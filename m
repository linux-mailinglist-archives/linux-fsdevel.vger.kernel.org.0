Return-Path: <linux-fsdevel+bounces-67679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C896BC469FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4A3B4D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60430E846;
	Mon, 10 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjyLkioR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FF2F690D;
	Mon, 10 Nov 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778110; cv=none; b=KY/PD4iESgPlzDDJ5xHXQhkJ+Reby9TIPyWWp8fD1+1g8Ps6hx8VVUHdxNcxltR4z7Rq2gnxLcLXADcyjikHehykSUmkC3gf6tVjEVtXNDKtNMZy4iFR7G/RpL2fuVQWB2lSin/CnRy55jv0omrREZ6pf25n2POFrBvqWDMp3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778110; c=relaxed/simple;
	bh=Aqloc7BOWQNjYEGGJL4VNHIwvX0puHEXVUArW0wY5yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMom9hifIeP2N1qEPtjd4xPU5RqUvszFMiCYEeTZMmK0nCWsRnMvh+GjykJlQ2Mkv/vJZk97/f+qK0HBaMlxLCM2We37EVTSVSwg3D8bzAonyNksWpdsEtttxQrYTephNUf9QPm10YiwP4c2ZRoAR1f2hOg3o7F9mYBCe71AoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjyLkioR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C89C19425;
	Mon, 10 Nov 2025 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778107;
	bh=Aqloc7BOWQNjYEGGJL4VNHIwvX0puHEXVUArW0wY5yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjyLkioRQTNOQX7WV1Bvgk28/2Npo87/4O/DYvYxhvdIkzERkIF4YWgs3zpThh4Nb
	 nk4DxXanbkMIWVH7rVuKqkYHYeYKOOPFEthmKGnYEIAObYRKAndU3l8nRk9CvViRux
	 65l/SP8udZTmUVNRLT5uXlJoPFSAOuwJ8MFyqobPnPc/FGkeiRAg+O5ICkw1tnUxZ9
	 nw59ACFdY/BU2F4GziHlZTo7UgjLJ3h/vdd4gyK6wH9qrNK6e1DhackPpUZT9njHNg
	 FBi/N8QIzRNuYSKNnCDyU3rxchuLO1kRHhf4q/nx8ccSCm7L7vHbfETFkVt/ILm193
	 OzCXZMlkxupeQ==
Date: Mon, 10 Nov 2025 14:34:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Roy, Patrick" <roypat@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"song@kernel.org" <song@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
	"tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from
 direct map
Message-ID: <aRHb5FJ2TUMtktVz@kernel.org>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-2-roypat@amazon.co.uk>
 <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com>
 <aQXVNuBwEIRBtOc0@kernel.org>
 <DDYZRG8A99D1.2MYZVGBKJNHJW@google.com>
 <aQiJAfO8wiVPko_N@kernel.org>
 <DDZV32U60137.1HE9JGMU6P1KD@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDZV32U60137.1HE9JGMU6P1KD@google.com>

On Tue, Nov 04, 2025 at 11:08:23AM +0000, Brendan Jackman wrote:
> On Mon Nov 3, 2025 at 10:50 AM UTC, Mike Rapoport wrote:
> >
> >> >> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> >> >> > index 1d0585616aa3..73a15cade54a 100644
> >> >> > --- a/include/linux/kvm_host.h
> >> >> > +++ b/include/linux/kvm_host.h
> >> >> > @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> >> >> >  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
> >> >> >  #endif
> >> >> >  
> >> >> > +#ifdef CONFIG_KVM_GUEST_MEMFD
> >> >> > +#ifndef kvm_arch_gmem_supports_no_direct_map
> >> >> > +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
> >> >> > +#endif
> >> >> > +#endif /* CONFIG_KVM_GUEST_MEMFD */
> >> >> 
> 
> But this is for CONFIG_ARCH_HAS_DIRECT_MAP? I am reading this as a stub
> to fill in for archs that have set_direct_map_*, but don't have runtime
> disablement like arm64.

You are right.
 
> Whereas my concern is archs that don't have set_direct_map_* at all,
> i.e. where we need to unconditionally fail
> GUEST_MEMFG_FLAG_NO_DIRECT_MAP.
> 
> (Or would we prefer to just not define it at all on those archs? Not
> sure what the norms are there, I guess that's a question for KVM/arch
> maintainers).

It makes sense to define can_set_direct_map to false for arches that don't
support set_direct_map. 

-- 
Sincerely yours,
Mike.

