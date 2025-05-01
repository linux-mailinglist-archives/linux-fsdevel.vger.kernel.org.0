Return-Path: <linux-fsdevel+bounces-47805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A7AA5A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CDC1C02045
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4E22FAE1;
	Thu,  1 May 2025 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Hbw8o5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849BCA4E;
	Thu,  1 May 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073039; cv=none; b=lSNVyLr4XhiDu8C3GsGI6AjDBfkqL3NIsNX0aToY057RUtAvWHcwA4XnU5hUhR5fSTS75hXr1TAbW5KgRM48SVC5hQ0tEIgwJieNGjGs2MBxAUwSCXWVGF5E+/uO7O77YTdTKWeTiyzKYE5Cpj+x+wQfY0V7KrE4vNl4naczvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073039; c=relaxed/simple;
	bh=6Uc/efFXmGs/JO4LOoqt4fg1j/FQiuh1BOAH74fuWDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9PPamz85TB+UQOXjMDBssNSRSwiV+VHa8hV1O+upQ84LRnyWIBRARg+dAppCsj/JSV1zlST/pBnT/6KepfjXhpux65t4RceBJ63h4hrvCK1x+BaMWG4jnj/Fg0NWGeXnp6DU51DP2dvVqUP2kRZkWLKF4fIDREhOVKmQt6/s1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Hbw8o5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7370a2d1981so484304b3a.2;
        Wed, 30 Apr 2025 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746073038; x=1746677838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSqWz+uwNyc71utyx5zA29Wqka9YgW7cUa1XkyvqWms=;
        b=J0Hbw8o5/3N6GgH6Pr/UINH5Icz//Ucb0wAP3JrkUXBguHhgZI/CIoSioxJSF6spDY
         4T1oYj60Bd8JRqBYuqt9yczaPsXLuEYfR4PbyNAPj868j/BjLCRCfG5GwIZmqRsSXteR
         NcfmN2iehDM7koPrfY5ooknpP39r6LKwwpf0zII3n4PbCEXJv5N7B8yqHsVOSaw4EhUR
         vbuh7u7CTSchTRvxqxmYkWX+DJ2KuE3IHW2GmTPE5wYUGYnFkfdeZT+BPFLRGrcmIi/r
         jPFG0/fcaKm9+ZAwYc0Mz1NpkEUg1Xy1tNXHsRwbEZs0DnaXC5rT1JyCXbz3K6neUkjW
         UMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746073038; x=1746677838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSqWz+uwNyc71utyx5zA29Wqka9YgW7cUa1XkyvqWms=;
        b=ncW0lAU7krWVRcw7t0pOLJd/3tCy4sY1CUlqk+wGv97RAXPEd6A6rS/mjUjSMe6hLq
         +FalIBmpyryc8Gyj2i8yJdEVw4k+2mTWpOITnVK0JV28dhS4ZMHD26ssYc5G15hskkME
         /6SS7dTMYY4nf+YEDaUuUopBTWFf5ybyuWz5KS6SaMowvVYZRz+Ry1qhY5sKZhNWft23
         njH9Te9JkADRu9LFF/CLhJFHwwxEFQwcys/flTsENBaB7kXsFLAifPqf7t27QpB0JIPI
         uG7KWOCrQalzorgzXra6DAfYYMhPGiuvX4kNx2KX9sdlnDToxum088Nquc2bQ85IKlpw
         nW4g==
X-Forwarded-Encrypted: i=1; AJvYcCUDzjbBqkThehVbAufasEhOAkm30TuRBOopDJYl6wAlPHQeOBPGNZyi/6heUUH3VpG3Znzf8OsE4PFv4XuY@vger.kernel.org, AJvYcCVi2SMgitMTg+AVaEyLdQODiqTRaDQbezSj6Vyi0cKBq715qNmDS9jCO+6audpl1kHaUPw0dfvGSaRcLgLW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PbCYSHCIKihEIdicSTEZ1mu+mRiy1NKk4n0EBd1marDI5zzg
	zhLuDntKBvJJ8uR3TrJVy/ANa+VCxU1i/1wIMWT/r/NFi3nmu5Ro
X-Gm-Gg: ASbGnct0ZsvwKZBPZ1ja9hnbGkPgw5QqnRNGUqAsYWv+C3CKcNpiWT7HXASD6zt8xic
	57rMmlS1tn8xXb9OE/tUEYChuqF37UnJkXjJkK7rznXCo0iEWRRa4xY4OpWVuBQkelRAZDImKQ2
	/4R/5kNo4Cq7yjcbeRK+W86BPzPMMOD8ZrdC+4WufDKKHU1aYRTD11oRGsi+goerinkhV/Qjdhv
	B3dZDzDeXNdhlt/4zebaSsa1bqud0rfx+V5C7K31NKpE7IxEL/844mRbPl8sHMD2/6lCeiljNO+
	5qHzgtJEANxqbj/H3rT42x8n5lUcgI323dV26bxoboRIx3Pt5SlQUbDNE+aUp13j
X-Google-Smtp-Source: AGHT+IHhhWhjtWqWjYhISbbYXlaaZG6J8Ta7drcMEv/LrBwlqg/TrkGMke/PM4xEXkJPcepQjnZfzg==
X-Received: by 2002:a05:6a21:1511:b0:203:becd:f9ce with SMTP id adf61e73a8af0-20ba8e4bbe9mr2663073637.39.1746073037614;
        Wed, 30 Apr 2025 21:17:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a30e50sm2548943b3a.119.2025.04.30.21.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:17:17 -0700 (PDT)
From: xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH v2 8/9] Documentation: add ksm_stat description in cgroup-v1/memory.rst
Date: Thu,  1 May 2025 04:17:13 +0000
Message-Id: <20250501041713.3324621-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

This updates ksm_stat description in cgroup-v1/memory.rst.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index d6b1db8cc7eb..a67e573c43d2 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -97,6 +97,8 @@ Brief summary of control files.
                                      used.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
+ memory.ksm_stat                     show the statistic information about various ksm
+                                     counters
  memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
                                      memory hard limit. Kernel hard limit is not
                                      supported since 5.16. Writing any value to
@@ -674,6 +676,40 @@ The output format of memory.numa_stat is::
 
 The "total" count is sum of file + anon + unevictable.
 
+.. _memcg_ksm_stat:
+
+5.7 ksm_stat
+------------
+
+When CONFIG_KSM is enabled, the ksm_stat file can be used to observe the ksm
+merging status of the processes within an memory cgroup.
+
+The output format of memory.ksm_stat is::
+
+  ksm_rmap_items <number>
+  ksm_zero_pages <number>
+  ksm_merging_pages <number>
+  ksm_profit <number>
+
+The "ksm_rmap_items" count specifies the number of ksm_rmap_item structures in
+use. The structureksm_rmap_item stores the reverse mapping information for
+virtual addresses.  KSM will generate a ksm_rmap_item for each ksm-scanned page
+of the process.
+
+The "ksm_zero_pages" count specifies represent how many empty pages are merged
+with kernel zero pages by KSM, which is useful when /sys/kernel/mm/ksm/use_zero_pages
+is enabled.
+
+The "ksm_merging_pages" count specifies how many pages of this process are involved
+in KSM merging (not including ksm_zero_pages).
+
+The "ksm_process_profit" count specifies the profit that KSM brings (Saved bytes).
+KSM can save memory by merging identical pages, but also can consume additional
+memory, because it needs to generate a number of rmap_items to save each scanned
+page's brief rmap information. Some of these pages may be merged, but some may not
+be abled to be merged after being checked several times, which are unprofitable
+memory consumed.
+
 6. Hierarchy support
 ====================
 
-- 
2.15.2



