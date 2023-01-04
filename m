Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5035865DB70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjADRpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjADRpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:45:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB501A3A6;
        Wed,  4 Jan 2023 09:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35282B8188A;
        Wed,  4 Jan 2023 17:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3971C433EF;
        Wed,  4 Jan 2023 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854339;
        bh=msm056/mOkbTA2byAEpjpULI3Z90pz6ivRTm/Jcj4Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mM9Tm7YMhSSJCWjq0WCtHKE0mrkpquzhLEMa8T8RYQmCVrErm/HRtFFhxUKl1hCEJ
         T6QRipu75ojlx7pi1Y6R/vsS0O3bo9dlrweLMVmPoxbW7ZxFicUG3mZ/p5tOwqSzUh
         LJDMMElHN+d9atSWubOP4jzPAxurd/SEpf2jS8b4VDXGXv6BT3D88WSVLF7G5r07Yv
         03D2E9ky/d6mB3eTOMvtdg7ciqyixTMtIxEsE+cPECVshsVhKxxVujblEbGwU9yITS
         3e/4zAZDDdv8FeIfRtu0hOriHFh/zeqjzLg/jW/g3l6v9h6GNw2i6G0CentdeNWPoU
         GBMqbBbrqmZMA==
Date:   Wed, 4 Jan 2023 09:45:38 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 5/9] iomap/gfs2: Get page in page_prepare handler
Message-ID: <Y7W7QlE5rQxpodPw@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-6-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:15PM +0100, Andreas Gruenbacher wrote:
> Change the iomap ->page_prepare() handler to get and return a locked
> folio instead of doing that in iomap_write_begin().  This allows to
> recover from out-of-memory situations in ->page_prepare(), which
> eliminates the corresponding error handling code in iomap_write_begin().
> The ->put_folio() handler now also isn't called with NULL as the folio
> value anymore.
> 
> Filesystems are expected to use the iomap_get_folio() helper for getting
> locked folios in their ->page_prepare() handlers.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

This patchset makes the page ops make a lot more sense to me now.  I
very much like the way that the new ->get_folio ->put_folio functions
split the responsibilities for setting up the page cach write and
tearing it down.  Thank you for cleaning this up. :)

(I would still like hch or willy to take a second look at this, however.)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/gfs2/bmap.c         | 21 +++++++++++++--------
>  fs/iomap/buffered-io.c | 17 ++++++-----------
>  include/linux/iomap.h  |  9 +++++----
>  3 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 0c041459677b..41349e09558b 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -956,15 +956,25 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
>  	goto out;
>  }
>  
> -static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
> -				   unsigned len)
> +static struct folio *
> +gfs2_iomap_page_prepare(struct iomap_iter *iter, loff_t pos, unsigned len)
>  {
> +	struct inode *inode = iter->inode;
>  	unsigned int blockmask = i_blocksize(inode) - 1;
>  	struct gfs2_sbd *sdp = GFS2_SB(inode);
>  	unsigned int blocks;
> +	struct folio *folio;
> +	int status;
>  
>  	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
> -	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
> +	status = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
> +	if (status)
> +		return ERR_PTR(status);
> +
> +	folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio))
> +		gfs2_trans_end(sdp);
> +	return folio;
>  }
>  
>  static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
> @@ -974,11 +984,6 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_sbd *sdp = GFS2_SB(inode);
>  
> -	if (!folio) {
> -		gfs2_trans_end(sdp);
> -		return;
> -	}
> -
>  	if (!gfs2_is_stuffed(ip))
>  		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
>  				       copied);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b84838d2b5d8..7decd8cdc755 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -609,7 +609,7 @@ static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
>  
>  	if (page_ops && page_ops->put_folio) {
>  		page_ops->put_folio(iter->inode, pos, ret, folio);
> -	} else if (folio) {
> +	} else {
>  		folio_unlock(folio);
>  		folio_put(folio);
>  	}
> @@ -642,17 +642,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	if (page_ops && page_ops->page_prepare) {
> -		status = page_ops->page_prepare(iter->inode, pos, len);
> -		if (status)
> -			return status;
> -	}
> -
> -	folio = iomap_get_folio(iter, pos);
> -	if (IS_ERR(folio)) {
> -		iomap_put_folio(iter, pos, 0, NULL);
> +	if (page_ops && page_ops->page_prepare)
> +		folio = page_ops->page_prepare(iter, pos, len);
> +	else
> +		folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> -	}
>  
>  	/*
>  	 * Now we have a locked folio, before we do anything with it we need to
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e5732cc5716b..87b5d0f8e578 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -13,6 +13,7 @@
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> +struct iomap_iter;
>  struct iomap_dio;
>  struct iomap_writepage_ctx;
>  struct iov_iter;
> @@ -131,12 +132,12 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>   * associated with them.
>   *
>   * When page_prepare succeeds, put_folio will always be called to do any
> - * cleanup work necessary.  In that put_folio call, @folio will be NULL if the
> - * associated folio could not be obtained.  When folio is not NULL, put_folio
> - * is responsible for unlocking and putting the folio.
> + * cleanup work necessary.  put_folio is responsible for unlocking and putting
> + * @folio.
>   */
>  struct iomap_page_ops {
> -	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
> +	struct folio *(*page_prepare)(struct iomap_iter *iter, loff_t pos,
> +			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct folio *folio);
>  
> -- 
> 2.38.1
> 
