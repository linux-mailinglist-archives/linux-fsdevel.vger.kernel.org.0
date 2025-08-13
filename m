Return-Path: <linux-fsdevel+bounces-57715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022EB24B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DC31BC2566
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99A2EF64A;
	Wed, 13 Aug 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqaOCqnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046C2ECD3C;
	Wed, 13 Aug 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093452; cv=none; b=d+t81jjvbF5V20btJBWpnXefRGhvv2nPP/kwPbgd1qTJm3w8nCghTRsBKegIQx7k00Gf1JsAYa6y6PBwSpi40T2/ihbqBYmp6Tnu89RGjCfRHAwayVhyith2AlCC4N4MVO7TBVOrINLX9qlgXs+9NmtojbRE1oqtjYJpP+tIG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093452; c=relaxed/simple;
	bh=clzkXZMykLrjrnKo2KZHjDNwa7wN2qhvT+IRnTjQP6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1lYGpAYqD6hFeSqavWr+J/AO/juNshJYL5L1aihJ+RrLkf+sIp8wquxAgb/E52x8rfNbZVXywQAA9/42JxhX69T1mEhFaO135dmfJD8NQFn8XrOAtTO3tDtnaiyiqC9+B7bovtnWvHs7xgJ7AFURYWK5Jf8qWmHf6zeDUj7/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqaOCqnO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b06d162789so76937681cf.2;
        Wed, 13 Aug 2025 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093449; x=1755698249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFkut+jxkX2kCL0o1G+AwY8Knubz8aROAdKPd/K2Kek=;
        b=lqaOCqnOXmg1mm9Q924sZ+VdmMfcdRJw0mAiG5EgnyziieF41htFRgOEpyfiavnJbT
         JJDXidiKtnn4Y2CIr13XaXLpspr8xVqR6jx8WYwMaDjvZN5iD2hSaeGJav/Qw60hiHJf
         kCZ0JkTrojQR7Vp3eddzVYDWjpxq7imXdEm2+YBDxUVuhKBsDmucFePsjhwg19GU+ZxH
         +rz8oFk2FUzIB4SCxCsK7hOpGbSWhgJ3PiehyCQ8A6OnyGFXnJHQ4bQOSaaO8ycawKue
         4znVsGRQMHBYpFxPqoL5egG3dssqWqS0NeFe+RLgQhDo+8arE02TrYrgf6NbsdQxyQIZ
         uepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093449; x=1755698249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFkut+jxkX2kCL0o1G+AwY8Knubz8aROAdKPd/K2Kek=;
        b=nFpoeCI9kOXCGq/wvNcn4/ltRaAlGTjintyUF/8KwkzVkRfGeAOzypfgImeCV2sOO+
         NlrZ0v/i1xpasoFsPbXqkuHj6d1k9SYaGoS5B83nBFeMLrAtGap0gi3YV/queBmoPHYl
         5PohntIqnC64UTTJLO/+rLzbQDG2UnjH0DUAUZRuJTVOvZr6b9XCGSJiQJwEgkCjzQMt
         jEqKHWEraUFUuoJQxpB/0AEhBe8IwZy4/cwC08Q096QyNo4gae0IDmwgCzKInntR2ARL
         XTzEEFyHlfDOUu86KYgp3jr4vD0Jeex8P6pjIc/vCdqy5KcR4U0X6fgx1hORvYsb+0CA
         T3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUAGQh4fr6bhEt9vjc4zfYWkKC6M0Ud/cG0iLHDLWn8RZ73k5mwTWhuz6/Juyze2npujJEVDG68Qpk+Cc8h@vger.kernel.org, AJvYcCXpI+MHth3hIDSGIB7PUrsS8HsbFRxwQzF3yPGyHOc8u9Nca5nyOOzYSuTLEmXajIHXWom4anf99Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPx76ESTAGApg5xk7zL44B1ImzRm5aw4fZeQTCEZY0FsO0gDm
	5otnZg0hDipErIl3yKbn0oKIH5mVTFWHup5H3IEgbg1RYMk7Obmy+MdL
X-Gm-Gg: ASbGncuf0YgY3s3tlr2IJkgBwjmp0NCqyetUFyfoLUUua3ExO4S7gg0/IbXdASa7H5R
	5+7fw2vtrR0T05qgugeVvHekfk10j57dhiZz5x0GyouBwm66xB1DmRUZqbWUte99kzl4OVJ0Zm2
	piB/YVR7D8fcELXcSUTAB73z7nYQlx5IpKmQ9VoZypfiIBpHijCluz/9t2UmviXkoxgmGa4Iuef
	reoK7BIXvB9zVXjCNnadsjtVnW/9x0w+v/QbUTHRrATA+3OYUw5VJl+rKzmPc4P82R0pqYE4S9T
	dYsBfJ+ATrjjl2yqCiRgi8D220J7ZqHkmIV3ahnGUEIjleE2eG+BuoJ54RzXcThBv0Gs/X0TIy4
	7RfY04jjb5EFtJqULn9dqnaVnx8yrTz4=
X-Google-Smtp-Source: AGHT+IFpUulFAXexVGcZ3RSnDMGaetHyokWl7LRdgFy0lzYI/f7M0RHgQ7IVBpy0qRTidvun+fcyKg==
X-Received: by 2002:ac8:690b:0:b0:4b0:69ff:eb71 with SMTP id d75a77b69052e-4b0fc68bc8cmr45578351cf.1.1755093448790;
        Wed, 13 Aug 2025 06:57:28 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce39fb3sm195578986d6.82.2025.08.13.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:28 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 1/7] prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
Date: Wed, 13 Aug 2025 14:55:36 +0100
Message-ID: <20250813135642.1986480-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813135642.1986480-1-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

People want to make use of more THPs, for example, moving from
the "never" system policy to "madvise", or from "madvise" to "always".

While this is great news for every THP desperately waiting to get
allocated out there, apparently there are some workloads that require a
bit of care during that transition: individual processes may need to
opt-out from this behavior for various reasons, and this should be
permitted without needing to make all other workloads on the system
similarly opt-out.

The following scenarios are imaginable:

(1) Switch from "none" system policy to "madvise"/"always", but keep THPs
    disabled for selected workloads.

(2) Stay at "none" system policy, but enable THPs for selected
    workloads, making only these workloads use the "madvise" or "always"
    policy.

(3) Switch from "madvise" system policy to "always", but keep the
    "madvise" policy for selected workloads: allocate THPs only when
    advised.

(4) Stay at "madvise" system policy, but enable THPs even when not advised
    for selected workloads -- "always" policy.

Once can emulate (2) through (1), by setting the system policy to
"madvise"/"always" while disabling THPs for all processes that don't want
THPs. It requires configuring all workloads, but that is a user-space
problem to sort out.

(4) can be emulated through (3) in a similar way.

Back when (1) was relevant in the past, as people started enabling THPs,
we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
yet (i.e., used by Redis) were able to just disable THPs completely. Redis
still implements the option to use this interface to disable THPs
completely.

With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
workload -- a process, including fork+exec'ed process hierarchy.
That essentially made us support (1): simply disable THPs for all workloads
that are not ready for THPs yet, while still enabling THPs system-wide.

The quest for handling (3) and (4) started, but current approaches
(completely new prctl, options to set other policies per process,
alternatives to prctl -- mctrl, cgroup handling) don't look particularly
promising. Likely, the future will use bpf or something similar to
implement better policies, in particular to also make better decisions
about THP sizes to use, but this will certainly take a while as that work
just started.

Long story short: a simple enable/disable is not really suitable for the
future, so we're not willing to add completely new toggles.

While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
completely for these processes, this is a step backwards, because these
processes can no longer allocate THPs in regions where THPs were
explicitly advised: regions flagged as VM_HUGEPAGE. Apparently, that
imposes a problem for relevant workloads, because "not THPs" is certainly
worse than "THPs only when advised".

Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
would change the documented semantics quite a bit, and the versatility
to use it for debugging purposes, so I am not 100% sure that is what we
want -- although it would certainly be much easier.

So instead, as an easy way forward for (3) and (4), add an option to
make PR_SET_THP_DISABLE disable *less* THPs for a process.

In essence, this patch:

(A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
    of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).

    prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED).

(B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
    PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.

    Previously, it would return 1 if THPs were disabled completely. Now
    it returns the set flags as well: 3 if PR_THP_DISABLE_EXCEPT_ADVISED
    was set.

(C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
    the semantics clearly.

    Fortunately, there are only two instances outside of prctl() code.

(D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
    with VM_HUGEPAGE" -- essentially "thp=madvise" behavior

    Fortunately, we only have to extend vma_thp_disabled().

(E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are
    disabled completely

    Only indicating that THPs are disabled when they are really disabled
    completely, not only partially.

    For now, we don't add another interface to obtained whether THPs
    are disabled partially (PR_THP_DISABLE_EXCEPT_ADVISED was set). If
    ever required, we could add a new entry.

The documented semantics in the man page for PR_SET_THP_DISABLE
"is inherited by a child created via fork(2) and is preserved across
execve(2)" is maintained. This behavior, for example, allows for
disabling THPs for a workload through the launching process (e.g.,
systemd where we fork() a helper process to then exec()).

For now, MADV_COLLAPSE will *fail* in regions without VM_HUGEPAGE and
VM_NOHUGEPAGE. As MADV_COLLAPSE is a clear advise that user space
thinks a THP is a good idea, we'll enable that separately next
(requiring a bit of cleanup first).

There is currently not way to prevent that a process will not issue
PR_SET_THP_DISABLE itself to re-enable THP. There are not really known
users for re-enabling it, and it's against the purpose of the original
interface. So if ever required, we could investigate just forbidding to
re-enable them, or make this somehow configurable.

Acked-by: Usama Arif <usamaarif642@gmail.com>
Tested-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
---
 Documentation/filesystems/proc.rst |  5 ++-
 fs/proc/array.c                    |  2 +-
 include/linux/huge_mm.h            | 20 +++++++---
 include/linux/mm_types.h           | 14 +++----
 include/uapi/linux/prctl.h         | 10 +++++
 kernel/sys.c                       | 59 ++++++++++++++++++++++++------
 mm/khugepaged.c                    |  2 +-
 7 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2971551b72353..915a3e44bc120 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -291,8 +291,9 @@ It's slow but very precise.
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
- THP_enabled		     process is allowed to use THP (returns 0 when
-			     PR_SET_THP_DISABLE is set on the process
+ THP_enabled                 process is allowed to use THP (returns 0 when
+                             PR_SET_THP_DISABLE is set on the process to disable
+                             THP completely, not just partially)
  Threads                     number of threads
  SigQ                        number of signals queued/max. number for queue
  SigPnd                      bitmap of pending signals for the thread
diff --git a/fs/proc/array.c b/fs/proc/array.c
index c286dc12325ed..d84b291dd1ed8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
 
 	if (thp_enabled)
-		thp_enabled = !mm_flags_test(MMF_DISABLE_THP, mm);
+		thp_enabled = !mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 84b7eebe0d685..22b8b067b295e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -318,16 +318,26 @@ struct thpsize {
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
+/*
+ * Check whether THPs are explicitly disabled for this VMA, for example,
+ * through madvise or prctl.
+ */
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
 		vm_flags_t vm_flags)
 {
+	/* Are THPs disabled for this VMA? */
+	if (vm_flags & VM_NOHUGEPAGE)
+		return true;
+	/* Are THPs disabled for all VMAs in the whole process? */
+	if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, vma->vm_mm))
+		return true;
 	/*
-	 * Explicitly disabled through madvise or prctl, or some
-	 * architectures may disable THP for some mappings, for
-	 * example, s390 kvm.
+	 * Are THPs disabled only for VMAs where we didn't get an explicit
+	 * advise to use them?
 	 */
-	return (vm_flags & VM_NOHUGEPAGE) ||
-	       mm_flags_test(MMF_DISABLE_THP, vma->vm_mm);
+	if (vm_flags & VM_HUGEPAGE)
+		return false;
+	return mm_flags_test(MMF_DISABLE_THP_EXCEPT_ADVISED, vma->vm_mm);
 }
 
 static inline bool thp_disabled_by_hw(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 47d2e4598acd6..3b369dfbbedd6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1781,19 +1781,17 @@ enum {
 #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
 #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
 
-/*
- * This one-shot flag is dropped due to necessity of changing exe once again
- * on NFS restore
- */
-//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
+#define MMF_HUGE_ZERO_FOLIO	18      /* mm has ever used the global huge zero folio */
 
 #define MMF_HAS_UPROBES		19	/* has uprobes */
 #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
 #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
-#define MMF_HUGE_ZERO_FOLIO	23      /* mm has ever used the global huge zero folio */
-#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_DISABLE_THP_MASK	_BITUL(MMF_DISABLE_THP)
+
+#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except when advised (e.g., VM_HUGEPAGE) */
+#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
+#define MMF_DISABLE_THP_MASK	(_BITUL(MMF_DISABLE_THP_COMPLETELY) | \
+				 _BITUL(MMF_DISABLE_THP_EXCEPT_ADVISED))
 #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index ed3aed264aeb2..150b6deebfb1e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -177,7 +177,17 @@ struct prctl_mm_map {
 
 #define PR_GET_TID_ADDRESS	40
 
+/*
+ * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
+ * is reserved, so PR_GET_THP_DISABLE can return "1 | flags", to effectively
+ * return "1" when no flags were specified for PR_SET_THP_DISABLE.
+ */
 #define PR_SET_THP_DISABLE	41
+/*
+ * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
+ * VM_HUGEPAGE).
+ */
+# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
 #define PR_GET_THP_DISABLE	42
 
 /*
diff --git a/kernel/sys.c b/kernel/sys.c
index 605f7fe9a1432..a46d9b75880b8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2452,6 +2452,51 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
 	return sizeof(mm->saved_auxv);
 }
 
+static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (arg2 || arg3 || arg4 || arg5)
+		return -EINVAL;
+
+	/* If disabled, we return "1 | flags", otherwise 0. */
+	if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm))
+		return 1;
+	else if (mm_flags_test(MMF_DISABLE_THP_EXCEPT_ADVISED, mm))
+		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
+	return 0;
+}
+
+static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
+				 unsigned long arg4, unsigned long arg5)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (arg4 || arg5)
+		return -EINVAL;
+
+	/* Flags are only allowed when disabling. */
+	if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
+		return -EINVAL;
+	if (mmap_write_lock_killable(current->mm))
+		return -EINTR;
+	if (thp_disable) {
+		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
+			mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
+			mm_flags_set(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
+		} else {
+			mm_flags_set(MMF_DISABLE_THP_COMPLETELY, mm);
+			mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
+		}
+	} else {
+		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
+		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
+	}
+	mmap_write_unlock(current->mm);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2625,20 +2670,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		return task_no_new_privs(current) ? 1 : 0;
 	case PR_GET_THP_DISABLE:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = !!mm_flags_test(MMF_DISABLE_THP, me->mm);
+		error = prctl_get_thp_disable(arg2, arg3, arg4, arg5);
 		break;
 	case PR_SET_THP_DISABLE:
-		if (arg3 || arg4 || arg5)
-			return -EINVAL;
-		if (mmap_write_lock_killable(me->mm))
-			return -EINTR;
-		if (arg2)
-			mm_flags_set(MMF_DISABLE_THP, me->mm);
-		else
-			mm_flags_clear(MMF_DISABLE_THP, me->mm);
-		mmap_write_unlock(me->mm);
+		error = prctl_set_thp_disable(arg2, arg3, arg4, arg5);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
 	case PR_MPX_DISABLE_MANAGEMENT:
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 550eb00116c51..1a416b8659972 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 {
 	return hpage_collapse_test_exit(mm) ||
-		mm_flags_test(MMF_DISABLE_THP, mm);
+		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
 }
 
 static bool hugepage_pmd_enabled(void)
-- 
2.47.3


