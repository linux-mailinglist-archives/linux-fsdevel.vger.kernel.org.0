Return-Path: <linux-fsdevel+bounces-8973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823B83C8D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00767296848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968E130E4C;
	Thu, 25 Jan 2024 16:45:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3613666C;
	Thu, 25 Jan 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201143; cv=none; b=h4LxSFtrZtntpspJ+LU99Jsfd86oP4tqwpJCH+A6fe2tYw52CE3vF3xWXj/+7Ctll8Ph+1CIAMIAXzHWV5o5TmTYbS7qN6zVBVRD9/TL9y1Vkd9T13iVvRI0yV+2sq5uXlDsT/VQaEAFwQaaKqHmtPLjWjoLJBdLUiia33dSLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201143; c=relaxed/simple;
	bh=g16m8hwe2c+Kqfp9b9jwBFM1C8lWUj9Vnff3BFnKf5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWnG77qGLeXwfUya7CjIcGajInD3ArZCpcK4rPOA1lgVDTiUvvNNWHam9fz6f1AQgzbYM+p9fulrfIhKMtaZQbaY7mcU5EysY31Kv66GTI6ywDnHd0+hmMHnVR2MfDo6hNbfcmzExNaTmigdDM3i0FGUn2ICSxJdG2dMMVlil/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C361713;
	Thu, 25 Jan 2024 08:46:25 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D8E3F5A1;
	Thu, 25 Jan 2024 08:45:34 -0800 (PST)
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
Subject: [PATCH RFC v3 30/35] arm64: mte: ptrace: Handle pages with missing tag storage
Date: Thu, 25 Jan 2024 16:42:51 +0000
Message-Id: <20240125164256.4147-31-alexandru.elisei@arm.com>
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

A page can end up mapped in a MTE enabled VMA without the corresponding tag
storage block reserved. Tag accesses made by ptrace in this case can lead
to the wrong tags being read or memory corruption for the process that is
using the tag storage memory as data.

Reserve tag storage by treating ptrace accesses like a fault.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch, issue reported by Peter Collingbourne.

 arch/arm64/kernel/mte.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index faf09da3400a..b1fa02dad4fd 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -412,10 +412,13 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 	while (len) {
 		struct vm_area_struct *vma;
 		unsigned long tags, offset;
+		unsigned int fault_flags;
+		struct page *page;
+		vm_fault_t ret;
 		void *maddr;
-		struct page *page = get_user_page_vma_remote(mm, addr,
-							     gup_flags, &vma);
 
+get_page:
+		page = get_user_page_vma_remote(mm, addr, gup_flags, &vma);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			break;
@@ -433,6 +436,25 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
+
+		if (tag_storage_enabled() && !page_tag_storage_reserved(page)) {
+			fault_flags = FAULT_FLAG_DEFAULT | \
+				      FAULT_FLAG_USER | \
+				      FAULT_FLAG_REMOTE | \
+				      FAULT_FLAG_ALLOW_RETRY | \
+				      FAULT_FLAG_RETRY_NOWAIT;
+			if (write)
+				fault_flags |= FAULT_FLAG_WRITE;
+
+			put_page(page);
+			ret = handle_mm_fault(vma, addr, fault_flags, NULL);
+			if (ret & VM_FAULT_ERROR) {
+				err = -EFAULT;
+				break;
+			}
+			goto get_page;
+		}
+
 		WARN_ON_ONCE(!page_mte_tagged(page));
 
 		/* limit access to the end of the page */
-- 
2.43.0


