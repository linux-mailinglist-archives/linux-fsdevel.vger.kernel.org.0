Return-Path: <linux-fsdevel+bounces-55579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D986AB0BFB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FD0168B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DF288C81;
	Mon, 21 Jul 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8QsdFRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FB1798F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088992; cv=none; b=VKZMehjr2BagmOg4iKa3PvSGjH+rtIVxj1RoyGq9/4/gMHlbGDq/IYWd3JHN/6nNLuFvwaVt7eBmP66AFbP0zdYd3IadFtgRR/+ueK6qgAh/NEpiVVSTSL58ElR25LNQoHmzL6dafvPJ6NwVIiQdd80lR8F52a/sWrTLMAMohrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088992; c=relaxed/simple;
	bh=Wa3FNnx2OnNWPflO9+BmCciJrxToLZxmHGGLzyuMWzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRYgh6rHDl4b66uNakGvZlFrlscioL/4KCZpLUuSPDPppasxwHucHFiqv0X1W7HWKRNW4+Xmn0IPnVh0mhKLiCdVQUr57v5GXb4rx29J26uq+ZWKKdAGdBC9SFj+bEq+MeavMTSh5c4F92oJGH5Fwbi8C/HvE3DUvE4/Zx5lk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8QsdFRK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753088989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7u6caywsLvYLuVxkpsdUT2qNKGKBBqyOD5l/+WUF5hI=;
	b=L8QsdFRKPHxW1BraM8D7ohmKsIIzkYTUxT3Q9XzsOGxzSrgiDUlJ3uu2m1ymkiKnl2R2YG
	JNTdIK4v93WGr33EWPYXu5syfQPR7o1PHuSS9q2CoSJZAbcXlQk3eZvtS3EVYDsE0QxW4N
	HpXV+1DFKieznN9UIngIcWVF/0NA2R8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-LjJ9c0DbPN65bums8b72ww-1; Mon, 21 Jul 2025 05:09:46 -0400
X-MC-Unique: LjJ9c0DbPN65bums8b72ww-1
X-Mimecast-MFC-AGG-ID: LjJ9c0DbPN65bums8b72ww_1753088985
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso36313155e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 02:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088985; x=1753693785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u6caywsLvYLuVxkpsdUT2qNKGKBBqyOD5l/+WUF5hI=;
        b=Z2/QyjEJIQA11Q1rlBRjjQHY3XhMllwVoAaHwtRnQ4AdOqbT0ZS8dk+nH3fuMrBeRE
         o45DnCg9trQZwSCrmjhpttviXoJR0FywILXa5C2lHNJZXPM/om4jtyvrVManSMcDNSjI
         ww8FT+dslQvdHH+E38U2uS1hcO4p44DBnnSxVRtD99KZ61KLpVNFrf/wZBSOTCWc5O2S
         9yuZynqI7rY8UmdVWNpcfOFZ9rHhHzuByMsRcZJmHBLm+NKlGra1oWgySi6KKfHKjmMo
         FUBqBDXgvaE5rLtEVEfDN1Gx1X2/XQAsrz8C9EemMKiyR54F9dMbpTf7/r92Up3ssCDA
         Jb+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXVLU0+rifTIwF52hAIKEE5T+3fNpxh6FN+8E8ZsUfCB2DI/wJw8rqUJ0joDD6+DM1lgwONyUT9btSCtLf@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtTocc/lnHsCZQcxk/YPycZE1M4B8uqYa+n3R9/JUsbm4Oz6r
	UB9INSwLVc25QxUo3Q21BPUQ7bNYI5VteFocv80q61uUz/RiXbxYJ5oPdw1kfmAhBzP4puBYN9X
	shTc7KbrZurXnQ8nxVPmGe6N57HJPcwNqFy0D7JnR0ChnV4OMAazZrITdcBOz0ABEOy0=
X-Gm-Gg: ASbGncufe2Xt188mMtQtQrQIc1eZ0/ORxpuHGllQMKqMcIDdge6JteQY4NkzJc3rf/Y
	Fb6Y07d0OOYrG/3yxOeLBntKwnylkag2FCUsx3IyAykyHK8FJ1j3RdPdRlyARzRNHQ/UVOkyiTN
	lHedeoOYFLAydwi6uw4jsomu/PM2nxG8QoM8d3L966kaQN82RT3/HOJsyDg0ijtZAAnKQa1yWia
	gj3RqSHN/d5hgMiqvC7QxVF4O2nRhrD5xMN7se5JFkmYbzZNQxejJWqSO4lfjnEVvUOyFiAvgWq
	Asv00l6p1Fu9OPBV+WjcCbEkeBwHV1tos8Sos9uzmuCs+JDT6aFOdEkHSpuldzCEmOf+geUCRex
	/gs2OPeQQpqKHkxNjdpBGOa8=
X-Received: by 2002:a05:600c:310a:b0:456:58e:318e with SMTP id 5b1f17b1804b1-4562e29c660mr198562065e9.30.1753088985026;
        Mon, 21 Jul 2025 02:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe98w4qflWkYM9Zg6Fz1StAofoZoYSsF8y704An1WPPyMZMujFAEA1iHOUaqnCNO3tWo5ofg==
X-Received: by 2002:a05:600c:310a:b0:456:58e:318e with SMTP id 5b1f17b1804b1-4562e29c660mr198561375e9.30.1753088984354;
        Mon, 21 Jul 2025 02:09:44 -0700 (PDT)
Received: from localhost (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca4d807sm9898705f8f.73.2025.07.21.02.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 02:09:43 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Usama Arif <usamaarif642@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Jann Horn <jannh@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
Date: Mon, 21 Jul 2025 11:09:42 +0200
Message-ID: <20250721090942.274650-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People want to make use of more THPs, for example, moving from
THP=never to THP=madvise, or from THP=madvise to THP=never.

While this is great news for every THP desperately waiting to get
allocated out there, apparently there are some workloads that require a
bit of care during that transition: once problems are detected, these
workloads should be started with the old behavior, without making all
other workloads on the system go back to the old behavior as well.

In essence, the following scenarios are imaginable:

(1) Switch from THP=none to THP=madvise or THP=always, but keep the old
    behavior (no THP) for selected workloads.

(2) Stay at THP=none, but have "madvise" or "always" behavior for
    selected workloads.

(3) Switch from THP=madvise to THP=always, but keep the old behavior
    (THP only when advised) for selected workloads.

(4) Stay at THP=madvise, but have "always" behavior for selected
    workloads.

In essence, (2) can be emulated through (1), by setting THP!=none while
disabling THPs for all processes that don't want THPs. It requires
configuring all workloads, but that is a user-space problem to sort out.

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
(completely new prctl, options to set other policies per processm,
 alternatives to prctl -- mctrl, cgroup handling) don't look particularly
promising. Likely, the future will use bpf or something similar to
implement better policies, in particular to also make better decisions
about THP sizes to use, but this will certainly take a while as that work
just started.

Long story short: a simple enable/disable is not really suitable for the
future, so we're not willing to add completely new toggles.

While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
completely for these processes, this scares many THPs in our system
because they could no longer get allocated where they used to be allocated
for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
problem for relevant workloads, because "not THPs" is certainly worse
than "THPs only when advised".

Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
would change the documented semantics quite a bit, and the versatility
to use it for debugging purposes, so I am not 100% sure that is what we
want -- although it would certainly be much easier.

So instead, as an easy way forward for (3) and (4), an option to
make PR_SET_THP_DISABLE disable *less* THPs for a process.

In essence, this patch:

(A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
    of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).

    For now, arg3 was not allowed to be set (-EINVAL). Now it holds
    flags.

(B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
    PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.

    For now, it would return 1 if THPs were disabled completely. Now
    it essentially returns the set flags as well.

(C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
    the semantics clearly.

    Fortunately, there are only two instances outside of prctl() code.

(D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
    with VM_HUGEPAGE" -- essentially "thp=madvise" behavior

    Fortunately, we only have to extend vma_thp_disabled().

(E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
    disabled completely

    Only indicating that THPs are disabled when they are really disabled
    completely, not only partially.

The documented semantics in the man page for PR_SET_THP_DISABLE
"is inherited by a child created via fork(2) and is preserved across
execve(2)" is maintained. This behavior, for example, allows for
disabling THPs for a workload through the launching process (e.g.,
systemd where we fork() a helper process to then exec()).

There is currently not way to prevent that a process will not issue
PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
to PR_SET_THP_DISABLE through another flag if ever required. The known
users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
that is not added for now.

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

---

At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
think there might be real use cases where we want to disable any THPs --
in particular also around debugging THP-related problems, and
"THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will
also block MADV_COLLAPSE, which can be very helpful. Of course, I thought
of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
I just don't like the semantics.

"prctl: allow overriding system THP policy to always"[1] proposed
"overriding policies to always", which is just the wrong way around: we
should not add mechanisms to "enable more" when we already have an
interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
weird otherwise.

"[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
setting the default of the VM_HUGEPAGE, which is similarly the wrong way
around I think now.

The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
similarly were around the "default for VM_HUGEPAGE" idea, but after the
discussion, I think we should better leave VM_HUGEPAGE untouched.

Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
we essentially want to say "leave advised regions alone" -- "keep THP
enabled for advised regions",

The only thing I really dislike about this is using another MMF_* flag,
but well, no way around it -- and seems like we could easily support
more than 32 if we want to, or storing this thp information elsewhere.

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

This is *completely* untested and might be utterly broken. It merely
serves as a PoC of what I think could be done. If this ever goes upstream,
we need some kselftests for it, and extensive tests.

[1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
[2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
[3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
[4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
[5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
[6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com

---
 Documentation/filesystems/proc.rst |  5 +--
 fs/proc/array.c                    |  2 +-
 include/linux/huge_mm.h            | 20 ++++++++---
 include/linux/mm_types.h           | 13 +++----
 include/uapi/linux/prctl.h         |  7 ++++
 kernel/sys.c                       | 58 +++++++++++++++++++++++-------
 mm/khugepaged.c                    |  2 +-
 7 files changed, 78 insertions(+), 29 deletions(-)

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
index d6a0369caa931..c4f91a784104f 100644
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
index e0a27f80f390d..c4127104d9bc3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -323,16 +323,26 @@ struct thpsize {
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
+/*
+ * Check whether THPs are explicitly disabled through madvise or prctl, or some
+ * architectures may disable THP for some mappings, for example, s390 kvm.
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
index 1ec273b066915..a999f2d352648 100644
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
+#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
+#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
+#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
+				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
 #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559a..1949bb9270d48 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -177,7 +177,14 @@ struct prctl_mm_map {
 
 #define PR_GET_TID_ADDRESS	40
 
+/*
+ * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
+ * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
+ * specified for PR_SET_THP_DISABLE.
+ */
 #define PR_SET_THP_DISABLE	41
+/* Don't disable THPs when explicitly advised (MADV_HUGEPAGE / VM_HUGEPAGE). */
+# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
 #define PR_GET_THP_DISABLE	42
 
 /*
diff --git a/kernel/sys.c b/kernel/sys.c
index b153fb345ada2..2a34b2f708900 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
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
+	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
+		return 1;
+	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
+		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
+	return 0;
+}
+
+static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
+				 unsigned long arg4, unsigned long arg5)
+{
+	unsigned long *mm_flags = &current->mm->flags;
+
+	if (arg4 || arg5)
+		return -EINVAL;
+
+	/* Flags are only allowed when disabling. */
+	if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
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
@@ -2596,20 +2640,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
index 8a5873d0a23a7..a685077644b4e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -427,7 +427,7 @@ static inline int collapse_test_exit(struct mm_struct *mm)
 static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
 {
 	return collapse_test_exit(mm) ||
-	       test_bit(MMF_DISABLE_THP, &mm->flags);
+	       test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
 }
 
 static bool hugepage_enabled(void)

base-commit: 760b462b3921c5dc8bfa151d2d27a944e4e96081
-- 
2.50.1


