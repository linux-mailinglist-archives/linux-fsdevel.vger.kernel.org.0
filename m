Return-Path: <linux-fsdevel+bounces-10960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB084F73F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA561F221C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19B69973;
	Fri,  9 Feb 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXpPNRmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF2364D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488888; cv=none; b=A/TXNGEgqmeeaBQkSB7XFu2WUtLGxdTdt6kYwltmSUQkGG3Uxv3cuipeQk+UK+vfp9IvjfcJ1Ys9nl6VyAizhjKAwqVsgbYpw8Lsx8bCq1KfuZM+0hwxWCzhmJAZu831+U4wVLjVaIJ6WtruSNU7DOHLLi1UlXTPPS1P1cnW0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488888; c=relaxed/simple;
	bh=HUx7t17vxGA5IaYOV8ff1kr8+jU/9ANSxbnT6H9GSco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMM/CC84efDH2bSK48N/93r1uYZxKmAGM+JDOlZwiyKZjGNItJwpUPAIyRdMFk28RVemjYeXlOTnFxIg9LZADlip0irCAWzSRPzOiZLPYrkzss/g7huvhFeS4s4zkaHWiXlu8T/MdIyUiGGUtc8x5Sb6QxqkELvn8s+sNtvej14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXpPNRmQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604b44e1dc9so19412507b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707488886; x=1708093686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCfsv6GrpUFnVCwcL3J5Wem8yNPUxVMsIIYMkBzD0b0=;
        b=ZXpPNRmQeW+Sm8OzwxON1DpjmSlXeodKp3uxsBZq1Cg5uqJA8J7OR0zmKyk1akz2Yy
         5EywEk/vM6zchQkTO/MSC9+Yucn6xjqlLJXS5II+SRuUGG5D3/myvb/anp4h/lhMlUIG
         ZcZcRAnBDNFUNDeH/AEX9RhWOJlV1M6SbJDFo/Eax51+lByy3q3Dg7L8HJx5FRfGnOhl
         sabcrTwvk8718sVD0CAGGXFZLyzHPoNW6pzR4LcloHCjJlb0MDm2i6LNBXTuYHY0+3L1
         YbngJFU/xjyYwKCM/BH9Ajz03VQupmY8A4LEcC1lUozX9lXFnBzk7XDTJUskDv3PBTXF
         fhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707488886; x=1708093686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCfsv6GrpUFnVCwcL3J5Wem8yNPUxVMsIIYMkBzD0b0=;
        b=JTGt92UEu/KZoWb1nqK/uMJhE+GUkxzl0/DgsKfpebFTPwQicy0KlB+u34EVqckIqO
         h5LuSNoz+FfK3fxx+Wupk0evW9MfC7aZndnAVkJNAh5HcyQzCNFaRXIom4k6slJPRzDv
         jGy51C0AB3auxPnjP+LwRgFOXMDdCAtHRuYML5VluPJkO5u2wKtc7G2g0TMfRqB712tw
         sPJlm7j9hX7Sy16qOG/DG87wctkAM08HHY/IO//RCIUAZEuDNvlwQPGA4JYKyuaeAZZM
         fYDHXV3J9fYZQUEkzsd6+BLrbqbkCi8mO1jMX32Dh0yAFlUQWdiaSxsvB2Y+N/dHyv4n
         8TLg==
X-Gm-Message-State: AOJu0YzNSPBj8JtkH74p6KsQ48oUBL7y2vD6Qeh3At2BTnY9ONw4Q9as
	VGB+4LfDQZ5QBPKPvYNGXqoxUBh6VWVc/7LB78OAMQhoquOJ6ggWVQfsDEo7lx2/5KhGTMycodj
	pEw==
X-Google-Smtp-Source: AGHT+IHy+djrwH9lBwMcfClT+8pK1QZMj2IcA9F/oSlT9qX98kneABwsfBtcWfL+f67hdIOBZn1ACZ3Dunw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6d82:0:b0:5ff:a885:65b with SMTP id
 i124-20020a816d82000000b005ffa885065bmr252030ywc.10.1707488885935; Fri, 09
 Feb 2024 06:28:05 -0800 (PST)
Date: Fri, 9 Feb 2024 06:28:04 -0800
In-Reply-To: <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com>
Message-ID: <ZcY2VRsRd03UQdF7@google.com>
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating memory
From: Sean Christopherson <seanjc@google.com>
To: Steven Price <steven.price@arm.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com, 
	vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	jroedel@suse.de, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 09, 2024, Steven Price wrote:
> On 16/10/2023 12:50, Michael Roth wrote:
> > In some cases, like with SEV-SNP, guest memory needs to be updated in a
> > platform-specific manner before it can be safely freed back to the host.
> > Wire up arch-defined hooks to the .free_folio kvm_gmem_aops callback to
> > allow for special handling of this sort when freeing memory in response
> > to FALLOC_FL_PUNCH_HOLE operations and when releasing the inode, and go
> > ahead and define an arch-specific hook for x86 since it will be needed
> > for handling memory used for SEV-SNP guests.
> 
> Hi all,
> 
> Arm CCA has a similar need to prepare/unprepare memory (granule
> delegate/undelegate using our terminology) before it is used for
> protected memory.
> 
> However I see a problem with the current gmem implementation that the
> "invalidations" are not precise enough for our RMI API. When punching a
> hole in the memfd the code currently hits the same path (ending in
> kvm_unmap_gfn_range()) as if a VMA is modified in the same range (for
> the shared version).
>
> The Arm CCA architecture doesn't allow the protected memory to be removed and
> refaulted without the permission of the guest (the memory contents would be
> wiped in this case).

TDX behaves almost exactly like CCA.  Well, that's not technically true, strictly
speaking, as there are TDX APIs that do allow for *temporarily* marking mappings
!PRESENT, but those aren't in play for invalidation events like this.

SNP does allow zapping page table mappings, but fully removing a page, as PUNCH_HOLE
would do, is destructive, so SNP also behaves the same way for all intents and
purposes.

> One option that I've considered is to implement a seperate CCA ioctl to
> notify KVM whether the memory should be mapped protected.

That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?

> The invalidations would then be ignored on ranges that are currently
> protected for this guest.

That's backwards.  Invalidations on a guest_memfd should affect only *protected*
mappings.  And for that, the plan/proposal is to plumb only_{shared,private} flags
into "struct kvm_gfn_range"[1] so that guest_memfd invalidations don't zap shared
mappings, and mmu_notifier invalidation don't zap private mappings.  Sample usage
in the TDX context[2] (disclaimer, I'm pretty sure I didn't write most of that
patch despite, I only provided a rough sketch).

[1] https://lore.kernel.org/all/20231027182217.3615211-13-seanjc@google.com
[2] https://lore.kernel.org/all/0b308fb6dd52bafe7153086c7f54bfad03da74b1.1705965635.git.isaku.yamahata@intel.com

> This 'solves' the problem nicely except for the case where the VMM
> deliberately punches holes in memory which the guest is using.

I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
so don't do that.

> The issue in this case is that there's no way of failing the punch hole
> operation - we can detect that the memory is in use and shouldn't be
> freed, but this callback doesn't give the opportunity to actually block
> the freeing of the memory.

Why is this KVM's problem?  E.g. the same exact thing happens without guest_memfd
if userspace munmap()s memory the guest is using.

> Sadly there's no easy way to map from a physical page in a gmem back to
> which VM (and where in the VM) the page is mapped. So actually ripping
> the page out of the appropriate VM isn't really possible in this case.

I don't follow.  guest_memfd has a 1:1 binding with a VM *and* a gfn, how can you
not know what exactly needs to be invalidated?

> How is this situation handled on x86? Is it possible to invalidate and
> then refault a protected page without affecting the memory contents? My
> guess is yes and that is a CCA specific problem - is my understanding
> correct?
> 
> My current thoughts for CCA are one of three options:
> 
> 1. Represent shared and protected memory as two separate memslots. This
> matches the underlying architecture more closely (the top address bit is
> repurposed as a 'shared' flag), but I don't like it because it's a
> deviation from other CoCo architectures (notably pKVM).
> 
> 2. Allow punch-hole to fail on CCA if the memory is mapped into the
> guest's protected space. Again, this is CCA being different and also
> creates nasty corner cases where the gmem descriptor could have to
> outlive the VMM - so looks like a potential source of memory leaks.
> 
> 3. 'Fix' the invalidation to provide more precise semantics. I haven't
> yet prototyped it but it might be possible to simply provide a flag from
> kvm_gmem_invalidate_begin specifying that the invalidation is for the
> protected memory. KVM would then only unmap the protected memory when
> this flag is set (avoiding issues with VMA updates causing spurious unmaps).
> 
> Fairly obviously (3) is my preferred option, but it relies on the
> guarantees that the "invalidation" is actually a precise set of
> addresses where the memory is actually being freed.

#3 is what we are planning for x86, and except for the only_{shared,private} flags,
the requisite functionality should already be in Linus' tree, though it does need
to be wired up for ARM.

