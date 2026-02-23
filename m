Return-Path: <linux-fsdevel+bounces-78039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNK5N/DdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFAA17EDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5F9304CEA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3D37E2E0;
	Mon, 23 Feb 2026 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEWx8Hi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA737D11D;
	Mon, 23 Feb 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887996; cv=none; b=iwUFZlPFW/RNM7VFvXyTfbVGbQyb3baLOZOgthx+j47kEO/aWQ8k8ym+tsj0d80XudVQw4bwnCY+4YKXHLrgmf6lVtQOON2OshvAOZ1l+yfv+cEw44+CqvjBnqmld53/RjhSk2y/24iVw1zBTXI1e8ke/415Ow/5GvEH65WW7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887996; c=relaxed/simple;
	bh=2xV+wUcDg5Qbf0unWMWw7MKiuY2kzAYYBg+1fTOej9k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/VtcfSG/Fu4R7U/19igHQJ+8+vaGziZpPasncvuBfjscR1Vtjgj7d4oLSp1rTxm24LhrjfcXV0atu838+9InpyrkE9dzUyGltXN7olHoIHRO0lorJqL+fOcuTrQk3V3eqXDeq6uYMc5tuXQYHcNyBmrdSroSNou/k1kYAsFUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEWx8Hi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A145C116C6;
	Mon, 23 Feb 2026 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887995;
	bh=2xV+wUcDg5Qbf0unWMWw7MKiuY2kzAYYBg+1fTOej9k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LEWx8Hi5tAUnWyAH5lviIhmh51f8jd5gPXaA/btbpERMTJPI/pmuWX8oGH0NXfu5M
	 Q+JVOQ1NPf2OWkuSSpQMWP12wwwkFMLyMt+uimoiquv/qGUXqrrB55/dAOjf3KjEfr
	 I2g7IHo5zgSay27JpU7j2a1UZ6HttwcErC+BiHAO/Mebep7QoMFtsjGwWV3ckh37Bt
	 PTBAOIH3xXZR4kPMrSfaDbq4Yb2gNr+9l+NCP8YUBEc0ox5Yu0xvkOiwPEMogYgWhd
	 GCIbFt6AFKRr87DRv4HPdpQ6VBMmNbGhe8m0AJ6+MVYLMEuT7loeoD65UOXpitswyI
	 o9wGOKwvQo+DA==
Date: Mon, 23 Feb 2026 15:06:35 -0800
Subject: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before sending
 FUSE_DESTROY
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78039-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8CFAA17EDB8
X-Rspamd-Action: no action

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
FUSE_DESTROY to the fuse server, and the fuse server has to write all of
its pending changes to the block device before replying to the DESTROY
request because the kernel releases its O_EXCL hold on the block device.
This means that the kernel must flush all pending FUSE_RELEASE requests
before issuing FUSE_DESTROY.

For fuse-iomap servers this will also be a problem because iomap servers
are expected to release all exclusively-held resources before unmount
returns from the kernel.

Create a function to push all the background requests to the queue
before sending FUSE_DESTROY.  That way, all the pending file release
events are processed by the fuse server before it tears itself down, and
we don't end up with a corrupt filesystem.

Note that multithreaded fuse servers will need to track the number of
open files and defer a FUSE_DESTROY request until that number reaches
zero.  An earlier version of this patch made the kernel wait for the
RELEASE acknowledgements before sending DESTROY, but the kernel people
weren't comfortable with adding blocking waits to unmount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 +++++
 fs/fuse/dev.c    |   19 +++++++++++++++++++
 fs/fuse/inode.c  |   12 +++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d15e..1d4beca5c7018d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Flush all pending requests but do not wait for them.
+ */
+void fuse_flush_requests(struct fuse_conn *fc);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170d4..ac9d7a7b3f5e68 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -24,6 +24,7 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/nmi.h>
 
 #include "fuse_trace.h"
 
@@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Flush all pending requests and wait for them.  Only call this function when
+ * it is no longer possible for other threads to add requests.
+ */
+void fuse_flush_requests(struct fuse_conn *fc)
+{
+	spin_lock(&fc->lock);
+	spin_lock(&fc->bg_lock);
+	if (fc->connected) {
+		/* Push all the background requests to the queue. */
+		fc->blocked = 0;
+		fc->max_background = UINT_MAX;
+		flush_bg_queue(fc);
+	}
+	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->lock);
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be93e..58c3351b467221 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy)
+	if (fc->destroy) {
+		/*
+		 * Flush all pending requests (most of which will be
+		 * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
+		 * server must close the filesystem before replying to the
+		 * destroy message, because unmount is about to release its
+		 * O_EXCL hold on the block device.  We don't wait, so libfuse
+		 * has to do that for us.
+		 */
+		fuse_flush_requests(fc);
 		fuse_send_destroy(fm);
+	}
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);


