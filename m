Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCC769C91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGaQdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjGaQdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7FE3;
        Mon, 31 Jul 2023 09:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 145B0611FA;
        Mon, 31 Jul 2023 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79433C433C7;
        Mon, 31 Jul 2023 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690821178;
        bh=9i8LJI+T4uoH41XWGczyor+SrktGj/4ZSTLsUYWT9LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+wY7zG0+STpq+BUQ5RxzgSL1jfWTCHHd/N3iuued8C2cRbltXGEyZkooxZdi2la0
         SEZA+u/yDM7Tk3DbloF2FjbB5kHd2YWfRyJQwCI0y1//gGowS7ZKrYRk/yJG3FnTO/
         qJ6cB9FcKYCZDE2B2YmYM/qkENr6dEUiSBCbZsnI4zYRdtgztODsiZarWRnQcQQuuM
         DpTgPHjj3XbYJWok8O2qXQlhQlTu44sQEHFcHNrLHO5Zefvlpr8tmSwVzQ4PmgRRHT
         pYawqEMg5o5UHeAZjliaNOrU7lMz0gWwXACIZpnfwRLgQ7bYaaVoRsmTgUKAFfkqWQ
         sgd+9A5sXrOVg==
Date:   Mon, 31 Jul 2023 18:32:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jack@suse.cz,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
 <20230731-augapfel-penibel-196c3453f809@brauner>
 <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
 <20230731135325.GB6016@lst.de>
 <20230731-deswegen-chatten-4ff6c45563ad@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731-deswegen-chatten-4ff6c45563ad@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:57:57PM +0200, Christian Brauner wrote:
> On Mon, Jul 31, 2023 at 03:53:25PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 31, 2023 at 03:22:28PM +0200, Christian Brauner wrote:
> > > Uh, no. I vasty underestimated how sensitive that change would be. Plus
> > > arguably ->kill_sb() really should be callable once the sb is visible.
> > > 
> > > Are you looking into this or do you want me to, Christoph?
> > 
> > I'm planning to look into it, but I won't get to it before tomorrow.
> 
> Ok, let me go through the callsites and make sure that all callers are
> safe. I think we should just continue calling deactivate_locked_super()
> exactly the way we do right now but remove shenanigans like the one we
> have in erofs_kill_sb().

The only filesystem that did implicitly rely on fill_super() having been
called was indeed - sorry to single it out - erofs. Everyone else
doesn't have that sort of dependency afaict.

fs/erofs/super.c:       return get_tree_bdev(fc, erofs_fc_fill_super);
=> ->kill_sb() has requirement that ->fill_super() has been called.

So I went and looked at all users of

(1) get_tree_bdev() -> new mount api
(2) mount_bdev      -> old mount api

which are the two functions that were changed in Jan's and Christoph's
patch.

I'm listing the results below. One thing to note is that only 40% (10
out of the 26 I looked at) of block based filesystems reliant on
higher-level fs/super.c helpers directly (e.g., that excludes btrfs)
have converted to the new mount api.

In any case, Gao, can you remove that dependency of erofs_kill_sb() on
erofs_fill_super(), please? Once that hits upstream the syzbot report
will go away.

fs/exfat/super.c:         return get_tree_bdev(fc, exfat_fill_super);
fs/ntfs3/super.c:         return get_tree_bdev(fc, ntfs_fill_super);
fs/squashfs/super.c:      return get_tree_bdev(fc, squashfs_fill_super);
fs/ext4/super.c:          return get_tree_bdev(fc, ext4_fill_super);
fs/xfs/xfs_super.c:       return get_tree_bdev(fc, xfs_fs_fill_super);
fs/adfs/super.c:          return mount_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
fs/befs/linuxvfs.c:       return mount_bdev(fs_type, flags, dev_name, data, befs_fill_super);
fs/bfs/inode.c:           return mount_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
fs/ext2/super.c:          return mount_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
fs/fat/namei_msdos.c:     return mount_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
fs/fat/namei_vfat.c:      return mount_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
fs/freevxfs/vxfs_super.c: return mount_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
fs/hfs/super.c:           return mount_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
fs/hfsplus/super.c:       return mount_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super);
fs/hpfs/super.c:          return mount_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
fs/isofs/inode.c:         return mount_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
fs/jfs/super.c:           return mount_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
fs/minix/inode.c:         return mount_bdev(fs_type, flags, dev_name, data, minix_fill_super);
fs/ntfs/super.c:          return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
fs/ocfs2/super.c:         return mount_bdev(fs_type, flags, dev_name, data, ocfs2_fill_super);
fs/omfs/inode.c:          return mount_bdev(fs_type, flags, dev_name, data, omfs_fill_super);
fs/qnx6/inode.c:          return mount_bdev(fs_type, flags, dev_name, data, qnx6_fill_super);
fs/sysv/super.c:          return mount_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
fs/udf/super.c:           return mount_bdev(fs_type, flags, dev_name, data, udf_fill_super);
fs/ufs/super.c:           return mount_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
=> no custom ->kill_sb() method.

fs/cramfs/inode.c:        ret = get_tree_bdev(fc, cramfs_blkdev_fill_super);
fs/fuse/inode.c:          err = get_tree_bdev(fsc, fuse_fill_super);
fs/gfs2/ops_fstype.c:     error = get_tree_bdev(fc, gfs2_fill_super);
fs/romfs/super.c:         ret = get_tree_bdev(fc, romfs_fill_super);
fs/affs/super.c:          return mount_bdev(fs_type, flags, dev_name, data, affs_fill_super);
fs/efs/super.c:           return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
fs/f2fs/super.c:          return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
fs/qnx4/inode.c:          return mount_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
fs/reiserfs/super.c:      return mount_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super);
fs/zonefs/super.c:        return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
=> ->kill_sb() has no requirement that ->fill_super() has been called.
