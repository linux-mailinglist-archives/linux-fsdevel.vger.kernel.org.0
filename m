Return-Path: <linux-fsdevel+bounces-76244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A8kGu7Sgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:02:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB754E1A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE923041BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EAC350A1D;
	Wed,  4 Feb 2026 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVgo4JZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22C34F257;
	Wed,  4 Feb 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181334; cv=none; b=k3TQ0TNzvgQrVpSj4S38IBt/s5qC9I5rxmxCSHEQonZwUGRO1BWSU9cbmwC6u0ihNGUBnzSCDzYOgF2d5WBanvyyQxAzrkMVrf1Ry31ujrnR9GNEgBFrA6uGHF/otaXMVtJ2koJtDalS5y3+XZTLN2WNLWQcTPNNOHaqPICc2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181334; c=relaxed/simple;
	bh=BssClzJli42sqwnuhq7EEp2oGu8Z3L8cVPtpreDMGtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMEmgBok5BMinqtA/PK1ZNMeHYkK8Sr4VkRzbcwu5FbfjJfB3TqfGIQBSXrtm83sgH1GzCCzprpVcNX6ZdynrNTSUlV6QlKdpn03MZEAWOjbv2Dtr6GNYawHQx0JeN0ZEoQkPvZCik3JrfdJ6oBYKi3vuHWaggjHx5SSE0p9PfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVgo4JZw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770181334; x=1801717334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BssClzJli42sqwnuhq7EEp2oGu8Z3L8cVPtpreDMGtc=;
  b=mVgo4JZwFyU56rcObsmZRQVRlWYJGQiWb+dOGnrZg0ONCbgf/rPeTBj9
   vb6UtP4JjGW6BVXQTbZjqbu2WjN3SLNHNVqVsfktj5ARuulkbNHADqtKV
   VLzBbmXUiB+fMFjjEsEwNX9KTJ5RQMJIQ7FLOLChdXKUSxTHgCMqMVeaK
   Bm6smQqgLZuxg7WaRyPSiq2Jjjjl/wp3rimW8Ke4ml/IVqGbfJtM4IEGJ
   ok7coKSNpIgSELHUK3JsyzH6tgLu/UGWUG0nBGlxoAs29M5ltAsaDlpXb
   cvKz6GdMfLqToH41rZD8OFkuWddRIIZt9RkBFo+SUxq6W4zM2yB1zUFBP
   w==;
X-CSE-ConnectionGUID: l/PZ6WedTyueOgh/uO1g1w==
X-CSE-MsgGUID: 4rWHnChQRHGPOjkfHOmxdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71086376"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71086376"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:02:13 -0800
X-CSE-ConnectionGUID: r6WIlB3hRYOB1WMvBCSX1g==
X-CSE-MsgGUID: 4L+xrWR+RMKF3IcyS644EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="240739427"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2026 21:01:47 -0800
Date: Wed, 4 Feb 2026 12:43:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <aYLOZIZU0nwk+0UN@yilunxu-OptiPlex-7050>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <aYHGVQTF6RUs7r3g@yilunxu-OptiPlex-7050>
 <20260203181618.GY2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203181618.GY2328995@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76244-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[98];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: DB754E1A42
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:16:18PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 05:56:37PM +0800, Xu Yilun wrote:
> > > +1.  For guest_memfd, we initially defined per-VM memory attributes to track
> > > private vs. shared.  But as Ackerley noted, we are in the process of deprecating
> > > that support, e.g. by making it incompatible with various guest_memfd features,
> > > in favor of having each guest_memfd instance track the state of a given page.
> > > 
> > > The original guest_memfd design was that it would _only_ hold private pages, and
> > > so tracking private vs. shared in guest_memfd didn't make any sense.  As we've
> > > pivoted to in-place conversion, tracking private vs. shared in the guest_memfd
> > > has basically become mandatory.  We could maaaaaybe make it work with per-VM
> > > attributes, but it would be insanely complex.
> > > 
> > > For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> > > is all or nothing, and can never change, then the only entity that can track that
> > > info is the owner of the dmabuf.  And even if the private vs. shared attributes
> > > are constant, tracking it external to KVM makes sense, because then the provider
> > > can simply hardcode %true/%false.  
> > 
> > For CoCo-VM and Tee-IO, I'm wondering if host or KVM has to maintain
> > the private/shared attribute for "assigned MMIO". I'm not naming them
> > "host MMIO" cause unlike RAM host never needs to access them, either in
> > private manner or shared manner.
> > 
> > Traditionally, host maps these MMIOs only because KVM needs HVA->HPA
> > mapping to find pfn and setup KVM MMU.
> 
> This is not actually completely true, the host mapping still ends up
> being used by KVM if it happens to trap and emulate a MMIO touching
> instruction.
> 
> It really shouldn't do this, but there is a whole set of complex
> machinery in KVM and qemu to handle this case.
> 
> For example if the MSI-X window is not properly aligned then you have
> some MMIO that is trapped and must be reflected to real HW.

In this case, the affected pages are not assigned MMIOs and KVM won't
import them. Mapping them is just OK.

> 
> So the sharable parts of the BAR should still end up being mmaped into
> userspace, I think.

This does mean we can't make VFIO totally unmappable. But VFIO can still
try to create unmappable dmabufs for assigned MMIO regions, fail dmabuf
creation or fail mmap() based on the addresses.

> 
> Which means we need VFIO to know what they are, and hopefully it is
> just static based on the TDISP reports..

I don't think VMM need to check TDISP report. The only special thing is
the MSI-X mixed pages which can be figured out by standard PCI
discovery.

Seems this doesn't impact the idea that KVM needs no implication of
Private/Shared from VFIO, as long as VFIO keeps exported dmabufs
unmapped.

