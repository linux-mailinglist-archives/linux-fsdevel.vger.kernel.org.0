Return-Path: <linux-fsdevel+bounces-78053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJggMvnenGm4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A717F004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E1A31297A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85D437E300;
	Mon, 23 Feb 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7921uvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74448340280;
	Mon, 23 Feb 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888214; cv=none; b=J8wvnmdPUQ3rEiLIWZKVque+V2DeOgPqZQsX0prTSg4L/AZ5RxlBzNCbtPdcEzFcjcQ22zk+RQ7a94ukBn0HRje+jWco+/ZfiFiAZY94wdeBEWgKKjh/kYXeyfukEl1/pzT2ExlbiUAMRDCyhMfdZ3JKGBcOGJ3gy+kXSkqDCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888214; c=relaxed/simple;
	bh=3dnf/PDwFPGoWt1cMnUS75kckYLQCLA7k8oKCbyqR80=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uajBujbXyhcG83IdW+nGRTvBCT4vZ5ZtgFdQ+ypycXhEAyFFUT2bMG8tNqIENcdP1u4nFWU1MKXxuLlrYU1WCvMvGreBDRv9LhWZ4lXjnu8jdk/r4OzJ2s5HMMCTeI7nEFr6yI71ZS4+/VTQd51iz5RARG5ql24tOjquG3L3JXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7921uvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4423EC116C6;
	Mon, 23 Feb 2026 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888214;
	bh=3dnf/PDwFPGoWt1cMnUS75kckYLQCLA7k8oKCbyqR80=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e7921uvrc/y6EwzM3sSI30RZl+eBea+Lja8701Rs/eJD6ufBQTqeNoRUwAi02/n+V
	 Sbc0WaJGmHZWqJWsBz3qsBSXi+AQqSROqWLvMfqQ6DmnkslYOnkPaK4w36NLKqNjwB
	 4LO4IsegQgsUioXx5umsRNk0ebP0OUbCt2u3yaxq3TrBP/UxNDCkCFVDIEPE+xHl7l
	 DWV7tFWNnjN5SDX1+e6/h6mBUvnAgJRyL1nf4P6v3XF3QM6e96XrzspbgzYqPC/uxP
	 13Dgi47vVzU3nvinp8SLVRTK47oppBv2xTFgO+5et+B7vaebgQpB6FRrIe29jH5yn2
	 B4X8VuTfR723Q==
Date: Mon, 23 Feb 2026 15:10:13 -0800
Subject: [PATCH 06/33] fuse: enable SYNCFS and ensure we flush everything
 before sending DESTROY
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734374.3935739.9586909088672061251.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78053-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741A717F004
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

At unmount time, there are a few things that we need to ask a fuse iomap
server to do.  We need to send FUSE_DESTROY to the fuse server so that
it closes the filesystem and the device fds before unmount returns.
That way, a script that does something like "umount /dev/sda ; e2fsck
-fn /dev/sda" will not fail the e2fsck because the fd closure races with
e2fsck startup.  This is essential for fstests QA to work properly.

To make this happen, first, we need to flush queued events to userspace
to give the fuse server a chance to process the events.  These will all
be FUSE_RELEASE events for previously opened files.  Once the commands
are flushed, we can send the FUSE_DESTROY request to ask the server to
close the filesystem.  This depends on libfuse to hold the destroy
command until there are no unreleased files (instead of having the
kernel enforce the ordering) because the kernel fuse developers don't
like the idea of unbounded waits in unmount.

Second, to reduce the amount of metadata must be persisted to disk in
the fuse server's destroy method, enable FUSE_SYNCFS so that previous
sync_filesystem calls can flush dirty data before we get deeper in the
unmount machinery.  If a fuse command timeout is set, this reduces the
likelihood that the kernel aborts the FUSE_DESTROY command whilst the
server is busy flushing dirty metadata.

This is a major behavior change and who knows what might break existing
code, so we hide it behind iomap mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    3 +++
 fs/fuse/fuse_iomap.h |    5 +++++
 fs/fuse/fuse_iomap.c |   32 ++++++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    9 +++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0321be384b769e..6860913a89e65d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1431,6 +1431,9 @@ int fuse_init_fs_context_submount(struct fs_context *fsc);
  */
 void fuse_conn_destroy(struct fuse_mount *fm);
 
+/* Send the FUSE_DESTROY command. */
+void fuse_send_destroy(struct fuse_mount *fm);
+
 /* Drop the connection and free the fuse mount */
 void fuse_mount_destroy(struct fuse_mount *fm);
 
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 43562ef23fb325..129680b056ebea 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -20,9 +20,14 @@ static inline bool fuse_has_iomap(const struct inode *inode)
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
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 0ac783dd312dc3..4b63bb32167877 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -584,3 +584,35 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
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
+	 * Flush all pending file release commands and send a destroy command.
+	 * This gives the fuse server a chance to process all the pending
+	 * releases, write the last bits of metadata changes to disk, and close
+	 * the iomap block devices before we return from the umount call.
+	 * iomap fuse servers are expected to release all exclusive access
+	 * resources before unmount completes.
+	 *
+	 * Note that multithreaded fuse servers will have to hold the destroy
+	 * command until all release requests have completed because the kernel
+	 * maintainers do not want to introduce waits in unmount.
+	 */
+	fuse_flush_requests(fc);
+	fuse_send_destroy(fm);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8f01844f89b261..778fdec9d81a03 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -633,7 +633,7 @@ static void fuse_umount_begin(struct super_block *sb)
 		retire_super(sb);
 }
 
-static void fuse_send_destroy(struct fuse_mount *fm)
+void fuse_send_destroy(struct fuse_mount *fm)
 {
 	if (fm->fc->conn_init) {
 		FUSE_ARGS(args);
@@ -1475,6 +1475,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap)
+			fuse_iomap_mount(fm);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -2099,7 +2102,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy) {
+	if (fc->iomap) {
+		fuse_iomap_unmount(fm);
+	} else if (fc->destroy) {
 		/*
 		 * Flush all pending requests (most of which will be
 		 * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse


