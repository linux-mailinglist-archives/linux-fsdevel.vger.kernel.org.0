Return-Path: <linux-fsdevel+bounces-29384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE20979268
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03B5281A13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A181D5880;
	Sat, 14 Sep 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQYAuBes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578561D12F8;
	Sat, 14 Sep 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333656; cv=none; b=NNDHClBF6TEWPxWBmj+2MsKqghu9xhNsuI8gnlC54vZdOCeh6T9OKUZe3bkFjCrFFrLiQOfFInDSxwllKEEql4nVo4JVg8N5KJUj12LJH2gbOsrgN8adhQGgnPxput9wnHtxzxn52m5j4+YbX5BYOTyxWFfE28hzQKdddD+Glls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333656; c=relaxed/simple;
	bh=/dfE47m7K8nZA6bqMBlfXG7BPm8zSfwAyhiBp2lHZvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzPInGF12cFRvBa+4m+zMzIPIHsnnvXPF+w/w51hr89BMLg8ug5eiNIx2a3NDAzwkxYgpPrj6w7Lh2x/3pnCJNRjgoZ7YUW/Ezb4f85GTnT9+zotGAnD7w3jWQABlUi/8f53wpOWAp+XuwfEwmTMVtMfZjnql5rvdwt5RPcTyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQYAuBes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA65C4CECC;
	Sat, 14 Sep 2024 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333655;
	bh=/dfE47m7K8nZA6bqMBlfXG7BPm8zSfwAyhiBp2lHZvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VQYAuBesq56UQPycOVQYKukq5mJbQ9QK4E7WhdklLL7GlhgbMNKWmgah4QPT7IO2Z
	 AHj8MRiXTcHSGOFaEZ7iTGLMQmiKQMcCJ86KBKkyLGFKQQqXeT3otFDPkGicHlZCfo
	 6OEyw4ujRtYlCEUbUxTjonLAIYcQHDNz13Rj0JyCKMxwsP6HtherPjsTMDVla2+XXJ
	 lPRKe55XyWLGdPU+Bk6eFQOA4QiZiq4T6fmkCnH4HtdCn4nyCcxLQGNZaQewo01SHe
	 Vtz+KmyeYvomaHHxZSNoNYLu6sM0gV0sVx8xgQCBQZvN4z2pl/A9Ab7LxHqDiznOHt
	 VugKDAtQdg4uA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:18 -0400
Subject: [PATCH v8 05/11] fs: tracepoints around multigrain timestamp
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-5-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5947; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/dfE47m7K8nZA6bqMBlfXG7BPm8zSfwAyhiBp2lHZvM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLG5tHz6yHM6q5mnvpj1Gu54/Dx+ejg8C/Lo
 OL6Yjyr7tSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 FSzSD/9C2MjL8co2O/piD/TweFTojMnHgr0m/BmN/ofQm9TCW/y8BD7awkt7HUezkDb1iYLdyB/
 mH1mvdLoddXhzME0s6tZBboBr8tuz/5mdiAewdqeMI3/Y/f2Z7wpdfHIOKHTrOXiD16vaWUlFfd
 feaAqdR8hjYXciuRBcRJzcJwyvkISuZUJz03+s/w73WvTASj1Iev39akcCFpJg8XN5Tfyt8S8nR
 xjb2fSfXNYCBu79VlQ7RzjhRLMqMfugbbnq+9SaqYRL4OaLZS5WZVHobfdGzmhAZI8IcP9cKuaY
 cZKdb5UCzcQtBkl1vKL2Dz4S3HCP0v5jG/1r+5mzJ6RVndUnowSWfi6+WIXoqtWPKSftX+/BtRt
 QxZNMb3zlh4PRtBuryOdhk1zJUJ/Q3oKglc2vERC23EJV4FN3l7CFYsQ6xYSvFNqcAIJ8PBBRAJ
 0zT2vceH51lrHWOfc/H3fWN48m14JtgQfiWogDrV+Bww7I/k7hfjhRMhoBoCssKOH6E+XkTZXIk
 seUqqYcXooLcs7NaQdxeis5R2B75CBMNIDLJphZy1Ejjw3gD8OJ2Alj8pt5tXONZfYHcIrFqdog
 UTFuATPPICaN0K1m0yUB4WQzG4e9XQBNd4jbaBDSGxH861ChDaqx4Bi+8sNDxWYxWj3lYqvy5a/
 icz9mM/v5aV35AA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints around various multigrain timestamp events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |   9 ++-
 fs/stat.c                        |   3 +
 include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 614d0402e9ad..d7da9d06921f 100644
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
@@ -2687,14 +2691,17 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
index a449626fd460..9eb6d9b2d010 100644
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
2.46.0


