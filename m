Return-Path: <linux-fsdevel+bounces-58436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0BB2E9BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A83B7582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0A1E7C23;
	Thu, 21 Aug 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0cmqUaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF821DDA15
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737472; cv=none; b=GI/SwnNArS8mpM1j86A/a866c8+946HiXHYfOgiQ3ttTosc2J4tTyDeOZrGRXOwQzgFsnrsUiDtNOYzBxthaCnynAicEvBk6FYExhnS7vDtrmFU4T9zf3bxEjuq40E9mIKybV1gbFsj+hRBSOt3LQ8NRoZUqHfIlyEWdwfI2WPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737472; c=relaxed/simple;
	bh=gPIMn3dsdudsCEbrUudkGr4mVI5yJpnkV20JfuNylkE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6nuy3z1nJcxTlMIVKDlIEsj6EX7YnZ/dBt8aVgugnSj2s31rfskzKZ90qJjHJUUL7Ieo5A1KH3Avd9sOrU2DhV3wXKagOUWlFQDcopNDKcqb7rXawcGD/WA1W3rFwaUAljx0bz2renQ5EEFu1yRJy+YLucYbN81Z0KVuMk44hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0cmqUaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C404C4CEE7;
	Thu, 21 Aug 2025 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737472;
	bh=gPIMn3dsdudsCEbrUudkGr4mVI5yJpnkV20JfuNylkE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=p0cmqUajqyGXdT8gVm0iUvm7m+36BBQuWjCWb4WiEwFKKggGZaFKrSGcBBIbmSobi
	 vlAiiqaN22fbKpW58mflzOwk87otICS9Oesm04xVhtacFAedoFtVG9HLLdoceVlEZw
	 MigVwVePYRM79hoF7jGYzHlKcsTU1z8iQVL6YojGpnrcHh5TkG9DzProfER5qAs6AK
	 xmayALEkdyECfVOxu6C2Z5unxLCX8OdyXcoFJVFduho60Ru+zOigxt1F8QkZw7r3rK
	 f5C4VVwU/WMEeKdSeCNGLG/KKwj2QnxPCyVjFtNkexQhhsK54SlQRw3u3kxMQ/IsYR
	 5VAGsJf68wVUQ==
Date: Wed, 20 Aug 2025 17:51:11 -0700
Subject: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708588.15537.652020578795040843.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
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

Create a function to push all the background requests to the queue and
then wait for the number of pending events to hit zero, and call this
before fuse_abort_conn.  That way, all the pending events are processed
by the fuse server and we don't end up with a corrupt filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    6 ++++++
 fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  |    1 +
 3 files changed, 45 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bfd9..2b5d56e3cb4eaf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1249,6 +1249,12 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Flush all pending requests and wait for them.  Takes an optional timeout
+ * in jiffies.
+ */
+void fuse_flush_requests_and_wait(struct fuse_conn *fc, unsigned long timeout);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049f9..6f2b277973ca7d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -24,6 +24,7 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/nmi.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -2385,6 +2386,43 @@ static void end_polls(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Flush all pending requests and wait for them.  Only call this function when
+ * it is no longer possible for other threads to add requests.
+ */
+void fuse_flush_requests_and_wait(struct fuse_conn *fc, unsigned long timeout)
+{
+	unsigned long deadline;
+
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
+	 * Wait 30s for all the events to complete or abort.  Touch the
+	 * watchdog once per second so that we don't trip the hangcheck timer
+	 * while waiting for the fuse server.
+	 */
+	deadline = jiffies + timeout;
+	smp_mb();
+	while (fc->connected &&
+	       (!timeout || time_before(jiffies, deadline)) &&
+	       wait_event_timeout(fc->blocked_waitq,
+			!fc->connected || atomic_read(&fc->num_waiting) == 0,
+			HZ) == 0)
+		touch_softlockup_watchdog();
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab1d..b3b0c0f5598b4a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2045,6 +2045,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
+	fuse_flush_requests_and_wait(fc, secs_to_jiffies(30));
 	if (fc->destroy)
 		fuse_send_destroy(fm);
 


