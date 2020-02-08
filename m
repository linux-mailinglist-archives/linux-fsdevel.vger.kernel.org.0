Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3C156247
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 02:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBHBep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 20:34:45 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46632 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBHBep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 20:34:45 -0500
Received: by mail-pg1-f201.google.com with SMTP id f5so779124pgn.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 17:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=;
        b=ZzptqxUsermKYJMyiUDjvBiGxUIdwqTzJfy+wNJraQ/fqxPgGbS6BGRKrTpYZT99NP
         LQVDbxgl6rqVunRCW0ICPGiKpNThIj+TdvQ5TjjeSLkpDlJtuWqpEnxBlBrS2HEtG+RW
         9z2HN6g50wLJeFY9fmYqHHVVeKmyWOB0q7ii4xnMViegdwpFM70+FfqSZe7YAxDz9qPz
         rQI68XvesZcSELHJhYuD8Anx5KlcByOodivzB6VfODhyuo8qsoR7iOlqkI0zS2IW8J1A
         G74nrd0ARErEc3uP+liYKFfxifqkv4AUuLVaYmPTGE7ECQxADA+maD2kLEzIxEDZMkLy
         HKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GmdJt27134kNRYXiKp4wrB+O4TXMZQXM52BZBGOfEtM=;
        b=KvBb2F/uHN+AfsSWsmOX1X3G6yWU6oaznOs1ny9RS6+cbmXCqNNcJ024FdBGhrCL0r
         MyFTx9EkjLgh6aw0cd9Y3dePVyrMse2x8AImUdJIuMGNGpEeMFSNfWad75Tc7JPhkp8c
         xrJlJz4XqhLQWVB+/mVC16kTEPOcXisey4nEoYgSSZRU62w8xWtsllaG1OAR72N7j7N9
         i1UdQU0zobL5DGcbgi6ixNktrN85uSXncuZhHzWiSUrzzLXWzKXJohW+xEGgcYiTNi3U
         7a4GSA7n6Ad4ZMjPNyBkyRM1IJoVMOq60midlrRZKZexqd7B5+0AEDblV4GAqaQVZjJ0
         mPVQ==
X-Gm-Message-State: APjAAAXnzsLQHotPX1S+4TQ5fGuY6x66YtFBwMya67mdrmVXJQQuYH/8
        U89E4o6SSPfUV4DV3X50H5BbtFUf6Gw=
X-Google-Smtp-Source: APXvYqxT2SICJR0/scVLMtmD7Drj2JGcZpB0cicjSWB5iCPIziOWFDKhaM/J3laVncF61b47rtO91OtcfaA=
X-Received: by 2002:a63:1c1d:: with SMTP id c29mr2121466pgc.14.1581125684457;
 Fri, 07 Feb 2020 17:34:44 -0800 (PST)
Date:   Fri,  7 Feb 2020 17:34:30 -0800
Message-Id: <20200208013438.240137-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 0/8] Support fof Casefolding and Encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are all on top of torvalds/master

Ext4 and F2FS currently both support casefolding and encryption, but not at
the same time. These patches aim to rectify that.

I moved the identical casefolding dcache operations for ext4 and f2fs into
fs/libfs.c, as all filesystems using casefolded names will want them.

I've also adjust fscrypt to not set it's d_revalidate operation during it's
prepare lookup, instead having the calling filesystem set it up. This is
done to that the filesystem may have it's own dentry_operations. Also added
a helper function in libfs.c that will work for filesystems supporting both
casefolding and fscrypt.

For Ext4, since the hash for encrypted casefolded directory names cannot be
computed without the key, we need to store the hash on disk. We only do so
for encrypted and casefolded directories to avoid on disk format changes.
Previously encryption and casefolding could not be on the same filesystem,
and we're relaxing that requirement. F2fs is a bit more straightforward
since it already stores hashes on disk.

I've updated the related tools with just enough to enable the feature. I
still need to adjust ext4's fsck's, although without access to the keys,
neither fsck will be able to verify the hashes of casefolded and encrypted
names.

v7 chances:
Moved dentry operations from unicode to libfs, added new iterator function
to unicode to allow this.
Added libfs function for setting dentries to remove code duplication between
ext4 and f2fs.

v6 changes:
Went back to using dentry_operations for casefolding. Provided standard
implementations in fs/unicode, avoiding extra allocation in d_hash op.
Moved fscrypt d_ops setting to be filesystem's responsibility to maintain
compatibility with casefolding and overlayfs if casefolding is not used
fixes some f2fs error handling

v4-5: patches submitted on fscrypt

v3 changes:
fscrypt patch only creates hash key if it will be needed.
Rebased on top of fscrypt branch, reconstified match functions in ext4/f2fs

v2 changes:
fscrypt moved to separate thread to rebase on fscrypt dev branch
addressed feedback, plus some minor fixes


Daniel Rosenberg (8):
  unicode: Add utf8_casefold_iter
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption
  ext4: Hande casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/crypto/fname.c                            |   7 +-
 fs/crypto/fscrypt_private.h                  |   1 -
 fs/crypto/hooks.c                            |   1 -
 fs/ext4/dir.c                                |  78 +----
 fs/ext4/ext4.h                               |  93 ++++--
 fs/ext4/hash.c                               |  26 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 ++-
 fs/ext4/namei.c                              | 325 ++++++++++++-------
 fs/ext4/super.c                              |  21 +-
 fs/f2fs/dir.c                                | 127 +++-----
 fs/f2fs/f2fs.h                               |  15 +-
 fs/f2fs/hash.c                               |  25 +-
 fs/f2fs/inline.c                             |   9 +-
 fs/f2fs/namei.c                              |   1 +
 fs/f2fs/super.c                              |  17 +-
 fs/f2fs/sysfs.c                              |  10 +-
 fs/libfs.c                                   | 127 ++++++++
 fs/ubifs/dir.c                               |  18 +
 fs/unicode/utf8-core.c                       |  25 +-
 include/linux/f2fs_fs.h                      |   3 -
 include/linux/fs.h                           |  24 ++
 include/linux/fscrypt.h                      |   6 +-
 include/linux/unicode.h                      |  10 +
 25 files changed, 671 insertions(+), 371 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

