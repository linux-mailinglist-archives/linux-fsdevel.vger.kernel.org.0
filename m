Return-Path: <linux-fsdevel+bounces-22858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553F91DC87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE27B25BDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE115217F;
	Mon,  1 Jul 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omKMtLWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA61509AC;
	Mon,  1 Jul 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829635; cv=none; b=L9WZ2QN+NZotLLRJgtVKFRS8vyWkOeYXm4FrdAcuhtySvYY2PvCdUfJmNcRJY8DcLtU6cbAUSAHlkU9DDBIpC8zoi/4EYhkOg4KpExiCBY+l1FLmBnPBQkULB9GhvtHg9/stGCNF74FlShKmMWuyEDcK0obKkSgmZP0+7FveC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829635; c=relaxed/simple;
	bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glxfI0YWwDY+RKeJMXu43cXVzgT60gTkKT3n00MRBSsulRSWs/OOlBhGdK8eUKRT8ruEmB6FDpElJ7a2J/vJIcbYGd4YgpCKgBSXQ89MEjEO+/fEUlcv7NHNBiQ84+Y+FweILWHQBqB+xlGcY0mR9LFhOoDA+fAokCel4qmQt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omKMtLWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F0C4AF0A;
	Mon,  1 Jul 2024 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829635;
	bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=omKMtLWAsyL0zAsAPOLHmO/PULOiMrdAphGS7XL4KzP6SdkInnFOvrWPg8iNVA8SE
	 O2vLzg+9P8se6O6us7xNZvZOiRvyVe6XH4EsLttxrJ562NbbpORn5fYa5Z9FbZgevX
	 qXDhnyoFG89QoRXmS11fV84bk9fbobyzJUF+UVVU/ysy6MiPwUfK/3YkOXCVEJB8Oa
	 xdVQkFCz2rr2x3UStE4oxMyzA3dYKPEOgg/ltdVkaUwQwIxEKUd4ieRKnYOv7+wR8R
	 uy7OS93B3eNia1jKGcgtDsC5LDu5X5FmWvjRHZhf2FEqX5SgMdVrl6WbKOk1ilNiRs
	 SXGE/9Yod0TbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:39 -0400
Subject: [PATCH v2 03/11] fs: tracepoints for inode_needs_update_time and
 inode_set_ctime_to_ts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-3-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
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
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR4fMvBS8msf2r3qrJVeLrJLPiafhklB5Y2M
 2ff/OZrOoWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeAAKCRAADmhBGVaC
 FewxD/wO4A1OP0QwpPBNzHvQYzQ3QKtbRRz9097tMgFKRzvc9W+rJQXTGyU01Q0frLqh5f3Ju1N
 +ft2f0BamL4qEFTpRkkkRX61dzmSeFYDJVCau/cNUdcnNYjx+3dm6SlBg6Y3P+mxxf7KkU32/jQ
 vrmQ/mlWFeK9qxwwHyUOISjol5fs7IXrNbR7PyHfQpj4GfcRd//9tSvfFlB/SecQpUbcUIkZQjW
 +BSOC9RSuiFVYGiWawlq9Q+O0TchkJwvXS7wj/X5hfI6C+BNnyC5c38G4u0/QIUrdoze6JU20hO
 UNxwHmOFBHjp+PL73EE3S3GU/+fleMJDlCOTky+50FNHnuOM+lrTZySsYH+DZOc2o7ke9EiFlOf
 +KL/WVDc3Cia5wKy4lh/xod+mibhHsNcGbIhcv22izrEGGnnOx+4QIFfrI2dnmAyMmHAPSgsZ1d
 j+0H5m0vv1lcBEIFiSVlGwyytRufnhAQJX4J9RNWkhsHBidzAPogfAZwEY4ef5se6337mLqSF35
 pZnYoZV+1blWEStRGHsh383sypvnp67jYhT64JXRqGWZheHFMcyRtK5A7nUzOtAmHAOM/0gBTID
 K9nklzlgH+VYxyx/euDlDXvIUUbv1bITh/pJ1W7Dg+QlAY78fF/LAEknKlq/ct9/gsNQsdWUhFY
 xOJIKdmKn59P8HQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new tracepoint for when we're testing whether the timestamps need
updating, and around the update itself.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |  4 +++
 include/trace/events/timestamp.h | 76 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7b0a73ed499d..5d2b0dfe48c3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,8 @@
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
 #include <trace/events/writeback.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/timestamp.h>
 #include "internal.h"
 
 /*
@@ -2096,6 +2098,7 @@ static int inode_needs_update_time(struct inode *inode)
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
 		sync_it |= S_VERSION;
 
+	trace_inode_needs_update_time(inode, &now, &ts, sync_it);
 	return sync_it;
 }
 
@@ -2522,6 +2525,7 @@ EXPORT_SYMBOL(inode_get_ctime);
 struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
 {
 	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
+	trace_inode_set_ctime_to_ts(inode, &ts);
 	return ts;
 }
 EXPORT_SYMBOL(inode_set_ctime_to_ts);
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
new file mode 100644
index 000000000000..35ff875d3800
--- /dev/null
+++ b/include/trace/events/timestamp.h
@@ -0,0 +1,76 @@
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
+TRACE_EVENT(inode_needs_update_time,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *now,
+		 struct timespec64 *ctime,
+		 int sync_it),
+
+	TP_ARGS(inode, now, ctime, sync_it),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			dev)
+		__field(ino_t,			ino)
+		__field(time64_t,		now_sec)
+		__field(time64_t,		ctime_sec)
+		__field(long,			now_nsec)
+		__field(long,			ctime_nsec)
+		__field(int,			sync_it)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->sync_it	= sync_it;
+		__entry->now_sec	= now->tv_sec;
+		__entry->ctime_sec	= ctime->tv_sec;
+		__entry->now_nsec	= now->tv_nsec;
+		__entry->ctime_nsec	= ctime->tv_nsec;
+		__entry->sync_it	= sync_it;
+	),
+
+	TP_printk("ino=%d:%d:%ld sync_it=%d now=%llu.%ld ctime=%llu.%lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		__entry->sync_it,
+		__entry->now_sec, __entry->now_nsec,
+		__entry->ctime_sec, __entry->ctime_nsec
+	)
+);
+
+TRACE_EVENT(inode_set_ctime_to_ts,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *ts),
+
+	TP_ARGS(inode, ts),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			dev)
+		__field(ino_t,			ino)
+		__field(time64_t,		ts_sec)
+		__field(long,			ts_nsec)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->ts_sec		= ts->tv_sec;
+		__entry->ts_nsec	= ts->tv_nsec;
+	),
+
+	TP_printk("ino=%d:%d:%ld ts=%llu.%lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		__entry->ts_sec, __entry->ts_nsec
+	)
+);
+#endif /* _TRACE_TIMESTAMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.45.2


