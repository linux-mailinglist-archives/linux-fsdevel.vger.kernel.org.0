Return-Path: <linux-fsdevel+bounces-23294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF792A647
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73CAB221FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25300149DFA;
	Mon,  8 Jul 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK+m74Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE48143896;
	Mon,  8 Jul 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454032; cv=none; b=uRnYXEGVMhwx50c6m8/mUMBYtRnRdTv74cVF58GYBnrgwWZT8/bNbuV0shhVmpRJPUfhXd09htXGgz8hCU1iGBVkKDEgU0eqSUzw4o4Yr2dvPhYmWZFdqrmW1xYF5hJMnoFiiUa+pG4oUL3Q/OSr+Kmy3LNaL5rSjniPq3JBpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454032; c=relaxed/simple;
	bh=3Lbwoi1OsUrhgHdGPKIfY5gAyrpedRUJApKASCysnEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFRU08VCCvtIBCmWAHi6+4an3aY7AbjadXAByXKyUG7KCfSeI2QhFPGL9MOsHn1rIMrCfj1LpNsoSlgp+ow/NBbhcZncZ/DX/aIw9YPniWoCg31q2VrAytLoAb5I5hksk0w6gR/T7136LAcb9wGcKrswi09qZ6krL/hCejh7qVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK+m74Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A013CC4AF0D;
	Mon,  8 Jul 2024 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454032;
	bh=3Lbwoi1OsUrhgHdGPKIfY5gAyrpedRUJApKASCysnEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZK+m74LnLYmP4hKfEEcqImJ2WWsRHzZh8aQS2kRZGkex1opFTkUCiiYOFpMJP7NN9
	 C+xzCJa17mVivTegTyPfkpvrSabc7XuOrKZy8hm5P5CFEniVLhvKlvb45MexFsgWWM
	 fErZ+I3DuJeHvAZdMxnyFH/dGPWM1jgyYweg5qr2jLXuk7+6o0dsJl3tem3MrIxo0q
	 q3SQRCFGMSKU86GPjjS+TE4ZL/Fcg9sn3y8raEHC2szPsIQsSk8jQyW7S037K/3dty
	 cKmeWH6QdtXNzBK++SHOJJtGDBQ1x9qUkwyM4uTQPIYjsf/vKZmU1CQiRNGuK7o+1S
	 FsG+vxtXTW8Lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:36 -0400
Subject: [PATCH v4 3/9] fs: add percpu counters for significant multigrain
 timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-3-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3Lbwoi1OsUrhgHdGPKIfY5gAyrpedRUJApKASCysnEY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuDCTkX86wQZxt/FexePHG2g2qXIymEXEO5D
 zP/7w+C29GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLgwAKCRAADmhBGVaC
 FfVVEACRsXJxxH7+xhMllN37rUAlU4nCqFXZe9HjP1jSGjrbBm11+KznLCamc/MioFvpOSKHatn
 ux0gbVneJuEOw0SRtqvfdyvpcIeA3tr//bDyUEE6iFIfYQs3Ti/jroUTL0ByKzCv/Gk+VhxNJeA
 pLwbZgxJmDPjbq3COlkop/rp5Phdfwof3sI/q9IvlJ+NyemoRN2SNmMgSM0nuoYoht2I4n9twAb
 C8FiR+a7Eumi5eynE8zj4EnvuxZ+Hgo0/wI6ob+vV9720GGQYzNjddDkeb3tq1LHdrE630uxnGT
 A4wx3CDkxBATrZFdCGwwZP1Hu4PZCAg2H6//4T3VihPP/s9TBa6hIyCyA3QIxP9CYhhrckj6ILr
 mVOH5ZTbJQCEWThtzT6n2CcjoGnNjYSQwNWrNpw2lLpONd5EKdz7BC89OCEFIsYKjixhce4URO1
 nUelqVu6pI8wlUzh972tX+6J6qUJlVzwP9kVDaY93iILZOEZQKjhr3umIqtkZzqNZhLL1w3IvCl
 FdNKQPT6DUOCpVGSXU7SavEbux6lnmq/f9TdrrmzcHKN/zfys7Fz/GIoQYjVVP87eelAXPPFCc3
 /oz5euHbjCPt+3nY8JTmpDCn7sFZTcZNpMd+619k/41SELlbrvgeMU0JeSdNzEiSFtsbCb1JG3h
 ZAi75SeocmkMcSA==
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
index b2ff309a400a..9b93d0a47e55 100644
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
 static __cacheline_aligned_in_smp ktime_t ctime_floor;
 
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
-			if (!try_cmpxchg(&ctime_floor, &old, fine))
+			if (try_cmpxchg(&ctime_floor, &old, fine))
+				percpu_counter_inc(&mg_floor_swaps);
+			else
 				fine = old;
 			now = ktime_mono_to_real(fine);
 		}
 	}
+	percpu_counter_inc(&mg_ctime_updates);
 	now_ts = ktime_to_timespec64(now);
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


