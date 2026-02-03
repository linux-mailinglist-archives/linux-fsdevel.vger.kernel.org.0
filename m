Return-Path: <linux-fsdevel+bounces-76180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPUsBxDLgWl1JwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:16:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F96D76D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF238306681E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF832D29C2;
	Tue,  3 Feb 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHfJCxHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5823183F;
	Tue,  3 Feb 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113729; cv=none; b=XqWlP+Gx8IK4tVkZo0NrmJEiXFqfAVEjAoWZBbG6u9FBPi9dTLrpn/LFr4+FRvY28Vbn5vwCO54n/VIxOribdfNb/a6PTLeTy8joPsYncOHD5n9yimBW9X9bEidpk2+SrARHphkrP03S7sN3C+38Oki2E5c/qNoYuU5rJt2C1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113729; c=relaxed/simple;
	bh=ltTqItvs5DEbQAayR00+PqL/+NRtgJq6ixieEinQSY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5jjG2QEVNkNXRP2RTfrK1GMOiUYH6UPKgEbwKpBdLGeZyIapCP4xIUdjduYYCelC1/8WjH3KNQMilVzd2sxP9LXQ2iMElxruLRgEvQq6IqpmH4FPc8DmCQ31z/Gd3mxq8IqLIGIX2TTULSA5lfMctxJNBPC4HBqUqSuVoQi/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHfJCxHU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770113728; x=1801649728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltTqItvs5DEbQAayR00+PqL/+NRtgJq6ixieEinQSY4=;
  b=WHfJCxHU6+m/HKsG1GEUHnC7LYEAoVlCp5pDuHNDURLYdoEDYFbRORys
   Lk4D7f7h02Orrykg+0t+tdqw6ZDWUlqyALFWmthEf98FPXaS0PGAQBtwm
   QgjKlOvAaqcH35dSuq9S9Za8hua/CidmhLAnv34VmjsDGLRHy3R6uWSvY
   c6YMNE8Le7rCnOAbslhhonhRo5jiZ7H17FnEfMCleDQ+iVn4X1jZH6A5O
   xRcF5tFZxKA5PklK5l89LpJq4MuTnFWaCO5jLhV90cjGpkqYi/GLgYZmA
   rd1cFOH+ZyF1x+tHM4dFEJpBLyNtmrBZofZhwQVPcScqg/lICl94yNpww
   w==;
X-CSE-ConnectionGUID: Q43I6yY3TF6pmKIhbq1+8Q==
X-CSE-MsgGUID: ou9M2qUoRwCLUcxP0tEM4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="96738240"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="96738240"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:15:26 -0800
X-CSE-ConnectionGUID: QSwRDmD1RvONYQUf1EbLaA==
X-CSE-MsgGUID: +XVLnH3CSfiSKxpDX9/BtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209093662"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 03 Feb 2026 02:15:05 -0800
Date: Tue, 3 Feb 2026 17:56:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ackerley Tng <ackerleytng@google.com>,
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
Message-ID: <aYHGVQTF6RUs7r3g@yilunxu-OptiPlex-7050>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqx3_eE0rNh6nP0@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76180-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 86F96D76D8
X-Rspamd-Action: no action

> +1.  For guest_memfd, we initially defined per-VM memory attributes to track
> private vs. shared.  But as Ackerley noted, we are in the process of deprecating
> that support, e.g. by making it incompatible with various guest_memfd features,
> in favor of having each guest_memfd instance track the state of a given page.
> 
> The original guest_memfd design was that it would _only_ hold private pages, and
> so tracking private vs. shared in guest_memfd didn't make any sense.  As we've
> pivoted to in-place conversion, tracking private vs. shared in the guest_memfd
> has basically become mandatory.  We could maaaaaybe make it work with per-VM
> attributes, but it would be insanely complex.
> 
> For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> is all or nothing, and can never change, then the only entity that can track that
> info is the owner of the dmabuf.  And even if the private vs. shared attributes
> are constant, tracking it external to KVM makes sense, because then the provider
> can simply hardcode %true/%false.  

For CoCo-VM and Tee-IO, I'm wondering if host or KVM has to maintain
the private/shared attribute for "assigned MMIO". I'm not naming them
"host MMIO" cause unlike RAM host never needs to access them, either in
private manner or shared manner.

Traditionally, host maps these MMIOs only because KVM needs HVA->HPA
mapping to find pfn and setup KVM MMU. Now we have FD based approach so
with dmabuf fd, host no longer needs mapping. Does that give confidence
that KVM only needs to setup MMU for this type of MMIO as private/shared
according to guest's intension (which is fault->is_private)?

We don't need to track private/shared in VFIO MMIO dmabuf, only to keep
them unmappable.

> 
> As for _how_ to do that, no matter where the attributes are stored, we're going
> to have to teach KVM to play nice with a non-guest_memfd provider of private
> memory.
> 

