Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA63403D20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbhIHP7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352249AbhIHP7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVVmrjwehVBypYQtKjBAOERwHcrRNV9eAHtDAthew/Y=;
        b=b8JEliKZ4ectdYGulR788kibJhxHV2YjeKJKPl2ZoV4s0dXzhkiu/U/LxlmvA/SnVDTWGo
        +Lx9yzO182m03sEerLCADXTN5/g7GgRi8rtlCSaf8CHG4H0/j0mzHLK9XSzLyp71T77IF+
        y9yZUj5fN4Kf1dvqfSGVBNVo59EjVLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-n6VuYYxnN2GaGNQPPn4QNw-1; Wed, 08 Sep 2021 11:58:11 -0400
X-MC-Unique: n6VuYYxnN2GaGNQPPn4QNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95A0A84A5EE;
        Wed,  8 Sep 2021 15:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF955D9C6;
        Wed,  8 Sep 2021 15:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] afs: Fix mmap coherency vs 3rd-party changes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, markus.suvanto@gmail.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:58:08 +0100
Message-ID: <163111668833.283156.382633263709075739.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the coherency management of mmap'd data such that 3rd-party changes
become visible as soon as possible after the callback notification is
delivered by the fileserver.  This is done by the following means:

 (1) When we break a callback on a vnode specified by the CB.CallBack call
     from the server, we queue a work item (vnode->cb_work) to go and
     clobber all the PTEs mapping to that inode.

     This causes the CPU to trip through the ->map_pages() and
     ->page_mkwrite() handlers if userspace attempts to access the page(s)
     again.

     (Ideally, this would be done in the service handler for CB.CallBack,
     but the server is waiting for our reply before considering, and we
     have a list of vnodes, all of which need breaking - and the process of
     getting the mmap_lock and stripping the PTEs on all CPUs could be
     quite slow.)

 (2) Call afs_validate() from the ->map_pages() handler to check to see if
     the file has changed and to get a new callback promise from the
     server.

Also handle the fileserver telling us that it's dropping all callbacks,
possibly after it's been restarted by sending us a CB.InitCallBackState*
call by the following means:

 (3) Maintain a per-cell list of afs files that are currently mmap'd
     (cell->fs_open_mmaps).

 (4) Add a work item to each server that is invoked if there are any open
     mmaps when CB.InitCallBackState happens.  This work item goes through
     the aforementioned list and invokes the vnode->cb_work work item for
     each one that is currently using this server.

     This causes the PTEs to be cleared, causing ->map_pages() or
     ->page_mkwrite() to be called again, thereby calling afs_validate()
     again.

I've chosen to simply strip the PTEs at the point of notification reception
rather than invalidate all the pages as well because (a) it's faster, (b)
we may get a notification for other reasons than the data being altered (in
which case we don't want to clobber the pagecache) and (c) we need to ask
the server to find out - and I don't want to wait for the reply before
holding up userspace.

This was tested using the attached test program:

	#include <stdbool.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <fcntl.h>
	#include <sys/mman.h>
	int main(int argc, char *argv[])
	{
		size_t size = getpagesize();
		unsigned char *p;
		bool mod = (argc == 3);
		int fd;
		if (argc != 2 && argc != 3) {
			fprintf(stderr, "Format: %s <file> [mod]\n", argv[0]);
			exit(2);
		}
		fd = open(argv[1], mod ? O_RDWR : O_RDONLY);
		if (fd < 0) {
			perror(argv[1]);
			exit(1);
		}

		p = mmap(NULL, size, mod ? PROT_READ|PROT_WRITE : PROT_READ,
			 MAP_SHARED, fd, 0);
		if (p == MAP_FAILED) {
			perror("mmap");
			exit(1);
		}
		for (;;) {
			if (mod) {
				p[0]++;
				msync(p, size, MS_ASYNC);
				fsync(fd);
			}
			printf("%02x", p[0]);
			fflush(stdout);
			sleep(1);
		}
	}

It runs in two modes: in one mode, it mmaps a file, then sits in a loop
reading the first byte, printing it and sleeping for a second; in the
second mode it mmaps a file, then sits in a loop incrementing the first
byte and flushing, then printing and sleeping.

Two instances of this program can be run on different machines, one doing
the reading and one doing the writing.  The reader should see the changes
made by the writer, but without this patch, they aren't because validity
checking is being done lazily - only on entry to the filesystem.

Testing the InitCallBackState change is more complicated.  The server has
to be taken offline, the saved callback state file removed and then the
server restarted whilst the reading-mode program continues to run.  The
client machine then has to poke the server to trigger the InitCallBackState
call.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/callback.c |   42 ++++++++++++++++++++++++++++++++-
 fs/afs/cell.c     |    2 ++
 fs/afs/file.c     |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/afs/internal.h |    8 ++++++
 fs/afs/server.c   |    2 ++
 fs/afs/super.c    |    1 +
 mm/memory.c       |    1 +
 7 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 7d9b23d981bf..1dd7543dbf9f 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -20,6 +20,37 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+/*
+ * Handle invalidation of an mmap'd file.  We invalidate all the PTEs referring
+ * to the pages in this file's pagecache, forcing the kernel to go through
+ * ->fault() or ->page_mkwrite() - at which point we can handle invalidation
+ * more fully.
+ */
+void afs_invalidate_mmap_work(struct work_struct *work)
+{
+	struct afs_vnode *vnode = container_of(work, struct afs_vnode, cb_work);
+
+	unmap_mapping_pages(vnode->vfs_inode.i_mapping, 0, 0, false);
+}
+
+void afs_server_init_callback_work(struct work_struct *work)
+{
+	struct afs_server *server = container_of(work, struct afs_server, initcb_work);
+	struct afs_vnode *vnode;
+	struct afs_cell *cell = server->cell;
+
+	down_read(&cell->fs_open_mmaps_lock);
+
+	list_for_each_entry(vnode, &cell->fs_open_mmaps, cb_mmap_link) {
+		if (vnode->cb_server == server) {
+			clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+			queue_work(system_unbound_wq, &vnode->cb_work);
+		}
+	}
+
+	up_read(&cell->fs_open_mmaps_lock);
+}
+
 /*
  * Allow the fileserver to request callback state (re-)initialisation.
  * Unfortunately, UUIDs are not guaranteed unique.
@@ -29,8 +60,10 @@ void afs_init_callback_state(struct afs_server *server)
 	rcu_read_lock();
 	do {
 		server->cb_s_break++;
-		server = rcu_dereference(server->uuid_next);
-	} while (0);
+		if (!list_empty(&server->cell->fs_open_mmaps))
+			queue_work(system_unbound_wq, &server->initcb_work);
+
+	} while ((server = rcu_dereference(server->uuid_next)));
 	rcu_read_unlock();
 }
 
@@ -49,6 +82,11 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 			afs_lock_may_be_available(vnode);
 
+		if (reason != afs_cb_break_for_deleted &&
+		    vnode->status.type == AFS_FTYPE_FILE &&
+		    atomic_read(&vnode->cb_nr_mmap))
+			queue_work(system_unbound_wq, &vnode->cb_work);
+
 		trace_afs_cb_break(&vnode->fid, vnode->cb_break, reason, true);
 	} else {
 		trace_afs_cb_break(&vnode->fid, vnode->cb_break, reason, false);
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 887b673f6223..d88407fb9bc0 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -166,6 +166,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	seqlock_init(&cell->volume_lock);
 	cell->fs_servers = RB_ROOT;
 	seqlock_init(&cell->fs_lock);
+	INIT_LIST_HEAD(&cell->fs_open_mmaps);
+	init_rwsem(&cell->fs_open_mmaps_lock);
 	rwlock_init(&cell->vl_servers_lock);
 	cell->flags = (1 << AFS_CELL_FL_CHECK_ALIAS);
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4c8d786b53e0..e6c447ae91f3 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -25,6 +25,9 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static void afs_readahead(struct readahead_control *ractl);
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+static void afs_vm_open(struct vm_area_struct *area);
+static void afs_vm_close(struct vm_area_struct *area);
+static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
@@ -60,8 +63,10 @@ const struct address_space_operations afs_fs_aops = {
 };
 
 static const struct vm_operations_struct afs_vm_ops = {
+	.open		= afs_vm_open,
+	.close		= afs_vm_close,
 	.fault		= filemap_fault,
-	.map_pages	= filemap_map_pages,
+	.map_pages	= afs_vm_map_pages,
 	.page_mkwrite	= afs_page_mkwrite,
 };
 
@@ -492,19 +497,79 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 	return 1;
 }
 
+static void afs_add_open_mmap(struct afs_vnode *vnode)
+{
+	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
+		down_write(&vnode->volume->cell->fs_open_mmaps_lock);
+
+		list_add_tail(&vnode->cb_mmap_link,
+			      &vnode->volume->cell->fs_open_mmaps);
+
+		up_write(&vnode->volume->cell->fs_open_mmaps_lock);
+	}
+}
+
+static void afs_drop_open_mmap(struct afs_vnode *vnode)
+{
+	if (!atomic_dec_and_test(&vnode->cb_nr_mmap))
+		return;
+
+	down_write(&vnode->volume->cell->fs_open_mmaps_lock);
+
+	if (atomic_read(&vnode->cb_nr_mmap) == 0)
+		list_del_init(&vnode->cb_mmap_link);
+
+	up_write(&vnode->volume->cell->fs_open_mmaps_lock);
+	flush_work(&vnode->cb_work);
+}
+
 /*
  * Handle setting up a memory mapping on an AFS file.
  */
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
+	afs_add_open_mmap(vnode);
+
 	ret = generic_file_mmap(file, vma);
 	if (ret == 0)
 		vma->vm_ops = &afs_vm_ops;
+	else
+		afs_drop_open_mmap(vnode);
 	return ret;
 }
 
+static void afs_vm_open(struct vm_area_struct *vma)
+{
+	afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
+}
+
+static void afs_vm_close(struct vm_area_struct *vma)
+{
+	afs_drop_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
+}
+
+static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(vmf->vma->vm_file));
+	struct afs_file *af = vmf->vma->vm_file->private_data;
+
+	switch (afs_validate(vnode, af->key)) {
+	case 0:
+		return filemap_map_pages(vmf, start_pgoff, end_pgoff);
+	case -ENOMEM:
+		return VM_FAULT_OOM;
+	case -EINTR:
+	case -ERESTARTSYS:
+		return VM_FAULT_RETRY;
+	case -ESTALE:
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+}
+
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5ed416f4ff33..0deeb76c67d0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -390,6 +390,8 @@ struct afs_cell {
 	/* Active fileserver interaction state. */
 	struct rb_root		fs_servers;	/* afs_server (by server UUID) */
 	seqlock_t		fs_lock;	/* For fs_servers  */
+	struct rw_semaphore	fs_open_mmaps_lock;
+	struct list_head	fs_open_mmaps;	/* List of vnodes that are mmapped */
 
 	/* VL server list. */
 	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
@@ -503,6 +505,7 @@ struct afs_server {
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
+	struct work_struct	initcb_work;	/* Work for CB.InitCallBackState* */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
@@ -657,7 +660,10 @@ struct afs_vnode {
 	afs_lock_type_t		lock_type : 8;
 
 	/* outstanding callback notification on this file */
+	struct work_struct	cb_work;	/* Work for mmap'd files */
+	struct list_head	cb_mmap_link;	/* Link in cell->fs_open_mmaps */
 	void			*cb_server;	/* Server with callback/filelock */
+	atomic_t		cb_nr_mmap;	/* Number of mmaps */
 	unsigned int		cb_s_break;	/* Mass break counter on ->server */
 	unsigned int		cb_v_break;	/* Mass break counter on ->volume */
 	unsigned int		cb_break;	/* Break counter on vnode */
@@ -965,6 +971,8 @@ extern struct fscache_cookie_def afs_vnode_cache_index_def;
 /*
  * callback.c
  */
+extern void afs_invalidate_mmap_work(struct work_struct *);
+extern void afs_server_init_callback_work(struct work_struct *work);
 extern void afs_init_callback_state(struct afs_server *);
 extern void __afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
 extern void afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 684a2b02b9ff..6e5b9a19b234 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -235,6 +235,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
+	INIT_WORK(&server->initcb_work, afs_server_init_callback_work);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
@@ -467,6 +468,7 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
 		afs_give_up_callbacks(net, server);
 
+	flush_work(&server->initcb_work);
 	afs_put_server(net, server, afs_server_trace_destroy);
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index e38bb1e7a4d2..d110def8aa8e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -698,6 +698,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->lock_state	= AFS_VNODE_LOCK_NONE;
 
 	init_rwsem(&vnode->rmdir_lock);
+	INIT_WORK(&vnode->cb_work, afs_invalidate_mmap_work);
 
 	_leave(" = %p", &vnode->vfs_inode);
 	return &vnode->vfs_inode;
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..adf9b9ef8277 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3403,6 +3403,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		unmap_mapping_range_tree(&mapping->i_mmap, &details);
 	i_mmap_unlock_write(mapping);
 }
+EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 
 /**
  * unmap_mapping_range - unmap the portion of all mmaps in the specified


