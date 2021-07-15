Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E783CAE30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhGOVCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGOVCM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DCC5613DB;
        Thu, 15 Jul 2021 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626382758;
        bh=0EucBWjY29MULPwrccvkBApnBg2v72BlT6IHmjKghlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joTNieRPj8cS/TGFOPAPhkb0rc9ZVr8napBQt9m85+2DQVUkowqVmvDOze7153qj1
         HwrO7MKTkSZYRtu0Fh8IcYTzQTlu8KHQ+da6BxpBW42CojKDcIF8bIXo9BYmlYYDJU
         AdILwiATZR4GYeTsCuEjyn7slVojO/WznHrA/HAxvEeDfdwodC0ywidsZP93BlE/pz
         owf/ZdXd4Y+8dQglmE/CefBkqmy/SBsrTBWaVcMwzwzbL3qsSklLSfdNeaY/T0Xn8f
         lsiiImBzEYzHe+E/wGlkAlm6oO5Ui2DT0iBCvJLS3BgHZWiQMSSWYIsCOnXr+w6CJX
         aoDJRiBBG53Vg==
Date:   Thu, 15 Jul 2021 13:59:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 090/138] block: Add bio_add_folio()
Message-ID: <20210715205917.GC22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-91-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-91-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:16AM +0100, Matthew Wilcox (Oracle) wrote:
> This is a thin wrapper around bio_add_page().  The main advantage here
> is the documentation that the submitter can expect to see folios in the
> completion handler, and that stupidly large folios are not supported.
> It's not currently possible to allocate stupidly large folios, but if
> it ever becomes possible, this function will fail gracefully instead of
> doing I/O to the wrong bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c         | 21 +++++++++++++++++++++
>  include/linux/bio.h |  3 ++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..1b500611d25c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -933,6 +933,27 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: Bio to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Always uses the head page of the folio in the bio.  If a submitter
> + * only uses bio_add_folio(), it can count on never seeing tail pages
> + * in the completion routine.  BIOs do not support folios larger than 2GiB.
> + *
> + * Return: The number of bytes from this folio added to the bio.
> + */
> +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)

Er... if bios don't support folios larger than 2GB, then why check @off
and @len against UINT_MAX, which is ~4GB?

--D

> +		return 0;
> +	return bio_add_page(bio, &folio->page, len, off);
> +}
> +
>  void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct bvec_iter_all iter_all;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 2203b686e1f0..ade93e2de6a1 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -462,7 +462,8 @@ extern void bio_uninit(struct bio *);
>  extern void bio_reset(struct bio *);
>  void bio_chain(struct bio *, struct bio *);
>  
> -extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> +int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
> +size_t bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
>  extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
>  			   unsigned int, unsigned int);
>  int bio_add_zone_append_page(struct bio *bio, struct page *page,
> -- 
> 2.30.2
> 
