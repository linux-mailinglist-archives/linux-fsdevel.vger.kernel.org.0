Return-Path: <linux-fsdevel+bounces-3675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E587F7785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67FE1C210E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B12E844;
	Fri, 24 Nov 2023 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSBuLy+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8D19BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700839146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sUP0938eWxrh/qcHUeeo6YZetnQrjCIIyWqIBPJP/FA=;
	b=PSBuLy+otRIBqwjnDCFFN8NtaOdKxHHcPIhnEUTHLpVv08jVIn/h08OuKmDU9hKiRFTKU/
	KsgGYP732peyUzk3SYAl6Jq5zH2n3W43zmXgKlCG7J6HXoJRglZG4gTLirx0LYJT1V+g6B
	649/0/elvpV8zMKsitPeBmBs6/TuOl8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-E0TMX0MEMxmLOyg1bsgLjQ-1; Fri, 24 Nov 2023 10:19:05 -0500
X-MC-Unique: E0TMX0MEMxmLOyg1bsgLjQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a0921b293so4055626d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839144; x=1701443944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUP0938eWxrh/qcHUeeo6YZetnQrjCIIyWqIBPJP/FA=;
        b=up3N1tvS1PAOATVl6Yc2leRy2PgEajdwNGOlyg3jdjLKfBqUX6wlnVxzGA2maOFe+u
         7HM4S/mIZ3hij82ztNM/4muEU+Tr4S9h6P5hyxyelLz/JNcB76JAcgpfBjQlNg4XCB5e
         8WJjk5f8Bb69yrQhekFec/cyVlpW1Uf0uln6xT970jSXDl9wRChPQoFycXuUUyIf4nUW
         A3K2hG2nBqvJpY2c7V0d3gAFd8JgOpXFfQy0BFjJBMEP25FedEzJGBODCtu6kQKigRYe
         EUgWzrXNwsWqOpm8VuxJoREhG6GMFp1Hnro6o8Q9ubgI1MTYxy1XDJcNgWkXtaJ4suOH
         NBCw==
X-Gm-Message-State: AOJu0YxarWEyTjhOG/lhbuieTa+nJtuH7TPl7tNi1q0Zmf/vgrToWd/6
	9kTDIlb0WsjbMt9tKizkiKciCjCPGjHG//Sig9CaMiwokz0GfbFCXTPyUjeVyopMFuPW6nxQK0L
	Lqz1Mm2lx5GOy2KtnpjTpdoJuig==
X-Received: by 2002:a05:6214:e62:b0:679:dfc4:a5b with SMTP id jz2-20020a0562140e6200b00679dfc40a5bmr3427593qvb.5.1700839144712;
        Fri, 24 Nov 2023 07:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH65tZjZ4kmXbh/d9VdlWOCPV9PyBUVtyw/3egpKaKfZhkxUJBi3CqSgdCBKJPV4rh40sArzw==
X-Received: by 2002:a05:6214:e62:b0:679:dfc4:a5b with SMTP id jz2-20020a0562140e6200b00679dfc40a5bmr3427564qvb.5.1700839144350;
        Fri, 24 Nov 2023 07:19:04 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kr6-20020ac861c6000000b004180fb5c6adsm1339987qtb.25.2023.11.24.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:19:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/Kconfig: Make hugetlbfs a menuconfig
Date: Fri, 24 Nov 2023 10:19:02 -0500
Message-ID: <20231124151902.1075697-1-peterx@redhat.com>
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
into a menuconfig.  When moving it, fix a typo 'v' spot by Randy.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Fix a typo in the relevant area [Randy]
---
 fs/Kconfig | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index fd1f655b4f1f..0b404e61c80b 100644
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
@@ -266,22 +266,24 @@ config HUGETLBFS
 
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
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
+	  The HugeTLB Vmemmap Optimization (HVO) defaults to off. Say Y here to
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


