Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4579640492A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhIILVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhIILUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:20:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F375C06175F;
        Thu,  9 Sep 2021 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eBdVhI0kcw3JwSK5QRLhLU755/zLdNcWhAWcUbZ5EOw=; b=rL5ragHCDt81/zHRNRaEYSaweU
        CSnmLghKvvYl4zCzMyryv/InNxXFGqJtCP+9EHkVwu7AfmGoU3jfX2eX0mVfzIVjzncHYfZVNKAuw
        wxzv6Y0SskesZd5TiP1+OBXIRyu0Wk4ByswZYLOg/rl6pyynpS0KVtJJAchPr4uqrMrhV2pR/Eirf
        qWP1sYj9LHbPSgdxeh+ZZM4h7HS3DMOyIoVessLMxaD0U8Gs2EByx5K+cdbOcqVEd5N1JCWTtMGoO
        KPMUO5IyUCczwPotsN3jbcQEBcRl6vCPtLAnwXtrkIiYEnJH8F1iquIh5K0DvILwbhlAJCY0VbGT9
        +gSxt8lg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOI46-009ktL-OB; Thu, 09 Sep 2021 11:18:02 +0000
Date:   Thu, 9 Sep 2021 12:17:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 14/19] iomap: Fix iomap_dio_rw return value for user
 copies
Message-ID: <YTntZj0T3pWhApoe@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-15-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-15-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:21PM +0200, Andreas Gruenbacher wrote:
> When a user copy fails in one of the helpers of iomap_dio_rw, fail with
> -EFAULT instead of returning 0.  This matches what iomap_dio_bio_actor
> returns when it gets an -EFAULT from bio_iov_iter_get_pages.  With these
> changes, iomap_dio_actor now consistently fails with -EFAULT when a user
> page cannot be faulted in.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..8054f5d6c273 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -370,7 +370,7 @@ iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
>  {
>  	length = iov_iter_zero(length, dio->submit.iter);
>  	dio->size += length;
> -	return length;
> +	return length ? length : -EFAULT;

What's wrong with a good old:

	if (!length)
		return -EFAULT;
	return length?

Besides this nit and the fact that the patch needs a reabse it looks
good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
