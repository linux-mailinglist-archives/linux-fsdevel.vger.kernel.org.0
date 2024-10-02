Return-Path: <linux-fsdevel+bounces-30792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055298E516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1035A283361
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466B21D2CA;
	Wed,  2 Oct 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiQb+Vas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741C21D2AC;
	Wed,  2 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904468; cv=none; b=ecavxAeNWjJxBh9fJUlTkRmp1+oM0JBEoSjKzsfpLF+NGNfrtbit1Td4f00/TGYaaYibAJr4Xq8XAyAuercYbAThunR+pg1A0DruKyyQdoFJI4wbHgHU+9ZXQUvb8dxMjrtAYDgYatOQWaGXyz3iWDetd6G4Md1bXlTZKVDGdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904468; c=relaxed/simple;
	bh=MRGGG8rqdJzdD5KgI4WfyNMzLguXPYXob8v5j7W1QaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9v0hJxXHa+29X7cd8WUVSJH8v67mfZZLCJSS2ml/MURxve7zRr7wLldU/KVskbMuTQJsK/XJ21RDhGrWA6JIwzpNHPk8TdzDacnrO4YQ4ZEa3JcB5SFNCCLMgtdmcXJtXiFjY1zehMHduN7yHi3xb3x62i6N0omCS5wl0JHW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiQb+Vas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53227C4CED6;
	Wed,  2 Oct 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904467;
	bh=MRGGG8rqdJzdD5KgI4WfyNMzLguXPYXob8v5j7W1QaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RiQb+VasJhrhbm+efzGbpIcwLxszW5XKADxsVvHvZ4PtU9omVM1uKPRYjdDFTLrxU
	 spC6qoc3Jx5R2FiTqiPPDvCGVFpDpJoGjjicm25vd2LLcfcz9jjV/RR/bjlnI1V4EY
	 ad67YYwlvOrSCQNhgnodXxdPfs01FPltkNs3R5FmGOCg4ttPkExz83Q71CZ2EKDmER
	 3vEcrINS5svEVCEpFlZZQrG/rtN2NbUWpkxh9VaYk5MStmuCmVXUCBhdZXbYBg8jBs
	 7qYe48hdyaiE4eaWZsSg0Wr6BU5TlKcgxiilkkzod6H78fW5qEKHCFkhLxB0g4czZQ
	 211YHMvElLRgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:21 -0400
Subject: [PATCH v10 06/12] fs: tracepoints around multigrain timestamp
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-6-d1c4717f5284@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6245; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MRGGG8rqdJzdD5KgI4WfyNMzLguXPYXob8v5j7W1QaM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/rrV42gSWRnMywus+4vWn2erTXDHpugNyH
 p5Jt5mx0kCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FfHLD/0Y+Ozd45QWOEXlGcizIJuYoklt/IclS6YYuOynkLK657rXW0pb+HYJPpKskii5RnL8UEO
 zVviDGgIKrEHkavVfZbP1PYA1Z+VQJxoYVWmMckxEU4D/ttgg9q8HMGi6CTbx8HZxejV2aRidO5
 Q2DxmAfAokB2UKHZIppBcbZszz1P7Kl0yfRlUKeJuklq9GVYBs1Pim1fZgiXRyYL6b+tP/7ps5C
 ymjA4tKdOekiGiOceknMPhjV8Y9IqU+PmHDLm2KiN5LIetf6bnNXJkL52Q29NJ+eyMJwio0Ff1f
 Or/F8FVlAfl8FiM6wEM6D4BzMWoUdKQ4jZhMYgFdEkKNPohN1ckS5sGybaKegOQKCmz935a0+QB
 BPqzCoiaaZpYYAktHl5D4RtVolKmJtLGY2UYlkv0XkOyEjWDXeFzLnjTufDI846IzHPWWVDRGJ8
 9EaICfw8ssZEJ1BjJ3qNb5yFKxCidh7aW86QQORcgAC80gN2aI+HZXv9ijN3+4SCsr/suRndazc
 kUa9Wh92buOEq+U0+WoJQBKJ5dKFUJram9X+6fl//fjCaCVByxDXkahkzeJk+k/CKqLT5eUqaWc
 XKmwVPbj0nWdMCahwZT6k0Suf4uVnDOSP/+bA9QNEaZGS34TkJrUBsyzRUcRoKoQpfFn6QVLS4H
 6h9x5TdrOvNT+vg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints around various multigrain timestamp events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |   9 ++-
 fs/stat.c                        |   3 +
 include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7d1ede60e549683502911f3bb3a3a079768e449b..f7a25c511d6b7069fa235135cf3bad0cda32815b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,9 @@
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
 #include <trace/events/writeback.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/timestamp.h>
+
 #include "internal.h"
 
 /*
@@ -2603,6 +2606,7 @@ EXPORT_SYMBOL(inode_nohighmem);
 
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec;
@@ -2689,14 +2693,17 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	}
 
 	/* No need to cmpxchg if it's exactly the same */
-	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec)
+	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
+		trace_ctime_xchg_skip(inode, &now);
 		goto out;
+	}
 	cur = cns;
 retry:
 	/* Try to swap the nsec value into place. */
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
+		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
diff --git a/fs/stat.c b/fs/stat.c
index dd480bf51a2a764e5eb1d0a213c5ec8b640db911..6eb6c39d003755f9e602996ed93dcbd863847820 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -23,6 +23,8 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
+#include <trace/events/timestamp.h>
+
 #include "internal.h"
 #include "mount.h"
 
@@ -56,6 +58,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
 		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
 	stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
+	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
 }
 EXPORT_SYMBOL(fill_mg_cmtime);
 
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
new file mode 100644
index 0000000000000000000000000000000000000000..c9e5ec930054887a6a7bae8e487611b5ded33d71
--- /dev/null
+++ b/include/trace/events/timestamp.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timestamp
+
+#if !defined(_TRACE_TIMESTAMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMESTAMP_H
+
+#include <linux/tracepoint.h>
+#include <linux/fs.h>
+
+#define CTIME_QUERIED_FLAGS \
+	{ I_CTIME_QUERIED, "Q" }
+
+DECLARE_EVENT_CLASS(ctime,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *ctime),
+
+	TP_ARGS(inode, ctime),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(time64_t,	ctime_s)
+		__field(u32,		ctime_ns)
+		__field(u32,		gen)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->gen		= inode->i_generation;
+		__entry->ctime_s	= ctime->tv_sec;
+		__entry->ctime_ns	= ctime->tv_nsec;
+	),
+
+	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
+		__entry->ctime_s, __entry->ctime_ns
+	)
+);
+
+DEFINE_EVENT(ctime, inode_set_ctime_to_ts,
+		TP_PROTO(struct inode *inode,
+			 struct timespec64 *ctime),
+		TP_ARGS(inode, ctime));
+
+DEFINE_EVENT(ctime, ctime_xchg_skip,
+		TP_PROTO(struct inode *inode,
+			 struct timespec64 *ctime),
+		TP_ARGS(inode, ctime));
+
+TRACE_EVENT(ctime_ns_xchg,
+	TP_PROTO(struct inode *inode,
+		 u32 old,
+		 u32 new,
+		 u32 cur),
+
+	TP_ARGS(inode, old, new, cur),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(u32,		gen)
+		__field(u32,		old)
+		__field(u32,		new)
+		__field(u32,		cur)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->gen		= inode->i_generation;
+		__entry->old		= old;
+		__entry->new		= new;
+		__entry->cur		= cur;
+	),
+
+	TP_printk("ino=%d:%d:%ld:%u old=%u:%s new=%u cur=%u:%s",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
+		__entry->old & ~I_CTIME_QUERIED,
+		__print_flags(__entry->old & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS),
+		__entry->new,
+		__entry->cur & ~I_CTIME_QUERIED,
+		__print_flags(__entry->cur & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS)
+	)
+);
+
+TRACE_EVENT(fill_mg_cmtime,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *ctime,
+		 struct timespec64 *mtime),
+
+	TP_ARGS(inode, ctime, mtime),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(time64_t,	ctime_s)
+		__field(time64_t,	mtime_s)
+		__field(u32,		ctime_ns)
+		__field(u32,		mtime_ns)
+		__field(u32,		gen)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->gen		= inode->i_generation;
+		__entry->ctime_s	= ctime->tv_sec;
+		__entry->mtime_s	= mtime->tv_sec;
+		__entry->ctime_ns	= ctime->tv_nsec;
+		__entry->mtime_ns	= mtime->tv_nsec;
+	),
+
+	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u mtime=%lld.%u",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
+		__entry->ctime_s, __entry->ctime_ns,
+		__entry->mtime_s, __entry->mtime_ns
+	)
+);
+#endif /* _TRACE_TIMESTAMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.46.2


