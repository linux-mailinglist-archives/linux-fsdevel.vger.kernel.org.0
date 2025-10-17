Return-Path: <linux-fsdevel+bounces-64549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1EBEB9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3F2F4FBDAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7C34FF75;
	Fri, 17 Oct 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WA1qRovC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B534338582
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732020; cv=none; b=XOsUNvApE+gRBlt5CojYuwMOhJtmMjzkYhIA3htrO4qxhDU43mT359JHBnyb3vKHsuf2vZt3fK/wmwQ2izcrODkIue2o6+7tSgfpTfAz9zft0TOjp260gMUlhOmBtOl6xDI5bVLOxk3chbYg06wQbDMefy4vKlUVrMuQTL9EmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732020; c=relaxed/simple;
	bh=2DMaKOK2VXBsbJz3JTwxWGUFGZP6PnidI4mpyVFTIRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p5PsWo2aiFLsaWO+ytBfHDePZM08T971JfxyboSYvPfhktiu7w8JS1yv8tc0HfKPBQPEmKooj3pjsHGBXGc4NSArtbkmcCjTVGEO813pScnKmoB5gOHZ1hcKL0hqUgISLDUQa7/Nv9R8V+JF1HKnUhH+OjGl5k8f5TI8frDs4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WA1qRovC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so1902818a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732009; x=1761336809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmdP6R9nC9lX1jXEEElpeV73O9FQiFshjkk2aEtJ9fU=;
        b=WA1qRovCNHN2ZAT/8sz67z19z/LJuOECnGMWDiVMA/B331sLklnw5e6ERhoA/gbAtR
         QEG4dm2N5hooHB4GPOUI4GVHoirFlh5pDTIdEKlOwVbHCZaK0NfeE0nVcg2e4MhEJ3Yk
         P++bjQS3wAmLrjhhkrRGEkvYMjkpsdtGoDbrzEpEORpXZHluqOfBZnBBsqmooepxS1sE
         MGkqwVjiPjKM5V0kqygfCi+zsJFR+FBd08sTslPUcTG/Tl0VD45h8KcMG4VwiLRip/X5
         5HSgDtcMqNf0jYzW9WAGJOFdPpYeLQY9z9GWpe5rwLk2Zfha+KwskAk4sNwi9xYosCDI
         sH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732009; x=1761336809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmdP6R9nC9lX1jXEEElpeV73O9FQiFshjkk2aEtJ9fU=;
        b=IYdR2cHIK2Yx/Un3SsIimJlLXUdqknOB4m+LA58/DezoZ1kD36CrjGNco7UAw5Q+7Q
         dNIr2MRo2yieUdeOWIZ76wVuXT5RLN0qnJZzhWg9hxdjSqAaMqBg8jxaooKqtQhs9Iob
         IO3P/wIISTAhhcaHoYg7MK1qeFtrQuycfGwWcr/VW3UfVLOhIlHjT28nhWt0sr3InZ/1
         TreWor0jOct1ATevp0ffZ3QIuPZajyNfMGlY5uTpVauMiUvJw509ARpZuzJzSTz+EOEc
         qbc6FDqqlO8wVB8AmPvNycAsv0wYd2A3TlIxGZIGkP7px7jUNjiOebcBR4HYlFT+9Ads
         8UzA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Lm64woTIjW0wz4q2RfoZhe972MhyXHakswN/RK0EYp0y6rs0ZGY3g0DS0urrQzo13kY0h74n5pnE353q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZxgWdonvvv21IJb6SEGdDMogz228rGGRzDz3kUIRhEmHUUJ+
	xWpPOU9tCYRMVHTFaQKQHBHpQVT/HFS1xE+I1KHa43fXa8xisuS71VbU6HjZ0o909LNBmdlI4dn
	JuuD/SDI7DscH8hT+3Kl+hF7umA==
X-Google-Smtp-Source: AGHT+IGzgAEN2nLVpJn47Rpink95697ahn9+YSd6/QfacQuWgps1G1sah8dROQQkq3FQWO7kCJad1FtwMfse5d5QhQ==
X-Received: from pjbsr14.prod.google.com ([2002:a17:90b:4e8e:b0:33b:8b81:9086])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:52d0:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-33bcf8fa427mr6248763a91.19.1760732009057;
 Fri, 17 Oct 2025 13:13:29 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:17 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <ab7645218a87a45b0f3214a07138d3c8eadd3164.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 36/37] KVM: selftests: Update pre-fault test to work
 with per-guest_memfd attributes
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Skip setting memory to private in the pre-fault memory test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 6db75946a4f89..6bb5e52f6d948 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -188,7 +188,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 				    private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, gva, gpa, TEST_NPAGES);
 
-	if (private)
+	if (!kvm_has_gmem_attributes && private)
 		vm_mem_set_private(vm, gpa, TEST_SIZE);
 
 	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);
-- 
2.51.0.858.gf9c4a03a3a-goog


