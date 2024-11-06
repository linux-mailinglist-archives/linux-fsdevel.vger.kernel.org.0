Return-Path: <linux-fsdevel+bounces-33758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DBD9BEA56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CEB1F247B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BF1F8F12;
	Wed,  6 Nov 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diSjquW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F21E8825
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896680; cv=none; b=Ff8EanLJd1huGUndk6m7SfSxHbUQMEbJlx0kspeQpACxtqybwUOoAWxWJVOaMmMCfSV7IqAARlSjqOWK09BLPTaU4kbwfWvKBMnuMOkF4TS0wO0CEVg8+I9+kEKIQbYQz2bA+iuJ64NpXaIKFeLkEzozE/mv6A9dSGg1MhilOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896680; c=relaxed/simple;
	bh=PlP3tUUgr08MhjF8RVBqApIWP2b4NxRAsjXbxJF6jPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe/kpMzuMe2lwFRbU4q7jTtF134PHh89PeOBAZPRJYvKxXdB1hDW6/aqJzclAeou/f8LY2OiHlD9JGcvt9l3qkheJrDadlU6WIZzA+1bhkQEmo51iUyg1CuMmqJhG2ZU5lXIXDIAUpiYPAMD4CeKzaGo5A4UG44JKLzDGripl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diSjquW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVoEs9N2N3+Yy5ytz8xwWGrwrjCUqjBQVK6VxNHCBSE=;
	b=diSjquW/a4mCyHUpz3jXXNhv8FwEuR4SAfIDy6wx4zZ2r37iPNwf9gi3xfvKicp4sOZCqq
	PadVDcSEjXhACd+gjToTnP6N9ZcofL+qXPsxgdmlRQ28yEgsy3rJ0Epwx4MORkyLdSW8+T
	iekEK1o0bgywoSjc+Otr99OHNsWEp6o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Lke04AvaNPCkEvwplLVMIg-1; Wed,
 06 Nov 2024 07:37:54 -0500
X-MC-Unique: Lke04AvaNPCkEvwplLVMIg-1
X-Mimecast-MFC-AGG-ID: Lke04AvaNPCkEvwplLVMIg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05A51955D99;
	Wed,  6 Nov 2024 12:37:50 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31C6F30000DF;
	Wed,  6 Nov 2024 12:37:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/33] afs: Don't use mutex for I/O operation lock
Date: Wed,  6 Nov 2024 12:35:37 +0000
Message-ID: <20241106123559.724888-14-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Don't use the standard mutex for the I/O operation lock, but rather
implement our own as the standard mutex must be released in the same thread
as locked it.  This is a problem when it comes to doing async FetchData
where the lock will be dropped from the workqueue that processed the
incoming data and not from the issuing thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 111 +++++++++++++++++++++++++++++++++++++++---
 fs/afs/internal.h     |   3 +-
 fs/afs/super.c        |   2 +-
 3 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 428721bbe4f6..8488ff8183fa 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -49,6 +49,105 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	return op;
 }
 
+struct afs_io_locker {
+	struct list_head	link;
+	struct task_struct	*task;
+	unsigned long		have_lock;
+};
+
+/*
+ * Unlock the I/O lock on a vnode.
+ */
+static void afs_unlock_for_io(struct afs_vnode *vnode)
+{
+	struct afs_io_locker *locker;
+
+	spin_lock(&vnode->lock);
+	locker = list_first_entry_or_null(&vnode->io_lock_waiters,
+					  struct afs_io_locker, link);
+	if (locker) {
+		list_del(&locker->link);
+		smp_store_release(&locker->have_lock, 1);
+		smp_mb__after_atomic(); /* Store have_lock before task state */
+		wake_up_process(locker->task);
+	} else {
+		clear_bit(AFS_VNODE_IO_LOCK, &vnode->flags);
+	}
+	spin_unlock(&vnode->lock);
+}
+
+/*
+ * Lock the I/O lock on a vnode uninterruptibly.  We can't use an ordinary
+ * mutex as lockdep will complain if we unlock it in the wrong thread.
+ */
+static void afs_lock_for_io(struct afs_vnode *vnode)
+{
+	struct afs_io_locker myself = { .task = current, };
+
+	spin_lock(&vnode->lock);
+
+	if (!test_and_set_bit(AFS_VNODE_IO_LOCK, &vnode->flags)) {
+		spin_unlock(&vnode->lock);
+		return;
+	}
+
+	list_add_tail(&myself.link, &vnode->io_lock_waiters);
+	spin_unlock(&vnode->lock);
+
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (smp_load_acquire(&myself.have_lock))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
+/*
+ * Lock the I/O lock on a vnode interruptibly.  We can't use an ordinary mutex
+ * as lockdep will complain if we unlock it in the wrong thread.
+ */
+static int afs_lock_for_io_interruptible(struct afs_vnode *vnode)
+{
+	struct afs_io_locker myself = { .task = current, };
+	int ret = 0;
+
+	spin_lock(&vnode->lock);
+
+	if (!test_and_set_bit(AFS_VNODE_IO_LOCK, &vnode->flags)) {
+		spin_unlock(&vnode->lock);
+		return 0;
+	}
+
+	list_add_tail(&myself.link, &vnode->io_lock_waiters);
+	spin_unlock(&vnode->lock);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (smp_load_acquire(&myself.have_lock) ||
+		    signal_pending(current))
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	/* If we got a signal, try to transfer the lock onto the next
+	 * waiter.
+	 */
+	if (unlikely(signal_pending(current))) {
+		spin_lock(&vnode->lock);
+		if (myself.have_lock) {
+			spin_unlock(&vnode->lock);
+			afs_unlock_for_io(vnode);
+		} else {
+			list_del(&myself.link);
+			spin_unlock(&vnode->lock);
+		}
+		ret = -ERESTARTSYS;
+	}
+	return ret;
+}
+
 /*
  * Lock the vnode(s) being operated upon.
  */
@@ -60,7 +159,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	_enter("");
 
 	if (op->flags & AFS_OPERATION_UNINTR) {
-		mutex_lock(&vnode->io_lock);
+		afs_lock_for_io(vnode);
 		op->flags |= AFS_OPERATION_LOCK_0;
 		_leave(" = t [1]");
 		return true;
@@ -72,7 +171,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	if (vnode2 > vnode)
 		swap(vnode, vnode2);
 
-	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
+	if (afs_lock_for_io_interruptible(vnode) < 0) {
 		afs_op_set_error(op, -ERESTARTSYS);
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [I 0]");
@@ -81,10 +180,10 @@ static bool afs_get_io_locks(struct afs_operation *op)
 	op->flags |= AFS_OPERATION_LOCK_0;
 
 	if (vnode2) {
-		if (mutex_lock_interruptible_nested(&vnode2->io_lock, 1) < 0) {
+		if (afs_lock_for_io_interruptible(vnode2) < 0) {
 			afs_op_set_error(op, -ERESTARTSYS);
 			op->flags |= AFS_OPERATION_STOP;
-			mutex_unlock(&vnode->io_lock);
+			afs_unlock_for_io(vnode);
 			op->flags &= ~AFS_OPERATION_LOCK_0;
 			_leave(" = f [I 1]");
 			return false;
@@ -104,9 +203,9 @@ static void afs_drop_io_locks(struct afs_operation *op)
 	_enter("");
 
 	if (op->flags & AFS_OPERATION_LOCK_1)
-		mutex_unlock(&vnode2->io_lock);
+		afs_unlock_for_io(vnode2);
 	if (op->flags & AFS_OPERATION_LOCK_0)
-		mutex_unlock(&vnode->io_lock);
+		afs_unlock_for_io(vnode);
 }
 
 static void afs_prepare_vnode(struct afs_operation *op, struct afs_vnode_param *vp,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c9d620175e80..07b8f7083e73 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -702,13 +702,14 @@ struct afs_vnode {
 	struct afs_file_status	status;		/* AFS status info for this file */
 	afs_dataversion_t	invalid_before;	/* Child dentries are invalid before this */
 	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtained */
-	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
+	struct list_head	io_lock_waiters; /* Threads waiting for the I/O lock */
 	struct rw_semaphore	validate_lock;	/* lock for validating this vnode */
 	struct rw_semaphore	rmdir_lock;	/* Lock for rmdir vs sillyrename */
 	struct key		*silly_key;	/* Silly rename key */
 	spinlock_t		wb_lock;	/* lock for wb_keys */
 	spinlock_t		lock;		/* waitqueue/flags lock */
 	unsigned long		flags;
+#define AFS_VNODE_IO_LOCK	0		/* Set if the I/O serialisation lock is held */
 #define AFS_VNODE_UNSET		1		/* set if vnode attributes not yet set */
 #define AFS_VNODE_DIR_VALID	2		/* Set if dir contents are valid */
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f3ba1c3e72f5..7631302c1984 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -663,7 +663,7 @@ static void afs_i_init_once(void *_vnode)
 
 	memset(vnode, 0, sizeof(*vnode));
 	inode_init_once(&vnode->netfs.inode);
-	mutex_init(&vnode->io_lock);
+	INIT_LIST_HEAD(&vnode->io_lock_waiters);
 	init_rwsem(&vnode->validate_lock);
 	spin_lock_init(&vnode->wb_lock);
 	spin_lock_init(&vnode->lock);


