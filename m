Return-Path: <linux-fsdevel+bounces-24535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C29406D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21512829EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB218EFD9;
	Tue, 30 Jul 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRRt8mQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCE16C850;
	Tue, 30 Jul 2024 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316489; cv=none; b=YzH+8s/wUEY6TUfpqlt/953S7+5UaEAUAhdPhEaP8eXivj+iD+5jtKkXtdseC85g9ez5x0O5oMH1yd5g4kI4ucxDOG5jxeAbhQTo/We39MV/taQ1npUQ7G3gw4B/6orWYDA/Rzo9sR37nEdXoQ2FRbc1kB7/0quBMqwTd12642Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316489; c=relaxed/simple;
	bh=ZNRbrafpMZOvFmPSPkkvR42FVPPV+FlH4yiPBoNCuRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJDBocgJ4xcu+fAKpGvzWheWYAYQszrnAZRojBeym9mfpBGKkj++O6Cc+eGK/HQtkckEA2xBCHJJV2nsu6imxNjfFVX8PkpScUCEBKZ+o3D1fOUJ7yr5XUY/eW4GcrrSQAr7aJ7xZgdwVJLoId7bPwIFVzXDKWSlz9wQDzV2muA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRRt8mQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510DC4AF14;
	Tue, 30 Jul 2024 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316489;
	bh=ZNRbrafpMZOvFmPSPkkvR42FVPPV+FlH4yiPBoNCuRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRRt8mQjOglM7hqk7RE+FhyDRo6Q85oXP67J/+0o9/t/8DYqU2n4yS4z+tKvUx3NI
	 1MKUQifmSgFV/SKY6iUqttGYh1xQJe2DrzedvAK9WyohaeB+gYLH8Yukd1w6DeYgE1
	 0Vi57lOJ6eIngEZohLK4Bg6ya93mLVgt6RJJE8t2ECtt3+URU1fwvkOOoOKexAaPBf
	 al6194h6yEdw7steQlLe/808A3CkpCz8z5BdHrGyZbZI4U4jlQ9aN4+XJLPGZO5jWu
	 9804zD9o0kxXX1GDX71+phcn+mRQpo+kQ3iVjbjApXOEgQQiJqKBpTfl1KVcYVd4JT
	 xjJEPnFlOHmFQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 03/39] struct fd: representation change
Date: Tue, 30 Jul 2024 01:15:49 -0400
Message-Id: <20240730051625.14349-3-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

	The absolute majority of instances comes from fdget() and its
relatives; the underlying primitives actually return a struct file
reference and a couple of flags encoded into an unsigned long - the lower
two bits of file address are always zero, so we can stash the flags
into those.  On the way out we use __to_fd() to unpack that unsigned
long into struct fd.

	Let's use that representation for struct fd itself - make it
a structure with a single unsigned long member (.word), with the value
equal either to (unsigned long)p | flags, p being an address of some
struct file instance, or to 0 for an empty fd.

	Note that we never used a struct fd instance with NULL ->file
and non-zero ->flags; the emptiness had been checked as (!f.file) and
we expected e.g. fdput(empty) to be a no-op.  With new representation
we can use (!f.word) for emptiness check; that is enough for compiler
to figure out that (f.word & FDPUT_FPUT) will be false and that fdput(f)
will be a no-op in such case.

	For now the new predicate (fd_empty(f)) has no users; all the
existing checks have form (!fd_file(f)).  We will convert to fd_empty()
use later; here we only define it (and tell the compiler that it's
unlikely to return true).

	This commit only deals with representation change; there will
be followups.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c |  2 +-
 fs/overlayfs/file.c                  | 28 +++++++++++++++-------------
 fs/xfs/xfs_handle.c                  |  2 +-
 include/linux/file.h                 | 22 ++++++++++++++++------
 kernel/events/core.c                 |  2 +-
 net/socket.c                         |  2 +-
 6 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 3f85575cf971..a4cce360df21 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -572,7 +572,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	struct inode                   *inode = NULL;
 	int				new_xrcd = 0;
 	struct ib_device *ib_dev;
-	struct fd f = {};
+	struct fd f = EMPTY_FD;
 	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c4963d0c5549..2b7a5a3a7a2f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -93,11 +93,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 			       bool allow_meta)
 {
 	struct dentry *dentry = file_dentry(file);
+	struct file *realfile = file->private_data;
 	struct path realpath;
 	int err;
 
-	real->flags = 0;
-	real->file = file->private_data;
+	real->word = (unsigned long)realfile;
 
 	if (allow_meta) {
 		ovl_path_real(dentry, &realpath);
@@ -113,16 +113,17 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 		return -EIO;
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(real->file) != d_inode(realpath.dentry))) {
-		real->flags = FDPUT_FPUT;
-		real->file = ovl_open_realfile(file, &realpath);
-
-		return PTR_ERR_OR_ZERO(real->file);
+	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
+		struct file *f = ovl_open_realfile(file, &realpath);
+		if (IS_ERR(f))
+			return PTR_ERR(f);
+		real->word = (unsigned long)ovl_open_realfile(file, &realpath) | FDPUT_FPUT;
+		return 0;
 	}
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(real->file, file->f_flags);
+	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
+		return ovl_change_flags(realfile, file->f_flags);
 
 	return 0;
 }
@@ -130,10 +131,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 static int ovl_real_fdget(const struct file *file, struct fd *real)
 {
 	if (d_is_dir(file_dentry(file))) {
-		real->flags = 0;
-		real->file = ovl_dir_real_file(file, false);
-
-		return PTR_ERR_OR_ZERO(real->file);
+		struct file *f = ovl_dir_real_file(file, false);
+		if (IS_ERR(f))
+			return PTR_ERR(f);
+		real->word = (unsigned long)f;
+		return 0;
 	}
 
 	return ovl_real_fdget_meta(file, real, false);
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 7bcc4f519cb8..49e5e5f04e60 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -85,7 +85,7 @@ xfs_find_handle(
 	int			hsize;
 	xfs_handle_t		handle;
 	struct inode		*inode;
-	struct fd		f = {NULL};
+	struct fd		f = EMPTY_FD;
 	struct path		path;
 	int			error;
 	struct xfs_inode	*ip;
diff --git a/include/linux/file.h b/include/linux/file.h
index 0f3f369f2450..bdd6e1766839 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -35,18 +35,28 @@ static inline void fput_light(struct file *file, int fput_needed)
 		fput(file);
 }
 
+/* either a reference to struct file + flags
+ * (cloned vs. borrowed, pos locked), with
+ * flags stored in lower bits of value,
+ * or empty (represented by 0).
+ */
 struct fd {
-	struct file *file;
-	unsigned int flags;
+	unsigned long word;
 };
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
-#define fd_file(f) ((f).file)
+#define fd_file(f) ((struct file *)((f).word & ~3))
+static inline bool fd_empty(struct fd f)
+{
+	return unlikely(!f.word);
+}
+
+#define EMPTY_FD (struct fd){0}
 
 static inline void fdput(struct fd fd)
 {
-	if (fd.flags & FDPUT_FPUT)
+	if (fd.word & FDPUT_FPUT)
 		fput(fd_file(fd));
 }
 
@@ -60,7 +70,7 @@ extern void __f_unlock_pos(struct file *);
 
 static inline struct fd __to_fd(unsigned long v)
 {
-	return (struct fd){(struct file *)(v & ~3),v & 3};
+	return (struct fd){v};
 }
 
 static inline struct fd fdget(unsigned int fd)
@@ -80,7 +90,7 @@ static inline struct fd fdget_pos(int fd)
 
 static inline void fdput_pos(struct fd f)
 {
-	if (f.flags & FDPUT_POS_UNLOCK)
+	if (f.word & FDPUT_POS_UNLOCK)
 		__f_unlock_pos(fd_file(f));
 	fdput(f);
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 17b19d3e74ba..fd2ac9c7fd77 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12474,7 +12474,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = {NULL, 0};
+	struct fd group = EMPTY_FD;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
 	int event_fd;
diff --git a/net/socket.c b/net/socket.c
index f77a42a74510..c0d4f5032374 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -559,7 +559,7 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
 	if (fd_file(f)) {
 		sock = sock_from_file(fd_file(f));
 		if (likely(sock)) {
-			*fput_needed = f.flags & FDPUT_FPUT;
+			*fput_needed = f.word & FDPUT_FPUT;
 			return sock;
 		}
 		*err = -ENOTSOCK;
-- 
2.39.2


