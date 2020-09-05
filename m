Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D425E595
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 07:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIEFUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 01:20:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgIEFUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 01:20:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2366729B716
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 1/3] direct-io: clean up error paths of do_blockdev_direct_IO
Date:   Sat,  5 Sep 2020 01:20:21 -0400
Message-Id: <20200905052023.3719585-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905052023.3719585-1-krisman@collabora.com>
References: <20200905052023.3719585-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation to resort DIO checks, reduce code duplication of error
handling in do_blockdev_direct_IO.

Changes since V1:
  - Remove fail_dio_unlocked (Me)
  - Ensure fail_dio won't call inode_unlock() for writes (Jan Kara)

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/direct-io.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 183299892465..6c11db1cec27 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1170,7 +1170,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			blkbits = blksize_bits(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
 		if (align & blocksize_mask)
-			goto out;
+			return -EINVAL;
 	}
 
 	/* watch out for a 0 len io from a tricksy fs */
@@ -1178,9 +1178,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		return 0;
 
 	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
-	retval = -ENOMEM;
 	if (!dio)
-		goto out;
+		return -ENOMEM;
 	/*
 	 * Believe it or not, zeroing out the page array caused a .5%
 	 * performance regression in a database benchmark.  So, we take
@@ -1199,22 +1198,16 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 			retval = filemap_write_and_wait_range(mapping, offset,
 							      end - 1);
-			if (retval) {
-				inode_unlock(inode);
-				kmem_cache_free(dio_cache, dio);
-				goto out;
-			}
+			if (retval)
+				goto fail_dio;
 		}
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
 	dio->i_size = i_size_read(inode);
 	if (iov_iter_rw(iter) == READ && offset >= dio->i_size) {
-		if (dio->flags & DIO_LOCKING)
-			inode_unlock(inode);
-		kmem_cache_free(dio_cache, dio);
 		retval = 0;
-		goto out;
+		goto fail_dio;
 	}
 
 	/*
@@ -1258,14 +1251,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			 */
 			retval = sb_init_dio_done_wq(dio->inode->i_sb);
 		}
-		if (retval) {
-			/*
-			 * We grab i_mutex only for reads so we don't have
-			 * to release it here
-			 */
-			kmem_cache_free(dio_cache, dio);
-			goto out;
-		}
+		if (retval)
+			goto fail_dio;
 	}
 
 	/*
@@ -1368,7 +1355,13 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	} else
 		BUG_ON(retval != -EIOCBQUEUED);
 
-out:
+	return retval;
+
+fail_dio:
+	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
+		inode_unlock(inode);
+
+	kmem_cache_free(dio_cache, dio);
 	return retval;
 }
 
-- 
2.28.0

