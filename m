Return-Path: <linux-fsdevel+bounces-66506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CDC2177A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC23461E2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E49368F25;
	Thu, 30 Oct 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjTRYPMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582532B9A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844716; cv=none; b=ekzBVRDdFVFBXznevaPBptMy034rYmOmJfqctUrOOX+WBJW4XQOtzOsn0RXP1hxx96KsWYH0RXzT6p6Y1hfp0v1Q1iyMSNQjJWU/BxSV8pXi9wW9+u0n4x2wTcdEPtPKlkFtyHnJu5uDHBlKbfPl4N6Py+TfkA5WDrRuyCVb41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844716; c=relaxed/simple;
	bh=VJLcmOospl0NvxJ/WTOkbujLbTnBJibWwvHUpjZ0/1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQalvq2REsSjTX+M/dsvmTJDvSjotYe5hEHpI906E6eXZYNKlZbdu3nGkyt0J7BsKMtzzbOm6cw6Mp3rtFPxfEsyZuAqJR19xqL9VfjhCeeg1Qecqvq/xoIHYAeRftTWFdhHCeORXtZtRKyJcjhjTJDWTXcWx8On6hq7YweV71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjTRYPMi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4710d174c31so11061555e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761844713; x=1762449513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zIsYr/NZ5vBEDYePNHV7frUHCwl+Wvsd8lZxHFgSTA=;
        b=NjTRYPMi7t4Sc0qduHqJAUaR2OaP2M3rj8a1pzTXzXCAraf5vvUtw5KWFZZXm8/Io0
         xcdd8KNn3+7Rl2e0nnO4dVJD8onBJEddd11mJqnI8Cs7Al4FpN4AYzY+8QqmKWeVraiE
         Na9enRm+27lhGolwsAX5xckYPHFPxPd9cHNIBqb7YleBuKB9ywSS9pGL18/SDkECxveI
         uqgvhkt3hPeQC0ih1oHXBHr2aXqjWbN+9uUrwq74mAm8fct34G4D2UeVMILN73kLcXPM
         mRdqCWI90wrOO2RKjLyUGgFd40mEdDK8A/HgHy3/G+vY0RsXKNtbzW3ecO0s+vSJl0Q6
         F+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844713; x=1762449513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zIsYr/NZ5vBEDYePNHV7frUHCwl+Wvsd8lZxHFgSTA=;
        b=rePthPP72HJtopWtj9MbeYZmSeLI+ttm85TNJfrg68SeyfOpuuE8P7wc8AXyAGgh9f
         X/qz2tq6b7kh2zQ+X4TTvCNIEkl/YHcX7OAC/pu8KDm+DXQ/ed06Sct5GtRfv/QVlkCB
         HRXK/uaneGmcEuY+KrW4fy14s8V+Euv8b2WI5c/TL4TzeU11vvNE/KzEw1KZQwVvLBTt
         LR1kFKCkTIsk2f3HKSoAzgbWilUO1N1mmGoL1lf0ugVf3nL+dcyudgLTcOzAPxtmenVC
         j8mc+l7Rdz+rd9nWLhg/jc++kuL90PeF/KsdEjmfV+VBvgsUwhBQvSige/QtWp7qpEEk
         TzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgc+7Ma+PnDdUoQ91rx74Asw7fcI6EdMuWaaxPepKr7WCDJKtOXrii9dpmYfcvW1x1n4WDZR7DJejW9Un9@vger.kernel.org
X-Gm-Message-State: AOJu0YygK2hue+0s+3oadjdwpR8HEzJ0Bv86YIfN2SFQuRzGlvEeveU0
	XHwprCpsOrw7hBTNAR9PCVJmkbO/PtvEKlEZzt4ooPuB8jGSXnurw1BcFe3EF40UVIqM5hi9FEA
	wlKAdCmHzBKlJlw==
X-Google-Smtp-Source: AGHT+IFXk6DKJ2LvWY2ZBOreY5EWyiD1FLIIWcEezkT9L8CiZAonL3OXc94rN18lwM8G/At6waViWG4yx0JY7g==
X-Received: from wmbka6.prod.google.com ([2002:a05:600c:5846:b0:470:ffaa:ae5e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8b:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-4773086d53amr4625785e9.21.1761844712453;
 Thu, 30 Oct 2025 10:18:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 17:18:31 +0000
In-Reply-To: <20250924152214.7292-9-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-9-roypat@amazon.co.uk>
X-Mailer: aerc 0.21.0
Message-ID: <DDVTTQZBJXAK.1OC7BTWCVCP9U@google.com>
Subject: Re: [PATCH v7 12/12] KVM: selftests: Test guest execution from direct
 map removed gmem
From: Brendan Jackman <jackmanb@google.com>
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"song@kernel.org" <song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
> Add a selftest that loads itself into guest_memfd (via
> GUEST_MEMFD_FLAG_MMAP) and triggers an MMIO exit when executed. This
> exercises x86 MMIO emulation code inside KVM for guest_memfd-backed
> memslots where the guest_memfd folios are direct map removed.
> Particularly, it validates that x86 MMIO emulation code (guest page
> table walks + instruction fetch) correctly accesses gmem through the VMA
> that's been reflected into the memslot's userspace_addr field (instead
> of trying to do direct map accesses).
>
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>  .../selftests/kvm/set_memory_region_test.c    | 50 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index ce3ac0fd6dfb..cb3bc642d376 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -603,6 +603,41 @@ static void test_mmio_during_vectoring(void)
>  
>  	kvm_vm_free(vm);
>  }
> +
> +static void guest_code_trigger_mmio(void)
> +{
> +	/*
> +	 * Read some GPA that is not backed by a memslot. KVM consider this
> +	 * as MMIO and tell userspace to emulate the read.
> +	 */
> +	READ_ONCE(*((uint64_t *)MEM_REGION_GPA));
> +
> +	GUEST_DONE();
> +}
> +
> +static void test_guest_memfd_mmio(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	struct vm_shape shape = {
> +		.mode = VM_MODE_DEFAULT,
> +		.src_type = VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,
> +	};
> +	pthread_t vcpu_thread;
> +
> +	pr_info("Testing MMIO emulation for instructions in gmem\n");
> +
> +	vm = __vm_create_shape_with_one_vcpu(shape, &vcpu, 0, guest_code_trigger_mmio);

When I run this test on my minimal config in a nested VM I get:

[root@testvm:~]# /nix/store/xlxd60n7v1qfr6s5zxda410zrzdd0xc2-kselftests/bin/run_kselftest.sh -t kvm:set_memory_region_test
TAP version 13
1..1
# timeout set to 120
# selftests: kvm: set_memory_region_test
# Random seed: 0x6b8b4567
# Testing KVM_RUN with zero added memory regions
# Testing MMIO during vectoring error handling
# Allowed number of memory slots: 32764
# Adding slots 0..32763, each memory region with 2048K size
# Testing MMIO emulation for instructions in gmem
# ==== Test Assertion Failure ====
#   lib/kvm_util.c:1118: region->mmap_start != MAP_FAILED
#   pid=614 tid=614 errno=19 - No such device
#      1	0x0000000000407b02: vm_mem_add at ??:?
#      2	0x000000000040a924: __vm_create at ??:?
#      3	0x000000000040ab16: __vm_create_shape_with_one_vcpu at ??:?
#      4	0x00000000004042cf: main at ??:?
#      5	0x00007faa6b08a47d: ?? ??:0
#      6	0x00007faa6b08a538: ?? ??:0
#      7	0x0000000000404384: _start at ??:?
#   mmap() failed, rc: -1 errno: 19 (No such device)

Here's the kconfig I'm using (basically defconfig+KVM): 

https://gist.githubusercontent.com/bjackman/4ea941ef5072606769211f3b000c8ed7/raw/73808882ddae6ff2ae8a0be85ac977b2980f7292/kconfig.txt

Sorry I'm too ignorant about KVM to know what I'm missing here but I
guess it's a missing TEST_REQUIRE()?


