Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75325C9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 22:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgICUE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 16:04:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57750 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICUE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:04:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 50BA529B164
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 2/3] direct-io: don't force writeback for reads beyond EOF
Date:   Thu,  3 Sep 2020 16:04:13 -0400
Message-Id: <20200903200414.673105-3-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903200414.673105-1-krisman@collabora.com>
References: <20200903200414.673105-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a DIO read starts past EOF, the kernel won't attempt it, so we don't
need to flush dirty pages before failing the syscall.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/direct-io.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 04aae41323d7..43460c8e0f90 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1188,19 +1188,9 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	memset(dio, 0, offsetof(struct dio, pages));
 
 	dio->flags = flags;
-	if (dio->flags & DIO_LOCKING) {
-		if (iov_iter_rw(iter) == READ) {
-			struct address_space *mapping =
-					iocb->ki_filp->f_mapping;
-
-			/* will be released by direct_io_worker */
-			inode_lock(inode);
-
-			retval = filemap_write_and_wait_range(mapping, offset,
-							      end - 1);
-			if (retval)
-				goto fail_dio;
-		}
+	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+		/* will be released by direct_io_worker */
+		inode_lock(inode);
 	}
 
 	/* Once we sampled i_size check for reads beyond EOF */
@@ -1210,6 +1200,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		goto fail_dio;
 	}
 
+	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
+		if (retval)
+			goto fail_dio;
+	}
+
 	/*
 	 * For file extending writes updating i_size before data writeouts
 	 * complete can expose uninitialized blocks in dumb filesystems.
-- 
2.28.0

