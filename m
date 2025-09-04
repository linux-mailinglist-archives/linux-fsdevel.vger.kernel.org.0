Return-Path: <linux-fsdevel+bounces-60223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E46B42DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F28207499
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A054946A;
	Thu,  4 Sep 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="oVJ1zUlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="icEjdw4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1BAD24;
	Thu,  4 Sep 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944323; cv=none; b=N37mACWZPr9PNFg/mWVjVc4dGAaLcL1IM+NYKF7KGF0xTIQNhSQJjPohfanweErK4BjbgIa6PyAkNHNzp2LndUEWM7Gd0vcZIUql2n0h4U5oi6uueTWs6tgm3Ok5PNz2ZBld8TZ28xB+OsrXZ993MWhGH/mEUCami+YeiTNZm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944323; c=relaxed/simple;
	bh=3dp3frev3iFKofTCFqaftycvnIca/r/D1varzlnkhP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glzWaHKRCIJdla1A/ByQ99NanhEVZoS0+FnZqhiLqLo+Vfe+6DfAN5TjfKGZ3z6qKhrOP4qD7mZGjGi3VwcqV+UHR7Tgo5Hgj1lNY+DzfpBRXuhhuYz9QZ00eXkq32HFLcc/07HoMXtomIbak+ocBh+qMXqBELlzIaMm7MmVuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=oVJ1zUlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=icEjdw4T; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A8BCEC0496;
	Wed,  3 Sep 2025 20:05:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 20:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756944319;
	 x=1757030719; bh=QOiWxVgiB87YYbdwXWtpKgYwT41UKymb6ess0oSRWS8=; b=
	oVJ1zUljKcM9wKa59JNNafJMMZQGva26JJnk9OCCK4l1A7Q7qKdDRzmGpApG8sVX
	EF96Zx//knJIISlGZbLaQf6OnxKUQmP+Cnu9EQ91ZZrQnUGvSJ5YQedDxXOsJZzU
	3dYpr0xgeUXigIECjOYwTOnK171Eb1XA+JpixT0RUbMzqeWs0kln9J97WEar9soQ
	D48qjSKH2xLv1wQ2tw1qdSgOHZX60X5rC/kDEjT+i8Hu3HcqW7fhZ9kdJXoXbl82
	+mXpIOfugeZZepuylH5CY+iKlIrTHUFa3Wht2VIfgBlm8tcOh5tEIsYdFhFzgTNa
	JFKHVHoUsdebJ7N/77xz6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756944319; x=
	1757030719; bh=QOiWxVgiB87YYbdwXWtpKgYwT41UKymb6ess0oSRWS8=; b=i
	cEjdw4TxYKGHppt2njHPdCURP1p4bKdzC3qyDEpQRQkd3EkNZd1tj5Yr6FXZhflY
	JpLBi9x7omwT7sx9UTuKdookc8+i4l1ns3cx0Ni1HhFSlpgZt5BYCrRK/RJMqRy9
	sdgL2ZiCf45cDiXhABdZpxk2vVg+GTofzsTrnclew+7ln4cf5qTAOMX5eN3oj/hm
	4pP8t5fYKBHzFSZWZm61OBzczCBhBQdoZRwyUoQ8dr3SZNJ9Uy7AvoZJo+cxl8R+
	0U6P70eKMB+FxZ92x7veE28gVzg0awZLF1tWHRGtTAUyBv4UfFyAA+GxZGbh+jvA
	jgRmVxaAdrkWc6/OGarEA==
X-ME-Sender: <xms:vte4aFZJEwZlzrQeZrQeAnxpha9FTSMRkPy6pQ0U0R42mQTPKgmy_A>
    <xme:vte4aIMdKMamfV-WusPmLLBwL8NJ0pB3DtIrx3NRwj8WR0ibLE4RDvVhDBOAZBNBa
    lLC6QLFIhOM1r8XCWc>
X-ME-Received: <xmr:vte4aOZmw1OVVlyKA5i_vHSCmJ6MslNfxu603e47YCNfiYPqRhXivm0jBfzyouz6tgT6o4cpH0utbBOKCgtiNM_Di5WDOloEM6WuWkbosRti4HUonzRQRANsJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhephedvue
    duteetudektddtgeeghfduueefuddufeeutdejiefghfefieeifeelffdvnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfi
    hrvggtkhdrohhrghdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugi
    gpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmihgtseguihhgihhk
    ohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepvh
    elfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vte4aAV52BwX15ezEwJSJDHFHT_IEuEg2YdQFOemDvXagJoykwzNWw>
    <xmx:vte4aFB4LN-xdDQ1ca4LUPuz2hM4fYvPPpYpDS3TykcuSB3p6zP1FA>
    <xmx:vte4aEKKqqT3rRH9hZO8iXfjHTDZYEeOhK2JsKyoF0YjUzlq2MW_hg>
    <xmx:vte4aLv5PVyy1trDIoNDixHg-7aDiJH-wdj6yDm9DBmEwhSeKsc9RQ>
    <xmx:v9e4aAI7dCbhZCheBkyu94sKrF7Pj5z0Kch0M2fgZ5r3otxcy0I0oOGj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:17 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/7] fs/9p: Add ability to identify inode by path for .L in uncached mode
Date: Thu,  4 Sep 2025 01:04:11 +0100
Message-ID: <acfb2cddabe1910dc379ee3064c0f3e3b952d84b.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
References: <cover.1756935780.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The intention of this patch is to allow features like Landlock and
fanotify (inode mark mode) to work on uncached 9pfs.  These features rely
on holding a specific inode and handling further access to the same file
(as identified by that inode), however, currently in uncached mode, we
always get a new inode on each access, due to concerns regarding server
side inode number collision.

On cached mode (either CACHE_LOOSE or CACHE_META), inode is already reused
only by looking at the qid (server-side inode number).  Since introducing
this additional check would regress hard links (as they will have
different path, and thus the two ends of a hard link won't be the same
inode anymore under this approach), this won't be done for cached mode.

Currently this patch doesn't actually have any effect - the next commit
will introduce a config option to control inodeident=path enablement and
default it to on for uncached mode.

Signed-off-by: Tingmao Wang <m@maowtm.org>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: "Günther Noack" <gnoack@google.com>
Closes: https://github.com/landlock-lsm/linux/issues/45

---
Changes since v1:
- Assume inodeident=path will not be set in cached mode.

- Fix various issues (rcu usage etc) in ino_path.c with feedback from Al
  Viro and Mickaël Salaün

- Use d_same_name instead of strncmp

- Instead of changing v9fs_test_new_inode_dotl to add the path check (thus
  hijacking the meaning of "new" to actually mean "uncached"), we add the
  path check (conditional on the right flags in v9ses) to the cached test
  function (v9fs_test_inode_dotl) and use that function for both cached
  and uncached mode, by adding additional conditionals within in for the
  version/generation check.  The v9fs_test_new_inode_dotl function is thus
  used only for mknod, mkdir and atomic_open in the "need to create" case.

- Instead of never reusing inode if path-based ident is not enabled, we
  always reuse in uncached mode, but if path-based ident is not enabled,
  we don't check the path.  This makes the code easier to reason about,
  and gets rid of the complexity of having to support two quite different
  mode of operation (re-using and not re-using inodes).

- Fix crash due to uninitialized v9inode->path when inode is allocated
  then immediately deallocated in iget5_locked as a result of two iget
  racing with each other to insert the inode.  Spotted via xfstests.

- Don't allocate v9fs_ino_path within v9fs_set_inode_dotl, as iget5_locked
  specifies that it can't sleep.  Doing so means that we need to handle a
  special case of inode being created and hashed into the inode list, and
  thus may be tested by another iget5_locked call, but its v9inode->path
  has not been populated yet.  This is resolved via waiting for
  iget5_locked to return before checking the path.  This edge case was
  spotted via xfstests.

 fs/9p/Makefile         |   3 +-
 fs/9p/ino_path.c       | 110 ++++++++++++++++++++++++++++++
 fs/9p/v9fs.h           |  74 +++++++++++++++-----
 fs/9p/vfs_inode.c      |  16 +++--
 fs/9p/vfs_inode_dotl.c | 149 +++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_super.c      |  13 +++-
 6 files changed, 321 insertions(+), 44 deletions(-)
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
index 000000000000..a03145e08a9d
--- /dev/null
+++ b/fs/9p/ino_path.c
@@ -0,0 +1,110 @@
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
+ * Must hold rename_sem due to traversing parents.  Caller must hold
+ * reference to dentry.
+ */
+struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
+{
+	struct v9fs_ino_path *path;
+	size_t path_components = 0;
+	struct dentry *curr = dentry;
+	ssize_t i;
+
+	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
+	might_sleep(); /* Allocation below might block */
+
+	rcu_read_lock();
+
+	/* Don't include the root dentry */
+	while (curr->d_parent != curr) {
+		if (WARN_ON_ONCE(path_components >= SSIZE_MAX)) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		path_components++;
+		curr = curr->d_parent;
+	}
+
+	/*
+	 * Allocation can block so don't do it in RCU (and because the
+	 * allocation might be large, since name_snapshot leaves space for
+	 * inline str, not worth trying GFP_ATOMIC)
+	 */
+	rcu_read_unlock();
+
+	path = kmalloc(struct_size(path, names, path_components), GFP_KERNEL);
+	if (!path)
+		return NULL;
+
+	path->nr_components = path_components;
+	curr = dentry;
+
+	rcu_read_lock();
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
+ * Must hold rename_sem due to traversing parents.  Returns whether
+ * ino_path matches with the path of a v9fs dentry.  This function does
+ * not sleep.
+ */
+bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
+{
+	struct dentry *curr = dentry;
+	struct name_snapshot *compare;
+	ssize_t i;
+	bool ret;
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
+		compare = &ino_path->names[i];
+		if (!d_same_name(curr, curr->d_parent, &compare->name)) {
+			rcu_read_unlock();
+			return false;
+		}
+		curr = curr->d_parent;
+	}
+	/* Comparison fails if dentry is deeper than ino_path */
+	ret = (curr == curr->d_parent);
+	rcu_read_unlock();
+	return ret;
+}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..134b55a605be 100644
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
+	 * Stores the path of the file this inode is for, only for filesystems
+	 * with inode_ident=path.  Lifetime is the same as this inode.
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
@@ -217,38 +236,57 @@ static inline int v9fs_proto_dotl(struct v9fs_session_info *v9ses)
 	return v9ses->flags & V9FS_PROTO_2000L;
 }
 
+static inline int v9fs_inode_ident_path(struct v9fs_session_info *v9ses)
+{
+	return v9ses->flags & V9FS_INODE_IDENT_PATH;
+}
+
 /**
- * v9fs_get_inode_from_fid - Helper routine to populate an inode by
- * issuing a attribute request
+ * v9fs_get_inode_from_fid - Find or populate an inode by issuing a
+ * attribute request, reusing existing inode by qid, and additionally
+ * path, if inodeident=path is enabled.
  * @v9ses: session information
  * @fid: fid to issue attribute request for
  * @sb: superblock on which to create inode
+ * @dentry: dentry corresponding to @fid
  *
  */
 static inline struct inode *
 v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			struct super_block *sb)
+			struct super_block *sb, struct dentry *dentry)
 {
+	if (!v9fs_inode_ident_path(v9ses)) {
+		/* Only pass in a dentry if we use qid+path to identify inodes */
+		dentry = NULL;
+	} else {
+		WARN_ON_ONCE(!dentry);
+	}
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 0);
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 0);
 	else
 		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
 }
 
 /**
  * v9fs_get_new_inode_from_fid - Helper routine to populate an inode by
- * issuing a attribute request
+ * issuing a attribute request.  Always get a new inode.
  * @v9ses: session information
  * @fid: fid to issue attribute request for
  * @sb: superblock on which to create inode
+ * @dentry: dentry corresponding to @fid.  A reference will be taken and
+ * placed in the inode, if in path identification mode.
  *
  */
 static inline struct inode *
 v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			    struct super_block *sb)
+			    struct super_block *sb, struct dentry *dentry)
 {
+	if (!v9fs_inode_ident_path(v9ses)) {
+		/* Only pass in a dentry if we use qid+path to identify inodes */
+		dentry = NULL;
+	}
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 1);
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, dentry, 1);
 	else
 		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
 }
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index caff65d8b2bb..5e56c13da733 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -232,6 +232,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 	if (!v9inode)
 		return NULL;
 	v9inode->cache_validity = 0;
+	v9inode->path = NULL;
 	mutex_init(&v9inode->v_mutex);
 	return &v9inode->netfs.inode;
 }
@@ -243,6 +244,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 
 void v9fs_free_inode(struct inode *inode)
 {
+	free_ino_path(V9FS_I(inode)->path);
 	kmem_cache_free(v9fs_inode_cache, V9FS_I(inode));
 }
 
@@ -607,15 +609,17 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
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
@@ -732,14 +736,16 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
 	p9_fid_put(dfid);
+
 	if (fid == ERR_PTR(-ENOENT))
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+	else if (v9ses->cache & (CACHE_META | CACHE_LOOSE))
+		/* Cached fs will not use inode path identification */
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, NULL);
 	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0fafc603b64a..86adaf5bcc0e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,44 +52,98 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
+struct iget_data {
+	struct p9_stat_dotl *st;
+
+	/* May be NULL */
+	struct dentry *dentry;
+
+	bool need_double_check;
+};
+
 static int v9fs_test_inode_dotl(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct p9_stat_dotl *st = ((struct iget_data *)data)->st;
+	struct dentry *dentry = ((struct iget_data *)data)->dentry;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	bool cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
 
-	/* don't match inode of different type */
+	/*
+	 * Don't reuse inode of different type, even if path matches.
+	 */
 	if (inode_wrong_type(inode, st->st_mode))
 		return 0;
 
-	if (inode->i_generation != st->st_gen)
-		return 0;
-
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
 
 	if (v9inode->qid.path != st->qid.path)
 		return 0;
+
+	if (cached) {
+		/*
+		 * Server side changes are not supposed to happen in cached mode.
+		 * If we fail this generation or version comparison on the inode,
+		 * we don't reuse it.
+		 */
+		if (inode->i_generation != st->st_gen)
+			return 0;
+
+		/* compare qid details */
+		if (memcmp(&v9inode->qid.version,
+			&st->qid.version, sizeof(v9inode->qid.version)))
+			return 0;
+	}
+
+	if (v9fs_inode_ident_path(v9ses) && dentry) {
+		if (v9inode->path) {
+			if (!ino_path_compare(v9inode->path, dentry)) {
+				p9_debug(
+					P9_DEBUG_VFS,
+					"Refusing to reuse inode %p based on path mismatch",
+					inode);
+				return 0;
+			}
+		} else if (inode->i_state & I_NEW) {
+			/*
+			 * iget5_locked may call this function with a still
+			 * initializing (I_NEW) inode, so we're now racing with the
+			 * code in v9fs_qid_iget_dotl that prepares v9inode->path.
+			 * Returning from this test function now with positive result
+			 * will cause us to wait for this inode to be ready, and we
+			 * can then re-check in v9fs_qid_iget_dotl.
+			 */
+			((struct iget_data *)data)->need_double_check = true;
+		} else {
+			WARN_ONCE(
+				1,
+				"Inode %p (ino %lu) does not have v9inode->path even though fs has path-based inode identification enabled?",
+				inode, inode->i_ino);
+		}
+	}
+
 	return 1;
 }
 
-/* Always get a new inode */
 static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
 {
 	return 0;
 }
 
-static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
+static int v9fs_set_inode_dotl(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct iget_data *idata = data;
+	struct p9_stat_dotl *st = idata->st;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
 	inode->i_generation = st->st_gen;
+	/*
+	 * We can't fill v9inode->path here, because allocating an ino_path
+	 * means that we might sleep, and we can't sleep here.
+	 */
+	v9inode->path = NULL;
 	return 0;
 }
 
@@ -97,19 +151,56 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					struct p9_qid *qid,
 					struct p9_fid *fid,
 					struct p9_stat_dotl *st,
+					struct dentry *dentry,
 					int new)
 {
 	int retval;
 	struct inode *inode;
+	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
+	struct iget_data data = {
+		.st = st,
+		.dentry = dentry,
+		.need_double_check = false,
+	};
 
 	if (new)
 		test = v9fs_test_new_inode_dotl;
 	else
 		test = v9fs_test_inode_dotl;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
+	if (dentry) {
+		/*
+		 * If we need to compare paths to find the inode to reuse, we need
+		 * to take the rename_sem for this FS.  We need to take it here,
+		 * instead of inside ino_path_compare, as iget5_locked has
+		 * spinlock in it (inode_hash_lock)
+		 */
+		down_read(&v9ses->rename_sem);
+	}
+	while (true) {
+		data.need_double_check = false;
+		inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, &data);
+		if (!data.need_double_check)
+			break;
+		/*
+		 * Need to double check path as it wasn't initialized yet when we
+		 * tested it
+		 */
+		if (!inode || (inode->i_state & I_NEW)) {
+			WARN_ONCE(
+				1,
+				"Expected iget5_locked to return an existing inode");
+			break;
+		}
+		if (ino_path_compare(V9FS_I(inode)->path, dentry))
+			break;
+		iput(inode);
+	}
+	if (dentry)
+		up_read(&v9ses->rename_sem);
+
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -125,6 +216,17 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	if (retval)
 		goto error;
 
+	v9inode = V9FS_I(inode);
+	if (dentry) {
+		down_read(&v9ses->rename_sem);
+		v9inode->path = make_ino_path(dentry);
+		up_read(&v9ses->rename_sem);
+		if (!v9inode->path) {
+			retval = -ENOMEM;
+			goto error;
+		}
+	}
+
 	v9fs_stat2inode_dotl(st, inode, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
@@ -140,9 +242,18 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 }
 
+/**
+ * Issues a getattr request and use the result to look up the inode for
+ * the target pointed to by @fid.
+ * @v9ses: session information
+ * @fid: fid to issue attribute request for
+ * @sb: superblock on which to create inode
+ * @dentry: if not NULL, the path of the provided dentry is compared
+ * against the path stored in the inode, to determine reuse eligibility.
+ */
 struct inode *
 v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			 struct super_block *sb, int new)
+			 struct super_block *sb, struct dentry *dentry, int new)
 {
 	struct p9_stat_dotl *st;
 	struct inode *inode = NULL;
@@ -151,7 +262,7 @@ v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 	if (IS_ERR(st))
 		return ERR_CAST(st);
 
-	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, new);
+	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, dentry, new);
 	kfree(st);
 	return inode;
 }
@@ -305,7 +416,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -400,7 +511,7 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -838,7 +949,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb, dentry);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 795c6388744c..bb9e66f4631e 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -141,7 +141,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		sb->s_d_flags |= DCACHE_DONTCACHE;
 	}
 
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb, NULL);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;
@@ -153,6 +153,17 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		goto release_sb;
 	}
 	sb->s_root = root;
+
+	if (v9fs_inode_ident_path(v9ses)) {
+		/*
+		 * This down_read is probably not necessary, just to satisfy
+		 * lockdep_assert
+		 */
+		down_read(&v9ses->rename_sem);
+		V9FS_I(inode)->path = make_ino_path(root);
+		up_read(&v9ses->rename_sem);
+	}
+
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
 		goto release_sb;
-- 
2.51.0

