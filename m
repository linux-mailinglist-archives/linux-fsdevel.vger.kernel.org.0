Return-Path: <linux-fsdevel+bounces-21141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8C8FF9C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B221F2448F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BD171AD;
	Fri,  7 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mCZpZk9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B511718
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725601; cv=none; b=P4AyAxlMqXVEAM0dOhzsbfz+nsqOPyPV6SwhDSApKaWiElzqxSEAI1/NHtzosJM1UWjk6yWzm/zq+XUg2mLuDG1x+whXztivEPXaCHHMOlgYHE0uo1QnwlTaEqQM0+l93csIwOXgvOJLWxRuD3sL61IP6BfgyJ4926P3UUCb7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725601; c=relaxed/simple;
	bh=t3vn3r2Yi0/bWPCT1vdHN+juRgfkt0JZtX2MaLjpvro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JO/7Iw/Jey0z9pQIzHUC6lOT+jX3dIwq4o/tuSx685fZRYTLdhCoV09ahOdBm7J4BtDu7i8bIgIJpyEhcuEmn4VfIICR4j7Fn16sVvk+LYKDoGMWGLOv/OpCMXUfABU1xhYRz8jlx38Anujoe4RPiNZRFtJ+ceCrvqTmI6jC3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mCZpZk9z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GS+5+xf0hEh5khu5ACKp70Zlu/taVlkcYRTR41g+YQk=; b=mCZpZk9zL3e9X7QsEES/Q0rWLe
	vBkLjRQmgWkG6yky9ACurGTkzkoNF3OG/MMD8thYQMlAxQTJd3xrch8xWj8PT2ax7mYUovU56XJZR
	4S5DdJfpXAJf5fPmXqKWMKbN4FPNhKz/x50hUFzz3Isf7nuJflce2Nyo8RhmeupPnTgz038AU4a0I
	eEpwB/ux6zshzlC3Zrwcbb2wq9i4hzsRyCuIXD3giwdKedPzJm+Gwr67TQsJm29zV7MZT0pN0ljew
	mmv1EKnY5q76NK/eXdYNi6fwVd45IIRFnnIHQ3EQ7d9mEnAwOP+pLw1Lhps84o6DC3xm2RrmNJn0K
	sjA70ILQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOta-009xBR-0Y;
	Fri, 07 Jun 2024 01:59:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 04/19] struct fd: representation change
Date: Fri,  7 Jun 2024 02:59:42 +0100
Message-Id: <20240607015957.2372428-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

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
index 03ea3afcb31f..efe3cc3debba 100644
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
index c4963d0c5549..458299873780 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -93,11 +93,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 			       bool allow_meta)
 {
 	struct dentry *dentry = file_dentry(file);
+	struct file *private = file->private_data;
 	struct path realpath;
 	int err;
 
-	real->flags = 0;
-	real->file = file->private_data;
+	real->word = (unsigned long)private;
 
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
+	if (unlikely(file_inode(private) != d_inode(realpath.dentry))) {
+		struct file *f = ovl_open_realfile(file, &realpath);
+		if (IS_ERR(f))
+			return PTR_ERR(f);
+		real->word = (unsigned long)ovl_open_realfile(file, &realpath) | FDPUT_FPUT;
+		return 0;
 	}
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(real->file, file->f_flags);
+	if (unlikely((file->f_flags ^ private->f_flags) & ~OVL_OPEN_FLAGS))
+		return ovl_change_flags(private, file->f_flags);
 
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
index 445a2daff233..bb250f4246b3 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -86,7 +86,7 @@ xfs_find_handle(
 	int			hsize;
 	xfs_handle_t		handle;
 	struct inode		*inode;
-	struct fd		f = {NULL};
+	struct fd		f = EMPTY_FD;
 	struct path		path;
 	int			error;
 	struct xfs_inode	*ip;
diff --git a/include/linux/file.h b/include/linux/file.h
index 0964408727a7..39eb10a1bbfc 100644
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
index 7acf44111a6e..fd4621cd9c23 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12438,7 +12438,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
-	struct fd group = {NULL, 0};
+	struct fd group = EMPTY_FD;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
 	int event_fd;
diff --git a/net/socket.c b/net/socket.c
index 50b074f52147..a2c509363d4d 100644
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


