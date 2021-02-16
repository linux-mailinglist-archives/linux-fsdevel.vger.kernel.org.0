Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383E131CF1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhBPRck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhBPRb6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:31:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C504D64DA1;
        Tue, 16 Feb 2021 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613496677;
        bh=mXnJDdFhDKnuB4BfSnRg55qq72NgQAWh/t0zlWZx1ac=;
        h=Date:From:To:Cc:Subject:From;
        b=drZ2I17AtuopvjlB/V3/59+15qqq0Fx5jdgKbl/5GigP2LPzOJc1m3ojlytCR8Gfi
         lkfbPmltxTG7V8pADiWoPwoMrxKyocNpF5vBvz4AePysb7acjSyXwQWb0duYJdbw/C
         1EACbnbvix33Il1O62ICyquCoPmhapOrhIgPAcCmhdaUJh/wY9nqHrF7Mkiy9WNj8m
         twdc2UEE6l0FZfFLad292feM5Htv70EoKCeRcpEgkvzYILbYQNiH+w5IaxA0BvoKjG
         ZHMvnMlMTLA5VLbXn29PJMGVi0Baq0xejVYPwAmUm1aOTPv3YKo1GFbRjTRRUE+C75
         6jHbe1WXaZ2QQ==
Date:   Tue, 16 Feb 2021 09:31:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [GIT PULL] fsverity updates for 5.12
Message-ID: <YCwBY/FsxEsnI0M/@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 07c99001312cbf90a357d4877a358f796eede65b:

  fs-verity: support reading signature with ioctl (2021-02-07 14:51:19 -0800)

----------------------------------------------------------------

Add an ioctl which allows reading fs-verity metadata from a file.

This is useful when a file with fs-verity enabled needs to be served
somewhere, and the other end wants to do its own fs-verity compatible
verification of the file.  See the commit messages for details.

This new ioctl has been tested using new xfstests I've written for it.

----------------------------------------------------------------
Eric Biggers (6):
      fs-verity: factor out fsverity_get_descriptor()
      fs-verity: don't pass whole descriptor to fsverity_verify_signature()
      fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
      fs-verity: support reading Merkle tree with ioctl
      fs-verity: support reading descriptor with ioctl
      fs-verity: support reading signature with ioctl

 Documentation/filesystems/fsverity.rst |  76 +++++++++++++
 fs/ext4/ioctl.c                        |   7 ++
 fs/f2fs/file.c                         |  11 ++
 fs/verity/Makefile                     |   1 +
 fs/verity/fsverity_private.h           |  13 ++-
 fs/verity/open.c                       | 133 ++++++++++++++--------
 fs/verity/read_metadata.c              | 195 +++++++++++++++++++++++++++++++++
 fs/verity/signature.c                  |  20 +---
 include/linux/fsverity.h               |  12 ++
 include/uapi/linux/fsverity.h          |  14 +++
 10 files changed, 417 insertions(+), 65 deletions(-)
 create mode 100644 fs/verity/read_metadata.c
