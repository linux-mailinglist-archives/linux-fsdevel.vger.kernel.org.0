Return-Path: <linux-fsdevel+bounces-75863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG7iNqpwe2mMEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:37:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE15B10A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4342303715C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733531AAA7;
	Thu, 29 Jan 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxwqYsgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059B2FDC28
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697384; cv=none; b=R3f8Abg/Ykg4aqEvGpMvf+IC0A1uwL/lWt0l0YDtAhUThnVUuMSi4FPB/cA9Zq/Cy2smos+tMp8MQGvDZ4Cc2Sa6oFr03RnqmUPpi3wf9yVP7a7FbuKetPo4KvhqCdmh7JD/4uh2rxCk8YOrSbBBzs3jxp402H1v+rl+Lwuewvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697384; c=relaxed/simple;
	bh=ANQwl8weniEr3yhzdlhVQGQZ449UNTL3DKFoQ/EudaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMAPkWW/aqgvCLfqj3f8gz0hf5EXi0iptKWx4dOSQfPGPIaUZlRWQ4dG2k6LtbeOfVNGpUOOXGyyTJvQUH6dPYu3n9c5EnwBU+EuabVoJd/n63kxwD2R/zMDgblGNNQ1sL/y4mmZE22zmY3szp97A73SqPZ6YU2IEFrc1hodo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxwqYsgc; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-385c2f88618so9233241fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769697379; x=1770302179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCBf85o7m+LpjtZO2vby61ve+5QD+ZPBxgo311Kvx5c=;
        b=ZxwqYsgcsRDpg8P+2CkVnKIa97Uuw8sHfUjPyK68xS1ikxzYlgpEErT5jowzRYVqFV
         bOnW3UrliNORNnOSTzYOkB0XBdj4BDSCFDd1KJQimcesEZkaU4luEzsncxgxUJBzly37
         G8iOaMW8VaoAi/DQNkj/FNgz9cP8/ueEsIbrzXdXzGO9dhO6LVH7eW2iPMIEs7tX3EJg
         4IPh5xmLvIYUEbrIZ0oPl45abJRk2h/k70ogrQ5+H2/3/eH9qTG4jztKc0eC96oKtrWT
         AdT9SZUC3336ycSg+WnHuwhoqwvYtgnwxDbbem+CiWZe+UyzfzoM64QgdcjZfDatX8cx
         4JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697379; x=1770302179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCBf85o7m+LpjtZO2vby61ve+5QD+ZPBxgo311Kvx5c=;
        b=iLViRa9mCwHhXHKwsQVLzCwheGyNHVcc3EAZDJVGKcqO0M1GGWO33KHQX5KOUNGMv+
         Thw38csQrLk4DIwFvgxw/6me6xX1i+0rDKsp/orejoGcr5l+H+GppTPQrm5XNtAIIiYS
         Ozh9QpcBUoGQjkDVYgqAsNt4Dbedi76WgQBiMK+F5Z5sLlzU9jCEIllie2At+D55lj7+
         IviBggP7kKlWIrBL1u43sIKNb6UUSrlhnFLsukY9y/ZCVvQyaRnltW+I1qMDLY7k1n+q
         2A+VBlYYBpdnFqh0flyUbu4hBDztDqZzEu3lFs2KNOunHq8u6pxIdySAn2osZPUFJVDn
         /kzw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+yzxB2bGJGnSfY3OUGYyz6wapcEr6we2lUz2kExUSGHIhKRIlnr2TpHYL+slkT4FVB9PacuCWN35GJML@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3BYFZIETd7dkZa7nhdXJ/DeB1d7CWV1F7m90lmMZvS9gYTN0
	rs4BGwnSNg46++qjTSBS8FXI8JS61SurRAnxRFEIdupGXXl5RWLJ5lTqzCbdLEYAQQ==
X-Gm-Gg: AZuq6aL6BTmIaeA4M2WW0HiRI0Km/4QaFaCBNetkflGKL1z4BCXNjipw1eCREBNYnJ4
	Syb4GxgBLmjltwZrXjCMy27rGuYG/Lp0m6TwkUuecRrlJeN1TsBfDGp8mlNlku1jKgWu3k604hH
	t9TX23f6HAKayzjQ0vBBRgJSKVLPOP91+TREtRPm76+FlU4p1BhyUW9r5sxAXmJf/6B1mVBZBLh
	7siPza3VeLzcDLNnIe6A+DJCGbYj6qBxD7n1ebivRDY15nq6jjk7pDXoqyEo/WOJpK024MAIWUO
	3OyR1uljCRdPS8pPG3F6lB4LWe5Sk2sPRzrnA5NKLtqJ5Sec82e1UyIFRt5p6upFntMtCqnShtX
	0GSwGbXdC5hk7CoTgqenxHdYEHomnEVV3fN3Y1sJh8aAmBSa0q9uon6O/tHsTFMS2zp4fk5tV1N
	gBp/o+CEWxpmj1BvN7Mb9z59acUq22pmUkGYw42RI3QRPOUw==
X-Received: by 2002:a05:6512:10c1:b0:59d:f4b8:c3ac with SMTP id 2adb3069b0e04-59e0401702cmr4088944e87.18.1769697378667;
        Thu, 29 Jan 2026 06:36:18 -0800 (PST)
Received: from google.com (133.23.88.34.bc.googleusercontent.com. [34.88.23.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbe0bsm1156180e87.83.2026.01.29.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:36:17 -0800 (PST)
Date: Thu, 29 Jan 2026 14:36:14 +0000
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
Message-ID: <od4dx6snqsl2qiocgf3jxm4dndxhrlvsfr22eveuno6nskgfdj@mxsywvku2jk5>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
 <i22yykvttpc2e4expluuzucczqnetdnpee2wx2fzqwg7cnt45x@ovx7e7hok5iz>
 <20260129134245.GD2307128@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129134245.GD2307128@ziepe.ca>
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
	TAGGED_FROM(0.00)[bounces-75863-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 4DE15B10A7
X-Rspamd-Action: no action

On Thursday 29 Jan 2026 at 09:42:45 (-0400), Jason Gunthorpe wrote:
> On Thu, Jan 29, 2026 at 11:10:12AM +0000, Quentin Perret wrote:
> 
> > A not-fully-thought-through-and-possibly-ridiculous idea that crossed
> > my mind some time ago was to make KVM itself a proper dmabuf
> > importer. 
> 
> AFAIK this is already the plan. Since Intel cannot tolerate having the
> private MMIO mapped into a VMA *at all* there is no other choice.
> 
> Since Intel has to build it it I figured everyone would want to use it
> because it is probably going to be much faster than reading VMAs.

Ack.

> Especially in the modern world of MMIO BARs in the 512GB range.
> 
> > You'd essentially see a guest as a 'device' (probably with an
> > actual struct dev representing it), and the stage-2 MMU in front of it
> > as its IOMMU. That could potentially allow KVM to implement dma_map_ops
> > for that guest 'device' by mapping/unmapping pages into its stage-2 and
> > such. 
> 
> The plan isn't something so wild..

I'll take that as a compliment ;-)

Not dying on that hill, but it didn't feel _that_ horrible after
thinking about it for a little while. From the host's PoV, a guest is
just another thing that can address memory, which has its own address
space and a page-table that we control in front. If you squint hard
enough it doesn't look _that_ different from a device from that angle.
Oh well.

> https://github.com/jgunthorpe/linux/commits/dmabuf_map_type/
> 
> The "Physical Address List" mapping type will let KVM just get a
> normal phys_addr_t list and do its normal stuff with it. No need for
> hacky DMA API things.

Thanks, I'll read up.

> Probably what will be hard for KVM is that it gets the entire 512GB in
> one shot and will have to chop it up to install the whole thing into
> the PTE sizes available in the S2. I don't think it even has logic
> like that right now??

The closest thing I can think of is the KVM_PRE_FAULT_MEMORY stuff in
the KVM API that forces it to fault in an arbitrarily range of guest
IPA space. There should at least be bits of infrastructure that can be
re-used for that I guess.

> > It gets really funny when a CoCo guest decides to share back a subset of
> > that dmabuf with the host, and I'm still wrapping my head around how
> > we'd make that work, but at this point I'm ready to be told how all the
> > above already doesn't work and that I should go back to the peanut
> > gallery :-)
> 
> Oh, I don't actually know how that ends up working but I suppose it
> could be meaningfully done :\

For mobile/pKVM we'll want to use dmabufs for more than just passing
MMIO to guests FWIW, it'll likely be used for memory in certain cases
too. There are examples in the KVM Forum talk I linked in the previous
email, but being able to feed guests with dmabuf-backed memory regions
is very helpful. That's useful to e.g. get physically contiguous memory
allocated from a CMA-backed dmabuf heap on systems that don't tolerate
scattered private memory well for example (either for functional or
performance reasons). I certainly wish we could ignore this type of
hardware, but we don't have that luxury sadly.

In cases like that, we certainly expect that the guest will be sharing
back parts of memory it's been given (at least a swiotlb bounce buffer
so it can do virtio etc), and that may very well be in the middle of a
dmabuf-backed memslot. In fact the guest has no clue what is backing
it's memory region, so we can't really expect it _not_ to do that :/

