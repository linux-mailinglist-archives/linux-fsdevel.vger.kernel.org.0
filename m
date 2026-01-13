Return-Path: <linux-fsdevel+bounces-73516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1861D1BAC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC8703040286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783A36AB6D;
	Tue, 13 Jan 2026 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ggUe5AZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC626B74A;
	Tue, 13 Jan 2026 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346032; cv=none; b=Tpbn1M8VLWMAp+Deg6zNq/FL/Opl46Q6o9h0dYkNocz7mxy3kUZz1+25Gy6sGhnqy3pozjGMxS/4YzZhbIiLaz6fUo45LqbD2C43EmE09IwCpxwG3SoEqx5IvnnPgkONt7tCZWuWOq+boqvDzyXk1aUXodbiFFdlMNsPYO50pAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346032; c=relaxed/simple;
	bh=pL6O0xc9qxnlWkXFaYtPJbO1YELosPyh9YQ4IOndaXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0UMEKJ3HRVh3mxxV2CA0TIoupQFHfITJyflUD6oUmMyLclcEgmwkwdk498gCb8Z0eIHkLy8i+dGh3ony03+GmEZn0JpLb+DK39tG9T7fZyr0QmPukUe5ldJMsPVV40S4avRyA3xJK8f1nqCltq/egHQf7zAs4KzZ8fH4vlOFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ggUe5AZi; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DJdo4X3597538;
	Tue, 13 Jan 2026 15:13:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6b8lhji3oxV30DYJl9hk8PPRW00E8IBcoZn7eC/2TZ0=; b=ggUe5AZiRPYJ
	M5Ht6Qu+EbaTJTqAcfGlNPDca8SGxU6MU7GhWm6lm6ZewM9R9nnjfnX5xZP5WOoa
	jUGkKFNIEghdQuCPqhFZdH5mlPP/AWFbU6Zl6ImP2U3xsqpXotxbrGj93ke/Bqsq
	lx5BJ6EXIPFE2tRKAt5eMwz4fZLsjuAGjugTsKC0E17iGNsGNSP5ZJy6TWvZqHpZ
	CuihkxRZUjjC6vLbbdyM8RMNdmT8vC1gqxp2zbCSzoM0nJxk4wNefdtkdVH0GWVt
	jt//M7N/POX8bCqn0BvU/eGc9OjOqWgTPOOQh2rcIiubinbgeFHQZ+ASUwftJQaY
	I6qeLCODHA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnqktmu4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 15:13:13 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 23:13:11 +0000
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam
 R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami
 Hiramatsu" <mhiramat@kernel.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato
	<pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v4 5/9] mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
Date: Tue, 13 Jan 2026 15:12:55 -0800
Message-ID: <20260113231257.3002271-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5d41b24e7bc622cda0af92b6d558d7f4c0d1bc8c.1763460113.git.lorenzo.stoakes@oracle.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=M89A6iws c=1 sm=1 tr=0 ts=6966d189 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=K3mAnt_iSIqV1N-OikAA:9
X-Proofpoint-GUID: 5-CcFQBuNngsaUgw3TgiRUAET30XzMDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4OCBTYWx0ZWRfX2DhGmdnpVK4A
 LH9faNP4/xk97+1ec61zl/gKesEZTMzKwF6k//6ncpB1RaeYymPjCSpxJ2jEETu4T6gnYwJtU54
 dCwogLU/Q5/xmR5fK6UN4t2MiJawyueXAkZxe2JhOIpCHtoLoChUAEp1Q978J5aUsRTT54fXXCb
 t//mqC+Wss6Uei+7zmlvdgyGai3YYItrHWylZL6bWh93e1NzYhgcrC8OwtP0uc4YaVy0xk0E/ew
 5lMnpZ5m1uEStBT0eIYFluWR8uKtLQGQZEljmswk8De8/R0v817ts8rGwdem4EtuzHqnXZpGUZt
 hJ2a+EgsGXYZ9brFHP5PkXFK9nJ55WexMz96w3yMLDjEJuyuVLlFzxoi3+ZP2CLDcdGo2YG543E
 vGDTJ5RNMtJMQcwkxZzJAqV3L09aYdLn+a2xisbuVVTHDsD2f7m1SCWF9PeLUo6Ka6XaKaNnEG/
 nKjXIdXrS1R7qgsJg0Q==
X-Proofpoint-ORIG-GUID: 5-CcFQBuNngsaUgw3TgiRUAET30XzMDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

On Tue, 18 Nov 2025 10:17:47 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Gather all the VMA flags whose presence implies that page tables must be
> copied on fork into a single bitmap - VM_COPY_ON_FORK - and use this
> rather than specifying individual flags in vma_needs_copy().
> 
> We also add VM_MAYBE_GUARD to this list, as it being set on a VMA implies
> that there may be metadata contained in the page tables (that is - guard
> markers) which would will not and cannot be propagated upon fork.
> 
> This was already being done manually previously in vma_needs_copy(), but
> this makes it very explicit, alongside VM_PFNMAP, VM_MIXEDMAP and
> VM_UFFD_WP all of which imply the same.
> 
> Note that VM_STICKY flags ought generally to be marked VM_COPY_ON_FORK too
> - because equally a flag being VM_STICKY indicates that the VMA contains
> metadat that is not propagated by being faulted in - i.e.  that the VMA
> metadata does not fully describe the VMA alone, and thus we must propagate
> whatever metadata there is on a fork.
> 
> However, for maximum flexibility, we do not make this necessarily the case
> here.
> 

Hi Lorenzo, one more from the review automation:

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fea113d1d723c..af2904aeb1631 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -555,6 +555,32 @@ extern unsigned int kobjsize(const void *objp);
>  */
> #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
>
> +/*
> + * Flags which should result in page tables being copied on fork. These are
> + * flags which indicate that the VMA maps page tables which cannot be
> + * reconsistuted upon page fault, so necessitate page table copying upon
> + *
> + * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
> + *                           reasonably reconstructed on page fault.
> + *
> + *              VM_UFFD_WP - Encodes metadata about an installed uffd
> + *                           write protect handler, which cannot be
> + *                           reconstructed on page fault.
> + *
> + *                           We always copy pgtables when dst_vma has uffd-wp
                                                           ^^^^^^^
The comment says "dst_vma" but the new code in vma_needs_copy() checks
src_vma->vm_flags. Is this intentional?

The old code checked userfaultfd_wp(dst_vma), which tests whether the
child VMA has VM_UFFD_WP set. After dup_userfaultfd() clears VM_UFFD_WP
from the child when !UFFD_FEATURE_EVENT_FORK, the old code would skip
page table copying since the child no longer needs uffd-wp protection.

The new code checks src_vma->vm_flags & VM_COPY_ON_FORK, which includes
VM_UFFD_WP. Since the parent VMA still has VM_UFFD_WP set, this will now
force page table copying even when the child has had VM_UFFD_WP cleared.

For file-backed VMAs (e.g., shmem) with uffd-wp but !UFFD_FEATURE_EVENT_FORK,
this appears to cause unnecessary page table copying where the old code
would have allowed the child to fault pages in fresh.

The call chain is:

    dup_mmap()
      -> vm_area_dup(mpnt)                  // child gets same flags
      -> dup_userfaultfd(tmp, &uf)          // may clear VM_UFFD_WP from child
      -> copy_page_range(tmp, mpnt)
           -> vma_needs_copy(dst_vma=tmp, src_vma=mpnt)

> + *                           enabled even if it's file-backed
> + *                           (e.g. shmem). Because when uffd-wp is enabled,
> + *                           pgtable contains uffd-wp protection information,
> + *                           that's something we can't retrieve from page cache,
> + *                           and skip copying will lose those info.
> + *
> + *          VM_MAYBE_GUARD - Could contain page guard region markers which
> + *                           by design are a property of the page tables
> + *                           only and thus cannot be reconstructed on page
> + *                           fault.
> + */
> +#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)

[ ... ]

> diff --git a/mm/memory.c b/mm/memory.c
> index d1728d0538d64..27bc457b32c2e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1463,25 +1463,15 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> static bool
> vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> {
> +	if (src_vma->vm_flags & VM_COPY_ON_FORK)
        ^^^^^^^^
Was the change from checking dst_vma to src_vma for VM_UFFD_WP intentional?

The old code was:

    if (userfaultfd_wp(dst_vma))
        return true;

which expanded to:

    if (dst_vma->vm_flags & VM_UFFD_WP)
        return true;


