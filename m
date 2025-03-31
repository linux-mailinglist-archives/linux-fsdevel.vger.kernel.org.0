Return-Path: <linux-fsdevel+bounces-45341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A4A765B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB29188CB2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950951E98FA;
	Mon, 31 Mar 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L+o/M001"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767C1E520E;
	Mon, 31 Mar 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423543; cv=none; b=Yn09B7t0/i7M2xtFQeo4JKTsgexBqZOldFIdf+EqfDpv6vGG3gXZxGVqNhS3S+HHEs8TPMK0JCPKAKpgKSVW6YqItKmxv3ApyjLLHdlWzaMMWIsfjfL/dNOuaYGiVJTu/Evki/aj+B5YIu5fa0OjhZK76cnfhQ0li8Lmt2sl8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423543; c=relaxed/simple;
	bh=PtHxBraQ24vnyVeWep51sRq6RV1wdc6wiax6qMPd+JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abUkYBGBOyfKh4bs0X5d6voPdNzEskEoKdp7HP3GtF9zP2nR4pzAZDfz2rWdnynzO1sE9XT+wy4M786Jgl+vhdMcPfxGiF/8tDKdOwEq/r4hyHJcVPUBi+tsMa37sqap5eRx3HERFKmAy2ZPXWr63yTvS3kMdYXWOfJ2jL1NmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=L+o/M001; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1MkSIgjVP+CNberSoyFKkoWthULoTCREbX6XMJGd8lA=; b=L+o/M001kDp9zhtwVq6l7nKazt
	X33DiETYaftD/OyEKT64sHULD1LqxAwwGVw2p50uEMaK8Qxw903OL83zpimWSnT/AHZUoHF86VBDT
	icgPE3a6B0BK5o0wn1dBYthmgxXQyzbDDZq1kMesB+zKwc85ztragw76N+q/2nRszAE1/kYMvEZdA
	gs+dsWb+iugK2xp8P6uKnQMf9F1HBIzIcT9OOqwqnFbHCzaIy6x4thyVVAfgzGoM2ve5QKQo15BI1
	KnWXeXxsk2+zHZljLGAKzCB7cD/Wxt1H3wBSb9Hfk8+ifIoOJoYdN3Q3YToOJG3eC8hGhbtDze8ai
	5mrotbzg==;
Received: from [223.233.69.2] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzE6T-009Btr-M7; Mon, 31 Mar 2025 14:18:58 +0200
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
	vschneid@redhat.com
Subject: [PATCH v2 3/3] kthread: Use 'task_struct->full_name' to store kthread's full name
Date: Mon, 31 Mar 2025 17:48:20 +0530
Message-Id: <20250331121820.455916-4-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250331121820.455916-1-bhupesh@igalia.com>
References: <20250331121820.455916-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6986ce24fc00 ("kthread: dynamically allocate memory to store
kthread's full name"), added 'full_name' in parallel to 'comm' for
kthread names.

Now that we have added 'full_name' added to 'task_struct' itself,
drop the additional 'full_name' entry from 'struct kthread' and also
its usage.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 kernel/kthread.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5dc5b0d7238e..46fe19b7ef76 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -66,8 +66,6 @@ struct kthread {
 #ifdef CONFIG_BLK_CGROUP
 	struct cgroup_subsys_state *blkcg_css;
 #endif
-	/* To store the full name if task comm is truncated. */
-	char *full_name;
 	struct task_struct *task;
 	struct list_head hotplug_node;
 	struct cpumask *preferred_affinity;
@@ -108,12 +106,12 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
 	struct kthread *kthread = to_kthread(tsk);
 
-	if (!kthread || !kthread->full_name) {
+	if (!kthread || !tsk->full_name) {
 		strscpy(buf, tsk->comm, buf_size);
 		return;
 	}
 
-	strscpy_pad(buf, kthread->full_name, buf_size);
+	strscpy_pad(buf, tsk->full_name, buf_size);
 }
 
 bool set_kthread_struct(struct task_struct *p)
@@ -153,7 +151,6 @@ void free_kthread_struct(struct task_struct *k)
 	WARN_ON_ONCE(kthread->blkcg_css);
 #endif
 	k->worker_private = NULL;
-	kfree(kthread->full_name);
 	kfree(kthread);
 }
 
@@ -430,7 +427,7 @@ static int kthread(void *_create)
 		kthread_exit(-EINTR);
 	}
 
-	self->full_name = create->full_name;
+	self->task->full_name = create->full_name;
 	self->threadfn = threadfn;
 	self->data = data;
 
-- 
2.38.1


