Return-Path: <linux-fsdevel+bounces-48348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60AAADCE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4486B3A7973
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B021770C;
	Wed,  7 May 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IJ9uqSr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFFB217647;
	Wed,  7 May 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615913; cv=none; b=VfSflbkwIBNxYw5jTMAYLH3KeJlBPlYPwAMCjZgnM3Q756f9rImMGXUMa5pfO2Mi6PFGEuM/+btDqlv9WSfQLXMHNYCDxSv4R/y87M4jnWDXiqNIJbWssTh/fOGbTOEpEeDOeTxvnW3jwNAYFX8afPjaDikPCyga3PW8ol9S6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615913; c=relaxed/simple;
	bh=OOgluzoXjvHZLR2HjzqZH+NGY592izlc7i8Ve6dEhNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifQ4wNn9CdhKTUtrRvVey05hFLgywMquYATCRVp8m0uk7T+H3alIN19e9+ZoA+eynKewGrIsoDVICWBe4654KzT+OxbSCra/HTA8v299sJYuKegGfrpeolZX0rF7SYfl+jD21lzhcUAJQIMNhBF72FSIRlH8E7KLoDF8plCJXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IJ9uqSr9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gTfNNksQy2E+ZtNstFehMQzC+wJ++X6RiLzY/QWMRNA=; b=IJ9uqSr9rFPG1mHRB12cq4yByj
	Mx/zCauO0XxO+S7x7YUDG/44QxjctCmeqpz7vEJ5O7VyyqdQrWTeZvTAkDS/t72+cIk8E0g+qi99i
	KDEngf63HRzoRyMiVN65nxhne6mcg4iON6vUX/wJGz+b8cM85S7rcHCXODaVklIRByFV6SDo1vrTJ
	ex6dx3RlXGK8dTEKI1lzCaLQjj6JUB1/KkuUqabtqyfQY1USrIbPQpO0X7lks9W9WWXeqroJAOICd
	rwSAkKbOjHpEJLo6LIlEkajdwMuvi9dev0q3SPt3ZAJ22jRKEm13klqZIF4b/sSwpX9ydk5nWHK/5
	1RgX2Vxw==;
Received: from [223.233.66.62] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uCcWU-004fhg-Et; Wed, 07 May 2025 13:05:05 +0200
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
Subject: [PATCH v3 1/3] exec: Remove obsolete comments
Date: Wed,  7 May 2025 16:34:42 +0530
Message-Id: <20250507110444.963779-2-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250507110444.963779-1-bhupesh@igalia.com>
References: <20250507110444.963779-1-bhupesh@igalia.com>
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
index f96ac1982893..cb219c6db179 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1159,10 +1159,8 @@ struct task_struct {
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


