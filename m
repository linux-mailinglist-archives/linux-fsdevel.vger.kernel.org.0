Return-Path: <linux-fsdevel+bounces-21192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AE900367
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A381C21CF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7714194123;
	Fri,  7 Jun 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRxk4tnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C7193087
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763049; cv=none; b=tjRytffUApJxLc2cCmdSqv6jFNPisZRQ8kPO3+qt+KjlSgzpx797GzXTKMI5trhhLvduUy1sNAGQ3uF3SyOg6llGr5fad5XwguBOSZS3/FCWOB7wUMOyM9lihaEpaWtf7gELFKFplO69ktC2HsWRUgKRe2DKfp/Q9RAmQmlWFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763049; c=relaxed/simple;
	bh=kZIr6xLD60e+MbBbyqcbjS2T4bx3h666V+8zvgQT53s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9xvzRNuTmho4YPgGLEczm2GKWq8aXKH8OXlllIzMHlPgqzTbnZAEyuUAFmSUMAe1ciVbLoIQuaGxEctaIzIIry5rMFCWwMwpichU955hRK7Y96xFi8exXesjQ27rqbzA1YqMbPq2DbSMKy1qrH0lDKx9oyhpuOcG0zlMWzXsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRxk4tnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVo7IPc/OzMgdNcQVcdkp4iZHfQkhLNpmKtGDFarvnM=;
	b=PRxk4tnqHsjRsEXxkExpiWkDwBduySuvkgGcFoktzxRVlpv5LzwqovVKE2QLQ1vmjGujmv
	ZfDmJvpTsevPzWhR9+hj1UIDyTcQq6acY8buaQPZXQeQuXV2064famFw7w2C9PjzqFFEqE
	7I0flR4ajwo5cufY5Ag0lOPxqDkSbHo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-8Lw9Jl3kOiKOKhr_XOiSIg-1; Fri,
 07 Jun 2024 08:24:03 -0400
X-MC-Unique: 8Lw9Jl3kOiKOKhr_XOiSIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322EA3C025AC;
	Fri,  7 Jun 2024 12:24:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 569D9492BCE;
	Fri,  7 Jun 2024 12:24:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 1/6] fs/proc/task_mmu: indicate PM_FILE for PMD-mapped file THP
Date: Fri,  7 Jun 2024 14:23:52 +0200
Message-ID: <20240607122357.115423-2-david@redhat.com>
In-Reply-To: <20240607122357.115423-1-david@redhat.com>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Looks like we never taught pagemap_pmd_range() about the existence of
PMD-mapped file THPs. Seems to date back to the times when we first added
support for non-anon THPs in the form of shmem THP.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5aceb3db7565e..08465b904ced5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1522,6 +1522,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		}
 #endif
 
+		if (page && !PageAnon(page))
+			flags |= PM_FILE;
 		if (page && !migration && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
-- 
2.45.2


