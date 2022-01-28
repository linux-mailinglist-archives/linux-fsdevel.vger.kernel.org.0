Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881E4A044F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351786AbiA1XkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 18:40:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiA1XkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:40:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB4B61AB2;
        Fri, 28 Jan 2022 23:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D88C340E7;
        Fri, 28 Jan 2022 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413201;
        bh=A+dIr2ya4MfZD/2VpyiH8hHHsI4LewYXA+Fa5Nd6nXE=;
        h=From:To:Cc:Subject:Date:From;
        b=oQ4bHp0cWtAcolXJh+d8nqrKSLLjskoIRBUKOWvODAPFP7wcQ9jurmCAhgcPofhLY
         zFY2HkXWsOpdPkoUpUy3IirMcDmt6/V7JxtzYTAPQqEYV/dUjp13waVjBFGQauCiDG
         SHe4xAaSKUlMwcN5ZdDbp+YNrLzxbGkCISz2YOnaBbGKhuiGC4k0VV/RBWXDXLH8IB
         F+Ejz6t7SEW55Zz9Mtms+95THWoeO/SHlpBwDQTEU15LE689E8KpzwGJbOomnzWKjx
         GCHhSOZwWPch1yat38XkIeOAS8nUd3SsHWV44H04hT6Ewhcbe1GVNzxt9ZkertSoSm
         A+fig0YaH6efw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v11 0/5] add support for direct I/O with fscrypt using blk-crypto
Date:   Fri, 28 Jan 2022 15:39:35 -0800
Message-Id: <20220128233940.79464-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Note: I'm planning to send a patchset adding STATX_DIRECTIO as was
discussed on v10, but that will be a separate patchset.]

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

This series adds support for this.  There are multiple use cases for DIO
on encrypted files, but avoiding double caching on loopback devices
located in an encrypted directory is the main one currently.

v1 through v9 of this series were sent out by Satya Tangirala.  I've
cleaned up a few things since Satya's last version
(https://lore.kernel.org/all/20210604210908.2105870-1-satyat@google.com/T/#u).
But more notably, I've made a couple simplifications.

First, since f2fs has now been converted to use iomap for DIO, I've
dropped the patch which added fscrypt support to fs/direct-io.c.

Second, I've returned to the original design where DIO requests must be
fully aligned to the FS block size in terms of file position, length,
and memory buffers.  Satya previously was pursuing a slightly different
design, where the memory buffers (but not the file position and length)
were allowed to be aligned to just the block device logical block size.
This was at the request of Dave Chinner on v4 and v6 of the patchset
(https://lore.kernel.org/linux-fscrypt/20200720233739.824943-1-satyat@google.com/T/#u
and
https://lore.kernel.org/linux-fscrypt/20200724184501.1651378-1-satyat@google.com/T/#u).

I believe that approach is a dead end, for two reasons.  First, it
necessarily causes it to be possible that crypto data units span bvecs.
Splits cannot occur at such locations; however the block layer currently
assumes that bios can be split at any bvec boundary.  Changing that is
quite difficult, as Satya's v9 patchset demonstrated.  This is not an
issue if we require FS block aligned buffers instead.  Second, it
doesn't change the fact that FS block alignment is still required for
the file position and I/O length; this is unavoidable due to the
granularity of encryption being the FS block size.  So, it seems that
relaxing the memory buffer alignment requirement wouldn't make things
meaningfully easier for applications, which raises the question of why
we would bother with it in the first place.

Christoph Hellwig also said that he much prefers that fscrypt DIO be
supported without sector-only alignment to start:
https://lore.kernel.org/r/YPu+88KReGlt94o3@infradead.org

Given the above, as far as I know the only remaining objection to this
patchset would be that DIO constraints aren't sufficiently discoverable
by userspace.  Now, to put this in context, this is a longstanding issue
with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
not specific to this feature, and it doesn't actually seem to be too
important in practice; many other filesystem features place constraints
on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
(And for better or worse, many systems using fscrypt already have
out-of-tree patches that enable DIO support, and people don't seem to
have trouble with the FS block size alignment requirement.)

To address the issue of DIO constraints being insufficiently
discoverable, I plan to make statx() expose this information.

This series applies to v5.17-rc1.

Changed v10 => v11:
  * Changed fscrypt_dio_unsupported() back to fscrypt_dio_supported().
  * Removed a mention of f2fs from fscrypt_dio_supported().
  * Added Reviewed-by and Acked-by tags, including a couple from earlier
    I had dropped due to the renaming of fscrypt_dio_supported().
  * In fscrypt_limit_io_blocks(), don't load i_crypt_info until it's
    known to be valid, to avoid confusion as is done elsewhere.

Eric Biggers (5):
  fscrypt: add functions for direct I/O support
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 25 ++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 93 +++++++++++++++++++++++++++
 fs/ext4/file.c                        | 10 +--
 fs/ext4/inode.c                       |  7 ++
 fs/f2fs/data.c                        |  7 ++
 fs/f2fs/f2fs.h                        |  6 +-
 fs/iomap/direct-io.c                  |  6 ++
 include/linux/fscrypt.h               | 18 ++++++
 9 files changed, 173 insertions(+), 7 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.35.0

