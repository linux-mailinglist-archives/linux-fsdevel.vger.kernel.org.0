Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E742967AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 01:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373411AbgJVXfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 19:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373405AbgJVXfG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:35:06 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531C524248;
        Thu, 22 Oct 2020 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603409705;
        bh=sPm+q9fL8gFjupV6uEfDDpHTQP+mJ5kniWIFwA6zfWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku6TK6trtHAgrUobR95TwiHb69JYzJnkA5nbc9BAiXM06jXDQ9cvpzcgzEAEfIij8
         XN4/Y1z3fWdfFkfNUQZZ0i6rQ/T1+hJ41zCGZmM+tPU2flYqvXkJzZqj9gNywVh7fY
         Lf+GsnQAT3YePsQ3r/G00oWd5UDL51Sj/KLLww8o=
Date:   Thu, 22 Oct 2020 16:35:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: Convert block_read_full_page to be synchronous
Message-ID: <20201022233503.GC3613750@gmail.com>
References: <20201022212228.15703-1-willy@infradead.org>
 <20201022212228.15703-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022212228.15703-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:22:25PM +0100, Matthew Wilcox (Oracle) wrote:
> Use the new blk_completion infrastructure to wait for multiple I/Os.
> Also coalesce adjacent buffer heads into a single BIO instead of
> submitting one BIO per buffer head.  This doesn't work for fscrypt yet,
> so keep the old code around for now.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1b0ba1d59966..ccb90081117c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2249,6 +2249,87 @@ int block_is_partially_uptodate(struct page *page, unsigned long from,
>  }
>  EXPORT_SYMBOL(block_is_partially_uptodate);
>  
> +static void readpage_end_bio(struct bio *bio)
> +{
> +	struct bio_vec *bvec;
> +	struct page *page;
> +	struct buffer_head *bh;
> +	int i, nr = 0;
> +
> +	bio_for_each_bvec_all(bvec, bio, i) {

Shouldn't this technically be bio_for_each_segment_all()?  This wants to iterate
over the pages, not the bvecs -- and in general, each bvec might contain
multiple pages.

Now, in this case, each bio has only 1 page and 1 bvec, so it doesn't really
matter.  But if we're going to use an iterator, it seems we should use the right
kind.

Likewise in decrypt_bio() in patch 6.

- Eric
