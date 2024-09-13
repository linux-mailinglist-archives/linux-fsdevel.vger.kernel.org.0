Return-Path: <linux-fsdevel+bounces-29322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C89781BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BEE282E9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F351DFE0A;
	Fri, 13 Sep 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcrZKXLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F31DEFE5;
	Fri, 13 Sep 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235675; cv=none; b=L6pUuqZ6UBcN5lZDdmlskbUKX1acHnsVK72ebioqa3BwDwFgt/PaqJgV3if44qMFAPgrUqYcs3NJzfozQBWuyaZIbdBHtldNpeNxMBpPWxqJ0MDn32NyeHl/idjx6r8lgqEPLVFRitQylkPBRcIxf+KyGsWO51hZsR1r/xAFnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235675; c=relaxed/simple;
	bh=mswhu5zQXRl2wd+0yOTYLtr97eP2EA3GtMMWzONy8wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7WHyWIJO4WimQFHd+KCzpMc69038xdroj9u2HHSHO9c0+6LXhUH8lFUcvDZJU/sZ+9BIDNFXOroj/ZuVkujpAFN39zL9GYE9tXaIwmaedDUT1PDFkekehRIG55+0+GiovO7KI48rnMR01613Bx7GHSP0Rhsdiyh42045vkEGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcrZKXLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09398C4CEC5;
	Fri, 13 Sep 2024 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235674;
	bh=mswhu5zQXRl2wd+0yOTYLtr97eP2EA3GtMMWzONy8wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RcrZKXLg4N/m7lvW60c9Jd7o5yNaZ94nCF7FAgZfXsUkKYWJaNn6Qe/3GsjthU0UY
	 mtilMPhwu0hi+dBNqnjc22CfMT161qePMwNrcFY08moeR8O6iZyHoHuHG2KtxOg/Pz
	 bu1FrLhNG8MUPi7xnU2R2/AsOPZf5XSjQUZslaBHtwgXtwSHFXMxP8dcGHDqXlnfZO
	 2jk17BcaG7Q9Vl1Q5YMlcKAxy0vTHnrfcW9MdxYgVlJtSiqIPuRzXpwjvbkvxMyjhG
	 nInzULVRcvqSvlGspFy0EoyjghywAmFbI1S7pbtnsqH3Mg8ACL0eP4F1rfalDdEZ/J
	 zSxSMGNn+kLxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:14 -0400
Subject: [PATCH v7 05/11] fs: tracepoints around multigrain timestamp
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-5-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5892; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mswhu5zQXRl2wd+0yOTYLtr97eP2EA3GtMMWzONy8wQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQImnGZG1ZnDgABRhwGHmVqj6eZNVyQqpkfv
 dJtgBXjjC2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECAAKCRAADmhBGVaC
 FTzIEADLtm0TBV+gx6hWnjRySxnJ1KNJEpkgPVq427VHXKk3lpvAO6alhv1VxXv1lc3d4S96m8I
 Z1Io07qNpdTkazdyVw0PyBq+FvL85w3N1fhu/A4Ykgd2wpr/jZPWshC77ziwWTUFCNYH/jyHSq6
 vBmNJmn9yl0s57IILhKk7eLq5kcwmWx5Npjet/bgSUaNgvi5+fUufs87xPDJH2TmvziVOs98MtZ
 MHtu6ykOm2B2qUMc4C+eSUIKhHZu0Eo29AzGb53tbz/NwtbnO7F9Fxg77Lf1IM3BTGuxexDk6P/
 KOMw0Tjs53rqMNRpXq6mYMhkzgXHB04k3pu65ydcl6uj4HGma163fANNEidXkjxYXHUZ4+ksNtF
 +d+hOg8EjbSRFouVTAO+sv6F94+WNMDP1nXUn9P7paogkC644XpyKIA73zlAPr0WOMe1fg7u5HF
 Nctpw/NTd1LHcrc9YfH9sW8WkiPeFtEAPZEVIYMlUEc4NYIzFFqkYTpKXySJvLdPZn4A/XwGj1t
 hu+VQVfTgAJM4FHgYqEqe5j43zqFm6P4oX2mxRkqKKJFDPltx+UPFPBx0XA9ijOEHUkhYhEZ5Vl
 F0nIKxDFj/6+w8Uo/vji5S+0JaNfeHLqF3LdmdQvqmClLhsFvSGgCakfJ1HEzhqITmUNykn2IgJ
 dbpGPGZFu7e9AMA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints around various multigrain timestamp events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |   6 ++
 fs/stat.c                        |   3 +
 include/trace/events/timestamp.h | 124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 260a8a1c1096..d19f70422a5d 100644
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
@@ -2598,6 +2601,7 @@ EXPORT_SYMBOL(inode_nohighmem);
 
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec;
@@ -2683,6 +2687,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 
 	/* No need to cmpxchg if it's exactly the same */
 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec)
+		trace_ctime_xchg_skip(inode, &now);
 		goto out;
 	cur = cns;
 retry:
@@ -2690,6 +2695,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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


