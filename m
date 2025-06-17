Return-Path: <linux-fsdevel+bounces-51909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54CADD014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C471889829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC351FF603;
	Tue, 17 Jun 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fswuEnnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833981F9A8B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170941; cv=none; b=pTNfm2quFRlYfDuwjetto8zUunfB460MB7KxjvMkr3MUq/kDyPlnWasc+Uxx4i7nRBoOK4Qyh02oJY4swYqXOweTC3D+mm0yeaoqc3fFX6DcsXv3UO2ZKdkpJ0RLghsYYCabI1f/8lEGvl1tv1aG6peM1XTC//eDNCBmoaDP/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170941; c=relaxed/simple;
	bh=FemY+hsQFrUD5ZAGM9NrybsPZvSowNvRmXOgYe8eQXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLRgLYwljqHRKB/gFb8PT2DZOx2UtUNRdfyNoHv/5Jjf53q3OyZpxtCcxpg6FIidm1S2JK3b1lUgFD+qSmUFpOmYW6GcRoiWA1+WHrhSZbKl9IyVomG26M/WcRQVg0UwFRYQdXK9chjmK3goS1cNhwP59/yxYjf8+fMV1B/5bNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fswuEnnH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750170937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jgNdlNRbfBs1E1Ur5QzUEwyVJhDqK+C7eqNF6/N6wfM=;
	b=fswuEnnHWgLDBD0CEeR1bzUFLXjVu0dISYUcWcpcNzTT9IlVBmEuAdFtfIyt/IpST7xxM3
	7Zl9aZV6CoJZBgyMKubSFgxz0CN17uTf4GQFQ+vNiQ/arKFJhXv9h2JwFjqA+vYvwPQdVo
	yqIE5GsVLRTnROWPQPnoqzKavZZD+Jg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0zefOsFXNYeL3FBEhr-Jhg-1; Tue, 17 Jun 2025 10:35:36 -0400
X-MC-Unique: 0zefOsFXNYeL3FBEhr-Jhg-1
X-Mimecast-MFC-AGG-ID: 0zefOsFXNYeL3FBEhr-Jhg_1750170935
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so37754295e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 07:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750170935; x=1750775735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgNdlNRbfBs1E1Ur5QzUEwyVJhDqK+C7eqNF6/N6wfM=;
        b=Q7f2GtA+wkIce2c097xCz2r60MOt82uqSCrqpk72FkgmCvNT3/syxIpAC0Zml3AkmS
         56A+UKIoig4kD0sP8LZom78oRn6LD7H1SrJNpMnqYmB6n1wTC5K3L3D4AnG9sE66iBw9
         OxjNL+Fb29sJVPYgN8fbKEk3LnJoQFhO0ZXPHMO9q5tr5+w0sZwYFKSMmYCXipcUGv36
         OW2FLtVrvtjo3BrzE5Mb1E25tqqFZ8aTukpxO7XTRSfR+xuzuTXVbuuvVLCcTdhs8se9
         rK6vVKr5MnLbvp7tz5GNlDBIYkky4miGuobBAM7IPNtagdRpTEb1H7k+RAS+0BLFL00o
         ccAQ==
X-Gm-Message-State: AOJu0YyciCKN0gi1/raXCPWNSh+d6BKX5c349qwPZ9dBrB9fAq3TOtiO
	Mskv8yUaIcEL/K5TeVPwyo84mb0Iwb/2OPzLrsVxz2izDmXCun4OU7Krw7aKOJ52xlcy1PQ0oo/
	t03uSRS/08klruXxij+wbQGZSUST4Zu6MKQ9qskr8hcyUkPvahfZ7lO1r28pCxI0/NjM=
X-Gm-Gg: ASbGncseNDh9pWudzOeey4IgUW6SFnivUCYA0/YJXxQAXMPrmRNblQZfJeEoAenNYm3
	gJNwHPjcytncAjQh00913/4ntecVkFOwSbW3eDd9YIHTzmOHCcSBC3EVQI0fmm0TLUfel//2iUR
	5oDxOkUEfvr4ct2fzOuekaUfrEtl6d7Cqt2EgA9Iu+6l6rnEfQIFpnUbPdeNAHLuR4L3gMXOXwv
	OPQj5zzC2NwbARh/Gn23VKBSE1j/SHblYfosMX/+Cmr3kU2wasiFyusSVnhV3wtze3VVUjL5ckh
	Sr+EJPzwM0Mn5JN3X7ZK4lE/3E0dMxsF5vGe89nh9x3E74FPFxWKkWf6r2auvjyKWOY3q0PQ8s9
	Y49OzCQ==
X-Received: by 2002:a5d:5c84:0:b0:3a4:f902:3845 with SMTP id ffacd0b85a97d-3a5723a261fmr11736169f8f.21.1750170934706;
        Tue, 17 Jun 2025 07:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkPKlpTmwMDIOZJAPGaDCPoTWf6kGLLVQZf/ykyAoEKvG2AJhCQQXS3FLdC7hGH+p405nNw==
X-Received: by 2002:a5d:5c84:0:b0:3a4:f902:3845 with SMTP id ffacd0b85a97d-3a5723a261fmr11736147f8f.21.1750170934317;
        Tue, 17 Jun 2025 07:35:34 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b47198sm13954565f8f.81.2025.06.17.07.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 07:35:33 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v1] fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for the huge zero folio
Date: Tue, 17 Jun 2025 16:35:32 +0200
Message-ID: <20250617143532.2375383-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_zero_pfn() does not work for the huge zero folio. Fix it by using
is_huge_zero_pmd().

Found by code inspection.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Probably we should Cc stable, thoughts?

We should also extend the pagemap_ioctl selftest to cover this case, but I
don't have time for that right now. @Muhammad ?

---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27972c0749e78..4be91eb6ea5ca 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2182,7 +2182,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 				categories |= PAGE_IS_FILE;
 		}
 
-		if (is_zero_pfn(pmd_pfn(pmd)))
+		if (is_huge_zero_pmd(pmd))
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
-- 
2.49.0


