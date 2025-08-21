Return-Path: <linux-fsdevel+bounces-58448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E38B2E9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B23A020C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5D1E5B64;
	Thu, 21 Aug 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZWXNYo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F3C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737660; cv=none; b=LtrXbvxLwq8zAALOYwY9cgNbpdZA0turf6P9DpqNYFJbCTVc1Zc8Ji0+PttCBnezJnyw/8tg2JeecEghItDlShBbnayI+RAoXSH2YDuohXNqvF4eDMrxqo3IA7QujvG1IwjXlX/tc5OikAUpxhH6nMSq/PfR22oJGPvahySU2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737660; c=relaxed/simple;
	bh=PtscuiYduLSrk2kuu5IUqXnV5NTM5yg5/Mffs4h8ORk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6mDuHx+TDCgC8FbxerTUFKVyi/VZYR0WquIN542VRh6/tILF7jzpLUhuHWm32msWc94WZTh1vxGNYZx4QT0VNExoskkwrkH2+HaP3UShZaiU1TlPAi1gd/1HzabG4uB20INihPKtoBdIcAXEylKXafAL2ZRyAoDk/SGckNHzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZWXNYo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B659C4CEE7;
	Thu, 21 Aug 2025 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737660;
	bh=PtscuiYduLSrk2kuu5IUqXnV5NTM5yg5/Mffs4h8ORk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pZWXNYo4KkXTrhS/igmQdW2y8dgEuEVlrzctFOClGEpCHZp65FchOcoqqCNrnGKxb
	 pc5EcGZoyk6Y1xyI40TOiKY/Cycxsb76GnC0b6B7jastTxpbLhjWl6sKIIzPFHLQ9v
	 fHzWfC9ldlYYFDPFAPhNQp5FdLIf9n24YSv0PiK/iAGLJ5N5RrOvBQtgK7Gcf8Y/BB
	 YcyC5FQxjc/DrozI3GscajEgyBIeZr5cjzR81TwqiB20CBBPcTp1XPdjZii7svJjOu
	 mHpzkVAsWEpGbe9qVwLO7sNZF+GrkBWcy+ifSMDgNYUdwQD8jNm2nZ20zNNXb2vZoD
	 vrmZ9DILtlVHw==
Date: Wed, 20 Aug 2025 17:54:19 -0700
Subject: [PATCH 07/23] fuse: flush events and send FUSE_SYNCFS and
 FUSE_DESTROY on unmount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709265.17510.14616856553557933379.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h     |    7 +++++++
 fs/fuse/file_iomap.c |   29 +++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    9 +++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f4834a02d16c98..6a155bdd389af6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1364,6 +1364,9 @@ int fuse_init_fs_context_submount(struct fs_context *fsc);
  */
 void fuse_conn_destroy(struct fuse_mount *fm);
 
+/* Send the FUSE_DESTROY command. */
+void fuse_send_destroy(struct fuse_mount *fm);
+
 /* Drop the connection and free the fuse mount */
 void fuse_mount_destroy(struct fuse_mount *fm);
 
@@ -1646,11 +1649,15 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 
 int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *fb);
 int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb);
+void fuse_iomap_mount(struct fuse_mount *fm);
+void fuse_iomap_unmount(struct fuse_mount *fm);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_backing_open(...)		(-EOPNOTSUPP)
 # define fuse_iomap_backing_close(...)		(-EOPNOTSUPP)
+# define fuse_iomap_mount(...)			((void)0)
+# define fuse_iomap_unmount(...)		((void)0)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 154c99399f48d2..6e0e222da3046c 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -593,3 +593,32 @@ int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb)
 	/* We only support closing iomap block devices at unmount */
 	return -EBUSY;
 }
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
+	 * Flush all pending commands, syncfs, flush that, and send a destroy
+	 * command.  This gives the fuse server a chance to process all the
+	 * pending releases, write the last bits of metadata changes to disk,
+	 * and close the iomap block devices before we return from the umount
+	 * call.  The caller already flushed previously pending requests, so we
+	 * only need the flush to wait for syncfs.
+	 */
+	sync_filesystem(fm->sb);
+	fuse_flush_requests_and_wait(fc, secs_to_jiffies(60));
+	fuse_send_destroy(fm);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1f3f91981410aa..3274ee1c31b62b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -621,7 +621,7 @@ static void fuse_umount_begin(struct super_block *sb)
 		retire_super(sb);
 }
 
-static void fuse_send_destroy(struct fuse_mount *fm)
+void fuse_send_destroy(struct fuse_mount *fm)
 {
 	if (fm->fc->conn_init) {
 		FUSE_ARGS(args);
@@ -1457,6 +1457,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap)
+			fuse_iomap_mount(fm);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -2055,7 +2058,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 	struct fuse_conn *fc = fm->fc;
 
 	fuse_flush_requests_and_wait(fc, secs_to_jiffies(30));
-	if (fc->destroy)
+	if (fc->iomap)
+		fuse_iomap_unmount(fm);
+	else if (fc->destroy)
 		fuse_send_destroy(fm);
 
 	fuse_abort_conn(fc);


