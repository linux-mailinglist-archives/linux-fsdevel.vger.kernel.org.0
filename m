Return-Path: <linux-fsdevel+bounces-66727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843FC2B17F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 11:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6103F3A6F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7D2FF64C;
	Mon,  3 Nov 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAh+hzmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F82FCC10
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166143; cv=none; b=dKi8cuBY2/Hqfv4ouszo8pWqGGA+icxgF6rtay5ycy5uG6K4NcOi46BuG78oCz40hwTy9w4OSbIrqRGXSWE/aIZdls3D8tgRxCTHzqXJU1fiwF+z60qCFvucrwfwwA8cFX2lLOdvO1ocPvTOZxUFL/2fGCYRHDizWPSHRkTYfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166143; c=relaxed/simple;
	bh=8+P2mAiDVHSJp2el3mv9Dg4i98lSGdENhVxS8H1dViM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSlLPZHhsnSrmJGUY/7LDKPzKyQxxlbWKYATBWVrFNO3o4mZNxclaDas8rLCGDoqEtQECFA+xTD2VrstQWVpBwo109/FCK46gmS/PCivgwRwondTgh+qqMxo78xwWTU9ZzqgWGN9n9dsqVuWnpjpEvCXjbMg/YN7aDFhdBEqvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAh+hzmA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475de1afec6so14048355e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762166139; x=1762770939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIh+p2hn8CWwp1yzNpGitqYXRaRZUOuOWC3H0V0dQOo=;
        b=bAh+hzmAkGwoEFOBG+v9yKOCVi3zavh23jHO+A0Bi5r/D7LMYkktgkY2Y2RyBLUgA0
         xSGwERHygk1BrxIVKdOeDyF09DXGFkGXdgy+W2/hhV8vpJ+OpOzD6FgY6AQx/3lWYn12
         utCNcPpSFHFdbgfBPUbIBF/QetYRgHSSnq9sO/i8cyMIbFCaAtzB+oxx/Oy2PhNQrV1N
         DqRcNqisvLNoaNY2R10KbFb1tIauYOly1ThbyrmS9h13jYbcufakyKK2xoa+D84X1dHb
         cpPHiCP+l7K6+t1vuz/gY20iCjSB0T/BJGC1M+3nROAW8WbSKCwuXs4Qg323yAKF/kYv
         jsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166139; x=1762770939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIh+p2hn8CWwp1yzNpGitqYXRaRZUOuOWC3H0V0dQOo=;
        b=LKn+WC2ce3etXxE335ojRq3PGCSLm6zY5PR6vI/w7lq84O+XVvbZf2yoSRtuYetQEm
         eoFNUhavSJmZ0TwFKghrxGw+AR4Ol0FjooF5xYXwqUsy65zAiONOJFtI6FhB8S9l6iOw
         AF2vwpGmKAqa0HoGNQNptus094MmfGdoXZJE/VsDjWhkuol+9QgphyNzVlX+PXFD6Alk
         DGHvHPF5xZcXkYie5Lc4cAmlkhsKGL/0pFIaddnwVLrNRDN9c4XV99d4XDV0cd+ovAFe
         oL6c3/BGY8uM4ztrywIyLpbLhzdlVrtJxWsHS3VtXfK7bJw9vdOfpIbxsOCU/CFB1IC2
         J93A==
X-Forwarded-Encrypted: i=1; AJvYcCU/9S/iV6IBYwooaRkaSs026RXRG/NPxYvC7dj391Qg8pymtYIkzu38BWMXTBgs3sOf5TUQt9wj4GFc7SHK@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7qBSUnReSA6ZbySNvFD8EkN6bgRn3oZwBs0/lXRS/lrmU6rr
	+57ASSM5Mi69peRZkvjZ+krEgTSt6zJmF6sxHcjBpnN+tUsDMuaSlrH/Tl6EhrJ7CSu/smzNuKG
	tHAaPoKFgPtadsg==
X-Google-Smtp-Source: AGHT+IGsdQiHDuxdy1N3E7iEx3V3SXYmD4K71IvzTwmgh+q16FRulMDnGB/75cnoaLGyb09UfRoHjiberggitA==
X-Received: from wmco10.prod.google.com ([2002:a05:600c:a30a:b0:477:cf9:f4a3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:699a:b0:477:19af:31c2 with SMTP id 5b1f17b1804b1-477300d96c2mr124516735e9.9.1762166139059;
 Mon, 03 Nov 2025 02:35:39 -0800 (PST)
Date: Mon, 03 Nov 2025 10:35:38 +0000
In-Reply-To: <aQXVNuBwEIRBtOc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-2-roypat@amazon.co.uk>
 <DDWOP8GKHESP.2EOY2HGM9RXHU@google.com> <aQXVNuBwEIRBtOc0@kernel.org>
X-Mailer: aerc 0.21.0
Message-ID: <DDYZRG8A99D1.2MYZVGBKJNHJW@google.com>
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

On Sat Nov 1, 2025 at 9:39 AM UTC, Mike Rapoport wrote:
> On Fri, Oct 31, 2025 at 05:30:12PM +0000, Brendan Jackman wrote:
>> On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
>> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> > index 1d0585616aa3..73a15cade54a 100644
>> > --- a/include/linux/kvm_host.h
>> > +++ b/include/linux/kvm_host.h
>> > @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>> >  bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
>> >  #endif
>> >  
>> > +#ifdef CONFIG_KVM_GUEST_MEMFD
>> > +#ifndef kvm_arch_gmem_supports_no_direct_map
>> > +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
>> > +#endif
>> > +#endif /* CONFIG_KVM_GUEST_MEMFD */
>> 
>> The test robot seems happy so I think I'm probably mistaken here, but
>> AFAICS can_set_direct_map only exists when ARCH_HAS_SET_DIRECT_MAP,
>> which powerpc doesn't set.
>
> We have stubs returning 0 for architectures that don't have
> ARCH_HAS_SET_DIRECT_MAP.

I can't see any such stub for can_set_direct_map() specifically?

(But again, the bot seems happy, so I still suspect I'm wrong somehow or
other).

