Return-Path: <linux-fsdevel+bounces-44000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04123A6084E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 06:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94A288021A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF015A848;
	Fri, 14 Mar 2025 05:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DARLe5rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47921547FE;
	Fri, 14 Mar 2025 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930069; cv=none; b=E8gpKPQ4yXwTj2eOhfH//c4RtCZeBQNKaxV6Dzw4/u8MpsnrPG6wupaVwd+BgWLZbQiWJy2AHjDauVmwnXJcf4Mx0MVCo0wa/AlG/8K8uUeZHzl7+9ZcymXhqcDzh9z85PW0yE/FM6T1hEoZyL0O3kmguR416t+IkC4vgdDl2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930069; c=relaxed/simple;
	bh=/RlrgyOfTR9+lV8sqDAKYIlgXMAjGP1oaBB2knBVdIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2JDv1e/Kq0vfLrF//A/0p2p0rd/y7bxtz59X3utXaK0RMyIMt0LprdFNFP7eLYlvKCLmFlbYLDq7CT1ds0G+Nf4cJtuLWqpBCM6xZ9yp4xueVdcDnv/8eY/RG6Oo3rYMhRAxUNR8kWt+36PXrtU6yBHLh5+owHJC3eA+7jMf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DARLe5rP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XHQX/r89tdEu/+r44z9pTYBcRICBqpqFI1LW+VGUlMs=; b=DARLe5rPwlxbVJWHqGFXJL6op5
	Q+ourTWSJkYma8Y3Kvnc3Dm9a++q4HQbgIXVFaodRqnamxthAZzp9hTDdwEOHWFrNs3f5O7KQMKTm
	KAeYLNAh8c8YDFC73Dypyy3Dcw57bBem0cydTklfHLyA+V2LWPY9JZl0zEukeV8R11cynF3c+kUFY
	6hRI6CEqiITS29einh3KhyAD+rfidSyLtzdWhG8UpCFwtO+7K9EpA2PVbUeCNNnESfEwZ0+qILYrc
	6+yvFjmkRZvFVdmalFLtHxlbuHRxZIYHZfMio/KKS69qbumHVa8xM2ws4RBWOQ5YCOqAvBPRoSjA6
	/S1LYekw==;
Received: from [223.233.77.29] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tsxa5-008TWs-Hx; Fri, 14 Mar 2025 06:27:43 +0100
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
Subject: [PATCH RFC 2/2] fs/proc: Pass 'task->full_name' via 'proc_task_name()'
Date: Fri, 14 Mar 2025 10:57:15 +0530
Message-Id: <20250314052715.610377-3-bhupesh@igalia.com>
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

Now that we have the get_task_full_name() implementation which allows
the dynamically allocated and filled in task's full name to be passed
to interested users, use it in proc_task_name() by default for
task names so that user-land can see them through appropriate tools
(such as 'ps').

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa931..2cbeb1584f8a4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	else if (p->flags & PF_KTHREAD)
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
-		get_task_comm(tcomm, p);
+		get_task_full_name(tcomm, sizeof(tcomm), p);
 
 	if (escape)
 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
-- 
2.38.1


