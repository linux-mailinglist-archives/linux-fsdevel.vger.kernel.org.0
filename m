Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC57BE344
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjJIOoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjJIOoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:44:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B38F;
        Mon,  9 Oct 2023 07:44:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD2FC433C8;
        Mon,  9 Oct 2023 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696862644;
        bh=zR4FRH/0YXd++ACBWZ5EzM4vY8LFrSEQaaed6kyhrzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI57Tu4PuZQ9u3Adt4mFOcfvxFPwkzsB+va0e0kdUuXIo239edYbM/eE3sDfssN3E
         y9uuLeRN46aCrY7Iq9w5HzXclhYQjnelZ8WpjuDNKF/dIuTHTT9Lo8p1V1F8B+CW5u
         qUzLlJaV6pEV/OZ88ha3DbkapOmaoCwUxtnkBoSFxzP6mmL+7kH8jFLpaSAqvbA1oY
         MQ0eAoob9D5Ku+BMFaFvRAsCtzBdt64MC7dIlOlV+efHoF8qEF2ZHw4U1cuk0xCh9q
         /kGdNsUvFiP0Kbj6WCKUSYbspx70axXAb5uLQ7Uf66it4nIOQVO6khtemNY1T2vAPx
         KE4DT8Yt8WRYw==
From:   Christian Brauner <brauner@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 00/29] const xattr tables
Date:   Mon,  9 Oct 2023 16:43:50 +0200
Message-Id: <20231009-original-absprachen-d5b3b10c8768@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: 
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4637; i=brauner@kernel.org; h=from:subject:message-id; bh=zR4FRH/0YXd++ACBWZ5EzM4vY8LFrSEQaaed6kyhrzM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSqCM7cL6p43b4sdMmPSvkDQYFLo9++9iu3E5O7u891Ssqn 3GDVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0MDP8z+34bi3SlrntYdrZpNOOhd +KeCc6+e0KDaudqPMnsfekMyNDL6fWpWv7RHleWbsyJF/8obHF42E554TiAom/N95cfPmLDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 02:00:04AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> The 's_xattr' field of 'struct super_block' currently requires a mutable
> table of 'struct xattr_handler' entries (although each handler itself is
> const). However, no code in vfs actually modifies the tables.
>
> So this series changes the type of 's_xattr' to allow const tables, and
> modifies existing file system to move their tables to .rodata. This is
> desirable because these tables contain entries with function pointers in
> them; moving them to .rodata makes it considerably less likely to be
> modified accidentally or maliciously at runtime.
>
> I found this while writing Rust abstractions for vfs.

Applied to the vfs.xattr branch of the vfs/vfs.git tree.
Patches in the vfs.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.xattr

[01/29] xattr: make the xattr array itself const
        https://git.kernel.org/vfs/vfs/c/e346fb6d774a
[02/29] ext4: move ext4_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/e60ac1283340
[03/29] 9p: move xattr-related structs to .rodata
        https://git.kernel.org/vfs/vfs/c/b6079dc9cb51
[04/29] afs: move afs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/f710c2e48135
[05/29] btrfs: move btrfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/8a25b4189896
[06/29] ceph: move ceph_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/10f9fbe9f25a
[07/29] ecryptfs: move ecryptfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/f354ed981066
[08/29] erofs: move erofs_xattr_handlers and xattr_handler_map to .rodata
        https://git.kernel.org/vfs/vfs/c/3591f40e223c
[09/29] ext2: move ext2_xattr_handlers and ext2_xattr_handler_map to .rodata
        https://git.kernel.org/vfs/vfs/c/ce78a1ec1c3b
[10/29] f2fs: move f2fs_xattr_handlers and f2fs_xattr_handler_map to .rodata
        https://git.kernel.org/vfs/vfs/c/a1c0752c33d2
[11/29] fuse: move fuse_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/34271edb1878
[12/29] gfs2: move gfs2_xattr_handlers_max to .rodata
        https://git.kernel.org/vfs/vfs/c/89491fafa81c
[13/29] hfs: move hfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/e27a45b65070
[14/29] hfsplus: move hfsplus_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/2c323f2c5650
[15/29] jffs2: move jffs2_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/13a75c3abcbe
[16/29] jfs: move jfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/ea780283e2c0
[17/29] kernfs: move kernfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/ffb2e0650827
[18/29] nfs: move nfs4_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/f496647e3b09
[19/29] ntfs3: move ntfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/5bf1dd9441da
[20/29] ocfs2: move ocfs2_xattr_handlers and ocfs2_xattr_handler_map to .rodata
        https://git.kernel.org/vfs/vfs/c/2cba9af99b3f
[21/29] orangefs: move orangefs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/2e9440ac0716
[22/29] reiserfs: move reiserfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/c063254b7de8
[23/29] smb: move cifs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/e45679b0d2e4
[24/29] squashfs: move squashfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/8a2ae79c7db0
[25/29] ubifs: move ubifs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/582f1ebe32a9
[26/29] xfs: move xfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/6fca42a3b168
[27/29] overlayfs: move xattr tables to .rodata
        https://git.kernel.org/vfs/vfs/c/3f644c1cd7b5
[28/29] shmem: move shmem_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/2f8e5f98045e
[29/29] net: move sockfs_xattr_handlers to .rodata
        https://git.kernel.org/vfs/vfs/c/dcff22588d9a
