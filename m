Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E22178B56C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjH1QgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjH1Qfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:35:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC212F;
        Mon, 28 Aug 2023 09:35:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6EEA1FD65;
        Mon, 28 Aug 2023 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693240535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ck2GGOGhROLqsyobrCo5kdF6UPRkrbdxAmY4z9IUuok=;
        b=EtZzfSgJjiUXpAjtdYKvjMgJ0OZ4Q3hodxxDiiqMsvgYkWHBqZPn8b6HaeiQAJEHW5Uuko
        06HJR2ONdPdonWFc4Fxv/j1G2uH9dZxPNi9bmg/g7/MdjPYaFrmy0koVHOGYl0yF9ECUFU
        dvX53BpZP+akCxXPwoDv8WIm+8J4QE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693240535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ck2GGOGhROLqsyobrCo5kdF6UPRkrbdxAmY4z9IUuok=;
        b=gCDBzKEA8PtUwSuSbwhvUT0MqIp/q0xNdnkg7D4y2kSiwFqCax1L5bOi3yUguxVHz9AwG5
        nCbyIQ5cQ+9obfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8255139CC;
        Mon, 28 Aug 2023 16:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wwPfMNfM7GQmJQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 16:35:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3050AA0774; Mon, 28 Aug 2023 18:35:35 +0200 (CEST)
Date:   Mon, 28 Aug 2023 18:35:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <chao@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
Message-ID: <20230828163535.s7gnbmgzmsrqdpkt@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-23-jack@suse.cz>
 <1388dd5e-8d66-6f88-25d1-f563d7c366d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1388dd5e-8d66-6f88-25d1-f563d7c366d6@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-08-23 20:57:53, Chao Yu wrote:
> On 2023/8/23 18:48, Jan Kara wrote:
> > Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.
> 
> Hi Jan,
> 
> Seems it will confilct w/ below commit, could you please take a look?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=51bf8d3c81992ae57beeaf22df78ed7c2782af9d

Yes, it will conflict. But I don't plan to rush these patches into the
currently running merge window so I can just rebase after the f2fs patch
gets upstream. Thanks for the heads up.

								Honza

> > CC: Jaegeuk Kim <jaegeuk@kernel.org>
> > CC: Chao Yu <chao@kernel.org>
> > CC: linux-f2fs-devel@lists.sourceforge.net
> > Acked-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   fs/f2fs/f2fs.h  |  1 +
> >   fs/f2fs/super.c | 17 +++++++++--------
> >   2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e18272ae3119..2ec6c10df636 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1234,6 +1234,7 @@ struct f2fs_bio_info {
> >   #define FDEV(i)				(sbi->devs[i])
> >   #define RDEV(i)				(raw_super->devs[i])
> >   struct f2fs_dev_info {
> > +	struct bdev_handle *bdev_handle;
> >   	struct block_device *bdev;
> >   	char path[MAX_PATH_LEN];
> >   	unsigned int total_segments;
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index aa1f9a3a8037..885dcbd81859 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1561,7 +1561,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
> >   	int i;
> >   	for (i = 0; i < sbi->s_ndevs; i++) {
> > -		blkdev_put(FDEV(i).bdev, sbi->sb);
> > +		bdev_release(FDEV(i).bdev_handle);
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >   		kvfree(FDEV(i).blkz_seq);
> >   #endif
> > @@ -4196,9 +4196,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
> >   		if (max_devices == 1) {
> >   			/* Single zoned block device mount */
> > -			FDEV(0).bdev =
> > -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> > -						  sbi->sb, NULL);
> > +			FDEV(0).bdev_handle = bdev_open_by_dev(
> > +					sbi->sb->s_bdev->bd_dev, mode, sbi->sb,
> > +					NULL);
> >   		} else {
> >   			/* Multi-device mount */
> >   			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
> > @@ -4216,12 +4216,13 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
> >   					(FDEV(i).total_segments <<
> >   					sbi->log_blocks_per_seg) - 1;
> >   			}
> > -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> > -							  sbi->sb, NULL);
> > +			FDEV(i).bdev_handle = bdev_open_by_path(FDEV(i).path,
> > +					mode, sbi->sb, NULL);
> >   		}
> > -		if (IS_ERR(FDEV(i).bdev))
> > -			return PTR_ERR(FDEV(i).bdev);
> > +		if (IS_ERR(FDEV(i).bdev_handle))
> > +			return PTR_ERR(FDEV(i).bdev_handle);
> > +		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
> >   		/* to release errored devices */
> >   		sbi->s_ndevs = i + 1;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
