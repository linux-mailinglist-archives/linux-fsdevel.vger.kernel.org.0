Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3D65DB55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjADRho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjADRhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:37:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002539FB9;
        Wed,  4 Jan 2023 09:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 272F1CE1870;
        Wed,  4 Jan 2023 17:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFBEC433EF;
        Wed,  4 Jan 2023 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672853829;
        bh=vp+DMrtggOEZmBfs4AiT/cEptNthRadidDs/zv7+q5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFO2NXVLMI2SAJ0ZiGC8nci7O2/WMNc+cfBJztMKtQ38TX2A/iQCw3MLCdY/GGFJB
         ORFScJjb3h16kSU/DJOv5sPE6EO2hNJMSGGUjM7lFeO8llXxAc2i0Uq2ECy9tUlwjt
         Xf+/dZO/1C3VUxw1ZD1N0go16w2F00LpJgoDBsSp+Ncw+iawOGU4eNs5beLTH3/HUG
         9Cq9t5WkvX5eZ0dBhtWhGzGDSir/3uqH4OSTLwfq0SbL1zOyx8DwrjA5lkW5x2CEBX
         TJRKPwrEySabbeKgD33rXhp4uHmamBA6yzTrph3ttXmzl1w21fsNPgubVaPG2xG+aQ
         fzrVdTpHw/N8w==
Date:   Wed, 4 Jan 2023 09:37:08 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 3/9] iomap: Rename page_done handler to put_folio
Message-ID: <Y7W5RGsOgOThtlg3@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-4-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:13PM +0100, Andreas Gruenbacher wrote:
> The ->page_done() handler in struct iomap_page_ops is now somewhat
> misnamed in that it mainly deals with unlocking and putting a folio, so
> rename it to ->put_folio().
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/bmap.c         |  4 ++--
>  fs/iomap/buffered-io.c |  4 ++--
>  include/linux/iomap.h  | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 46206286ad42..0c041459677b 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -967,7 +967,7 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
>  	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
>  }
>  
> -static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> +static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
>  				 unsigned copied, struct folio *folio)
>  {
>  	struct gfs2_trans *tr = current->journal_info;
> @@ -994,7 +994,7 @@ static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
>  
>  static const struct iomap_page_ops gfs2_iomap_page_ops = {
>  	.page_prepare = gfs2_iomap_page_prepare,
> -	.page_done = gfs2_iomap_page_done,
> +	.put_folio = gfs2_iomap_put_folio,
>  };
>  
>  static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e13d5694e299..2a9bab4f3c79 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -580,8 +580,8 @@ static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  
> -	if (page_ops && page_ops->page_done) {
> -		page_ops->page_done(iter->inode, pos, ret, folio);
> +	if (page_ops && page_ops->put_folio) {
> +		page_ops->put_folio(iter->inode, pos, ret, folio);
>  	} else if (folio) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 743e2a909162..10ec36f373f4 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -126,18 +126,18 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> - * and page_done will be called for each page written to.  This only applies to
> + * and put_folio will be called for each page written to.  This only applies to

"...for each folio written to."

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>   * buffered writes as unbuffered writes will not typically have pages
>   * associated with them.
>   *
> - * When page_prepare succeeds, page_done will always be called to do any
> - * cleanup work necessary.  In that page_done call, @folio will be NULL if the
> - * associated folio could not be obtained.  When folio is not NULL, page_done
> + * When page_prepare succeeds, put_folio will always be called to do any
> + * cleanup work necessary.  In that put_folio call, @folio will be NULL if the
> + * associated folio could not be obtained.  When folio is not NULL, put_folio
>   * is responsible for unlocking and putting the folio.
>   */
>  struct iomap_page_ops {
>  	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
> -	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
> +	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct folio *folio);
>  
>  	/*
> -- 
> 2.38.1
> 
