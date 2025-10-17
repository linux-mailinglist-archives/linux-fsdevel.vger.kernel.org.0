Return-Path: <linux-fsdevel+bounces-64535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B946BEB905
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF944FC97D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135C34678B;
	Fri, 17 Oct 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vxO1VD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12470334C31
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731994; cv=none; b=a5pgMgCOrdld83yWIVmT6/GdlRoAS9MTB401u/c0madfX/fIDRo75bju9Pt6deyadwqC19CcdQO9FvB0PGwB/h8rIY+PJeXuZ8CuCuXJdO1v5uaSJk8QZP/K1H0qmY3Gb8UH3oE5uemQyvJnMLUVmTMO/ndSjvBYhoczHflePaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731994; c=relaxed/simple;
	bh=GAzkYSUv+N3H/xAb/xfS36q3dfdBV69oqQqnMSyz1sM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qy9u74ZwFuFAG7HRTTZgGyQ06LJ70LpRQqJqJ1sIDORwilN2+07Mc4GsuM6iw98FMDH9mzPY5rApwHbRJRouDyK2oXeWvFqKiT3tqWv2lbzs5ijhciQonybZqd17DFKuDpdVxvzQDe7RVi564C//Qc02H8VWQ6O9buwGSlVJhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vxO1VD1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2697410e7f9so58857475ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731985; x=1761336785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDnbSa/T9rbLxdB+UQ48e1HAUASVlE84N9T/ACVvI5o=;
        b=3vxO1VD16lGtn1c9wUCs+nCwlxXBifDRue+j1VCIphzAJsTCxxRf+cpqPibZrj3fZ0
         6sURYvhFIaqSdLQB7wXsC78BMcs3PIfaRkJb0zPtinCmyU8N8P22NAtgu116wag6Jd3U
         R0Yh06PEBOqzAFeKMMDL2VCAnlXYHCVu0cAT3elyFmSHDiZjrQFlw2d/EsK2s6sfM0Q+
         G7/J6ydyUg2641QAKbdnN6WrRvO8v8w+FORM5R6CgNg/mjIAlYVRxWKAlu0IhZ80WBdG
         Qa9I6Q9N+tf88OmVIlllmOQa/YhYk2totlmLxYk7yt8mCzJOYIjCUvMs5P81v1j8GQKd
         0caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731985; x=1761336785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDnbSa/T9rbLxdB+UQ48e1HAUASVlE84N9T/ACVvI5o=;
        b=Fo1hBNrvzhi9ZT6lUW2nzNAZ0o6tkA8N8hdkcTKOSZ7ApDnD8kh4Yq9G1a5SApQIFu
         q4x83Z8++VBgQiF2BzRORhDFxZL0L7DVDOKUu+mje1oyjmge+51PrAQYZqZAM6/zYoIQ
         OHYvDxDMVMcSVY9pZ+6cWIOegKKZ4UCWs3Y9oYP/k2AxVeAMUC3RokLtuyrb3ebQolQP
         NJ+jTnnfIElKrRy8LoZUBB6jg1gdmzrrTGLGgx1xQxZiKdA8z1T0CUd9L2NFc0aVWQsi
         SV7zluLWGqfAOf7q0QuR/rhw7VlA7g+ClG770VWUDg6ekHVgaHARmHeopQCeYwtD2QyI
         RiQw==
X-Forwarded-Encrypted: i=1; AJvYcCXOhXXxwFj0alQr/dr/DGKbJlffmy/xLgMvYHcsWY+5QCiXmHaw6fZklLFxsxsCB9hZ+dYIgKXYZ0eOKcqa@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhaYri6fhZA4+qH2i15q1/ZyozuS3cn/n/3i18oAvk4EbAXVR
	6e7fhlLztrRajGgj4BUaA+qWmx+AlSEZ/B7b7pEMWdJ4ni6y1CU+OS7lCMXb03r5o1nMS2T10TQ
	bS5VOwNOqjD88VKasral9EEjocw==
X-Google-Smtp-Source: AGHT+IGK/mdDuG3ZSGIyaVntdExFllUnbaBOt/fbdQU/VGroSYt3OxnCk4b4pKyuwZyAug/4lKin+lC/nqf3X5a2jw==
X-Received: from plrt13.prod.google.com ([2002:a17:902:b20d:b0:267:fa7d:b637])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:15c7:b0:288:e2ec:edfd with SMTP id d9443c01a7336-290c9c93ce2mr47503675ad.10.1760731985255;
 Fri, 17 Oct 2025 13:13:05 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:03 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <ab6491c3eac047b8c0fd4cbfcb021e6327124203.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 22/37] KVM: selftests: guest_memfd: Test conversion
 before allocation
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

Add two test cases to the guest_memfd conversions selftest to cover
the scenario where a conversion is requested before any memory has been
allocated in the guest_memfd region.

The KVM_MEMORY_CONVERT_GUEST ioctl can be called on a memory region at any
time. If the guest has not yet faulted in any pages for that region, the
kernel must record the conversion request and apply the requested state
when the pages are eventually allocated.

The new tests cover both conversion directions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 54e7deec992d4..3b222009227c3 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -263,6 +263,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 	}
 }
 
+/*
+ * Test that even if there are no folios yet, conversion requests are recorded
+ * in guest_memfd.
+ */
+GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
+{
+	test_convert_to_private(t, 0, 0, 'A');
+}
+
+GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
+{
+	test_convert_to_shared(t, 0, 0, 'A', 'B');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


