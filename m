Return-Path: <linux-fsdevel+bounces-49074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FFAB7A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48197188840E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855AD26B94F;
	Wed, 14 May 2025 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xN3xVQ5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7E26AA83
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266255; cv=none; b=QR+Oi7iAcQ1gzg3jfSZeSpeZRpqCVA7cexnjLMhNT9W3PK7USxaZGBSJJKGOIUMxWB8Vj63OccV2CHUE7YaNYQxYz1T1ifVm5IfEkFRxzmZHFgQGMd9VEi02egYwKkc9pZCAU/YRCSnzymtkmaNqciVHYLm6leOkMbI2r7p13gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266255; c=relaxed/simple;
	bh=W4BuF5k7B7Tw/7iEJJF+2Dr7h9c8MMcjTfURTwwSkno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HQuT7ylLZCNq4tXvdNbvjoQsPBD2ZipO7c5qK1y2LlF7wBvjjeilowNXDOVzv/nXPqFqeS+r7/iy6vJttJpVaV4i01vCqfnz8LPd7CjLxq/ck7RO6wrkERSqwKyA4Qn5K4Bscbq/qTjHsPMJPzomk1E2AdcMyJhKcoNHKmvMJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xN3xVQ5M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c4b072631so348530a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266254; x=1747871054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgpRGOQjA/CW069YjbpUEsTR9l1DVf09U2PvTNruEdk=;
        b=xN3xVQ5MBlt7ING8YtP7kdoFTcQQYr+idO4YOSfyE8Ov36J/U2IVYS69BUq7bVUYvk
         BgUcHYh3wUgg+HuAv60t/SlMBOdOk4cGiJnIS0Ht5RH1DGVfbZ2sVTPn/vv/m44tInVj
         sghXHb0U4NYVnjbsFBqKd9Go64SNTHw+S5Ty10gTT+6bSQp5lXMl3eXVy16vTNcx8Loy
         sKlMvcW0WKkxHK8W50y8zkgqrH7QGGuoHNOrw2bMMWFaFsH81PApXdSLEJteHTaP+69r
         wh9fYBCV4naU0lR5QDBaDCFSGq85ixY16itXygSnvMzesmHzpaZm/nc1n/qkKDfXr2ty
         Yyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266254; x=1747871054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgpRGOQjA/CW069YjbpUEsTR9l1DVf09U2PvTNruEdk=;
        b=AZmrV+HwIjzf5kulsddlA5DWa5t578wN0+Tlxr/eB5WdHlF24Udz5kavLDnX7brJ06
         qBvrkPV5y2HUwVVMaKyA5DmkEDEQUnAOOhH8LhNQuZruz90ehspDxROf8jLfldBv1fQg
         LH9Q9iAdcezvbnx+L73iyMmKkAhyo+3D5Setd1v0ZJwNUqQyD+OKgui55pKRgidP7w4w
         jhzHwkrXpZoDC2lzc0feajN6C3VB80ofUD4KSvLxjVfwVJpmB5lwqk+elQ9chEKkIpbm
         Jj9k2f85EBStTWHgMNltvPeEBqTwTbmxPHaBEErviyKeB4jAc2iTvhfADdiH0z2ELQUh
         u0tw==
X-Forwarded-Encrypted: i=1; AJvYcCVDll0afZWpR0P8tHrgnYnp9hUlv1m68rBLs8SgAnsnIUa5kXYK+UD/PTaZhMAcA6h35SeZ64V4TYYZy8ff@vger.kernel.org
X-Gm-Message-State: AOJu0Yxanf94G9RGesr+dnsPIgQEfqpCnHKz67QmAMccKQcSwBbAg4p9
	zknt+VbHkPaUzGYenZmygGqyhOT0HipJfA0qCIhveH3tyccg0zGX6KByE7+xi6CyvG7D5Zot27K
	nuqIdSJM4IpnLq9BkLb1kXQ==
X-Google-Smtp-Source: AGHT+IGCW/uG3koL7ZmUpNQ3fu2bu9Qxb+Pwj1sAO0kEu9QYRpIBgr98bzhS9ZJB60f0G+PEHbBrD9llUcw4LLEWwA==
X-Received: from pjboh6.prod.google.com ([2002:a17:90b:3a46:b0:2f4:465d:5c61])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d4f:b0:2fe:a336:fe63 with SMTP id 98e67ed59e1d1-30e5190763cmr782897a91.24.1747266253599;
 Wed, 14 May 2025 16:44:13 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:28 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <d8cab3a09f541bebb327decc043d830da3384f9c.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 49/51] KVM: selftests: Update private_mem_conversions_test.sh
 to test with HugeTLB pages
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Update test script to also test HugeTLB support for guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Change-Id: I7c6cc25d6b86e1e0dc74018f46c7e2796fab6357
---
 .../kvm/x86/private_mem_conversions_test.sh   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
index 5dda6916e071..0d2c5fa729fd 100755
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
@@ -57,6 +57,17 @@ backing_src_types+=( shmem )
 	backing_src_types+=( shared_hugetlb ) || \
 	echo "skipping shared_hugetlb backing source type"
 
+private_mem_backing_src_types=( private_mem_guest_mem )
+[ -n "$hugepage_default_enabled" ] && \
+	private_mem_backing_src_types+=( private_mem_hugetlb ) || \
+	echo "skipping private_mem_hugetlb backing source type"
+[ -n "$hugepage_2mb_enabled" ] && \
+	private_mem_backing_src_types+=( private_mem_hugetlb_2mb ) || \
+	echo "skipping private_mem_hugetlb_2mb backing source type"
+[ -n "$hugepage_1gb_enabled" ] && \
+	private_mem_backing_src_types+=( private_mem_hugetlb_1gb ) || \
+	echo "skipping private_mem_hugetlb_1gb backing source type"
+
 set +e
 
 TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
@@ -66,17 +77,21 @@ TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
 
 	for src_type in "${backing_src_types[@]}"; do
 
-		set -x
+		for private_mem_src_type in "${private_mem_backing_src_types[@]}"; do
 
-                $TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test
-		$TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
+			set -x
 
-                $TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -g
-		$TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -m $num_memslots_to_test -g
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
 
-		{ set +x; } 2>/dev/null
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -g
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -m $num_memslots_to_test -g
 
-		echo
+			{ set +x; } 2>/dev/null
+
+			echo
+
+		done
 
 	done
 )
-- 
2.49.0.1045.g170613ef41-goog


