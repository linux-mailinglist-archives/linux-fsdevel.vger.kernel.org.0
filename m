Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBE286EAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJHG0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHG0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:26:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A3C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2020 23:26:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E5EA129CC33
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [RESEND^2 PATCH 1/3] direct-io: clean up error paths of do_blockdev_direct_IO
Date:   Thu,  8 Oct 2020 02:26:18 -0400
Message-Id: <20201008062620.2928326-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008062620.2928326-1-krisman@collabora.com>
References: <20201008062620.2928326-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation to resort DIO checks, reduce code duplication of error
handling in do_blockdev_direct_IO.

Reviewed-by: Jan Kara <jack@suse.cz>
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

