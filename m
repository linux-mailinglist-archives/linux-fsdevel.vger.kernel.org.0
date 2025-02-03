Return-Path: <linux-fsdevel+bounces-40660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A285A26424
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087371884E85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF2820AF96;
	Mon,  3 Feb 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnNa8T7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0D2C859;
	Mon,  3 Feb 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612634; cv=none; b=KqAcQKAbKSs8fGAHuJiAmOQHl/Tr+G4tdBI4+zXrw0iQM8rLx5juqCDORwh9Lvj9TPxKR6fQ8LpnojSaCK0SDLBx6rakv2kM8KVuxuqQLuk/49QuPekP8pzKY0ll7zwxBYFrEC6PQ7LYe9opA8+j3c68Uj8X1OY7xLDg4IkBS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612634; c=relaxed/simple;
	bh=MbZhQXOcBuoGHwEHZVCayiszN6qkd0BnW0Ck/i551cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H2kYuiPS5LQRP4vU78/M6c01yzqFKz1R0i2ByiwwHYrigvtoF2dXAcLq2SRVS+/vEYfLW41W3+YCMBvI5OBqyscWPuc5K5K6g3w9zr04qrPyxozcT/VxNuVpScvVLxvOHk+3Qcw+MJZlHz5Mj4GFXvonOewk6glspTk420gZydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnNa8T7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC6DC4CED2;
	Mon,  3 Feb 2025 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612634;
	bh=MbZhQXOcBuoGHwEHZVCayiszN6qkd0BnW0Ck/i551cE=;
	h=From:Date:Subject:To:Cc:From;
	b=EnNa8T7D5UccSRM+wCdcFk/UdgG8Kq3/Ra+Ldl2K6wsXea8HAWxPJnYC0i1JgrPNf
	 pSVoZ4YWyuAZLg6bddK314m6Q3ktup8xMVdyRs7DMdmtA8n83Lo/2QraqRkoquSPuO
	 WjPzYpPVids1sGJtVssXe8iA6jWsKMsL6NrNIDZ5N9JwsZHaE7W/N5VaLTG0gpxtja
	 RcsHTvzRjlh9sHt0hMloLZX8x1kOEgH/LtJ8BpTC2cL0gPVKnLsUWNBcgxDHrb9ghG
	 pAbZ1f/LSEVAfMIpmtjARO5Ldz14snWQPL/RyQkiQ5UJ1W/sDu0n+W+u14xR3It6u1
	 tp6QAaD6B2c4A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Feb 2025 14:56:52 -0500
Subject: [PATCH v2] fuse: add a new "connections" file to show longest
 waiting reqeust
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-fuse-sysfs-v2-1-b94d199435a7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIQfoWcC/23MywrCMBCF4Vcps3YkFyLiyveQLkI60wYlkYwGS
 8m7G7t2+R843wZCJZLAZdigUI0Sc+phDgOExaeZME69wSjjlFEW+S2EsgoLBrJOT1q5wAr64Vm
 I42fHbmPvJcorl3W3q/6tf5mqUaM9sfdKs7H2fL1TSfQ45jLD2Fr7AjwFelClAAAA
X-Change-ID: 20250203-fuse-sysfs-ce351d105cf0
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4657; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MbZhQXOcBuoGHwEHZVCayiszN6qkd0BnW0Ck/i551cE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnoR+VLf3jCrACcbHnMQYJrH2XeCxw/FYMOG/oP
 00+gwxOoeyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6EflQAKCRAADmhBGVaC
 FSFmD/4nYnAZPP4BwuBzwQJpuYc4ksGZRpzs4TtZxFoBQIpyhncnWnNlod08gLGgkVbr2UVImzn
 viiOwuht6xkkpvsuW3rzie5WaEo0UL9v7/cSdoVO6Dwe4mf1vFPX2mDIwGoUc9oDsoBiK21D4W8
 SNnYDXEWcbC+tfeVJ92SZ84KQ++mgrl31zITMkxEHcE/b1r0B4jLtCOFdKl/c3Y29LlyBeoQ8uR
 x1bKOAiBaOE1JkFpA/eoQ2/YlyJN36M8kBsBkKNyt5TXvBtmjfPeqvIDhigiVsWGjhHR0gJQ2RF
 p2u3Y6YinoLspmwzd5pWA69HYflpAaMVguMnDz4rwM3Nw/hGUoPB+j8Ukitb3YV/VmF+6lQkRPD
 GOKnzat+luOCsndHmYct2A+Prs1D914rA/b+5sRNJJ1zZxYFxe4ZTezZMpQ9qrz/9YrupG6CVlD
 QurSkI9+izwXNJL/cn9T3rkO6mIaUzCDCEwZcavxjkjNiymiUU1HylHwKSyO3giBvfPFPhlgog1
 472QXhaZjR33azVwemEF2WNNgFprEHtx/EpxuB4SU/MTjW7s5cgT7DpBpnLpyJ61he0ORv5WP/C
 xSTwIKzVvQOQvFHzR4lRCmvYd+E0Dz6emGJUuqtPc3dlSkSIJkFmsRw/p/M4cdPFbOA52PHlIfu
 v1PeREPGhIHyYuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new file to the "connections" directory that shows how long (in
seconds) the oldest fuse_req in the processing hash or pending queue has
been waiting.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is based on top of Joanne's timeout patches, as it requires the
"create_time" field in fuse_req.  We have some internal detection of
hung fuse server processes that relies on seeing elevated values in the
"waiting" sysfs file. The problem with that method is that it can't
detect when highly serialized workloads on a FUSE mount are hung. This
adds another metric that we can use to detect this situation.
---
Changes in v2:
- use list_first_entry_or_null() when checking hash lists
- take fiq->lock when checking pending list
- ensure that if there are no waiting reqs, that the output will be 0
- use time_before() to compare jiffies values
- no need to hold fc->lock when walking pending queue
- Link to v1: https://lore.kernel.org/r/20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org
---
 fs/fuse/control.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  2 +-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b27f2120499826040af77d7662d2dad0e9f37ee6 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -180,6 +180,57 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	return ret;
 }
 
+/* Show how long (in s) the oldest request has been waiting */
+static ssize_t fuse_conn_oldest_read(struct file *file, char __user *buf,
+				      size_t len, loff_t *ppos)
+{
+	char tmp[32];
+	size_t size;
+	unsigned long now = jiffies;
+	unsigned long oldest = now;
+
+	if (!*ppos) {
+		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+		struct fuse_iqueue *fiq = &fc->iq;
+		struct fuse_dev *fud;
+		struct fuse_req *req;
+
+		if (!fc)
+			return 0;
+
+		spin_lock(&fc->lock);
+		list_for_each_entry(fud, &fc->devices, entry) {
+			struct fuse_pqueue *fpq = &fud->pq;
+			int i;
+
+			spin_lock(&fpq->lock);
+			for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+				/*
+				 * Only check the first request in the queue. The
+				 * assumption is that the one at the head of the list
+				 * will always be the oldest.
+				 */
+				req = list_first_entry_or_null(&fpq->processing[i],
+							       struct fuse_req, list);
+				if (req && time_before(req->create_time, oldest))
+					oldest = req->create_time;
+			}
+			spin_unlock(&fpq->lock);
+		}
+		spin_unlock(&fc->lock);
+
+		spin_lock(&fiq->lock);
+		req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
+		if (req && time_before(req->create_time, oldest))
+			oldest = req->create_time;
+		spin_unlock(&fiq->lock);
+
+		fuse_conn_put(fc);
+	}
+	size = sprintf(tmp, "%ld\n", (now - oldest)/HZ);
+	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+}
+
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
@@ -202,6 +253,11 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.write = fuse_conn_congestion_threshold_write,
 };
 
+static const struct file_operations fuse_ctl_oldest_ops = {
+	.open = nonseekable_open,
+	.read = fuse_conn_oldest_read,
+};
+
 static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 					  struct fuse_conn *fc,
 					  const char *name,
@@ -264,6 +320,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 
 	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
 				 NULL, &fuse_ctl_waiting_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "oldest", S_IFREG | 0400, 1,
+				 NULL, &fuse_ctl_oldest_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
 				 NULL, &fuse_ctl_abort_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dcc1c327a0574b1fd1adda4b7ca047aa353b6a0a..b46c26bc977ad2d75d10fb306d3ecc4caf2c53bd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -42,7 +42,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /* Frequency (in seconds) of request timeout checks, if opted into */
 #define FUSE_TIMEOUT_TIMER_FREQ 15

---
base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
change-id: 20250203-fuse-sysfs-ce351d105cf0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


