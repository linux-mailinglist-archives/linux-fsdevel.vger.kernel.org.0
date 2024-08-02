Return-Path: <linux-fsdevel+bounces-24879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754AA9460ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216EA1F21DAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8495215C14F;
	Fri,  2 Aug 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWLVrXYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903611537DA
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614149; cv=none; b=noPWMRAuWlqV2Yzg9kaVwaVZFpDblZJ0qPprmaBCWtAshXUdsCGi6miOOez/CaJX5bsIEGx8uo7cnEkkJjtZx+M06uKxKgGM/jHQcgtvlYKyMM6loR74hRE56WCQo57XiHtoOywdZF93rFDV+zb/4JneLY5pI4HMPzk5mHBdpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614149; c=relaxed/simple;
	bh=yWrrysTviCd1i7aiL4my77/CM6Vr1IENrGtPRMboIWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAX9hYQrGkND0EnI1BuR82i4ZUg+EebaNN+Gq7ccpL71YDFSpbeMeo7Q8VkUfk7YCoiqqh9UCbAQUIo32VsvGF65poxWXEuq+un8CJIJhHcifaMFGJTTcPUPOobePNFYpuLVt23Ssk3EVY3Ab436AD2Nqlb4mPpHY/VKdqc6+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWLVrXYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBGeX8yYPmEXT+9EKnjIl4n92Yc2dlnMkDo/CXaQu2Y=;
	b=SWLVrXYLlD1mTkAKXyJKND/yYYDgQzGmHlG/uToQkS9yJZJ3Mk/DVh1H9NJJHEAN2Lp1ei
	DtrrwhztYAC/iWpmumSm101tMGJs+OvcAIxnPObXUtG4RdODp1rJu4zbemnaIti6OYWQHz
	aJYF9U0H6OjvwqQhOTizguwV19SPB0M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-3V3FyyZyMi6_6IaMXo6ocw-1; Fri,
 02 Aug 2024 11:55:42 -0400
X-MC-Unique: 3V3FyyZyMi6_6IaMXo6ocw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08A81955EB7;
	Fri,  2 Aug 2024 15:55:39 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90DD4300018D;
	Fri,  2 Aug 2024 15:55:33 +0000 (UTC)
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
Subject: [PATCH v1 01/11] mm: provide vm_normal_(page|folio)_pmd() with CONFIG_PGTABLE_HAS_HUGE_LEAVES
Date: Fri,  2 Aug 2024 17:55:14 +0200
Message-ID: <20240802155524.517137-2-david@redhat.com>
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

We want to make use of vm_normal_page_pmd() in generic page table
walking code where we might walk hugetlb folios that are mapped by PMDs
even without CONFIG_TRANSPARENT_HUGEPAGE.

So let's expose vm_normal_page_pmd() + vm_normal_folio_pmd() with
CONFIG_PGTABLE_HAS_HUGE_LEAVES.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4c8716cb306c..29772beb3275 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -666,7 +666,7 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 	return NULL;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
 {
-- 
2.45.2


