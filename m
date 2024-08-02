Return-Path: <linux-fsdevel+bounces-24887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12701946117
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0748B23449
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94717E706;
	Fri,  2 Aug 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0TtLs3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20317E702
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614206; cv=none; b=Mzb4gEC8BurXdy65p/kAIiejJLsC3B7YB1/sIBXyqoRCxB0ECnBOn2tZXsqkrDWufO/jKOFcJMnmNh4+wZ4jypr9xvyqwSFCEj2RHz0W0HrTAiliewKg+VdMEfPbtU8pS9LSFsEjT6VJVx+ljrFQvIa6doqKO32xiWs4eh24bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614206; c=relaxed/simple;
	bh=D7p0bladQLZdcwqcqDuCFmY1nVG1fLgP938/gYuixF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUCCVHi+IWEd8TsqDrh0OqXMiBrFYFP4lkevqFDki1jW+NQKCWKSkO5NjH5qCiHsuEuQrhcePzQioc26Nz49kBte/5gkBkr/hgkEgz+1X9Ug0R8Xw7PqXzfC81BBQ+q+IBMd7qWroaeo1mHKTA5PB4UxhyO9QM5qGVn3/kASrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0TtLs3b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8hDUFeX9csW/JE1owVpjHxLVtzwb2VhQ3RSyvg6DEc=;
	b=f0TtLs3bjsEhCvNLIivKYozUU5WnT2Pqj0C+4rbhCMIul/xABTHy1PHyRcTF8PpLBaWjD6
	ew++LhdWIjzOju/JkkkCkIlU+wIfyP5aOFlJrYYN1uS88uQ95vHI57VYA4e+KKpZ5sfK6Q
	q1gj3VP1uQ5ks7NCNupmcLorSrutPb0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-xQRxca8hNvOMbFAn_7Ci0g-1; Fri,
 02 Aug 2024 11:56:36 -0400
X-MC-Unique: xQRxca8hNvOMbFAn_7Ci0g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C68619776D7;
	Fri,  2 Aug 2024 15:56:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD843300018D;
	Fri,  2 Aug 2024 15:56:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 09/11] s390/mm/fault: convert do_secure_storage_access() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:22 +0200
Message-ID: <20240802155524.517137-10-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's get rid of another follow_page() user and perform the conversion
under PTL: Note that this is also what follow_page_pte() ends up doing.

Unfortunately we cannot currently optimize out the additional reference,
because arch_make_folio_accessible() must be called with a raised
refcount to protect against concurrent conversion to secure. We can just
move the arch_make_folio_accessible() under the PTL, like
follow_page_pte() would.

We'll effectively drop the "writable" check implied by FOLL_WRITE:
follow_page_pte() would also not check that when calling
arch_make_folio_accessible(), so there is no good reason for doing that
here.

We'll lose the secretmem check from follow_page() as well, about which
we shouldn't really care about.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/fault.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 8e149ef5e89b..ad8b0d6b77ea 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -34,6 +34,7 @@
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/kfence.h>
+#include <linux/pagewalk.h>
 #include <asm/asm-extable.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
@@ -492,9 +493,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 	union teid teid = { .val = regs->int_parm_long };
 	unsigned long addr = get_fault_address(regs);
 	struct vm_area_struct *vma;
+	struct folio_walk fw;
 	struct mm_struct *mm;
 	struct folio *folio;
-	struct page *page;
 	struct gmap *gmap;
 	int rc;
 
@@ -536,15 +537,18 @@ void do_secure_storage_access(struct pt_regs *regs)
 		vma = find_vma(mm, addr);
 		if (!vma)
 			return handle_fault_error(regs, SEGV_MAPERR);
-		page = follow_page(vma, addr, FOLL_WRITE | FOLL_GET);
-		if (IS_ERR_OR_NULL(page)) {
+		folio = folio_walk_start(&fw, vma, addr, 0);
+		if (!folio) {
 			mmap_read_unlock(mm);
 			break;
 		}
-		folio = page_folio(page);
-		if (arch_make_folio_accessible(folio))
-			send_sig(SIGSEGV, current, 0);
+		/* arch_make_folio_accessible() needs a raised refcount. */
+		folio_get(folio);
+		rc = arch_make_folio_accessible(folio);
 		folio_put(folio);
+		folio_walk_end(&fw, vma);
+		if (rc)
+			send_sig(SIGSEGV, current, 0);
 		mmap_read_unlock(mm);
 		break;
 	case KERNEL_FAULT:
-- 
2.45.2


