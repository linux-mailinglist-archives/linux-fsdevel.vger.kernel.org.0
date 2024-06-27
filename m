Return-Path: <linux-fsdevel+bounces-22581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7960919CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AFA283B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0B2D047;
	Thu, 27 Jun 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2qBsDkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B928DCC;
	Thu, 27 Jun 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450046; cv=none; b=n3SU3VDZfVInGjqIOHiXRI1BpNSerlctOOvUkABQW9OYWNZvIuRQNX+IWGbyv6ncy6kVrjt+xGpANkl3y6B3yxWSC/K0mXTDqmZGorhfgQkGpnh8Zk7kp2UnseizOWSDjzEHOMqKGCxw5anHYsNEfuXFmjahxztYtldr9j8lr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450046; c=relaxed/simple;
	bh=alV5zibd2F0pMNbUX/mWZ+tG97f9Xo1V9J1WqjSbP8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nsd36lxg0yriAYMJc5w77AY39dbynC9k39XLEc6po0GxbRc/Z4XeG1SidKcamcKPDh9FGCIEzSoqicomu54dH4ziDqbzGuYJ8C/iLeQDlPuGPx9b6t+cqZJIMNLNPWWZg+7n4KF7d4eIt/WWj+PBDLIpvBedt57lemwy1mOyqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2qBsDkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBB2C4AF0B;
	Thu, 27 Jun 2024 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450045;
	bh=alV5zibd2F0pMNbUX/mWZ+tG97f9Xo1V9J1WqjSbP8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B2qBsDkL0dxLN9WUghKk/yCHEP7gA4zZFWEppqkoSjuXlX1Ly40r0xAI0yucOKYj2
	 HkDxytNHwn6CwxUDEusjmW+bsaESAP8HANhfrp4Hj6j9T2veupYhwNtdMLFVItDMXy
	 j2AzGP0bDuO5MEAcmbTEA8R6/zOCUPOj1CJK3xDa2DXG6IVhGxDkzhdSDwRe61LRAX
	 5Bhrp4Fg9F3xougTOgKp/XrG031v71BPC58JJcUR1kCgeVG73za33yIuZXm6I36dPO
	 7FIbSwBzm1okS9/gCa3hCBqZ0AcgJiP9QpSZYiFE/bURPowb8jz+OV5NoVTfNtlZKW
	 aqydfCIOCqxvw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:25 -0400
Subject: [PATCH 05/10] fs: add percpu counters to count fine vs. coarse
 timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-5-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
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
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=alV5zibd2F0pMNbUX/mWZ+tG97f9Xo1V9J1WqjSbP8A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvP3m8cgNO12xHkX/kvGeeOvTHePjzc/p9E
 73Z0udL2yeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 FVlYD/4q+QmTQ2BI3Y18pmSgyzhp+KsUaATjRNzT+mnMep2m7m1Gs2NuvWMCE7ogykMMDOjDMsJ
 sNvujib/blGj7gu3gYUWWOvZxnG34l4mhlVhdGs6xANPbLR5FMECfrsa5uQdJMLzuqOPgNnOhzU
 XieSHD6nsA4r4Hmqii/LDHKEwCU2HlAhtEgwdMOjVcQzKHiHoxuH03WR6yZaEzw1da20OJs5I8N
 B+gsf15KKvItUFHdBLu53BeVIVaAklaFg4DWvJm6MaxweD2QSVAjQ9Knf5dYJm4f29NcjElQ/pV
 V+hmOYJPtu3L5Dj9txMdu5fH5b4tOHT8a41rNL/eyU9PUta0GQX2uWHh7HLEZErUSiK7z4f1+tZ
 SMmcj45nVV6QYF+RMcnXcRG0aJGDxT9pNGhkkUhDmxNqdoAFbIwEGw2bbAEfpAx4lkWlHltyOE/
 C3RWGGnPKRRHCBOXnb76vJHiDsT1yG3EyzsQEVCSnKohcNYKBcYMI6a0PnpL4QfyHqq8wZi2+f9
 ZFGXq9RdXZPuIR4UwZt/YZE5SRl5MznqGcYcMVcU86xVjMkFUKKkDglI8O6xhHBbUw7CxN6GRiu
 DNbxDJGy3MTBLASlA+MkUOayWh4rJcPzch7NEoW2ex55o0g2b8Lg/qrEEVnEIGuk9Eo6/H8WmZh
 eav0qapDN1tVzpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Keep a pair of percpu counters so we can track what proportion of
timestamps is fine-grained.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 12790a26102c..18a9d1398773 100644
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
@@ -64,6 +66,11 @@ static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
 /* Don't send out a ctime lower than this (modulo backward clock jumps). */
 static __cacheline_aligned_in_smp ktime_t ctime_floor;
+
+/* Keep track of the number of fine vs. coarse timestamp fetches */
+static struct percpu_counter mg_fine_ts;
+static struct percpu_counter mg_coarse_ts;
+
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2636,6 +2643,9 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		trace_ctime_floor_update(inode, floor, now, old);
 		if (old != floor)
 			now = old;
+		percpu_counter_inc(&mg_fine_ts);
+	} else {
+		percpu_counter_inc(&mg_coarse_ts);
 	}
 retry:
 	/* Try to swap the ctime into place. */
@@ -2711,3 +2721,32 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
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


