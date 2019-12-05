Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1056A114427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLEP4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:56:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:35426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLEP4h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:56:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A917AC81;
        Thu,  5 Dec 2019 15:56:35 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de
Subject: [PATCH 0/8 v3] btrfs direct-io using iomap
Date:   Thu,  5 Dec 2019 09:56:22 -0600
Message-Id: <20191205155630.28817-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

These patches are based on xfs/iomap-for-next, though I tested it
against the patches on xfs/iomap-for-next on top of v5.4.1 (there are no
changes to existing patches). The tree is available at
https://github.com/goldwynr/linux/tree/btrfs-iomap-dio

I have tested it against xfstests/btrfs.

Changes since v1
- Incorporated back the efficiency change for inode locking
- Review comments about coding style and git comments
- Merge related patches into one
- Direct read to go through btrfs_direct_IO()
- Removal of no longer used function dio_end_io()

Changes since v2
- aligning iomap offset/length to the position/length of I/O
- Removed btrfs_dio_data
- Removed BTRFS_INODE_READDIO_NEED_LOCK
- Re-incorporating write efficiency changes caused lockdep_assert() in
  iomap to be triggered, remove that code.

 fs/btrfs/btrfs_inode.h |   18 ---
 fs/btrfs/ctree.h       |    1 
 fs/btrfs/extent_io.c   |   37 ++----
 fs/btrfs/extent_io.h   |    2 
 fs/btrfs/file.c        |   21 +++
 fs/btrfs/inode.c       |  267 ++++++++++++++++---------------------------------
 fs/direct-io.c         |   19 ---
 fs/iomap/direct-io.c   |   16 +-
 include/linux/fs.h     |    3 
 include/linux/iomap.h  |    2 
 mm/filemap.c           |   13 +-
 11 files changed, 149 insertions(+), 250 deletions(-)

-- 
Goldwyn

