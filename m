Return-Path: <linux-fsdevel+bounces-14243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C350879CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB32838D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9614291E;
	Tue, 12 Mar 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuyKhozq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614713E7C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275206; cv=none; b=n5doN7QYZdPfFCNh6FrQaa89p9KxqqydzWOH6MmCmMV1cn4CVphIxKE3bHHSQH70k7lVvu/KhZGUUE9niRiKxbYI1NqV0XcFTXR/j/do+W/uKWYsmAJUbJLcRB1ECOH+gzAD6TO0UB63u7ztb9G6O4n8vCFveCos2gCKKOGwI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275206; c=relaxed/simple;
	bh=Yh+LhS5yhRkoUraEclEvC+FapyUA4I8kLPY2KFzzQ6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVrvBTY1Pk8FLeM8FYZacUyNZanUJ3oQX9zbCXKDcVCtFDyiKGfwm8XyuQgLYDcxU+1j5Z5KbZvXVTWaEXEKNwWtXq5fGwq5ke6Q1tkGl+xoVQ1G7eK/Pq9E9CoD7GHhRNULlEZxAq4nRqG7ufJaZUPgG9AMp4wOIrgcNx75fFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuyKhozq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso7541939276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710275203; x=1710880003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkdeVHiZ4dO2mKNOI6prWlI/035w5V9mRcS9wJoax+0=;
        b=PuyKhozqlfbC+6hjQddM8pdLLVWSOXVaU+Qw5kWbrPZi8VvDIU6rEYnZ0YlPJults/
         LnKpQhiNDnMV3RY1NbpN4XoQMk9zhOoeb1R2U4BqIYLaiYoxmc7S43aejdEjwf3z43d2
         5AYQ+IATL+JlW3ZV4UKmKUUYmHegeYGcPbP1I29y8ZpOzpc2JMlFQ4L0dSIpgFKd8OQm
         AHfasU3Jac1Mnzde8e3VyJ8atIrEg2Rh9pjE9y2VFye0CFBIVtoQ4kitdL3J0XaQsDTg
         STsvy1rnghf+urEwTL7Qg4kISHFOIYms9zMTzVOn/i8H16Gn0yMGPGJYWx/jrLdeYCNc
         Pofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275203; x=1710880003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkdeVHiZ4dO2mKNOI6prWlI/035w5V9mRcS9wJoax+0=;
        b=U98iNlBXP5A1VwdfEJ0VrZnnCFEEcY/Ez/v5UlYEN71VVpbha3oXp0wNDNCTu3mR0G
         Rzq42KcXDWfVs+eK1VJ/ESEuRSGu0vHM2yQ0H8bOKXFzMsWdL/CiBT2socCiuo9Aij3f
         +oDzB/ftMBZ8N86wHrEJ1fvoQhIaLOa0b/mKE/BQLZxi7994Z+MnR9VzkDFn6GOjIOe4
         RgkfP9ZXzcd+edCxzJgmUQu8+HyoT6jdtYg9Pa+cWE8ig8gezNG/0NPOsORyTzinjlb4
         EuOmPZiOPwU3SQE/bdNK+VfioBM0Yibz00+pMsvQc2DNXLjlt6SKLop/OQn0olTtYlgC
         qT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkPEj9Js1Reb28ZIMJHtmSAnLc/RhnbsItdiUh/iCbyRBgQJLIHWjXK8CwvSarwCTDExlPii0HTvB7PLU/6CSDdb5gFKTBxaf+LEVyGA==
X-Gm-Message-State: AOJu0YzqXoJNCiZ3tAJlVkvxisMF4+Jvgq3srHEz/XLig0GPpdBdHheS
	RMlNvovJcEA1uLdDq2nMsqzkZna+RaSXJflWsNalKg7Q7gynehHiRI8gwTDg4nznZeJDOL18FFZ
	t6A==
X-Google-Smtp-Source: AGHT+IFUmGhOgcd89e4lrqvlrIUFlYT8TKtqW8wVsN51aYrWhEhHnUI06gztJWUkIbtg80Ly0GbAPRIO8Ug=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114a:b0:dc6:d890:1a97 with SMTP id
 p10-20020a056902114a00b00dc6d8901a97mr59614ybu.9.1710275203718; Tue, 12 Mar
 2024 13:26:43 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:26:42 -0700
In-Reply-To: <20240311172431.zqymfqd4xlpd3pft@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com> <ZcY2VRsRd03UQdF7@google.com>
 <84d62953-527d-4837-acf8-315391f4b225@arm.com> <ZcZBCdTA2kBoSeL8@google.com> <20240311172431.zqymfqd4xlpd3pft@amd.com>
Message-ID: <ZfC6gnqVhZQJnB_3@google.com>
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating memory
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com, 
	vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	jroedel@suse.de, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Michael Roth wrote:
> On Fri, Feb 09, 2024 at 07:13:13AM -0800, Sean Christopherson wrote:
> > On Fri, Feb 09, 2024, Steven Price wrote:
> > > >> One option that I've considered is to implement a seperate CCA ioctl to
> > > >> notify KVM whether the memory should be mapped protected.
> > > > 
> > > > That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?
> > > 
> > > Sorry, I really didn't explain that well. Yes effectively this is the
> > > attribute flag, but there's corner cases for destruction of the VM. My
> > > thought was that if the VMM wanted to tear down part of the protected
> > > range (without making it shared) then a separate ioctl would be needed
> > > to notify KVM of the unmap.
> > 
> > No new uAPI should be needed, because the only scenario time a benign VMM should
> > do this is if the guest also knows the memory is being removed, in which case
> > PUNCH_HOLE will suffice.
> > 
> > > >> This 'solves' the problem nicely except for the case where the VMM
> > > >> deliberately punches holes in memory which the guest is using.
> > > > 
> > > > I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
> > > > so don't do that.
> > > 
> > > A well behaving VMM wouldn't PUNCH_HOLE when the guest is using it, but
> > > my concern here is a VMM which is trying to break the host. In this case
> > > either the PUNCH_HOLE needs to fail, or we actually need to recover the
> > > memory from the guest (effectively killing the guest in the process).
> > 
> > The latter.  IIRC, we talked about this exact case somewhere in the hour-long
> > rambling discussion on guest_memfd at PUCK[1].  And we've definitely discussed
> > this multiple times on-list, though I don't know that there is a single thread
> > that captures the entire plan.
> > 
> > The TL;DR is that gmem will invoke an arch hook for every "struct kvm_gmem"
> > instance that's attached to a given guest_memfd inode when a page is being fully
> > removed, i.e. when a page is being freed back to the normal memory pool.  Something
> > like this proposed SNP patch[2].
> > 
> > Mike, do have WIP patches you can share?
> 
> Sorry, I missed this query earlier. I'm a bit confused though, I thought
> the kvm_arch_gmem_invalidate() hook provided in this patch was what we
> ended up agreeing on during the PUCK call in question.

Heh, I trust your memory of things far more than I trust mine.  I'm just proving
Cunningham's Law.  :-)

> There was an open question about what to do if a use-case came along
> where we needed to pass additional parameters to
> kvm_arch_gmem_invalidate() other than just the start/end PFN range for
> the pages being freed, but we'd determined that SNP and TDX did not
> currently need this, so I didn't have any changes planned in this
> regard.
> 
> If we now have such a need, what we had proposed was to modify
> __filemap_remove_folio()/page_cache_delete() to defer setting
> folio->mapping to NULL so that we could still access it in
> kvm_gmem_free_folio() so that we can still access mapping->i_private_list
> to get the list of gmem/KVM instances and pass them on via
> kvm_arch_gmem_invalidate().

Yeah, this is what I was remembering.  I obviously forgot that we didn't have a
need to iterate over all bindings at this time.

> So that's doable, but it's not clear from this discussion that that's
> needed.

Same here.  And even if it is needed, it's not your problem to solve.  The above
blurb about needing to preserve folio->mapping being free_folio() is sufficient
to get the ARM code moving in the right direction.

Thanks!

> If the idea to block/kill the guest if VMM tries to hole-punch,
> and ARM CCA already has plans to wire up the shared/private flags in
> kvm_unmap_gfn_range(), wouldn't that have all the information needed to
> kill that guest? At that point, kvm_gmem_free_folio() can handle
> additional per-page cleanup (with additional gmem/KVM info plumbed in
> if necessary).

