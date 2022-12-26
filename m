Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D13655FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 05:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLZE2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Dec 2022 23:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZE2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Dec 2022 23:28:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55CEA1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Dec 2022 20:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CC760D3D
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Dec 2022 04:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8375C433D2;
        Mon, 26 Dec 2022 04:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672028924;
        bh=KswpCOT3Vxs79xbA2FLndDBwU9JwJZi6BKa9BqXajH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjGKmupJFjBaz3IahmbsiWM+salr9KwaGb8e9pE++k1zVPr6aJNw6plUrG1r/qmZJ
         iUbqZ+1v0+DEhyvDnIcilULlUnlOxKX101Zm0z0xCFc5o2XzhbUL/vVmJ8W4/fwBLz
         T9rAtBl7dyVnq+X/3us56qepqo0MXXkSeYGAsuuDfYCe8cB2gd34fa0mKk979sqcUP
         1Le1JnUfSut6IYkQfGVRsn6DTmPOROD6o/5lChHApE+ik3VYrgTudEy9H+SS6BUKQF
         zBBrVjgbX/JaoXimjyQBq7axRscc5pdCrQ38HRTpAd7QKaJeHN+bFbQPqO+jXBqGQ/
         7Nq1jKhe2bA4A==
Date:   Sun, 25 Dec 2022 21:28:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] udf: Handle error when adding extent to a file
Message-ID: <Y6ki+weNcHuyH7i1@dev-arch.thelio-3990X>
References: <20221222101300.12679-1-jack@suse.cz>
 <20221222101612.18814-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222101612.18814-3-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:16:00AM +0100, Jan Kara wrote:
> When adding extent to a file fails, so far we've silently squelshed the
> error. Make sure to propagate it up properly.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/udf/inode.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 09417342d8b6..15b3e529854b 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -57,15 +57,15 @@ static int udf_update_inode(struct inode *, int);
>  static int udf_sync_inode(struct inode *inode);
>  static int udf_alloc_i_data(struct inode *inode, size_t size);
>  static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
> -static int8_t udf_insert_aext(struct inode *, struct extent_position,
> -			      struct kernel_lb_addr, uint32_t);
> +static int udf_insert_aext(struct inode *, struct extent_position,
> +			   struct kernel_lb_addr, uint32_t);
>  static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
>  			      struct kernel_long_ad *, int *);
>  static void udf_prealloc_extents(struct inode *, int, int,
>  				 struct kernel_long_ad *, int *);
>  static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
> -static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
> -			       int, struct extent_position *);
> +static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
> +			      int, struct extent_position *);
>  static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
>  
>  static void __udf_clear_extent_cache(struct inode *inode)
> @@ -795,7 +795,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
>  	/* write back the new extents, inserting new extents if the new number
>  	 * of extents is greater than the old number, and deleting extents if
>  	 * the new number of extents is less than the old number */
> -	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
> +	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
> +	if (*err < 0)
> +		goto out_free;

This patch in next-20221226 as commit d8b39db5fab8 ("udf: Handle error when
adding extent to a file") causes the following clang warning:

  fs/udf/inode.c:805:6: error: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
          if (*err < 0)
              ^~~~~~~~
  fs/udf/inode.c:827:9: note: uninitialized use occurs here
          return newblock;
                 ^~~~~~~~
  fs/udf/inode.c:805:2: note: remove the 'if' if its condition is always false
          if (*err < 0)
          ^~~~~~~~~~~~~
  fs/udf/inode.c:607:34: note: initialize the variable 'newblock' to silence this warning
          udf_pblk_t newblocknum, newblock;
                                          ^
                                           = 0
  1 error generated.

>  	newblock = udf_get_pblock(inode->i_sb, newblocknum,
>  				iinfo->i_location.partitionReferenceNum, 0);
> @@ -1063,21 +1065,30 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
>  	}
>  }
>  
> -static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
> -			       int startnum, int endnum,
> -			       struct extent_position *epos)
> +static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
> +			      int startnum, int endnum,
> +			      struct extent_position *epos)
>  {
>  	int start = 0, i;
>  	struct kernel_lb_addr tmploc;
>  	uint32_t tmplen;
> +	int err;
>  
>  	if (startnum > endnum) {
>  		for (i = 0; i < (startnum - endnum); i++)
>  			udf_delete_aext(inode, *epos);
>  	} else if (startnum < endnum) {
>  		for (i = 0; i < (endnum - startnum); i++) {
> -			udf_insert_aext(inode, *epos, laarr[i].extLocation,
> -					laarr[i].extLength);
> +			err = udf_insert_aext(inode, *epos,
> +					      laarr[i].extLocation,
> +					      laarr[i].extLength);
> +			/*
> +			 * If we fail here, we are likely corrupting the extent
> + 			 * list and leaking blocks. At least stop early to
> +			 * limit the damage.
> +			 */
> +			if (err < 0)
> +				return err;
>  			udf_next_aext(inode, epos, &laarr[i].extLocation,
>  				      &laarr[i].extLength, 1);
>  			start++;
> @@ -1089,6 +1100,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
>  		udf_write_aext(inode, epos, &laarr[i].extLocation,
>  			       laarr[i].extLength, 1);
>  	}
> +	return 0;
>  }
>  
>  struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
> @@ -2107,12 +2119,13 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
>  	return etype;
>  }
>  
> -static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
> -			      struct kernel_lb_addr neloc, uint32_t nelen)
> +static int udf_insert_aext(struct inode *inode, struct extent_position epos,
> +			   struct kernel_lb_addr neloc, uint32_t nelen)
>  {
>  	struct kernel_lb_addr oeloc;
>  	uint32_t oelen;
>  	int8_t etype;
> +	int err;
>  
>  	if (epos.bh)
>  		get_bh(epos.bh);
> @@ -2122,10 +2135,10 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
>  		neloc = oeloc;
>  		nelen = (etype << 30) | oelen;
>  	}
> -	udf_add_aext(inode, &epos, &neloc, nelen, 1);
> +	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
>  	brelse(epos.bh);
>  
> -	return (nelen >> 30);
> +	return err;
>  }
>  
>  int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
> -- 
> 2.35.3
> 
> 
