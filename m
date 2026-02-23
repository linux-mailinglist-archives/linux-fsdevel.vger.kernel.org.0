Return-Path: <linux-fsdevel+bounces-77908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLp5LAb9m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:08:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27C1728E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59AF306C7CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458534D4FD;
	Mon, 23 Feb 2026 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3osSZSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400634CFDE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830299; cv=none; b=WpMGSMOmD36r4btrrY3yoRYM1lO4i73akJ+6ehYqtaTrdOn6Fy/5dmA3w0EWirDmk34extUBdJ3nMFW5Ox30U/3QN5HZeGSzrHg8llU0LLM8/DTwezjg6wdyTJ5vseSvXjKEZUMhrWkc9wsi/KRpO24NVa/X9QepiwbNacXg6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830299; c=relaxed/simple;
	bh=jE9SWcy5OcAaB03+1AxluJ85cRuAv6Q4+ACJtj/hcCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbXT1cwLVWUnGjXltErpZEAYXhKVFgNZ723rhuAAFsZQWCjIw4px2IIc0ZKDkJXg30gHkBEuWKpoM/ESFsod3RIgNocw1K5HHS6mA/hJfUI//Q0BH28dSYFu/K/+UVNu1VECI1ZnJvCL6UJXgnaekvVNO2CUJP7qcq8aZi0KjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3osSZSX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8244d786b23so1534187b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830298; x=1772435098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZVo84a8gYXfxb6fQudIUthBz+u2OhxnqcpBYF66SVE=;
        b=d3osSZSXLUzwXIA1idTDrF+7M6NOyz6EO9RGsDR1p1iDWHQ23giSAoW5Aq9FrWYY+F
         f8fU7E5k3+zaTuOzRtSZiqiAGiLudiOHhAKWTf4tEyxbc2EXpK2J7iY3XSpvJSSxEU5H
         2RHt0a0zcwu+TbxmE9ownCbigw1TKukbKwpuosidUt5chrMcnEI8KsYLcXAnHOZwA6UV
         ogaZTYkIFHMGSgVJcLUZx8kTVFphXVy08ezXR+/I5k7O8W57+13InZqcZZ+tzxGgTgtT
         aC22sclknyrG+jd/U9P7l0TqGNN2N9H/5/4fHSSV8XMLLreyxxlnAYoCTtgg5qAm2NKV
         DDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830298; x=1772435098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZVo84a8gYXfxb6fQudIUthBz+u2OhxnqcpBYF66SVE=;
        b=U4D7ROGMzuRNGSg3A7XPjoGp1KhOoCE8IexQdVxV50ECoVGTTviEjrMikod4DWgCAD
         w6mic1ZgWe6GGcE3Nu8f0fOj59ACzLNCngJkUJdIfHRJILsknVItI7F13hy44FOcw0qT
         EPynaDrYNIVIvheqUClMYOcQIQhU8J3MCBr5fF98htkm7Fi2CuT8cxizOtFetRtPd4/8
         sTsUW7iYaJyc20/tBDJEeLoCvL+URApZKXx8OwnvMeZFMekE3obn1AGtUtS8GMKdLHtO
         tx8luNXcmGyIQr6uOjsjvdLv+z8Ps+ibDmTL0hwzO+yL88d0sZFK91WbIdT+WKszNM4t
         rZSg==
X-Forwarded-Encrypted: i=1; AJvYcCW+2gCsqZVMpe2hNAdItq0AXcn3y/WQrkv4y+ov2ZjXqXZV2z/ekUK6/KGXljXD3H9aFptvQW1qoBpRpQrw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3yrJsBHndHlIJBZ4eRmBDh55nND2TldktuEEVmViyogCcZm2
	1lG3BhsZHtHk8X+WTpCSxQl9pHIEttcK7RM9X1ECFsDRFdLROj2j8ir1ZqG8bhoBBzxtsFebVe9
	PzJHG8CkepZwr1AUppmcZKYSqpg==
X-Received: from pfbdf2.prod.google.com ([2002:a05:6a00:4702:b0:824:b56e:1181])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4ac1:b0:823:ad3:4ff4 with SMTP id d2e1a72fcca58-826daa0521bmr4935965b3a.37.1771830297745;
 Sun, 22 Feb 2026 23:04:57 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:38 +0000
In-Reply-To: <cover.1771826352.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771826352.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <45a3e4c00f4494c5f91aa1ccd9c400525a55ed45.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 05/10] mm: Export unmap_mapping_folio() for KVM
From: Ackerley Tng <ackerleytng@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org, 
	ackerleytng@google.com, seanjc@google.com, shivankg@amd.com, 
	rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77908-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F27C1728E1
X-Rspamd-Action: no action

guest_memfd needs a way to unmap a folio from all userspace processes. This
is required as part of a folio's truncation process. The function
unmap_mapping_folio() provides exactly this functionality.

Move its declaration from the internal mm/internal.h to the public
include/linux/mm.h and export the symbol.

unmap_mapping_folio() will be used by guest_memfd in a later patch to
implement a custom truncation function.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h | 2 ++
 mm/internal.h      | 2 --
 mm/memory.c        | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7f04f1eaab15a..97fa861364590 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2690,6 +2690,7 @@ extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
+void unmap_mapping_folio(struct folio *folio);
 void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows);
 void unmap_mapping_range(struct address_space *mapping,
@@ -2710,6 +2711,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	BUG();
 	return -EFAULT;
 }
+static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
diff --git a/mm/internal.h b/mm/internal.h
index f35dbcf99a86b..98351be76238b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -953,7 +953,6 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 struct anon_vma *folio_anon_vma(const struct folio *folio);
 
 #ifdef CONFIG_MMU
-void unmap_mapping_folio(struct folio *folio);
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
@@ -1131,7 +1130,6 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	return fpin;
 }
 #else /* !CONFIG_MMU */
-static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void mlock_new_folio(struct folio *folio) { }
 static inline bool need_mlock_drain(int cpu) { return false; }
 static inline void mlock_drain_local(void) { }
diff --git a/mm/memory.c b/mm/memory.c
index da360a6eb8a48..983bb25517cb7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/kvm_types.h>
 
 #include <trace/events/kmem.h>
 
@@ -4244,6 +4245,7 @@ void unmap_mapping_folio(struct folio *folio)
 					 last_index, &details);
 	i_mmap_unlock_read(mapping);
 }
+EXPORT_SYMBOL_FOR_KVM(unmap_mapping_folio);
 
 /**
  * unmap_mapping_pages() - Unmap pages from processes.
-- 
2.53.0.345.g96ddfc5eaa-goog


