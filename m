Return-Path: <linux-fsdevel+bounces-77382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMghBTOtlGl7GQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:02:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522414ED9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 116D7305C323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD5372B4D;
	Tue, 17 Feb 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/RRn3WG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE736F43E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351278; cv=none; b=bIn+zbvR90nkcuE4zNsLdpMKEaA+uuqQB/nG2QK0tyeFmKDlMNvy26caXuYNm4T9XCrU0mbGPjGN7KjBkxu9p7z8Du35Yiacgm7hSZCdhAabKIuSdL8itjQoAE8p3YRQ5jBjVBaP6p85ATL8Q3AyGCWEiT0fMRSQvvVzKReJ+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351278; c=relaxed/simple;
	bh=3Hi4Yw1wa5t6RwBOUReTRUch3U2jt68qYKe1b8CJ15E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXR0yqgtKC+Max5T/gXOvoAql7FLqT4D0qgYJe5S1BBlCC1JfuhieFv69pIrusxYyv34I7XbszU7x2eCqrTS0qNiSZnlG7dqYrNJ6sVRqo9RAq8LV/f3vfwpS2bwOBVnoyJancd/GU9xzpYchs5CO92V5kByHwPex7cZ8TkvEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/RRn3WG; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6795b040001so37970121eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771351276; x=1771956076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNWH6w2foYf8QmhTrAmxhB/CQUCC0ZNVw0ETpO4TRL8=;
        b=G/RRn3WGXChfjYl416ZnkaHqChV1tM+Q/kJknc/q27uWFs+Oc1lYwp9i3wpYU6PChl
         vDTLO+2TijMCnpoCXI6t8rufTpfhamTeHdIxDvJAAeeo84d1mbgGe4N4UsagYHbuTMN8
         tzkNc8nkNAZV+0auIr8CvNF2JtC7xdw3X05PjGPflu6huYKXCb1mmFkEPTIdXePFkjUJ
         eOD/62ZRuL2FGttlqodSjtGvEMGvXPl5yfA6L+HTZwmioqLNtbva11Ice/gehxwpHrD4
         wFayBbS3GUC/VS6klopHSvX9dHEjwXC7JZxTXh8IV8xbhyW5OgEqnxNL0xQXeIq4xw19
         5w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351276; x=1771956076;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNWH6w2foYf8QmhTrAmxhB/CQUCC0ZNVw0ETpO4TRL8=;
        b=Nx4BRpCwl428kgnIOWj2PZWzd6tv46eoNri0Y/7DsGjBgEu4s/iAjToLRjageNIOW/
         DSWBDCufgpLj6xyBFOGFpSYpUFCO7r51F8/UbF4V1GSyeSQ+uMsdwRnROuNfDrYnsh2f
         viSea02Xwh62aRSUv5DBPYv40oFblHzgHY6vaB44AKv3L/UtxgHdIce6o/l1JVCnDzZt
         kLKhJQsOXIM6RY362PlWcoVLym5ysHgBOAqjZa/fl7wvxAJR2D7VxXyKoemVGV56I6XW
         jUOrm5+SDN2XyYgkuKhv/AwfavPk/MuwxU7X9Cv1FuxveeVr3ebV/248xSLVbp5M4mBV
         vvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcKZUu5ybruXdJCa3fNmY6H9pVXg+LPFANnv3i8rgp5E9FPjqFQb0KnH7ZCR/FRF02TjqkKYleBFtIrJXj@vger.kernel.org
X-Gm-Message-State: AOJu0YxiubvW/an7GdjRQDLKCWb0MfXPbKf+l+bCWt8/wV8fpj7tGhwS
	zldtnvZuseTYmAGyF4L+hdHDmYnKVlKLU2gd8L8ZOtBAHEe/aXVYudNEk5sZa0Lg5oC4FzDNpv4
	UjL1D2w==
X-Received: from jabko13.prod.google.com ([2002:a05:6638:8f0d:b0:5ce:aa0c:6674])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1622:b0:66e:e7e:6524
 with SMTP id 006d021491bc7-677690aef69mr8034820eaf.58.1771351275445; Tue, 17
 Feb 2026 10:01:15 -0800 (PST)
Date: Tue, 17 Feb 2026 18:01:07 +0000
In-Reply-To: <20260217180108.1420024-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217180108.1420024-4-avagin@google.com>
Subject: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-77382-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com,futurfusion.io];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 8522414ED9E
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

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/exec.c                |  2 ++
 fs/proc/base.c           | 12 +++++++++---
 include/linux/mm_types.h |  1 -
 kernel/fork.c            |  7 ++++++-
 kernel/sys.c             | 29 ++++++++++++++---------------
 5 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9c70776fca9e..8f5fba06aff8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1801,6 +1801,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 	n =3D 1;
 #endif
=20
+	spin_lock(&mm->arg_lock);
 	for (i =3D 0; n && i < AT_VECTOR_SIZE; i +=3D 2) {
 		unsigned long type =3D mm->saved_auxv[i];
 		unsigned long val =3D mm->saved_auxv[i + 1];
@@ -1832,6 +1833,7 @@ static void inherit_hwcap(struct linux_binprm *bprm)
 		n--;
 	}
 done:
+	spin_unlock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, bprm->mm);
 }
=20
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..09d887741268 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1083,14 +1083,20 @@ static ssize_t auxv_read(struct file *file, char __=
user *buf,
 {
 	struct mm_struct *mm =3D file->private_data;
 	unsigned int nwords =3D 0;
+	unsigned long saved_auxv[AT_VECTOR_SIZE];
=20
 	if (!mm)
 		return 0;
+
+	spin_lock(&mm->arg_lock);
+	memcpy(saved_auxv, mm->saved_auxv, sizeof(saved_auxv));
+	spin_unlock(&mm->arg_lock);
+
 	do {
 		nwords +=3D 2;
-	} while (mm->saved_auxv[nwords - 2] !=3D 0); /* AT_NULL */
-	return simple_read_from_buffer(buf, count, ppos, mm->saved_auxv,
-				       nwords * sizeof(mm->saved_auxv[0]));
+	} while (saved_auxv[nwords - 2] !=3D 0); /* AT_NULL */
+	return simple_read_from_buffer(buf, count, ppos, saved_auxv,
+				       nwords * sizeof(saved_auxv[0]));
 }
=20
 static const struct file_operations proc_auxv_operations =3D {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2f3c6ad48c0a..d1a95b90e448 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1254,7 +1254,6 @@ struct mm_struct {
 		unsigned long start_code, end_code, start_data, end_data;
 		unsigned long start_brk, brk, start_stack;
 		unsigned long arg_start, arg_end, env_start, env_end;
-
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
=20
 #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
diff --git a/kernel/fork.c b/kernel/fork.c
index 4c92a2bc3cbb..e17e57e29b6a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1105,8 +1105,13 @@ static struct mm_struct *mm_init(struct mm_struct *m=
m, struct task_struct *p,
 		__mm_flags_overwrite_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags =3D current->mm->def_flags & VM_INIT_DEF_MASK;
=20
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
 		mm->def_flags =3D 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index e4b0fa2f6845..c679b5797e73 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2147,20 +2147,11 @@ static int prctl_set_mm_map(int opt, const void __u=
ser *addr, unsigned long data
 	mm->arg_end	=3D prctl_map.arg_end;
 	mm->env_start	=3D prctl_map.env_start;
 	mm->env_end	=3D prctl_map.env_end;
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
 		mm_flags_set(MMF_USER_HWCAP, mm);
+		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 	}
+	spin_unlock(&mm->arg_lock);
=20
 	mmap_read_unlock(mm);
 	return 0;
@@ -2190,10 +2181,10 @@ static int prctl_set_auxv(struct mm_struct *mm, uns=
igned long addr,
=20
 	BUILD_BUG_ON(sizeof(user_auxv) !=3D sizeof(mm->saved_auxv));
=20
-	task_lock(current);
-	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_lock(&mm->arg_lock);
 	mm_flags_set(MMF_USER_HWCAP, mm);
-	task_unlock(current);
+	memcpy(mm->saved_auxv, user_auxv, len);
+	spin_unlock(&mm->arg_lock);
=20
 	return 0;
 }
@@ -2481,9 +2472,17 @@ static inline int prctl_get_mdwe(unsigned long arg2,=
 unsigned long arg3,
 static int prctl_get_auxv(void __user *addr, unsigned long len)
 {
 	struct mm_struct *mm =3D current->mm;
+	unsigned long auxv[AT_VECTOR_SIZE];
 	unsigned long size =3D min_t(unsigned long, sizeof(mm->saved_auxv), len);
=20
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
--=20
2.53.0.310.g728cabbaf7-goog


