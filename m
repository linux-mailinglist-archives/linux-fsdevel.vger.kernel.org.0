Return-Path: <linux-fsdevel+bounces-49040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C825AB79B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289FA3AAD69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344A242D9F;
	Wed, 14 May 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lp/9Cau2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0D241662
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266203; cv=none; b=gQZN788QrjibI57mxDocwq0HyzPtDbv9XAMX3tV3lHWMgp6CCq/3h+mUgzIF2k8KBqoyu21caeKpPtH34rMOko8Jdspq42OfbO2Qmints7xGQqqwRnSUYJhHMKbgMByj1G3qBk5+npcsJFTU4Grv+Oo9OC8fi39nMrPnMZ4edeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266203; c=relaxed/simple;
	bh=01nWvfWOqpjLSNin0f5MozA8ay58nO5pCUzg1VWRoWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKzgZc2OFRz6ijZ3KCup97RS3gm3Bz7iTKLay21/1v/K+CTqr9RnewB8szFnUBjWEUfT6niNL6njU6BD7ddZlHh1R+Oz6qHkvNy1MLugP0dtyr4REAXLqKynH532FbK8M49RZiIEPtUNuyAFnmdbQcA+ab/miBr1FHsrkMc62a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lp/9Cau2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22fc89a08d0so3232695ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266200; x=1747871000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ANgzEKnFmEYy3Z3vGn+Lctns6AT0DlxBzYIgk/HcKs=;
        b=Lp/9Cau2UCYtt5sD9cyrTUv+qQ2HXUCcQ/tl9au/S5dARwBut9YAVf2HKDU04WWHwn
         V1xoIOMDZomvNGBWMG1lYm7JLyBBBqGejceLXPAcjXPjd0VPqKZR/TNYlOr4Kodu9BKM
         hU096IaHUllkFn6CJUDWJpUxwOffxyQTeKujyweR2cFgEl5cjWQGc37erHihJUVPrrEx
         CTzl04OJsNrKFnhLB8xFrY57dsVvAeUviViB91Q3dZ+R+MMbIr7da2y/ApdFB0S8Lisq
         XE8KvAnxgG9bWm2mmelwd/SOybtVzrRiH35vBXTD87oCzEb7NSwXFNz0+CMUbNGoKd2n
         zhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266200; x=1747871000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ANgzEKnFmEYy3Z3vGn+Lctns6AT0DlxBzYIgk/HcKs=;
        b=MZd9NOo9faYRJuiM15bBwuNOADIyoms9ILHUK4fG/UjslzgJBzbQIRwxsNsqG230WE
         Pm88bwwcKugm8YjNppJa0mD/PW8ozmi+27a72kg/MnZy1lIwzVrbJYIYds9SnmWGYH7I
         A+or4Uvt0GEruNkCyB7iipauCuQfcctp3Vw6S8SY8kGwFBvI7y5yYa5L/rV5WOSUjrcq
         97csYeoLEf+/I5YeZIB49PW91iZiaMH4aRKHrr/0G/NJPhNw417o4z8LSrsjloOB9kkl
         I1sQMJrKZxTIzB4spsllo1qoN0Fj46sjRjSRYHK+Tia7P7Z9jzO9f0nZmk306vmQShAA
         QA2g==
X-Forwarded-Encrypted: i=1; AJvYcCUg9vRMT1MbyyjJF/IlmCbNitzN0yPZ0+kJaVCdkx/SesAdhmhi1hKLVeaFCBmMoTMAocBmERI3GWSjoD2O@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsMK2l4CBcpI6gygTBgOwqvMQBW5B5JBFD8osaJAr6zV3cOWE
	9KXM+fbaP83qnbdgdSCJxDnd1pIX0URold83CGiPbeoP7NtXU5ApMxESPPV8RI6pmRNp+VK8r91
	hEpZsRdNZho5vIqUGeUv1zw==
X-Google-Smtp-Source: AGHT+IG3FjeJkDgm9Ms4EWnoaOoEWXfsjihW73xVKgzCGlB7gjrFDeuIA+VwVYTWTC4W+fpiL6H7gEsE4mtNiKz5/Q==
X-Received: from plblq11.prod.google.com ([2002:a17:903:144b:b0:231:9c86:58a1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5cb:b0:224:1943:c5c with SMTP id d9443c01a7336-231980dae09mr76459405ad.15.1747266200421;
 Wed, 14 May 2025 16:43:20 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:54 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <80cbdc463d3ee89b98e471e1f96f6739c903bc01.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 15/51] KVM: selftests: Update script to map shared
 memory from guest_memfd
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

Update the private_mem_conversions_test.sh script to use the -g flag
to also test conversions when both private and shared memory are
mapped from guest_memfd.

Change-Id: I16f8f6e4e5c361bbc4daeb66f15e8165db3d98f7
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/x86/private_mem_conversions_test.sh  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
index 76efa81114d2..5dda6916e071 100755
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
@@ -71,6 +71,9 @@ TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
                 $TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test
 		$TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
 
+                $TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -g
+		$TEST_EXECUTABLE -s "$src_type" -n $num_vcpus_to_test -m $num_memslots_to_test -g
+
 		{ set +x; } 2>/dev/null
 
 		echo
-- 
2.49.0.1045.g170613ef41-goog


