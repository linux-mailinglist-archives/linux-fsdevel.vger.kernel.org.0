Return-Path: <linux-fsdevel+bounces-30768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E157398E2FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C6F2833D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1621BAE4;
	Wed,  2 Oct 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jakiBEt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85121B443;
	Wed,  2 Oct 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895009; cv=none; b=hEyyrlMNDYmaNvYdc4vyR/8C9fm6F2M6LwyPPJxapu1H+LJ0gEC7vfbiUd4/4An3jpxW797dT+V4z5DC9xKGDAOVKWjqwdcBLEuDscz0RwMotWcdE9NGxp70Jyhfxr+gzToBOw3N8D+rP1tZYh13/4bfZwjLvIUuk67jsBKWPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895009; c=relaxed/simple;
	bh=ybB7Jq6PT/ZNMBeOogL4z2UfVWt3aicdUam5Wxv2K1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yz5fKGUg1t3RpesXh6Zpqx5RjyaoWLWy+6248jn2pZDh1UzVQ/P4xIw5pvErXztbqab0Jq0jtzIo1NjVLrHoQHkA2G660du4PI0ScciubH2bpwnpz8tbx4eDGKHFK7MD1jKoxJ/VQ8oa3yknikHNz4lhup2dPH75a5rWAtFyKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jakiBEt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6EDC4CECD;
	Wed,  2 Oct 2024 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895009;
	bh=ybB7Jq6PT/ZNMBeOogL4z2UfVWt3aicdUam5Wxv2K1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jakiBEt2k3OKyDhgEkn9ZhNmc3gm+CSxovyXO4T9s0vMM3vnbfRaX33hpGWtWeGod
	 0w+jC14ldR+52dDugSmbDba+UaPQ2TlIytUZuco35MeImO8FZ43+OVtnIVSb3oYyr0
	 qRnTOc+mZADskjg9Nos7u59aZ8n5g8X+hT7Vto9njcHshvaHZ2j5BZH0Dsy0nNXdsK
	 InQ3dJWOAg6ld7Kt2+gtL/D9Fw2TS9P5hgwyOBBpnJ97kuXvKMykbohVnxbW3kQ6zn
	 Chul7ZArrdzfjCAqzCvN1gBoMyY9O2Q4T9cfNc1AOuhh85Ic4xkI6zbzuQ2BJxSaLx
	 e75dB3iQvoWyA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:34 -0400
Subject: [PATCH v9 06/12] fs: add percpu counters for significant
 multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-6-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ybB7Jq6PT/ZNMBeOogL4z2UfVWt3aicdUam5Wxv2K1c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXMCff1Bu3nV1C9p/EgImanbwC6KH7xo9Z8L
 WHrsJ1mIgKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzAAKCRAADmhBGVaC
 Fb4LD/9wspekghH2RFnMuwf1MnF4LUapWBw5tZWsQIODmI+2sIhcxzp5USg264EHIX6q5+yoJ/z
 8ud9S98Wj3j1G/x5W/4FeqscjDBuelE3urjjbdcNyU4FC6+EENRbn22SvQ1DIxSOy+luToAtjgA
 4mbu+gHEBNweGUkg4H6VD3M7PNrqEU8TNotbwvMMtpdHLdcsaG6YdHBgYt6WwSiwJPwlYZv6g//
 OUPNGen7nqk1dMUyrWVUmpnvaM3ALEJe+3ywkwfu6i1mCIc9JC0EfLoPoAn5+q/z+ydn4FtZj7Z
 qWp6JQSb9H3SsUyn/KUB2vRVD5yzcG/++qxzeZM7C3umzt5bkC9N69H7Yc7Vc7n8t+uHIZwt863
 kai0nolffijAAxKGY6mM8phzDIoqKyAXPoPe2pFaa6Ouf2GFMzdLy/BVb1QDf0gHPs1vlKZI/rZ
 SlLk+m/pPRYiHQNo0t5RKMv42xtaDSL6dGSePgtDc3oF3E5/jNyRzQQ/w2pZjtKkAkMHef3YP2w
 c7Qc+U9OJGF1M3aTlL2cOyRSY3m/9pkNMFuioHQ02Hy59Nxo5eZe4gC2PsapgJWjxEIsWLFZEUu
 9aDCY97TV11I8B8BJsw/sEHcwFqADXX+vRzYODKX1fqWJAQhmeWUYVWQUAxM4X8ssPWO5mzK9ij
 Mmdk4UMLqKk2slQ==
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
 fs/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index f7a25c511d6b..0223f8ec3cfb 100644
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
@@ -2689,8 +2754,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		if (timespec64_compare(&now, &ctime) <= 0) {
 			ktime_get_real_ts64_mg(&now);
 			now = timestamp_truncate(now, inode);
+			mgtime_counter_inc(mg_fine_stamps);
 		}
 	}
+	mgtime_counter_inc(mg_ctime_updates);
 
 	/* No need to cmpxchg if it's exactly the same */
 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
@@ -2704,6 +2771,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
+		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?

-- 
2.46.2


