Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD754EAAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbiFPUSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378308AbiFPUSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:18:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678B34BBD;
        Thu, 16 Jun 2022 13:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E69B8241A;
        Thu, 16 Jun 2022 20:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B59C34114;
        Thu, 16 Jun 2022 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655410695;
        bh=uHvrE+2KCGPR9N5AeXBgCBnYJvNxKl74BJyMaayUJlE=;
        h=From:To:Cc:Subject:Date:From;
        b=FE409cquZhNFTvUkhTz7aypxXcp8WVokxBhnOgrLH7rlE98ZDV8l1GdGcslnY0oFx
         ByeEMsNBaXb9VYG8LFVjl1S+79f5i0YjMkfvsUE9Wj3myE3PSK8zfRz0/EtowyYHBO
         iOw2iLltOMlau7xeqpRv3LdCm6DGDeTZUolKc2IzonnbO9+6YbZOwCNo8qGlEkRTWs
         hqpSWrzTz01/8v2Q3ZThHothFD/mn5Nhs+a+vL4u/yf4s+PM80d04AO9bKkU0tNZug
         OemXtvGjdbXjqfvdtyPIPCgcGjA799xlqEljsmrYSlYgC4GqLRYODBx4O/scdI2HT6
         b92/3YjwKg2Ow==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 0/8] make statx() return DIO alignment information
Date:   Thu, 16 Jun 2022 13:14:58 -0700
Message-Id: <20220616201506.124209-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset makes the statx() system call return direct I/O (DIO)
alignment information.  This allows userspace to easily determine
whether a file supports DIO, and if so with what alignment restrictions.

Patch 1 adds the basic VFS support for STATX_DIOALIGN.  Patch 2 wires it
up for all block device files.  The remaining patches wire it up for
regular files on ext4 and f2fs.  Support for regular files on other
filesystems can be added later.

I've also written a man-pages patch, which I'm sending separately.

Note, f2fs has one corner case where DIO reads are allowed but not DIO
writes.  The proposed statx fields can't represent this.  My proposal
(patch 6) is to just eliminate this case, as it seems much too weird.
But I'd appreciate any feedback on that part.

This patchset applies to v5.19-rc2.

Changed v2 => v3:
   - Dropped the stx_offset_align_optimal field, since its purpose
     wasn't clearly distinguished from the existing stx_blksize.

   - Renamed STATX_IOALIGN to STATX_DIOALIGN, to reflect the new focus
     on DIO only.

   - Similarly, renamed stx_{mem,offset}_align_dio to
     stx_dio_{mem,offset}_align, to reflect the new focus on DIO only.

   - Wired up STATX_DIOALIGN on block device files.

Changed v1 => v2:
   - No changes.

Eric Biggers (8):
  statx: add direct I/O alignment information
  vfs: support STATX_DIOALIGN on block devices
  fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
  ext4: support STATX_DIOALIGN
  f2fs: move f2fs_force_buffered_io() into file.c
  f2fs: don't allow DIO reads but not DIO writes
  f2fs: simplify f2fs_force_buffered_io()
  f2fs: support STATX_DIOALIGN

 fs/crypto/inline_crypt.c  | 48 ++++++++++++++++++++-------------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 10 ++++----
 fs/ext4/inode.c           | 29 +++++++++++++++++++++++
 fs/f2fs/f2fs.h            | 45 ------------------------------------
 fs/f2fs/file.c            | 45 +++++++++++++++++++++++++++++++++++-
 fs/stat.c                 | 37 ++++++++++++++++++++++++++++++
 include/linux/fscrypt.h   |  7 ++----
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  4 +++-
 10 files changed, 147 insertions(+), 81 deletions(-)

-- 
2.36.1

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
