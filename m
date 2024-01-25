Return-Path: <linux-fsdevel+bounces-8959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B283C89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816E828AFE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5B13D500;
	Thu, 25 Jan 2024 16:44:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733A13472E;
	Thu, 25 Jan 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201061; cv=none; b=NnZb8Xg4qsqwaKV3MC7XYDP2kXNXbsnKP0FA4opRbv1zSECKXvYOEOsNJJo9AJrZiCLoIh79WwWMpP1Gko2668mEq4DMwHlakJ0o0BbfLqTImPHf/zUNSPm5WsJZIEOCrhc66NktvdK7DmyY63tilAZhFAx5NMlu1IuUBHVqVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201061; c=relaxed/simple;
	bh=kiyfnAGt1MV+rvONlOznWpR18xARO4HPqrDMRUk//ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnotwwQ4uQK6zuDW+j1mlzvyFdz20HWsSvJ1qTykoEJqbNeuPynuG0760O1DDD8Bz/AnWLtTFcxZTjXH4cdYaWVP1DgA3LxjVkw7qVCLe1GbhAnErPjM3ayatZrAkJEeEYGq6au7Xu2j7z5Jmpy2MEk2QQJH/CJqYvCYYjmyUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1168115DB;
	Thu, 25 Jan 2024 08:45:04 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211FF3F5A1;
	Thu, 25 Jan 2024 08:44:13 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 16/35] KVM: arm64: Don't deny VM_PFNMAP VMAs when kvm_has_mte()
Date: Thu, 25 Jan 2024 16:42:37 +0000
Message-Id: <20240125164256.4147-17-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to ARM DDI 0487J.a, page D10-5976, a memory location which
doesn't have the Normal memory attribute is considered Untagged, and
accesses are Tag Unchecked. Tag reads from an Untagged address return
0b0000, and writes are ignored.

Linux uses VM_PFNMAP VMAs represent device memory, and Linux doesn't set
the VM_MTE_ALLOWED flag for these VMAs.

In user_mem_abort(), KVM requires that all VMAs that back guest memory must
allow tagging (VM_MTE_ALLOWED flag set), except for VMAs that represent
device memory.  When a memslot is created or changed, KVM enforces a
different behaviour: **all** VMAs that intersect the memslot must allow
tagging, even those that represent device memory. This is too restrictive,
and can lead to inconsistent behaviour: a VM_PFNMAP VMA that is present
when a memslot is created causes KVM_SET_USER_MEMORY_REGION to fail, but if
such a VMA is created after the memslot has been created, the virtual
machine will run without errors.

Change kvm_arch_prepare_memory_region() to allow VM_PFNMAP VMAs when the VM
has the MTE capability enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes from rfc v2:

* New patch. It's a fix, and can be taken independently of the series.

 arch/arm64/kvm/mmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d14504821b79..b7517c4a19c4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2028,17 +2028,15 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (!vma)
 			break;
 
-		if (kvm_has_mte(kvm) && !kvm_vma_mte_allowed(vma)) {
-			ret = -EINVAL;
-			break;
-		}
-
 		if (vma->vm_flags & VM_PFNMAP) {
 			/* IO region dirty page logging not allowed */
 			if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
 				ret = -EINVAL;
 				break;
 			}
+		} else if (kvm_has_mte(kvm) && !kvm_vma_mte_allowed(vma)) {
+			ret = -EINVAL;
+			break;
 		}
 		hva = min(reg_end, vma->vm_end);
 	} while (hva < reg_end);
-- 
2.43.0


