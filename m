Return-Path: <linux-fsdevel+bounces-45339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FEA765AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D37D1887223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6E1E5B72;
	Mon, 31 Mar 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GLoQ8Gs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F51DD525;
	Mon, 31 Mar 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423531; cv=none; b=efgw0oe7YQlNvk/+4Gb/blqOKeqpbZB/wPwgJ+z+M2ZryBhCURDACG5YomWiwGd4Vwec57iOkOs0R2X4ngde+6sQfmXq7EfRRhRpya7/Zd0riT3parjYfXLCLhEl7a6iWja87vEYScXmCez6PPV3TmtXZp8gpo+ptBfNg0YbhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423531; c=relaxed/simple;
	bh=3NK1xXrNlc0u/r0W44A+OrbUmrXRF9zO+adUHiLTgFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4lsSGOoZEL8T0Pc0SX2ucaWb1r0/fZCR/uBqC+PusZGJ+A1bJt7mz95vnCAS0ro9Nz8Qc7TwSqFh8xMwSHDAQbm0xPkT/yZ545w8d0A60Q2fD4adZD925HbT44D8CoNDyp6uqoDgRPkgZEkVFNc40s1NoVqMXZ/FkD4wQwF4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GLoQ8Gs7; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m2o+Mi9B+LLlSr1F+IZ6AiiYjWbrFv3KIUCOssd5KE4=; b=GLoQ8Gs7Pv63GbZtpCeznhHQZD
	uGrw3V2kkzc05t3W9WL4nTZX5nrNHWFnf2oI+TulxjbbjiBuH13I6FIwJmAxh+qaikLRf3yKZ9e0z
	HD2HPTVbcLIBMPpKCCNDYZNLYwDAMk5n0eNwKKqtHRFqZkh5X0CfkPs48QBJytxuJywPJmCPFb4Ib
	u9XW3oOch4MwZynhdtcLpW7cqx8XuMgcjx6Yf01DOmYLiIcDbPGgJ9AAt1oCmCpLswGouy5i/3ZQ0
	76c3H2ssIWvhu42wYkEIJ+CiP9csFpnYwT9QyddFHdCDAOMxhAdUHpNDFggAQynJsn7TfsVUjmVv4
	e7mlHXnw==;
Received: from [223.233.69.2] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzE6G-009Btr-G1; Mon, 31 Mar 2025 14:18:44 +0200
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
Subject: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's full name
Date: Mon, 31 Mar 2025 17:48:18 +0530
Message-Id: <20250331121820.455916-2-bhupesh@igalia.com>
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

Provide a parallel implementation for get_task_comm() called
get_task_full_name() which allows the dynamically allocated
and filled-in task's full name to be passed to interested
users such as 'gdb'.

Currently while running 'gdb', the 'task->comm' value of a long
task name is truncated due to the limitation of TASK_COMM_LEN.

For example using gdb to debug a simple app currently which generate
threads with long task names:
  # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
  # cat log

  NameThatIsTooLo

This patch does not touch 'TASK_COMM_LEN' at all, i.e.
'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
that all the legacy / existing ABI, continue to work as before using
'/proc/$pid/task/$tid/comm'.

This patch only adds a parallel, dynamically-allocated
'task->full_name' which can be used by interested users
via '/proc/$pid/task/$tid/full_name'.

After this change, gdb is able to show full name of the task:
  # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
  # cat log

  NameThatIsTooLongForComm[4662]

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/exec.c             | 21 ++++++++++++++++++---
 include/linux/sched.h |  9 +++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f45859ad13ac..4219d77a519c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
 	int retval;
+	va_list args;
+	char *name;
+	const char *fmt;
 
 	/* Once we are committed compute the creds */
 	retval = bprm_creds_from_file(bprm);
@@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	return 0;
 
 out_unlock:
+	kfree(me->full_name);
 	up_write(&me->signal->exec_update_lock);
 	if (!bprm->cred)
 		mutex_unlock(&me->signal->cred_guard_mutex);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 56ddeb37b5cd..053b52606652 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1166,6 +1166,9 @@ struct task_struct {
 	 */
 	char				comm[TASK_COMM_LEN];
 
+	/* To store the full name if task comm is truncated. */
+	char				*full_name;
+
 	struct nameidata		*nameidata;
 
 #ifdef CONFIG_SYSVIPC
@@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
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


