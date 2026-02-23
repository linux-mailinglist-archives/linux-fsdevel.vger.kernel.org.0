Return-Path: <linux-fsdevel+bounces-78056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBreK6/enGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41C17EF48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D453068ED2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42537E316;
	Mon, 23 Feb 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgB1SGvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6937D11D;
	Mon, 23 Feb 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888261; cv=none; b=k3TSknDm+I8uWjfjhxFdZ1CmaCE+gLuai6KwUqv7eZ7JrrqROeK9H0fNpzYiWbQaqjVdq+PTmTQ0+QIj3gvSfX+BXJnB5Dks9A8PvV7qz5PqraHFRFQFsqVZQSq+FNqvNGLVWjaXebzXLyKm9COE0KkfQipxxhOeZumYjwdgLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888261; c=relaxed/simple;
	bh=+PUHTd8BQpLmKKrK21V4GKzWwMG+6KPf64ilP+wAi4g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5+9jrYbujKvtt5ULO0cllGIpxgHd4WYN85vB04QT0qpT0+Ew72ugg5uKe4QsV5JkNgVXsiaSN3z55j327zBI6P/Um/HXDGjPh2cjHJEooOzC4/AwVDlRjl8wgLcLZEbTBv+QLGU3vjkPL9mB1VbEHqXWEIBpFC4UGm2enflUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgB1SGvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C29C19421;
	Mon, 23 Feb 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888261;
	bh=+PUHTd8BQpLmKKrK21V4GKzWwMG+6KPf64ilP+wAi4g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AgB1SGvnrsTAarbrCpz6YCFbg4apdxy7ewVtwyjl6Gvf0XjIzVbjAeSfHYIKsjmqI
	 WB7QqbURF7yx12NXN64XJVFQm4D/RDEBQmBgmH4cQtS4LvpQ8rAinoOaeHpvNKvKnS
	 gP0Z4J4q58nqKlgelDEQuhxiINcHwUFsxd7XG7KCjnGyOx5WV+8xwOJcqP3Rf3xMIb
	 OUjHorDegTGXbp4xfSd7pp7aoUC/AQf9U0mm5EqqTMs8THrOTxy+YfXFMHZX49156G
	 iU/vwOLvxuDz+fWJzmDGNc61bHJMBqdQj5AJzqrX5pWrwxmLO05/x14mHA9LbI2r/E
	 VV7f3epSjK3dQ==
Date: Mon, 23 Feb 2026 15:11:00 -0800
Subject: [PATCH 09/33] fuse: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bpf@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188734438.3935739.5685285881720047871.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78056-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C41C17EF48
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create a per-inode flag to control whether or not this inode actually
uses iomap.  This is required for non-regular files because iomap
doesn't apply there; and enables fuse filesystems to provide some
non-iomap files if desired.

Note that more code will be added to fuse_iomap_init_inode in subsequent
patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h          |    6 ++++--
 fs/fuse/fuse_iomap.h      |   13 ++++++++++++
 include/uapi/linux/fuse.h |    3 +++
 fs/fuse/dir.c             |   14 +++++++++++--
 fs/fuse/file.c            |    3 +++
 fs/fuse/fuse_iomap.c      |   47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    6 ++++--
 7 files changed, 86 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 46c2c660a39484..011b252a437855 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -264,6 +264,8 @@ enum {
 	 * or the fuse server has an exclusive "lease" on distributed fs
 	 */
 	FUSE_I_EXCLUSIVE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -1257,12 +1259,12 @@ void fuse_init_common(struct inode *inode);
 /**
  * Initialize inode and file operations on a directory
  */
-void fuse_init_dir(struct inode *inode);
+void fuse_init_dir(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on a symlink
  */
-void fuse_init_symlink(struct inode *inode);
+void fuse_init_symlink(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Change attributes of an inode
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 129680b056ebea..34f2c75416eb62 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -23,11 +23,24 @@ extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
+
+void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_inode_has_iomap(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_IOMAP, &fi->state);
+}
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2d35dcfbf8aaf5..88f76f4be749a7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,6 +245,7 @@
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -587,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
+#define FUSE_ATTR_IOMAP		(1 << 3)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9abec6f072ac73..10db4dc046930f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2510,9 +2511,10 @@ void fuse_init_common(struct inode *inode)
 	inode->i_op = &fuse_common_inode_operations;
 }
 
-void fuse_init_dir(struct inode *inode)
+void fuse_init_dir(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_op = &fuse_dir_inode_operations;
 	inode->i_fop = &fuse_dir_operations;
@@ -2522,6 +2524,9 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
 	fi->rdc.version = 0;
+
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 }
 
 static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
@@ -2540,9 +2545,14 @@ static const struct address_space_operations fuse_symlink_aops = {
 	.read_folio	= fuse_symlink_read_folio,
 };
 
-void fuse_init_symlink(struct inode *inode)
+void fuse_init_symlink(struct inode *inode, struct fuse_attr *attr)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
 	inode->i_op = &fuse_symlink_inode_operations;
 	inode->i_data.a_ops = &fuse_symlink_aops;
 	inode_nohighmem(inode);
+
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 21a6f2cd7bfaa9..4a7b0c190aa8e4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -3214,6 +3215,8 @@ void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
 
+	if (fc->iomap)
+		fuse_iomap_init_inode(inode, attr);
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 4b63bb32167877..39c9239c64435a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -616,3 +616,50 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_flush_requests(fc);
 	fuse_send_destroy(fm);
 }
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
+{
+	ASSERT(get_fuse_conn(inode)->iomap);
+
+	if (!(attr->flags & FUSE_ATTR_IOMAP))
+		return;
+
+	/*
+	 * Any file being used in conjunction with iomap must also have the
+	 * exclusive flag set because iomap requires cached file attributes to
+	 * be correct at any time.  This applies even to non-regular files
+	 * (e.g. directories) because we need to do ACL and attribute
+	 * inheritance the same way a local filesystem would do.  If exclusive
+	 * mode isn't set, then we won't use iomap.
+	 */
+	if (!fuse_inode_is_exclusive(inode)) {
+		ASSERT(fuse_inode_is_exclusive(inode));
+		return;
+	}
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	fuse_inode_set_iomap(inode);
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_inode_clear_iomap(inode);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e45b53bfce4b2d..27699a6c11f66b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -198,6 +198,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_evict_inode(inode);
 	fuse_inode_clear_exclusive(inode);
 }
 
@@ -446,10 +448,10 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		fuse_init_file_inode(inode, attr);
 		break;
 	case S_IFDIR:
-		fuse_init_dir(inode);
+		fuse_init_dir(inode, attr);
 		break;
 	case S_IFLNK:
-		fuse_init_symlink(inode);
+		fuse_init_symlink(inode, attr);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:


