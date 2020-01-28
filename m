Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A114ADBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA1Btr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgA1Btr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:49:47 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171B6214AF;
        Tue, 28 Jan 2020 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580176186;
        bh=LG/91wYLxxcYT1svtlzLQ/c/hCjXKTZSNlbksK28KB8=;
        h=Date:From:To:Cc:Subject:From;
        b=O1F0TfY1lPK6UDP2+cAy1qiAe5gEdKKYy0ffpzRZKA6oCncfLoLhWr1QrWxf7ooi5
         HL4jFb0D2IC39TmP0BOa2trGbZYvJJ4O5lDnJJZFdddcuERLlqKFMkhjVIRBAO1muy
         oUfSt9noSUuHQmMW4oTq+ajZAVYQ8yqB791BiJ48=
Date:   Mon, 27 Jan 2020 17:49:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [GIT PULL] fsverity updates for 5.6
Message-ID: <20200128014944.GB960@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to da3a3da4e6c68459618a1043dcb12b450312a4e2:

  fs-verity: use u64_to_user_ptr() (2020-01-14 13:28:28 -0800)

----------------------------------------------------------------

- Optimize fs-verity sequential read performance by implementing
  readahead of Merkle tree pages.  This allows the Merkle tree to be
  read in larger chunks.

- Optimize FS_IOC_ENABLE_VERITY performance in the uncached case by
  implementing readahead of data pages.

- Allocate the hash requests from a mempool in order to eliminate the
  possibility of allocation failures during I/O.

----------------------------------------------------------------
Eric Biggers (4):
      fs-verity: implement readahead for FS_IOC_ENABLE_VERITY
      fs-verity: implement readahead of Merkle tree pages
      fs-verity: use mempool for hash requests
      fs-verity: use u64_to_user_ptr()

 fs/ext4/verity.c             | 47 ++++++++++++++++++++-
 fs/f2fs/data.c               |  2 +-
 fs/f2fs/f2fs.h               |  3 ++
 fs/f2fs/verity.c             | 47 ++++++++++++++++++++-
 fs/verity/enable.c           | 67 +++++++++++++++++++++++-------
 fs/verity/fsverity_private.h | 17 +++++---
 fs/verity/hash_algs.c        | 98 +++++++++++++++++++++++++++++++++-----------
 fs/verity/open.c             |  5 ++-
 fs/verity/verify.c           | 47 ++++++++++++++-------
 include/linux/fsverity.h     |  7 +++-
 10 files changed, 273 insertions(+), 67 deletions(-)

