Return-Path: <linux-fsdevel+bounces-40636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1889A26049
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552F1166DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058D20AF7A;
	Mon,  3 Feb 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ6BmngV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A720B213;
	Mon,  3 Feb 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600641; cv=none; b=AMYAgEfqT8Q4IBqHB7DEBP7En4VyoBo5qAh8PUSdxylf3utWO7K57NI0XHWs3I9bgWbVSzSpvahXiwSvCNdcpEUiN8Wt6d7HxCSSM5s4GqKjOj5Ibqd3/dAEwUgR8s4ldIgiu9Ok/ZAVhR1lsnHQKBHfU1t/nkcVXaIOE0tlIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600641; c=relaxed/simple;
	bh=PTEQg+KoPw4rUZvEINnJWwcR+6Sxha5H214W4w+bQv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=knRxtv5iQnFJRsFYDCCelONlj7lq/lRSpEisRbDOqLGB7yPv2+5SV9T4jS12GT4KraPr3oHs0HVGe8lgqjP0OAe7/NwcuDaJCcy1zCjRL/T6rbnVVCwN5IlYlYhQWmufL5wNZ3GXWwLqJZm/4O0QQhilTy7ui+UPJGhBPeTNTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ6BmngV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E53C4CEE3;
	Mon,  3 Feb 2025 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738600640;
	bh=PTEQg+KoPw4rUZvEINnJWwcR+6Sxha5H214W4w+bQv4=;
	h=From:Date:Subject:To:Cc:From;
	b=ZJ6BmngV7dhkxhhYKl2ceQ/+uvGAWgmgReWG7Fahpdsypf741KkJ+SUod9tFS/gvq
	 JTmvF+x9waHH1KMbQyg4eVVrWfa35BacZoDsPPLIoyyAWkE9GjA1rNybf1+mdHFCih
	 P4HbZelvaVYYZqvG8sk/LDnP+pf1RSDiMm7UYEJUd4lS2Jb2EMP7Oaix/vSI2mMZsr
	 o/hgIELi2qMSPkPIfM6u7DY5DUbywPPZ91HHcwte1IiF52wrbfgELyz0BhMlDMj5a/
	 E9axXnk5N1d3XLbZIn6/QlvDwgWc7ikbmtZkTPuAgNXVYfXjzli8khi9NETsUCjsR4
	 GB+HQLEfUFaAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Feb 2025 11:37:06 -0500
Subject: [PATCH] fuse: add a new "connections" file to show longest waiting
 reqeust
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org>
X-B4-Tracking: v=1; b=H4sIALHwoGcC/x3MMQqAMAxA0auUzAbSli5eRRykppqlSoOilN7d4
 viG/ysoF2GF0VQofIvKkTvsYCDuS94YZe0GRy6QI4/pUkZ9NSlG9sGulkJMBD04Cyd5/tk0t/Y
 B7lQEGVwAAAA=
X-Change-ID: 20250203-fuse-sysfs-ce351d105cf0
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PTEQg+KoPw4rUZvEINnJWwcR+6Sxha5H214W4w+bQv4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnoPC4BprHsPxU60mfjU3S6jKFJj9kmsLN+GvL7
 ggMSdHHgzaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6DwuAAKCRAADmhBGVaC
 FdzsEACVDqbBrb8Z5INcw5Wp3DpjKBTNJPgHzNGJePMG17qx9XRC6Egpsw6hJ7uxbaQzbq0t0hG
 6L5/fUU+CYXcnzMFjwjmL1u/jtrenAOB+OpwPCb8bbWceUUJKgB8Yh0s765a2BmZl2DpTD6Mpqd
 oe3nil5bVvMDg0xhhUdZi+dGZt+OR2TVXPKbPHSLUVdxsyW6XE3h+uLNubMe/TKWqk5kXjQ/qCu
 tZMc4n1QnOvOkXAqGWJlRjwV8RLKJciGERfC+U6s//vo7vZ0GUtv7O/0OQ8pR5hkPBS+6076fil
 KilqaXXRz2HareOCY+rQ+ESRYVLgZWXpEvDfB08S0spj87oi3tZxXdBs4TOyO2GraBDQFTOtbl5
 KTAnvwo2kC4YgkvckHKOx4iOGnLp6uwwTn7FlJUjWUBHqQaH/vAh+eFuGrT+DJNO2vCUuBW2YOg
 AowckWUOv36X9yF1Auudhdsk1Fx1gdLvHDyzdy4n/ZUSMWL3Uju18sKm7NfZzccNUH/TlRpq1Pt
 ne+OfPgEv7r41yrnG2rQdmcbD3tvBaOqPTVPoTfHJNR7bIKbGC66as2OJkXvsbp5QHHqP/KnyCN
 GYfaNzE6zYbfgzQO8fP7k0hrz3GhVmNUbNDpV5DxdtgnTaj2GI8/0pVeCHkQUq11H+Wv5zACE2S
 6VuGt6+sqz/BwfA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new file to the "connections" directory that shows how long (in
seconds) the oldest fuse_req in the processing hash or pending queue has
been waiting.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is based on top of Joanne's work, as it requires the "create_time"
field in fuse_req.  We have some internal detection of hung fuse server
processes that relies on seeing elevated values in the "waiting" sysfs
file. The problem with that method is that it can't detect when highly
serialized workloads on a FUSE mount are hung. This adds another metric
that we can use to detect when fuse mounts are hung.
---
 fs/fuse/control.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  2 +-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b213db11a2d7d85c4403baa61f9f7850fed150a8 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -180,6 +180,55 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	return ret;
 }
 
+/* Show how long (in s) the oldest request has been waiting */
+static ssize_t fuse_conn_oldest_read(struct file *file, char __user *buf,
+				      size_t len, loff_t *ppos)
+{
+	char tmp[32];
+	size_t size;
+	unsigned long oldest = jiffies;
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
+				if (list_empty(&fpq->processing[i]))
+					continue;
+				/*
+				 * Only check the first request in the queue. The
+				 * assumption is that the one at the head of the list
+				 * will always be the oldest.
+				 */
+				req = list_first_entry(&fpq->processing[i], struct fuse_req, list);
+				if (req->create_time < oldest)
+					oldest = req->create_time;
+			}
+			spin_unlock(&fpq->lock);
+		}
+		if (!list_empty(&fiq->pending)) {
+			req = list_first_entry(&fiq->pending, struct fuse_req, list);
+			if (req->create_time < oldest)
+				oldest = req->create_time;
+		}
+		spin_unlock(&fc->lock);
+		fuse_conn_put(fc);
+	}
+	size = sprintf(tmp, "%ld\n", (jiffies - oldest)/HZ);
+	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+}
+
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
@@ -202,6 +251,11 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
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
@@ -264,6 +318,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 
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


