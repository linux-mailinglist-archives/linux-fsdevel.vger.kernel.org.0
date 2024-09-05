Return-Path: <linux-fsdevel+bounces-28747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904D96DCDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8681F21D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EA19FA96;
	Thu,  5 Sep 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="0vk45VJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842919ADB9;
	Thu,  5 Sep 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548256; cv=none; b=PUG/Ad0dsuGmRLhJXrzqu4OY3s0S9ZYcUYZAwAqnwzVD5gTJvY7o9VvNDrp5RfDqdhi6OdwvV8x02I7/YTORUrU3DBLHG/4oJjme7+57cIwF58qJbHShWAa7LWFz+YxFUUrARDjdAiFivvHacIGp5RHAkwmy/vz/+ouVuQBPESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548256; c=relaxed/simple;
	bh=CJyjA4gBjrQqcN7SKwV2ogAyG7zP2fvwlMbtl9Q/2/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNJvHYaDAOYtbueFC5ZMACQ6P6gwJrcaqXAqJQqAVpQaHonBhlXY4E/uJ+IBbiSGWiFOSU4Jak3pBFd64LvOPE0UoxIhDwbDi6MRglk5AQxc3tEf/c23mggqRPXvmYE8FEBFp63CLw0LQAB2pKcWf9KJ5aZgCsmPcTQ9TcLdhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=0vk45VJc; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X02X46Mklz9sWG;
	Thu,  5 Sep 2024 16:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7VuFq93k4shWsKttYPQiSWTE6fbnrqrqnw6DhIiaGM=;
	b=0vk45VJcttKQDOXnR+jtUHP1va4ng/Mx8pNZxmN7/DdaKfLRd/T8fAg+w4IAExm2FyKxsL
	sWv34gYTh0D7wRByCNE6z2GQ/iYspGr6dZBvkLaA+LJizYK4FzaiKQmM6k3QVFxQjWAijW
	5yZgDzDO4QvGdh5QAIbT6MiOh6P7mG8lcLJ2Zob+gXamJmptl5o5RDmwytL9MtMB5O9FLe
	XEG9u+JUO3zrTwXFqresk1ECcmENY+CMOsLvIqndRwGBAOkzx4cfePOmT/85cSM4SK7lxg
	heqi582JEv+zAuCO17g0sZte3wFDUu/AaFuGP1PiIh/RHpnN37Ne/4j+DRUORg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:34 +1000
Subject: [PATCH RFC v2 02/10] sched_getattr: port to copy_struct_to_user
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-2-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
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
 h=from:subject:message-id; bh=CJyjA4gBjrQqcN7SKwV2ogAyG7zP2fvwlMbtl9Q/2/0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLb5XcT7W1zejTlBn65oy2/+vn/GZ6nKZrcSp7RI3
 oOS9yzlOkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEUpUY/srt0rmwa++uJTO/
 VfAei93D+nRNfPbu12Xv3lwQ28C9Wms9I0NnfdDDpzVWaqt2JoT0WUetrzSNZvnnqq5z5IKkWuv
 q73wA
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
2.46.0


