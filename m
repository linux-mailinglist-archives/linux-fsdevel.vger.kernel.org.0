Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37444749253
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGFASS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGFASR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788119AD;
        Wed,  5 Jul 2023 17:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B21D617B6;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C33B1C433C8;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602694;
        bh=UCIqkh07H9RodI2FiYHSloPcTyNTNSp1TtLBvzeAlzY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XD5s9qgQk+bezWq3JBvoy9wmXJ5ZRyDVTHkpXWgLVO3OxVcBH0YyZg8Gz6rb+KfwN
         /A+CNNvgWQMrDzOs56n2cEhwU0PkBRXiccPcVu64Aq1yBYBPWYZC4FuTB8N5QK1KQ+
         MdmDcn18RW7d50qJnG0uAgWsSoPksgnrlWtl7DDURyh0pmkik5uADq73uLJFx1EI+5
         TxJjuarqz28vf+B0YnRKEqs2EnBb9P4N1MwtPeCMbPEFDapDEj1dai8Lh/Uv6asayt
         1cEnsHDnrwJGGhdMLNNVih3y+j4HdKbkLcado1IWcst06dccj5qYciZqXhBkSg0rUM
         /tfAjpbujjdzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1405C64459;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/30] block: also call ->open for incremental
 partition opens
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269464.29151.2364164271547941172.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230608110258.189493-2-hch@lst.de>
In-Reply-To: <20230608110258.189493-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, vigneshr@ti.com, rafael@kernel.org,
        linux-nvme@lists.infradead.org, phil@philpotter.co.uk, clm@fb.com,
        dm-devel@redhat.com, haris.iqbal@ionos.com, pavel@ucw.cz,
        miquel.raynal@bootlin.com, jinpu.wang@ionos.com,
        linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        richard@nod.at, linux-pm@vger.kernel.org,
        linux-um@lists.infradead.org, josef@toxicpanda.com, colyli@suse.de,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        viro@zeniv.linux.org.uk, dsterba@suse.com, brauner@kernel.org,
        martin.petersen@oracle.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-btrfs@vger.kernel.org, hare@suse.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Thu,  8 Jun 2023 13:02:29 +0200 you wrote:
> For whole devices ->open is called for each open, but for partitions it
> is only called on the first open of a partition, e.g.:
> 
>   open("/dev/vdb", ...)
>   open("/dev/vdb", ...)
>     - 2 call to ->open
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/30] block: also call ->open for incremental partition opens
    https://git.kernel.org/jaegeuk/f2fs/c/9d1c92872e70
  - [f2fs-dev,02/30] cdrom: remove the unused bdev argument to cdrom_open
    https://git.kernel.org/jaegeuk/f2fs/c/764b83100b9a
  - [f2fs-dev,03/30] cdrom: remove the unused mode argument to cdrom_ioctl
    https://git.kernel.org/jaegeuk/f2fs/c/473399b50de1
  - [f2fs-dev,04/30] cdrom: remove the unused cdrom_close_write release code
    https://git.kernel.org/jaegeuk/f2fs/c/a4cec8bc14c0
  - [f2fs-dev,05/30] cdrom: track if a cdrom_device_info was opened for data
    https://git.kernel.org/jaegeuk/f2fs/c/8cdf433e2b8e
  - [f2fs-dev,06/30] cdrom: remove the unused mode argument to cdrom_release
    https://git.kernel.org/jaegeuk/f2fs/c/7ae24fcee992
  - [f2fs-dev,07/30] block: pass a gendisk on bdev_check_media_change
    https://git.kernel.org/jaegeuk/f2fs/c/444aa2c58cb3
  - [f2fs-dev,08/30] block: pass a gendisk to ->open
    https://git.kernel.org/jaegeuk/f2fs/c/d32e2bf83791
  - [f2fs-dev,09/30] block: remove the unused mode argument to ->release
    https://git.kernel.org/jaegeuk/f2fs/c/ae220766d87c
  - [f2fs-dev,10/30] block: rename blkdev_close to blkdev_release
    https://git.kernel.org/jaegeuk/f2fs/c/7ee34cbc291a
  - [f2fs-dev,11/30] swsusp: don't pass a stack address to blkdev_get_by_path
    https://git.kernel.org/jaegeuk/f2fs/c/c889d0793d9d
  - [f2fs-dev,12/30] bcache: don't pass a stack address to blkdev_get_by_path
    https://git.kernel.org/jaegeuk/f2fs/c/29499ab060fe
  - [f2fs-dev,13/30] rnbd-srv: don't pass a holder for non-exclusive blkdev_get_by_path
    https://git.kernel.org/jaegeuk/f2fs/c/5ee607675deb
  - [f2fs-dev,14/30] btrfs: don't pass a holder for non-exclusive blkdev_get_by_path
    https://git.kernel.org/jaegeuk/f2fs/c/2ef789288afd
  - [f2fs-dev,15/30] block: use the holder as indication for exclusive opens
    https://git.kernel.org/jaegeuk/f2fs/c/2736e8eeb0cc
  - [f2fs-dev,16/30] block: add a sb_open_mode helper
    https://git.kernel.org/jaegeuk/f2fs/c/3f0b3e785e8b
  - [f2fs-dev,17/30] fs: remove sb->s_mode
    https://git.kernel.org/jaegeuk/f2fs/c/81b1fb7d17c0
  - [f2fs-dev,18/30] scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool
    https://git.kernel.org/jaegeuk/f2fs/c/5f4eb9d5413f
  - [f2fs-dev,19/30] scsi: replace the fmode_t argument to scsi_ioctl with a simple bool
    https://git.kernel.org/jaegeuk/f2fs/c/2e80089c1824
  - [f2fs-dev,20/30] scsi: replace the fmode_t argument to ->sg_io_fn with a simple bool
    https://git.kernel.org/jaegeuk/f2fs/c/1991299e49fa
  - [f2fs-dev,21/30] nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool
    https://git.kernel.org/jaegeuk/f2fs/c/7d9d7d59d44b
  - [f2fs-dev,22/30] mtd: block: use a simple bool to track open for write
    https://git.kernel.org/jaegeuk/f2fs/c/658afed19cee
  - [f2fs-dev,23/30] rnbd-srv: replace sess->open_flags with a "bool readonly"
    https://git.kernel.org/jaegeuk/f2fs/c/99b07780814e
  - [f2fs-dev,24/30] ubd: remove commented out code in ubd_open
    https://git.kernel.org/jaegeuk/f2fs/c/bd6abfc8e789
  - [f2fs-dev,25/30] block: move a few internal definitions out of blkdev.h
    https://git.kernel.org/jaegeuk/f2fs/c/cfb425761c79
  - [f2fs-dev,26/30] block: remove unused fmode_t arguments from ioctl handlers
    https://git.kernel.org/jaegeuk/f2fs/c/5e4ea834676e
  - [f2fs-dev,27/30] block: replace fmode_t with a block-specific type for block open flags
    https://git.kernel.org/jaegeuk/f2fs/c/05bdb9965305
  - [f2fs-dev,28/30] block: always use I_BDEV on file->f_mapping->host to find the bdev
    https://git.kernel.org/jaegeuk/f2fs/c/4e762d862344
  - [f2fs-dev,29/30] block: store the holder in file->private_data
    https://git.kernel.org/jaegeuk/f2fs/c/ee3249a8ce78
  - [f2fs-dev,30/30] fs: remove the now unused FMODE_* flags
    https://git.kernel.org/jaegeuk/f2fs/c/0733ad800291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


