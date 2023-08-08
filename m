Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139AB774113
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHHROa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjHHRNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806526A6;
        Tue,  8 Aug 2023 09:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA3F617C1;
        Tue,  8 Aug 2023 08:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC090C433C8;
        Tue,  8 Aug 2023 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691485069;
        bh=jRxjFz09Uh7ZkVIXCQG/65cnOzMIdv2cBiHme7VbOvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqsWvxVQnUY5uZoUjqDs00BsmyspxW0N3Nd/2KIExW4RCIDtEeMUjmgThJiJypC/J
         HYmkIZkSVjOISExgk+Sn52YsNkU3YsV5ktKa+mMzjI7yGQS9Tkzp2Bl2g86u7DKA6t
         AGqEdzVHORXG6kMTxD1BjgusWwxkxHHW3pz/fGgHFxgQd151ghwtd2xRW327ZHzTJN
         YAm+A3xQXH0+IUsOsJ7Ew9c2uPNTaLWI2TJYriPpGprsNAKzC8UDrjuCjT3Mh3DW9p
         KDEV2e49nCCgvtQ+6vRq48quiNlvKFpgyav0i6SkScKbs9fSGbKEOQLQP6lTLY//hm
         tkpgCGhKIo7vg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: remove bdev->bd_super
Date:   Tue,  8 Aug 2023 10:57:41 +0200
Message-Id: <20230808-handhaben-jahrtausend-b3f041767517@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807112625.652089-1-hch@lst.de>
References: <20230807112625.652089-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=brauner@kernel.org; h=from:subject:message-id; bh=jRxjFz09Uh7ZkVIXCQG/65cnOzMIdv2cBiHme7VbOvo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRcYm6U+J4hEq746Uy2xOLOqnMH5h2ZfyHO8jrvPJ+E8nd8 u+5xdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkyJORoc1ppZxui2vd8quNwaf/iK fz1S134NFzmV356sx2PTuWO4wMf8S2P7h36dux4y3zpH/dlItfmfMmfEn97E+tNxxLRCUusgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 07 Aug 2023 12:26:21 +0100, Christoph Hellwig wrote:
> this series is against the vfs.super branch in the VFS tree and removes the
> bd_super field in struct block_device.
> 
> Diffstat:
>  fs/buffer.c               |   11 +++--------
>  fs/ext4/ext4_jbd2.c       |    3 +--
>  fs/ext4/super.c           |    1 -
>  fs/ocfs2/journal.c        |    6 +++---
>  fs/romfs/super.c          |    1 -
>  fs/super.c                |    3 ---
>  include/linux/blk_types.h |    1 -
>  7 files changed, 7 insertions(+), 19 deletions(-)
> 
> [...]

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

[1/4] fs: stop using bdev->bd_super in mark_buffer_write_io_error
      https://git.kernel.org/vfs/vfs/c/0007ce9af88c
[2/4] ext4: don't use bdev->bd_super in __ext4_journal_get_write_access
      https://git.kernel.org/vfs/vfs/c/a9572cf0e7d2
[3/4] ocfs2: stop using bdev->bd_super for journal error logging
      https://git.kernel.org/vfs/vfs/c/807c772f2a12
[4/4] fs, block: remove bdev->bd_super
      https://git.kernel.org/vfs/vfs/c/0a59ff894703
