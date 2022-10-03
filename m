Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC25F27DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 05:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJCDb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 23:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJCDbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5031356F5;
        Sun,  2 Oct 2022 20:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82392B8058E;
        Mon,  3 Oct 2022 03:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C19C433C1;
        Mon,  3 Oct 2022 03:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664767911;
        bh=y35fnV1suzCrdYnC9ogHY7hnwYVGR7VG5Y9k9Bvj6Y4=;
        h=Date:From:To:Cc:Subject:From;
        b=aXP5wX8T+Tj8ZKfuf/V+xa7gVbK0pLGri+mgOnMuP/IlzoyXMTV3k4ILCuklR6mZM
         FlaX90HO752CwrDRAnB4OdepWaGdvPTCVgt95WYpqKZHk979DdoVvdD1ZFziKehmd9
         zheGJo2+IVxfZnix2V7pcEv8F/blcN0QtP0GI8MVxwJ0BbVEod0APOgnGLSwJuAqfa
         grfOZgNRUjbIJ0CbrqHwg688qD4Ra9NLOmyhI7gmYwD0mwlGlvrfDDyPwqGrvJ9plG
         qfMG4uxF+RUX0f63BuXtgjxCvoja9F4BNDjWRV5uCa8QPEwG2L/oQe7iX5WGEgXaqT
         ciwkakE9U+5Aw==
Date:   Sun, 2 Oct 2022 20:31:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] STATX_DIOALIGN for 6.1
Message-ID: <YzpXpalOcvwp+keu@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/statx-dioalign-for-linus

for you to fetch changes up to 61a223df421f698c253143014cfd384255b3cf1e:

  xfs: support STATX_DIOALIGN (2022-09-11 19:47:12 -0500)

----------------------------------------------------------------

Make statx() support reporting direct I/O (DIO) alignment information.
This provides a generic interface for userspace programs to determine
whether a file supports DIO, and if so with what alignment restrictions.
Specifically, STATX_DIOALIGN works on block devices, and on regular
files when their containing filesystem has implemented support.

An interface like this has been requested for years, since the
conditions for when DIO is supported in Linux have gotten increasingly
complex over time.  Today, DIO support and alignment requirements can be
affected by various filesystem features such as multi-device support,
data journalling, inline data, encryption, verity, compression,
checkpoint disabling, log-structured mode, etc.  Further complicating
things, Linux v6.0 relaxed the traditional rule of DIO needing to be
aligned to the block device's logical block size; now user buffers (but
not file offsets) only need to be aligned to the DMA alignment.

The approach of uplifting the XFS specific ioctl XFS_IOC_DIOINFO was
discarded in favor of creating a clean new interface with statx().

For more information, see the individual commits and the man page update
https://lore.kernel.org/r/20220722074229.148925-1-ebiggers@kernel.org.

----------------------------------------------------------------
Eric Biggers (8):
      statx: add direct I/O alignment information
      vfs: support STATX_DIOALIGN on block devices
      fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
      ext4: support STATX_DIOALIGN
      f2fs: move f2fs_force_buffered_io() into file.c
      f2fs: simplify f2fs_force_buffered_io()
      f2fs: support STATX_DIOALIGN
      xfs: support STATX_DIOALIGN

 block/bdev.c              | 23 ++++++++++++++++++++++
 fs/crypto/inline_crypt.c  | 49 +++++++++++++++++++++++------------------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 37 ++++++++++++++++++++++++-----------
 fs/ext4/inode.c           | 37 +++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h            | 40 --------------------------------------
 fs/f2fs/file.c            | 43 ++++++++++++++++++++++++++++++++++++++++-
 fs/stat.c                 | 14 ++++++++++++++
 fs/xfs/xfs_iops.c         | 10 ++++++++++
 include/linux/blkdev.h    |  4 ++++
 include/linux/fscrypt.h   |  7 ++-----
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  4 +++-
 13 files changed, 188 insertions(+), 83 deletions(-)
