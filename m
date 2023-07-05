Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C017481DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGEKRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGEKRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:17:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F06180;
        Wed,  5 Jul 2023 03:17:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D55131F889;
        Wed,  5 Jul 2023 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688552248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uA0slXzh1ecbnksiBGBA/IWTYXhmDVwsFY4LrhsCa84=;
        b=xRwiUXOgWWlZRp3IfLFyGAV1qHoGbTNWMEdzR6SIzKjn+P8bHa3EE/Fu00ncvnEQCdYUtG
        78CB6ffSBwCO/ShSfUHXWsIHCgxm2IUnB1glWEaRabh/GTkBhK4SQ3iw1tG7QrjOqso8fJ
        xgnd/+fxA0Mq3EMurPf7nI1+1CwM2Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688552248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uA0slXzh1ecbnksiBGBA/IWTYXhmDVwsFY4LrhsCa84=;
        b=zOCjXb0p+JU9KnRe43Wrd0s0B5a6BDQ2kaUUBXbWTgD4NKjQdL2xmV+eXtq3xD/T8akfSW
        kxAxszGTHXsmIlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C87BD13460;
        Wed,  5 Jul 2023 10:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TT7lMDhDpWQkCQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 10:17:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 59FD8A0707; Wed,  5 Jul 2023 12:17:28 +0200 (CEST)
Date:   Wed, 5 Jul 2023 12:17:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/32] block: Use blkdev_get_handle_by_dev() in
 blkdev_open()
Message-ID: <20230705101728.77szc5vpz4shrosl@quack3>
References: <20230629165206.383-1-jack@suse.cz>
 <CGME20230704122236epcas5p4f17ed438838d75c8229e4ab0ea009c37@epcas5p4.samsung.com>
 <20230704122224.16257-3-jack@suse.cz>
 <20230705050510.GA28287@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705050510.GA28287@green245>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 10:35:10, Kanchan Joshi wrote:
> On Tue, Jul 04, 2023 at 02:21:30PM +0200, Jan Kara wrote:
> > Convert blkdev_open() to use blkdev_get_handle_by_dev().
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > block/fops.c | 17 +++++++++--------
> > 1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/block/fops.c b/block/fops.c
> > index b6aa470c09ae..d7f3b6e67a2f 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -496,7 +496,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
> > 
> > static int blkdev_open(struct inode *inode, struct file *filp)
> > {
> > -	struct block_device *bdev;
> > +	struct bdev_handle *handle;
> > 	blk_mode_t mode;
> > 
> > 	/*
> > @@ -509,24 +509,25 @@ static int blkdev_open(struct inode *inode, struct file *filp)
> > 	filp->f_mode |= FMODE_BUF_RASYNC;
> > 
> > 	mode = file_to_blk_mode(filp);
> > -	bdev = blkdev_get_by_dev(inode->i_rdev, mode,
> > -				 mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
> > -	if (IS_ERR(bdev))
> > -		return PTR_ERR(bdev);
> > +	handle = blkdev_get_handle_by_dev(inode->i_rdev, mode,
> > +			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
> > +	if (IS_ERR(handle))
> > +		return PTR_ERR(handle);
> > 
> > 	if (mode & BLK_OPEN_EXCL)
> > 		filp->private_data = filp;
> 
> Is this needed?
> This is getting overwritten after a couple of lines below.
> 
> > -	if (bdev_nowait(bdev))
> > +	if (bdev_nowait(handle->bdev))
> > 		filp->f_mode |= FMODE_NOWAIT;
> > 
> > -	filp->f_mapping = bdev->bd_inode->i_mapping;
> > +	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
> > 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
> > +	filp->private_data = handle;
> 
> Here.

Good point, I'll fix that for the next version. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
