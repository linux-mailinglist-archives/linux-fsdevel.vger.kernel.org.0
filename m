Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D996761E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGYQcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGYQcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394113D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 09:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B189617E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 16:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C79C433C8;
        Tue, 25 Jul 2023 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690302730;
        bh=w5CYpGezhMyGhBHulH91IHFKRnOySxzwJL/Becf2xjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ib3wJiS9/AY2JmfAkGVS//uNwnJ4j74LOOx48jBBDpbPUEcZEsJCCG9MGNBNHOJx+
         jRtWpZs/vySzVHyQdPYiT9XXfVcTdyzNtUfT+33k7Tu9HOlo0BmioGJmekaHGrK+EC
         kGWh2QpKnlhk+7FkHeEEHmwU0Tdt6wHX2EZkWdDPXBtdEtEjvYFaniSAQGIu4AG3cK
         mTFUGax8fKwFYn8BpT3Bs20ocgvE8vFP2VlTdMxl4xF1a2HCWKNd5EEeANxuVpE8BQ
         wvCp1bxhxiIPl/+UneD/9RzIgZHtIqbWBQwwpItloPCwEfgWFu24NKHDigTnNQlOcL
         Pu6MO/hSXNqag==
Date:   Tue, 25 Jul 2023 18:32:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230725-einnahmen-warnschilder-17779aec0a97@brauner>
References: <20230724175145.201318-1-hch@lst.de>
 <20230725-tagebuch-gerede-a28f8fd8084a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725-tagebuch-gerede-a28f8fd8084a@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:35:17PM +0200, Christian Brauner wrote:
> On Mon, Jul 24, 2023 at 10:51:45AM -0700, Christoph Hellwig wrote:
> > From: Jan Kara <jack@suse.cz>
> > 
> > Currently get_tree_bdev and mount_bdev open the block device before
> > commiting to allocating a super block.  This means the block device
> > is opened even for bind mounts and other reuses of the super_block.
> > 
> > That creates problems for restricting the number of writers to a device,
> > and also leads to a unusual and not very helpful holder (the fs_type).
> > 
> > Reorganize the mount code to first look whether the superblock for a
> > particular device is already mounted and open the block device only if
> > it is not.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > [hch: port to before the bdev_handle changes,
> >       duplicate the bdev read-only check from blkdev_get_by_path,
> >       extend the fsfree_mutex coverage to protect against freezes,
> >       fix an open bdev leak when the bdev is frozen,
> >       use the bdev local variable more,
> >       rename the s variable to sb to be more descriptive]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> > 
> > So I promised to get a series that builds on top of this ready, but
> > I'm way to busy and this will take a while.  Getting this reworked
> > version of Jan's patch out for everyone to use it as a based given
> > that Christian is back from vacation, and I think Jan should be about
> > back now as well.
> 
> I'm in the middle of reviewing this. You're probably aware, but both
> btrfs and nilfs at least still open the devices first since they
> open-code their bdev and sb handling.

I've removed the references to bind mounts from the commit message.
I mentioned in [1] and [2] that this problem is really related to
superblocks at it's core. It's just that technically a bind-mount would
be created in the following scenario where two processes race to create
a superblock:

P1								P2
fd_fs = fsopen("ext4");						fd_fs = fsopen("ext4");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");	fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");

// wins and creates superblock
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
								// finds compatible superblock of P1
								// spins until P1 sets SB_BORN and grabs a reference
								fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)

P1								P2
fd_mnt1 = fsmount(fd_fs);					fd_mnt2 = fsmount(fd_fs);
move_mount(fd_mnt1, "/A")                                       move_mount(fd_mnt2, "/B")

If we forbid writes to a mounted block device like Jan's other patch did
then before your's and Jan's patch P2 would fail at FSCONFIG_CMD_CREATE
iirc.

But bind-mounting itself isn't really broken. For example, even after P2
failed to create the superblock it could very well still do:

mount --bind /A /C
mount --bind /A /D

or whatever as that never goes into get_tree again. The problem really
is that stuff like:

mount -t ext4 /dev/sda /E

would be broken but the problem is that this request is arguably
ambiguous when seen from userspace. It either means:

(1) create a superblock and mount it at /E
(2) create a bind-mount for an existing superblock at /E

For P1 (1) is the case but for P2 (2) is the case.

Most of the time users really want (1). Right now, we have no way
for a user to be sure that (1) did take place aka that they did indeed
create the superblock. That can be a problem in environments where you
need to be sure that you did create the superblock with the correct
options. Because for P2 all mount options that they set may well be
completely ignored unless e.g., P1 did request rw and P2 did request ro.

This is why I'd like to add something like FSCONFIG_CMD_CREATE_EXCL
which would fail if the caller didn't actually create the superblock but
found an existing one instead.

[1]: https://lore.kernel.org/linux-block/20230704-fasching-wertarbeit-7c6ffb01c83d@brauner
[2]: https://lore.kernel.org/linux-block/20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner
