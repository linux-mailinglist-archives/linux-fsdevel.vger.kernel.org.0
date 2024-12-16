Return-Path: <linux-fsdevel+bounces-37505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B989F35A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FB1885281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944A1531F9;
	Mon, 16 Dec 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PtVxuleJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9714D6EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365578; cv=none; b=C4nZrSAfhKZnyVvzswObsRsy7q0NHDFI5Z0Lida5wQoLVEKxxkttxsV7Lwv+m0/YxhcLL+nVT/1RFzvSLxwxp6qZ+oJEfLmhdSs1HkxK7JmLumCAL/LGZeTYu8rXElK/7d4RxhFwWaLkLfBhxQlr+z7EIpGmdj0TWVI/4H8W2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365578; c=relaxed/simple;
	bh=XOAF2lEv3qdRbW0QxiyiB6A9nYjWu14cqTYC238yvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYdU1dRd4DAKOrUHlZRI4voKHoVAMNA/Iny6HoIZhdh6sCJK6xBPn5Kft4znJmNrO9kWZexiCuF1kE/so//IUC2OFXM/HV3cDiHYoewiXyRQNdUuMYwD48TlxIDeI29wYCx8zGKQruFZjDjhnsrqcn9qRabO/M+CXIFxIgrjK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PtVxuleJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=k/Aikfa9qgkLbilqbJTekFzoNO7qFSXxxQWLfy6xpXk=; b=PtVxuleJ6rp1rMQGfqDVmcqz+k
	gQMKozdCOS9VDdQ2vtIB09uBqqJiCqSLfCH0iD/fkCkXhdnNa/BtFb5i9YXBbNXGBt5EKP3DHb+WN
	OXZcyJuaM0QDGL5exG/xpomzumJr61FERAFi+CqNOxxxrIiilEUhDSx6p/AK/W1zz6lbGAuc0zOGu
	dM5UZmxFY/6qiXQGfmuREPgEE/23isCMv8INXILRgFLO3j4L1g+BvGFnSBSWyiTm9r/4Gt8xyqHws
	UPgV5EAoNKqOjjn9/gf9iM0w9yUaRNI22DEr16VYHGres0kauRlCrjo6zSV+Q5qRjZGwhxRi/J/Ub
	3QInib0A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDiI-000000009of-1wco;
	Mon, 16 Dec 2024 16:12:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] iov_iter: Remove setting of page->index
Date: Mon, 16 Dec 2024 16:12:50 +0000
Message-ID: <20241216161253.37687-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing actually checks page->index, so just remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/kunit_iov_iter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 13e15687675a..497d86e039f6 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -63,9 +63,6 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 		KUNIT_ASSERT_EQ(test, got, npages);
 	}
 
-	for (int i = 0; i < npages; i++)
-		pages[i]->index = i;
-
 	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
-- 
2.45.2


