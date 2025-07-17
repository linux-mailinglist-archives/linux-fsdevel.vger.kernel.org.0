Return-Path: <linux-fsdevel+bounces-55323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C1B097F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C386A61F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA10271449;
	Thu, 17 Jul 2025 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcNOMBFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A326E16A
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794937; cv=none; b=AjMbxTmMkhJdj7LS7UG8pQ1Y86UbpShMG2TB+GwYnJDo7H8yJkTeq8727UJIMq1cJQAbySRotLnzKGbKUj8fC6ObFOWiGLeTN16GM33zXRUu9kBf0gmWKrjq/mNqqYEp8TW33uaMMctq/GsC2AX9OG10T6iOG/ly/EUbEJcgHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794937; c=relaxed/simple;
	bh=UKpk+Vl0oRs1bLZT6xlxtJVNkaCQZQiE7KuLq915tDs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAk6YeQiUeDJi+vy0qMUq1RIaEadkvCznU2ZcU0LHpSqYsaqM6VtCkF9/5FkHicnJp90dVJEwR28KGhEF8wx3YaRT90PWfjUeyYb9ChpyVHcxWg2W5IIeFbKH+QpSedjPXqgX7rvOVFioBfWTtBQKD/eYhl1xt4So1Q8nLffKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcNOMBFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF6CC4CEFC;
	Thu, 17 Jul 2025 23:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794937;
	bh=UKpk+Vl0oRs1bLZT6xlxtJVNkaCQZQiE7KuLq915tDs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UcNOMBFMV3ZcCcIkvVLuhqkvdjYMxgy4yooUNH3xpTwKoPQwKurZmXVWFPfOUTUFd
	 EA/1VInSETJSnkFtufVvAlk2+5Za0oqGp0NzbCGWSlSa/O7O3CNm0dNWheXvpn2C2t
	 MEIKtIWXoNgUUi++bExI7Z7+BTBOIL7lc9I2kiqLA2Ui/C3riWJMNgsBYW2F8Eqq5t
	 UgildCzymMgSte2acmcMPM4DjVwIN6tQtsyy1iKYZl9wHi9OGI95zZH6X0TG/RIcgg
	 O1OHVUlSwAUS6Yizf3m+sQ5hKE97BVH7aD0uuEtCUg8U80xaFA3uKMORx0dFdJ4yBh
	 AKfiH+kLmFEKg==
Date: Thu, 17 Jul 2025 16:28:56 -0700
Subject: [PATCH 03/13] fuse: flush events and send FUSE_SYNCFS and
 FUSE_DESTROY on unmount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450001.711291.7754454933849755672.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h     |    5 +++++
 fs/fuse/file_iomap.c |   23 +++++++++++++++++++++++
 fs/fuse/inode.c      |    6 ++++--
 3 files changed, 32 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 12c462a29fe0c4..850c187434a61a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1380,6 +1380,9 @@ int fuse_init_fs_context_submount(struct fs_context *fsc);
  */
 void fuse_conn_destroy(struct fuse_mount *fm);
 
+/* Send the FUSE_DESTROY command. */
+void fuse_send_destroy(struct fuse_mount *fm);
+
 /* Drop the connection and free the fuse mount */
 void fuse_mount_destroy(struct fuse_mount *fm);
 
@@ -1639,6 +1642,7 @@ int fuse_iomap_conn_alloc(struct fuse_conn *fc);
 void fuse_iomap_conn_put(struct fuse_conn *fc);
 
 int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map);
+void fuse_iomap_conn_destroy(struct fuse_mount *fm);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1646,6 +1650,7 @@ int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map)
 # define fuse_iomap_conn_alloc(...)		(0)
 # define fuse_iomap_conn_put(...)		((void)0)
 # define fuse_iomap_dev_add(...)		(-ENOSYS)
+# define fuse_iomap_conn_destroy(...)		((void)0)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 535429023d37e7..4724d5678112db 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -540,6 +540,12 @@ bool fuse_iomap_fill_super(struct fuse_mount *fm)
 		}
 	}
 
+	/*
+	 * Enable syncfs for iomap fuse servers so that we can send a final
+	 * flush at unmount time.  This also means that we can support
+	 * freeze/thaw properly.
+	 */
+	fc->sync_fs = true;
 	return true;
 }
 
@@ -585,3 +591,20 @@ int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map)
 out:
 	return res;
 }
+
+void fuse_iomap_conn_destroy(struct fuse_mount *fm)
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
+	fuse_flush_requests(fc, 60 * HZ);
+	fuse_send_destroy(fm);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8266f30bc8a954..8b12284bced7e6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -618,7 +618,7 @@ static void fuse_umount_begin(struct super_block *sb)
 		retire_super(sb);
 }
 
-static void fuse_send_destroy(struct fuse_mount *fm)
+void fuse_send_destroy(struct fuse_mount *fm)
 {
 	if (fm->fc->conn_init) {
 		FUSE_ARGS(args);
@@ -2064,7 +2064,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 	struct fuse_conn *fc = fm->fc;
 
 	fuse_flush_requests(fc, 30 * HZ);
-	if (fc->destroy)
+	if (fc->iomap)
+		fuse_iomap_conn_destroy(fm);
+	else if (fc->destroy)
 		fuse_send_destroy(fm);
 
 	fuse_abort_conn(fc);


