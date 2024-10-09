Return-Path: <linux-fsdevel+bounces-31477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EFC99769D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F42282437
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDE1E32B6;
	Wed,  9 Oct 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="WLfGeaQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD21E1C3A;
	Wed,  9 Oct 2024 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506487; cv=none; b=q7a/DNDqRivHMrOY850B8OigYtrzJvwy1zDmMerS/EcwVrsLzRSJCY/+Fjw7/WMFQSBSX2mV6Jo/pTeot/Jl3gb/Jk2xPVCTHISTW42O6aEpI826EitVhhtnYcGowtO/Pjcpqld/xUaf6DI2IveUBniWI1LJbk9HJ1tCzd1lB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506487; c=relaxed/simple;
	bh=QV0XWMTc20hLZijF548/w6lWL5AXc1mfe0SnCes6JsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Izysi1oHde7RtbnR17994ZpdxvJXXMq3zX61R9kenJoeGNbGCTIWEWC5VNu6YhuYR9qHXk1YbiyXXkSOzcQEkZL3Vby4gkQTmSMaF5/Cy4rZXlTGIvRJe5VWlQuMxil3UE0N7UK5p1Od8KP8D/T+gShOXaXP81XN3MIJOeCS9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=WLfGeaQI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP4YG0mgHz9t4R;
	Wed,  9 Oct 2024 22:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtXxwnPBx6NnwUwXaCLmtGCf9bKP01jr4NfFLrKb8cI=;
	b=WLfGeaQIpls4YFkD0cnZ1egMM+13kERLlyj0wisqXjJ+Xq5+E088vSgfilJzZQOM0CxKQR
	UeFObHUi2/dcUEfmvpRlIT8ZsPXZzXsrPIVc2uxPYyk3PIPa9XBzp2lfNqF+e+gVtDwzQe
	IVK1ErNXrs192WVtYDkuJObxfuV0F2MgvugYzcP3mxafbq+5zJ10jnfrG4zdB9LSKc9fsW
	fyu1GhEJ0BdiVwZMvTshKvekXpm7gkdsXQ+3jkZLJNXR4wPPToI/K4imCI2Q0Z9UNV5Ty6
	RmidvHnvv/4P73eoNIcNLTDChgf2PJs2dZ5Je+NT0y2D0DvOKXHwAA8pqXcWXA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:35 +1100
Subject: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=QV0XWMTc20hLZijF548/w6lWL5AXc1mfe0SnCes6JsA=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQoMeZk/Q6U++OKKmnvBvadebrCaLpswcUGNglLsd
 ZbS5GUBHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiM4UZ/qdMNbR7vrGsM/N9
 ZwPfv62zztsn5t1jkZ3l9UVs+1o72U2MDDOb3RImWL9OuKvSmLO9wZfhnHFr4vY7dcvPHb0poG1
 RzA8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

sched_getattr(2) doesn't care about trailing non-zero bytes in the
(ksize > usize) case, so just use copy_struct_to_user() without checking
ignored_trailing.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/sched/syscalls.c | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..4ccc058bae16 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1147,45 +1147,6 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
 }
 
-/*
- * Copy the kernel size attribute structure (which might be larger
- * than what user-space knows about) to user-space.
- *
- * Note that all cases are valid: user-space buffer can be larger or
- * smaller than the kernel-space buffer. The usual case is that both
- * have the same size.
- */
-static int
-sched_attr_copy_to_user(struct sched_attr __user *uattr,
-			struct sched_attr *kattr,
-			unsigned int usize)
-{
-	unsigned int ksize = sizeof(*kattr);
-
-	if (!access_ok(uattr, usize))
-		return -EFAULT;
-
-	/*
-	 * sched_getattr() ABI forwards and backwards compatibility:
-	 *
-	 * If usize == ksize then we just copy everything to user-space and all is good.
-	 *
-	 * If usize < ksize then we only copy as much as user-space has space for,
-	 * this keeps ABI compatibility as well. We skip the rest.
-	 *
-	 * If usize > ksize then user-space is using a newer version of the ABI,
-	 * which part the kernel doesn't know about. Just ignore it - tooling can
-	 * detect the kernel's knowledge of attributes from the attr->size value
-	 * which is set to ksize in this case.
-	 */
-	kattr->size = min(usize, ksize);
-
-	if (copy_to_user(uattr, kattr, kattr->size))
-		return -EFAULT;
-
-	return 0;
-}
-
 /**
  * sys_sched_getattr - similar to sched_getparam, but with sched_attr
  * @pid: the pid in question.
@@ -1230,7 +1191,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 #endif
 	}
 
-	return sched_attr_copy_to_user(uattr, &kattr, usize);
+	kattr.size = min(usize, sizeof(kattr));
+	return copy_struct_to_user(uattr, usize, &kattr, sizeof(kattr), NULL);
 }
 
 #ifdef CONFIG_SMP

-- 
2.46.1


