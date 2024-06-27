Return-Path: <linux-fsdevel+bounces-22579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EEE919C9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DDB283382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE11CD20;
	Thu, 27 Jun 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksKFkOIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7C1CA96;
	Thu, 27 Jun 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450042; cv=none; b=o5nWBA1FqUCiKmdl+98w/mVlY690rTr/kcfCPkCEnm1eM0g0gwXHQvS87eWodU+NRtbC9BuzTcHaolv+G1u15lRB+xltoNXIoky2O2StMIrAgRhkrma5sZRyMo+4fxCDTpSOFuLXd0h+SuclrEFXmyhcpxhupUmADjODs8SqSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450042; c=relaxed/simple;
	bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGAfe31vgdc5t9b4v4HWPYZG4CBWHZhlW6oe0DDPpIDH6E6J+Ua23japNVTF1LAQM3IroNkPzdc6IJylKMyb0apsa4U/IasLCVrNTLep8HrSy2MCTGJbVDQAEoLqTPj4Aa2yJOjSI0pUwBOOigV4vPUoZLrlJJGIF/Z1Y2y9s8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksKFkOIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7AC4AF0B;
	Thu, 27 Jun 2024 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450040;
	bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ksKFkOIPD8B+IxtigbTwAuwg7Zi3C4sksnJDk2qwCJDFyBnx1CPl9lxXsmpzlgulQ
	 oLA6EsYD01q3aGiBq4BfIGKTX52cJ08PoKvb/WjeTLD7aXGncsmrJ5iQqkIs6koBN5
	 PntCYREhRs+JdmWkpQPu4EYd2sOl9h5/ef20IY8uXouz6gRCbIZn6/h+Cu9qX++hGI
	 wWq1wfUzUDxJm8GlIJ7HqUjuKqY4jEcJInvTHEOkFgVNG8iGkrKAsAUbep1WEVNkDa
	 7//UcWBy59SpfzyrHYM9wjhLB9RsJ7Qt0zcefYSVywwoenGVR3Jq4SIO75qebeN1JB
	 Cb1MI9Oqjs3LQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:23 -0400
Subject: [PATCH 03/10] fs: tracepoints for inode_needs_update_time and
 inode_set_ctime_to_ts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-3-a189352d0f8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TvAqWM+1osikcEDt9i0N4WD9vik81z9fLBMKtBzROY8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmu38o34Gc3uLqCC/KtRitsdQUwQQbBScUNZ
 xY97hHdyEiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rgAKCRAADmhBGVaC
 FUP6EACD4iVg9GXP9iA3Hn8lRNdHlGJ6Zy6M9ZhDcO6x6OiRZzdFfP0NgHKsFPdn2OnfETkahlZ
 GUYNkkiTUcbmS8kx8uGOv0t2By1BwU5Gig2xbUvCChWSNLlpJhfcSACoiyd3Z59dwnqyIlknHWL
 8lAD6m4QwwRpgRn8dz96Nbern/BwQ0MwgiSe7fxAD3xczDWM9eA7g9oxyCUy0x4Cgm+whV328Z9
 hVdTS7f3eBcfHjWyeP1EnceVlTAsZs55rwZp/uq53sUR8IZE31t8KK3XM2rOrGg6SXH51CWroSb
 45P0mbHembc5ibT3BDy30BAAEXJscI/6aAaL1BfiROPo1JseAG/df7eQmzoAmTlFy9t+UvqCnhd
 7c2goYMJrTEA3tUyWUa0RwqW6+bDSu3Gv2LxV4qNB0WaQF/rIGLZ6hdnysOdxXn80tLhbfatHuX
 YGY/56WUTpv9/Z5ooc6sHzggBFFcg0dFcPodRFmWgU4xTPL/xHRvRCpRSMLnPdW7mv4n3eswylP
 Q6K9QndkigtGk0lmq2U3HKGnXQR0K5wAJa9j1z1I3itPf1HVhdOxbBdQo5JOWaCOpXwovRowb4v
 pAEjUph2heWJ8O4jIFjj59Ct5FN1CInMMqtcROERa4vnmgpo4B2FVbZ8yTNqEDCkpdZaG2hby5r
 9MAyoeJnmKNLXKw==
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


