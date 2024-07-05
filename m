Return-Path: <linux-fsdevel+bounces-23230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C579F928CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB321F236FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386E170839;
	Fri,  5 Jul 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNNqRxxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96A16FF31;
	Fri,  5 Jul 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198985; cv=none; b=kzHcr1MzU8l7EbZ9vJ5FBS41AK4HbEhixZJjEU+RnasbVa+e0gYYrw5MERDtd9FaPDeejNxFgS/GAByeMB9WpOsFuYlKdfLjViJlDeOegnYAzZPM70vFfPmZ2yhNYg6j1eZSbjTSXv07kAAIwR1ean5Idr8049vgq9Hq20SE8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198985; c=relaxed/simple;
	bh=+1OK0xDU8G2id45dYRlr32i7detxgV/LcM9BvZ/n97g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ue45s4WcSgc3nKrN15EqM4eTrylh9AJ9ZLyrRJUfFrH/ilmnt1t5m/4LvMBDO0m5iPXvmUW/rKGfm96uinrb056NJuPulJ/5SGR5kB+PDPHnOpbiV8cU9UStq0g53DaO2o/RddD8QjhQE2uigy+tTt2CxWAKjN7UYVlV0mxBEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNNqRxxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48923C4AF50;
	Fri,  5 Jul 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198984;
	bh=+1OK0xDU8G2id45dYRlr32i7detxgV/LcM9BvZ/n97g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DNNqRxxGHO2l4hhgMZOJMofVeLsl83SaLoA4KkS5nEgKlJ0pS0A8N+2rNxaioxT7+
	 CiFK+0AmFofAfVZs+rMS9qrqHOgg0cfKitBFhCBCtIn749P6sRp1IHp9ti9A/Hhnf4
	 vn3ob6MrGjJ/X0lncPcmZyt4UeEwBXTiR06bbxI3+ZDSLvuqJ5aKzBOiAd/DqRcPvd
	 FZJYkk/KuuiLgsRwX+b7/RXis4CLt9jJYZFNODl5tGvZiwKGwmRgoXbbIKOyRV8ZrF
	 /VI6OGDuR+/+HfUPSu+3EIFe372dvyPYeFE/K9TqGAcCA0T/B2GJhWjVdg5EybMTwF
	 buKVApYBc0XUg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:37 -0400
Subject: [PATCH v3 3/9] fs: add percpu counters to count fine vs. coarse
 timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-3-85b2daa9b335@kernel.org>
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
In-Reply-To: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
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
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+1OK0xDU8G2id45dYRlr32i7detxgV/LcM9BvZ/n97g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc9NpIqArIlvQ4m695T/o+BYLlZdPbZsZCBm
 5bymx7blxGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPQAKCRAADmhBGVaC
 FbXsD/0S1Bkq6Yz6RSyvaCXFu41T9zBOdd/yMsk5WBlsV5ppRy2jxalIc7hhIAH2yAxNRTiW6AD
 Fs6Q6+/UensT2Wt3JluZVcZnHjaR4mL/Xt23H2ZuIYL3owWxb2kQkZG6EfaOi4ASqNpv1fS3V5B
 /0DQkwBfkoD+9RrlkdTJ/EY4vUOVvHN5sHVA44yTEhF8K/IT9R3HoyBTLWkwNI1qpRuZGUh8UZq
 Zb5qZxrocLXCzs9Ay7qb+WCTjP51ng3xmTY0KgcH1K81TFGNhvNraGBtwF4FGxaB6AOt6UqWxkI
 YOeDijkYylcOHaA4l7xnstdm71Ia1CPlNbQEw7hmxhpwD0DKmXUFWBNUP9Uuu4gdY0Ma6JdlIod
 pi+Vp5JXL2z2rhNNpjATuCqHocDFDEj1RFijUY2vF9cLLwgjvyEbx7DukXeFuC98jL3YaiJE1cS
 g6zsqYzFfjN/34zAJo2ooq1x5vGIW42JVCJdx9iVK3E7Mi8YhU42jKEmk2+Ci7WXqxdu4/yp0XJ
 pERG93gcMk25kcaVssOjMAHGeQr9GHwl8TkraT9olc59qhGXmfiycf9MqmfgbVLKSbecBPGNS5u
 WKpNuOESwnEZO0RKQadcRLJLenjgMmQtpb/DggW2mSevrnANhab5pDD9tB0/C0qlqvmlhfdWpbJ
 ySj1wc4LTu71FoQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Keep a pair of percpu counters so we can track what proportion of
timestamps is fine-grained.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4ab7aee3558c..2e5610ebb205 100644
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
@@ -69,6 +71,11 @@ static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
  * converted to the realtime clock on an as-needed basis.
  */
 static __cacheline_aligned_in_smp ktime_t ctime_floor;
+
+static struct percpu_counter mg_ctime_updates;
+static struct percpu_counter mg_floor_swaps;
+static struct percpu_counter mg_ctime_swaps;
+
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2662,11 +2669,14 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			 * as good, so keep it.
 			 */
 			old = cmpxchg(&ctime_floor, floor, fine);
-			if (old != floor)
+			if (old == floor)
+				percpu_counter_inc(&mg_floor_swaps);
+			else
 				fine = old;
 			now = ktime_mono_to_real(fine);
 		}
 	}
+	percpu_counter_inc(&mg_ctime_updates);
 	now_ts = ktime_to_timespec64(now);
 retry:
 	/* Try to swap the nsec value into place. */
@@ -2676,6 +2686,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	/* If swap occurred, then we're (mostly) done */
 	if (cur == cns) {
 		inode->i_ctime_sec = now_ts.tv_sec;
+		percpu_counter_inc(&mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
@@ -2745,3 +2756,39 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	u64 ctime_updates = percpu_counter_sum(&mg_ctime_updates);
+	u64 floor_swaps = percpu_counter_sum(&mg_floor_swaps);
+	u64 ctime_swaps = percpu_counter_sum(&mg_ctime_swaps);
+
+	seq_printf(s, "%llu %llu %llu\n", ctime_updates, ctime_swaps, floor_swaps);
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
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
+	return 0;
+}
+late_initcall(mg_debugfs_init);

-- 
2.45.2


