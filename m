Return-Path: <linux-fsdevel+bounces-9651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1878440B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC471F2C1FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5A7F490;
	Wed, 31 Jan 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNyRQ21h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EEB7F48C
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708227; cv=none; b=LvGxJaqTKHZRQmCoE5JgzGRiwP0T8ctSGbeS3WmU1ZT+gr11Ypx8NRcnvZ9vLrvIOfOl1a0KTg2NNGY0AcRczDRy0fdT5AFMe2kC+AItXB3AUPA6TASmHqvhKrq+jWybqYK4iomNuCWe8UWpudYD+bJwOMjTAf1iGhTLCeJAU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708227; c=relaxed/simple;
	bh=wbvajlmHu2Pzc559QV2/etJdPcH8TtSaDFnAcjEn1N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEmEsa0SVTwAOrZJiNgcAl6oH4EZ7VO9U9YYifOaAzKrny5eWj8vUGsUQUVDyVQsI84NTGHEnRzj/T3XMImMUA2aXCGgeD+jMPVkUHOFO1MxY03lzQwOfblqAKIsYiGSdkHtxH+dobbckgK2acqxhyNw9e3onhM5/OjXCLYu4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNyRQ21h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0300EC43394;
	Wed, 31 Jan 2024 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708227;
	bh=wbvajlmHu2Pzc559QV2/etJdPcH8TtSaDFnAcjEn1N8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RNyRQ21hUfMfLZv/E/ZYj8NXMPqBtqmniRJhZ3cHzsSvX7cjsJIY9OANRlQ3jnmAM
	 NBWyAENdL769rObnD3R4hoHpGzrMbPDTRz/Q1hlE+izK4O6690uIzkLEzjuj5EjG48
	 PzAJN796d74u56W9CUTqpCdLhjbQFVSfbf3dFHgu3A3PaiBer/sED1h2RRfGf21GvX
	 TrrmFYenlc2gW2MZlPpfTWZ3eeToEJYe+1Pr7ZTuzPqbHrH/4h6kgOVrrPfPMXxBQt
	 +ALu/+vkjzZ/U9lzPIRuoiNbY3Gs6cjzOzrrzSZxE03DahaHKQG5PFdDpMjrMobAYh
	 y2SBsq8hTDzZw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jan 2024 14:36:40 +0100
Subject: [PATCH DRAFT 3/4] : hwlat: port struct file_operations
 thread_mode_fops to struct kernfs_ops
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-tracefs-kernfs-v1-3-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wbvajlmHu2Pzc559QV2/etJdPcH8TtSaDFnAcjEn1N8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8vnxI8Igwp9p3Y7znr/vcmTbVbClfOpze8r/sk+jo
 +/A42ObO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayx47hf5Hmjotn/S5Y7WnZ
 Z+lw8eO5lgWtk2O/lb7fWa6x85LCz12MDDeubeeqvfx0oZqmsdB1uYgwRqP/MnEVV6SP7YxLqHy
 zkBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_hwlat.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 11b9f98b8d75..97f118575816 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -647,25 +647,12 @@ static void s_mode_stop(struct seq_file *s, void *v)
 	mutex_unlock(&hwlat_data.lock);
 }
 
-static const struct seq_operations thread_mode_seq_ops = {
-	.start		= s_mode_start,
-	.next		= s_mode_next,
-	.show		= s_mode_show,
-	.stop		= s_mode_stop
-};
-
-static int hwlat_mode_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &thread_mode_seq_ops);
-};
-
 static void hwlat_tracer_start(struct trace_array *tr);
 static void hwlat_tracer_stop(struct trace_array *tr);
 
 /**
  * hwlat_mode_write - Write function for "mode" entry
  * @filp: The active open file structure
- * @ubuf: The user buffer that contains the value to write
  * @cnt: The maximum number of bytes to write to "file"
  * @ppos: The current position in @file
  *
@@ -677,8 +664,8 @@ static void hwlat_tracer_stop(struct trace_array *tr);
  * among the allowed CPUs in a round-robin fashion. The "per-cpu" mode
  * creates one hwlatd thread per allowed CPU.
  */
-static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
-				 size_t cnt, loff_t *ppos)
+static ssize_t hwlat_mode_write(struct kernfs_open_file *of, char *buf,
+				size_t cnt, loff_t ppos)
 {
 	struct trace_array *tr = hwlat_trace;
 	const char *mode;
@@ -688,9 +675,6 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, cnt))
-		return -EFAULT;
-
 	buf[cnt] = 0;
 
 	mode = strstrip(buf);
@@ -720,10 +704,6 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 		hwlat_tracer_start(tr);
 	mutex_unlock(&trace_types_lock);
 
-	*ppos += cnt;
-
-
-
 	return ret;
 }
 
@@ -751,12 +731,13 @@ static struct trace_min_max_param hwlat_window = {
 	.min		= &hwlat_data.sample_width,
 };
 
-static const struct file_operations thread_mode_fops = {
-	.open		= hwlat_mode_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-	.write		= hwlat_mode_write
+static const struct kernfs_ops thread_mode_fops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.start			= s_mode_start,
+	.next			= s_mode_next,
+	.show			= s_mode_show,
+	.stop			= s_mode_stop,
+	.write			= hwlat_mode_write,
 };
 /**
  * init_tracefs - A function to initialize the tracefs interface files

-- 
2.43.0


