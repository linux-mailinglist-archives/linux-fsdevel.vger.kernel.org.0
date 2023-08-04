Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC37704FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHDPjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjHDPjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82249C1;
        Fri,  4 Aug 2023 08:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 061246202B;
        Fri,  4 Aug 2023 15:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31522C433C9;
        Fri,  4 Aug 2023 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163570;
        bh=WBKOiXxNnEcmIAXLd9bFnF2KFmCPgIBMmS+a6ZOzWKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guM3dTEfPj9gzW4hZVBn+/1D3e6V0oGJa3WQkuaCaRJm+YEkO/j0g28vpLcq+8KPx
         00I5JDimR9O6GRpM1sCbRoDBeqI3dA0US5iDcvRFH1wRzLZGMG/AKi+37CHK3OiKfl
         Pd3WUGjQp78CvSWurtOz9TKUp2R8T9+xWekamZzkpVJreEREn7gcZJVUpwDMtQgJPa
         oNlJ1Fd+Wv/UAECk8iLUJUaVzEv4k+34Xo4z1QJAK3CSDmvC6vv3w+O4TwoqgSUVxv
         yOZLQQe40+3upkBEjN2TRg8dq8CL62TzVM9oUzcd7edWypJQ/9r8RDeBu3CtctpdP3
         S7Paz1gf4bygw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: more blkdev_get and holder work
Date:   Fri,  4 Aug 2023 17:39:20 +0200
Message-Id: <20230804-wegelagerei-nagel-e5ba7e7cedd5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=brauner@kernel.org; h=from:subject:message-id; bh=7FNUYW+x5CSjf6yCNgXxulkGn+cMsTW366YHSfu1h4A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSclU4X5tucveB9lDl37gJ9jlmvFGN+KNg9TprAwbY/er8W 31PtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncNWf4K3Hkgdv/npvLfSQ798adms 9ScvSZ2rptQtc471tqdUeIZzMyHOPQmly1SzxZ11D73stJc0XjnmfPNpO6vb5+SlL6wynWPAA=
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

On Wed, 02 Aug 2023 17:41:19 +0200, Christoph Hellwig wrote:
> this series sits on top of the vfs.super branch in the VFS tree and does a
> few closely related things:
> 
>   1) it also converts nilfs2 and btrfs to the new scheme where the file system
>      only opens the block devices after we know that a new super_block was
>      allocated.
>   2) it then makes sure that for all file system openers the super_block is
>      stored in bd_holder, and makes use of that fact in the mark_dead method
>      so that it doesn't have to fall get_super and thus can also work on
>      block devices that sb->s_bdev doesn't point to
>   3) it then drops the fs-specific holder ops in ext4 and xfs and uses the
>      generic fs_holder_ops there
> 
> [...]

Let's pick this up now so it still has ample time in -next even though
we're still missing a nod from the btrfs people. The nilfs to
mount_bdev() conversion is probably not super urgent but if wanted a
follow-up patch won't be frowned upon.

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[01/12] fs: export setup_bdev_super
        https://git.kernel.org/vfs/vfs/c/71c00ec51d83
[02/12] nilfs2: use setup_bdev_super to de-duplicate the mount code
        https://git.kernel.org/vfs/vfs/c/c820df38784a
[03/12] btrfs: always open the device read-only in btrfs_scan_one_device
        https://git.kernel.org/vfs/vfs/c/75029e14cea6
[04/12] btrfs: open block devices after superblock creation
        https://git.kernel.org/vfs/vfs/c/364820697dbb
[05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more robust
        https://git.kernel.org/vfs/vfs/c/4cf66c030db1
[06/12] fs: use the super_block as holder when mounting file systems
        https://git.kernel.org/vfs/vfs/c/c0188baf8f7e
[07/12] fs: stop using get_super in fs_mark_dead
        https://git.kernel.org/vfs/vfs/c/2a8402f9db25
[08/12] fs: export fs_holder_ops
        https://git.kernel.org/vfs/vfs/c/ee62b0ec9ff8
[09/12] ext4: drop s_umount over opening the log device
        https://git.kernel.org/vfs/vfs/c/644ab8c64a12
[10/12] ext4: use fs_holder_ops for the log device
        https://git.kernel.org/vfs/vfs/c/fba3de1aad77
[11/12] xfs: drop s_umount over opening the log and RT devices
        https://git.kernel.org/vfs/vfs/c/9470514a171c
[12/12] xfs use fs_holder_ops for the log and RT devices
        https://git.kernel.org/vfs/vfs/c/c6fb2ed736e3
