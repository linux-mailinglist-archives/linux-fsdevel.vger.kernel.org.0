Return-Path: <linux-fsdevel+bounces-23293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDA92A63F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462C11F2112A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128814831C;
	Mon,  8 Jul 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqeurhHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3A1474A9;
	Mon,  8 Jul 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454029; cv=none; b=omATfzH405i+hPGgpSN7Fx/P3355d/BvdqSQ37Bs01rDetykyPYDbzb9JAkZiSBA0tN9yGUYBZSp7oxlFSqGO377OhGcGdZginVsfwTj4UkuxYAPYHlqLhAYFLq6dq9x+JIJTPmuMGqriXDFzN8k6ApU7WyzPKbVh25CH7iFpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454029; c=relaxed/simple;
	bh=RGBdixLVMnvZSpnnXMBVJzXQ79WBOeu5zDQit4Vflmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsC9Ud2dJKVoUYvSBzlwNbAi6Ld9Tz4WzC8MoM6aCS3C0RwfTOnoTJztGBYjKQlReo5jL62OFSy01u7bO1fDf0o5fS4AxFPI6omPwTbpwr7Tl+7e0gDGtHiCTR6m5AhHIDMh98ADg5m7vL/dY71fG3e9+7u3DwpPQMERND/ElaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqeurhHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB4C4AF0C;
	Mon,  8 Jul 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454029;
	bh=RGBdixLVMnvZSpnnXMBVJzXQ79WBOeu5zDQit4Vflmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tqeurhHnKiHcm2GAMReCaD6QM2ypo/Gf/JZXf7C+JwFyAD4IMO2Mn7ryFxbwuNTO9
	 U7mXBDlo9IExDjK+eFXmJtquMvI2Q8IHsTB1XOcRIbBRQZpDFgUDj1dBKSTS7Axgwh
	 WYOgBD7UkhQ2IBlVzaN3ML2PooKPoausb3ZczaK3GA737F/kGhyVul/2hdM1zfBeRM
	 LkAlR68snx6yW+QmIj7kmZW65+7XpJN4bDHSOA7suaoQP1shx1NnWoIztABE7hgG1c
	 t5vQW3jD+b7u53tzNpocQny56UPO4RfbgDvaHzdnF72kAM/P53s2PZE49Dd3YnKZU3
	 KQkuwg/y91bZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 08 Jul 2024 11:53:35 -0400
Subject: [PATCH v4 2/9] fs: tracepoints around multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-mgtime-v4-2-a0f3c6fb57f3@kernel.org>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
In-Reply-To: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
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
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RGBdixLVMnvZSpnnXMBVJzXQ79WBOeu5zDQit4Vflmo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAuDdpNxbcmlwD+lX7dRs+zrqonu2h14Q/J+v
 Oup+OtpHtWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLgwAKCRAADmhBGVaC
 FSEVD/9sP/3W2ybSXNwIlKJEMoJIDNa7UF6wAAPhxhIK7AGH4bfW60+p1e3IvJREC6NgxDUFFx5
 aMgG+AFMjN/h5J3/NvH+kbxgHfJciF4QiOfUGZtfPD0rMmiJhBJPLSr7c1kYC2RCuZz3pFpDbZO
 /qMOYme/u0KMqnMaZm7RyOSwfLhVlZxYX7DJl/Lmv2MuCLzqNjYim+B7K8thvoM12SdQH7U322Y
 +dYYjoLtEsJ1rqQsxPKmdk/NHK3010L2Inmkrgg33uRl5rQ4OnPTiwB1/XHB3mUnnzfiBGA9T8s
 UsekKVbV/lmVQjP08b3mpBxnaUKxBWB+H3tb8ZUDKm2+V1zJYxEXiwtsEF5lFZgiofF5FJhdwFR
 JHZbaMiXY/Mk51jYZRaerbqrot5jS/I5CUMbpy91Z/7qfjU/aL5Ud36zk6YEe7Ke+ZcQvIKr8qQ
 52tPrawcLxLZvwQ5CJlNBsVuhR0INfwSUfIWL7jlWGwff87RKUHbOsUgo1EjqAPshTOzsIhNaUf
 8XB7TaJCq0iJGWUPQHu8ndPilDUG5QqIbIhgmJ0A//UsXJlzeS6qmHYGtrfJ3PcjcnAwYEGe1bs
 KtAzvgsas7CXfNeWez8LkLC3b77EQecrzVI9HPK1CtRusGN+9L9rBfsZvXFzhgee1c2iJrYNb/+
 vGEJaQHT5jQbLCg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints around various multigrain timestamp events.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |   5 ++
 fs/stat.c                        |   3 ++
 include/trace/events/timestamp.h | 109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 10ed1d3d9b52..b2ff309a400a 100644
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
@@ -2571,6 +2574,7 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
 {
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	return ts;
 }
 EXPORT_SYMBOL(inode_set_ctime_to_ts);
@@ -2670,6 +2674,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
index 000000000000..3a603190b46c
--- /dev/null
+++ b/include/trace/events/timestamp.h
@@ -0,0 +1,109 @@
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
+TRACE_EVENT(inode_set_ctime_to_ts,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *ctime),
+
+	TP_ARGS(inode, ctime),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			dev)
+		__field(ino_t,			ino)
+		__field(time64_t,		ctime_s)
+		__field(u32,			ctime_ns)
+		__field(u32,			gen)
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
+TRACE_EVENT(ctime_ns_xchg,
+	TP_PROTO(struct inode *inode,
+		 u32 old,
+		 u32 new,
+		 u32 cur),
+
+	TP_ARGS(inode, old, new, cur),
+
+	TP_STRUCT__entry(
+		__field(dev_t,				dev)
+		__field(ino_t,				ino)
+		__field(u32,				gen)
+		__field(u32,				old)
+		__field(u32,				new)
+		__field(u32,				cur)
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
+	TP_printk("ino=%d:%d:%ld:%u old=%u:%c new=%u cur=%u:%c",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
+		__entry->old & ~I_CTIME_QUERIED, __entry->old & I_CTIME_QUERIED ? 'Q' : '-',
+		__entry->new,
+		__entry->cur & ~I_CTIME_QUERIED, __entry->cur & I_CTIME_QUERIED ? 'Q' : '-'
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
+		__field(dev_t,			dev)
+		__field(ino_t,			ino)
+		__field(time64_t,		ctime_s)
+		__field(time64_t,		mtime_s)
+		__field(u32,			ctime_ns)
+		__field(u32,			mtime_ns)
+		__field(u32,			gen)
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


