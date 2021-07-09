Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB953C1E46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 06:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhGIEbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 00:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIEbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3C1861448;
        Fri,  9 Jul 2021 04:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625804907;
        bh=VRmIO81Cs3egvMfWaudHwtfzRZvPahIOOhURKHxklZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLgVYAqcv96xPaiHWIljqXDFvrILaABEO4trm5+xw+BqGLN+nydFa+1rYuPc01vcA
         1j8SP4WsXn2kP8uG52qGixOCdPV4X+/bPLuVmSENOSAltbLZpNFtiB1HPZ67HyUWp+
         p27KoKcbbmoKCYl0t6kw9mUIiqJTi6rfzjaC0xInsL4ZQazA1RQy4NBSDbUZMyM06n
         AbVXPofg2a/Awh+aQmU5McMcflJ3fA/vbw3np4Yr7jDzeFwOPn/u1yamj04vrU11g4
         4zuN5+PKpzGFquaY29A4m7N0/i0GQm08lQnkeKhJKp9iZEUJA0bFafR9m/IBpNYIrB
         7T2pj4LUsn7CQ==
Date:   Thu, 8 Jul 2021 21:28:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <20210709042826.GU11588@locust>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707115524.2242151-3-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:55:23PM +0200, Andreas Gruenbacher wrote:
> In iomap_readpage_actor, don't create iop objects for inline inodes.
> Otherwise, iomap_read_inline_data will set PageUptodate without setting
> iop->uptodate, and iomap_page_release will eventually complain.
> 
> To prevent this kind of bug from occurring in the future, make sure the
> page doesn't have private data attached in iomap_read_inline_data.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 598fcfabc337..6330dabc451e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -215,6 +215,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  	if (PageUptodate(page))
>  		return;
>  
> +	BUG_ON(page_has_private(page));
>  	BUG_ON(page->index);
>  	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
> @@ -239,7 +240,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> -	struct iomap_page *iop = iomap_page_create(inode, page);
> +	struct iomap_page *iop;
>  	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
>  	unsigned poff, plen;
> @@ -252,6 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> +	iop = iomap_page_create(inode, page);
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
> -- 
> 2.26.3
> 
