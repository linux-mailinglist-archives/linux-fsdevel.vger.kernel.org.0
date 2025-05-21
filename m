Return-Path: <linux-fsdevel+bounces-49557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D51ABEBE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03F91B6716D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 06:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A3233155;
	Wed, 21 May 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lPzMBE1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16F230BC5;
	Wed, 21 May 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808642; cv=none; b=Qz7xCdPqtn1fajz2VmP1QyXdEKE012n5Hm6luwgmw7qHaDqrFl6oBsLSlSdsy3QQxTdNnjQunYiInltanyBWX/K1TblFOs9A5aKxb8tK9zzc/Wkl4dUAridQvULLG3EPT2iNF2y/+LlJ+0xi7Ko1FaDXlnC9yKSGzFtF5+DxV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808642; c=relaxed/simple;
	bh=I8faleen+YlYRwQJOEFwvKHjEj3VGyqU4/5IQ3Xn7Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0uGrIcyid0aPITaXf0krC3OfcoubTJvO8psb4d/jLDxmSTJszUu4Z9VgOBqKr2BZS245jbvi1DJn4CXa69di3lEHqjuuDTy86qg51Uk3JyTxWLsT0byNpIT2Rv76zRsw6KfPVCybYwQOmspJj8pVfB1Z+rgIirioys/cVBN3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lPzMBE1P; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mj1L8UT5keBFToIFmCVn4vf03lSCBcagktZ7oeGryzY=; b=lPzMBE1PrVethON7w5jSglZ0xH
	doMttCtEHa3eE5f+fCV168lQsBT2/z+SSX6WM6u1qcTFFAQZbVT4KEKYq3P/aZcfSvHFoFAGM2tE7
	luHTWLJ1z3bG/Q0B4+YnNDNufb24FcogBUnxL1gTq6DggcJOuoQZT35uA61x8TkmUrU1i42nIC43N
	eLDbKGfDDQQIVEhr4Dnk3EtISFTwWezSPLTCZ59CvgIzNp9b6cQny6eTNcsQ82ixKM9jeguTVvcBg
	TmIaHE19jBMUvyhf6ezdOBl8N1czNhiqPIDMErkVMbNDquDobWCOfzAb2TfR7cMJMX4qzES5jePmV
	STdRxYgw==;
Received: from [223.233.70.209] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHcrs-00B3oN-DJ; Wed, 21 May 2025 08:23:56 +0200
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] exec: Remove obsolete comments
Date: Wed, 21 May 2025 11:53:35 +0530
Message-Id: <20250521062337.53262-2-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250521062337.53262-1-bhupesh@igalia.com>
References: <20250521062337.53262-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 3a3f61ce5e0b ("exec: Make sure task->comm is always NUL-terminated"),
replaced 'strscpy_pad()' with 'memcpy()' implementations inside
'__set_task_comm()'.

However a few left-over comments are still there, which mention
the usage of 'strscpy_pad()' inside '__set_task_comm()'.

Remove those obsolete comments.

While at it, also remove an obsolete comment regarding 'task_lock()'
usage while handing 'task->comm'.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/sched.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8c60a42f9d00..704222114dcc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1162,10 +1162,8 @@ struct task_struct {
 	 *
 	 * - normally initialized begin_new_exec()
 	 * - set it with set_task_comm()
-	 *   - strscpy_pad() to ensure it is always NUL-terminated and
+	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
 	 *     zero-padded
-	 *   - task_lock() to ensure the operation is atomic and the name is
-	 *     fully updated.
 	 */
 	char				comm[TASK_COMM_LEN];
 
@@ -1997,7 +1995,7 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
  *   User space can randomly change their names anyway, so locking for readers
  *   doesn't make sense. For writers, locking is probably necessary, as a race
  *   condition could lead to long-term mixed results.
- *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ *   The logic inside __set_task_comm() should ensure that the task comm is
  *   always NUL-terminated and zero-padded. Therefore the race condition between
  *   reader and writer is not an issue.
  *
-- 
2.38.1


