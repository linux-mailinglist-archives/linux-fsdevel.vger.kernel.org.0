Return-Path: <linux-fsdevel+bounces-23229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64183928CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B82887DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584B16F8F4;
	Fri,  5 Jul 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnLONj/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF116F0ED;
	Fri,  5 Jul 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198982; cv=none; b=TPjWui6nc+TIXPzyap/uSybxY6dy+ZMK+IUMysV0F4r8fQkgNDS4j6YkCthhDJ3eGW1nJY8xp9PMN+WjitkqIlM0HVRjJBeA71jwhWyHDGr7FhQz36kf/qV9xIjX8kMTP/b70KE7L4LekQ3GTPSJC6YcU3+CVso2EVswkjLiabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198982; c=relaxed/simple;
	bh=GhiNb5Rp3y6E5eQ0/354yg7YEonNuQ8RCB0kW9t0l7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKLuMx/qdgozZbKQvIOyDveaetV+7cpNPG+rfq1lfFHWtGy1UTGSEAceStPT4mRgYEDNhdHrnnhE1ZySNbqW/umQmtuPgtmaFFDrI6AZ6zSoaBg8GphKfOiDhYu8oj7GurrUDJ1reJ8d5+3eT39rD2xJWmu838LkrlvQoUCWqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnLONj/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E9C4AF11;
	Fri,  5 Jul 2024 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198982;
	bh=GhiNb5Rp3y6E5eQ0/354yg7YEonNuQ8RCB0kW9t0l7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZnLONj/hu2KVW0C2XHKr7k9afRYizo1wBh8VyFbv6ftScL2Ormo4a9UKtrbGiSeSS
	 PoI5PQCaHpTuoSTrDKP5he5ihIvvtoFAc6ilt5eyzV9glRuYhhm9ZktAIBuT0+khtr
	 EFAl1SBZMinhW29ivH/MfynIvKVdLi/yjFVsB7EeMfYad3z6dEySQmSjERoKHJ06mX
	 Im/Nl9fHCmlVprWKnFBsMw8ud2CgBY0PE7GNyApxhcUAq24Z1kjKlZH8g54uA4uTFZ
	 BOzyalGDm7A03saSSO8tfje5/L5r9TNPf6k5dD4Fi1J9p38DofQYMWzckC+XTTT7sx
	 y2VHIeElXje6w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Jul 2024 13:02:36 -0400
Subject: [PATCH v3 2/9] fs: tracepoints around multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-mgtime-v3-2-85b2daa9b335@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GhiNb5Rp3y6E5eQ0/354yg7YEonNuQ8RCB0kW9t0l7g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc8sugM77UpnbOVavEn9ip1g17NATieHZMGA
 YUffdzTePCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognPAAKCRAADmhBGVaC
 FZm9EACreEaIUiF7eQm7h3tdABL+r8H0QLz2l0niCCIEOV82RNNSH1PPunPbnZXlursqjT/Df7h
 Tj+NsqmueLXMQRE05FUgwYrlAoZbyVa+E/AwsiV/H4KZkYeEZklqMymNm8FJmLWCxbegb+bZC+9
 bJxQxz8h+guQsrUKeq314xnP/2y/GvUkKkaG8ZyjK+i3gW3/uz4IqBVANMriISFjd6V4ZF12dcc
 BpOijtB8arPUZEL7FZCAxNBBTM7s8V00ttTkd/dc/UUQef/NZnDgWmvfJResQwiQ32IsDGcexPv
 3Z1gNl7/sCsjz3IeVWJjncScJlTMrCc3yI5v2kNKdcObDBN08TBqA+uUc4/CHwALxAKqgm38z3F
 tztkbOcqO2RdIwXtqgeoiiQYO9s3IMtjk5uuUzqOQcSAWtg5/iav/BNIx0j1lRCKCz5e1ye+/cV
 F5iiqULV4t8Zr4KMJPpnw3u9MhwQ6pwyLQX6+L9X6Xkj1wYx7iU01EC60QkYYz7KXAYLanO/zPk
 UOAwp7NYPm0qGrD9v82FsTZAzE0VdPtHvD71q8yeswu0cOcRIxs6KTFoAetB9Bzbp3mGeB91pqt
 3efIx93aokHK1m0vPmwjR/3cOs7smkpBvOatsmQV0C7IGarFno1qtnvTVDpz+PjYAN/84eI8iSq
 dmikcbxkhLycGBg==
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
index 844ff0750959..4ab7aee3558c 100644
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
@@ -2570,6 +2573,7 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
 {
 	inode->i_ctime_sec = ts.tv_sec;
 	inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	return ts;
 }
 EXPORT_SYMBOL(inode_set_ctime_to_ts);
@@ -2667,6 +2671,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 retry:
 	/* Try to swap the nsec value into place. */
 	cur = cmpxchg(&inode->i_ctime_nsec, cns, now_ts.tv_nsec);
+	trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
 
 	/* If swap occurred, then we're (mostly) done */
 	if (cur == cns) {
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
index 000000000000..a004e5572673
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
+		__field(u32,			gen)
+		__field(time64_t,		ctime_s)
+		__field(u32,			ctime_ns)
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
+		__field(u32,			gen)
+		__field(time64_t,		ctime_s)
+		__field(time64_t,		mtime_s)
+		__field(u32,			ctime_ns)
+		__field(u32,			mtime_ns)
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


