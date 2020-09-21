Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E507027289C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIUOoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbgIUOoT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55DB4AC4C;
        Mon, 21 Sep 2020 14:44:52 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/15] iomap: Call inode_dio_end() before generic_write_sync()
Date:   Mon, 21 Sep 2020 09:43:42 -0500
Message-Id: <20200921144353.31319-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap complete routine can deadlock with btrfs_fallocate because of the
call to generic_write_sync().

P0                      P1
inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
__iomap_dio_rw()        inode_lock()
                        <block>
<submits IO>
<completes IO>
inode_unlock()
                        <gets inode_lock()>
                        inode_dio_wait()
iomap_dio_complete()
  generic_write_sync()
    btrfs_file_fsync()
      inode_lock()
      <deadlock>

inode_dio_end() is used to notify the end of DIO data in order
to synchronize with truncate. Call inode_dio_end() before calling
generic_write_sync(), so filesystems can lock i_rwsem during a sync.

---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d970c6bbbe11..e01f81e7b76f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			dio_warn_stale_pagecache(iocb->ki_filp);
 	}
 
+	inode_dio_end(file_inode(iocb->ki_filp));
 	/*
 	 * If this is a DSYNC write, make sure we push it to stable storage now
 	 * that we've written data.
@@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
 		ret = generic_write_sync(iocb, ret);
 
-	inode_dio_end(file_inode(iocb->ki_filp));
 	kfree(dio);
 
 	return ret;
-- 
2.26.2

