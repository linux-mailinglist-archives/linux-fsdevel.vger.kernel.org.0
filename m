Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1114341D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgATWeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 17:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgATWeR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:34:17 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FBF217F4;
        Mon, 20 Jan 2020 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579559657;
        bh=xm885UhKFUwKfgBkYWfnG/AC3Rw6vyxcGdpz/w5UOxs=;
        h=From:To:Cc:Subject:Date:From;
        b=n9BG408GF/aokCw8EG9MBQ9hJw9mAgpR6LRC5KJXhFvrUD8dUEMcz1fPCmgxfOxnK
         FYltkiqo8UTJrZL597rrakuG7LCaY6g0rVjw3rHQFWyQaaJluloPm74WLLPuT+6kjF
         HwzLBOeRmONd/Z5cEVB5lRpaCnrKE0dDiJHJ32rU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 0/6] fscrypt preparations for encryption+casefolding
Date:   Mon, 20 Jan 2020 14:31:55 -0800
Message-Id: <20200120223201.241390-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a cleaned up and fixed version of the fscrypt patches to prepare
for directories that are both encrypted and casefolded.

Patches 1-3 start deriving a SipHash key for the new dirhash method that
will be used by encrypted+casefolded directories.  To avoid unnecessary
overhead, we only do this if the directory is actually casefolded.

Patch 4 fixes a bug in UBIFS where it didn't gracefully handle invalid
hash values in fscrypt no-key names.  This is an existing bug, but the
new fscrypt no-key name format (patch 6) made it much easier to trigger;
it started being hit by 'kvm-xfstests -c ubifs -g encrypt'.

Patch 5 updates UBIFS to make it ready for the new fscrypt no-key name
format that always includes the dirhash.

Patch 6 modifies the fscrypt no-key names to always include the dirhash,
since with the new dirhash method the dirhash will no longer be
computable from the ciphertext filename without the key.  It also fixes
a longstanding issue where there could be collisions in the no-key
names, due to not using a proper cryptographic hash to abbreviate names.

For more information see the main patch series, which includes the
filesystem-specific changes:
https://lkml.kernel.org/linux-fscrypt/20200117214246.235591-1-drosen@google.com/T/#u

This applies to fscrypt.git#master.

Changed v4 => v5:
  - Fixed UBIFS encryption to work with the new no-key name format.

Daniel Rosenberg (3):
  fscrypt: don't allow v1 policies with casefolding
  fscrypt: derive dirhash key for casefolded directories
  fscrypt: improve format of no-key names

Eric Biggers (3):
  fscrypt: clarify what is meant by a per-file key
  ubifs: don't trigger assertion on invalid no-key filename
  ubifs: allow both hash and disk name to be provided in no-key names

 Documentation/filesystems/fscrypt.rst |  40 +++--
 fs/crypto/Kconfig                     |   1 +
 fs/crypto/fname.c                     | 239 ++++++++++++++++++++------
 fs/crypto/fscrypt_private.h           |  19 +-
 fs/crypto/hooks.c                     |  44 +++++
 fs/crypto/keysetup.c                  |  81 ++++++---
 fs/crypto/keysetup_v1.c               |   4 +-
 fs/crypto/policy.c                    |   7 +
 fs/inode.c                            |   3 +-
 fs/ubifs/dir.c                        |   6 +-
 fs/ubifs/journal.c                    |   4 +-
 fs/ubifs/key.h                        |   1 -
 include/linux/fscrypt.h               |  94 +++-------
 13 files changed, 365 insertions(+), 178 deletions(-)

-- 
2.25.0

