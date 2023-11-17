Return-Path: <linux-fsdevel+bounces-3058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB2E7EF99D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14461F27416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278E482F5;
	Fri, 17 Nov 2023 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9n664XZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E4171F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDuRQ8qt5BAHVjo78hLbEI2A9+TTuLpwEa7n+hIfUok=;
	b=L9n664XZ7GsBuKzMOcfCkgfxolELOKZj8FPjMVu63yWLm5hJXoB99AHaFW9zlAe3rpAtkI
	BJ2sgFK/wSmDc97efvUHOrPCBEQZapxHG1w6QstLkbTySnNOdJCvOxAgbFfScfKTI1uLzv
	sp+jZHgEmAGnxhknJ28OvFQ2R1ptFQQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-oFpXzy-aNEOxjzwGinR_HQ-1; Fri,
 17 Nov 2023 16:16:14 -0500
X-MC-Unique: oFpXzy-aNEOxjzwGinR_HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 041803C025D3;
	Fri, 17 Nov 2023 21:16:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 683CE2166B29;
	Fri, 17 Nov 2023 21:16:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/51] netfs: Implement unbuffered/DIO vs buffered I/O locking
Date: Fri, 17 Nov 2023 21:14:59 +0000
Message-ID: <20231117211544.1740466-8-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Borrow NFS's direct-vs-buffered I/O locking into netfslib.  Similar code is
also used in ceph.

Modify it to have the correct checker annotations for i_rwsem lock
acquisition/release and to return -ERESTARTSYS if waits are interrupted.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/Makefile     |   1 +
 fs/netfs/locking.c    | 215 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |  10 ++
 3 files changed, 226 insertions(+)
 create mode 100644 fs/netfs/locking.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index cd22554d9048..647ce1935674 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -4,6 +4,7 @@ netfs-y := \
 	buffered_read.o \
 	io.o \
 	iterator.o \
+	locking.o \
 	main.o \
 	misc.o \
 	objects.o
diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
new file mode 100644
index 000000000000..58e0f48394c5
--- /dev/null
+++ b/fs/netfs/locking.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I/O and data path helper functionality.
+ *
+ * Borrowed from NFS Copyright (c) 2016 Trond Myklebust
+ */
+
+#include <linux/kernel.h>
+#include <linux/netfs.h>
+
+/*
+ * inode_dio_wait_interruptible - wait for outstanding DIO requests to finish
+ * @inode: inode to wait for
+ *
+ * Waits for all pending direct I/O requests to finish so that we can
+ * proceed with a truncate or equivalent operation.
+ *
+ * Must be called under a lock that serializes taking new references
+ * to i_dio_count, usually by inode->i_mutex.
+ */
+static int inode_dio_wait_interruptible(struct inode *inode)
+{
+	if (!atomic_read(&inode->i_dio_count))
+		return 0;
+
+	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
+	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
+
+	for (;;) {
+		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
+		if (!atomic_read(&inode->i_dio_count))
+			break;
+		if (signal_pending(current))
+			break;
+		schedule();
+	}
+	finish_wait(wq, &q.wq_entry);
+
+	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
+}
+
+/* Call with exclusively locked inode->i_rwsem */
+static int netfs_block_o_direct(struct netfs_inode *ictx)
+{
+	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags))
+		return 0;
+	clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
+	return inode_dio_wait_interruptible(&ictx->inode);
+}
+
+/**
+ * netfs_start_io_read - declare the file is being used for buffered reads
+ * @inode: file inode
+ *
+ * Declare that a buffered read operation is about to start, and ensure
+ * that we block all direct I/O.
+ * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is unset,
+ * and holds a shared lock on inode->i_rwsem to ensure that the flag
+ * cannot be changed.
+ * In practice, this means that buffered read operations are allowed to
+ * execute in parallel, thanks to the shared lock, whereas direct I/O
+ * operations need to wait to grab an exclusive lock in order to set
+ * NETFS_ICTX_ODIRECT.
+ * Note that buffered writes and truncates both take a write lock on
+ * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
+ */
+int netfs_start_io_read(struct inode *inode)
+	__acquires(inode->i_rwsem)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+
+	/* Be an optimist! */
+	if (down_read_interruptible(&inode->i_rwsem) < 0)
+		return -ERESTARTSYS;
+	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) == 0)
+		return 0;
+	up_read(&inode->i_rwsem);
+
+	/* Slow path.... */
+	if (down_write_killable(&inode->i_rwsem) < 0)
+		return -ERESTARTSYS;
+	if (netfs_block_o_direct(ictx) < 0) {
+		up_write(&inode->i_rwsem);
+		return -ERESTARTSYS;
+	}
+	downgrade_write(&inode->i_rwsem);
+	return 0;
+}
+EXPORT_SYMBOL(netfs_start_io_read);
+
+/**
+ * netfs_end_io_read - declare that the buffered read operation is done
+ * @inode: file inode
+ *
+ * Declare that a buffered read operation is done, and release the shared
+ * lock on inode->i_rwsem.
+ */
+void netfs_end_io_read(struct inode *inode)
+	__releases(inode->i_rwsem)
+{
+	up_read(&inode->i_rwsem);
+}
+EXPORT_SYMBOL(netfs_end_io_read);
+
+/**
+ * netfs_start_io_write - declare the file is being used for buffered writes
+ * @inode: file inode
+ *
+ * Declare that a buffered read operation is about to start, and ensure
+ * that we block all direct I/O.
+ */
+int netfs_start_io_write(struct inode *inode)
+	__acquires(inode->i_rwsem)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+
+	if (down_write_killable(&inode->i_rwsem) < 0)
+		return -ERESTARTSYS;
+	if (netfs_block_o_direct(ictx) < 0) {
+		up_write(&inode->i_rwsem);
+		return -ERESTARTSYS;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(netfs_start_io_write);
+
+/**
+ * netfs_end_io_write - declare that the buffered write operation is done
+ * @inode: file inode
+ *
+ * Declare that a buffered write operation is done, and release the
+ * lock on inode->i_rwsem.
+ */
+void netfs_end_io_write(struct inode *inode)
+	__releases(inode->i_rwsem)
+{
+	up_write(&inode->i_rwsem);
+}
+EXPORT_SYMBOL(netfs_end_io_write);
+
+/* Call with exclusively locked inode->i_rwsem */
+static int netfs_block_buffered(struct inode *inode)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+	int ret;
+
+	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags)) {
+		set_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
+		if (inode->i_mapping->nrpages != 0) {
+			unmap_mapping_range(inode->i_mapping, 0, 0, 0);
+			ret = filemap_fdatawait(inode->i_mapping);
+			if (ret < 0) {
+				clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
+				return ret;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * netfs_start_io_direct - declare the file is being used for direct i/o
+ * @inode: file inode
+ *
+ * Declare that a direct I/O operation is about to start, and ensure
+ * that we block all buffered I/O.
+ * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is set,
+ * and holds a shared lock on inode->i_rwsem to ensure that the flag
+ * cannot be changed.
+ * In practice, this means that direct I/O operations are allowed to
+ * execute in parallel, thanks to the shared lock, whereas buffered I/O
+ * operations need to wait to grab an exclusive lock in order to clear
+ * NETFS_ICTX_ODIRECT.
+ * Note that buffered writes and truncates both take a write lock on
+ * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
+ */
+int netfs_start_io_direct(struct inode *inode)
+	__acquires(inode->i_rwsem)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+	int ret;
+
+	/* Be an optimist! */
+	if (down_read_interruptible(&inode->i_rwsem) < 0)
+		return -ERESTARTSYS;
+	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) != 0)
+		return 0;
+	up_read(&inode->i_rwsem);
+
+	/* Slow path.... */
+	if (down_write_killable(&inode->i_rwsem) < 0)
+		return -ERESTARTSYS;
+	ret = netfs_block_buffered(inode);
+	if (ret < 0) {
+		up_write(&inode->i_rwsem);
+		return ret;
+	}
+	downgrade_write(&inode->i_rwsem);
+	return 0;
+}
+EXPORT_SYMBOL(netfs_start_io_direct);
+
+/**
+ * netfs_end_io_direct - declare that the direct i/o operation is done
+ * @inode: file inode
+ *
+ * Declare that a direct I/O operation is done, and release the shared
+ * lock on inode->i_rwsem.
+ */
+void netfs_end_io_direct(struct inode *inode)
+	__releases(inode->i_rwsem)
+{
+	up_read(&inode->i_rwsem);
+}
+EXPORT_SYMBOL(netfs_end_io_direct);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 6e662832c3ae..18e3d8b53646 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -131,6 +131,8 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 	loff_t			zero_point;	/* Size after which we assume there's no data
 						 * on the server */
+	unsigned long		flags;
+#define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 };
 
 /*
@@ -312,6 +314,13 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);
 
+int netfs_start_io_read(struct inode *inode);
+void netfs_end_io_read(struct inode *inode);
+int netfs_start_io_write(struct inode *inode);
+void netfs_end_io_write(struct inode *inode);
+int netfs_start_io_direct(struct inode *inode);
+void netfs_end_io_direct(struct inode *inode);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query
@@ -338,6 +347,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->ops = ops;
 	ctx->remote_i_size = i_size_read(&ctx->inode);
 	ctx->zero_point = ctx->remote_i_size;
+	ctx->flags = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif


