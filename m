Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7522725ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjFGMUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjFGMTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:19:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E7E65;
        Wed,  7 Jun 2023 05:19:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0679A1FDAC;
        Wed,  7 Jun 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686140377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIcAmuwwomlFKuWyJzT2ZczfUfDqBv+dd3ElI46NTH0=;
        b=nwl1WimOwPcjF98AEDnJ2K0z5H5r6S9PZV0NMxPrxeO+b6iUxsJL+D1fFXUbalAwuKeyE3
        zDs72n/QwOPnZMi8nk3pSIarBQVHhZeQACSX9v+viDkwrv0NDl02wL5QLAw6mpY+lpJvKO
        GLq8dP5GTUTOdUeWCMUzXQ+Ee2PhJ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686140377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIcAmuwwomlFKuWyJzT2ZczfUfDqBv+dd3ElI46NTH0=;
        b=E1AF4AwgkO2HnPq1es8OnevAsUmnYalHeDtF1c1JN6GfSa26Y5PIvIwVLzXxB76McWsDjz
        R09PGSzfxNnSgdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7EEB13776;
        Wed,  7 Jun 2023 12:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LXmULNh1gGTYQAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:19:36 +0000
Message-ID: <9d7ae46b-f963-3412-cf5c-4d11c54eea58@suse.de>
Date:   Wed, 7 Jun 2023 14:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
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
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-10-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/23 09:39, Christoph Hellwig wrote:
> ->open is only called on the whole device.  Make that explicit by
> passing a gendisk instead of the block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c          |  5 ++---
>   arch/xtensa/platforms/iss/simdisk.c |  4 ++--
>   block/bdev.c                        |  2 +-
>   drivers/block/amiflop.c             |  8 ++++----
>   drivers/block/aoe/aoeblk.c          |  4 ++--
>   drivers/block/ataflop.c             | 16 +++++++--------
>   drivers/block/drbd/drbd_main.c      |  6 +++---
>   drivers/block/floppy.c              | 30 +++++++++++++++--------------
>   drivers/block/nbd.c                 |  8 ++++----
>   drivers/block/pktcdvd.c             |  6 +++---
>   drivers/block/rbd.c                 |  4 ++--
>   drivers/block/rnbd/rnbd-clt.c       |  4 ++--
>   drivers/block/swim.c                | 10 +++++-----
>   drivers/block/swim3.c               | 10 +++++-----
>   drivers/block/ublk_drv.c            |  4 ++--
>   drivers/block/z2ram.c               |  6 ++----
>   drivers/block/zram/zram_drv.c       | 13 +++++--------
>   drivers/cdrom/gdrom.c               |  4 ++--
>   drivers/md/bcache/super.c           |  4 ++--
>   drivers/md/dm.c                     |  4 ++--
>   drivers/md/md.c                     |  6 +++---
>   drivers/mmc/core/block.c            |  4 ++--
>   drivers/mtd/mtd_blkdevs.c           |  4 ++--
>   drivers/mtd/ubi/block.c             |  4 ++--
>   drivers/nvme/host/core.c            |  4 ++--
>   drivers/nvme/host/multipath.c       |  4 ++--
>   drivers/s390/block/dasd.c           |  4 ++--
>   drivers/s390/block/dcssblk.c        |  7 +++----
>   drivers/scsi/sd.c                   | 12 ++++++------
>   drivers/scsi/sr.c                   |  6 +++---
>   include/linux/blkdev.h              |  2 +-
>   31 files changed, 102 insertions(+), 107 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

