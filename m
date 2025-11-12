Return-Path: <linux-fsdevel+bounces-68072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFDBC5344A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 17:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AFA502E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668F33AD97;
	Wed, 12 Nov 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bDjPjfqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12F33CE92
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960487; cv=none; b=H9YrKtZlmgvGWuwfe/blKtUM2RKl39KpndrCHE1XSAZDE3Zmsyo045PKznxdiPNjL0HNDKvGtCe9EOxtEavrM0NApZVF44Mz0kqneLX9AuoOaWjsbv563D6dR28GBmHId9lXnrzu4bzLGr0ZnuExjHd+i8PFmeiz8afGEsCKNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960487; c=relaxed/simple;
	bh=GQQ0+OyWLqYJubVS6AGNI+hNpf6DosJPXicx/zXp2ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpEWmcnwurJp+W6A28ua4FPz1bs4UN6/MmwlVCftvu+FNqrutoEbuXko9u6zymEbP7ynqo3ZYR3X8fjNk2R9Y+NRxrhFkdWtJQONXSbz2i/Kax6UWU1tgVvr5+v0rDnKy7AD/AfTH9r9LrCkNnwdKNMhRM3e/VF2dxxf2ULTrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bDjPjfqZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1480292a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762960484; x=1763565284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQQ0+OyWLqYJubVS6AGNI+hNpf6DosJPXicx/zXp2ik=;
        b=bDjPjfqZMEHdRUHXIE74IWAqnrsCifN+P2zhpNVDEzr7MJ94C4pvOL4rlODLOxd11M
         edKbu+KuZbnwFDuKmx32FgVxPIyir2Fs80CYapeWtTEI82xS0xg58P3NYKeK//pT/AwQ
         1tKnsezfxf5u0eFFhdhk6Foa/c6xNgOt4Paff1TwNqLqBQzXhSQI/u2EW6znkwFENINk
         pIDbwh2Q5fzFNB+8iBK9MoVbdazhQwLh5kn/JLpTJB2EfG/txW7PCz0H1Ihu5VQPR1gR
         Fw656ClP9cH08NysacoXrdmqrL2QI4cXTeYz8VHaY483+8qzQP14Ooz4YOFeEZOB1VUD
         fOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960484; x=1763565284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQQ0+OyWLqYJubVS6AGNI+hNpf6DosJPXicx/zXp2ik=;
        b=QJwtQgeDmlVka3Ln/rBQOoAs/j7WOMwY55L6XSki9MIqugVT+VvwBJri52l6xWzPjI
         gMfY06SHrsfXqTdn96F/9BUP3DXTSUYiIQzUOfsSJ1sFj/oH68idZGOXaNHe4f26vOV8
         SYjgVFD+E22tIG4HG6E1y5QFq99LK2rys38gYkn1Lsa/X/JrWvPNmAKewa0xAZBDxkNb
         uxRQguQrAz7JuAUkO+CZGuNQo6GMree/dwr/XOFlIg1G3nIXQoEwzhKgHAwpX6uRIo7I
         xaurt6MO+Q5HI2Y/GNm8aLPqiMXyZAogOX5MZKaCo8rAKburX8PSk0dIGt+xNGOqH5N/
         4gGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy417UDZM6/KkREqP1/+CQsfG7ECF1XSD8qXvjINiRWqJl8UCa27bOGsQFKBRTX7LR1Ay0sesY3DxuOJ7c@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlOvZbAb9/LfazygD3Jf68p+DYSym8qVtFpcl70N08ediSjyw
	tdEw7mIHCICo7jLs1kANaeqgpES926uSGS9bCA7DaQiyX95L3a4dFaqwvPXKHXBZGFgiw7lJ+hL
	n4j5uA3QLja5ASlZ/xeihXTMSUpr2kvArwZgUu6+xyw==
X-Gm-Gg: ASbGncuZL/YgsM0xdAA6eMu6PLDvckuWLdzzIDy1tUj9IUGe0Nb9CL1HYBCUxq3je46
	5RmQz0BOgwnbqdk1QOT6caUtQY1wHQtNQPdnyKxN8mL7NjRXFEvAZ8LagAeBlVoJeCo3CYTiAhv
	VpyxhTwnoOwZ4A/mwEfLf8h21yH1L61wcP6dWX3+c53nqgzObOvW1bDyyH4G63NLXu9A5aFbS2h
	gO2zeohPrTWgRJ5i4pre5pEZ+6peS2wt1yXkPQxh63RhdZY6IUYGotHsQ==
X-Google-Smtp-Source: AGHT+IHvOWdCZpIHJdaITaurDIMyMeqdwSgS8ChEWfqyly8byOG2zD+TlxMB8QW/ltMZhyzar+Gs0r2HAPI8mXk2QxA=
X-Received: by 2002:a05:6402:358d:b0:641:3090:cba3 with SMTP id
 4fb4d7f45d1cf-6431a577cd4mr2984066a12.37.1762960484292; Wed, 12 Nov 2025
 07:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>
 <aRRflLTejNQXWa1Z@kernel.org> <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>
 <aRSMsz4zy8QBbsIH@kernel.org>
In-Reply-To: <aRSMsz4zy8QBbsIH@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 10:14:07 -0500
X-Gm-Features: AWmQ_bnD0Fa5WV9clCVqwOFMlUw8urbv0kYDUHAZVRNByd6elh9oV6dClE850Us
Message-ID: <CA+CK2bA6vCH=RkiZjAOsh5iR52BY567bJB3HNAGqDb307YxVdw@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > FLB global objects act similarly to subsystem-wide data, except their
> > data has a clear creation and destruction time tied to preserved
> > files. When the first file of a particular type is added to LUO, this
> > global data is created; when the last file of that type is removed
> > (unpreserved or finished), this global data is destroyed, this is why
> > its life is bound to file lifecycle. Crucially, this global data is
> > accessible at any time while LUO owns the associated files spanning
> > the early boot update boundary.
>
> But there are no files at mm_core_init(). I'm really confused here.

This isn't about the files themselves, but about the subsystem global
data. The files are only used to describe the lifetime of this global
data.

I think mm_core_init() is too late, and the call would need to be
moved earlier to work correctly with subsystems. At the very least, we
will have to add some early FDT parsing to retrieve data during early
boot, but that would be part of the HugeTLB preservation work.

I can move liveupdate_init() inside kho_memory_init(), so we don't
need to modify mm_core_init(). Or, rename kho_memory_init to
kho_and_liveupdate_memory_init() and combine the two calls into a
single function in kexec_handover.c.

> > > So I think for now we can move liveupdate_init() later in boot and we will
> > > solve the problem of hugetlb reservations when we add support for hugetlb.
> >
> > HugeTLB reserves memory early in boot. If we already have preserved
> > HugeTLB pages via LUO/KHO, we must ensure they are counted against the
> > boot-time reservation. For example, if hugetlb_cma_reserve() needs to
> > reserve ten 1G pages, but LUO has already preserved seven, we only
> > need to reserve three new pages and the rest are going to be restored
> > with the files.
> >
> > Since this count is contained in the FLB global object, that data
> > needs to be available during the early reservation phase. (Pratyush is
> > working on HugeTLB preservation and can explain further).
>
> Not sure I really follow the design here, but in my understanding the gist
> here is that hugetlb reservations need to be aware of the preserved state.
> If that's the case, we definitely can move liveupdate_init() to an initcall
> and revisit this when hugetlb support for luo comes along.

This will break the in-kernel tests that ensure FLB data is accessible
and works correctly during early boot, as they use
early_initcall(liveupdate_test_early_init);.

We cannot rely on early_initcall() for liveupdate_init() because it
would compete with the test. We also can't move the test to a later
initcall, as that would break the verification of what FLB is
promising: early access to global data by subsystems that need it
(PCI, IOMMU Core, HugeTLB, etc.).

Thanks,
Pasha

