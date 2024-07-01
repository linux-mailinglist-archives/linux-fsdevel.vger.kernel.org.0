Return-Path: <linux-fsdevel+bounces-22860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B391DC94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C491C20D48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02995156C6B;
	Mon,  1 Jul 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se0TP++U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43994155A5D;
	Mon,  1 Jul 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829640; cv=none; b=n0Yi/NZBRB3oqTj8K+4uCYxbKfObwohEfsqO4oGNDu/ArG7tThJkHtlM7pzTmL2bvV9CntvHzngaS7c9wAisRqYwU4gG0GiyN8CfQr7NcUDBj06yIFfbJUcL2lL/Q9GU089y7rcvsBh60QlzhHI+Sb76VsRHB1DPxrl/DUw6lTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829640; c=relaxed/simple;
	bh=JWRcJeXc6fXcX2y9b+IE3C2Bm9hRJGE2VXVsCkiQEEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFOVGce/8D18rkoYK/oinanFkdrKtFIHa5ZSGj6WiHfHFbJfQzvM2+mqbr4i/yXWn9umnzCs4/wyFU2EjWh1/idjxS1jd/Wqnzfj6ImwFUvrmXuOw9J8+cYT4NWO3y58Z9kxtKSWTaX3sjFSGtK42UvyYcSFjZAPKn4d+W2y67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se0TP++U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1685C4AF0F;
	Mon,  1 Jul 2024 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829639;
	bh=JWRcJeXc6fXcX2y9b+IE3C2Bm9hRJGE2VXVsCkiQEEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=se0TP++UJvdc9tTwQYDWqPXK5SsoCVQEe8u53ed6hPWPwfOgnV88jaGfk7sTo2eXL
	 nRY8Iw2KVokCOgKmtjXDKPs2VPCxAu8K40B7e9mMhjpiFChsUkptNZ24fsETyJsWp7
	 5D2pKr6uJKJohwPP+TgVb9bw2jPKI/Yo9aiC+RYFhFHGudB/p3G5Ml7axOb0rU+o/w
	 wFDC7qDsqDCY2oZ+aW2yd3pLVq6BOzINc57Ooz542ufQe902LOAsamYyzUvesAO/68
	 gLkjwevJtszygqTdxvRSNkvVRfseGT4a+O9+IfgapnQnk9HZsFnrF4NiHMXOmaD2Cx
	 ApGhjU0KxyCyA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:41 -0400
Subject: [PATCH v2 05/11] fs: add percpu counters to count fine vs. coarse
 timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-5-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JWRcJeXc6fXcX2y9b+IE3C2Bm9hRJGE2VXVsCkiQEEs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR4nLWjcXTKYRX92RbOTrFgWknM7qS0hOAxr
 IJZCQkOSZyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeAAKCRAADmhBGVaC
 FfCmEACKq11QB244lQsJ4wjlEbpNH5+UfFQoAsuVPJp5dxRHy58bwatwzEoStmos+TxpRPReuYO
 BZjYKqcEMxqby1upgyyi89Q5zEcjY4WURlCYdJljzTmfLmwOxWxQSEPqAnD59ClVzeTCtubwg/9
 shcH+Zved1qwW9PV+wgOieb8ctvp5cvV/kLLH4Wf7tHxSELULTrGMj4ZCQnJ/Fwkg78BzW5cSXw
 MKJM6eQnTkYJ/qtsUFgTTqJVnoAd5GYRkotdtq5qHMu7mpa+kjTA3rRml4h+EprFZ+9KgM7iKn7
 BtSyY34jgzUZ7Y7j6mfanIFxe9wKcPN6QJO4xixne5zYaMza+GpFleQdtl5KMqw3qMkR8cJWPVw
 MUfT4rPv1o6Pwh1fNhqiH1mM2sn3PTbYaYKRzqV1UZg4wdICMImwMvZwQOWS9wtReEdWgUdaFV5
 FcbwT2b4VRyf0gmqgjhOH5IcWz5ga4SiIfxyUt6yooXr5maDt+gzF+3d5Iz6FwPZB1opA37HRfO
 4lSGU+7r1Mw2ddmhvir8Ou7hyu5rbN3QZtxiqllJUt1EjD74o7zu8+l5kEMUPKh7hyEl0qRrwL2
 OtN2Sp+jGr24JxTcjGfdSrCSRgQK8wGLxb91PP9SWu2lTnLgC6ejX/I6eIDgdOwqb8OKfVyiSPW
 b6R2CXcnj8f+Hfw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Keep a pair of percpu counters so we can track what proportion of
timestamps is fine-grained.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 12790a26102c..5b5a1a8c0bb7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -21,6 +21,8 @@
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -64,6 +66,10 @@ static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
 /* Don't send out a ctime lower than this (modulo backward clock jumps). */
 static __cacheline_aligned_in_smp ktime_t ctime_floor;
+
+static struct percpu_counter mg_fine_ts;
+static struct percpu_counter mg_coarse_ts;
+
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2636,6 +2642,9 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		trace_ctime_floor_update(inode, floor, now, old);
 		if (old != floor)
 			now = old;
+		percpu_counter_inc(&mg_fine_ts);
+	} else {
+		percpu_counter_inc(&mg_coarse_ts);
 	}
 retry:
 	/* Try to swap the ctime into place. */
@@ -2711,3 +2720,32 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	u64 fine = percpu_counter_sum(&mg_fine_ts);
+	u64 coarse = percpu_counter_sum(&mg_coarse_ts);
+
+	seq_printf(s, "%llu %llu\n", fine, coarse);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mgts);
+
+static int __init mg_debugfs_init(void)
+{
+	int ret = percpu_counter_init(&mg_fine_ts, 0, GFP_KERNEL);
+
+	if (ret)
+		return ret;
+
+	ret = percpu_counter_init(&mg_coarse_ts, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_fine_ts);
+		return ret;
+	}
+
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
+	return 0;
+}
+late_initcall(mg_debugfs_init);

-- 
2.45.2


