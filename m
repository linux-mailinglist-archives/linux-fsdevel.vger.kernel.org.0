Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AF725EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjFGMVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbjFGMVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:21:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E371FC0;
        Wed,  7 Jun 2023 05:20:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBB84219E0;
        Wed,  7 Jun 2023 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686140450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1Rl1qGqvM4Z5x8Xq+CyMv3eUpGokjis8a1uEGHT2oM=;
        b=NtfJezGisqgVMGMlpHu5h7lKBliQJSnIU40FJjYFHclq1pJ2yccwB2gCrQVYr/XEAgBe//
        SwWqpD3W1ozsd6dyaotuzbIDg6Oacufyt0jV/rrLR+MxmjDwaQJv56xVitpaNX1eUWndRD
        n4xYwVUPyj+t5hxm3UfoFljrLDNuTx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686140450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1Rl1qGqvM4Z5x8Xq+CyMv3eUpGokjis8a1uEGHT2oM=;
        b=zQ5xWW4Z2foG7bGxNOdFosbyzeVEHPlunA2KDXAT7USZKkViaz3OAfkcgfavN420ThY0SP
        Jl33OjNpQS/R7bCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7586A13776;
        Wed,  7 Jun 2023 12:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DOJsHCJ2gGSBQQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:20:50 +0000
Message-ID: <bb59f7f1-0d12-ed28-9754-7027959ada0b@suse.de>
Date:   Wed, 7 Jun 2023 14:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/31] block: remove the unused mode argument to ->release
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
 <20230606073950.225178-11-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-11-hch@lst.de>
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
> The mode argument to the ->release block_device_operation is never used,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c          |  4 ++--
>   arch/xtensa/platforms/iss/simdisk.c |  2 +-
>   block/bdev.c                        | 14 +++++++-------
>   drivers/block/amiflop.c             |  2 +-
>   drivers/block/aoe/aoeblk.c          |  2 +-
>   drivers/block/ataflop.c             |  4 ++--
>   drivers/block/drbd/drbd_main.c      |  4 ++--
>   drivers/block/floppy.c              |  2 +-
>   drivers/block/loop.c                |  2 +-
>   drivers/block/nbd.c                 |  2 +-
>   drivers/block/pktcdvd.c             |  4 ++--
>   drivers/block/rbd.c                 |  2 +-
>   drivers/block/rnbd/rnbd-clt.c       |  2 +-
>   drivers/block/swim.c                |  2 +-
>   drivers/block/swim3.c               |  3 +--
>   drivers/block/z2ram.c               |  2 +-
>   drivers/cdrom/gdrom.c               |  2 +-
>   drivers/md/bcache/super.c           |  2 +-
>   drivers/md/dm.c                     |  2 +-
>   drivers/md/md.c                     |  2 +-
>   drivers/mmc/core/block.c            |  2 +-
>   drivers/mtd/mtd_blkdevs.c           |  2 +-
>   drivers/mtd/ubi/block.c             |  2 +-
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/multipath.c       |  2 +-
>   drivers/s390/block/dasd.c           |  2 +-
>   drivers/s390/block/dcssblk.c        |  4 ++--
>   drivers/scsi/sd.c                   |  3 +--
>   drivers/scsi/sr.c                   |  2 +-
>   include/linux/blkdev.h              |  2 +-
>   30 files changed, 41 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

