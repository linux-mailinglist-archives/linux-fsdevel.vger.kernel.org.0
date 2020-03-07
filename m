Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEA17CB34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 03:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCGCgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 21:36:35 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53588 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCGCge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:36:34 -0500
Received: by mail-pg1-f201.google.com with SMTP id c33so2497210pgl.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 18:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hL4QYmipQbbtBF3hqX0FdDc0KzQVh/PklVg+OKiKB0c=;
        b=fH4KDebpx8sfR/ExNItOLzsNNZbzuWPMaFA6X0gtKuiYWaa3VS/gCqm9U3BgcKI1kG
         e7/FD5PABlXZvNRNPlaiyvNYxjH7MJXMmOpwXyefWgZjzeJtvh26HfJuAjFe7Yy9lOA1
         t2TLyoLjiSbm5QKizkXqoTTxJuK4yPWtNqNJRJK26GNzaWFtpT4tlAJTLhqIhRhPxHpU
         4WYWqBTcoH+Bl6qgJCQ7uHhzGnrfa3KaK30WACW8WGDTDkP8dSqvFw1QpLKEpoGjkE21
         A1Z2i6nYM+2DB8zOPZiduwEW9dh0TwsUMvd2rF/qkovCw+rOowod48n/BhxsW34sUgWH
         3qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hL4QYmipQbbtBF3hqX0FdDc0KzQVh/PklVg+OKiKB0c=;
        b=Xj47gyaerV/Zmia0MVxY3EXQNq5AfB3C8mtl9ZHabz0GR6+y26IVfMdYMUBbUK5QlM
         yZuO3Yzb8NaCZDBguZCTV3WgwkYuR5NLKb6smRq41GeBMSz1MfHtBdX57xDQa4NOIXfH
         TL3uDdoZbYAz1u6RZgsfNAKa5d4ppgBncHauKny/8Kpkx3uPrFBwi1mfMlXqPIRW+0oU
         UBs+tQIUfgbWSZ9mPwVdKki6irz1ejY7eRjAYSG0CJuVYCs3rt9/22BFhNcXQE2/VJNu
         /YHNNRUlGVDfQPMe5Vv2p3t2Hw7vlYO83fY49NoUR3WD5/Xg+vwhdgMkvlay2LIs8TyO
         NmDQ==
X-Gm-Message-State: ANhLgQ0sr75JWck0GCk75FOO6vyOYf3rdVbKd1/lNEsHVWfxDYzxGe5n
        r0WTKGErfilKaoYX4HSceDAMPHX+O5Q=
X-Google-Smtp-Source: ADFU+vvinrVh+l8QTv3HIUiABuCgsyoBanuoKAxU/xc+BcTv2eFzH5SpHBDbPai696SnQnmC+kbjhJ4IF6o=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr6425637pjb.89.1583548593063;
 Fri, 06 Mar 2020 18:36:33 -0800 (PST)
Date:   Fri,  6 Mar 2020 18:36:03 -0800
Message-Id: <20200307023611.204708-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 0/8] Support for Casefolding and Encryption
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

I've left off the Ext4 patches that enable casefolding and ecryption from
this revision since they still need some fixups, and I haven't gotten around
to the fsck changes yet.

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

v8 changes:
Fixed issue with non-strict_mode fallback for hashing dentry op
Fixed potential RCU/unicode issue in casefolding dentry_ops.
Split "fscrypt: Have filesystems handle their d_ops" into a few smaller patches
Switched ubifs change to also use the dentry op function added in libfs.c
Added hash function in fs/unicode
changed super_block s_encoding_flags to u16. Didn't make unsigned int since
both filesystems using them use them as 16 bits, and want to avoid possible
confusion. Wouldn't really be opposed to that change though
Added kernel doc comments
misc other small adjustments
TODO:
 Investigate moving to a dentry flag to check for casefolding, or otherwise
 conditionally setting the casefolding dentry ops as needed, like fscrypt.
 Currently not done due to some issues with cached negative dentries and
 toggling casefolding on an empty directory.

 Ext4 fsck changes/debugging ext4 patches


v7 changes:
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
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support
  fscrypt: Export fscrypt_d_revalidate
  libfs: Add generic function for setting dentry_ops
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption

 fs/crypto/fname.c           |   7 +-
 fs/crypto/fscrypt_private.h |   1 -
 fs/crypto/hooks.c           |   1 -
 fs/ext4/dir.c               |  51 -----------
 fs/ext4/ext4.h              |  16 ----
 fs/ext4/hash.c              |   2 +-
 fs/ext4/namei.c             |  21 ++---
 fs/ext4/super.c             |  15 ++--
 fs/f2fs/dir.c               | 127 +++++++++++-----------------
 fs/f2fs/f2fs.h              |  18 +---
 fs/f2fs/hash.c              |  27 ++++--
 fs/f2fs/inline.c            |   9 +-
 fs/f2fs/namei.c             |   1 +
 fs/f2fs/super.c             |  17 ++--
 fs/f2fs/sysfs.c             |  10 ++-
 fs/libfs.c                  | 164 ++++++++++++++++++++++++++++++++++++
 fs/ubifs/dir.c              |   1 +
 fs/unicode/utf8-core.c      |  23 ++++-
 include/linux/f2fs_fs.h     |   3 -
 include/linux/fs.h          |  24 ++++++
 include/linux/fscrypt.h     |   6 +-
 include/linux/unicode.h     |   3 +
 22 files changed, 321 insertions(+), 226 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

