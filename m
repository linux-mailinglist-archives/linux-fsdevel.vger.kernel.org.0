Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0970C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfGVW0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 18:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbfGVW0J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:26:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484D921985;
        Mon, 22 Jul 2019 22:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563834368;
        bh=SaCZr/lqE3KBkwJxJ3lN9pVqMFlNvyqSapA1Iar2Yz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ogi3k+rE6tk0IM0RMI1sxYzidV8NLfAQfkbaqZqpx47sIH3rytjrFbF0L2h9+viUc
         HXSYDvdHUkfN2kpbEa5fKWrQdie7drx8APmpPamwnuov0yvOqo0lk8hQ21R7nNODV1
         D/z8/0j2BEGTqS2l1Mi4j87EjG/KCZECdTJfkpyY=
Date:   Mon, 22 Jul 2019 15:26:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: annotate refault stalls from IO submission
Message-Id: <20190722152607.dd175a9d517a5f6af06a8bdc@linux-foundation.org>
In-Reply-To: <20190722201337.19180-1-hannes@cmpxchg.org>
References: <20190722201337.19180-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Jul 2019 16:13:37 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is
> spent in submit_bio(). In that case, we underreport memory pressure.

It's a somewhat broad patch.  How significant is this problem in the
real world?  Can we be confident that the end-user benefit is worth the
code changes?

> Annotate the submit_bio() paths (or the indirection through readpage)
> for refaults and swapin to get proper psi coverage of delays there.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/btrfs/extent_io.c | 14 ++++++++++++--
>  fs/ext4/readpage.c   |  9 +++++++++
>  fs/f2fs/data.c       |  8 ++++++++
>  fs/mpage.c           |  9 +++++++++
>  mm/filemap.c         | 20 ++++++++++++++++++++
>  mm/page_io.c         | 11 ++++++++---
>  mm/readahead.c       | 24 +++++++++++++++++++++++-

We touch three filesystems.  Why these three?  Are all other
filesystems OK or will they need work as well?

> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
>
> ...
>
> @@ -2753,11 +2763,14 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  				void *data,
>  				gfp_t gfp)
>  {
> +	bool refault = false;
>  	struct page *page;
>  	int err;
>  repeat:
>  	page = find_get_page(mapping, index);
>  	if (!page) {
> +		unsigned long pflags;
> +

That was a bit odd.  This?

--- a/mm/filemap.c~psi-annotate-refault-stalls-from-io-submission-fix
+++ a/mm/filemap.c
@@ -2815,12 +2815,12 @@ static struct page *do_read_cache_page(s
 				void *data,
 				gfp_t gfp)
 {
-	bool refault = false;
 	struct page *page;
 	int err;
 repeat:
 	page = find_get_page(mapping, index);
 	if (!page) {
+		bool refault = false;
 		unsigned long pflags;
 
 		page = __page_cache_alloc(gfp);
_

