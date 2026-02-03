Return-Path: <linux-fsdevel+bounces-76216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZsIco7gmmVQgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:17:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A9DD710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB7E1309F8AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFA366DC4;
	Tue,  3 Feb 2026 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mniz/5oy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105673612D8
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142582; cv=none; b=Byg1eDoxz3/zsDxuQ6W7Soc2hkp8NzUaAZNpCXkQhwbghrYjjJCZbdnUAJaGTWjDUgALairmPpc2TeUGhaZcu3uPPzfSee5RoPpobtNXPgtNFJeUHRWmnkhZOixVDPFdk7WWiNHmp4VQzRgtgy8/Q5jBvb52MFxmNLmMcUKxpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142582; c=relaxed/simple;
	bh=Qt7o89VltFIBegDzasIbqnP3PJ+WPuTLLON/GuX+fRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeGjnKwaXhxlxzIEe+xU/tSWvI/Dm6Ympv/nCAuTUaiPyrf6NzMU6E58YMZB545JzUmy52L3dP3h6UgDERfUbGRsnvcc/beMsuev4m/hGJsynEz/+XI1E1itCV4d4cDeZgEOvZALbtO+5mE9guGl8vUqWnic8iI3qFf8+GxYIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mniz/5oy; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8947e6ffd30so70834916d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770142580; x=1770747380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu1la4UZlbEX7cvXzj/Z/hgnRFrqjHU+qKtYtW0dmkY=;
        b=Mniz/5oynk/qOI64zPIe8E+PNEyixk4fEB611FX5soFdbulK6R9KmPQtOu4aEAXjcB
         efjpn/kLP3vsSPGaHohVu6/Rt0K9qXP7QtNggw4Y7iGiQ+lb7Btklx97aDYTLAlUztFI
         h5yvBEF6xvd6QNj3f/5Rq9dS5pMAQ/wKBPWuMCDaLEXtmpFbJnXArLI2UIvYnmp155Zy
         0b+yLcNYyG0uUnOruupOuHumm/8Fat9UIruRUI37sLCEsgtmT6QSkgWJF1h0NEiROxuz
         1abL4IMKxz9NUHd0G1V4nEtr6+1cDHCJ7YB1uyGxhcm0aubd+Dk72keMw16xEPt7BDo4
         yQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142580; x=1770747380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu1la4UZlbEX7cvXzj/Z/hgnRFrqjHU+qKtYtW0dmkY=;
        b=SXS43QjWZ0jTyw/gTsuL3lh5eYYXYjH9p73aUFfHPah62BSKSVRXb+tHIqv57orsPq
         L5fITzX34l8OLoxxsMLVKGLgcn5Psrh0nFCWc6tQWvSfHGAHYaSjB5ztNgB5e3uPuQdn
         yEqYRYB5y7MXEco1S5gqfyP7ubJhOtWVU1UhsbX71clw83XbQc8l9A3YvnGny7H6ia7Z
         kdLWFim4BLCMf9IpagDvhtIyZi8D0L8gGfCNSQttxk0S3fo/HXDtwBHEfdErcpOdgGP1
         4mvSycpWT4nES4iQl8q7FsREZrwG3H9orG89jhgOwWSmX5M+WEawa+COJRZ4bOdZIU5s
         I3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNrPWeejsZVDvATbLKeaWhjGOkL4UKQIrLPuPcikPqlabjc8ZQgMPNuvjIAvWa2Q/qqFyhbkCvjrO7SNK@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPal3IwWoaArZcmpNdQM2/smaHTWDbvGpyovqswu9LbVdUy0u
	ZAQO8n/4nn5Cr1ARuLl8plbmiTaT6Hfd142bR+Y2x55NzwSPadyJENmohpmRM/NCRD8=
X-Gm-Gg: AZuq6aK1l3bWnqcKpjK4QW1THS0rZbNa3ALiRmGHa/ZfwKZPlpNfgdBCLBKV251AKNU
	K3SaDsDMyBddsdpxd8txxknU0euiBDpsi9jyE1tPEkw3VSbHjiSMsSmy7NoNXnN7PtNSVRydN3Z
	hH8jCGUzov6165LBPQZQU1drXv6hvoPeFzcENUw/My/MG3Z4tcs9wD87XODT52A2fL4FoEzC37b
	0FbKUpCMNFPjKDMwmFnDtyuOL0TVjQK7qgYrbAjxcbj6ErYnp7+Z6LN5G8I+6mhTJ8da/X0SJk6
	gVwgDQbTAhPqndgoZ12dJ3yd4+NQ02pa7fXC6jFuFMZryehANlM5rktilX1X5EGFnDhjZluY4dC
	ZHur3/oz0Bk8bp5gk1SiTBxWyL37uSve8tybni9DOBEuBXAuj+u9YrX91JVrADdiNQB6hlcrEZt
	rtGG3lj9RXMJLaNQIICm8CXPf8QWHyfYcdYlOsjZlCpHIwQdUDJeFodDbqtYXW2K0HVc8=
X-Received: by 2002:a05:6214:20ab:b0:87c:22f9:dac4 with SMTP id 6a1803df08f44-8952210b4a5mr5192876d6.15.1770142579616;
        Tue, 03 Feb 2026 10:16:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521c00173sm2728446d6.12.2026.02.03.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:16:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnKwk-0000000Gah4-0kfw;
	Tue, 03 Feb 2026 14:16:18 -0400
Date: Tue, 3 Feb 2026 14:16:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com,
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com,
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com,
	jack@suse.cz, james.morse@arm.com, jarkko@kernel.org,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au,
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz,
	qperret@google.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
	wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260203181618.GY2328995@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <aYHGVQTF6RUs7r3g@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHGVQTF6RUs7r3g@yilunxu-OptiPlex-7050>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76216-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[98];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF3A9DD710
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:56:37PM +0800, Xu Yilun wrote:
> > +1.  For guest_memfd, we initially defined per-VM memory attributes to track
> > private vs. shared.  But as Ackerley noted, we are in the process of deprecating
> > that support, e.g. by making it incompatible with various guest_memfd features,
> > in favor of having each guest_memfd instance track the state of a given page.
> > 
> > The original guest_memfd design was that it would _only_ hold private pages, and
> > so tracking private vs. shared in guest_memfd didn't make any sense.  As we've
> > pivoted to in-place conversion, tracking private vs. shared in the guest_memfd
> > has basically become mandatory.  We could maaaaaybe make it work with per-VM
> > attributes, but it would be insanely complex.
> > 
> > For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> > is all or nothing, and can never change, then the only entity that can track that
> > info is the owner of the dmabuf.  And even if the private vs. shared attributes
> > are constant, tracking it external to KVM makes sense, because then the provider
> > can simply hardcode %true/%false.  
> 
> For CoCo-VM and Tee-IO, I'm wondering if host or KVM has to maintain
> the private/shared attribute for "assigned MMIO". I'm not naming them
> "host MMIO" cause unlike RAM host never needs to access them, either in
> private manner or shared manner.
> 
> Traditionally, host maps these MMIOs only because KVM needs HVA->HPA
> mapping to find pfn and setup KVM MMU.

This is not actually completely true, the host mapping still ends up
being used by KVM if it happens to trap and emulate a MMIO touching
instruction.

It really shouldn't do this, but there is a whole set of complex
machinery in KVM and qemu to handle this case.

For example if the MSI-X window is not properly aligned then you have
some MMIO that is trapped and must be reflected to real HW.

So the sharable parts of the BAR should still end up being mmaped into
userspace, I think.

Which means we need VFIO to know what they are, and hopefully it is
just static based on the TDISP reports..

Jason

