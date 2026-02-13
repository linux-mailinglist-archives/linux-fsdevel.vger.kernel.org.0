Return-Path: <linux-fsdevel+bounces-77160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLUxBspmj2k+QwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:00:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2DE138C94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41CE3303AF12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D0366052;
	Fri, 13 Feb 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqPF5gM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104333659FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005631; cv=none; b=pE8TtyZq0vcE29V5cGu0kOJLi3oeI+FbqeiM6hcn5hAP/GHLGFS1wbApGV8LsopckW9GXMy7UtwWxzhKjbfrPRLhU3wAU4rK8hiQwZbuXW/pfViLehdhTEkzS+oteb8fIVMFQ+R/5fqR8o9+m7ZG9+a2KHGIzXfSU5x/tSzJCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005631; c=relaxed/simple;
	bh=+WV1YBiwq1cn5Ri97h3khgnUrYsgPgYvdL7ymu0xKhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouJOU0NxEWx6guriFFaAHPO/yiBxbNoPpFSpiOx6VHgIpJFldDZXy3Tt/CsfxJ5rJxAL37N5u1H6r7npJUGpJxiMoS+7OQqwmwNh7A/A0UvKVS7Ic+BbmYg92unhbtCUvhXCmFRUwQufUjHvY+zG5hn8YlG9xwQdSkVEwSJdvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqPF5gM7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771005628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rd411M5TW7Fun2lJJ6DOZ0iLzrgobY/ywXFhkQ7bdYQ=;
	b=JqPF5gM72T/ZkqbD9NDxh3ppqmRQimNB1bLkdyE1QTrRJS3w8vQhW+ux05F+wyHYYX+PTg
	IWbdhHFsQPAN45lCuaZMCueSYcjkJ2ODctGKQCjSwHl/MpY2SPZfSK8+irhYqCqE8L5Ckm
	2fFGg6JF2G8WhVKONLKIsUZsox7wYRQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-_kyUrgK7M1S-Gr0-plMeXw-1; Fri,
 13 Feb 2026 13:00:23 -0500
X-MC-Unique: _kyUrgK7M1S-Gr0-plMeXw-1
X-Mimecast-MFC-AGG-ID: _kyUrgK7M1S-Gr0-plMeXw_1771005621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C11B1956046;
	Fri, 13 Feb 2026 18:00:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7427930001B9;
	Fri, 13 Feb 2026 18:00:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	gtully@redhat.com,
	djansa@redhat.com
Subject: [RFC v6.19] dlm: introduce dlmpfs
Date: Fri, 13 Feb 2026 13:00:14 -0500
Message-ID: <20260213180014.614646-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77160-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aahringo@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7F2DE138C94
X-Rspamd-Action: no action

DLMPFS is a new filesystem to offer distributed locking API (in this
case DLM) over the already known and easy portable file locking API.

Why?

Because there are user outside that just use a distributed filesystem
for locking. They don't have a use case to actually using a distributed
filesystem to store data. Offering a DLM distributed API over a
filesystem makes it easy for users to such switch to it as thats their
only need as flock()/fcntl() is already being used in their application.

How to use, 2 node cluster:

1. node1:

$ mount -t dlmpfs -o clname=$CLUSTERNAME none /mnt
$ touch /mnt/lock
$ flock /mnt/lock -c "echo 'acquired'; sleep 20; echo 'released'"

2. node2:

$ mount -t dlmpfs -o clname=$CLUSTERNAME none /mnt
$ touch /mnt/lock
$ flock /mnt/lock -c "echo 'acquired'; sleep 20; echo 'released'"

do 2. at the 20 seconds range and you will victim the locking.

Limitations:

One limitation is that the filepath need to be known before as DLM
cannot discover locks, but this is DLM nature as the resource name
need to be based on a rule that every node has the same locking
context for a specific resource. Usually this can be just hardcoded
in an implementation.

Future work:

1. POSIX distributed locking specification:

The file locking API isn't made for distributed locking and has its
problems because every distributed filesystem does their own stuff to
somehow "map" distributed locking to the flock()/fcntl() behaviour. The
goal is to use this filesystem to also allow "experiments" to introduce
in a community effort new file locking callbacks/systemcalls that are
more distributed locking friendly.

2. Support different lock manager backends

This filesystem is for DLM only, but I can also think of to support nfs
"lockd" lock manager to it. Then this filesystem should be named more as
"lockfs".

DLM stuff:

dlmpfs vs dlmfs:

There is a dlmfs already in the kernel but this offers ocfs2 DLM
specific API to the user as user space interface. dlmpfs is offering
file locking API to the user that uses DLM as backend.

Distributed inode problem (very DLM specific):

We need to use the same inode on all nodes that belongs to the same
"context". We do that over the LVB area and using e.g. the filepath
as identifier to request/allocate a clutser wide inode number.

E.g. if "/lock" regular file is created a lock request is being done
with the filepath as resource name. This resource name will be asked if
its already exists as this information is part of the LVB area. If
such filepath/resource does not exists this node will write LVB data and
allocate a unused inode number, also done over LVB and resource name. If
the filepath/resource would exists then the node will held the lock only
to keep this information alive. The LVB area will only be written by the
first node trying creating the first file, this should make it safe that
the LVB area keeps alive due recovery.

Other stuff:

This filesystem is based on ramfs, many thanks to provide such a filesystem
and I was able to simple change it for my needs.

And yes, you cannot write/read any data, this filesystem is only for
creating files/dirs and call flock()/fcntl() locking api on it.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/Kconfig             |  10 +
 fs/dlm/Makefile            |   2 +-
 fs/dlm/dlmpfs/Makefile     |   8 +
 fs/dlm/dlmpfs/file.c       | 134 +++++++++++
 fs/dlm/dlmpfs/inode.c      | 476 +++++++++++++++++++++++++++++++++++++
 fs/dlm/dlmpfs/internal.h   |  65 +++++
 fs/dlm/dlmpfs/newdlm.c     | 258 ++++++++++++++++++++
 include/uapi/linux/magic.h |   1 +
 8 files changed, 953 insertions(+), 1 deletion(-)
 create mode 100644 fs/dlm/dlmpfs/Makefile
 create mode 100644 fs/dlm/dlmpfs/file.c
 create mode 100644 fs/dlm/dlmpfs/inode.c
 create mode 100644 fs/dlm/dlmpfs/internal.h
 create mode 100644 fs/dlm/dlmpfs/newdlm.c

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index b46165df5a918..3d75a6ab113b8 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -14,3 +14,13 @@ config DLM_DEBUG
 	Under the debugfs mount point, the name of each lockspace will
 	appear as a file in the "dlm" directory.  The output is the
 	list of resource and locks the local node knows about.
+
+config DLM_DLMPFS
+	tristate "DLM locking filesystem"
+	depends on DLM
+	help
+	Offers DLM locking API over filesystem operations locking callbacks
+	each node needs to create the same named file under this filesystem
+	and do locking API as flock or fcntl on it. It can be used if
+	using an applications that already use file locking for distributed
+	locking operations.
diff --git a/fs/dlm/Makefile b/fs/dlm/Makefile
index 5a471af1d1fe5..157acd6305003 100644
--- a/fs/dlm/Makefile
+++ b/fs/dlm/Makefile
@@ -18,4 +18,4 @@ dlm-y :=			ast.o \
 				user.o \
 				util.o 
 dlm-$(CONFIG_DLM_DEBUG) +=	debug_fs.o
-
+obj-$(CONFIG_DLM_DLMPFS) +=	dlmpfs/
diff --git a/fs/dlm/dlmpfs/Makefile b/fs/dlm/dlmpfs/Makefile
new file mode 100644
index 0000000000000..ccf9d23cc3e0a
--- /dev/null
+++ b/fs/dlm/dlmpfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the linux dlmpfs routines.
+#
+
+obj-y += dlmpfs.o
+
+dlmpfs-objs += inode.o newdlm.o file.o
diff --git a/fs/dlm/dlmpfs/file.c b/fs/dlm/dlmpfs/file.c
new file mode 100644
index 0000000000000..d1a030d57ce8c
--- /dev/null
+++ b/fs/dlm/dlmpfs/file.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* dlmpfs file implementation mostly flock/fcntl
+ */
+
+#include <linux/fs.h>
+#include <linux/dlm.h>
+#include <linux/slab.h>
+#include <linux/dcache.h>
+#include <linux/filelock.h>
+
+#include "internal.h"
+
+struct dlmpfs_file {
+	struct dlmlk *flk;
+};
+
+static int dlmpfs_open(struct inode *inode, struct file *file)
+{
+	struct dlmpfs_fs_info *fsi = DLMPFS_FSI(file->f_inode);
+	char strname[DLMPFS_NUM_RESNAME_LEN];
+	struct dlmpfs_file *fp;
+
+	fp = kzalloc_obj(*fp, GFP_NOFS);
+	if (!fp)
+		return -ENOMEM;
+
+	dlmpfs_fill_resname_num("flock", strname, file->f_inode->i_ino);
+	fp->flk = dlmlk_alloc(fsi->ls, strname, strlen(strname));
+	file->private_data = fp;
+	return simple_open(inode, file);
+}
+
+static int dlmpfs_do_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct dlmpfs_file *fp = file->private_data;
+	unsigned long flags = 0;
+	int mode;
+	int rv;
+
+	mode = lock_is_write(fl) ? DLM_LOCK_EX : DLM_LOCK_PR;
+	/* user should not do that but we catch this case here */
+	if (dlmlk_grmode(fp->flk) == mode)
+		return 0;
+
+	if (!IS_SETLKW(cmd))
+		flags |= DLM_LKF_NOQUEUE;
+
+	/* avoid SH->EX, do SH->NL->EX to avoid deadlocks */
+	if (IS_SETLKW(cmd) &&
+	    dlmlk_grmode(fp->flk) == DLM_LOCK_PR &&
+	    mode == DLM_LOCK_EX)
+		dlmlk_convert(fp->flk, DLM_LOCK_NL, flags);
+
+	rv = dlmlk_convert_interuptible(fp->flk, mode, flags);
+	if (rv == -EINTR)
+		return rv;
+
+	if (dlmlk_sb(fp->flk)->sb_status == -EAGAIN) {
+		rv = -EAGAIN;
+	} else {
+		rv = locks_lock_file_wait(file, fl);
+		/* should never be the case */
+		WARN_ON(rv == -EINTR);
+	}
+
+	return rv;
+}
+
+static void dlmpfs_do_unflock(struct file *file, struct file_lock *fl)
+{
+	struct dlmpfs_file *fp = file->private_data;
+
+	if (dlmlk_grmode(fp->flk) == DLM_LOCK_NL)
+		return;
+
+	dlmlk_convert(fp->flk, DLM_LOCK_NL, 0);
+	locks_lock_file_wait(file, fl);
+}
+
+static int dlmpfs_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	if (!(fl->c.flc_flags & FL_FLOCK))
+		return -ENOLCK;
+
+	if (lock_is_unlock(fl)) {
+		dlmpfs_do_unflock(file, fl);
+		return 0;
+	} else {
+		return dlmpfs_do_flock(file, cmd, fl);
+	}
+}
+
+static int dlmpfs_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct dlmpfs_fs_info *fsi = DLMPFS_FSI(file->f_inode);
+	struct inode *i = file->f_inode;
+
+	if (!(fl->c.flc_flags & FL_POSIX))
+		return -ENOLCK;
+
+	if (cmd == F_CANCELLK)
+		return dlmplk_cancel(fsi->ls, i->i_ino, file, fl);
+	else if (IS_GETLK(cmd))
+		return dlmplk_get(fsi->ls, i->i_ino, file, fl);
+	else if (lock_is_unlock(fl))
+		return dlmplk_unlock(fsi->ls, i->i_ino, file, fl);
+
+	return dlmplk_lock(fsi->ls, i->i_ino, file, cmd, fl);
+}
+
+static int dlmpfs_release(struct inode *inode, struct file *file)
+{
+	struct dlmpfs_file *fp = file->private_data;
+
+	if (fp->flk)
+		dlmlk_free_nowait(fp->flk);
+
+	kfree(fp);
+	file->private_data = NULL;
+	return 0;
+}
+
+const struct file_operations dlmpfs_file_operations = {
+	.open		= dlmpfs_open,
+	.flock		= dlmpfs_flock,
+	.lock		= dlmpfs_lock,
+	.fsync		= noop_fsync,
+	.release	= dlmpfs_release,
+};
+
+const struct inode_operations dlmpfs_file_inode_operations = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
diff --git a/fs/dlm/dlmpfs/inode.c b/fs/dlm/dlmpfs/inode.c
new file mode 100644
index 0000000000000..f79cc545404a9
--- /dev/null
+++ b/fs/dlm/dlmpfs/inode.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/time.h>
+#include <linux/hex.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/sched.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/seq_file.h>
+
+#include "internal.h"
+
+#define DLMPFS_DEFAULT_MODE	0755
+
+static const struct super_operations dlmpfs_ops;
+static const struct inode_operations dlmpfs_dir_inode_operations;
+
+struct dlm_pdata_lvb {
+	__le32 inum;
+#define DLMPFS_LVB_USED	BIT(0)
+	__le32 flags;
+};
+
+struct dlmpfs_inode {
+	struct inode inode;
+	struct dlmlk *lkinum;
+	struct dlmlk *lkfpath;
+};
+
+static inline struct dlmpfs_inode *DLMPFS_I(struct inode *inode)
+{
+	return container_of(inode, struct dlmpfs_inode, inode);
+}
+
+static struct inode *dlmpfs_alloc_inode(struct super_block *sb)
+{
+	struct dlmpfs_inode *di;
+
+	di = kzalloc_obj(*di, GFP_NOFS);
+	if (!di)
+		return NULL;
+
+	inode_init_once(&di->inode);
+	return &di->inode;
+}
+
+static void dlmpfs_free_inode(struct inode *inode)
+{
+	struct dlmpfs_inode *ip = DLMPFS_I(inode);
+
+	if (ip->lkfpath) {
+		dlmlk_free_nowait(ip->lkfpath);
+		ip->lkfpath = NULL;
+	}
+
+	if (ip->lkinum) {
+		dlmlk_free_nowait(ip->lkinum);
+		ip->lkinum = NULL;
+	}
+
+	kfree(ip);
+}
+
+static void dlmpfs_reverse_hex(char *c, u64 value)
+{
+	*c = '0';
+	while (value) {
+		*c-- = hex_asc[value & 0x0f];
+		value >>= 4;
+	}
+}
+
+void dlmpfs_fill_resname_num(const char *prefix, char *resname,
+			     unsigned int num)
+{
+	size_t len;
+
+	memset(resname, 0, DLMPFS_NUM_RESNAME_LEN);
+	len = strlen(prefix);
+	memcpy(resname, prefix, len);
+	resname[len] = ' ';
+	dlmpfs_reverse_hex(resname + len + 1, num);
+}
+
+static unsigned int dlmpfs_reserve_inum(struct dlmpfs_fs_info *fsi,
+					struct dlmpfs_inode *di)
+{
+	char strname[DLMPFS_NUM_RESNAME_LEN];
+	unsigned int num = fsi->last_inum;
+	struct dlm_pdata_lvb *lvb;
+
+retry_inum:
+	num++;
+	if (!num)
+		num++;
+
+	if (!di->lkinum) {
+		dlmpfs_fill_resname_num("inode", strname, num);
+		di->lkinum = dlmlk_alloc(fsi->ls, strname, strlen(strname));
+	}
+
+	dlmlk_convert(di->lkinum, DLM_LOCK_EX, DLM_LKF_VALBLK);
+
+	lvb = dlmlk_lvb(di->lkinum);
+	if (lvb->flags & cpu_to_le32(DLMPFS_LVB_USED)) {
+		dlmlk_free(di->lkinum);
+		di->lkinum = NULL;
+		goto retry_inum;
+	}
+
+	lvb->flags |= cpu_to_le32(DLMPFS_LVB_USED);
+	dlmlk_convert(di->lkinum, DLM_LOCK_NL, DLM_LKF_VALBLK);
+	fsi->last_inum = num;
+	return num;
+}
+
+static int dlmpfs_add_inum_usage(struct dlmpfs_fs_info *fsi,
+				 struct dlmpfs_inode *di,
+				 __le32 num)
+{
+	char strname[DLMPFS_NUM_RESNAME_LEN];
+	struct dlm_pdata_lvb *lvb;
+
+	if (!di->lkinum) {
+		dlmpfs_fill_resname_num("inode", strname, le32_to_cpu(num));
+		di->lkinum = dlmlk_alloc(fsi->ls, strname, strlen(strname));
+	}
+
+	dlmlk_convert(di->lkinum, DLM_LOCK_NL, DLM_LKF_VALBLK);
+
+	lvb = dlmlk_lvb(di->lkinum);
+	if (!(lvb->flags & cpu_to_le32(DLMPFS_LVB_USED))) {
+		dlmlk_free(di->lkinum);
+		di->lkinum = NULL;
+		/* failed to add usage */
+		return 1;
+	}
+
+	return 0;
+}
+
+static unsigned int dlmpfs_alloc_inode_num(struct dlmpfs_fs_info *fsi,
+					   struct dlmpfs_inode *di,
+					   const void *res, size_t reslen)
+{
+	struct dlm_pdata_lvb *lvb;
+	unsigned int num;
+	int rv;
+
+	if (!di->lkfpath)
+		di->lkfpath = dlmlk_alloc(fsi->ls, res, reslen);
+
+retry:
+	dlmlk_convert(di->lkfpath, DLM_LOCK_NL, DLM_LKF_VALBLK);
+
+	lvb = dlmlk_lvb(di->lkfpath);
+	/* cluster wide inum being set */
+	if (lvb->flags & cpu_to_le32(DLMPFS_LVB_USED)) {
+		/* increment inode user */
+		rv = dlmpfs_add_inum_usage(fsi, di, lvb->inum);
+		if (rv)
+			goto retry;
+
+		return le32_to_cpu(lvb->inum);
+	}
+
+	dlmlk_convert(di->lkfpath, DLM_LOCK_EX, DLM_LKF_VALBLK);
+	if (lvb->flags & cpu_to_le32(DLMPFS_LVB_USED)) {
+		/* increment inode user */
+		rv = dlmpfs_add_inum_usage(fsi, di, lvb->inum);
+		if (rv)
+			goto retry;
+
+		dlmlk_convert(di->lkfpath, DLM_LOCK_NL, 0);
+		return le32_to_cpu(lvb->inum);
+	}
+
+	num = dlmpfs_reserve_inum(fsi, di);
+	lvb->flags |= cpu_to_le32(DLMPFS_LVB_USED);
+	lvb->inum = cpu_to_le32(num);
+
+	dlmlk_convert(di->lkfpath, DLM_LOCK_NL, DLM_LKF_VALBLK);
+	return num;
+}
+
+static struct dlmpfs_inode *dlmpfs_new_inode(struct super_block *sb)
+{
+	return DLMPFS_I(new_inode(sb));
+}
+
+static struct inode *dlmpfs_get_inode(struct super_block *sb, const void *res,
+				      size_t reslen, const struct inode *dir,
+				      umode_t mode, dev_t dev)
+{
+	struct dlmpfs_inode *dinode = dlmpfs_new_inode(sb);
+	struct dlmpfs_fs_info *fsi = sb->s_fs_info;
+	struct inode *inode;
+
+	if (dinode) {
+		inode = &dinode->inode;
+		inode->i_ino = dlmpfs_alloc_inode_num(fsi, dinode, res, reslen);
+		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+		simple_inode_init_ts(inode);
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+			inode->i_op = &dlmpfs_file_inode_operations;
+			inode->i_fop = &dlmpfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &dlmpfs_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inc_nlink(inode);
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+	}
+	return inode;
+}
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+/* SMP-safe */
+static int
+dlmpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+	     struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	unsigned char *resname[DLM_RESNAME_MAXLEN] = {};
+	struct inode *inode;
+	char *path, *pbuf;
+	size_t pathlen;
+	int error;
+
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		break;
+	case S_IFDIR:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	pbuf = (char *)__get_free_page(GFP_KERNEL);
+	if (!pbuf)
+		return -ENOSPC;
+
+	path = dentry_path_raw(dentry, pbuf, PAGE_SIZE);
+	if (IS_ERR(path)) {
+		free_page((unsigned long)pbuf);
+		return -ENOSPC;
+	}
+
+	pathlen = strlen(path);
+	if (pathlen > DLM_RESNAME_MAXLEN) {
+		error = -ENAMETOOLONG;
+		goto out;
+	}
+
+	memcpy(resname, path, pathlen);
+	/* use next power of 2 as pathlen */
+	pathlen = ALIGN(pathlen, 8);
+	error = -ENOSPC;
+	inode = dlmpfs_get_inode(dir->i_sb, resname, pathlen, dir, mode, dev);
+	if (inode) {
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name, NULL,
+						     NULL);
+		if (error) {
+			iput(inode);
+			goto out;
+		}
+
+		d_make_persistent(dentry, inode);
+		error = 0;
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	}
+
+out:
+	free_page((unsigned long)pbuf);
+	return error;
+}
+
+static struct dentry *dlmpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				   struct dentry *dentry, umode_t mode)
+{
+	int retval = dlmpfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+
+	if (!retval)
+		inc_nlink(dir);
+	return ERR_PTR(retval);
+}
+
+static int dlmpfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl)
+{
+	return dlmpfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
+}
+
+static const struct inode_operations dlmpfs_dir_inode_operations = {
+	.create		= dlmpfs_create,
+	.lookup		= simple_lookup,
+	.mkdir		= dlmpfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.unlink         = simple_unlink,
+	.mknod          = dlmpfs_mknod,
+};
+
+/*
+ * Display the mount options in /proc/mounts.
+ */
+static int dlmpfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct dlmpfs_fs_info *fsi = root->d_sb->s_fs_info;
+
+	if (fsi->mount_opts.mode != DLMPFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
+	return 0;
+}
+
+static const struct super_operations dlmpfs_ops = {
+	.alloc_inode	= dlmpfs_alloc_inode,
+	.free_inode	= dlmpfs_free_inode,
+	.statfs		= simple_statfs,
+	.drop_inode	= inode_just_drop,
+	.show_options	= dlmpfs_show_options,
+};
+
+enum dlmpfs_param {
+	Opt_mode,
+	Opt_clname,
+	Opt_lsname,
+};
+
+static const struct fs_parameter_spec dlmpfs_fs_parameters[] = {
+	fsparam_u32oct("mode",	Opt_mode),
+	fsparam_string("clname",	Opt_clname),
+	fsparam_string("lsname",	Opt_lsname),
+	{}
+};
+
+static int dlmpfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct dlmpfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, dlmpfs_fs_parameters, param, &result);
+	if (opt == -ENOPARAM) {
+		opt = vfs_parse_fs_param_source(fc, param);
+		if (opt != -ENOPARAM)
+			return opt;
+		/*
+		 * We might like to report bad mount options here;
+		 * but traditionally dlmpfs has ignored all mount options,
+		 * and as it is used as a !CONFIG_SHMEM simple substitute
+		 * for tmpfs, better continue to ignore other mount options.
+		 */
+		return 0;
+	}
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_mode:
+		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_clname:
+		strscpy(fsi->clname, param->string, DLM_RESNAME_MAXLEN);
+		break;
+	case Opt_lsname:
+		strscpy(fsi->lsname, param->string, DLM_RESNAME_MAXLEN);
+		break;
+	}
+
+	return 0;
+}
+
+static int dlmpfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct dlmpfs_fs_info *fsi = sb->s_fs_info;
+	unsigned char res[8] = {};
+	struct inode *inode;
+	int rv;
+
+	rv = dlmls_new(fsi->lsname, fsi->clname, 0, 8, NULL, NULL,
+		       NULL, &fsi->ls);
+	if (rv) {
+		fsi->ls = NULL;
+		return rv;
+	}
+
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_magic		= DLMPFS_MAGIC;
+	sb->s_op		= &dlmpfs_ops;
+	sb->s_d_flags		= DCACHE_DONTCACHE;
+	sb->s_time_gran		= 1;
+
+	res[0] = '/';
+	inode = dlmpfs_get_inode(sb, res, sizeof(res), NULL, S_IFDIR | fsi->mount_opts.mode, 0);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dlmpfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, dlmpfs_fill_super);
+}
+
+static void dlmpfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations dlmpfs_context_ops = {
+	.free		= dlmpfs_free_fc,
+	.parse_param	= dlmpfs_parse_param,
+	.get_tree	= dlmpfs_get_tree,
+};
+
+static int dlmpfs_init_fs_context(struct fs_context *fc)
+{
+	struct dlmpfs_fs_info *fsi;
+
+	fsi = kzalloc_obj(*fsi, GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	strscpy(fsi->clname, "cluster");
+	strscpy(fsi->lsname, "dlmpfs");
+	fsi->mount_opts.mode = DLMPFS_DEFAULT_MODE;
+	fc->s_fs_info = fsi;
+	fc->ops = &dlmpfs_context_ops;
+	return 0;
+}
+
+static void dlmpfs_kill_sb(struct super_block *sb)
+{
+	struct dlmpfs_fs_info *fsi = sb->s_fs_info;
+	struct dlmls *ls = fsi->ls;
+
+	kfree(sb->s_fs_info);
+	kill_anon_super(sb);
+
+	if (ls)
+		dlmls_release(ls, 2);
+}
+
+static struct file_system_type dlmpfs_fs_type = {
+	.name		= "dlmpfs",
+	.init_fs_context = dlmpfs_init_fs_context,
+	.parameters	= dlmpfs_fs_parameters,
+	.kill_sb	= dlmpfs_kill_sb,
+};
+
+static int __init init_dlmpfs_fs(void)
+{
+	return register_filesystem(&dlmpfs_fs_type);
+}
+fs_initcall(init_dlmpfs_fs);
diff --git a/fs/dlm/dlmpfs/internal.h b/fs/dlm/dlmpfs/internal.h
new file mode 100644
index 0000000000000..7119a005fca61
--- /dev/null
+++ b/fs/dlm/dlmpfs/internal.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __DLMPFS_H__
+#define __DLMPFS_H__
+
+#include <linux/fs.h>
+#include <linux/dlm.h>
+
+struct dlmls;
+struct dlmlk;
+
+#define DLMPFS_NUM_RESNAME_LEN 32
+
+struct dlmpfs_mount_opts {
+	umode_t mode;
+};
+
+struct dlmpfs_fs_info {
+	struct dlmpfs_mount_opts mount_opts;
+	unsigned int last_inum;
+	char clname[DLM_RESNAME_MAXLEN];
+	char lsname[DLM_RESNAME_MAXLEN];
+	struct dlmls *ls;
+};
+
+extern const struct file_operations dlmpfs_file_operations;
+extern const struct inode_operations dlmpfs_file_inode_operations;
+
+void dlmpfs_fill_resname_num(const char *prefix, char *resname,
+			     unsigned int num);
+struct dlmlk *dlmlk_alloc(struct dlmls *ls, const void *name, size_t namelen);
+void dlmlk_free(struct dlmlk *lk);
+void dlmlk_free_nowait(struct dlmlk *lk);
+void dlmlk_convert(struct dlmlk *lk, int mode, unsigned long flags);
+int dlmlk_convert_interuptible(struct dlmlk *lk, int mode, unsigned long flags);
+const struct dlm_lksb *dlmlk_sb(struct dlmlk *lk);
+int dlmlk_grmode(struct dlmlk *lk);
+int dlmls_new(const char *lsname, const char *clname,
+	      uint32_t flags, int lvblen,
+	      const struct dlm_lockspace_ops *ops,
+	      void *ops_arg, int *ops_result,
+	      struct dlmls **ls_ret);
+void dlmls_release(struct dlmls *ls, uint32_t flags);
+int dlmpfs_get_path(struct dentry *dentry, char **path,
+		    size_t *pathlen, char **page_buf);
+
+int dlmplk_lock(struct dlmls *ls, u64 number, struct file *file,
+		int cmd, struct file_lock *fl);
+int dlmplk_unlock(struct dlmls *ls, u64 number, struct file *file,
+		  struct file_lock *fl);
+int dlmplk_cancel(struct dlmls *ls, u64 number, struct file *file,
+		  struct file_lock *fl);
+int dlmplk_get(struct dlmls *ls, u64 number, struct file *file,
+	       struct file_lock *fl);
+static inline void *dlmlk_lvb(struct dlmlk *lk)
+{
+	return (void *)dlmlk_sb(lk)->sb_lvbptr;
+}
+
+static inline struct dlmpfs_fs_info *DLMPFS_FSI(const struct inode *inode)
+{
+	return inode->i_sb->s_fs_info;
+}
+
+#endif /* __DLMPFS_H__ */
diff --git a/fs/dlm/dlmpfs/newdlm.c b/fs/dlm/dlmpfs/newdlm.c
new file mode 100644
index 0000000000000..0f565ada0268d
--- /dev/null
+++ b/fs/dlm/dlmpfs/newdlm.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* creating a better to use DLM API above the current API
+ */
+
+#include <linux/dlm.h>
+#include <linux/delay.h>
+#include <linux/filelock.h>
+#include <linux/dlm_plock.h>
+
+#include "internal.h"
+
+struct dlmlk {
+	/* need to aligned */
+	unsigned char lvb[8];
+	struct dlm_lksb sb;
+	struct completion compl;
+	struct dlmls *ls;
+	bool nowait;
+	unsigned char name[DLM_RESNAME_MAXLEN];
+	size_t namelen;
+	int grmode;
+};
+
+struct dlmls {
+	dlm_lockspace_t *ls;
+	struct kref kref;
+	bool released;
+};
+
+static void release_ls(struct kref *kref)
+{
+	struct dlmls *ls = container_of(kref, struct dlmls, kref);
+
+	kfree(ls);
+}
+
+static void ast(void *astarg)
+{
+	struct dlmlk *lk = astarg;
+
+	if (lk->nowait) {
+		WARN_ON(lk->sb.sb_status != -DLM_EUNLOCK);
+		kref_put(&lk->ls->kref, release_ls);
+		kfree(lk);
+	} else {
+		complete(&lk->compl);
+	}
+}
+
+static int dlm_lock_sync(struct dlmlk *lk,
+			 int mode, uint32_t _flags,
+			 bool interruptible)
+{
+	unsigned long flags = _flags;
+	int rv;
+
+	/* invalid sb_status because racing API with prev status */
+	lk->sb.sb_status = -1;
+
+	/* stupid DLM_LKF_CONVERT setting */
+	if (lk->grmode != DLM_LOCK_IV)
+		flags |= DLM_LKF_CONVERT;
+
+retry:
+	rv = dlm_lock(lk->ls->ls, mode, &lk->sb, flags, lk->name, lk->namelen,
+		      0, ast, lk, NULL);
+	switch (rv) {
+	case 0:
+		break;
+	case -EBUSY:
+		/* stupid DLM API behaviour */
+		mdelay(50);
+		goto retry;
+	default:
+		goto out;
+	}
+
+	if (interruptible) {
+		rv = wait_for_completion_interruptible(&lk->compl);
+		if (rv == -ERESTARTSYS) {
+			dlm_unlock(lk->ls->ls, lk->sb.sb_lkid,
+				   DLM_LKF_CANCEL, NULL, lk);
+
+			wait_for_completion(&lk->compl);
+			switch (lk->sb.sb_status) {
+			case -DLM_ECANCEL:
+				rv = -EINTR;
+				break;
+			case 0:
+				rv = 0;
+				break;
+			default:
+				rv = -1;
+				WARN_ON(1);
+				break;
+			}
+		}
+	} else {
+		/* TODO waiting on demote makes only sense if DLM_LKF_VALBLK */
+		wait_for_completion(&lk->compl);
+	}
+
+	/* user might can request that because the user space user
+	 * makes stupid things like NL -> NL conversions.
+	 */
+	if (!rv)
+		lk->grmode = mode;
+
+out:
+	return rv;
+}
+
+static int dlm_unlock_sync(struct dlmlk *lk, bool nowait)
+{
+	int rv;
+
+	/* never did a lock change */
+	if (lk->grmode == DLM_LOCK_IV)
+		return 0;
+
+	rv = dlm_unlock(lk->ls->ls, lk->sb.sb_lkid, 0,
+			NULL, lk);
+	if (rv)
+		goto out;
+
+	if (!nowait)
+		wait_for_completion(&lk->compl);
+
+out:
+	return rv;
+}
+
+struct dlmlk *dlmlk_alloc(struct dlmls *ls, const void *name, size_t namelen)
+{
+	struct dlmlk *lk;
+
+	lk = kzalloc_obj(*lk, GFP_NOFS);
+	if (!lk)
+		return NULL;
+
+	lk->ls = ls;
+	kref_get(&ls->kref);
+	lk->sb.sb_lvbptr = lk->lvb;
+	init_completion(&lk->compl);
+	memcpy(lk->name, name, namelen);
+	lk->namelen = namelen;
+	lk->grmode = DLM_LOCK_IV;
+
+	/* TODO tell DLM to perform master lookup, even before alloc */
+	return lk;
+}
+
+void dlmlk_convert(struct dlmlk *lk, int mode, unsigned long flags)
+{
+	int rv;
+
+	rv = dlm_lock_sync(lk, mode, flags, false);
+	WARN_ON(rv);
+}
+
+int dlmlk_convert_interuptible(struct dlmlk *lk, int mode, unsigned long flags)
+{
+	/* demotes never run into contention, TODO more states */
+	WARN_ON(mode == DLM_LOCK_NL);
+	/* can return -EINTR */
+	return dlm_lock_sync(lk, mode, flags, true);
+}
+
+void dlmlk_free(struct dlmlk *lk)
+{
+	int rv;
+
+	/* if we already released we don't perform unlocks */
+	if (!lk->ls->released) {
+		rv = dlm_unlock_sync(lk, false);
+		WARN_ON(rv);
+	}
+
+	kref_put(&lk->ls->kref, release_ls);
+	kfree(lk);
+}
+
+void dlmlk_free_nowait(struct dlmlk *lk)
+{
+	int rv;
+
+	/* if we already released we don't perform unlocks */
+	if (!lk->ls->released) {
+		rv = dlm_unlock_sync(lk, true);
+		WARN_ON(rv);
+	} else {
+		kref_put(&lk->ls->kref, release_ls);
+		kfree(lk);
+	}
+}
+
+const struct dlm_lksb *dlmlk_sb(struct dlmlk *lk)
+{
+	return &lk->sb;
+}
+
+int dlmlk_grmode(struct dlmlk *lk)
+{
+	return lk->grmode;
+}
+
+int dlmls_new(const char *lsname, const char *clname,
+	      uint32_t flags, int lvblen,
+	      const struct dlm_lockspace_ops *ops,
+	      void *ops_arg, int *ops_result,
+	      struct dlmls **ls_ret)
+{
+	struct dlmls *ls;
+	int rv;
+
+	ls = kzalloc_obj(*ls, GFP_NOFS);
+	if (!ls)
+		return -ENOMEM;
+
+	rv = dlm_new_lockspace(lsname, clname, flags, lvblen,
+			       ops, ops_arg, ops_result, &ls->ls);
+	if (!rv) {
+		kref_init(&ls->kref);
+		*ls_ret = ls;
+	}
+
+	return rv;
+}
+
+void dlmls_release(struct dlmls *ls, uint32_t flags)
+{
+	ls->released = true;
+	dlm_release_lockspace(ls->ls, flags);
+}
+
+int dlmplk_lock(struct dlmls *ls, u64 number, struct file *file,
+		int cmd, struct file_lock *fl)
+{
+	return dlm_posix_lock(ls->ls, number, file, cmd, fl);
+}
+
+int dlmplk_unlock(struct dlmls *ls, u64 number, struct file *file,
+		  struct file_lock *fl)
+{
+	return dlm_posix_unlock(ls->ls, number, file, fl);
+}
+
+int dlmplk_cancel(struct dlmls *ls, u64 number, struct file *file,
+		  struct file_lock *fl)
+{
+	return dlm_posix_cancel(ls->ls, number, file, fl);
+}
+
+int dlmplk_get(struct dlmls *ls, u64 number, struct file *file,
+	       struct file_lock *fl)
+{
+	return dlm_posix_get(ls->ls, number, file, fl);
+}
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76cc..2cd5eeaac51ce 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,7 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define DLMPFS_MAGIC		0x858458f7	/* some random number */
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.43.0


