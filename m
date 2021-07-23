Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEF3D35FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhGWHVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 03:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHVS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6103860EBD;
        Fri, 23 Jul 2021 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627027312;
        bh=oOvAR2cpP4N+IlYWG7PQAEk7l4EUjRNyF8VQm9+XWm0=;
        h=From:To:Cc:Subject:Date:From;
        b=rGZ451b8BYlFUgtRqyQvN0bu/Jv2a4yopo6hwEgS1DDE5IV3TX+vwsryStWncHf0N
         kd4/A0MkoEsV7/CHQBK1IlpW6arLDIkeXx6Eb1DQ77w7teI4L9ucZ5ldaeGBwSuTOU
         KNhMKWzGUBVZZR6khT7Wa6aDXv02V309PDUxvqybh4lz8GpXc/FAAM2CrLlju+j2yx
         R7S3Jd3FXjEdJXuBWvLKXeyBK88VgT2UDjP0SrVhUYL/jrsnQ9JGTR61gQAL8djLaL
         JLUaUrTjiZDsb+K8+6F9IFTIlG3UnSFwMoBJBPTQo/K+pHhXCvhMP15aHXkUwjZSDW
         YJ+ZRn7XYRvJg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH v2 0/2] f2fs: use iomap for direct I/O
Date:   Fri, 23 Jul 2021 00:59:19 -0700
Message-Id: <20210723075921.166705-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series makes f2fs use the iomap direct I/O implementation instead
of the fs/direct-io.c one.  In order to do this, it adds f2fs_iomap_ops,
since this is the first use of iomap in f2fs.

The iomap direct I/O implementation is more efficient than
fs/direct-io.c.  Switching to iomap also avoids the need to add new
features and optimizations to the old implementation; e.g., see
https://lore.kernel.org/r/20200710053406.GA25530@infradead.org and
https://lore.kernel.org/r/YKJBWClI7sUeABDs@infradead.org.

Patch 1 adds f2fs_iomap_ops, and patch 2 switches direct I/O reads and
writes to iomap.

Careful review is appreciated, as I'm not an expert in all areas here.

This series applies to commit 0de0db9b033a of f2fs.git#dev
(https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev).

Changed since v1:
   - Dropped the preparatory cleanups/fixes for f2fs_file_write_iter(),
     since they have been applied.
   - Merged the last three patches into one.
   - Implemented iomap_dio_ops::end_io() and switched to
     __iomap_dio_rw() to simplify updating of f2fs's in-flight DIO
     counters, as suggested by Christoph.

Eric Biggers (2):
  f2fs: implement iomap operations
  f2fs: use iomap for direct I/O

 fs/f2fs/Kconfig |   1 +
 fs/f2fs/data.c  | 260 +++++++++---------------------------
 fs/f2fs/f2fs.h  |  22 +--
 fs/f2fs/file.c  | 346 ++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 370 insertions(+), 259 deletions(-)


base-commit: 0de0db9b033af99f494c9ee4a2c9bac6456da1eb
-- 
2.32.0

