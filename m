Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00593CB8D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbhGPOnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 10:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhGPOnh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:43:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE4D3613AF;
        Fri, 16 Jul 2021 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446442;
        bh=7TQ2wZS0o8rjARGf+YyE3LnEc8JXm7RWnWlgvVpHFQg=;
        h=From:To:Cc:Subject:Date:From;
        b=k0VWFJo3KwWNfUem7TO3aDtwyb9j6dkN+3TTCvFk7rKAri7TjWyW6iHXIneGPXQaC
         MBJFcqLytNz4Dsp//LiCCz9ULWPcKbd/qLWH3YKn/EGQV7sweVjBWLJor6w/3gGWg2
         +/b4dZrcIsGCd0L67vYfg3RnUZvZV82d3zU7AB6Kv80xG01WOtPH2idOsUNYmC57ir
         M4OFWToanQQ1UaB+t6BdYLUSG1qHfMxEkFFDmINkNoJ+h7ISXQ3nW6Sfn33BLjE/Sq
         DU9HEJ77uKQcyJ49jeQjlATWQ2iODCq7TX3NkwrFleGe1reU5lcLpgrTDSk15tTY9p
         g1R6yoPQmwmZw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH 0/9] f2fs: use iomap for direct I/O
Date:   Fri, 16 Jul 2021 09:39:10 -0500
Message-Id: <20210716143919.44373-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series makes f2fs implement direct I/O using iomap_dio_rw() instead
of __blockdev_direct_IO().  In order to do this, it adds f2fs_iomap_ops,
since this is the first use of iomap in f2fs.

The iomap direct I/O implementation is more efficient than the
fs/direct-io.c implementation.  Switching to iomap also avoids the need
to add new features and optimizations to the old implementation.  E.g.,
see https://lore.kernel.org/r/20200710053406.GA25530@infradead.org and
https://lore.kernel.org/r/YKJBWClI7sUeABDs@infradead.org.

In general, this series preserves existing f2fs behavior (such as the
conditions for falling back to buffered I/O) and is only an
implementation change.

Patches 1-5 contain cleanups and fixes for f2fs_file_write_iter().
Patch 6 adds f2fs_iomap_ops, patch 7 and 8 switch direct I/O reads and
writes to iomap, and patch 9 removes obsoleted code.

Careful review is appreciated, as I'm not an expert in all areas here.

This series has been tested with xfstests by running 'gce-xfstests -c
f2fs -g auto -X generic/017' with and without this series; no
regressions were seen.  (Some tests fail both before and after.
generic/017 hangs both before and after, so it had to be excluded.)

This series applies to v5.14-rc1.

Eric Biggers (9):
  f2fs: make f2fs_write_failed() take struct inode
  f2fs: remove allow_outplace_dio()
  f2fs: rework write preallocations
  f2fs: reduce indentation in f2fs_file_write_iter()
  f2fs: fix the f2fs_file_write_iter tracepoint
  f2fs: implement iomap operations
  f2fs: use iomap for direct I/O reads
  f2fs: use iomap for direct I/O writes
  f2fs: remove f2fs_direct_IO()

 fs/f2fs/Kconfig             |   1 +
 fs/f2fs/data.c              | 286 +++++++------------------
 fs/f2fs/f2fs.h              |  29 +--
 fs/f2fs/file.c              | 416 +++++++++++++++++++++++++++++-------
 include/trace/events/f2fs.h |  12 +-
 5 files changed, 421 insertions(+), 323 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

