Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8292CCC78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgLCCX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgLCCX1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:23:27 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/9] Allow deleting files with unsupported encryption policy
Date:   Wed,  2 Dec 2020 18:20:32 -0800
Message-Id: <20201203022041.230976-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently it's impossible to delete files that use an unsupported
encryption policy, as the kernel will just return an error when
performing any operation on the top-level encrypted directory, even just
a path lookup into the directory or opening the directory for readdir.

It's desirable to return errors for most operations on files that use an
unsupported encryption policy, but the current behavior is too strict.
We need to allow enough to delete files, so that people can't be stuck
with undeletable files when downgrading kernel versions.  That includes
allowing directories to be listed and allowing dentries to be looked up.

This series fixes this (on ext4, f2fs, and ubifs) by treating an
unsupported encryption policy in the same way as "key unavailable" in
the cases that are required for a recursive delete to work.

The actual fix is in patch 9, so see that for more details.

Patches 1-8 are cleanups that prepare for the actual fix by removing
direct use of fscrypt_get_encryption_info() by filesystems.

This patchset applies to branch "master" (commit 4a4b8721f1a5) of
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.

Changed since v1:
  - Made some minor updates to commit messages.
  - Added Reviewed-by tags.

Eric Biggers (9):
  ext4: remove ext4_dir_open()
  f2fs: remove f2fs_dir_open()
  ubifs: remove ubifs_dir_open()
  ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
  fscrypt: introduce fscrypt_prepare_readdir()
  fscrypt: move body of fscrypt_prepare_setattr() out-of-line
  fscrypt: move fscrypt_require_key() to fscrypt_private.h
  fscrypt: unexport fscrypt_get_encryption_info()
  fscrypt: allow deleting files with unsupported encryption policy

 fs/crypto/fname.c           |  8 +++-
 fs/crypto/fscrypt_private.h | 28 ++++++++++++++
 fs/crypto/hooks.c           | 16 +++++++-
 fs/crypto/keysetup.c        | 20 ++++++++--
 fs/crypto/policy.c          | 22 +++++++----
 fs/ext4/dir.c               | 16 ++------
 fs/ext4/namei.c             | 10 +----
 fs/f2fs/dir.c               | 10 +----
 fs/ubifs/dir.c              | 11 +-----
 include/linux/fscrypt.h     | 75 +++++++++++++++++++------------------
 10 files changed, 126 insertions(+), 90 deletions(-)


base-commit: 4a4b8721f1a5e4b01e45b3153c68d5a1014b25de
-- 
2.29.2

