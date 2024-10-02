Return-Path: <linux-fsdevel+bounces-30793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DB98E51D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893561C229B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908C21F421;
	Wed,  2 Oct 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzCXJ6wf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D62178ED;
	Wed,  2 Oct 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904471; cv=none; b=vDK7ptKrJkEvgp+zGvklJxdztqbnk4V6NG4hAX2GF/Eq0VKlTCBQ7GRJV6GRyswk+pXYs8G5E92ifNg5Q2UymXnqd/7WcIDwvvqFmB/Q4Zw1xebA8UPiDPvyCYH4IJKmoOEaA4BgHfWtlbamIe38Y76Z5LSsOQ68nAOjW2SB+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904471; c=relaxed/simple;
	bh=Z8ARvNSJ2qaGQw9gXXGsklzintCaz0parTyIMYimjOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTcDlVkxG5lrmLzsYS8EUfu7d5KbzExWtk6H94LWffDH7Ty1WA7L8lg4WZE1At232b6kQONQTuc5c2UKnxyQDC6BdPLT7VPVXPlWQ+N9sSUZeTHEHKERt6muX4P4SQAMlqcXNxYfcCvHu87lKAeF3KWrgflvoFu7dmIxkiiELJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzCXJ6wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17306C4CED1;
	Wed,  2 Oct 2024 21:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904470;
	bh=Z8ARvNSJ2qaGQw9gXXGsklzintCaz0parTyIMYimjOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tzCXJ6wfC5VMb2ExRKKrzQ20m0/cMA8alt1mx22BM50xuDhE0GS9gVEFsrjSveh5f
	 HFH5VS9B24S84IqvZUpSgC0C1q24ouXK3xTB7RbQfG8UaeRZcICfAK6HDjmfFkfBV7
	 3aO9o2M1mNeM3mDVEnXkN4uh72RWd1d3J5IlhvmQyO4+hhMRETQlHKR4X9G6/DFhRe
	 YSYJkbBlozjLOXMmaq1m2Gt9EFtR/FJhOO+7ql9Vva32Q75BFsiORHAqNQJqujNmqW
	 SBn90QVLpNFHTeIS+z4r+VmFCXvrhebJ9B4yq9M8D2P5LJh1lY5wtzoECPs6IH+MI2
	 QP5O6BUQzp8Rg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:22 -0400
Subject: [PATCH v10 07/12] fs: add percpu counters for significant
 multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-7-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z8ARvNSJ2qaGQw9gXXGsklzintCaz0parTyIMYimjOU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/TMaGYuw/cJFUuusrG5sD9Gz0d9qf6qw5y
 upmhOuFiF6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FRvxD/9evDrf3HGvYTuhxkxutkxIEi68sVhkiNZD69Mm7WZA2CzmHFpkbIzJUXlNfytAPvjdSGx
 Se9Non3XuQRLNglgc0lhxcfcZdu/X+u5yMiBvHkBZEf5lodGBnhBUeXjm4jg9rEign2Xcke0uen
 zmW17gVIHwMZ3pm48WdgDnI8LGujnHwyRtaKHMgoMO1zgnVvcxwJwwUnejPgDLsmruCTvs+3DcO
 Y1qi5xwXYC30GgA8xLI3gOheiXnZPH7tbEJ+CH8lRjel+ECcxNYyb4BgLgnjumPTmVu+ctbB3O/
 NyFL+R7Pi0fN4SNBqZmhwLTUJrcqb7DCkLXIHsvJwkrbW3Bqnf24X7QYDnJtEJQ9zSf7lLcSU6k
 V+ew1hvKLd2wb+drV/Ii7HSHdlUZvaWrk8oHWdjSCKLvUAmjwdajzx9wmNWqXhGfXmTr0ecFsKA
 NXFHfSfVYvzOmgE53f2k3i5mgVRZyIhHJUlyjRFJKFGzUxYaTAIh5NNmXRgDtW4ppFtQH53Hxhu
 kp4ZqjZv2oO3ibhlxc5JK1fBHr6GVEm5y/b+JdsECtsh3oy/dqkLWdOAHXM5vNLGLzaBO7Qa7Ds
 CYD7TxCxZPUyWMagc0FhPLEfyvMm79Aw6QZdmp6UVnPQO6c8VRfeyGOyuivKJVQaMeSbXMaQuV2
 JHDiBQHJy0omjwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

New percpu counters for counting various stats around multigrain
timestamp events, and a new debugfs file for displaying them when
CONFIG_DEBUG_FS is enabled:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches
- number of floor value swap events

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index f7a25c511d6b7069fa235135cf3bad0cda32815b..6d501c7308aefcbb8001d64cb46e57f1839b8a3b 100644
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
@@ -101,6 +103,70 @@ long get_nr_dirty_inodes(void)
 	return nr_dirty > 0 ? nr_dirty : 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static DEFINE_PER_CPU(long, mg_ctime_updates);
+static DEFINE_PER_CPU(long, mg_fine_stamps);
+static DEFINE_PER_CPU(long, mg_ctime_swaps);
+
+static unsigned long get_mg_ctime_updates(void)
+{
+	unsigned long sum = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		sum += data_race(per_cpu(mg_ctime_updates, i));
+	return sum;
+}
+
+static unsigned long get_mg_fine_stamps(void)
+{
+	unsigned long sum = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		sum += data_race(per_cpu(mg_fine_stamps, i));
+	return sum;
+}
+
+static unsigned long get_mg_ctime_swaps(void)
+{
+	unsigned long sum = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		sum += data_race(per_cpu(mg_ctime_swaps, i));
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
+	unsigned long floor_swaps = timekeeping_get_mg_floor_swaps();
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
@@ -2689,8 +2755,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		if (timespec64_compare(&now, &ctime) <= 0) {
 			ktime_get_real_ts64_mg(&now);
 			now = timestamp_truncate(now, inode);
+			mgtime_counter_inc(mg_fine_stamps);
 		}
 	}
+	mgtime_counter_inc(mg_ctime_updates);
 
 	/* No need to cmpxchg if it's exactly the same */
 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
@@ -2704,6 +2772,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
+		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?

-- 
2.46.2


