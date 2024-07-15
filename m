Return-Path: <linux-fsdevel+bounces-23690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293179314B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81A21F23695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075018E772;
	Mon, 15 Jul 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur9LdRyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72318C330;
	Mon, 15 Jul 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047757; cv=none; b=INEQ0im4puKQPGAJBJOnxsvlpuhvKEMMncx+wBnRkOp35HFfCZCWGP+HOzYMxOqdsSNl7Q/cj4oEkqxK7hBVhH996gA+tLo5aEdKOcR6FEDp8C/XErUJT0wjXRUWraWFqlf9lt41ctiZPJDS90IpCu+29CN1Eej8qGRTCcX15hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047757; c=relaxed/simple;
	bh=JF/UPK3ugqCOBOaDB3oltr4AnbnZLO/O9/Xo7V+dF+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uf81bVkaY97kJ+bCbqG2pdFvmT2T0m2Y6bN+scQK8CFYeO12zFifPXzPluofCJBpUfQeq/X3ttyHO9+0r3Vtn5C5RwsEcMPY0bQHQm2HIRZnTeGL1WnBvOywIuez3EyjSq3er7FZDQEJD2/+1H0koyumRrnXEIQhJetPJqlPyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur9LdRyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A6C4AF12;
	Mon, 15 Jul 2024 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047756;
	bh=JF/UPK3ugqCOBOaDB3oltr4AnbnZLO/O9/Xo7V+dF+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ur9LdRyAvrQagDyjIWlEueNxPt9nz4/83/B6DD+X9AKi2i4/a5sMfqUVlz8RbBvcE
	 Px7Gaj/Lm7MtFRRybgKxCT/6t6an+0CinXqzM5r/4Ddt/uWMtaXBjx19DXKcLlBPLZ
	 Y2y1mYNlM6rQHHBhxXvFe527889tYnjdqlLtjyr1yUOS2DxQyXXi2+uD6DHbXOhX2b
	 E1Ga4zCQj4fJNeyw/q+Zos3j3cyle2JETp8CEVD39WIJUhBxNHi+wy4R9D5GQyQC+O
	 O4jzYdl07IPgm0A0EyuPEG2KANH9JzsGAuoOq9gQukqfxLMRVWW4uUrIcAHL1bjAlY
	 KQC636ATizJXg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:53 -0400
Subject: [PATCH v6 2/9] fs: tracepoints around multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-2-48e5d34bd2ba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5888; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JF/UPK3ugqCOBOaDB3oltr4AnbnZLO/O9/Xo7V+dF+g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrCSgUIIsCgXmn1E3IInVm5DrnlaLkzFW1Jw
 Q+FZkqs1YuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawgAKCRAADmhBGVaC
 FeayD/4qqJuWDW34Qj9rLUQz1zDsDJLwxRBQatCJZuZzyADr4yvwLceGX6w1+FUvXEa67majQhJ
 e7oBwc+4hdgMiY3uolxhzopsEolZMhJ0iQqVJknfBn9+457EHEsVYbUv3lbZt2FUI0+z3F1CjZe
 tlBSFJ5YtE6qYdGbVLfp7t+6h9WeNhRCndTXKSM+Rhq62e+ECQyEVvkFCGD7Z2yWnn7X0TFZIFo
 F6t/iZwxyG4d7FNQFSXRBnHBX94VW4L5SdosG9r4N4o8OCTKSH0cEwAv/RRj6Bl6AsRTAoC486f
 5JooGyoWoUxLj4BTmVYknjinuTvdD8CNaua5BvXftYb6NZfx8wM4vjlxsosIH2ag4AvP4B+loSY
 fBhiNsjn6oFZ9R/y3yiLqXD4hKHs0B6TSYjPZUKOnF+IOIdt7wnaJJPoUpJ5XcR7cvAsvg35Q5G
 q4YzxTeFXs4B37EfoEHKXJNRP53TC7Exzv1Gkg3z9dV5iqep1Yr6tCCcXYz4qRmYPCQegvTkSDe
 rrQB5mVJ/qWQ/uhYcF+1tDw6JhZcVIDgS9Ux4kYW2sYVA0znjt4RwDhTvZB7HOhaDDU/+u232Sy
 5UDpuVg1mOk5Sp9DpgFxvvqL+Ft0vVIgua2aXNn8v5w7PfPa476R4sLaUcfUXlMt0QCw/jFVIOV
 D1//ICt1f739Nfg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints around various multigrain timestamp events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |   9 ++-
 fs/stat.c                        |   3 +
 include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 417acbeabef3..869994285e87 100644
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
@@ -2569,6 +2572,7 @@ EXPORT_SYMBOL(inode_nohighmem);
 
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec;
@@ -2668,13 +2672,16 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	cur = cns;
 
 	/* No need to cmpxchg if it's exactly the same */
-	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec)
+	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec) {
+		trace_ctime_xchg_skip(inode, &now_ts);
 		goto out;
+	}
 retry:
 	/* Try to swap the nsec value into place. */
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now_ts.tv_sec;
+		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
diff --git a/fs/stat.c b/fs/stat.c
index df7fdd3afed9..552dfd67688b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -23,6 +23,8 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
+#include <trace/events/timestamp.h>
+
 #include "internal.h"
 #include "mount.h"
 
@@ -49,6 +51,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 	stat->mtime = inode_get_mtime(inode);
 	stat->ctime.tv_sec = inode->i_ctime_sec;
 	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
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
2.45.2


