Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF818131EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 06:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgAGFQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 00:16:47 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:47599 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgAGFQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:16:47 -0500
Received: by mail-ua1-f74.google.com with SMTP id b18so9246494uap.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 21:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cfX1tvKpjBFaGwVknnvW2VBwxewGwbcoGgPS02CBSEM=;
        b=Q40BGR+McgMbCgqtKK+XRsRmJJBj/BH4LjOY1inQamlLz1Onc25gJfKSbGCbLp3BV6
         kKbmIcg1Qs8OlNWNQNQVhlpP5eQeWpb8bdcg/T1uA1M21Nwy3AmiDfyWJt0tvnczfV4l
         F5+GHxcTVIFp5EjxqoKHbB5BR5AscstZMpWufBT8/BJSWPsoka2tUFUerrjyIkmcUjjK
         wZ3VxyoNX/QvFD5IuLtoVSHr99qrCNN1Y+s01aUz0lsnsY4sqo6j8cw1VnQNt7bNfDGH
         /9+qGi2HEFX3SqvMkNy9rSPpAhx5BvUPP3MMTK/c1L92gGjvYGn+U5QaEIouLcVwROXe
         FVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cfX1tvKpjBFaGwVknnvW2VBwxewGwbcoGgPS02CBSEM=;
        b=G4+FbT9tesKaO8oVkTEnvhQUYxlMRcpvoZ5XEF/IILLnWh1gF5ZN63143vFRNw0v1J
         STPUXIh5GkNsECw+f4busEn9FSAs0AxAFvP4d+wYY8QnLWq7G3LpFGhb1tylGIQwsuP2
         n9FcUalpLMxkSXc6bCHM4wXwpNjZ6sithOt2FfCDqGtpM7TROwG8fik2KhFWUqVeRAgH
         2kdUSSNkXtIBrnelSEBtB1NHSE+CqrzXKhMYSuWwYmcwjugSqrHNc9u27xB4wl4FkTFS
         186hxrw4pglLgdhP7OXC48rb45JwHqE7hO19fMcIGFcj6gt6xQTysZKB5UoJNjIY4eJT
         o0gw==
X-Gm-Message-State: APjAAAU9eAr1yQ3seAnySanj9nKC600YiqFmB+ss0rLR+j7LrZfdl0vU
        /NJDY51wXoUS0qhZgfc0+pGc/u68Vzs=
X-Google-Smtp-Source: APXvYqzc67czlLj1xc/BSkQkduLdtiKKbLVUdrPq7hUPjUVp5UmYvrkDtchUfmBzIECNLQOquU+7Qzeor7M=
X-Received: by 2002:a1f:8d57:: with SMTP id p84mr56402733vkd.65.1578374205529;
 Mon, 06 Jan 2020 21:16:45 -0800 (PST)
Date:   Mon,  6 Jan 2020 21:16:32 -0800
Message-Id: <20200107051638.40893-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/6] Support for Casefolding and Encryption
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
need to adjust their respective fsck's, although without access to the keys,
they won't be able to verify the hashes of casefolded and encrypted names.

changes:
fscrypt moved to separate thread to rebase on fscrypt dev branch
addressed feedback, plus some minor fixes

Daniel Rosenberg (6):
  TMP: fscrypt: Add support for casefolding with encryption
  vfs: Fold casefolding into vfs
  f2fs: Handle casefolding with Encryption
  ext4: Use struct super_blocks' casefold data
  ext4: Hande casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/crypto/Kconfig                            |   1 +
 fs/crypto/fname.c                            | 234 ++++++++++---
 fs/crypto/fscrypt_private.h                  |   9 +
 fs/crypto/keysetup.c                         |  32 +-
 fs/crypto/policy.c                           |  45 ++-
 fs/dcache.c                                  |  28 ++
 fs/ext4/dir.c                                |  75 +----
 fs/ext4/ext4.h                               |  87 +++--
 fs/ext4/hash.c                               |  26 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 ++-
 fs/ext4/namei.c                              | 326 ++++++++++++-------
 fs/ext4/super.c                              |  21 +-
 fs/f2fs/dir.c                                | 114 +++----
 fs/f2fs/f2fs.h                               |  14 +-
 fs/f2fs/hash.c                               |  25 +-
 fs/f2fs/inline.c                             |   9 +-
 fs/f2fs/super.c                              |  17 +-
 fs/f2fs/sysfs.c                              |   8 +-
 fs/inode.c                                   |   7 +
 fs/namei.c                                   |  41 ++-
 include/linux/fs.h                           |  10 +
 include/linux/fscrypt.h                      |  96 ++----
 include/linux/unicode.h                      |  14 +
 25 files changed, 835 insertions(+), 477 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

