Return-Path: <linux-fsdevel+bounces-66662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCCC27AE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051303BBEC7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B502C2356;
	Sat,  1 Nov 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ+WYDY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB14086A;
	Sat,  1 Nov 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761989965; cv=none; b=h9MnHuwbeQSesrCWQ9DM2rsMyGDM1Ok6gBqxrPuqc0IlIYX/LB+s5yFnd7fw8lt5zUh66JmIc5v6iEwdbaio+RzfKVHgk/GxMYo949xFbmyjm3CmJMvJAdKlmsAJY84kHZHpyZYkC51VJIw/pNLpBl+GPNZsJeKYJUkTRdtS0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761989965; c=relaxed/simple;
	bh=jKoa9V9XhQiv7BaQFL5zndUrFnF2g5McGSxuYRyVXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptq5PgaO6Qu7UptyAzLaB1JW5JhrfE/a8zo98unhMo+TgUE7uc7caCzktWBwGtta1ulHOcDqifK1l/FoKXbhTwCqs1LqOCXpuh8nnsq3+BNErkUtgr+c9mwvW62q/cv1G3pBrsmzIHxvEP86S58WGbywigBtEd4MncL8Uu3UFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ+WYDY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5088C4CEF1;
	Sat,  1 Nov 2025 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761989964;
	bh=jKoa9V9XhQiv7BaQFL5zndUrFnF2g5McGSxuYRyVXf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJ+WYDY+iJ5sz8QoBX/tgU9hS9MUKyxppf6Z2c2jctyOP9E8oK4uNRpvXJ0N7Vtn8
	 +1BC2YnPbSVKmc/bH7MUpPoZNwya+izl1xNabQT+1XlwS1BQ4mOQge1ALFNjsbnpmH
	 8dbbR8VGuC2diAqgEA5+pZ7+auNqQQcyoqaky5EjcHqjT6Zh6x5c48FIa6MZAHcUO2
	 apa+2zlnhJh/yi7yQPnsElQoV2X21wJKxz+CMPsU3MT27ZRV+jsk8w9hUJaFL+SyDM
	 lvJSrGW+4VcIuBmjfZP5z9FNQIsXfcO66WMXFChCMGvguxkPx5evJAwXAwFgmlWDUz
	 rGvhbOdFX0KoA==
Date: Sat, 1 Nov 2025 11:39:02 +0200
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
Message-ID: <aQXVNuBwEIRBtOc0@kernel.org>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-2-roypat@amazon.co.uk>
 <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com>

On Fri, Oct 31, 2025 at 05:30:12PM +0000, Brendan Jackman wrote:
> On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 1d0585616aa3..73a15cade54a 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> >  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
> >  #endif
> >  
> > +#ifdef CONFIG_KVM_GUEST_MEMFD
> > +#ifndef kvm_arch_gmem_supports_no_direct_map
> > +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
> > +#endif
> > +#endif /* CONFIG_KVM_GUEST_MEMFD */
> 
> The test robot seems happy so I think I'm probably mistaken here, but
> AFAICS can_set_direct_map only exists when ARCH_HAS_SET_DIRECT_MAP,
> which powerpc doesn't set.

We have stubs returning 0 for architectures that don't have
ARCH_HAS_SET_DIRECT_MAP.
 
> If this is indeed an issue I think it can be fixed by just defining
> can_set_direct_map() to false when !ARCH_HAS_SET_DIRECT_MAP.

-- 
Sincerely yours,
Mike.

