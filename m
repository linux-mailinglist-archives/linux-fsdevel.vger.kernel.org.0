Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47B79C013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjIKUws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbjIKNAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775A0CD7;
        Mon, 11 Sep 2023 06:00:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D58AC433CA;
        Mon, 11 Sep 2023 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694437234;
        bh=gTtArNuZ0vo/RYfzma1n4Nj7HrwLli9DtJUfB6Thws4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDFDXJKS6/Y2QkjEBjP2l9kxDeFHwcUhOkRE5Hd4b2kqfzjlNiT9ZDfOkcczPTNC+
         TCuE8jW4hntfldk3SqtzM4OYoxztc/Vq7ypUBq8AMkO3wTqyyV8abd2yC/969cSAuq
         Y7T3+FqQpNK1ZYKottqqDrOucAbSlXEWGVU/As/EmxxwLl5dxN16SGcxdp4YmB1ovG
         Dgk2zNtzOfDbdenCJansYRsOeDE2ryvCvu56Iz+tS0d9s44v7wwu4TjULA4tDVPj6J
         ALqktbowU323PXO3ZQISMbPVFolDyaYWk9Y0S1MxPPbvW3aL4otvrxVYOciSgjodxe
         0GjTS/5X5+ADw==
Date:   Mon, 11 Sep 2023 15:00:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs freezing question
Message-ID: <20230911-spotten-tadel-4a4cf4e17729@brauner>
References: <20230908-merklich-bebauen-11914a630db4@brauner>
 <20230908143221.GA1977092@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908143221.GA1977092@perftesting>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Eesh, no you're right, seems like we only set this when we're moving devices
> around, so it must have gotten removed at some point.

Thanks for taking a look, Josef!

> > My series can proceed independent of fixing btrfs but I'm just trying to
> > make people aware in case that somehow wasn't known.
> 
> Thanks for that, we definitely need to get this fixed.  Is the bdev->bd_holder
> part of the new mount api, or is it some other thing that we can do right now
> and then be in a good spot when your new patchset lands?  Let me know and we can
> prioritize that work.  Thanks,

This is independent of converting btrfs to the new mount api.

Christoph has landed a patch series this cycle that sets bdev->bd_holder
to the superblock owning the block device. Before his work
bdev->bd_holder was set to the filesystem type. Roughly, this has
enabled us to go from a block device straight to the owning superblock.

Associated with changing bdev->bd_holder is using a set of holder
operations: fs_holder_ops (see fs/super.c). These can be used to perform
various operations on the holder: in this case on the superblock.

IOW, we don't need to find the owning superblock anymore we just need to
go straight from block device to owning superblock. You can see this
e.g., in block/bdev.c:bdev_mark_dead() = fs/super.c:fs_bdev_mark_dead().

What we need is to switch btrfs to bdev->bd_holder = sb and the usage of
fs/super.c:fs_holder_ops if possible. We did this anyway to avoid
deadlocks, allow dropping of s_umount when opening block devices and
ultimately we can find matching superblocks before opening block devices
which will allow us to restrict writers to block devices in v6.7 (Jan's
work).

We converted all block-based filesystems to use this new mechanism but
David insisted on taking the btrfs portion through btrfs itself. So none
of the btrfs patches in the series linked below have made it upstream
for v6.6 and so you're unfortunately the only fs which still uses the
old mechanism:

Subject: [PATCH 05/17] btrfs: open block devices after superblock
https://lore.kernel.org/linux-block/20230811100828.1897174-6-hch@lst.de

What would help is if you would start to take these patches.
