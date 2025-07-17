Return-Path: <linux-fsdevel+bounces-55315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9BB097CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2472E5A3356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C325A353;
	Thu, 17 Jul 2025 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKDeFji4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E3241667
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794811; cv=none; b=awIpIqblfsch4AJQ6X9NPyhjrLx7RTWSCdbuMsnM5RNtQAOe2+YRDFlUgIEurhkLFFwsZ4MN6hlvIz+uhkpR1IY1IWQSXVXtizp//7IoE4uQ76zGy7MGKa8tOFhxvQcM/RuubZVZAzp1b7ieuNEMtnNWp0622lHKstCVd63Z2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794811; c=relaxed/simple;
	bh=z+oe+NY0h6zFaJ+shFCeBwHcCX+VBZtkH4SgVHlOhjo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i79nU+faDrYJ7YszNSjv0Drd1tVZczFABzuv76CjA9z9nU243N7ulsFtj1lHAoCPOmOBatRJVnZ8EDqo4SAh3dsYp7JCoX+1Kk21ZrbpGSyGpE+fBqXi0+lc3o4kAPnTmOu0JBgw1vgYgBv3EEKUoF86vQ/ze2MetKNQkytebK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKDeFji4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2257C4CEE3;
	Thu, 17 Jul 2025 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794811;
	bh=z+oe+NY0h6zFaJ+shFCeBwHcCX+VBZtkH4SgVHlOhjo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BKDeFji4bZhuPHKBFm8oHHltkg5qD/CufpX6kPlB5YjJaG95IX8+OViTfjPT7JysM
	 3k4VSRpvpdMz/t919IWwmolw1MAcPZX2xErUS+B2jxcI9Njw3s5LsGvIwcsex96n7y
	 fwI3wcRvGbCoZ0w+VssMx0+Q2oflfu0Pr47Ik6KuOalc7ob67sM/K7EkhlwButARAs
	 Vx6gJ0+EbhTTRsFz40dhLX6YPTyTtGWx4koZ6nhwyI6Kr+lwHcuKTD4uLCE5C4VJEM
	 V0mw4fE+C9ZkP1vUhY9Ws/UEjOrs5eK/ocUi3U2ki2eoAYgdAKp6Fvakn+4Tsa5i+p
	 EZXchBeHYjNRQ==
Date: Thu, 17 Jul 2025 16:26:51 -0700
Subject: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
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
index b54f4f57789f7f..78d34c8e445b32 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1256,6 +1256,12 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Flush all pending requests and wait for them.  Takes an optional timeout
+ * in jiffies.
+ */
+void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049f9..5387e4239d6aa6 100644
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
+void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
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
index 9572bdef49eecc..1734c263da3a77 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2047,6 +2047,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
+	fuse_flush_requests(fc, 30 * HZ);
 	if (fc->destroy)
 		fuse_send_destroy(fm);
 


