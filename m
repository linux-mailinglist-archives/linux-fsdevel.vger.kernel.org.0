Return-Path: <linux-fsdevel+bounces-61494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FBB5892A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9167A2AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162861A00F0;
	Tue, 16 Sep 2025 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UysFGYhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1D625;
	Tue, 16 Sep 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982273; cv=none; b=qF+t0GxaRkxmEJeLZ6YGu6YRpEQuh0kZcHEsGgc/6NVtnwMF+K7/84XpfqD8Lj4kRqV/F/N085ruUgVvUt/uNeOowhvr09vyW6lv89HR2mEhESTAzzqobpGZD/hYgKp0Rb4NYDH6qxKK1qMFhJPBcJ6WDgCYD23N+5QNslNKCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982273; c=relaxed/simple;
	bh=yyWcWclGC/G6pKZwZHCA4tTUa0pSiXR6/iwKa31QtL4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mjq4jzB9cjmMRBliUP5D/WBe1UV15wKGEKLuHplz6+uB/EPsOd0XJlplQ6pLGxBvPcoj+7+Pz1CSw8VnRlXjXcg4aT6+Jr0Rt9qR4RQno1oiaolMlF5ROqEtJtuNNs4gp3pzBqmiZkdERZuRI7fbU/nciWZnPWuIlMHk6mO1CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UysFGYhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC16C4CEF1;
	Tue, 16 Sep 2025 00:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982273;
	bh=yyWcWclGC/G6pKZwZHCA4tTUa0pSiXR6/iwKa31QtL4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UysFGYhxlOkn7qU6yWTao/H8HzY/luS6VLLbvY3IxVIy6VHoJ3bH6fIopVwni/wZe
	 HsJocciy1K+ghTa/e6oUeOTcpcYpICMskkP5rZIp62yD8xwT0waC49vL6+hNxRD3uj
	 tnkQ0U13hkUB9Ae+CvBDcqsIVK0DlT3sjXFnLD1ADWbzRZUrxmQJiL8cMI1I79OOHJ
	 I57n8BtT81zXRJkKaA4Teknrdv5pr5Db1r/BX/AFl/hz3dK9fwCEnvHZ7rNYRGeO7p
	 Yf3nUKcX8+ouK+QoRAxvj/BsLlqGKvVmEq/UapShKM2fGYQKfl/ANZMWhF85iWJDEB
	 pxfzXhMo46HXQ==
Date: Mon, 15 Sep 2025 17:24:32 -0700
Subject: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 +++++
 fs/fuse/dev.c    |   33 +++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  |   11 ++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cc428d04be3e14..8edca9ad13a9d1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1263,6 +1263,11 @@ void fuse_request_end(struct fuse_req *req);
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
index 5150aa25e64be9..dcd338b65b2fc7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -24,6 +24,7 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/nmi.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -2385,6 +2386,38 @@ static void end_polls(struct fuse_conn *fc)
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
+	 * Wait for all the events to complete or abort.  Touch the watchdog
+	 * once per second so that we don't trip the hangcheck timer while
+	 * waiting for the fuse server.
+	 */
+	smp_mb();
+	while (wait_event_timeout(fc->blocked_waitq,
+			!fc->connected || atomic_read(&fc->num_waiting) == 0,
+			HZ) == 0)
+		touch_softlockup_watchdog();
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c4f..c94aba627a6f11 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2056,8 +2056,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
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


