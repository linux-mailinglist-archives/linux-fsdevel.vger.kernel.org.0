Return-Path: <linux-fsdevel+bounces-45821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C2A7D075
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB053188C53C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951A1AA1EC;
	Sun,  6 Apr 2025 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Z6eU+TSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFX5OLvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B040157A48;
	Sun,  6 Apr 2025 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972351; cv=none; b=Yjj0N7icJPafO4eQs8IO6rzujax0gyeC0+ufJA3UbJBCE64GoyHMuHjETPPEoOBaLqNpoQ+NYXEH39wMnMLfj9F7v7NNHNRp/i9WQO+DR15LiaQhyb6EL0kCCTTr0KxbKzBCVRht206G5p0pwyvoHbTF7k/9pF6pYyFZpfFILgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972351; c=relaxed/simple;
	bh=XLFo39BVEoAoBBqV9syYijIuPWDZsYIEBwJfJJ9SE7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no88pUzG6JDkyEzey1VWP8FYBPZxI8FpFi1etZqPI54+CkOgkqSZlizN+QVUBdqUs15iIeuI/y8NftNywYl5VcpSlOBVQWhvPgsxuv2ueOGeWlsMGRYBYH7eUpN5jjs3AhXFRzasDJLtcv22vCnQ4cer9IoklKYTKlhaR6bmk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Z6eU+TSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFX5OLvk; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 689D0202428;
	Sun,  6 Apr 2025 16:45:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 06 Apr 2025 16:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972348; x=
	1743975948; bh=QTBCQns44FbkVkYYlhRmyTJiJhR3fKsYOUyxwrjONOk=; b=Z
	6eU+TSYjzvhSATxKOv4qeVP8Fp6YdlM5ZPqEaY8eD3viFzVBy2c4FX0rK2TJVB/4
	PahRk80cuzQZ6QaDiMpTnQ96jOoOKy4UnxWKB+HrUljCZayFPHlHlqm7Za+FyQyE
	8XpU25HTPh6zTQcucX0TUyKOV1fSFGMR68O09AyO0/uwH9TCZzjcW2TWRaYOTgVp
	GFgswoHMON938DmgTgyRI3OxTg0Nresc0snJHkzA3vXyMme8M1unfS85jwCWSIAX
	NOviCzcFEdaGgMwSk4oFLhyJSmpc0pruimhDSnPd1TfIOpZ01OTyE7GPUo3BByEs
	+y2SUutmf0Gg06MYUE2YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972348; x=1743975948; bh=Q
	TBCQns44FbkVkYYlhRmyTJiJhR3fKsYOUyxwrjONOk=; b=tFX5OLvkNpa63wFdf
	lzxXEiUsPQ0MEPkQP818VH0+J4TGfWRyW6ckhHt0qYiizUTlR8Re+uslC8N61JFy
	SDTIi89oREambWYknuw2C0BPWqU2P8hwUFGG5NjZl3xLSX3PDj/fVgVZfYTKGGsz
	LGLGf9r9ckgMFYOcoZeEphrq7xM9sMra34W7QW1TMKq4O+nf64zPh5UP25rdsD8J
	ykCAR5a1G9ryN8VijtbKmQFk8/tK6A1iC0aozQ++fK6IT5qaPpwwLvf4zPKXf9V3
	y0iKIh5wPQ9+/URy61oA+M42rxFgGDtYuR//dSRlXZtPlI5MgYDfVdmtfOk2aVk7
	3WR4A==
X-ME-Sender: <xms:9-fyZ9w2WnKfPbS8Tx1etmyIgbFtvKpGDHhGz6NmfMmjirbj2PCHuw>
    <xme:9-fyZ9QfeWDZw6FXorJf1MCQFyX1ZLUfWDD3xk7Aj33nEW5kLPAoFOFha6MSbaYjO
    loP2WyXQbT0rWPnmAY>
X-ME-Received: <xmr:9-fyZ3Vd-wwYCM3qYxcVnFcAdrzaL1kQmveRQuzSGwQDUDkHxtmEb4tCwjps5FjQsL-EFJcch0RUjNjdtj_EbGrbTccbj4YZNSmfpVuyMYbWOJOSDCqZaro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9-fyZ_hUvT9v7vPnQjh0KqPlUcHK_dFAKwocHkEBoBRqbH_nAwK7Cg>
    <xmx:9-fyZ_DB194p2WK61_9QoBzuruZUc94hrW1jc7T6n8SL-k1PkSV_Nw>
    <xmx:9-fyZ4LPQSRmLLBlE5CGBTvl25Ej-lXkdmM2s3SdM6K27FI0qDGDEQ>
    <xmx:9-fyZ-C36QqA_9VqxleDGbuKtuJDtTkEvhS9YradxJT8BgVoSazhdA>
    <xmx:-OfyZ-CCy9hZF2DLlKCjOpzkJ4kYT1YA5XevOJSAdI0ijnHSuJV1rz6m>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:45:42 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for .L
Date: Sun,  6 Apr 2025 21:43:02 +0100
Message-ID: <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating a new file for shared code between vfs_inode.c and
vfs_inode_dotl.c.  Same change for non-.L will be added in a following
commit.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/Makefile         |   3 +-
 fs/9p/ino_path.c       | 114 +++++++++++++++++++++++++++++++++++++++++
 fs/9p/v9fs.h           |  54 +++++++++++++------
 fs/9p/vfs_inode.c      |  20 ++++++--
 fs/9p/vfs_inode_dotl.c |  91 +++++++++++++++++++++++++++++---
 fs/9p/vfs_super.c      |  10 +++-
 6 files changed, 262 insertions(+), 30 deletions(-)
 create mode 100644 fs/9p/ino_path.c

diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index e7800a5c7395..38c3ceb26274 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_9P_FS) := 9p.o
 	vfs_dentry.o \
 	v9fs.o \
 	fid.o  \
-	xattr.o
+	xattr.o \
+	ino_path.o
 
 9p-$(CONFIG_9P_FSCACHE) += cache.o
 9p-$(CONFIG_9P_FS_POSIX_ACL) += acl.o
diff --git a/fs/9p/ino_path.c b/fs/9p/ino_path.c
new file mode 100644
index 000000000000..a4e0aef81618
--- /dev/null
+++ b/fs/9p/ino_path.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Specific operations on the v9fs_ino_path structure.
+ *
+ * Copyright (C) 2025 by Tingmao Wang <m@maowtm.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/dcache.h>
+
+#include <linux/posix_acl.h>
+#include <net/9p/9p.h>
+#include <net/9p/client.h>
+#include "v9fs.h"
+
+/*
+ * Must hold rename_sem due to traversing parents
+ */
+struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
+{
+	struct v9fs_ino_path *path;
+	size_t path_components = 0;
+	struct dentry *curr = dentry;
+	ssize_t i;
+
+	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
+
+	rcu_read_lock();
+
+    /* Don't include the root dentry */
+	while (curr->d_parent != curr) {
+		path_components++;
+		curr = curr->d_parent;
+	}
+	if (WARN_ON(path_components > SSIZE_MAX)) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	path = kmalloc(struct_size(path, names, path_components),
+		       GFP_KERNEL);
+	if (!path) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	path->nr_components = path_components;
+	curr = dentry;
+	for (i = path_components - 1; i >= 0; i--) {
+		take_dentry_name_snapshot(&path->names[i], curr);
+		curr = curr->d_parent;
+	}
+	WARN_ON(curr != curr->d_parent);
+	rcu_read_unlock();
+	return path;
+}
+
+void free_ino_path(struct v9fs_ino_path *path)
+{
+	if (path) {
+		for (size_t i = 0; i < path->nr_components; i++)
+			release_dentry_name_snapshot(&path->names[i]);
+		kfree(path);
+	}
+}
+
+/*
+ * Must hold rename_sem due to traversing parents
+ */
+bool ino_path_compare(struct v9fs_ino_path *ino_path,
+			     struct dentry *dentry)
+{
+	struct dentry *curr = dentry;
+	struct qstr *curr_name;
+	struct name_snapshot *compare;
+	ssize_t i;
+
+	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
+
+	rcu_read_lock();
+	for (i = ino_path->nr_components - 1; i >= 0; i--) {
+		if (curr->d_parent == curr) {
+			/* We're supposed to have more components to walk */
+			rcu_read_unlock();
+			return false;
+		}
+		curr_name = &curr->d_name;
+		compare = &ino_path->names[i];
+		/*
+		 * We can't use hash_len because it is salted with the parent
+		 * dentry pointer.  We could make this faster by pre-computing our
+		 * own hashlen for compare and ino_path outside, probably.
+		 */
+		if (curr_name->len != compare->name.len) {
+			rcu_read_unlock();
+			return false;
+		}
+		if (strncmp(curr_name->name, compare->name.name,
+			    curr_name->len) != 0) {
+			rcu_read_unlock();
+			return false;
+		}
+		curr = curr->d_parent;
+	}
+	rcu_read_unlock();
+	if (curr != curr->d_parent) {
+		/* dentry is deeper than ino_path */
+		return false;
+	}
+	return true;
+}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..5c85923aa2dd 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -10,6 +10,7 @@
 
 #include <linux/backing-dev.h>
 #include <linux/netfs.h>
+#include <linux/dcache.h>
 
 /**
  * enum p9_session_flags - option flags for each 9P session
@@ -31,16 +32,17 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U    = 0x01,
-	V9FS_PROTO_2000L    = 0x02,
-	V9FS_ACCESS_SINGLE  = 0x04,
-	V9FS_ACCESS_USER    = 0x08,
-	V9FS_ACCESS_CLIENT  = 0x10,
-	V9FS_POSIX_ACL      = 0x20,
-	V9FS_NO_XATTR       = 0x40,
-	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO      = 0x100,
-	V9FS_SYNC           = 0x200
+	V9FS_PROTO_2000U      = 0x01,
+	V9FS_PROTO_2000L      = 0x02,
+	V9FS_ACCESS_SINGLE    = 0x04,
+	V9FS_ACCESS_USER      = 0x08,
+	V9FS_ACCESS_CLIENT    = 0x10,
+	V9FS_POSIX_ACL        = 0x20,
+	V9FS_NO_XATTR         = 0x40,
+	V9FS_IGNORE_QV        = 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO        = 0x100,
+	V9FS_SYNC             = 0x200,
+	V9FS_INODE_IDENT_PATH = 0x400,
 };
 
 /**
@@ -133,11 +135,27 @@ struct v9fs_session_info {
 /* cache_validity flags */
 #define V9FS_INO_INVALID_ATTR 0x01
 
+struct v9fs_ino_path {
+	size_t nr_components;
+	struct name_snapshot names[] __counted_by(nr_components);
+};
+
+extern struct v9fs_ino_path *make_ino_path(struct dentry *dentry);
+extern void free_ino_path(struct v9fs_ino_path *path);
+extern bool ino_path_compare(struct v9fs_ino_path *ino_path,
+	struct dentry *dentry);
+
 struct v9fs_inode {
 	struct netfs_inode netfs; /* Netfslib context and vfs inode */
 	struct p9_qid qid;
 	unsigned int cache_validity;
 	struct mutex v_mutex;
+
+	/*
+	 * Only for filesystems with inode_ident=path.  Lifetime is the same as
+	 * this inode
+	 */
+	struct v9fs_ino_path *path;
 };
 
 static inline struct v9fs_inode *V9FS_I(const struct inode *inode)
@@ -188,7 +206,8 @@ extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
 extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 					      struct p9_fid *fid,
-					      struct super_block *sb, int new);
+					      struct super_block *sb,
+					      struct dentry *dentry, int new);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -217,6 +236,11 @@ static inline int v9fs_proto_dotl(struct v9fs_session_info *v9ses)
 	return v9ses->flags & V9FS_PROTO_2000L;
 }
 
+static inline int v9fs_inode_ident_path(struct v9fs_session_info *v9ses)
+{
+	return v9ses->flags & V9FS_INODE_IDENT_PATH;
+}
+
 /**
  * v9fs_get_inode_from_fid - Helper routine to populate an inode by
  * issuing a attribute request
@@ -227,10 +251,10 @@ static inline int v9fs_proto_dotl(struct v9fs_session_info *v9ses)
  */
 static inline struct inode *
 v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			struct super_block *sb)
+			struct super_block *sb, struct dentry *dentry)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 0);
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 0);
 	else
 		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
 }
@@ -245,10 +269,10 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
  */
 static inline struct inode *
 v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			    struct super_block *sb)
+			    struct super_block *sb, struct dentry *dentry)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 1);
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 1);
 	else
 		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
 }
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 1640765563e9..72fd72a2ff06 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -243,6 +243,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 
 void v9fs_free_inode(struct inode *inode)
 {
+	free_ino_path(V9FS_I(inode)->path);
 	kmem_cache_free(v9fs_inode_cache, V9FS_I(inode));
 }
 
@@ -607,15 +608,17 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 			goto error;
 		}
 		/*
-		 * instantiate inode and assign the unopened fid to the dentry
+		 * Instantiate inode.  On .L fs, pass in dentry for inodeident=path.
 		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb,
+			v9fs_proto_dotl(v9ses) ? dentry : NULL);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
 				   "inode creation failed %d\n", err);
 			goto error;
 		}
+		/* Assign the unopened fid to the dentry */
 		v9fs_fid_add(dentry, &fid);
 		d_instantiate(dentry, inode);
 	}
@@ -733,14 +736,21 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
 	p9_fid_put(dfid);
+
+	/*
+	 * On .L fs, pass in dentry to v9fs_get_inode_from_fid in case it is
+	 * needed by inodeident=path
+	 */
 	if (fid == ERR_PTR(-ENOENT))
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+	else if (v9ses->cache & (CACHE_META | CACHE_LOOSE))
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb,
+			v9fs_proto_dotl(v9ses) ? dentry : NULL);
 	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb,
+			v9fs_proto_dotl(v9ses) ? dentry : NULL);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 2d025e561ba1..c1cc3553f2fb 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,10 +52,17 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
+struct iget_data {
+	struct p9_stat_dotl *st;
+	struct dentry *dentry;
+};
+
 static int v9fs_test_inode_dotl(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct p9_stat_dotl *st = ((struct iget_data *)data)->st;
+	struct dentry *dentry = ((struct iget_data *)data)->dentry;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
 	/* don't match inode of different type */
 	if (inode_wrong_type(inode, st->st_mode))
@@ -74,22 +81,74 @@ static int v9fs_test_inode_dotl(struct inode *inode, void *data)
 
 	if (v9inode->qid.path != st->qid.path)
 		return 0;
+
+	if (v9fs_inode_ident_path(v9ses)) {
+		if (!ino_path_compare(v9inode->path, dentry)) {
+			p9_debug(P9_DEBUG_VFS, "Refusing to reuse inode %p based on path mismatch",
+				 inode);
+			return 0;
+		}
+	}
 	return 1;
 }
 
 /* Always get a new inode */
 static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
 {
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_stat_dotl *st = ((struct iget_data *)data)->st;
+	struct dentry *dentry = ((struct iget_data *)data)->dentry;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	/*
+	 * Don't reuse inode of different type, even if we have
+	 * inodeident=path and path matches.
+	 */
+	if (inode_wrong_type(inode, st->st_mode))
+		return 0;
+
+	/*
+	 * We're only getting here if QID2INO stays the same anyway, so
+	 * mirroring the qid checks in v9fs_test_inode_dotl
+	 * (but maybe that check is unnecessary anyway? at least on 64bit)
+	 */
+
+	if (v9inode->qid.type != st->qid.type)
+		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
+
+	if (v9fs_inode_ident_path(v9ses) && dentry && v9inode->path) {
+		if (ino_path_compare(V9FS_I(inode)->path, dentry)) {
+			p9_debug(P9_DEBUG_VFS,
+				 "Reusing inode %p based on path match", inode);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
 static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct iget_data *idata = data;
+	struct p9_stat_dotl *st = idata->st;
+	struct dentry *dentry = idata->dentry;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
 	inode->i_generation = st->st_gen;
+	if (v9fs_inode_ident_path(v9ses)) {
+		if (dentry) {
+			v9inode->path = make_ino_path(dentry);
+			if (!v9inode->path)
+				return -ENOMEM;
+		} else {
+			v9inode->path = NULL;
+		}
+	}
 	return 0;
 }
 
@@ -97,19 +156,35 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					struct p9_qid *qid,
 					struct p9_fid *fid,
 					struct p9_stat_dotl *st,
+					struct dentry *dentry,
 					int new)
 {
 	int retval;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
+	struct iget_data data = {
+		.st = st,
+		.dentry = dentry,
+	};
+
 
 	if (new)
 		test = v9fs_test_new_inode_dotl;
 	else
 		test = v9fs_test_inode_dotl;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
+	if (v9fs_inode_ident_path(v9ses) && dentry) {
+		/*
+		 * We have to take the rename_sem lock here as iget5_locked has
+		 * spinlock in it (inode_hash_lock)
+		 */
+		down_read(&v9ses->rename_sem);
+	}
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, &data);
+	if (v9fs_inode_ident_path(v9ses) && dentry)
+		up_read(&v9ses->rename_sem);
+
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -142,7 +217,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 struct inode *
 v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			 struct super_block *sb, int new)
+			 struct super_block *sb, struct dentry *dentry, int new)
 {
 	struct p9_stat_dotl *st;
 	struct inode *inode = NULL;
@@ -151,7 +226,7 @@ v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, new);
+	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, dentry, new);
 	kfree(st);
 	return inode;
 }
@@ -305,7 +380,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -400,7 +475,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -838,7 +913,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 489db161abc9..566d9ae6255f 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb, NULL);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;
@@ -151,6 +151,14 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		goto release_sb;
 	}
 	sb->s_root = root;
+
+	if (v9fs_inode_ident_path(v9ses)) {
+		/* Probably not necessary, just to satisfy lockdep_assert */
+		down_read(&v9ses->rename_sem);
+		V9FS_I(inode)->path = make_ino_path(root);
+		up_read(&v9ses->rename_sem);
+	}
+
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
 		goto release_sb;
-- 
2.39.5


