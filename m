Return-Path: <linux-fsdevel+bounces-61513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9BFB5897D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37201522390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57721254D;
	Tue, 16 Sep 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpoA3m0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0A1FF7B3;
	Tue, 16 Sep 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982574; cv=none; b=ML49GopPbMQofCp9j7LpdP7iKCvZXhjQMI/0Jb/pecSENiJrIoeqUBzV0PlTzVesqWZW/6B5PL26z2kK+gbd7K8VtaOHnq62KgSaiWL3zMuLnX5+0gl/i1a/O6fxHb5ci0mNuaK6x9C7lGHRTN48a9thIQ8fJ7XcNG3pLKbglAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982574; c=relaxed/simple;
	bh=nm0FskFu9bfbh3AUBQqC/rRYtyo4lm2NVk09xhoJ0GM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC3NpfVL+dohgbuza7wT4FCuxuA8C43aZzyMgsuojMsl0P6TD4zeAoMRjbgNfmWiXVX8mhZ8GMf10dXBXPFafsAEvX8GWI6X27WU1/pPT5icapR8o5xlmUUwbdDpfKOj5DG2QTuolg56+K6mpRhokyfwY76Fo4m2Rt3swkMW2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpoA3m0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D0DC4CEF1;
	Tue, 16 Sep 2025 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982572;
	bh=nm0FskFu9bfbh3AUBQqC/rRYtyo4lm2NVk09xhoJ0GM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kpoA3m0tZQmOsP5V3bIpCG5IzWw+ZfIIsouqu54EbE8HswnYRdIc8I5BdRh6Ac7z9
	 yJJJxIwN9pDUCkSKvr+J09FjBHguM/dfXke569z2I7LyADNFqOLxTTya8cXhKp8Sw3
	 mkuPlzIDKBVDQQTvS0wYLW8r7WAGN375dQmFOo8Dbua3MnlGHEEwqtbJ3c/iUrtXJi
	 MyzoQUEI0z4g5al/uqreG1MVGLMR5FSOCbaeMimnfKgjOzeQ9TFLLsOMvYN9yglDQP
	 LaHlB+Ug1EGFnSy6zyiX4NT4dkDsxThnrydqBpRSn37FA+hST4kKGfOHYPMaVmvGHX
	 +TFshzx+aZSmA==
Date: Mon, 15 Sep 2025 17:29:32 -0700
Subject: [PATCH 06/28] fuse: flush events and send FUSE_SYNCFS and
 FUSE_DESTROY on unmount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151395.382724.3934045032344049955.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

At unmount time, there are a few things that we need to ask the fuse
server to do.

First, we need to flush queued events to userspace to give the fuse
server a chance to process the events.  This is how we make sure that
the server processes FUSE_RELEASE events before the connection goes
down.

Second, to ensure that all those metadata updates are persisted to disk
before tell the fuse server to destroy itself, send FUSE_SYNCFS after
waiting for the queued events.

Finally, we need to send FUSE_DESTROY to the fuse server so that it
closes the filesystem and the device fds before unmount returns.  That
way, a script that does something like "umount /dev/sda ; e2fsck -fn
/dev/sda" will not fail the e2fsck because the fd closure races with
e2fsck startup.  Obviously, we need to wait for FUSE_SYNCFS.

This is a major behavior change and who knows what might break existing
code, so we hide it behind iomap mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    8 ++++++++
 fs/fuse/file_iomap.c |   29 +++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    9 +++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 791f210c13a876..3cda9bc6af23fe 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1432,6 +1432,9 @@ int fuse_init_fs_context_submount(struct fs_context *fsc);
  */
 void fuse_conn_destroy(struct fuse_mount *fm);
 
+/* Send the FUSE_DESTROY command. */
+void fuse_send_destroy(struct fuse_mount *fm);
+
 /* Drop the connection and free the fuse mount */
 void fuse_mount_destroy(struct fuse_mount *fm);
 
@@ -1709,9 +1712,14 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 }
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
+
+void fuse_iomap_mount(struct fuse_mount *fm);
+void fuse_iomap_unmount(struct fuse_mount *fm);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_mount(...)			((void)0)
+# define fuse_iomap_unmount(...)		((void)0)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 3a4161633add0e..75e6f668baa9ef 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -604,3 +604,32 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.may_close = fuse_iomap_may_close,
 	.post_open = fuse_iomap_post_open,
 };
+
+void fuse_iomap_mount(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+
+	/*
+	 * Enable syncfs for iomap fuse servers so that we can send a final
+	 * flush at unmount time.  This also means that we can support
+	 * freeze/thaw properly.
+	 */
+	fc->sync_fs = true;
+}
+
+void fuse_iomap_unmount(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+
+	/*
+	 * Flush all pending commands, then issue a syncfs, flush the syncfs,
+	 * and send a destroy command.  This gives the fuse server a chance to
+	 * process all the pending releases, write the last bits of metadata
+	 * changes to disk, and close the iomap block devices before we return
+	 * from the umount call.
+	 */
+	fuse_flush_requests_and_wait(fc);
+	sync_filesystem(fm->sb);
+	fuse_flush_requests_and_wait(fc);
+	fuse_send_destroy(fm);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0d39e1dcec308d..7cb1426ca3e767 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -623,7 +623,7 @@ static void fuse_umount_begin(struct super_block *sb)
 		retire_super(sb);
 }
 
-static void fuse_send_destroy(struct fuse_mount *fm)
+void fuse_send_destroy(struct fuse_mount *fm)
 {
 	if (fm->fc->conn_init) {
 		FUSE_ARGS(args);
@@ -1463,6 +1463,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap)
+			fuse_iomap_mount(fm);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -2101,7 +2104,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy) {
+	if (fc->iomap) {
+		fuse_iomap_unmount(fm);
+	} else if (fc->destroy) {
 		/*
 		 * Flush all pending requests (most of which will be
 		 * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse


