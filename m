Return-Path: <linux-fsdevel+bounces-56402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8FB1712F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B73A7C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD92C159B;
	Thu, 31 Jul 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gubzsVOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238718F66;
	Thu, 31 Jul 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964915; cv=none; b=lrSipfoZA9dXX+JRiHiAmSqrVmMGhbM9t+Qoi/QF9VnHXjnYaB/dyhOmzOmn6OsKzEGpv/rEvModRChc9pMRsMRW4M2sOIZh9HQXXoI+vA24/P0MU8mIjFYsDRY1NYk21dtcV+3nQWytQvEplOfhcYvwvCf4Vlj6whqTYREgiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964915; c=relaxed/simple;
	bh=xZ9YZgIxzV1a7mKg/0oAROyV8ujWXIyeZMiyUcdlV70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TykiqvIDXTdaYIFhXf4Q9s2SCcQZ9IbsRpw6x+k8JirtuLoTzo5mJ/mSLcyZHUqv44/G2kr+CMW9fo5S4P9NkIQ3CBHFCUwsr94vQrQHBr5S/f3P9Lfig/+jhYaAozqGDGZOeumUBDHwYl+WKhfzJoSbjOG6AaWD/9vgK735xI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gubzsVOe; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e2e3108841so33875085a.3;
        Thu, 31 Jul 2025 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964912; x=1754569712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE+REDzqvLKoDrvawnxQmNnKD+qsH5pazW//69VuTHA=;
        b=gubzsVOe0EZDBy/yyY+tXsUUWSew1w8Ia/FA663sAgRoNidjKDhyKn1Ck4vhN2ckYh
         pDfCbXUDE6wMfxLQBWiiBqek6s85HNHJ7mE3kj0xqxbdB/OLDu6V10RVOuQQ/tR8DD+k
         iUSrD1Aq5G9OQXH4AFL9+YFaYTtnMFxqYJTpFOSmjZUfbbXD/n5C7p+CftaSakSuWtYe
         w620muPUhC/RvXhJQqpf+bYPiwgqvd9eaTaTjpiaUim9Ws1FMN9vWJii8GePFl78+zIV
         dryHpJjwKSNeVIM5ImbQFdfCqQ4pB0kq/0WDoGxRNWs+RUQoFZL4XF2cqxrnDPyF8XJA
         SIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964912; x=1754569712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE+REDzqvLKoDrvawnxQmNnKD+qsH5pazW//69VuTHA=;
        b=IknYWJMGwAspbYI7LtOfGAWnBcBUSFNQ/PQdR6Xl3jKtWbvFThCTycbBdxKaoBg4Rg
         Dv/jtedgTWEEngYsfg8JGRGCaDaXXt5ktB39ed7DUq3QNbw4xULDE7/NlnqSrMsidNIt
         7uXmtreEO1c96GV2IOzrs93uJL/bip0ehMmLWNRYlZBOgNcA5JbNmTH8ds0o1g1fRmxb
         zOq00ynzHO277+QXm32YmRzLGfwalDTacPSGAHsDwR/3wq60IdnF7qEgeY3IKNOJDrXk
         gAzevcLLM1jb4VQIzvTmWHFX6om9Acv1NSJY/mXzHYk0db3DTNcai+Oo9bDdc49wCEqU
         GiOw==
X-Forwarded-Encrypted: i=1; AJvYcCWH1hjd9lxTD4QdqZKV3/JE9pzQ7Nowre/wxFluD8oRYRnQ1ddOVdbteUrYXtKKt6cvp+uXaiV0BPg=@vger.kernel.org, AJvYcCWuW2tuEGzPwXzG08kJEfmR1FAYu4oLhyiZAUUL5u4gJQH2kKo2t/jSUK8mTRTiLNK3PHx10wgZyeOrEQd4@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4rbx0SgEjBUbqi7oazBvyQG8ZhxPEqOCn1wosTFgtiNJFiTH
	LWpXk+r/XZlFeyvWqJd5iEanUqNYPSPFEQhHmaa2wJO2RC5q6kmxH4bF
X-Gm-Gg: ASbGncvsdxhu7tDmPCfNB2c7un4SPqEfqww3/DZgEt95cNKCGiEIAJ3o+bEjlHtC7tW
	GT0Pv3ztJLbHs/KvSnJHXUx7nd9RtzCr6Wkv42AsHzTAnOmTv+fLhJrZ9CU0RsaXef8M3KnOwbK
	DYMPNsSsSvH/+qtK/ognpifgDDpiRHLgUo/QqFwQODTwtRiBpo2npGid24tAAYfIQshAh/A4Tw6
	J9bdUwx1zCFWxl/sF53t35VrrS0y7qWUmdkHBXKMtEyDaXJuBwHMZPRiDNeptq7WVGlxSF7FqqS
	lxR3V+oYrYRY86nFXk11g13Gy/f+fdEFSwnX3YtEm7f6MwiyE7xGXUIVKRSQ/RX2c8pK2hBxFK5
	9yl98XBrtA0FxLGyfiNPw
X-Google-Smtp-Source: AGHT+IH/cBB9x74cpkRu8HPZ/iEfhO8KlkDxbrmTcVNP2rihHZS8nQJ/U5x1SDYWYPt6bAWgldxMyg==
X-Received: by 2002:a05:620a:2846:b0:7e0:6402:bece with SMTP id af79cd13be357-7e66f0143efmr801145585a.38.1753964911599;
        Thu, 31 Jul 2025 05:28:31 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f598a0asm78995285a.6.2025.07.31.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:30 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
Date: Thu, 31 Jul 2025 13:27:18 +0100
Message-ID: <20250731122825.2102184-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731122825.2102184-1-usamaarif642@gmail.com>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
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
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

---

At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
think there might be real use cases where we want to disable any THPs --
in particular also around debugging THP-related problems, and
"never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
helpful for debugging purposes. Of course, I thought of having a
system-wide config option to modify PR_SET_THP_DISABLE behavior, but
I just don't like the semantics.

"prctl: allow overriding system THP policy to always"[1] proposed
"overriding policies to always", which is just the wrong way around: we
should not add mechanisms to "enable more" when we already have an
interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
weird otherwise.

"[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
setting the default of the VM_HUGEPAGE, which is similarly the wrong way
around I think now.

The ideas explored by Lorenzo to extend process_madvise()[3] and mctrl()[4]
similarly were around the "default for VM_HUGEPAGE" idea, but after the
discussion, I think we should better leave VM_HUGEPAGE untouched.

Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
we essentially want to say "leave advised regions alone" -- "keep THP
enabled for advised regions",

The only thing I really dislike about this is using another MMF_* flag,
but well, no way around it -- and seems like we could easily support
more than 32 if we want to (most users already treat it like a proper
bitmap).

I think this here (modifying an existing toggle) is the only prctl()
extension that we might be willing to accept. In general, I agree like
most others, that prctl() is a very bad interface for that -- but
PR_SET_THP_DISABLE is already there and is getting used.

Long-term, I think the answer will be something based on bpf[5]. Maybe
in that context, I there could still be value in easily disabling THPs for
selected workloads (esp. debugging purposes).

Jann raised valid concerns[6] about new flags that are persistent across
exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
consider it having a similar security risk as our existing
PR_SET_THP_DISABLE, but devil is in the detail.

[1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
[2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
[3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
[4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
[5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
[6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst |  5 ++-
 fs/proc/array.c                    |  2 +-
 include/linux/huge_mm.h            | 20 +++++++---
 include/linux/mm_types.h           | 13 +++----
 include/uapi/linux/prctl.h         | 10 +++++
 kernel/sys.c                       | 59 ++++++++++++++++++++++++------
 mm/khugepaged.c                    |  2 +-
 7 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2971551b7235..915a3e44bc12 100644
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
index d6a0369caa93..c4f91a784104 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
 
 	if (thp_enabled)
-		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
+		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..71db243a002e 100644
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
+	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
+		return true;
 	/*
-	 * Explicitly disabled through madvise or prctl, or some
-	 * architectures may disable THP for some mappings, for
-	 * example, s390 kvm.
+	 * Are THPs disabled only for VMAs where we didn't get an explicit
+	 * advise to use them?
 	 */
-	return (vm_flags & VM_NOHUGEPAGE) ||
-	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
+	if (vm_flags & VM_HUGEPAGE)
+		return false;
+	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
 }
 
 static inline bool thp_disabled_by_hw(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ec273b06691..123fefaa4b98 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1743,19 +1743,16 @@ enum {
 #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
 #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
 
-/*
- * This one-shot flag is dropped due to necessity of changing exe once again
- * on NFS restore
- */
-//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
+#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
 
 #define MMF_HAS_UPROBES		19	/* has uprobes */
 #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
 #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
-#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
-#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
+#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except when advised (e.g., VM_HUGEPAGE) */
+#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
+#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
+				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
 #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..9c1d6e49b8a9 100644
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
index b153fb345ada..932a8e637e78 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2423,6 +2423,51 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
 	return sizeof(mm->saved_auxv);
 }
 
+static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	unsigned long *mm_flags = &current->mm->flags;
+
+	if (arg2 || arg3 || arg4 || arg5)
+		return -EINVAL;
+
+	/* If disabled, we return "1 | flags", otherwise 0. */ 
+	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
+		return 1;
+	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
+		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
+	return 0;
+}
+
+static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
+				 unsigned long arg4, unsigned long arg5)
+{
+	unsigned long *mm_flags = &current->mm->flags;
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
+			clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
+			set_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
+		} else {
+			set_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
+			clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
+		}
+	} else {
+		clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
+		clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
+	}
+	mmap_write_unlock(current->mm);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2596,20 +2641,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		return task_no_new_privs(current) ? 1 : 0;
 	case PR_GET_THP_DISABLE:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
+		error = prctl_get_thp_disable(arg2, arg3, arg4, arg5);
 		break;
 	case PR_SET_THP_DISABLE:
-		if (arg3 || arg4 || arg5)
-			return -EINVAL;
-		if (mmap_write_lock_killable(me->mm))
-			return -EINTR;
-		if (arg2)
-			set_bit(MMF_DISABLE_THP, &me->mm->flags);
-		else
-			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
-		mmap_write_unlock(me->mm);
+		error = prctl_set_thp_disable(arg2, arg3, arg4, arg5);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
 	case PR_MPX_DISABLE_MANAGEMENT:
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1ff0c7dd2be4..2c9008246785 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 {
 	return hpage_collapse_test_exit(mm) ||
-	       test_bit(MMF_DISABLE_THP, &mm->flags);
+	       test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
 }
 
 static bool hugepage_pmd_enabled(void)
-- 
2.47.3


