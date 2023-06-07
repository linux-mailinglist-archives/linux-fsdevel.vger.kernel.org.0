Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04C7261EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbjFGOAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFGOAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:00:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6C1FE2;
        Wed,  7 Jun 2023 07:00:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD1A1FDAA;
        Wed,  7 Jun 2023 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686146410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UrhG/vp+m03DiK3yFBmnkaqHBlBTfdkmOZNwI5+daeI=;
        b=aaeNmU5ZCbhkqsc+e7TmqELd+MojX+TJ4sW47FDZ16ksOKTS1HV5xIbX0zomficAn/Jh5v
        VZiRj0mibB+S0/nZ9oVGZBw1IUP0IX/+ZnPW1SQuG9FRCZsxkZPR09gqoOTRnF+vHJM2YE
        Ooe+gJXDWNv9E7scSycsuGNec+mAcBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686146410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UrhG/vp+m03DiK3yFBmnkaqHBlBTfdkmOZNwI5+daeI=;
        b=KHxasVxySgF+IfYKHAeDp2hM9up/Wuoe5ajJJXZVSidBzHNz58lOdiZ2OyRWPEh/mFqMqo
        GNlPBbs8U0FDH+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D167113776;
        Wed,  7 Jun 2023 14:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oAxvMmmNgGS7ewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Jun 2023 14:00:09 +0000
Date:   Wed, 7 Jun 2023 15:53:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/31] block: use the holder as indication for exclusive
 opens
Message-ID: <20230607135354.GP25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-17-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:35AM +0200, Christoph Hellwig wrote:
> The current interface for exclusive opens is rather confusing as it
> requires both the FMODE_EXCL flag and a holder.  Remove the need to pass
> FMODE_EXCL and just key off the exclusive open off a non-NULL holder.
> 
> For blkdev_put this requires adding the holder argument, which provides
> better debug checking that only the holder actually releases the hold,
> but at the same time allows removing the now superfluous mode argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bdev.c                        | 37 ++++++++++++++++------------
>  block/fops.c                        |  6 +++--
>  block/genhd.c                       |  5 ++--
>  block/ioctl.c                       |  5 ++--
>  drivers/block/drbd/drbd_nl.c        | 23 ++++++++++-------
>  drivers/block/pktcdvd.c             | 13 +++++-----
>  drivers/block/rnbd/rnbd-srv.c       |  4 +--
>  drivers/block/xen-blkback/xenbus.c  |  2 +-
>  drivers/block/zram/zram_drv.c       |  8 +++---
>  drivers/md/bcache/super.c           | 15 ++++++------
>  drivers/md/dm.c                     |  6 ++---
>  drivers/md/md.c                     | 38 +++++++++++++++--------------
>  drivers/mtd/devices/block2mtd.c     |  4 +--
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/s390/block/dasd_genhd.c     |  2 +-
>  drivers/target/target_core_iblock.c |  6 ++---
>  drivers/target/target_core_pscsi.c  |  8 +++---

For

>  fs/btrfs/dev-replace.c              |  6 ++---
>  fs/btrfs/ioctl.c                    | 12 ++++-----
>  fs/btrfs/volumes.c                  | 28 ++++++++++-----------
>  fs/btrfs/volumes.h                  |  6 ++---

Acked-by: David Sterba <dsterba@suse.com>
