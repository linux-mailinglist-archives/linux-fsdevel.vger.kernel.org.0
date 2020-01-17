Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83250141347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 22:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgAQVmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 16:42:55 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46749 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgAQVmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:42:55 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so11391325plr.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 13:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yBEf4c2Y/V+ZNwnYQzLFCcZKpZySQQ5dJ9X0QGzY9eo=;
        b=hrp+gp+g8aB/jpumGkpuc5F5wkzC/eegSUgKsuaP5vuBUKLF33qoqqM2MafIuVh9s1
         jI2A1GYFMvU+zXn/tCLnmGXTqm3p0Gd4ZJGvWkGqgwBJx9K3w5rosKRTKFkLyeVpf7r7
         WFGq/cvvGa0UIt89Z8qEnh4tUigSQ7k5T7oowlnUjWNYSj1q2cLitkSLMyMd0jkKCkAD
         anxNB8ZROhRvpyrX/Yj82zl81n9GScBR9YTXGVMqHu3OoPibEEExYkK8+hQXWp7bAWgy
         5hmPB7B0i/vXCHN1gPjV6lJhuK5oImOVpW8qPq4w+BW8SnU9RkZI5NRwJt35MaEoucrI
         kOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yBEf4c2Y/V+ZNwnYQzLFCcZKpZySQQ5dJ9X0QGzY9eo=;
        b=itTQ1tkBLwWzZJ0I2hmwCLJzdxh1HaEmna7Yf3rEyWMplOUSncAkc2bVyg5bz2s64g
         TxBXrHLD1nxo94c5A2wq6Z1CeMtaLjG1EkZ6mUMf+EM7pTyQA3jWxAiuHPD9+R5fs7fo
         UGDjO5GmDV3ZwxOl/bH5mQIdhBXf4PCUkzZYoL1cpPWaPrMN2nItoBCtyc3fitJ+IFlK
         kuIrUY3qsGqjOL6bTu3Ap/IPFopZVbE3aRqmjIDv2EoSAE5JY9FpIk8jsDbEGtNkIrhv
         tJ0XWUi+88hzTs2AZW5NncAaK6txBovM534tPNsJPGubZ1W6sZpp+ykcPGVg+B5giBcT
         4Fqw==
X-Gm-Message-State: APjAAAVudR4bYntd8qFGS8H04SA4NbXb3vKFpf6j1pig/+NJMOIFev3F
        FDVOKs1dYRR2tBmO01s0vJZXG9VgIEY=
X-Google-Smtp-Source: APXvYqx/thRfotMiEcNYQU3muvCEizuxjwfQx4bfJuDJBpTmZngE9VJym447R2DaU34FJTWJBfRydBLRlJY=
X-Received: by 2002:a63:ff20:: with SMTP id k32mr45963088pgi.448.1579297374588;
 Fri, 17 Jan 2020 13:42:54 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:42:37 -0800
Message-Id: <20200117214246.235591-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 0/9] Support for Casefolding and Encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are all on top of fscrypt's developement branch

Ext4 and F2FS currently both support casefolding and encryption, but not at
the same time. These patches aim to rectify that.

Since directory names are stored case preserved, we cannot just take the hash
of the ciphertext. Instead we use the siphash of the casefolded name. With this
we no longer have a direct path from an encrypted name to the hash without the
key. To deal with this, fscrypt now always includes the hash in the name it
presents when the key is not present. There is a pre-existing bug where you can
change parts of the hash and still match the name so long as the disruption to
the hash does not happen to affect lookup on that filesystem. I'm not sure how
to fix that without making ext4 lookups slower in the more common case.

I moved the identical dcache operations for ext4 and f2fs into the VFS, as any
filesystem that uses casefolding will need the same code. This will also allow
further optimizations to that path, although my current changes don't take
advantage of that yet.

For Ext4, this also means that we need to store the hash on disk. We only do so
for encrypted and casefolded directories to avoid on disk format changes.
Previously encryption and casefolding could not live on the same filesystem,
and we're relaxing that requirement. F2fs is a bit more straightforward since
it already stores hashes on disk.

I've updated the related tools with just enough to enable the feature. I still
need to adjust ext4's fsck's, although without access to the keys,
neither fsck will be able to verify the hashes of casefolded and encrypted names.

v3 changes:
fscrypt patch only creates hash key if it will be needed.
Rebased on top of fscrypt branch, reconstified match functions in ext4/f2fs

v2 changes:
fscrypt moved to separate thread to rebase on fscrypt dev branch
addressed feedback, plus some minor fixes


Daniel Rosenberg (9):
  fscrypt: Add siphash and hash key for policy v2
  fscrypt: Don't allow v1 policies with casefolding
  fscrypt: Change format of no-key token
  fscrypt: Only create hash key when needed
  vfs: Fold casefolding into vfs
  f2fs: Handle casefolding with Encryption
  ext4: Use struct super_blocks' casefold data
  ext4: Hande casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/crypto/Kconfig                            |   1 +
 fs/crypto/fname.c                            | 232 ++++++++++---
 fs/crypto/fscrypt_private.h                  |   9 +
 fs/crypto/keysetup.c                         |  35 +-
 fs/crypto/policy.c                           |  53 +++
 fs/dcache.c                                  |  28 ++
 fs/ext4/dir.c                                |  75 +----
 fs/ext4/ext4.h                               |  85 +++--
 fs/ext4/hash.c                               |  26 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 +--
 fs/ext4/namei.c                              | 324 ++++++++++++-------
 fs/ext4/super.c                              |  21 +-
 fs/f2fs/dir.c                                | 112 +++----
 fs/f2fs/f2fs.h                               |  12 +-
 fs/f2fs/hash.c                               |  25 +-
 fs/f2fs/inline.c                             |   9 +-
 fs/f2fs/super.c                              |  17 +-
 fs/f2fs/sysfs.c                              |   8 +-
 fs/inode.c                                   |   3 +-
 fs/namei.c                                   |  41 ++-
 include/linux/fs.h                           |  10 +
 include/linux/fscrypt.h                      |  95 ++----
 include/linux/unicode.h                      |  14 +
 25 files changed, 835 insertions(+), 473 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

