Return-Path: <linux-fsdevel+bounces-9596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66AB843296
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB71F27384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE44A2D;
	Wed, 31 Jan 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9IQLSNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B594C9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663584; cv=none; b=OVUnfISq7fh9ZCPp5RUAyxsC6EFnfgy4pMVz2ytRed1BEnDkbrzUGbOadbRShsxgJGV1+8teu7oLX+zR5EJPlk7b5zlo9zHZVtrgf9UsPt+cjB5ZwVVJ90Jch46U5KW28Hfdbbx5MJw8W+ZBr0FVzlvpFQVeLhQVOpe7y4Kyjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663584; c=relaxed/simple;
	bh=WnaiMYjG3HYrBPVosKeochjRi58QHb85b9Uafy87v5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwQGKRk8sjpE1P6np5WqkLqmgf5IxU4kIUkQ1m/erTPQrd0/EWB9SPYhH6KYidX2KihHyPlrmK8F8hj+z9mKnZzAsHG94IQtezegteoeDPLArv3weDAUAaUjw9YMEHC1A2Xv4JKlbXStwRHb07UUFvdeKYeBbX1ZIgi5eUslv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9IQLSNZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so2424658a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 17:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706663582; x=1707268382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GoosJvXV4tQVgQnoX094ue9LgaeDV/puMZ+zgV5v8A=;
        b=w9IQLSNZ4uiLohicHi+6G4ZMJRs0oUrtBRqKLSOvirKyQrWa1O/qJwki5kVmpdZUx3
         IpKJ4/Q6lzxOqvq+nzIOc64XbTDVm5OnVcguzGFi4NlitC2y4KwWXcGKJZHfHjeWTbpc
         Nqc5QsHw1b4PeF0Jqt2N5f0pgo9UHiHsbXI6wiwqGaevp5KffFT1lNyFTEchXuLFnmwy
         8aeYQITF4QJdmpaKl8yABpwEesen6QirhP2R5sWTUkaY7VuuYZpwS4VR8k2F/w6BascW
         TIj9TXanfw+TjmKBdug0CmE/Jm2wfYbveeQ59wYGdBLLdJZWqwhMyrLj+atS2x+AgBwu
         5s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663582; x=1707268382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GoosJvXV4tQVgQnoX094ue9LgaeDV/puMZ+zgV5v8A=;
        b=wsmxMo+ZjinfZado+LSKINeR+RLDrBj3ngNx4oXVo12mgXRqFFlhup+hoEZJiJeHOX
         2EUfGxVue+S5eUSYmAad/PqXzf4kHIlqwlrNdjg9kG2IrFuJDVOIyWTyx1+Aj7laOUgz
         oPnCxMOkmPtoTo4J41p/bTW4tzG+diEwW3rR3zzj2cEl/98cbwmYL4XhIfv4PEqV2HDA
         Lsd2dSf8JmxtAP86n1ciXP7EgE65WKaiWwI0OJD31zBjxIQdjYk+CBfn0ZghtytBRnZ9
         9BW5XimjHPFnNpayGBw/48GlgtaT14kJqDK87xLLLxPHw5BQd6F8ITpUx9QeZjyEMGwP
         WJsg==
X-Gm-Message-State: AOJu0YzuWT+kQP9hWGlYXv5YPaug7vdQg8kR4iuu+Wlu9JLimOs99OQT
	oGADO/DGb4wDqETogcO/fSFF8UHO3WAry4vo0RqiH/lzDdM/oKFkaJd4ddzunW4CnQeeaX5yLB6
	t3g==
X-Google-Smtp-Source: AGHT+IHXA4t0uhZ7tzthJIqQkUlU7edO5hP5ya6T+NaNmVk8RFxp+26SnKPKNqGEdvTVdg4s3sxwKV4qvvQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d212:b0:1d9:1e1:76ca with SMTP id
 t18-20020a170902d21200b001d901e176camr715ply.10.1706663582547; Tue, 30 Jan
 2024 17:13:02 -0800 (PST)
Date: Tue, 30 Jan 2024 17:13:00 -0800
In-Reply-To: <20231016115028.996656-9-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-9-michael.roth@amd.com>
Message-ID: <ZbmenP05fo8hZU8N@google.com>
Subject: Re: [PATCH RFC gmem v1 8/8] KVM: x86: Determine shared/private faults
 based on vm_type
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, isaku.yamahata@intel.com, 
	ackerleytng@google.com, vbabka@suse.cz, ashish.kalra@amd.com, 
	nikunj.dadhania@amd.com, jroedel@suse.de, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 16, 2023, Michael Roth wrote:
> For KVM_X86_SNP_VM, only the PFERR_GUEST_ENC_MASK flag is needed to
> determine with an #NPF is due to a private/shared access by the guest.
> Implement that handling here. Also add handling needed to deal with
> SNP guests which in some cases will make MMIO accesses with the
> encryption bit.

...

> @@ -4356,12 +4357,19 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  			return RET_PF_EMULATE;
>  	}
>  
> -	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> +	/*
> +	 * In some cases SNP guests will make MMIO accesses with the encryption
> +	 * bit set. Handle these via the normal MMIO fault path.
> +	 */
> +	if (!slot && private_fault && kvm_is_vm_type(vcpu->kvm, KVM_X86_SNP_VM))
> +		private_fault = false;

Why?  This is inarguably a guest bug.

> +	if (private_fault != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
>  		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
>  		return -EFAULT;
>  	}
>  
> -	if (fault->is_private)
> +	if (private_fault)
>  		return kvm_faultin_pfn_private(vcpu, fault);
>  
>  	async = false;
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 759c8b718201..e5b973051ad9 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -251,6 +251,24 @@ struct kvm_page_fault {
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
>  
> +static bool kvm_mmu_fault_is_private(struct kvm *kvm, gpa_t gpa, u64 err)
> +{
> +	bool private_fault = false;
> +
> +	if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM)) {
> +		private_fault = !!(err & PFERR_GUEST_ENC_MASK);
> +	} else if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM)) {
> +		/*
> +		 * This handling is for gmem self-tests and guests that treat
> +		 * userspace as the authority on whether a fault should be
> +		 * private or not.
> +		 */
> +		private_fault = kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
> +	}

This can be more simply:

	if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM))
		return !!(err & PFERR_GUEST_ENC_MASK);

	if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM))
		return kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);

