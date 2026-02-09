Return-Path: <linux-fsdevel+bounces-76738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDXGKzQwimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51757113EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8AAA30078B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF440FD84;
	Mon,  9 Feb 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUhqOWxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756644218BE
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663979; cv=none; b=Qc4WH7QRj+u8TLkcZ29twvXwO3ZfI73HZk2OPwA1fTNIR57PTB6p+tr+g3S2o+6Whw92kkY3HCgk/d5BGPRxxLjDp+GEDxQOue9jooJzB4eMGxrVNq8Z/lVpXObBq3t2SPJPywWWQVpodFwRa3YEJHZ7ILWARXivBx2jI9qvJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663979; c=relaxed/simple;
	bh=77kGZVNaKYz+QXGZQBlLxOKMlsctKpB/eDPJq1uQV94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DrKXUK/MsE/Ow4Wq2216SCnaDJDoiNyv+JioObdLnMSx6l83yt7XddsDMQ/RhRdbD5DinqPTF/kfvzGlgOp+umzFQKakgdPalN6S0AN0nbYnnWGmKyxzbikf3JHl3hOjZ6kUn2eSo64n2ZcmloCVzXOruaBglqzEM86QdJHUtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUhqOWxR; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6630d586952so6861421eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770663978; x=1771268778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4G/yDIBINwPi2+ikRkQ7TO2ayApdYAt//QBA3TmHUE=;
        b=yUhqOWxRhqST4aV+4mP0MkcQsUiaezX0zZVEpJAJvHNrrw14frzINT7E76YB5TSrUB
         1JulcVK/wxgbwJaGFsy4mU5aV1PsBT4jmPiSLzmUVgcXnH1TZKDxYAcUN3mkmSXrb1Gg
         D1DwxzFvmIhUHDZozxZ2TkFoaosPRJprAJJjwlWLj9DfO6GLDtjsCMntjqhYHuxF2+CN
         wyhAZV5MueUrHAtar1/eeCOHiSHx/muaiKjrwrp7B6EuNPXeJB5M332U8kAg5OB4TVeT
         Z+byHlm6RcyCkxWimUT1JZr1czIsWtmeBRSiqq4bIQhtZMWiRSO4u5i9H+rFKkUFAJBK
         JPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663978; x=1771268778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4G/yDIBINwPi2+ikRkQ7TO2ayApdYAt//QBA3TmHUE=;
        b=tcEpS9JC+RpgLiRZTYhP+dB5HhOTevbxskaiR26a2hPQbsS2dTwmOaaQrDD246oh0q
         18z9s7MZkc6pQoyUAOtPCklAuDpHbzig+GsOoArexRu4eUh2e5RwaF1VFJAFEUgtPJFe
         x962wIPx91hvxkneZYQXDM2Aqp3ugL6Z9YhV2Vppinwp6Ea8TiWSCEMrl2W4oUFgYUE2
         rj6x/ur1+28QlD5R/uvwx+jGVNKWFALaAZz84Ucn5FOrwAi9Xnpnd6GVs6sXoWxaEuXz
         RrOm/0zkePscGfUPWxmjPfRwstAzNR4ZVrsM7BnEDqN0cCJMep0JRGARLVItvBTcnaO9
         hhvw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ05iJ2C/uQxAgSPZyPmodNr3cfWS24QwI1VVG3QunvHMMyq5Hc1a/M87o0sVT7V58FqESYF16roEt3dYf@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnzPTLwvYLlm4whgcSV2zNsCpul9BWvCSyNd+2yJQlw5TxG8i
	UswJ9wpGEPFb9Ju/fbI6Sak7etbyLMpodQnt6akWLg7my0Njp7NMb2K9IumIMiMBPsJHEQOY+6m
	T9Hjcyw==
X-Received: from ilsl17.prod.google.com ([2002:a05:6e02:5d1:b0:447:81b5:ae2a])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1356:b0:667:7e1a:204a
 with SMTP id 006d021491bc7-66d0d10b35bmr5231904eaf.71.1770663978454; Mon, 09
 Feb 2026 11:06:18 -0800 (PST)
Date: Mon,  9 Feb 2026 19:06:04 +0000
In-Reply-To: <20260209190605.1564597-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209190605.1564597-4-avagin@google.com>
Subject: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-76738-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51757113EFC
X-Rspamd-Action: no action

The mm->saved_auxv array stores the auxiliary vector, which can be
modified via prctl(PR_SET_MM_AUXV) or prctl(PR_SET_MM_MAP). Previously,
accesses to saved_auxv were not synchronized. This was a intentional
trade-off, as the vector was only used to provide information to
userspace via /proc/PID/auxv or prctl(PR_GET_AUXV), and consistency
between the auxv values left to userspace.

With the introduction of hardware capability (HWCAP) inheritance during
execve, the kernel now relies on the contents of saved_auxv to configure
the execution environment of new processes.  An unsynchronized read
during execve could result in a new process inheriting an inconsistent
set of capabilities if the parent process updates its auxiliary vector
concurrently.

While it is still not strictly required to guarantee the consistency of
auxv values on the kernel side, doing so is relatively straightforward.
This change implements synchronization using arg_lock.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/exec.c      |  8 ++++++--
 fs/proc/base.c | 12 +++++++++---
 kernel/fork.c  |  7 ++++++-
 kernel/sys.c   | 29 ++++++++++++++---------------
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7401efbe4ba0..d7e3ad8c8051 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1793,6 +1793,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 static void inherit_hwcap(struct linux_binprm *bprm)
 {
+	struct mm_struct *mm = current->mm;
 	int i, n;
 
 #ifdef ELF_HWCAP4
@@ -1805,10 +1806,12 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 	n = 1;
 #endif
 
+	spin_lock(&mm->arg_lock);
 	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
-		long val = current->mm->saved_auxv[i + 1];
+		unsigned long type = mm->saved_auxv[i];
+		unsigned long val = mm->saved_auxv[i + 1];
 
-		switch (current->mm->saved_auxv[i]) {
+		switch (type) {
 		case AT_NULL:
 			goto done;
 		case AT_HWCAP:
@@ -1835,6 +1838,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 		n--;
 	}
 done:
+	spin_unlock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..09d887741268 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1083,14 +1083,20 @@ static ssize_t auxv_read(struct file *file, char __user *buf,
 {
 	struct mm_struct *mm = file->private_data;
 	unsigned int nwords = 0;
+	unsigned long saved_auxv[AT_VECTOR_SIZE];
 
 	if (!mm)
 		return 0;
+
+	spin_lock(&mm->arg_lock);
+	memcpy(saved_auxv, mm->saved_auxv, sizeof(saved_auxv));
+	spin_unlock(&mm->arg_lock);
+
 	do {
 		nwords += 2;
-	} while (mm->saved_auxv[nwords - 2] != 0); /* AT_NULL */
-	return simple_read_from_buffer(buf, count, ppos, mm->saved_auxv,
-				       nwords * sizeof(mm->saved_auxv[0]));
+	} while (saved_auxv[nwords - 2] != 0); /* AT_NULL */
+	return simple_read_from_buffer(buf, count, ppos, saved_auxv,
+				       nwords * sizeof(saved_auxv[0]));
 }
 
 static const struct file_operations proc_auxv_operations = {
diff --git a/kernel/fork.c b/kernel/fork.c
index 0091315643de..c0a3dd94df22 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1104,8 +1104,13 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 
-		if (mm_flags_test(MMF_USER_HWCAP, current->mm))
+		if (mm_flags_test(MMF_USER_HWCAP, current->mm)) {
+			spin_lock(&current->mm->arg_lock);
 			mm_flags_set(MMF_USER_HWCAP, mm);
+			memcpy(mm->saved_auxv, current->mm->saved_auxv,
+			       sizeof(mm->saved_auxv));
+			spin_unlock(&current->mm->arg_lock);
+		}
 	} else {
 		__mm_flags_overwrite_word(mm, default_dump_filter);
 		mm->def_flags = 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index 6fbd7be21a5f..eafb5f75cb5c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2147,20 +2147,11 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	mm->arg_end	= prctl_map.arg_end;
 	mm->env_start	= prctl_map.env_start;
 	mm->env_end	= prctl_map.env_end;
-	spin_unlock(&mm->arg_lock);
-
-	/*
-	 * Note this update of @saved_auxv is lockless thus
-	 * if someone reads this member in procfs while we're
-	 * updating -- it may get partly updated results. It's
-	 * known and acceptable trade off: we leave it as is to
-	 * not introduce additional locks here making the kernel
-	 * more complex.
-	 */
 	if (prctl_map.auxv_size) {
-		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 		mm_flags_set(MMF_USER_HWCAP, current->mm);
+		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 	}
+	spin_unlock(&mm->arg_lock);
 
 	mmap_read_unlock(mm);
 	return 0;
@@ -2190,10 +2181,10 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 
 	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
 
-	task_lock(current);
-	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_lock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, current->mm);
-	task_unlock(current);
+	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_unlock(&mm->arg_lock);
 
 	return 0;
 }
@@ -2466,9 +2457,17 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 static int prctl_get_auxv(void __user *addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long auxv[AT_VECTOR_SIZE];
 	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
 
-	if (size && copy_to_user(addr, mm->saved_auxv, size))
+	if (!size)
+		return sizeof(mm->saved_auxv);
+
+	spin_lock(&mm->arg_lock);
+	memcpy(auxv, mm->saved_auxv, size);
+	spin_unlock(&mm->arg_lock);
+
+	if (copy_to_user(addr, auxv, size))
 		return -EFAULT;
 	return sizeof(mm->saved_auxv);
 }
-- 
2.53.0.239.g8d8fc8a987-goog


