Return-Path: <linux-fsdevel+bounces-28203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E3967FFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2463B223B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DE185921;
	Mon,  2 Sep 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="eX+FSbVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2D15D5D9;
	Mon,  2 Sep 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260841; cv=none; b=VijHLiZYl1kJ/Dc7btMnRJIksuGqMXd75iQ2BK3mWKmwMgyQkP1Eg3V0NRm3RXiI+Ls5x8b5fJjV92qwHVFAf15a89OWcl1FJaS+9zBKFyHelWT4NYCTeCYhkvMYy4YLMpXDzgj3H2/Ol1hsBmE4jao3PWjeVSkALc0tEdBAgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260841; c=relaxed/simple;
	bh=CJyjA4gBjrQqcN7SKwV2ogAyG7zP2fvwlMbtl9Q/2/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkAqGwodIAVUbST2zuU5looRSor3BvvPriAsElNd4xWQS90wP1o9CbiaBzXXEF+yOKd4Rs9zsyFlNKtPsc7mMnhEshHL5KPmHSQ2OkEVIqKre0igja0YFYgM2OknC8W3tjLVR7n9SgauXnxzGPu3DCqAwRsHTffVVVxA635wt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=eX+FSbVj; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wy0Dz6sqdz9skM;
	Mon,  2 Sep 2024 09:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7VuFq93k4shWsKttYPQiSWTE6fbnrqrqnw6DhIiaGM=;
	b=eX+FSbVjkVuBs1CE53MmEviWKOmjR8b3uXAAg1c4bo6j+myhrUYPhyXVsTIgdgwpCaqzPd
	8R/b+sZTRmToGqapYu293nY5wDGDZxeICV49jowhRYIb1lcaEIA9uxkpWRNOfmR2l8qjIK
	1/IMlhkZnMloIiJ9ToNiV1IDQg8vjRqtYPDcbK34/1+jcYU/eSs+vx9+M44rK9JA6lTWK2
	bRtFQFdkk0ME/j51vJ3Juw8jJhW/2C5L1jcclacsB/j8NzzSsw3WcnkZqCXeeN1MWeuDu7
	zfFJFsIqEWyJuv4lUCL0cutlD3ttYOomutyYC1ViwSV7G29WigtEdA0f3MeZBg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:24 +1000
Subject: [PATCH RFC 2/8] sched_getattr: port to copy_struct_to_user
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-2-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
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
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWHWbbc+l+FmL2+3K3T9tA9ldWoXnfYF75SQfvlkf
 rB++tqZHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiRr6MDH1F6wLmM4RyCDxy
 3PwjKr9FZv3518uv3EldtefUtbK7qTkMf7ivBy3Qfdl2pTeEM9JBupnd7+HGX/qhnTbdBX59m3/
 tZgYA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4Wy0Dz6sqdz9skM

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


