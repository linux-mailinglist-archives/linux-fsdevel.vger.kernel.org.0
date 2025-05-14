Return-Path: <linux-fsdevel+bounces-49072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D6AB7A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423CE9E05FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF226A1BC;
	Wed, 14 May 2025 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WyHbWhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8B226CE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266253; cv=none; b=sdq6nAcAHrbTg1gX0aOdFJrv28dPonge873zQUtIbKZQG+RxNfZTn+OVDkmqDK/uR5KoHot/129jIrsePIT7UkRSLfMhszpIAzy21ohY/QTf5WimHZ8WUw7xubTJsthke9umQouEjy+RcAWPmnLyM6LtcBsLWFdur+qif6uCvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266253; c=relaxed/simple;
	bh=RmlnZgFdZqjzPPd7eIlteMHDS+xME2PjQiXp3qME9AU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fvVm6nggQZEIuSpSSL3uAHyX2Ds9eEnYlfSIMkLfKc1rKv/j/gZskBaHiDXJFBTAoRS2q2g4nd6h/fKPiMgav+jTfglL5KIRte43tBh/QawA0ZQqZPb0p7SVoYDBSIOakVyBKY9smVF4gQAnsHkN+yLbAeRti+Mm+viUi9k6YmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WyHbWhY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e50a45d73so2909165ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266250; x=1747871050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoLxnUTPsoaNLqVdaJcroJKZWfS4rkiGi/yftlVoHwU=;
        b=2WyHbWhYQDt9pMVrp4KMzh8C/L/7nug049ml7nsT3/+vLPQfD8C1Vali0Ytyuejs9Y
         i4dD3xuiFQTw0Dik0+kY7AfNmBeWdC913XiSMM1XL+5HjArG1dbX4gj0nC656WNiRrmz
         6SMAPaZYMTEZ5IiB9wga3DyCKkhFv2AileX0FkuFMVMTVoiMoxQmcYjWxMXbY0sBaDY+
         zonfamF00cOjoQL2LYb31AzUwR0CWOudIGbAiohw/xbpB6bRX3S3acpSM9t3KgitAHa4
         UdB7DjVFrW+jgFlcMFhQ7p25rFErb2DmZli7ms9Dy5MBY1NHmbstW4G+BsI4WF1wAnRf
         iKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266250; x=1747871050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoLxnUTPsoaNLqVdaJcroJKZWfS4rkiGi/yftlVoHwU=;
        b=I8HP0ukpcYwOvueXogYGqqO7ecTxjIGzGvZbXM00CvBNdjWyisGXEgdVJWmRmXn1GH
         TjGBvmvkvbCcXpg/LetlzTTb0BJoIfISTVF+9sLAkhzq2BoxT1syU53HA6tZkZa6kZ1V
         zr54Rads6aSd7zEIuDbga4OxkWshDAT8gHXTy65iH580t/8Gu4+fM+MC5bmT0s1wPtnQ
         5xSjHM7wE0VjKGCZgpcgIH1bWGwngg8RcyJJaoOjJt9zRHnRD6LM3FJCnGoO2L9ADQfy
         azRIKcc2TrYJEYGfK7Jlog5SnIFWl+481jj7UUeulmnwuBNY7WrEhoDa6Y+nSRsUQ9m0
         oKqA==
X-Forwarded-Encrypted: i=1; AJvYcCXgtwS7HR0HjLwvjrr5mFDJEgNRmoyfNGfsZf6pPxbLW/TPTolsI7cbdi/oSctNYQJe6LqCeRr2YnAQKSo3@vger.kernel.org
X-Gm-Message-State: AOJu0YyipfEJmyggD0HHjioPkrUln2sdmfQLKHitKWW6UrRj0dFgO5Mv
	2HTxFfp94eV7kge9zDx2LdriW5pyVScidtG8x/qwticq75pMkfnxxgZOT/4BpOwEvlqv8KMHyG4
	l6DpYjspzUb0D1GAw+iCw7A==
X-Google-Smtp-Source: AGHT+IHZbq2m2KZ1WT28Acy6uWBe7uvmxINNxxXuS4/4XNP8bRQlXVNAWhWbDMLmHfKnKz0cepkUgU78XTTuk1uhxw==
X-Received: from pgg17.prod.google.com ([2002:a05:6a02:4d91:b0:b1f:fba5:9aad])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce04:b0:22c:3294:f038 with SMTP id d9443c01a7336-231b5e3cf88mr5286885ad.18.1747266250517;
 Wed, 14 May 2025 16:44:10 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:26 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <e64fc10b654b0b97cddbcc3209ef40e1d73bfe48.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 47/51] KVM: selftests: Support various types of backing
 sources for private memory
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

Adds support for various type of backing sources for private
memory (in the sense of confidential computing), similar to the
backing sources available for shared memory.

Change-Id: I683b48c90d74f8cb99e416d26c8fb98331df0bab
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/include/test_util.h | 18 ++++-
 tools/testing/selftests/kvm/lib/test_util.c   | 77 +++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4a03784ac4f..bfd9d9a897e3 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -139,9 +139,19 @@ enum vm_mem_backing_src_type {
 
 struct vm_mem_backing_src_alias {
 	const char *name;
-	uint32_t flag;
+	uint64_t flag;
 };
 
+enum vm_private_mem_backing_src_type {
+	VM_PRIVATE_MEM_SRC_GUEST_MEM,  /* Use default page size */
+	VM_PRIVATE_MEM_SRC_HUGETLB,    /* Use kernel default page size for hugetlb pages */
+	VM_PRIVATE_MEM_SRC_HUGETLB_2MB,
+	VM_PRIVATE_MEM_SRC_HUGETLB_1GB,
+	NUM_PRIVATE_MEM_SRC_TYPES,
+};
+
+#define DEFAULT_VM_PRIVATE_MEM_SRC VM_PRIVATE_MEM_SRC_GUEST_MEM
+
 #define MIN_RUN_DELAY_NS	200000UL
 
 bool thp_configured(void);
@@ -154,6 +164,12 @@ int get_backing_src_madvise_advice(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+
+void private_mem_backing_src_help(const char *flag);
+enum vm_private_mem_backing_src_type parse_private_mem_backing_src_type(const char *type_name);
+const struct vm_mem_backing_src_alias *vm_private_mem_backing_src_alias(uint32_t i);
+size_t get_private_mem_backing_src_pagesz(uint32_t i);
+
 long get_run_delay(void);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 24dc90693afd..8c4d6ec44c41 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -15,6 +15,8 @@
 #include <sys/syscall.h>
 #include <linux/mman.h>
 #include "linux/kernel.h"
+#include <linux/kvm.h>
+#include <linux/guestmem.h>
 
 #include "test_util.h"
 
@@ -288,6 +290,34 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 	return &aliases[i];
 }
 
+const struct vm_mem_backing_src_alias *vm_private_mem_backing_src_alias(uint32_t i)
+{
+	static const struct vm_mem_backing_src_alias aliases[] = {
+		[VM_PRIVATE_MEM_SRC_GUEST_MEM] = {
+			.name = "private_mem_guest_mem",
+			.flag = 0,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB] = {
+			.name = "private_mem_hugetlb",
+			.flag = GUEST_MEMFD_FLAG_HUGETLB,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB_2MB] = {
+			.name = "private_mem_hugetlb_2mb",
+			.flag = GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_2MB,
+		},
+		[VM_PRIVATE_MEM_SRC_HUGETLB_1GB] = {
+			.name = "private_mem_hugetlb_1gb",
+			.flag = GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_1GB,
+		},
+	};
+	_Static_assert(ARRAY_SIZE(aliases) == NUM_PRIVATE_MEM_SRC_TYPES,
+		       "Missing new backing private mem src types?");
+
+	TEST_ASSERT(i < NUM_PRIVATE_MEM_SRC_TYPES, "Private mem backing src type ID %d too big", i);
+
+	return &aliases[i];
+}
+
 #define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
 
 size_t get_backing_src_pagesz(uint32_t i)
@@ -333,6 +363,22 @@ int get_backing_src_madvise_advice(uint32_t i)
 	}
 }
 
+size_t get_private_mem_backing_src_pagesz(uint32_t i)
+{
+	switch (i) {
+	case VM_PRIVATE_MEM_SRC_GUEST_MEM:
+		return getpagesize();
+	case VM_PRIVATE_MEM_SRC_HUGETLB:
+		return get_def_hugetlb_pagesz();
+	default: {
+		uint64_t flag = vm_private_mem_backing_src_alias(i)->flag;
+
+		return 1UL << ((flag >> GUESTMEM_HUGETLB_FLAG_SHIFT) &
+			       GUESTMEM_HUGETLB_FLAG_MASK);
+	}
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
@@ -369,6 +415,37 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
 	return -1;
 }
 
+static void print_available_private_mem_backing_src_types(const char *prefix)
+{
+	int i;
+
+	printf("%sAvailable private mem backing src types:\n", prefix);
+
+	for (i = 0; i < NUM_PRIVATE_MEM_SRC_TYPES; i++)
+		printf("%s    %s\n", prefix, vm_private_mem_backing_src_alias(i)->name);
+}
+
+void private_mem_backing_src_help(const char *flag)
+{
+	printf(" %s: specify the type of memory that should be used to\n"
+	       "     back guest private memory. (default: %s)\n",
+	       flag, vm_private_mem_backing_src_alias(DEFAULT_VM_PRIVATE_MEM_SRC)->name);
+	print_available_private_mem_backing_src_types("     ");
+}
+
+enum vm_private_mem_backing_src_type parse_private_mem_backing_src_type(const char *type_name)
+{
+	int i;
+
+	for (i = 0; i < NUM_PRIVATE_MEM_SRC_TYPES; i++)
+		if (!strcmp(type_name, vm_private_mem_backing_src_alias(i)->name))
+			return i;
+
+	print_available_private_mem_backing_src_types("");
+	TEST_FAIL("Unknown private mem backing src type: %s", type_name);
+	return -1;
+}
+
 long get_run_delay(void)
 {
 	char path[64];
-- 
2.49.0.1045.g170613ef41-goog


