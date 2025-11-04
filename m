Return-Path: <linux-fsdevel+bounces-66924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122DC30ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349193B40EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802422E6CA7;
	Tue,  4 Nov 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOi6cERc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE32E2838
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254509; cv=none; b=RBAF8lEMJUqjgqT2gN/24ytvvfsTTBlQGZwDBdoH+4MnO1dR+tjXo6FaYhn5fRgbg8JI7czYKcMcPfKpkUC8pbwmeuZyMWIYMpWTr8T2QbQwKx/eQmShJ+t78X7Yqb66bHAiYxh8YBmlNV4Y+R21d8ZF5ZsVsGJMmB9PI8glMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254509; c=relaxed/simple;
	bh=hGCmoKsbTJZjLqzPr2g+Pp/EUZnTi1S5B2EwX1vZ0U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIlxjiliTLsRLSm4oAUv1PVRFhjDbMp36RYVWHtxLcfhndQhF4mZfLegUqaLpfDaCSUG9iwJtQP678pDVAQi0CTzkI//5pKeQ+gX9GZtaG3qiDqxK79+88E2BIuCwNMxnVYSlz/rokgI30xI6yPgeiikjDvS98ioaHMig6/hz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOi6cERc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4770c37331fso38737415e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762254505; x=1762859305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cH/AxQtviVkhj7n7m5X/IItvMNFrrOxnPoGxdV9l8=;
        b=fOi6cERc3oxNKySp93N+xGtpdQTmBLUmZkeP7IiX4XXgPG6lFdOGAFIHaEADyURTxl
         7Kxddg0lFNrsFDZkwJiMeD0PQvHm2DXbCQqsh77jpMWgqySROtYGzyz7ma3XJeoHIcsp
         nGJbFzQqKI9fDJe70U/xBwYf9AosmwzziDmgi7uc0T1PqPjUeDZOFRNqffXEpf26Ovwp
         G6i5Ke4VD14cYJglw3x53i+hkX352Rl3na838EnIMVB6XsYr8G21taJ6cj4XVkH7g+9b
         tp5JOoIzjh9jXzrN9n2ox9sFzFssx6MO5EqKwCCra5puyFSmVMcKQ4XKC3hqZIaSYjk9
         0M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254505; x=1762859305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cH/AxQtviVkhj7n7m5X/IItvMNFrrOxnPoGxdV9l8=;
        b=DcjtWLV9+flKoJC+aI7Lx1EY4K/dv24hi7fzInmU1hSRHfKPJzYGbwtVn/2D02in3g
         Xtg3zm3qd6Uh2hK47pHMc1dQBlIKQ8skPOFWXKdPEozjpPMocPM5w6HA2XAn+dcD/A0l
         J+4fvdMMyAKf7aA6PjrMDgQXVgsuOzwLEDt4HLJyrgmUE+ndHbJxWaqD5Xf9IumP1oXD
         DNhDZd9dSvCYT7w3hFjU8LS2TXCVBM86PTiGXYj6AJAZP86KACFHejNyS01aAR75W/Li
         SrVTDN1MOrFVPG9U/U55ailbaIEkvjZHWVRaAA3k4W8EVAOv4GBZMec5SwLhHJTCEwag
         P4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnXUzbkaI18eE15JCEm+vmW+3Om/6xpu5J7j7YZwGUxls6QN6HZjsaaDoDXBWjYuOIkQJIJKvVL10mb9ll@vger.kernel.org
X-Gm-Message-State: AOJu0YweAr6I9wxTK/pbpIseCfRtXrPLqd8TFJ51IF5sAC3t/wfr4zMc
	K4GNaV9YxVfFAk9PndsdcleRzG3yO018hdgyrNUPyXLwQLqx33mg7hmzeQwWDAxui6OXYrinXoD
	M0ax5pvJqNzrmvg==
X-Google-Smtp-Source: AGHT+IHvMIGMZ3oRYsIKBDomkCS6KVzlMOaVYE+CMhTF6/Om+i57uqifzVXn/OYDK9jNj1kCcP7uTWSdj5qqlA==
X-Received: from wmbg22.prod.google.com ([2002:a05:600c:a416:b0:477:14b8:19f6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1549:b0:477:e66:4077 with SMTP id 5b1f17b1804b1-4773089bd5bmr143775885e9.29.1762254504672;
 Tue, 04 Nov 2025 03:08:24 -0800 (PST)
Date: Tue, 04 Nov 2025 11:08:23 +0000
In-Reply-To: <aQiJAfO8wiVPko_N@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-2-roypat@amazon.co.uk>
 <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com> <aQXVNuBwEIRBtOc0@kernel.org>
 <DDYZRG8A99D1.2MYZVGBKJNHJW@google.com> <aQiJAfO8wiVPko_N@kernel.org>
X-Mailer: aerc 0.21.0
Message-ID: <DDZV32U60137.1HE9JGMU6P1KD@google.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct map
From: Brendan Jackman <jackmanb@google.com>
To: Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>
Cc: "Roy, Patrick" <roypat@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "song@kernel.org" <song@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
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

On Mon Nov 3, 2025 at 10:50 AM UTC, Mike Rapoport wrote:
> On Mon, Nov 03, 2025 at 10:35:38AM +0000, Brendan Jackman wrote:
>> On Sat Nov 1, 2025 at 9:39 AM UTC, Mike Rapoport wrote:
>> > On Fri, Oct 31, 2025 at 05:30:12PM +0000, Brendan Jackman wrote:
>> >> On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
>> >> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> >> > index 1d0585616aa3..73a15cade54a 100644
>> >> > --- a/include/linux/kvm_host.h
>> >> > +++ b/include/linux/kvm_host.h
>> >> > @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>> >> >  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
>> >> >  #endif
>> >> >  
>> >> > +#ifdef CONFIG_KVM_GUEST_MEMFD
>> >> > +#ifndef kvm_arch_gmem_supports_no_direct_map
>> >> > +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
>> >> > +#endif
>> >> > +#endif /* CONFIG_KVM_GUEST_MEMFD */
>> >> 
>> >> The test robot seems happy so I think I'm probably mistaken here, but
>> >> AFAICS can_set_direct_map only exists when ARCH_HAS_SET_DIRECT_MAP,
>> >> which powerpc doesn't set.
>> >
>> > We have stubs returning 0 for architectures that don't have
>> > ARCH_HAS_SET_DIRECT_MAP.
>> 
>> I can't see any such stub for can_set_direct_map() specifically?
>
> include/linux/set_memory.h:
>
> #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
> static inline int set_direct_map_invalid_noflush(struct page *page)
> {
> 	return 0;
> }
> static inline int set_direct_map_default_noflush(struct page *page)
> {
> 	return 0;
> }
>
> static inline int set_direct_map_valid_noflush(struct page *page,
> 					       unsigned nr, bool valid)
> {
> 	return 0;
> }
>
> static inline bool kernel_page_present(struct page *page)
> {
> 	return true;
> }
> #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> /*
>  * Some architectures, e.g. ARM64 can disable direct map modifications at
>  * boot time. Let them overrive this query.
>  */
> #ifndef can_set_direct_map
> static inline bool can_set_direct_map(void)
> {
> 	return true;
> }
> #define can_set_direct_map can_set_direct_map

But this is for CONFIG_ARCH_HAS_DIRECT_MAP? I am reading this as a stub
to fill in for archs that have set_direct_map_*, but don't have runtime
disablement like arm64.

Whereas my concern is archs that don't have set_direct_map_* at all,
i.e. where we need to unconditionally fail
GUEST_MEMFG_FLAG_NO_DIRECT_MAP.

(Or would we prefer to just not define it at all on those archs? Not
sure what the norms are there, I guess that's a question for KVM/arch
maintainers).


