Return-Path: <linux-fsdevel+bounces-65995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8AC17987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2146D4E921A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4E2D321D;
	Wed, 29 Oct 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgnaXEPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9A2D2387;
	Wed, 29 Oct 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698588; cv=none; b=cUzXxSHmv0D7wMYxztPjjHADi/qONKvbTcRuWMH+hwt2GVKllLZ4SJgrA9bDdJvRJa6ppgDTruwWadn+6dIYmYaw2U38l+yqqr1DGqU28KlBd7bohgWSh1GDZSZC9e8X9LfRcxQmk6nOF0Q3Z6snjaCQpRu8DylVY6Nsk+CH/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698588; c=relaxed/simple;
	bh=WAVhp96aL4pKZl1xITmaVaPn7T+E9gdLjGtJVrVdguY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTF3yEErgS7sVPZJ0ZpGhc5D7Pg3Sh2YPSTAGbK15QnR7sg92cQJ8p9ahw4VhUjil8pfXjpfQr/mqhEYe4YslMcEC9bbydC55iK6ZT527lzp+uMJ1OaLv+ig6siGKaVvQZT0yfnWZgD3cjtAVI8OUvU6cXpPNwSxw140ZOp4odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgnaXEPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DE7C4CEE7;
	Wed, 29 Oct 2025 00:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698588;
	bh=WAVhp96aL4pKZl1xITmaVaPn7T+E9gdLjGtJVrVdguY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VgnaXEPhGc7ELIVnOLzhOi5iBfBYRhvoLbHDNYjOGHD/modAYA7J8/3sR+oex/yOM
	 +sJ0Gv+txJOzqja+quM3CQPOr8oC38QbThTqVPGWAT8/ti6u0v9cWCMAVHh15AZETF
	 JscaxcDc5IShWCkp55+sLCjDSaQdz+haYlVq1jue+snU+O3PMMDEzMtDCf7L+//os1
	 SpH3EwC8eOLoTjiE+8OB9aKafnjGeG8EFmAAkgOve/Nr747kSSBWFuZRnZbUcNTkHm
	 U/jO3MKKwqQhQRAUFqw7TnP9vqz3fm6AHL6ZCtsv3f3LwroFQC7yKF5ot8n7wVJIRh
	 pqRN6Md4wnpqw==
Date: Tue, 28 Oct 2025 17:43:08 -0700
Subject: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/488 fails with fuse2fs in the following fashion:

generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
(see /var/tmp/fstests/generic/488.full for details)

This test opens a large number of files, unlinks them (which really just
renames them to fuse hidden files), closes the program, unmounts the
filesystem, and runs fsck to check that there aren't any inconsistencies
in the filesystem.

Unfortunately, the 488.full file shows that there are a lot of hidden
files left over in the filesystem, with incorrect link counts.  Tracing
fuse_request_* shows that there are a large number of FUSE_RELEASE
commands that are queued up on behalf of the unlinked files at the time
that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
aborted, the fuse server would have responded to the RELEASE commands by
removing the hidden files; instead they stick around.

For upper-level fuse servers that don't use fuseblk mode this isn't a
problem because libfuse responds to the connection going down by pruning
its inode cache and calling the fuse server's ->release for any open
files before calling the server's ->destroy function.

For fuseblk servers this is a problem, however, because the kernel sends
FUSE_DESTROY to the fuse server, and the fuse server has to close the
block device before returning.  This means that the kernel must flush
all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.

Create a function to push all the background requests to the queue and
then wait for the number of pending events to hit zero, and call this
before sending FUSE_DESTROY.  That way, all the pending events are
processed by the fuse server and we don't end up with a corrupt
filesystem.

Note that we use a wait_event_timeout() loop to cause the process to
schedule at least once per second to avoid a "task blocked" warning:

INFO: task umount:1279 blocked for more than 20 seconds.
      Not tainted 6.17.0-rc7-xfsx #rc7
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690

Earlier in the threads about this patch there was a (self-inflicted)
dispute as to whether it was necessary to call touch_softlockup_watchdog
in the loop body.  Because the process goes to sleep, it's not necessary
to touch the softlockup watchdog because we're not preventing another
process from being scheduled on a CPU.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 +++++
 fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  |   11 ++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c2f2a48156d6c5..aaa8574fd72775 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Flush all pending requests and wait for them.
+ */
+void fuse_flush_requests_and_wait(struct fuse_conn *fc);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d7072..ecc0a5304c59d1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -24,6 +24,7 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/nmi.h>
 
 #include "fuse_trace.h"
 
@@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Flush all pending requests and wait for them.  Only call this function when
+ * it is no longer possible for other threads to add requests.
+ */
+void fuse_flush_requests_and_wait(struct fuse_conn *fc)
+{
+	spin_lock(&fc->lock);
+	if (!fc->connected) {
+		spin_unlock(&fc->lock);
+		return;
+	}
+
+	/* Push all the background requests to the queue. */
+	spin_lock(&fc->bg_lock);
+	fc->blocked = 0;
+	fc->max_background = UINT_MAX;
+	flush_bg_queue(fc);
+	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->lock);
+
+	/*
+	 * Wait for all pending fuse requests to complete or abort.  The fuse
+	 * server could take a significant amount of time to complete a
+	 * request, so run this in a loop with a short timeout so that we don't
+	 * trip the soft lockup detector.
+	 */
+	smp_mb();
+	while (wait_event_timeout(fc->blocked_waitq,
+			!fc->connected || atomic_read(&fc->num_waiting) == 0,
+			HZ) == 0) {
+		/* empty */
+	}
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f25470..d048d634ef46f5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2094,8 +2094,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy)
+	if (fc->destroy) {
+		/*
+		 * Flush all pending requests (most of which will be
+		 * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
+		 * server must close the filesystem before replying to the
+		 * destroy message, because unmount is about to release its
+		 * O_EXCL hold on the block device.
+		 */
+		fuse_flush_requests_and_wait(fc);
 		fuse_send_destroy(fm);
+	}
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);


