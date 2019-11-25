Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E61087F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 05:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKYElZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 23:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfKYElY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 23:41:24 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40B52071A;
        Mon, 25 Nov 2019 04:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574656884;
        bh=9h1w2qtMHzyhRb2apJD57n+fyg2uYaxC4b4cjzeRMlw=;
        h=Date:From:To:Cc:Subject:From;
        b=Tll3maaU/bz0aycxUJHNcQn/Ild1MGKfxRKmm9EgU1xzWiFVLNpmMk3JJz11CDAyL
         S/u4L35s7MUodpnyagLojBopI5S/fYQSGwSV89q/gUEcxE/1KQwVhPTelQFj+z2/5S
         y0UChR6e6WnlF8TaNOeXQYfjEe1TK7zmi+ht5pm8=
Date:   Sun, 24 Nov 2019 20:41:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.5
Message-ID: <20191125044122.GA9817@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 0eee17e3322625b87ce5fa631bda16562a8dc494:

  f2fs: add support for IV_INO_LBLK_64 encryption policies (2019-11-06 12:34:42 -0800)

----------------------------------------------------------------

- Add the IV_INO_LBLK_64 encryption policy flag which modifies the
  encryption to be optimized for UFS inline encryption hardware.

- For AES-128-CBC, use the crypto API's implementation of ESSIV (which
  was added in 5.4) rather than doing ESSIV manually.

- A few other cleanups.

----------------------------------------------------------------
Eric Biggers (8):
      fscrypt: invoke crypto API for ESSIV handling
      fscrypt: remove struct fscrypt_ctx
      fscrypt: zeroize fscrypt_info before freeing
      docs: ioctl-number: document fscrypt ioctl numbers
      fscrypt: avoid data race on fscrypt_mode::logged_impl_name
      fscrypt: add support for IV_INO_LBLK_64 policies
      ext4: add support for IV_INO_LBLK_64 encryption policies
      f2fs: add support for IV_INO_LBLK_64 encryption policies

 Documentation/filesystems/fscrypt.rst |  68 +++++++++------
 Documentation/ioctl/ioctl-number.rst  |   1 +
 fs/crypto/bio.c                       |  29 +------
 fs/crypto/crypto.c                    | 124 ++++----------------------
 fs/crypto/fscrypt_private.h           |  25 +++---
 fs/crypto/keyring.c                   |   6 +-
 fs/crypto/keysetup.c                  | 158 ++++++++++------------------------
 fs/crypto/keysetup_v1.c               |   4 -
 fs/crypto/policy.c                    |  41 ++++++++-
 fs/ext4/ext4.h                        |   2 +
 fs/ext4/super.c                       |  14 +++
 fs/f2fs/super.c                       |  26 ++++--
 include/linux/fscrypt.h               |  35 +-------
 include/uapi/linux/fscrypt.h          |   3 +-
 14 files changed, 208 insertions(+), 328 deletions(-)
