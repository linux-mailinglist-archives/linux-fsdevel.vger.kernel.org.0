Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107D65B266
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 13:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjABMwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbjABMvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:51:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CAB64DE
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jan 2023 04:51:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A372340D4;
        Mon,  2 Jan 2023 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672663889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHCyqg7HOd27XtOCIdL4L4m7fbRm45BpGOGa6lv7Q+s=;
        b=VwgVegVS4VvArHPr1nU4HdTcOHFFNKFaESUSCWpuOPSdk7nP+zdFmEOyFa1jQKeWsxaG30
        CWd+Vuc6CsPNePiEPtWevm4Hjbt2OEZ874oQP4ZMXLwFlVZelV7ClpyWUeNyCO24efDs3+
        FNCzGtmCgMc1vZJmyFdgSA7oPObdr6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672663889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHCyqg7HOd27XtOCIdL4L4m7fbRm45BpGOGa6lv7Q+s=;
        b=Ox85EEpvkNlWESdz8ppMZPxRNkns3DIFbyuPQ1wPT2YfNok5YcV/7dXpHLrfDZwZM1Dwdz
        KTfxvJLpDkJxxvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70A4A13427;
        Mon,  2 Jan 2023 12:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYyAG1HTsmNuHAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:51:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 963EBA073E; Mon,  2 Jan 2023 13:51:28 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:51:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] udf: Handle error when adding extent to a file
Message-ID: <20230102125128.ilpxetxna3fqlhez@quack3>
References: <20221222101300.12679-1-jack@suse.cz>
 <20221222101612.18814-3-jack@suse.cz>
 <Y6ki+weNcHuyH7i1@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6ki+weNcHuyH7i1@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 25-12-22 21:28:43, Nathan Chancellor wrote:
> On Thu, Dec 22, 2022 at 11:16:00AM +0100, Jan Kara wrote:
> > When adding extent to a file fails, so far we've silently squelshed the
> > error. Make sure to propagate it up properly.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/udf/inode.c | 41 +++++++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> > index 09417342d8b6..15b3e529854b 100644
> > --- a/fs/udf/inode.c
> > +++ b/fs/udf/inode.c
> > @@ -57,15 +57,15 @@ static int udf_update_inode(struct inode *, int);
> >  static int udf_sync_inode(struct inode *inode);
> >  static int udf_alloc_i_data(struct inode *inode, size_t size);
> >  static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
> > -static int8_t udf_insert_aext(struct inode *, struct extent_position,
> > -			      struct kernel_lb_addr, uint32_t);
> > +static int udf_insert_aext(struct inode *, struct extent_position,
> > +			   struct kernel_lb_addr, uint32_t);
> >  static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
> >  			      struct kernel_long_ad *, int *);
> >  static void udf_prealloc_extents(struct inode *, int, int,
> >  				 struct kernel_long_ad *, int *);
> >  static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
> > -static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
> > -			       int, struct extent_position *);
> > +static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
> > +			      int, struct extent_position *);
> >  static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
> >  
> >  static void __udf_clear_extent_cache(struct inode *inode)
> > @@ -795,7 +795,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
> >  	/* write back the new extents, inserting new extents if the new number
> >  	 * of extents is greater than the old number, and deleting extents if
> >  	 * the new number of extents is less than the old number */
> > -	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
> > +	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
> > +	if (*err < 0)
> > +		goto out_free;
> 
> This patch in next-20221226 as commit d8b39db5fab8 ("udf: Handle error when
> adding extent to a file") causes the following clang warning:
> 
>   fs/udf/inode.c:805:6: error: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>           if (*err < 0)
>               ^~~~~~~~
>   fs/udf/inode.c:827:9: note: uninitialized use occurs here
>           return newblock;
>                  ^~~~~~~~
>   fs/udf/inode.c:805:2: note: remove the 'if' if its condition is always false
>           if (*err < 0)
>           ^~~~~~~~~~~~~
>   fs/udf/inode.c:607:34: note: initialize the variable 'newblock' to silence this warning
>           udf_pblk_t newblocknum, newblock;
>                                           ^
>                                            = 0
>   1 error generated.

Thanks for the report. It should be fixed now.

								Honza


> 
> >  	newblock = udf_get_pblock(inode->i_sb, newblocknum,
> >  				iinfo->i_location.partitionReferenceNum, 0);
> > @@ -1063,21 +1065,30 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
> >  	}
> >  }
> >  
> > -static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
> > -			       int startnum, int endnum,
> > -			       struct extent_position *epos)
> > +static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
> > +			      int startnum, int endnum,
> > +			      struct extent_position *epos)
> >  {
> >  	int start = 0, i;
> >  	struct kernel_lb_addr tmploc;
> >  	uint32_t tmplen;
> > +	int err;
> >  
> >  	if (startnum > endnum) {
> >  		for (i = 0; i < (startnum - endnum); i++)
> >  			udf_delete_aext(inode, *epos);
> >  	} else if (startnum < endnum) {
> >  		for (i = 0; i < (endnum - startnum); i++) {
> > -			udf_insert_aext(inode, *epos, laarr[i].extLocation,
> > -					laarr[i].extLength);
> > +			err = udf_insert_aext(inode, *epos,
> > +					      laarr[i].extLocation,
> > +					      laarr[i].extLength);
> > +			/*
> > +			 * If we fail here, we are likely corrupting the extent
> > + 			 * list and leaking blocks. At least stop early to
> > +			 * limit the damage.
> > +			 */
> > +			if (err < 0)
> > +				return err;
> >  			udf_next_aext(inode, epos, &laarr[i].extLocation,
> >  				      &laarr[i].extLength, 1);
> >  			start++;
> > @@ -1089,6 +1100,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
> >  		udf_write_aext(inode, epos, &laarr[i].extLocation,
> >  			       laarr[i].extLength, 1);
> >  	}
> > +	return 0;
> >  }
> >  
> >  struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
> > @@ -2107,12 +2119,13 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
> >  	return etype;
> >  }
> >  
> > -static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
> > -			      struct kernel_lb_addr neloc, uint32_t nelen)
> > +static int udf_insert_aext(struct inode *inode, struct extent_position epos,
> > +			   struct kernel_lb_addr neloc, uint32_t nelen)
> >  {
> >  	struct kernel_lb_addr oeloc;
> >  	uint32_t oelen;
> >  	int8_t etype;
> > +	int err;
> >  
> >  	if (epos.bh)
> >  		get_bh(epos.bh);
> > @@ -2122,10 +2135,10 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
> >  		neloc = oeloc;
> >  		nelen = (etype << 30) | oelen;
> >  	}
> > -	udf_add_aext(inode, &epos, &neloc, nelen, 1);
> > +	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
> >  	brelse(epos.bh);
> >  
> > -	return (nelen >> 30);
> > +	return err;
> >  }
> >  
> >  int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
> > -- 
> > 2.35.3
> > 
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
