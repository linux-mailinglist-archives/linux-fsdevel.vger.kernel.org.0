Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA54286EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgJHG0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 02:26:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHG0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:26:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C546229615E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jamie Liu <jamieliu@google.com>
Subject: [RESEND^2 PATCH 3/3] direct-io: defer alignment check until after the EOF check
Date:   Thu,  8 Oct 2020 02:26:20 -0400
Message-Id: <20201008062620.2928326-4-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008062620.2928326-1-krisman@collabora.com>
References: <20201008062620.2928326-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior to commit 9fe55eea7e4b ("Fix race when checking i_size on direct
i/o read"), an unaligned direct read past end of file would trigger EOF,
since generic_file_aio_read detected this read-at-EOF condition and
skipped the direct IO read entirely, returning 0. After that change, the
read now reaches dio_generic, which detects the misalignment and returns
EINVAL.

This consolidates the generic direct-io to follow the same behavior of
filesystems.  Apparently, this fix will only affect ocfs2 since other
filesystems do this verification before calling do_blockdev_direct_IO,
with the exception of f2fs, which has the same bug, but is fixed in the
next patch.

it can be verified by a read loop on a file that does a partial read
before EOF (On file that doesn't end at an aligned address).  The
following code fails on an unaligned file on filesystems without
prior validation without this patch, but not on btrfs, ext4, and xfs.

  while (done < total) {
    ssize_t delta = pread(fd, buf + done, total - done, off + done);
    if (!delta)
      break;
    ...
  }

Fix this regression by moving the misalignment check to after the EOF
check added by commit 74cedf9b6c60 ("direct-io: Fix negative return from
dio read beyond eof").

Based on a patch by Jamie Liu.

Reported-by: Jamie Liu <jamieliu@google.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/direct-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index c17efe58f1c9..82838cca934b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1165,14 +1165,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * the early prefetch in the caller enough time.
 	 */
 
-	if (align & blocksize_mask) {
-		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
-		blocksize_mask = (1 << blkbits) - 1;
-		if (align & blocksize_mask)
-			return -EINVAL;
-	}
-
 	/* watch out for a 0 len io from a tricksy fs */
 	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
@@ -1200,6 +1192,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		goto fail_dio;
 	}
 
+	if (align & blocksize_mask) {
+		if (bdev)
+			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+		blocksize_mask = (1 << blkbits) - 1;
+		if (align & blocksize_mask)
+			goto fail_dio;
+	}
+
 	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
-- 
2.28.0

