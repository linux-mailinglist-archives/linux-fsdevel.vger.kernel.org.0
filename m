Return-Path: <linux-fsdevel+bounces-58488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5178B2E9FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E016C433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EE1E32D3;
	Thu, 21 Aug 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfSc1mRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D81A9FAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738286; cv=none; b=Zzz/fXKVWZs6XK5Zyet0sv3NisArPQBqvYH+NW9Epyn89K+mYZQSvw2/kFVemqZ5WUlL16RO7pS4rGxG22QNb3R6cDtUHKfIjYtflfaTDkv2KzfuMC5K9pWreHDKSjXQG65JkiDVEqLbbElYiQZxpA3iiD8zREF74HXZA7H1CbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738286; c=relaxed/simple;
	bh=hnu/HmAxOoUbSfq7T1GZYhYpyC1OoQF5aMZElf24GdY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxZSkLBief7fXfh8/diJ+qopkn5HScmSpHjF2Jl/QvAFqrKzp2kijUCn4dWdnzGWBzoyaf9ud0iSPaup2Lj2N6znljzeLunT6PjLf7tOnb1MCVsqAnHzEtre9x84e2B9CwIt9tnCbqc+slAlVNaefX2rJCxLk4vlQOj6LdBL8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfSc1mRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF4C113D0;
	Thu, 21 Aug 2025 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738285;
	bh=hnu/HmAxOoUbSfq7T1GZYhYpyC1OoQF5aMZElf24GdY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PfSc1mRYy2dhLb1f9v1+KGtMo65NCR7kUN22GEXqpvlN2O2tD+8IVP239YjbnY8To
	 rrEOsZlZDTw4jrMlmhfJRNgS3H9mq0WN+HVMIBngLlZo7fsWceyUfyOv++aR8cMhjz
	 KEHXji+4VmGDwqCfTa7aCIzLQ6arY5EqYbYTEQosmlmFiu+XRRSmbDQlaMaQhznRk7
	 9RsqMYu9jUbKGY9EzSXV1MlJgTsz+3EIdGldQOv18B/8FXcMt0xprPev/tMdLla4+8
	 Xf0tZxdzBGIIJkYeTNR1VucVtcy9yQgHGP/W+MKXGWRdDIi4McjIziog7+7hUS+KZ/
	 dUQXPf2MkA28Q==
Date: Wed, 20 Aug 2025 18:04:45 -0700
Subject: [PATCH 13/21] libfuse: don't allow hardlinking of iomap files in the
 upper level fuse library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711527.19163.1093949447716658384.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The upper level fuse library creates a separate node object for every
(i)node referenced by a directory entry.  Unfortunately, it doesn't
account for the possibility of hardlinks, which means that we can create
multiple nodeids that refer to the same hardlinked inode.  Inode locking
in iomap mode in the kernel relies there only being one inode object for
a hardlinked file, so we cannot allow anyone to hardlink an iomap file.
The client had better not turn on iomap for an existing hardlinked file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   18 ++++++++++
 lib/fuse.c             |   90 +++++++++++++++++++++++++++++++++++++++++++-----
 lib/fuse_versionscript |    2 +
 3 files changed, 101 insertions(+), 9 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 7256f43fd5c39a..4c4fff837437c8 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1415,6 +1415,24 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
  */
 int fuse_fs_iomap_device_remove(int device_id);
 
+/**
+ * Decide if we can enable iomap mode for a particular file for an upper-level
+ * fuse server.
+ *
+ * @param statbuf stat information for the file.
+ * @return true if it can be enabled, false if not.
+ */
+bool fuse_fs_can_enable_iomap(const struct stat *statbuf);
+
+/**
+ * Decide if we can enable iomap mode for a particular file for an upper-level
+ * fuse server.
+ *
+ * @param statxbuf statx information for the file.
+ * @return true if it can be enabled, false if not.
+ */
+bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index 6b211084e2175a..cbf2c5d3a67895 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3249,10 +3249,66 @@ static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
 	reply_err(req, err);
 }
 
+/*
+ * Decide if file IO for this inode can use iomap.
+ *
+ * The upper level libfuse creates internal node ids that have nothing to do
+ * with the ext2_ino_t that we give it.  These internal node ids are what
+ * actually gets igetted in the kernel, which means that there can be multiple
+ * fuse_inode objects in the kernel for a single hardlinked inode in the fuse
+ * server.
+ *
+ * What this means, horrifyingly, is that on a fuse filesystem that supports
+ * hard links, the in-kernel i_rwsem does not protect against concurrent writes
+ * between files that point to the same inode.  That in turn means that the
+ * file mode and size can get desynchronized between the multiple fuse_inode
+ * objects.  This also means that we cannot cache iomaps in the kernel AT ALL
+ * because the caches will get out of sync, leading to WARN_ONs from the iomap
+ * zeroing code and probably data corruption after that.
+ *
+ * Therefore, libfuse must never create hardlinks of iomap files, and the
+ * predicates below allow fuse servers to decide if they can turn on iomap for
+ * existing hardlinked files.
+ */
+bool fuse_fs_can_enable_iomap(const struct stat *statbuf)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return false;
+
+	return statbuf->st_nlink < 2;
+}
+
+bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return false;
+
+	return statxbuf->stx_nlink < 2;
+}
+
+static bool fuse_lib_can_link(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct node *node;
+
+	if (!(req->se->conn.want_ext & FUSE_CAP_IOMAP))
+		return true;
+
+	node = get_node(f, ino);
+	return !(node->iflags & FUSE_IFLAG_IOMAP);
+}
+
 static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 			  const char *newname)
 {
 	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
@@ -3261,17 +3317,33 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 
 	err = get_path2(f, ino, NULL, newparent, newname,
 			&oldpath, &newpath, NULL, NULL);
-	if (!err) {
-		struct fuse_intr_data d;
+	if (err)
+		goto out_reply;
 
-		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_link(f->fs, oldpath, newpath);
-		if (!err)
-			err = lookup_path(f, newparent, newname, newpath,
-					  &e, &iflags, NULL);
-		fuse_finish_interrupt(f, req, &d);
-		free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
+	/*
+	 * The upper level fuse library creates a separate node object for
+	 * every (i)node referenced by a directory entry.  Unfortunately, it
+	 * doesn't account for the possibility of hardlinks, which means that
+	 * we can create multiple nodeids that refer to the same hardlinked
+	 * inode.  Inode locking in iomap mode in the kernel relies there only
+	 * being one inode object for a hardlinked file, so we cannot allow
+	 * anyone to hardlink an iomap file.  The client had better not turn on
+	 * iomap for an existing hardlinked file.
+	 */
+	if (!fuse_lib_can_link(req, ino)) {
+		err = -EPERM;
+		goto out_path;
 	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_link(f->fs, oldpath, newpath);
+	if (!err)
+		err = lookup_path(f, newparent, newname, newpath,
+				  &e, &iflags, NULL);
+	fuse_finish_interrupt(f, req, &d);
+out_path:
+	free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
+out_reply:
 	reply_entry(req, &e, iflags, err);
 }
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index df78723e0f2518..aa16efdd8a9879 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -229,6 +229,8 @@ FUSE_3.99 {
 		fuse_reply_create_iflags;
 		fuse_reply_entry_iflags;
 		fuse_add_direntry_plus_iflags;
+		fuse_fs_can_enable_iomap;
+		fuse_fs_can_enable_iomapx;
 } FUSE_3.18;
 
 # Local Variables:


