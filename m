Return-Path: <linux-fsdevel+bounces-43999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF46A6084B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 06:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4B93BD85E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7FC151992;
	Fri, 14 Mar 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gw4iRTuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAC23B0;
	Fri, 14 Mar 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930065; cv=none; b=n6eipKkp51ZXXAKAZ8qpWlVLbOWmBP4/XtFhRYMrETR7LgzTBHfDkUqD/ks9998wJKUj15OcvNUvJpbDOByowK8/JlGDrJw9Bn2PmUBGmn2VCnJzTf9lnAxWD0tt88amfauyQTqqiwo3TZvd/o3EYV4Yg2cuJbCHl2ST59saKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930065; c=relaxed/simple;
	bh=Qad0HNYNG2mQ31pUF+uts0R4QYzNHajVBJxToGBcLvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYRlMcbKEuzZXwVHnFIpnKqndxcG5hkN2K5PdwEA6Bnu9pGnbOZIpNDEj1zb27tSkOH8/pSg9ZwgrQADXmzr9qxqVlRTA2zrVXB8JIS5Rz4N0Wu5ZNJ4muXctE8Dzn4QCyJqxn5RGh9rfv25NsV6F5J/uZ2M0Zk5r5r3MAVNOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gw4iRTuD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GqPrTsyS3aajz7ZThVCKkiRjh7iVAyZkGVinKr7Mvs0=; b=gw4iRTuDAS2eJw3qoVdsWlnm85
	8tZt4oDOh/smHkqLc+e8A+qD4PWm7Cactc053/Q3Z2dj9uNTA9HbG+kiOwG7eaAIBdfvC4Kpt18Il
	21gVLowHmhQa53uCPwCvDte12WhV5MXah3REGmGfdzOMDJnnyI4wTHouxAIr7s8LYNaDNYdMzhljt
	hU7fQM1x+XmvqhlgZzIYABZLZTLu7auQX72Z9Lv+jiaxoDfc5GxvqTw27NZTp7ZJjVLFGZfoJnQJS
	mMoUGf0RhFXJbjHNrO26njrPfwpPKSvdftcuIy8GHlDk8hRUyGvoAbFbuM0g/BmDJdS7yQkrmwH9a
	a1xutSsg==;
Received: from [223.233.77.29] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tsxZy-008TWs-Hk; Fri, 14 Mar 2025 06:27:36 +0100
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
Subject: [PATCH RFC 1/2] exec: Dynamically allocate memory to store task's full name
Date: Fri, 14 Mar 2025 10:57:14 +0530
Message-Id: <20250314052715.610377-2-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314052715.610377-1-bhupesh@igalia.com>
References: <20250314052715.610377-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a parallel implementation for get_task_comm() called
get_task_full_name() which allows the dynamically allocated
and filled-in task's full name to be passed to interested
users such as 'ps'.

Currently while running 'ps', the 'task->comm' value of a long
task name is truncated due to the limitation of TASK_COMM_LEN.
For example:
  # ./create_very_long_name_user_space_script.sh&
  # ps
    PID TTY          TIME CMD
    332 ttyAMA0  00:00:00 create_very_lon

This leads to the names passed from userland via 'pthread_setname_np()'
being truncated.

Now, during debug tracing, seeing truncated names is not very useful.
(for example for debug applications invoking 'pthread_getname_np()') to
debug task names.

One possible way to fix this issue is extending the task comm size, but
as 'task->comm' is used in lots of places, that may cause some potential
buffer overflows. Another more conservative approach is introducing a new
pointer to store task's full name, which won't introduce too much overhead
as it is in the non-critical path.

After this change, the full name of these truncated tasks will be shown
in 'ps'. For example:
  # ps
    PID TTY          TIME CMD
    305 ttyAMA0  00:00:00 create_very_long_name_user_space_script.sh

Here is the proposed flow now:
 1. 'pthread_setname_np()' like userspace API sets thread name.
 2. This will set 'task->full_name' in addition to default 16-byte
   truncated 'task->comm'.
 3. And 'pthread_getname_np()' will retrieve 'task->full_name' by
   default from the same '/proc/self/task/[tid]/full_name'

Step 3 implementation is achieved via the subsequent patch in this
patchset.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/exec.c             | 21 ++++++++++++++++++---
 include/linux/sched.h |  9 +++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac2..43d0a0d81d44e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1210,6 +1210,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
 	int retval;
+	va_list args;
+	char *name;
+	const char *fmt;
 
 	/* Once we are committed compute the creds */
 	retval = bprm_creds_from_file(bprm);
@@ -1350,11 +1353,22 @@ int begin_new_exec(struct linux_binprm * bprm)
 		 * detecting a concurrent rename and just want a terminated name.
 		 */
 		rcu_read_lock();
-		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
-				true);
+		fmt = smp_load_acquire(&bprm->file->f_path.dentry->d_name.name);
+		name = kvasprintf(GFP_KERNEL, fmt, args);
+		if (!name)
+			return -ENOMEM;
+
+		me->full_name = name;
+		__set_task_comm(me, fmt, true);
 		rcu_read_unlock();
 	} else {
-		__set_task_comm(me, kbasename(bprm->filename), true);
+		fmt = kbasename(bprm->filename);
+		name = kvasprintf(GFP_KERNEL, fmt, args);
+		if (!name)
+			return -ENOMEM;
+
+		me->full_name = name;
+		__set_task_comm(me, fmt, true);
 	}
 
 	/* An exec changes our domain. We are no longer part of the thread
@@ -1401,6 +1415,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	return 0;
 
 out_unlock:
+	kfree(me->full_name);
 	up_write(&me->signal->exec_update_lock);
 	if (!bprm->cred)
 		mutex_unlock(&me->signal->cred_guard_mutex);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9c15365a30c08..ebf121768d951 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1144,6 +1144,9 @@ struct task_struct {
 	 */
 	char				comm[TASK_COMM_LEN];
 
+	/* To store the full name if task comm is truncated. */
+	char				*full_name;
+
 	struct nameidata		*nameidata;
 
 #ifdef CONFIG_SYSVIPC
@@ -1984,6 +1987,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
 	buf;						\
 })
 
+#define get_task_full_name(buf, buf_size, tsk) ({	\
+	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
+	strscpy_pad(buf, (tsk)->full_name, buf_size);	\
+	buf;						\
+})
+
 #ifdef CONFIG_SMP
 static __always_inline void scheduler_ipi(void)
 {
-- 
2.38.1


