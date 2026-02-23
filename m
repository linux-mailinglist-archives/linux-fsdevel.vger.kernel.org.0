Return-Path: <linux-fsdevel+bounces-78125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLtsHCXjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:30:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C2E17F7EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 232CC30AF3E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50537F8C3;
	Mon, 23 Feb 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izbbd66+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49537F8A5;
	Mon, 23 Feb 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889341; cv=none; b=M1BVmUPuabsfmBpF8yXTiPOer4R2vZ9ainS3q8mTKwBxRfeFpjCzBCimaNJKiZp+N7lQFRqxhKUBFZVBeZhCh/m4ikQfPjkd3t0zmMGCbZevWD5yzqwJ48/G/U/j0QwHicSsh+ZAu6s/C671F0GNKMLt38cd63xzZvPDTWKhQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889341; c=relaxed/simple;
	bh=cLMn5YOBKc/GmiQfqzk0AQ2ECiY/AKgLG2rYfGQdl9U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2DtNP88T6KTKsqP6XoGszbepBTsP3szMMc0tPs+QN+pAIL5iCzkrLlu6AvOxD4CNMuUUf1gmUHkLNGCXxgQD531R2KqpfT9AQUyZqjzQJe2n10fU9Z+rTOwvX7FB1g0EqljnnQfT+4r9ojqBwGEh8lq4CGmA7TqQqHECUhDXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izbbd66+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02DEC19421;
	Mon, 23 Feb 2026 23:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889341;
	bh=cLMn5YOBKc/GmiQfqzk0AQ2ECiY/AKgLG2rYfGQdl9U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=izbbd66+ZKCfEciAuyXAHgLkRwrlhOVzNUzCSwIR8bPkZe4bTrim32mveMEpYh226
	 dUXbQnwl9iqX91mhaX9d0zNKR3QiJSmROC5wVJcqH7Tv0uJJ6hurT7N3PPAfYrh7yX
	 sVWE3/pPENDR5rQ1hibGZjORCNDONZuvLW7R9ovDvBxnPs2YGVN5BVID4WwbRRAXn5
	 fFwftEM/dLLXaRfLyGAmidLPDKQ93XCdbdFGl8DIqTJlV3rIYwYeQCYWIO6tRXyGJx
	 I4JQh9nXcuLV+LmlB5k0jelL3TusVKo0mdb6VtrjMtHbZs4BQEA4vVu6IvtvQ8jKZD
	 4Gfd4kUAer8rg==
Date: Mon, 23 Feb 2026 15:29:00 -0800
Subject: [PATCH 14/25] libfuse: don't allow hardlinking of iomap files in the
 upper level fuse library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740186.3940670.11398665309070607810.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78125-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E4C2E17F7EC
X-Rspamd-Action: no action

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
index 0db5f7e961d8fa..817b3cf6c419c4 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1438,6 +1438,24 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
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
index 78812b66c05106..5d9acbc177a177 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3266,10 +3266,66 @@ static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
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
@@ -3278,17 +3334,33 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 
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
index fa1943e18dcafa..67c3bd614c44fc 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -242,6 +242,8 @@ FUSE_3.99 {
 		fuse_reply_create_iflags;
 		fuse_reply_entry_iflags;
 		fuse_add_direntry_plus_iflags;
+		fuse_fs_can_enable_iomap;
+		fuse_fs_can_enable_iomapx;
 } FUSE_3.19;
 
 # Local Variables:


