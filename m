Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B61E9E35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgFAG3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 02:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFAG3D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:29:03 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984C62074B;
        Mon,  1 Jun 2020 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590992942;
        bh=1+HgUI0i7fD04WdwIoS+2wnOjK8xL00OVCgY/EpDx+k=;
        h=Date:From:To:Cc:Subject:From;
        b=MVHaz8NKfknh3A0lNcT3nJFyTOEe5L8m03Pcsrk9fJegee57FJh4GsxGwfBuXsCt7
         EEKaPXfr+/SBUG57z7bDRJTyN066lYEVel0r9o+D6IPFtwiHAcxXa3ETpYnJ1/RY+O
         EAFX2wU0xM9B3cxEdLcx07R/QyByhcXKANim49yM=
Date:   Sun, 31 May 2020 23:28:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.8
Message-ID: <20200601062848.GA11054@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to e3b1078bedd323df343894a27eb3b3c34944dfd1:

  fscrypt: add support for IV_INO_LBLK_32 policies (2020-05-19 09:34:18 -0700)

----------------------------------------------------------------

- Add the IV_INO_LBLK_32 encryption policy flag which modifies the
  encryption to be optimized for eMMC inline encryption hardware.

- Make the test_dummy_encryption mount option for ext4 and f2fs support
  v2 encryption policies.

- Fix kerneldoc warnings and some coding style inconsistencies.

There will be merge conflicts with the ext4 and f2fs trees due to the
test_dummy_encryption change, but the resolutions are straightforward.

----------------------------------------------------------------
Eric Biggers (8):
      fscrypt: fix all kerneldoc warnings
      fscrypt: name all function parameters
      fscrypt: remove unnecessary extern keywords
      linux/parser.h: add include guards
      fscrypt: add fscrypt_add_test_dummy_key()
      fscrypt: support test_dummy_encryption=v2
      fscrypt: make test_dummy_encryption use v2 by default
      fscrypt: add support for IV_INO_LBLK_32 policies

 Documentation/filesystems/f2fs.rst    |   6 +-
 Documentation/filesystems/fscrypt.rst |  33 +++++-
 fs/crypto/crypto.c                    |  15 ++-
 fs/crypto/fname.c                     |  52 ++++++---
 fs/crypto/fscrypt_private.h           | 111 +++++++++---------
 fs/crypto/hooks.c                     |   4 +-
 fs/crypto/keyring.c                   | 122 ++++++++++++-------
 fs/crypto/keysetup.c                  | 109 ++++++++++++-----
 fs/crypto/policy.c                    | 195 ++++++++++++++++++++++++++++---
 fs/ext4/ext4.h                        |   7 +-
 fs/ext4/super.c                       |  68 ++++++++---
 fs/ext4/sysfs.c                       |   2 +
 fs/f2fs/f2fs.h                        |   4 +-
 fs/f2fs/super.c                       |  85 ++++++++++----
 fs/f2fs/sysfs.c                       |   4 +
 include/linux/fscrypt.h               | 214 ++++++++++++++++++++--------------
 include/linux/parser.h                |   5 +-
 include/uapi/linux/fscrypt.h          |   3 +-
 18 files changed, 737 insertions(+), 302 deletions(-)
