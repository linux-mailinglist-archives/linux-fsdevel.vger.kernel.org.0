Return-Path: <linux-fsdevel+bounces-29323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A59781C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D11C21796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F21DFE3E;
	Fri, 13 Sep 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4gq5z6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8D1DEFE3;
	Fri, 13 Sep 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235677; cv=none; b=b78KJ5YUHnM3FHbPLvlZ8y/LxOG92/7yAvOVhMowQ2ncxYr5y33H34Eat8bE36ePB0MKqdRYW89sEg9IP9pdj+L2xmJRL9onF4JfrkBOKkQv6W5RVwsGIctYYGLinMfWc/H0S8vb3vNSy3UYj8StrVAP039XedtqZ+PlWURuTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235677; c=relaxed/simple;
	bh=KHbT8i/Qcxqnz2+0udQZ1J3l24AVjm4qbm+DkSqt5l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyAg4tpg9HGGU1GA71NgS3vHMfxOX5JWavQYCCa5U0ACn3pMAxAa/6J/4Fd5+yxzhbr42OL5JSYuzWZ2qyDCnnb5MXus7iWx9yqIp8PtY+gESh3LJORS/+N1S8hHqZiemvVEkmyeDLEkP168+nruWTH9EPzWxjdMn/qzDokKGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4gq5z6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF469C4CEC0;
	Fri, 13 Sep 2024 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235677;
	bh=KHbT8i/Qcxqnz2+0udQZ1J3l24AVjm4qbm+DkSqt5l4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s4gq5z6hcBvpH4Af29Xa3mpQqQYLzKD4py2xkhJFItmOHrX6Qd/Fgf6YVXRDe3MGr
	 Y6ZtMmWbFjlzRcj4YIH5Xkc3/s3iDMH749NSTPEdbLAXKYVAyc+y0M176gv5js+3CQ
	 sM+9flb6wNVmu5snNzxlWS3Jh0jMftXjUknTZwQMV25wcG7XoM8Unq4hH1/sr/r8sw
	 mH/kWzpS43Xv8h79gRRUjdNRKmpwsS/AyuC+xx+pCsIl0H3CHgvLzt/mk4TvDmLOOq
	 6CWsCS/+/JC9Bx5hZIys1oqiaV5ujeaTgpNILKa007hMD2FDMzhYguW1uISUDErtCa
	 3OkcxFDgqNMtw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:15 -0400
Subject: [PATCH v7 06/11] fs: add percpu counters for significant
 multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-6-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KHbT8i/Qcxqnz2+0udQZ1J3l24AVjm4qbm+DkSqt5l4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQIsjChr/AGoTI8XHoboWzHgL1UrmuoBOIh2
 H0F2aytFBiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECAAKCRAADmhBGVaC
 FQ/IEADDyLUPPS3+cN83808MzxZztxPDxXZD2JHsYTymxmOFO/RaD8qGe4hUZ7ZdN2LWKzMI5fr
 ppbNy6x0jKBcBM85ugKAyHqnvOuHlMrYzaKqj9+ANAywJslEBvAS/ukrrgESCwYCAKsVteGI+Z/
 8HQiNipXu2BjMQpbBsqqiNhIx9bvlR1ZXfFpndkgMklebePjxpZD1v65WqSD2tAQegFDYw9536b
 0GVXFbwG2vTPWEFHPDs+aJcgA67VQdSvHHTTw3F5ZlfEphmYdXiBTWGeKajVsSEl7yMNcKaJL35
 fs7kOeSLHIqh0fEj44Mxaxo7kAivA2UusbstCWI/Pv/lENOM5lsIcxYSZc/huctUzScUYdffl1W
 XAisX9gk2C5t1jEsqJBm0RZixHiU+Wq2C1JOZ60pg7b9hYl7f+M/nTslorqoL0d9U/FZg7DLqdO
 Dlw2uMvAA9rNutfj3ERGBr6Ko5LYiLULlICoyjDA8+1QW0zIohk7qhLyfCipFTPyTfVs1okIOIN
 3+5eFy1j/B7UjGCZVH7xZH3x7QHe81R8CYRojAQWu4pk/js1aKMe7iyvy+xakmgmSyOWxU2Xp83
 gJuk+plif3OX9OVu1StHpvYDsqookQd8OLqsIAqAaVzGVk0Q8HvCS5liO38Z/JS5bnukCW21eR2
 8bDMmGYu8mWFbAA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

New percpu counters for counting various stats around mgtimes, and a new
debugfs file for displaying them when CONFIG_DEBUG_FS is enabled:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d19f70422a5d..749eb549dec5 100644
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
+static DEFINE_PER_CPU(unsigned long, mg_ctime_updates);
+static DEFINE_PER_CPU(unsigned long, mg_fine_stamps);
+static DEFINE_PER_CPU(unsigned long, mg_ctime_swaps);
+
+static long get_mg_ctime_updates(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_updates, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_fine_stamps(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_fine_stamps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_ctime_swaps(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+#define mgtime_counter_inc(__var)	this_cpu_inc(__var)
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	long ctime_updates = get_mg_ctime_updates();
+	long ctime_swaps = get_mg_ctime_swaps();
+	long fine_stamps = get_mg_fine_stamps();
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
@@ -2650,10 +2715,9 @@ EXPORT_SYMBOL(timestamp_truncate);
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
@@ -2680,8 +2744,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
 					    .tv_nsec = cns & ~I_CTIME_QUERIED };
 
-		if (timespec64_compare(&now, &ctime) <= 0)
+		if (timespec64_compare(&now, &ctime) <= 0) {
+			mgtime_counter_inc(mg_fine_stamps);
 			ktime_get_real_ts64_mg(&now, cookie);
+		}
 	}
 	now = timestamp_truncate(now, inode);
 
@@ -2696,6 +2762,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
+		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?

-- 
2.46.0


