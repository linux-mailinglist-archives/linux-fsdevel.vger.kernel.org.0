Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578AB72C713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjFLOLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjFLOLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:11:51 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23510F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 07:11:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so36866439f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686579108; x=1689171108;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4muTChvfXbyFleywXuJztp663UoDJyd/b1njxzLhqy8=;
        b=sLZGHozVNiyKe7ZdVW/Izn1P7sgaQShCFq8nFxDEUw2HPGtUJB2+ZAyPMlipviAeTp
         k3uQ8FI/e0eQenGUZnHNrzUL6Ik3G0IXm+GRBayvvLbMzgaY+UXyhfCpD4GOrVPEdTJv
         IcIkIA09lG9xzyFYUO5JzJkmOBfAprST6Rp9IHrO/jxkuWSRx8pvHMOooqILGwgI/Lo6
         1VEW0UpTP7V9T32ew0hLYFEC4JqpDUjaCB9j68pNjawpUBhqZ7JS8ocpEabGbvX3LMxh
         84vjMA0Z3WUKqubPW8wvoXypai5o3n5GNzihnbK3f7nqUGYlTvpK/lKsx4hWnhA+HiQE
         ZgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579108; x=1689171108;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4muTChvfXbyFleywXuJztp663UoDJyd/b1njxzLhqy8=;
        b=PTN49OkuQ3Z2Bem87z52UZZpYCD6agqYnkWOAgPF2TY3vvrGtIlV45b98OY/1rsZO9
         I8ilTTM3s0UxeOwfhP861yEnXTNPqIt0SNW061p3wb4zC7peZIuu7x+Tx/l3izFMG4tA
         6uKe0ft1pWDiN5cyhMXLIlSJntoB7iqTWvjSrUyRF9dw9X1VvVXvA+2UH0XEOcfk43De
         CMW2rIanscDVZRVvK9oODii7UL9TKuNdI1XOIdIRV6vU/YNLeCbuy49VRPiVPv1Iliu6
         NVZ7vn2bwFyUC6USziQtzbYSevyuDmxeaC8K2FQMoMJcIQfv/yWOnCrXOWTn7r8XvqnN
         ezWg==
X-Gm-Message-State: AC+VfDxVD+dwwcpOhRQTNqeVV8EQi39x6Skd40Ao0j7p5qaulwkWkqyV
        AFl2bDxF0wbv/BTH6Vb3bdbD4Q==
X-Google-Smtp-Source: ACHHUZ7oss5Q4qEAESR1LIaLJkD7ZwONVfsRpFehVo9Ss1V9OTMOTrOh14yI7Krm7Ivy+/EbDcrm4g==
X-Received: by 2002:a6b:690a:0:b0:77a:ee79:652 with SMTP id e10-20020a6b690a000000b0077aee790652mr4231482ioc.1.1686579107952;
        Mon, 12 Jun 2023 07:11:47 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i19-20020a02cc53000000b0041408b79f1esm2793007jaq.111.2023.06.12.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:11:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
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
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
Subject: Re: decouple block open flags from fmode_t v2
Message-Id: <168657910650.933808.4041515037046679285.b4-ty@kernel.dk>
Date:   Mon, 12 Jun 2023 08:11:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 08 Jun 2023 13:02:28 +0200, Christoph Hellwig wrote:
> this series adds a new blk_mode_t for block open flags instead of abusing
> fmode_t.  The block open flags work very different from the normal use of
> fmode_t and only share the basic READ/WRITE flags with it.  None of the
> other normal FMODE_* flags is used, but instead there are three
> block-specific ones not used by anyone else, which can now be removed.
> 
> Note that I've only CCed maintainers and lists for drivers and file systems
> that have non-trivial changes, as otherwise the series would spam literally
> everyone in the block and file system world.
> 
> [...]

Applied, thanks!

[01/30] block: also call ->open for incremental partition opens
        commit: 9d1c92872e7082f100f629a58b32fa0214aa1aec
[02/30] cdrom: remove the unused bdev argument to cdrom_open
        commit: 764b83100b9aff52f950e408539c22a37cdedae8
[03/30] cdrom: remove the unused mode argument to cdrom_ioctl
        commit: 473399b50de1fdc12606254351273c71d1786251
[04/30] cdrom: remove the unused cdrom_close_write release code
        commit: a4cec8bc14c02e15006a71f02b0e1bbc72b9f796
[05/30] cdrom: track if a cdrom_device_info was opened for data
        commit: 8cdf433e2b8e4fc6c7b4393deb93fb258175d537
[06/30] cdrom: remove the unused mode argument to cdrom_release
        commit: 7ae24fcee9929f9002b84d8121144b2b3590b58c
[07/30] block: pass a gendisk on bdev_check_media_change
        commit: 444aa2c58cb3b6cfe3b7cc7db6c294d73393a894
[08/30] block: pass a gendisk to ->open
        commit: d32e2bf83791727a84ad5d3e3d713e82f9adbe30
[09/30] block: remove the unused mode argument to ->release
        commit: ae220766d87cd6799dbf918fea10613ae14c0654
[10/30] block: rename blkdev_close to blkdev_release
        commit: 7ee34cbc291a28134b60683b246ba58b4b676ec3
[11/30] swsusp: don't pass a stack address to blkdev_get_by_path
        commit: c889d0793d9dc07e94a5fddcc05356157fab00b7
[12/30] bcache: don't pass a stack address to blkdev_get_by_path
        commit: 29499ab060fec044161be73fb0e448eab97b4813
[13/30] rnbd-srv: don't pass a holder for non-exclusive blkdev_get_by_path
        commit: 5ee607675debef509946f8a251d4c30a21493ec2
[14/30] btrfs: don't pass a holder for non-exclusive blkdev_get_by_path
        commit: 2ef789288afd365f4245ba97e56189062de5148e
[15/30] block: use the holder as indication for exclusive opens
        commit: 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307
[16/30] block: add a sb_open_mode helper
        commit: 3f0b3e785e8b54a40c530fa77b7ab37bec925c57
[17/30] fs: remove sb->s_mode
        commit: 81b1fb7d17c0110df839e13468ada9e99bb6e5f4
[18/30] scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool
        commit: 5f4eb9d5413fdfc779c099fdaf0ff417eb163145
[19/30] scsi: replace the fmode_t argument to scsi_ioctl with a simple bool
        commit: 2e80089c18241699c41d0af0669cb93844ff0dc1
[20/30] scsi: replace the fmode_t argument to ->sg_io_fn with a simple bool
        commit: 1991299e49fa58c3ba7e91599932f84bf537d592
[21/30] nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool
        commit: 7d9d7d59d44b7e9236d168472aa222b6543fae25
[22/30] mtd: block: use a simple bool to track open for write
        commit: 658afed19ceed54a52b9e9e69c0791c8868ff55d
[23/30] rnbd-srv: replace sess->open_flags with a "bool readonly"
        commit: 99b07780814e89f16bec2773c237eb25121f8502
[24/30] ubd: remove commented out code in ubd_open
        commit: bd6abfc8e7898ce2163a1ffdbb9ec71a0a081267
[25/30] block: move a few internal definitions out of blkdev.h
        commit: cfb425761c79b6056ae5bb73f8d400f03b513959
[26/30] block: remove unused fmode_t arguments from ioctl handlers
        commit: 5e4ea834676e3b8965344ca61d36e1ae236249eb
[27/30] block: replace fmode_t with a block-specific type for block open flags
        commit: 05bdb9965305bbfdae79b31d22df03d1e2cfcb22
[28/30] block: always use I_BDEV on file->f_mapping->host to find the bdev
        commit: 4e762d8623448bb9d32711832ce977a65ff7636a
[29/30] block: store the holder in file->private_data
        commit: ee3249a8ce78ef014a71b05157a43fba8dc764e3
[30/30] fs: remove the now unused FMODE_* flags
        commit: 0733ad8002916b9dbbbcfe6e92ad44d2657de1c1

Best regards,
-- 
Jens Axboe



