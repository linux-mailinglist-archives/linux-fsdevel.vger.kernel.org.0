Return-Path: <linux-fsdevel+bounces-75851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM1RLi1Be2nECwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 12:14:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58119AF820
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3DB4308C23D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D918D387343;
	Thu, 29 Jan 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QAyUCoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0283859FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685020; cv=none; b=h8ucGxyYDGvUkIBXNb0p0P6CL8HCcvcHTRYUQ3aHdrnlBpapb5MMDA7jn0NrrfmD9s/j+yjAT3lQFktNJxtdOwKviqXs8fA4aGvn1pVo+VAQhM8Oe2R8cWK8PC8eZB+iJc44MoF193KtA3eqjT83Xapa8Zm43Wvbgj1BJACNV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685020; c=relaxed/simple;
	bh=kRUBBMAYJVrvzKRxdllg3UUuYrBU5zUZBBbF/HzxRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECt/5UwxaqTixIfekqacKb64w0RdP30MJxYwkT+WW1ZZqo3v5pp4ax9/fOKHA32zuAUVyeBxpfEkbcaH5DPgKqAHRpQ5U5u1Vj6Lz33iMCAV/D3WuTeyfNoIF+Gim6fEfoEtR2eYlr2d3LYe5FpaLSou59YvWJQpHArFYcDfQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QAyUCoN; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59b76844f89so766634e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769685016; x=1770289816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apF++zvcLgqSdwOs1FYPc9MkjitG47zUTTeeoONSIrw=;
        b=0QAyUCoNUvu9FPzFTcrMMg02JXXHJsg7+uJSdWJOR8RLJ+euKam1jutj9n7x4xgdv8
         12BcQ6LvHu89TNjOQaQXlEFVryGl5LOD5FcOAXXrsPrt8qbhD35DATI+LqF9utlWl+KC
         CvF8nJk3S56bi32Aol4MXgn+fYDMjKx4HmErRrzXRiBMetQvUgxtbF9XzXNo+9/JdSyy
         853J/IgxfA1vsyKPVKC00VepN7OMEZZiIuMg5kfKnQd2/IJB+4u96fXysq9I2DscSbXV
         H5ihJRkHPgGf9Jz3uWynbooOUucteDQHtFzfjhgxhziAd4RycrMutUbiZtYDSBgqiCNL
         Hsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769685016; x=1770289816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apF++zvcLgqSdwOs1FYPc9MkjitG47zUTTeeoONSIrw=;
        b=ogem8VNx9VnOufr5frX6JhAhXACp00B7ORHUey1xCo/zUaFTgz7YH1oORfA9nnTX72
         ZUOmEwTkPT6Y/xtEPYZyg7he7jxL8c/K3hQ1wgtI112ipUY6beVN85FCDazrsOnwqi7L
         Wp5BKbMk3pFZ2G1A8WUDB/KWylGUO7r11hd4xXeffKZNESMFsGbtZp36ZzEscUSiWJom
         yjGSLL7Lxy2JSLPVxsRwM6CUcAcsQFiv94TknyGTVUItGjFGgh4BYq6CbMFFaV+JzF0M
         BdF/D675KsswT574aQoB+4qilF1dtlaP9BEkY1vWgmx+8I3Aa9yyYlT3X+z7+Xj8kYEL
         YHlw==
X-Forwarded-Encrypted: i=1; AJvYcCWjDq91ySNthGdEjMHBajLKohHBVQwy+q9PTepV5G8pKmyCkwC8pLgKdONpGNDSGetuQQSOM673qJvientS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/M4zdqc5g5fMpewBo5S0/1uMxPkATMwexRm3W9JgftemmNYx1
	Zw+B8GlBtYvY+ncis83RhALu++8AibRLin2l4ExYf4C4Eqe8dBXiXkhst4vAHwxRWg==
X-Gm-Gg: AZuq6aIatbwYsegjWBoVdLdZCqFrUeoanoTTihzgye8XvRaR/e9c0UVoMHWZkcNYvmn
	4ZijyKUgNZs3rMZpd8vZfDY4+LCoEebx0pUoO/+eYMsVBbI6aXSFrvKn9uLE2tc9a3GiizlJuU0
	H/HwBxsn2btXSqYmOZQdG4OqZGTmSgwmmd/PqiDhPYJNWpzFNnQuDVVVFD+SHFGZb4K5lMkkHnx
	JqTq6xtnAdj6kzhVuO6Rk01TDF2BoLDJWWk1k3i8RUaglrw5t/kIktXJ/Are/USujeAH7iG8lXg
	bqvrG36je1t1gEWrX438FRkFXhPMJP6mqlCafd4pXEBnnbLOJD2ramDuoCOmjuispZdw4OFQgAA
	JL9WCdsozJx4aICA4M4WJx91eAdt+vWevo4WHvA2J9ocKgtaicQU+8+NVZRZ+cYz7ccAk+0bnFp
	HnmMlkcSc//HxcIeXo+O/tq0YWFQxB9e2lamy7EzCESC4uZA==
X-Received: by 2002:a05:6512:3c86:b0:59e:133b:f76f with SMTP id 2adb3069b0e04-59e133bf83fmr81660e87.23.1769685015739;
        Thu, 29 Jan 2026 03:10:15 -0800 (PST)
Received: from google.com (133.23.88.34.bc.googleusercontent.com. [34.88.23.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074814a1sm1097806e87.15.2026.01.29.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:10:15 -0800 (PST)
Date: Thu, 29 Jan 2026 11:10:12 +0000
From: Quentin Perret <qperret@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, jarkko@kernel.org, 
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <i22yykvttpc2e4expluuzucczqnetdnpee2wx2fzqwg7cnt45x@ovx7e7hok5iz>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129011618.GA2307128@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75851-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qperret@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58119AF820
X-Rspamd-Action: no action

Hi all,

On Wednesday 28 Jan 2026 at 21:16:18 (-0400), Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 05:03:27PM -0800, Sean Christopherson wrote:
> 
> > For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> > is all or nothing, and can never change, then the only entity that can track that
> > info is the owner of the dmabuf.  And even if the private vs. shared attributes
> > are constant, tracking it external to KVM makes sense, because then the provider
> > can simply hardcode %true/%false.
> 
> Oh my I had not given that bit any thought. My remarks were just about
> normal non-CC systems.
> 
> So MMIO starts out shared, and then converts to private when the guest
> triggers it. It is not all or nothing, there are permanent shared
> holes in the MMIO ranges too.
> 
> Beyond that I don't know what people are thinking.
> 
> Clearly VFIO has to revoke and disable the DMABUF once any of it
> becomes private. VFIO will somehow have to know when it changes modes
> from the TSM subsystem.
> 
> I guess we could have a special channel for KVM to learn the
> shared/private page by page from VFIO as some kind of "aware of CC"
> importer.

Slightly out of my depth, but I figured I should jump in this discussion
nonetheless; turns out dmabuf vs CoCo is a hot topic for pKVM[*], so
please bear with me :)

It occurred to me that lazily faulting a dmabuf page by page into a
guest isn't particularly useful, because the entire dmabuf is 'paged in'
by construction on the host side (regardless of whether that dmabuf is
backed by memory or MMIO). There is a weird edge case where a memslot
may not cover an entire dmabuf, but perhaps we could simply say 'don't
do that'. Faulting-in the entire dmabuf in one go on the first guest
access would be good for performance, but it doesn't really solve any of
the problems you've listed above.

A not-fully-thought-through-and-possibly-ridiculous idea that crossed
my mind some time ago was to make KVM itself a proper dmabuf
importer. You'd essentially see a guest as a 'device' (probably with an
actual struct dev representing it), and the stage-2 MMU in front of it
as its IOMMU. That could potentially allow KVM to implement dma_map_ops
for that guest 'device' by mapping/unmapping pages into its stage-2 and
such. And in order to get KVM to import a dmabuf, host userspace would
have to pass a dmabuf fd to SET_USER_MEMORY_REGION2, a which point KVM
could check properties about the dmabuf before proceeding with the
import. We could set different expectations about the properties we
want for CoCo vs non-CoCo guests at that level (and yes this could
include having KVM use a special channel with the exporter to check
that).

That has the nice benefit of having a clear KVM-level API to transition
an entire dmabuf fd to 'private' in one go in the CoCo case. And in the
non-CoCo case, we avoid the unnecessary lazy faulting of the dmabuf.

It gets really funny when a CoCo guest decides to share back a subset of
that dmabuf with the host, and I'm still wrapping my head around how
we'd make that work, but at this point I'm ready to be told how all the
above already doesn't work and that I should go back to the peanut
gallery :-)

Cheers,
Quentin

[*] https://www.youtube.com/watch?v=zaBxoyRepzA&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=35

