Return-Path: <linux-fsdevel+bounces-23691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C166D9314C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFDC2836DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EECE18EA99;
	Mon, 15 Jul 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTkc25ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44318EA72;
	Mon, 15 Jul 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047760; cv=none; b=HaacfFSxRJK+JduoXTv4KcULgzdazvb7Rw0w8qLVwPkayEBffzYib8eWjeGuKKFrJUYr6xmq0bDaYUaH1H7CUr+5ZVaqZ4Fgg3cDiOdljtL/Wa3mLOrdJSm7V+ibb+JzdxW2DQYkS/xMtikIBJ0TWjhG7jp3ZS8BQniAEXuGczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047760; c=relaxed/simple;
	bh=HU6vitpuM/kW1drnmaJbobayjjiX3I313g5+a5XkSf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDdQBUePusgrAyBTwKtzxfxW4/5YTbC+ggQagAMSD9nIhJwuzNP18eb0Ja9D13tp2k27qfW9pMMsMYoSJcVfPITk1VN/LU7NEa7Up9NLiSdSXhodS8Ds5qx3Wx8uKtQPttPFNIKA7WQII3i+6TbnN85rfGdOx++wAltq3oQ7PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTkc25ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9369C4AF0F;
	Mon, 15 Jul 2024 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047759;
	bh=HU6vitpuM/kW1drnmaJbobayjjiX3I313g5+a5XkSf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gTkc25ssg6JIYDP5yx56GycmMYuUfPA/FzBDPYtSausd5bgyrigtG6xODVb8OFUDc
	 W55GGEX8O4LsV/vWIWiJXaEW57ho7kAdFYc7OntI/7DGEEG+UzzuKwUgoTgXmVHr0D
	 nskM2bOoF9umr01Z2oPfDiJh31unMRdMxVeWkCddFmP5YTNa9cufjicwUcxSdODguS
	 x/ocBfBFbu7LbPcwHdrStZ3DkRPrwj281kjkwLf2LxHJWPf+PfUse8dL0zznuS0lL/
	 BhOIYPIVsO7NG9BM274kgSdWSBGLKQn3Azf6ARWdsZ/uEBb4sVuN+Qrt/08zmgfGyr
	 Zgy/6fN8dnQHA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:54 -0400
Subject: [PATCH v6 3/9] fs: add percpu counters for significant multigrain
 timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-3-48e5d34bd2ba@kernel.org>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HU6vitpuM/kW1drnmaJbobayjjiX3I313g5+a5XkSf4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrCYPk7Gycow3R8t8u9VHqvaLk0qL2DGj/tC
 M6baL/u3SKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawgAKCRAADmhBGVaC
 FfCpD/wO35AVGJ7f4oBU8BPuQpqmK72PLEFjcoUJMSz/9hbuLYnDFxXNGdedZya7sbm3a82unkI
 OR0VZkAsVmwdUxJJHMEiHejznHsftKsq6O28bDsrH314esp9WXHHaOIbgT9Yv95jifbccGodejm
 On3SY90Jyi46TF+2jQMGpUlKJXM+FITar4aDAy9UEpPvArFZJRuAkOLijiyecK06u0PvTGzzBEp
 /0p/+3JwbXJOSNoVNVWXsClCMRKsoxvuc+dT0G22ktyL1aX9linfibZk8ck1bk0PhCVsi/gIm8Y
 3P2pe7OkT3F6o9zDCFAr7F3XxetyoRxK7Fu5jPkE5iOR69hCGbmFXEJoya5GVNicwxqRdrRhdVn
 QjbFyIuJs1lgklHTHQK0qVdTwziVMashfL9yjxes92pMj6QKJGI3GjBsg4v8Q+BmQW6IftmEbOP
 zu757yUqHCzSRlHe0y1yf1nSY6erGn/S1Rvj41iulKcFd+96hIVbrKjZh5rF/r2wfJczzwAmsRy
 b8LgQ5p20q0H4h2GElvxGQAxGZqkU8f/uGDY1NwoCqK1dxcftLZUgbJ9HkPZ+AOnkGwGNTZ+viO
 +CzeoUQIrSpVhPYFFuzrzRvDqU/1xRLqMBMdqEf0c3dUGuE2xoWnhopq8VpLQuMBJX4RgroiKWP
 P3pBhVgyKiiwuqw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Four percpu counters for counting various stats around mgtimes, and a
new debugfs file for displaying them:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches
- number of floor value swaps

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 869994285e87..fff844345c35 100644
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
@@ -80,6 +82,10 @@ EXPORT_SYMBOL(empty_aops);
 
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
+static DEFINE_PER_CPU(unsigned long, mg_ctime_updates);
+static DEFINE_PER_CPU(unsigned long, mg_fine_stamps);
+static DEFINE_PER_CPU(unsigned long, mg_floor_swaps);
+static DEFINE_PER_CPU(unsigned long, mg_ctime_swaps);
 
 static struct kmem_cache *inode_cachep __ro_after_init;
 
@@ -101,6 +107,42 @@ static inline long get_nr_inodes_unused(void)
 	return sum < 0 ? 0 : sum;
 }
 
+static long get_mg_ctime_updates(void)
+{
+	int i;
+	long sum = 0;
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_updates, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_fine_stamps(void)
+{
+	int i;
+	long sum = 0;
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_fine_stamps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_floor_swaps(void)
+{
+	int i;
+	long sum = 0;
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_floor_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_ctime_swaps(void)
+{
+	int i;
+	long sum = 0;
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
+
 long get_nr_dirty_inodes(void)
 {
 	/* not actually dirty inodes, but a wild approximation */
@@ -2655,6 +2697,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 
 			/* Get a fine-grained time */
 			fine = ktime_get();
+			this_cpu_inc(mg_fine_stamps);
 
 			/*
 			 * If the cmpxchg works, we take the new floor value. If
@@ -2663,11 +2706,14 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			 * as good, so keep it.
 			 */
 			old = floor;
-			if (!atomic64_try_cmpxchg(&ctime_floor, &old, fine))
+			if (atomic64_try_cmpxchg(&ctime_floor, &old, fine))
+				this_cpu_inc(mg_floor_swaps);
+			else
 				fine = old;
 			now = ktime_mono_to_real(fine);
 		}
 	}
+	this_cpu_inc(mg_ctime_updates);
 	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
 	cur = cns;
 
@@ -2682,6 +2728,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now_ts.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
+		this_cpu_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
@@ -2751,3 +2798,24 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	long ctime_updates = get_mg_ctime_updates();
+	long ctime_swaps = get_mg_ctime_swaps();
+	long fine_stamps = get_mg_fine_stamps();
+	long floor_swaps = get_mg_floor_swaps();
+
+	seq_printf(s, "%lu %lu %lu %lu\n",
+		   ctime_updates, ctime_swaps, fine_stamps, floor_swaps);
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

-- 
2.45.2


