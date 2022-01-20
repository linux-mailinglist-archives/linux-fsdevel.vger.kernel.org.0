Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C84494807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358941AbiATHQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358745AbiATHQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D513C061574;
        Wed, 19 Jan 2022 23:16:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46E2AB81CEC;
        Thu, 20 Jan 2022 07:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B753EC340E0;
        Thu, 20 Jan 2022 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662974;
        bh=YfVf7rAvgCs/3ET6tKl91x/+y+054s6VdI88iVi2crE=;
        h=From:To:Cc:Subject:Date:From;
        b=PAlOlzacCH2/P3OqiqE/xQAyMQxkbvDpWWaF3mSbkECHkWdbNB3Pkfhdi7TgkKZM4
         BFoV7ewBtSy2vNip6LmTlBCekvL4uPu07h+n/AoifvoAD3TpvOz+VfTz8In8lj7Hyk
         o1PD5/yFkvRk3bbYrx5PbtceEkvBJiAMrM0pJXgKYT45Hy7A9wCjlsOwtEDL/nM4RQ
         kmp9owsKM1ed0iN5+iFWARjZCq1fe9exZMZEGFBi2IbYD463R2L8iFu5eqmiSSSEgf
         pZB3oCs7fKv4fJ6/eABBNsOWdfaE5RZ02o2lZEKPi1GW2xs0kgblUGLGx4JVArZH3x
         vWGUG/jsWCi+w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH v10 0/5] add support for direct I/O with fscrypt using blk-crypto
Date:   Wed, 19 Jan 2022 23:12:10 -0800
Message-Id: <20220120071215.123274-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

This series adds support for this.  There are multiple use cases for DIO
on encrypted files, but avoiding double caching on loopback devices
located in an encrypted directory is the main one currently.

Previous versions of this series were sent out by Satya Tangirala.
I've cleaned up a few things since Satya's last version, v9
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

I plan to propose a new generic ioctl to address the issue of DIO
constraints being insufficiently discoverable.  But until then, I'm
wondering if people are willing to consider this patchset again, or
whether it is considered blocked by this issue alone.  (And if this
patchset is still unacceptable, would it be acceptable with f2fs support
only, given that f2fs *already* only allows FS block size aligned DIO?)

Eric Biggers (5):
  fscrypt: add functions for direct I/O support
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 25 +++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 90 +++++++++++++++++++++++++++
 fs/ext4/file.c                        | 10 +--
 fs/ext4/inode.c                       |  7 +++
 fs/f2fs/data.c                        |  7 +++
 fs/f2fs/f2fs.h                        |  6 +-
 fs/iomap/direct-io.c                  |  6 ++
 include/linux/fscrypt.h               | 18 ++++++
 9 files changed, 170 insertions(+), 7 deletions(-)


base-commit: 1d1df41c5a33359a00e919d54eaebfb789711fdc
-- 
2.34.1

