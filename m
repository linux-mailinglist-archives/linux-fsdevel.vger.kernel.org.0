Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985BE1822C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgCKTsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 15:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbgCKTsm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:48:42 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6A020691;
        Wed, 11 Mar 2020 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583956122;
        bh=NTCCQBA/qngUM9vruihaGQpLvV8cowQXBnlryjh7duc=;
        h=Date:From:To:Cc:Subject:From;
        b=v/jab1Mtz7GdBG9uHSDV6k2H9A5ugStqAz7qXsT5oSvLW0R8a6a71HOmgfCea5clU
         G66Us11UI+4tNO3Dj0FH7tIcAgD6G5vzcw6dOTDobm5SYL6M1oFXxg7KIYICRZtMGR
         9CaWX6LC7nIdux3wMMCMyiTs0f5kOJR5zRFuyh0M=
Date:   Wed, 11 Mar 2020 12:48:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt fix for v5.6-rc6
Message-ID: <20200311194839.GB41227@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 2b4eae95c7361e0a147b838715c8baa1380a428f:

  fscrypt: don't evict dirty inodes after removing key (2020-03-07 18:43:07 -0800)

----------------------------------------------------------------

Fix a bug where if userspace is writing to encrypted files while the
FS_IOC_REMOVE_ENCRYPTION_KEY ioctl (introduced in v5.4) is running,
dirty inodes could be evicted, causing writes could be lost or the
filesystem to hang due to a use-after-free.  This was encountered during
real-world use, not just theoretical.

Tested with the existing fscrypt xfstests, and with a new xfstest I
wrote to reproduce this bug.  This fix does expose an existing bug with
'-o lazytime' that Ted is working on fixing, but this fscrypt fix is
more critical and is needed anyway regardless of the lazytime fix.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: don't evict dirty inodes after removing key

 fs/crypto/keysetup.c | 9 +++++++++
 1 file changed, 9 insertions(+)
