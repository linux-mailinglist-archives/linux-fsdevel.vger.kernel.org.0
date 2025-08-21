Return-Path: <linux-fsdevel+bounces-58596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D8B2F549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BB93AF65F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397542FE57B;
	Thu, 21 Aug 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dcitShqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A32FDC3C;
	Thu, 21 Aug 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771757; cv=none; b=icPcxL/7ygMUt8zQp5VqvoI32Y+EKWQAaKIofGpOZWQxaH2KgynarWnLmp4QpfsGYdxm8DRqMViVgm4D2KVvjpXO81BZzOkIlZiSM8wovZKT8KzwfjeBsLAt6wlaNlnSDHm+7MzUQ1cGdymwYhwdpd8VzHBKz1tlNDL47mBw0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771757; c=relaxed/simple;
	bh=wvaUmALRQLnARKD+yeMOhpT7bXS/e9AoONMp4b6P1Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0dhufU5uxImO8DAgvnQ16n/CWFZFEH6BvN3jE7aNgXaPsUKBb1LW5SZaLfb+7JlFuER3MiwR+ScbKq6iuvIFO4NCRySiwB7bgyxq86JJ4teeX5qOndQ5cETzigxSmib7t9LxskT5pJ9HLFzw+b08pvfjEKoAF0mSyZ5shiV8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dcitShqS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VqJEmr/n09REC8+UBB9VEKt7Poxqe/QefzeRVIsvj6A=; b=dcitShqSPUuBBKA4+9P37TcOhG
	u7PqftO+reDMPuDKrTaP4COiidnrQNYhqrUuz9RukvpTJp2gJpPv4W/YtsqtSG8g8AquTq3IprFER
	VxAVoVW8/k2sFNeNg2R2p8YJ8JKugf02aO5keT0AxLXt3mr54ivsCOMEcnqJK3qUhTk/zjAW6CArQ
	MwBPbyfWOrwyFPUlTSmn6W9xU4xiVNNafCN6t7gVsnlmxzmgx7THcsJOtBGW9CqoZFda7OcOYQ33K
	g1cHk59nVGk+2UdcdyIUxwskYIMot9FQ3Yy4WLFfhaArAJQK0uzyMDmz/GUy0GnrA1Q/FJW5aEmo4
	7JXrWb/A==;
Received: from [223.233.68.152] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1up2RD-00HBmV-Hy; Thu, 21 Aug 2025 12:22:31 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v8 5/5] include: Replace BUILD_BUG_ON with static_assert in 'set_task_comm()'
Date: Thu, 21 Aug 2025 15:51:52 +0530
Message-Id: <20250821102152.323367-6-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250821102152.323367-1-bhupesh@igalia.com>
References: <20250821102152.323367-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUILD_BUG_ON() with static_assert() inside
'set_task_comm()', to benefit from the error message available
with static_assert().

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d26d1dfb9904..2603a674ee22 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1972,7 +1972,8 @@ extern void kick_process(struct task_struct *tsk);
 
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
-	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
+	static_assert(sizeof(from) >= TASK_COMM_LEN,	\
+		"tsk->comm size being set should be >= TASK_COMM_LEN");	\
 	__set_task_comm(tsk, from, false);		\
 })
 
-- 
2.38.1


