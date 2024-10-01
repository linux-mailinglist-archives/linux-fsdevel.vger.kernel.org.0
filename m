Return-Path: <linux-fsdevel+bounces-30480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816FD98BA55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D205AB23074
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8D1C2DA8;
	Tue,  1 Oct 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJYReTzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69381C2426;
	Tue,  1 Oct 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780364; cv=none; b=LOX1t4BA/ATlax43633cl00uNmXwr+wrRv7qWxFkUWFMMXPrAJACVgsrUbCYN+xIARHXr9xfklI9KsHH9jSl5weQrRLeiIqNKpDfTuqA/5YT6ZaTMshiPZqgtX1ivKwb1nIt4nnrCefwyIjouKyl1fZXoROU/d3FWbrfffyJ7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780364; c=relaxed/simple;
	bh=izJl02glxmmNWffqD/IPDGQCuMtAoj3PYaIpg9PyC+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwKVmB7hY9Glskw4BV/ymcxpwIOP2PODLD5cdmoi5zISbLHFrsdLd8Wna8GPF3wLzKeFRmE+4fTEHh+ZU1N4KXC608dHooHLtphc5BU0/KIUNPguwXJzytZihtn4R6xGdRQ9utR5WMO1S2csVUF5AEsvDvebydZnvSLl+zWTYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJYReTzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3DC4CED5;
	Tue,  1 Oct 2024 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780364;
	bh=izJl02glxmmNWffqD/IPDGQCuMtAoj3PYaIpg9PyC+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJYReTzjCU5juqIQtdAtIbD6Cg8WsgMtVfkxad1wpDaXt0C/azxShGQz0aEdLwS+i
	 NMBJSD5AMwqRC9jAD+agmdvxZbhb1deO6PZ20MXZuTvm5IN2yZOhqr5TYaydIZtyzy
	 xoWFhDolE7EBRb9u82huyjjPzS//NxjCBPgB0yyus0QgUHAP06Y8Wv+UmwMAz13+EK
	 wRZzJDLC3n0/pimokV7Gr3o2unPk5KJgF3sUwNY2CljlHaTslpI+nqcpCkVxr0NBUj
	 9Tu5xv20Nz3Ux9zeEAaX7IwNb02A5DF0jW/Zxim6vaMiiu8f3Ye7VsX2FYMRggkIvE
	 d7X3TQycX4uFQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:58:59 -0400
Subject: [PATCH v8 05/12] fs: tracepoints around multigrain timestamp
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-5-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6077; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=izJl02glxmmNWffqD/IPDGQCuMtAoj3PYaIpg9PyC+M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X696gqADrOhEqB6pujGiTNndsyHf/izuC/1
 R463+eBHFWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+gAKCRAADmhBGVaC
 FbboEACUj+9F3EVD5uJtrX2uK5uY53172VIJT2UCmgEOe9ZlQA7D6if6CWZVPpy84ZAFu0wKvCU
 nUfGe+A6pYC7FsWSWtboTu4uITOQh80rU3WCcsO2wvzjoi0r+sasAbUqKCSQQ03TKI7P864nU6w
 s02Q5/aUyzz8G+ClLfJ6+oaoxzxdlqxVt26SF6t/cwBvqv21aB6lPekW0yU+0G9fQzugdYDs9tR
 4IaBJVJIPDUGj9CNQLAfmB+R7ZqQCaX0ial0zvkB5j5DThz5OCKhv2BoHsySCKOSxAK5ljs4V29
 FSLRdvZe7fmhn+pVlw4zCeGrK90NjBPLY05C1taeQGjXm1KMTYxIRVTYppCGOrbxRlV8HAqCfNA
 h/f7Kj5Ig3A+TIavynuTUw+cLKXxTS8/KcpbfSa228J9uujdacgBgN5tNHjWJLqbGd1CnxF3EE1
 G0/Tc41yTgoQPk1eZbgcEefCxgG1wSzpWVixfbgYFnVHQnxMDxmE6ME/pzql569Onv5uvSoXL7v
 ii0xb1hqVt3AWZPlFcv2dLDzXp6DCkga+++6O+tiwAR3lOEdBe7ZHyKwGNqa9+ttRmDzG/Y8BPr
 TJ1hwYpwwsQrPBeldGN5ImNSqSxV05EHm+neGOG5J+7diqsxz74eScJtZxkQ0PkpS6XSSZrquPH
 CgidwNso0HxHmJA==
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
index 7a324d999816..1a7eff2a40e2 100644
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
@@ -2639,6 +2642,7 @@ EXPORT_SYMBOL(inode_nohighmem);
 
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec;
@@ -2723,14 +2727,17 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
index 381926fb405f..72914b6624a5 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -23,6 +23,8 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
+#include <trace/events/timestamp.h>
+
 #include "internal.h"
 #include "mount.h"
 
@@ -52,6 +54,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
 		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
 	stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
+	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
 }
 EXPORT_SYMBOL(fill_mg_cmtime);
 
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
new file mode 100644
index 000000000000..c9e5ec930054
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


