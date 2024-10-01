Return-Path: <linux-fsdevel+bounces-30481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A683B98BA5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082ADB231D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD01C32FE;
	Tue,  1 Oct 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfnDYDpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EC1C2DCF;
	Tue,  1 Oct 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780367; cv=none; b=b9sbVAcuV+WMnLmo+F39c3eJHHKkxiIiAex64oSGjcEEwyfOTtaDfwpftg0l9UzlDphx77nrQV56+rnhI3dajHHK2zjoJGeQXSKiQ5ljZSdW3jsGPok0vydpB2314/Ce7QeSRofd8v6elJxHJYRPzvxRs/ZKGlSlp7sS5+khDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780367; c=relaxed/simple;
	bh=bnxqTLrbNZyT1g0NvyIT2ylk9FHviHzTCIeX6Q+a9Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/mUf7jyGHlmRrVEIbWD9KIGxqnZ5qLoX0KH9QvkY2VoR2YCfNoGr/RUs9dH0HEwfkPXuhD+ZLbPTbYogFA0Xinfe7s1jJje/320DMx5iPOauTOT5JzzlnpwDyIEj6s/XdfZo9ohC5srn6SZbUx1ffzk1NzMwkEEB6qBIo2pdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfnDYDpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB15BC4CECD;
	Tue,  1 Oct 2024 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780367;
	bh=bnxqTLrbNZyT1g0NvyIT2ylk9FHviHzTCIeX6Q+a9Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GfnDYDpcxS3boT3U4rQLJwULi0a8n222Fjnp1VCMDfC20mmbQD0cDIQadBM51cgPJ
	 nV9YRO7/QWGpLPtne8HTI+7ACDNc8Yh6wr2X2n11INCbNF2nFwFWdG88ogoEctFXGK
	 3eTu3I7U31GhahuJcVqwWBQB62Ha5QtCSqJPyxODA+GxhlZ8/ILXzGt+LHu8ChZiUz
	 PC8M9TXzE6TMHP8suehx38ysXd9H+7CO37Wvfw9VlzkPrWwpi+KMc32f+amoNQvAyW
	 GH/RDL/sP0VJ6V8ofYYdHgnT5D8Q43Va9pxygzXntA2zx8I+RlbyMIblG77RXge9rT
	 J3cX4dtYnSwHg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:00 -0400
Subject: [PATCH v8 06/12] fs: add percpu counters for significant
 multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-6-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4249; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bnxqTLrbNZyT1g0NvyIT2ylk9FHviHzTCIeX6Q+a9Tw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X6uFTDpmruN1n3YxfQ4M9GqHLCg78dcLoDF
 Xy4u5w/fieJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+gAKCRAADmhBGVaC
 FWKuEACrNZonEdFb91CPslE1FKZ3EnjTmpY62WjtfzkO/dS6Yc+5Vty9sBbTC2Wgj8swV7VQI1E
 3n1u4rMgrfPOlKr/QKBU80elsZhvrOmrrheb8ui9AcOo1I+XdXePrsG3aobdnQ/Gv98zQCACcb4
 8B3sikCLn0hTps4oScihpn6zZyM8TBMb0TElbFDmt0PEZNuki6joWMvpLwvyNH/nfI03Hw2fpfK
 oAdmhyFG2rHsyZIGH4wystUL77V2sapnE7zcnoj6JqkAMp8tK3NkVkUcusLKJYJeacY1MAupboZ
 czHepmwuiXJUE6Cqgy6F3qrOxev1S6jHvRpKb2cKCgvO4rVEIBkIs5mZ5U4Sb1CHU3jf+wLsvbd
 QRY6NtWBCfTUH5a9hly1Yd3oryA+TCSVmZitD/8XpNEsU+vwLG6WEC2ca+5ElyS1snzgDfhFIBB
 de7bQwlpZzQi44aNXyKQOwkQNze6xRmXR5rDhdRhFgkmvBu/cOoqP4g5Sr1MSVY4uQ+1qNcBIau
 Xf1Aq6G1ho60wNVM5P5giwaUn7DeV26EjG2JGKgxypBjstKfHItRHYZFrVfl08OyWr8hK1UplDh
 bQdjV8UIwzVG91dY0MV35yqrh2hcuKJFCN3kZ6Td8t43eJprgUnh/lnWZtbYu/IU9B5zDnkuF9T
 35pY/z3vA4fyIPw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

New percpu counters for counting various stats around multigrain
timestamp events, and a new debugfs file for displaying them when
CONFIG_DEBUG_FS is enabled:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1a7eff2a40e2..e46f7170851b 100644
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
@@ -101,6 +103,69 @@ long get_nr_dirty_inodes(void)
 	return nr_dirty > 0 ? nr_dirty : 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static DEFINE_PER_CPU(long, mg_ctime_updates);
+static DEFINE_PER_CPU(long, mg_fine_stamps);
+static DEFINE_PER_CPU(long, mg_ctime_swaps);
+
+static unsigned long get_mg_ctime_updates(void)
+{
+	int i;
+	unsigned long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_updates, i);
+	return sum;
+}
+
+static unsigned long get_mg_fine_stamps(void)
+{
+	int i;
+	unsigned long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_fine_stamps, i);
+	return sum;
+}
+
+static unsigned long get_mg_ctime_swaps(void)
+{
+	int i;
+	unsigned long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_swaps, i);
+	return sum;
+}
+
+#define mgtime_counter_inc(__var)	this_cpu_inc(__var)
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	unsigned long ctime_updates = get_mg_ctime_updates();
+	unsigned long ctime_swaps = get_mg_ctime_swaps();
+	unsigned long fine_stamps = get_mg_fine_stamps();
+
+	seq_printf(s, "%lu %lu %lu\n",
+		   ctime_updates, ctime_swaps, fine_stamps);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mgts);
+
+static int __init mg_debugfs_init(void)
+{
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
+	return 0;
+}
+late_initcall(mg_debugfs_init);
+
+#else /* ! CONFIG_DEBUG_FS */
+
+#define mgtime_counter_inc(__var)	do { } while (0)
+
+#endif /* CONFIG_DEBUG_FS */
+
 /*
  * Handle nr_inode sysctl
  */
@@ -2691,10 +2756,9 @@ EXPORT_SYMBOL(timestamp_truncate);
  *
  * If it is multigrain, then we first see if the coarse-grained timestamp is
  * distinct from what we have. If so, then we'll just use that. If we have to
- * get a fine-grained timestamp, then do so, and try to swap it into the floor.
- * We accept the new floor value regardless of the outcome of the cmpxchg.
- * After that, we try to swap the new value into i_ctime_nsec. Again, we take
- * the resulting ctime, regardless of the outcome of the swap.
+ * get a fine-grained timestamp, then do so. After that, we try to swap the new
+ * value into i_ctime_nsec. We take the resulting ctime, regardless of the
+ * outcome of the swap.
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
@@ -2723,8 +2787,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		if (timespec64_compare(&now, &ctime) <= 0) {
 			ktime_get_real_ts64_mg(&now);
 			now = timestamp_truncate(now, inode);
+			mgtime_counter_inc(mg_fine_stamps);
 		}
 	}
+	mgtime_counter_inc(mg_ctime_updates);
 
 	/* No need to cmpxchg if it's exactly the same */
 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
@@ -2738,6 +2804,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
+		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?

-- 
2.46.2


