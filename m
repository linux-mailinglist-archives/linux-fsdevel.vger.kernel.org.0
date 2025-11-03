Return-Path: <linux-fsdevel+bounces-66728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9737C2B278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B9D4F1CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4B301007;
	Mon,  3 Nov 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMmdPgR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDE2FFF8B;
	Mon,  3 Nov 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167064; cv=none; b=rsHJ0FzDCuv6X+wv3YOSvKNs4c5m2C6VGJRbvs2fmdnolF2b/EtDgdid6G/y0QMnGNaX1OLm9ZkrdfaOqE73DOmvFBIQg9DGsAp64rLFLQ88j0rPX68FEQ6OzjPnmOr6N+yPB5TLJfSjvoOOKfnBo1nFVc6vMLHGSVvJP/6II2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167064; c=relaxed/simple;
	bh=VQ4hXNs7+ujjrEuM6okI3GtAUk8U1jbFJcLICEJAusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+IMRzPsP5deAqMy5laEyBmeBns+us68jF5qOGFpcToZgKStW1MAUjx8Y+7rPGtdkEjL95jYsMi3AzB7D9jkLt+eYB2qEtNfkFNK3ZFAefEdEzipqyQkePeumsCiwhAA+y7e5ZxdwBBBuPwMQYviKQcdIC0/26qSRWAcwDPIEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMmdPgR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3098C4CEE7;
	Mon,  3 Nov 2025 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762167062;
	bh=VQ4hXNs7+ujjrEuM6okI3GtAUk8U1jbFJcLICEJAusg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMmdPgR/Ennl/LxZY9JqJ+rdcdE5xbtl2DS6YCfkT8tjg2C4Ok941GA3a0aGjjcbh
	 N+VphgG9Mxrc/rwY9hDkjQyGMzokqLs2VkZpM811GklFiDmbuNyU/kx4IyYR4eQ6J4
	 LYYuHJzAEuB/b9dp2zy3oLn35WeqIp2x8dQv1mg9ylraTpLP1Ncd6KNEOugD2aZg6d
	 J7IOaVx49e5JS8rzKGoQ+bfFg7G0KZ5tWzMM2lCcQC4hMefqksB4zyYyXewfMGG/sH
	 sf8iVfIkNndfACRLGLkcklSZ9SSPDp5SoTikAG2yQ/gnB6LeuVhTDfy3sIEh3BNm3K
	 i5hySTuH4tUXA==
Date: Mon, 3 Nov 2025 12:50:41 +0200
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
Message-ID: <aQiJAfO8wiVPko_N@kernel.org>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-2-roypat@amazon.co.uk>
 <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com>
 <aQXVNuBwEIRBtOc0@kernel.org>
 <DDYZRG8A99D1.2MYZVGBKJNHJW@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDYZRG8A99D1.2MYZVGBKJNHJW@google.com>

On Mon, Nov 03, 2025 at 10:35:38AM +0000, Brendan Jackman wrote:
> On Sat Nov 1, 2025 at 9:39 AM UTC, Mike Rapoport wrote:
> > On Fri, Oct 31, 2025 at 05:30:12PM +0000, Brendan Jackman wrote:
> >> On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
> >> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> >> > index 1d0585616aa3..73a15cade54a 100644
> >> > --- a/include/linux/kvm_host.h
> >> > +++ b/include/linux/kvm_host.h
> >> > @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> >> >  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
> >> >  #endif
> >> >  
> >> > +#ifdef CONFIG_KVM_GUEST_MEMFD
> >> > +#ifndef kvm_arch_gmem_supports_no_direct_map
> >> > +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
> >> > +#endif
> >> > +#endif /* CONFIG_KVM_GUEST_MEMFD */
> >> 
> >> The test robot seems happy so I think I'm probably mistaken here, but
> >> AFAICS can_set_direct_map only exists when ARCH_HAS_SET_DIRECT_MAP,
> >> which powerpc doesn't set.
> >
> > We have stubs returning 0 for architectures that don't have
> > ARCH_HAS_SET_DIRECT_MAP.
> 
> I can't see any such stub for can_set_direct_map() specifically?

include/linux/set_memory.h:

#ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
static inline int set_direct_map_invalid_noflush(struct page *page)
{
	return 0;
}
static inline int set_direct_map_default_noflush(struct page *page)
{
	return 0;
}

static inline int set_direct_map_valid_noflush(struct page *page,
					       unsigned nr, bool valid)
{
	return 0;
}

static inline bool kernel_page_present(struct page *page)
{
	return true;
}
#else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
/*
 * Some architectures, e.g. ARM64 can disable direct map modifications at
 * boot time. Let them overrive this query.
 */
#ifndef can_set_direct_map
static inline bool can_set_direct_map(void)
{
	return true;
}
#define can_set_direct_map can_set_direct_map
#endif
#endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */

 
> (But again, the bot seems happy, so I still suspect I'm wrong somehow or
> other).

-- 
Sincerely yours,
Mike.

