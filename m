Return-Path: <linux-fsdevel+bounces-55720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8AB0E3B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B7C4E59BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295928467B;
	Tue, 22 Jul 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFNmf1z9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C7283FDD;
	Tue, 22 Jul 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210362; cv=none; b=OK5+Q2Mv1Pvixr9D0n8a30iFhY8YY1F0XL0tQCKQfijwDRDNhwIudLoYVCCGXEOJPpskNUn4M5THTA8V+Hx1Ar1d5Y1Kds8cGpxWNuJkiBvNihMMIiZRlawS0/QsKVCyfz7QMIT7uJ53d2SEP0B9ldH7oc0Y3nJKEG0qSNBchls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210362; c=relaxed/simple;
	bh=apbJUn2GYMxwEvdL9T8Odi+1K6I7qN6CC7cmy3Kd4do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtZwpafGPCDDTxqOgW2mkEADZ/se4eTEZQA2mUpXajpqURQ8IHEfHuUhUdVImAYJvuV2MAsxoovy/pGtycJ4h8X3ACID+cbgUluuzSSujrvn53eyc6nvnzT2TGBwbW5aNtVG4i7UtcnvCgSIxRThG4LBVbx0dwVGHy+fKYOvNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFNmf1z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A7AC4CEF8;
	Tue, 22 Jul 2025 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753210362;
	bh=apbJUn2GYMxwEvdL9T8Odi+1K6I7qN6CC7cmy3Kd4do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eFNmf1z9FLotZKIyolB5buZFoQiezsQYrah/gCseMWrMkfevaDt6gBsplLbHYbzUF
	 yTgW00AeM1P5OPilZdow5W5NCJUqi98zszkOFXKs2VVAoCHUy0sbZ93EjyqHfnHhSu
	 tw2qGg6De/81mlPI0LW2GE0eNhTz6qRmq6KEnJ79TdNKVEXT/9P0bTYtyHG1yHGL4Q
	 oqgFZxDGDoKKscYb38sT3xtirXdaYKJ+xRSj3qultOkmBnSSXKDRg8JiUJDacCSUP+
	 ylAg1sRxCAtlkY7iUaRKGIgM69QKpOphpSRwGvtikC9wmJgPxeP/CipORK6S5UaL88
	 idXUQZ5Iner0g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 22 Jul 2025 14:52:27 -0400
Subject: [PATCH 1/2] vfs: add tracepoints in inode_set_ctime_deleg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-nfsd-testing-v1-1-31321c7fc97f@kernel.org>
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
In-Reply-To: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=apbJUn2GYMxwEvdL9T8Odi+1K6I7qN6CC7cmy3Kd4do=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBof932FhldSMvrXMgAlZ3u1/gC/mWBZwP96O8px
 IYCFg9B/2WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaH/d9gAKCRAADmhBGVaC
 FYuWEADGdCj2uZb5ghm1gPxpM7hPE3nblhWkDKZxoiD5M1Q0oc5GWZaQIWLeu63hfPGJO4EWHu0
 KoEpXdehUL5GKGHy+b2ZqDV1LIDIAr5j44g4xuh3n7N5tJXxZDF3nH4Z+TsgT/cC5NeVQlgRNfU
 /OTC1elXvx6RzNHRtYYxaBHA34gyRwIMxUIhVe5qGn7ZGw/H7r+SFOH2JEoSeNVZwfiKMcE4bzJ
 klxlMTCHvwPMJBDv7NR8QzFW1fTt6PN1PjTcEB29QobW8vtx00T38FXtOp2qkfvgFaDR1hhJQcl
 ubAaMwCuwDrzzn56OkMdKdycXINnS99IjsGzKungrTfQ3xTdhcz9ThWUSe/6JNj+o6KjxMc8cwb
 6Bnnfo2751PlQB2SrHp3ogSFgAZf5O+iMLCU/X0Itkfd4FYdUUDlvxLDtGdF/RoJzfikozITySz
 FqfHPkKjxEKK5KueIs8i/MYxrOTIHZJjAupIjfBQES8PVhJg5wS0bRpgqYGveGBjNHA4LaIF+Ej
 DkHNKjldzYuk876a7rkg8RhXfS+89deek5QHukfEmVW899rcMHLXPs30yiCc5kr2uS5kHsIYQgP
 K6K2qjFAqz17nQC8ohlzyLGnc6yGxPYb4WbhZhe6QGQfNTiIv/UTHzGzDojSfzleReacAX/OA47
 u/H2bXK++gRGbdA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add tracepoints in inode_set_ctime_deleg() that show the existing ctime,
the requested ctime and the current_time().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                       |  5 ++++-
 include/trace/events/timestamp.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a13b3dd8dad0f5f90951f08ef64de..6a8bf57d649aa0909b85f09e3b5b0fbc81efe303 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2811,10 +2811,13 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 	cur_ts.tv_sec = inode->i_ctime_sec;
 
 	/* If the update is older than the existing value, skip it. */
-	if (timespec64_compare(&update, &cur_ts) <= 0)
+	if (timespec64_compare(&update, &cur_ts) <= 0) {
+		trace_inode_set_ctime_deleg(inode, &cur_ts, &update, NULL);
 		return cur_ts;
+	}
 
 	ktime_get_coarse_real_ts64_mg(&now);
+	trace_inode_set_ctime_deleg(inode, &cur_ts, &update, &now);
 
 	/* Clamp the update to "now" if it's in the future */
 	if (timespec64_compare(&update, &now) > 0)
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
index c9e5ec930054887a6a7bae8e487611b5ded33d71..e66161d8e14d9b74b0c875f0b324d24895403c18 100644
--- a/include/trace/events/timestamp.h
+++ b/include/trace/events/timestamp.h
@@ -118,6 +118,46 @@ TRACE_EVENT(fill_mg_cmtime,
 		__entry->mtime_s, __entry->mtime_ns
 	)
 );
+
+TRACE_EVENT(inode_set_ctime_deleg,
+	TP_PROTO(struct inode *inode,
+		 struct timespec64 *old,
+		 struct timespec64 *req,
+		 struct timespec64 *now),
+
+	TP_ARGS(inode, old, req, now),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(time64_t,	old_s)
+		__field(time64_t,	req_s)
+		__field(time64_t,	now_s)
+		__field(u32,		old_ns)
+		__field(u32,		req_ns)
+		__field(u32,		now_ns)
+		__field(u32,		gen)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->gen		= inode->i_generation;
+		__entry->old_s		= old->tv_sec;
+		__entry->req_s		= req->tv_sec;
+		__entry->now_s		= now ? now->tv_sec : 0;
+		__entry->old_ns		= old->tv_nsec;
+		__entry->req_ns		= req->tv_nsec;
+		__entry->now_ns		= now ? now->tv_nsec : 0;
+	),
+
+	TP_printk("ino=%d:%d:%ld:%u old=%lld.%u req=%lld.%u now=%lld.%u",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
+		__entry->old_s, __entry->old_ns,
+		__entry->req_s, __entry->req_ns,
+		__entry->now_s, __entry->now_ns
+	)
+);
 #endif /* _TRACE_TIMESTAMP_H */
 
 /* This part must be outside protection */

-- 
2.50.1


