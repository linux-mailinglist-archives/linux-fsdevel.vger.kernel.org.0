Return-Path: <linux-fsdevel+bounces-2985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA77EE893
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A04B20BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1D45017;
	Thu, 16 Nov 2023 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR8LC9Rd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67323D73
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:00:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da307fb7752so1764892276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700168424; x=1700773224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcg1jHOi88FLN7hCqkcZwcR8zkGGhGMDTBufXRqyOok=;
        b=AR8LC9RdzQJ6e04orRQ7NovChpkme4uD8a5w8U6EF3WUGxEuLhURPJTy96rf3K4WNQ
         xxE8sD7/d3QeR+YsUnwL0t5v7PZ70vsTr+Bd1xceYyZx2I8BC5Zt5HKTqJTCKcxVxKmh
         35TdC1VPrs8AdH1hr5SatgucrL3Y5+9Bs0t1NfLBqwJM6o6y2vGjM9+/C0lTaHwuVY+r
         lRe/yBmNqO+6EZkX/WhUQRyWdRoDD05/VHwJb0B0qyJ2Fob6cmgQwA7MdHE5KMTEz0lT
         xtLMml7o5rQD6n4+cQIRCtXO0HDgRih3fpwt8Qp2XhCAXNQCxaqWg4qKY5XmzysECn8X
         JLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168424; x=1700773224;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcg1jHOi88FLN7hCqkcZwcR8zkGGhGMDTBufXRqyOok=;
        b=Ji+ZTHZIVlHPhhz3C+OK98rxZojh1Ce+SV8Mqvl9l3kDahbVnDWTjwlfziGFgmRExy
         0BuesRHyYlL1ucJhrPFTF2l242WIIv00TPQmQLpCmtnwIolFZlNqY052v6xs4o4/pRx7
         rSoZt1CcL06hnMPqe8KodF+BYG2reBhbD8Cqw+Hs4FJ0JZ8HKC+466zUTdbWD1vFzJIZ
         Y1EBWwGC6GLxgDaUxkogi8rn7kxzaTXO9wf/eJPhxZBAc2mb5i42pfcz/YrlRyUPAsRT
         I31zolKLT/u+ypx6XyFRppFX28MbrQMsVTSpFqAZUuEgWAKVER/VFtfZ42fb2xUfDwX/
         hQ4w==
X-Gm-Message-State: AOJu0YxcU9MLsw9KbTiBE/w8W8+5ZFSQtcqo0578uW/CEcE60a5VViB1
	t7aJ3EGdaqyWKBptZWrjCoYtGM1mysHlpvIuYg==
X-Google-Smtp-Source: AGHT+IERExc4D+qrt27go/xYBPrtoAORZdvfQFtSO07pMqMqSuTLQB8wBOPMZT1riqPUGW5/Jxx9EA2kvlBTv30QyA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:7644:0:b0:da3:a4ae:1525 with SMTP
 id r65-20020a257644000000b00da3a4ae1525mr393167ybc.5.1700168424573; Thu, 16
 Nov 2023 13:00:24 -0800 (PST)
Date: Thu, 16 Nov 2023 21:00:22 +0000
In-Reply-To: <20231105163040.14904-33-pbonzini@redhat.com> (message from Paolo
 Bonzini on Sun,  5 Nov 2023 17:30:35 +0100)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzfs15o1ll.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 32/34] KVM: selftests: Add basic selftest for guest_memfd()
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev, 
	chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	seanjc@google.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	chao.p.peng@linux.intel.com, tabba@google.com, jarkko@kernel.org, 
	amoorthy@google.com, dmatlack@google.com, yu.c.zhang@linux.intel.com, 
	isaku.yamahata@intel.com, mic@digikod.net, vbabka@suse.cz, 
	vannapurve@google.com, mail@maciej.szmigiero.name, david@redhat.com, 
	qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com, 
	liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Paolo Bonzini <pbonzini@redhat.com> writes:

> <snip>
>
> +static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
> +{
> +	size_t page_size = getpagesize();
> +	uint64_t flag;
> +	size_t size;
> +	int fd;
> +
> +	for (size = 1; size < page_size; size++) {
> +		fd = __vm_create_guest_memfd(vm, size, 0);
> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> +			    "guest_memfd() with non-page-aligned page size '0x%lx' should fail with EINVAL",
> +			    size);
> +	}
> +
> +	for (flag = 1; flag; flag <<= 1) {

Since transparent hugepage support is no longer officially part of this
series, 

> +		uint64_t bit;

this declaration of bit can be removed.

> +
> +		fd = __vm_create_guest_memfd(vm, page_size, flag);
> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> +			    flag);
> +

This loop can also be removed,

> +		for_each_set_bit(bit, &valid_flags, 64) {
> +			fd = __vm_create_guest_memfd(vm, page_size, flag | BIT_ULL(bit));
> +			TEST_ASSERT(fd == -1 && errno == EINVAL,
> +				    "guest_memfd() with flags '0x%llx' should fail with EINVAL",
> +				    flag | BIT_ULL(bit));
> +		}

otherwise this won't compile because valid_flags is not declared.

These lines will have to be added back when adding transparent hugepage
support.

> +	}
> +}

Tested-by: Ackerley Tng <ackerleytng@google.com>

