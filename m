Return-Path: <linux-fsdevel+bounces-23563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB08392E59E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7511C2332F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06A16CD3C;
	Thu, 11 Jul 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNqlpCJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA516CD0E;
	Thu, 11 Jul 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696114; cv=none; b=PQv+wtgOwMiT4n9elUjTBWtbAI+Hp81ii2jCzwFDOdGukAyVnmSFOo0wvkzGSU8xRj9NneATtJIy02ju5DvpzERuVSi0mwhzZq2EEUVam5vDHwIgLg0icni4nJv4m2Mhc3iq+JGBSpCxAdGJwcET8mpLbvelDjRxK2wV0O0cyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696114; c=relaxed/simple;
	bh=V0Y36Pam00rCiMQb26squSrDlnu7zkSekBYQGaNEp4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r65QmJrhGLyPKXgnh0gKeimcqEYjc7tCuPtjbOc+NUsSPzwnMPVIxJnxOsN+6IGi7qimy1eDbXjjaWshx39pOD3E7wUYPU2GGVh93PDKcmb07qQpdKjC5ISa1O9/Xcmo8YuW33YMbKMUvgaIuyTHZrxXkMb8FPv+1oXjR9p8xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNqlpCJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BA0C32786;
	Thu, 11 Jul 2024 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696114;
	bh=V0Y36Pam00rCiMQb26squSrDlnu7zkSekBYQGaNEp4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JNqlpCJQnzaR4gPRF+/O7iGm2A36GRWO+KYPfgCzi+SSbIJ978sLXFTiY7DHW2bE+
	 eGFmiXzdEx7tdFvxZrS8DXqAwndXrA2C1o5/vvB9K8i68QH2Ewh29kC00nDEodVbE4
	 FGz+TV/F2NmCZueArvI+bsTRWDzQUzQvURwbYUXojZlDeJ4qb/uL2WLucfVPg8olqf
	 7s78U0dC7qDEidr4Hr1Xv4cO3CpxgpquMVzYVT1tTg9xPdewRFVqA7SLvfGnntJe5P
	 rJDK7r5NSwVCzs4BrJ/5g8Wujp/7ggImfhB9jhhSY2N+Gxs07I1C/bCj5G5MBtTdAC
	 4mFINDf7SE5/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:07 -0400
Subject: [PATCH v5 3/9] fs: add percpu counters for significant multigrain
 timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-3-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V0Y36Pam00rCiMQb26squSrDlnu7zkSekBYQGaNEp4g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70krkIlkGBeCvXUTXPhRsNRgPGJ/7YIxm4VL
 oKt1D2isCCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JAAKCRAADmhBGVaC
 FW9aEACXcSFuqDDqkal+wDTNWITDuTTUB2w8mpenTaC/RQ3UZtBsS3UcX1Cx8QGaA/9P1j70Kpc
 b24dZI2nx8fs3w6Tdw+tosbB/bBOkwvgj6FdMTijoam8dSosicCguBmMSx5afItFNUeokv4BpZq
 fYTF7BCzFykIsuYa8XzhyDtFt5TpzJtbHjrFMhpCioS62H8q+jReo87cZThXZkAagQYFnFb7G2X
 yNacNVvoBPllyhx9PA0PdCv3+A5HDmtWKzFH/w+doHLJb3Umabh9NkkQNvf93F5jKFrpMD9jNxa
 odgFtZ7FVa08ZF5AoVNUUa7/TwwAYlsvMJt7eZsthrL2N5/zth9xDVzCJd1qVvgwrAjfKUzo2Co
 yKM5XS+ZmsTnpi1u6TesAh1lvQk+L3uX01nCXJEtyovW1FvVRTPBgFNvviObAKTj/cyd2ZHJno0
 iaC79matLqywBRRBk7lkHD48raPWyTxIniS3Oo8dAzxF+sRZeMZFkMwgnuLXyJk/oghLI0NqlUf
 dXAA5OHTlY0zGAZWoVLrcnPu2NXMDt9074Qvn7BcbYsOs8KVGY9Wm3XyT+IX0c9FQX1O6bWT/J3
 oTWjUmrPm+su1GqxnnelBFzr1W79r+m/y4xgRiiD9eJLqFBEx4O5EoSFC+o6wdeplizkl0ovYh/
 /RbyRLwcUU9VYrw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Four percpu counters for counting various stats around mgtimes, and a
new debugfs file for displaying them:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches
- number of floor value swaps

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 81b45e0a95a6..011148c82901 100644
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
@@ -70,6 +72,11 @@ static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
  */
 static __cacheline_aligned_in_smp atomic64_t ctime_floor;
 
+static struct percpu_counter mg_ctime_updates;
+static struct percpu_counter mg_floor_swaps;
+static struct percpu_counter mg_ctime_swaps;
+static struct percpu_counter mg_fine_stamps;
+
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2654,6 +2661,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 
 			/* Get a fine-grained time */
 			fine = ktime_get();
+			percpu_counter_inc(&mg_fine_stamps);
 
 			/*
 			 * If the cmpxchg works, we take the new floor value. If
@@ -2662,11 +2670,14 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			 * as good, so keep it.
 			 */
 			old = floor;
-			if (!atomic64_try_cmpxchg(&ctime_floor, &old, fine))
+			if (atomic64_try_cmpxchg(&ctime_floor, &old, fine))
+				percpu_counter_inc(&mg_floor_swaps);
+			else
 				fine = old;
 			now = ktime_mono_to_real(fine);
 		}
 	}
+	percpu_counter_inc(&mg_ctime_updates);
 	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
 	cur = cns;
 retry:
@@ -2675,6 +2686,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now_ts.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
+		percpu_counter_inc(&mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
@@ -2744,3 +2756,49 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	u64 ctime_updates = percpu_counter_sum(&mg_ctime_updates);
+	u64 ctime_swaps = percpu_counter_sum(&mg_ctime_swaps);
+	u64 fine_stamps = percpu_counter_sum(&mg_fine_stamps);
+	u64 floor_swaps = percpu_counter_sum(&mg_floor_swaps);
+
+	seq_printf(s, "%llu %llu %llu %llu\n",
+		   ctime_updates, ctime_swaps, fine_stamps, floor_swaps);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mgts);
+
+static int __init mg_debugfs_init(void)
+{
+	int ret = percpu_counter_init(&mg_ctime_updates, 0, GFP_KERNEL);
+
+	if (ret)
+		return ret;
+
+	ret = percpu_counter_init(&mg_floor_swaps, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_ctime_updates);
+		return ret;
+	}
+
+	ret = percpu_counter_init(&mg_ctime_swaps, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_floor_swaps);
+		percpu_counter_destroy(&mg_ctime_updates);
+		return ret;
+	}
+
+	ret = percpu_counter_init(&mg_fine_stamps, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&mg_floor_swaps);
+		percpu_counter_destroy(&mg_ctime_updates);
+		percpu_counter_destroy(&mg_ctime_swaps);
+		return ret;
+	}
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
+	return 0;
+}
+late_initcall(mg_debugfs_init);

-- 
2.45.2


