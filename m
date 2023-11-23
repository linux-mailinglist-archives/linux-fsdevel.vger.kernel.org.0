Return-Path: <linux-fsdevel+bounces-3564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371E7F6910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F512818B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7713FFE;
	Thu, 23 Nov 2023 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqBo9D1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9704A1B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700779173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uxvMU/Xo7MVeCzgBFSVtpLXkJ+M09hdrAxYgaD5WzoM=;
	b=bqBo9D1GQbQTfWyBjiMq8BjVmYXzKgT+sNqENpXefUnQ3LrIPZjCho2tGSF/yIDTtRHaX4
	7LSbEqQlBu8JWEtbvirFk7HnYBOJFnkEzWIgq0MSUHhdNAOnCqrzyMhvfYm2Bnl29Gknom
	o3zEqj+PisH4a5Vy6FuyL8oUemIZmqY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-M5LHOwqwM6KO6n1EbfYr2w-1; Thu, 23 Nov 2023 17:39:32 -0500
X-MC-Unique: M5LHOwqwM6KO6n1EbfYr2w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-679d8383224so3241736d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 14:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700779172; x=1701383972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxvMU/Xo7MVeCzgBFSVtpLXkJ+M09hdrAxYgaD5WzoM=;
        b=WOF4ka48R+4cm6ueHT/W4k8sNTH36OIP15HIfkR0lK9kEneJuB6DKoeaADp3zBRnRY
         GP8Hr+ocFsgWhHIEJXlf/zmFCEfifzuv+HQkk+ixh3ZHBWAP/4/JrYBvjId1aWBLppbN
         NpGjGs11HkD6CEy513LjTNoDIh7F6jZX5BPCPRNmMbrt9dAuMg0EqdPNTngwqiM0JgJw
         xBYzMI+gBywETkLVgUW2jusU66f2JA/KwgevnbsxmHjSDlLTb+UFbaX22b2RS8euDIe/
         zqBw9shf8paLtXEAdzVSpsNdthsnvx856Sfthx32OFAhSPbHgFTwU9hlqJ6O34ecx1wA
         MiWg==
X-Gm-Message-State: AOJu0YyUcabCAiLkqh/rbqQlLvZXhDXmkytFYczYfqu9a8Z5s+J/IqIr
	3AeFCLLxbEG7uubpEUZUtdT0VhgK7BLXmxx52HnNaRStOoLo8iZclNgd9+zCkVA71vjKqOSB9Qx
	x+K52xpbI9gV1ABoR+D3Njvb2BoOSVT3Bog==
X-Received: by 2002:ad4:4242:0:b0:67a:11a9:e579 with SMTP id l2-20020ad44242000000b0067a11a9e579mr743242qvq.3.1700779171814;
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvUeYsikfky/jSIEaAUmbV6X8zYGpERKvvHbE6LK2W5XgyAicVdgusWE5DO059Yw/o9j2ixA==
X-Received: by 2002:ad4:4242:0:b0:67a:11a9:e579 with SMTP id l2-20020ad44242000000b0067a11a9e579mr743224qvq.3.1700779171591;
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id n11-20020ad444ab000000b0067a08bba0bbsm774131qvt.0.2023.11.23.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
Date: Thu, 23 Nov 2023 17:39:29 -0500
Message-ID: <20231123223929.1059375-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
itself, under "Pesudo filesystems".

Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
into a menuconfig.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index fd1f655b4f1f..8636198a8689 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -254,7 +254,7 @@ config TMPFS_QUOTA
 config ARCH_SUPPORTS_HUGETLBFS
 	def_bool n
 
-config HUGETLBFS
+menuconfig HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
@@ -266,14 +266,7 @@ config HUGETLBFS
 
 	  If unsure, say N.
 
-config HUGETLB_PAGE
-	def_bool HUGETLBFS
-
-config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	def_bool HUGETLB_PAGE
-	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
-	depends on SPARSEMEM_VMEMMAP
-
+if HUGETLBFS
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
 	default n
@@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
+endif # HUGETLBFS
+
+config HUGETLB_PAGE
+	def_bool HUGETLBFS
+
+config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
+	depends on SPARSEMEM_VMEMMAP
 
 config ARCH_HAS_GIGANTIC_PAGE
 	bool
-- 
2.41.0


