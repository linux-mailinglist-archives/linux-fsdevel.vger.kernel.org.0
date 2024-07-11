Return-Path: <linux-fsdevel+bounces-23562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4392E597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC65B2565A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CD16C86A;
	Thu, 11 Jul 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLLmbufx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50F16C844;
	Thu, 11 Jul 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696111; cv=none; b=AUwD7wHGz/Dlu+HpRnrf8smLuytUWban6zlHYIhF82WMhyJLoYj9VeVZpNI/ZmX2GGlD9yEzaWPCGzXpuV1V6CozPq1vZNd7gJnye8DywQuHiiCaRGGP+Qfhb1jCpL2YbBlBKjpprFZajkl10Uvcf2UIh3lWfwV+YVE336yd0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696111; c=relaxed/simple;
	bh=rFzpgz1HqOKOCLh7b0SiDnaZS+NN3RBwFhHtuP1qUx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxGOC2mJHGkStA/01bvAuXZyx97tsPJTlM+ZB+M4NuN0Dd1FKsrygM2Ly1cUVRpaN0PBIKZiW+WW/tLgjoRmd2wckT2wbFgU3/1oPP4fC2+JrbzX9pFCjYuWUHHLrvbRTgIjT1thnLbtpMYgEIbJjSRDiy8AtgC1SI73j7VPuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLLmbufx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D80C4AF07;
	Thu, 11 Jul 2024 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696111;
	bh=rFzpgz1HqOKOCLh7b0SiDnaZS+NN3RBwFhHtuP1qUx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLLmbufxrMwqRIxsj3EShlbrXkeTe6QolAUV6OjeFmXNDxMrS8FgaZD5fet1zUGYK
	 EuTAGivoIefR/QittNO1F0NVIxe/dS51KBHibbHueFnUadb5ve6vJiRuNL2BMH5unO
	 bLpDY+VzZFC8jCXRma6W6JQ8FpSb3gi5uf6XgsV7RdM829lo6SghJDd4296X49b5Gp
	 LRQ2TDjlvJBkDsNpa9lfKHTLunLNPiPQi9eaelK17ZwAOtk9XL3AgFLnOraT72P6Z8
	 eL1ItkUDt2fNUTMY8+d2jrdYOaOqk9huYtOczCijmsagZL4hsS518H2PdT4GMoXDYL
	 GB+1wxSKonsRA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:06 -0400
Subject: [PATCH v5 2/9] fs: tracepoints around multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-2-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
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
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rFzpgz1HqOKOCLh7b0SiDnaZS+NN3RBwFhHtuP1qUx4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70kIZqRBAr9twF69KZlGMkMn1TAN28mNNhTf
 ngIzrb7jvWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JAAKCRAADmhBGVaC
 FX5SD/9yMgo83hVnTouqwh7Wudzs0Jud5XixMFsw35LiO08WfJQztDhsi7MJ6lxuIejoTHfuqus
 zAkkVjU1NHU1aPGZM1LaW8NY+PM5Vm0rg1H3Tp8LWaxM4u/kapfjM0f6xep+yI75SHRBm2T00Yu
 I0nrE8Ymxm8IwMju/5dPeqZG4gWibKcorgyLgv4TAmwfmidRhjYRIALqhKMAN+Zc2OCBLG48VMS
 foedmx1f1jk/Kv5n9NDlIFT6BNGhZrGahDsqXM5UaTVTksmsnXUL/o/neOWINHggU6rvsjS72SL
 ygap7ep9ZUCBW7Lh8t3Zm/htJpqnwBw6c7NvDCjFa4JBYo4v+6Jqbxkgy1qO/A7rCLhmnfQE2sv
 /SnXaHKUznyFIl0sOa4xvOln1B14jAlfpxmcUE/e3NWkb6Bzb+TxMujcTXnuVFUrepr/WsCnsU7
 gzVw9Q/HcugitbGMkQgmeWtGtGfYHKUmf+LPetEcK8lPO95Gq5Bk5KRgVfoPTN5hX9vX8vVq36J
 TFbun/sDhI9A7eWtnr7ZkYbo9D71S6Iq+FQGQf3WeWlWqx77ThDn/39obkMI2vV/2/95kFnM+hw
 G1nCZSOkBoc/K5bQqsbxktIJueJou5XmijV4ZvXD0O4dC9kciGPM5YYI3NrMs3YdqjZwhI9KyRG
 9mD08b4tXRCD0fg==
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
index 2b5889ff7b36..81b45e0a95a6 100644
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


