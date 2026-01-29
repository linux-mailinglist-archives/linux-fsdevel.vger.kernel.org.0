Return-Path: <linux-fsdevel+bounces-75830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDqNOu6xemk79QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:03:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAFAA7C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860D33007AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953F3126A1;
	Thu, 29 Jan 2026 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxM9HG+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8811CA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648611; cv=none; b=Sx/lzkghyvgDahFSPBvkjE0nEQC31aUV/uC6WtT1/nsfP6Q0RupkR/hu4YXVtIAoOfASrxalTPYG0QwNq+DkpF+1MK/xbx6tTIq2bR8nNaVmwW1JKJHvIPRvaPDPpDH50ywR4Cpjsho52h2VfEkfIVnW6H392GEn7eaHYEJYCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648611; c=relaxed/simple;
	bh=LycvwrEt9FiYCojoBJvkidjYu1wB89lVriZlQuiRjLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jO35ShUQC6/gHgC6Tc1z2cHaEUqcRP7EVflBESgAgOgOn2i6IHZiBEhpr7FyYQFd5v4UftrMVYS+TLR6AslqhZwW45Zzih6NKLApjMrUFteRaUaHa7v9v2tclI3ksCjiY7tRVzLK+vfoodxUuqHSPVDer/o1oJH5R50SQnJXmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxM9HG+X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7701b6353so3604135ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648609; x=1770253409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=19yGyDu7FA79ZAJBhihksbqQH2oSVrmD3QatKOHHT0Q=;
        b=SxM9HG+XCbluVUI9hhaJPoAGO9A4weGXrDN1WkEGXQkijuxtuAjaNEYFx+SLCqf0Vc
         DKo+wzbFJwA6yw7xBSyJwqQpAsDR6yb7FZU74TcmQYFFTPOeEhgrhdR6MUWIFp7qAG3f
         jS6sEPMQU+UK3viVxx6z7fZ+5qAIL8KBye4cTl21BAAmPZKUYXNqeHrwxKvvRjD3dSBb
         wBk8pa2mDMfo9JnWph33h5v8eIxV9BJIuCrP+bVCeNYlC4GG3+fX4/NgZnKzBPhJJpGu
         2J5KSfLSi5sExTVcHHRzagEuMknn+FWrhRQKbztN3EF1NO9VCtOojet9vcwtssGjZ0mv
         B/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648609; x=1770253409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19yGyDu7FA79ZAJBhihksbqQH2oSVrmD3QatKOHHT0Q=;
        b=gd2MAG609cDO6WIVVSAstJR776d7li4v5zZsmoW2S3HPtPTLagVCMkXXZXHyKgPGnn
         34FoZgvcmfRbQvz2NxbYp4a2iYw5q4a4fHO6x07C3nQ8JdrwFyqtfkk/fx4CfkDlLGs/
         DXWYhncNpCh5NCS1OI2ve9LECgb1EeV5g0Kf9OxpJzKTcpkdemkFHIbOcX0df6HLeFYY
         yCreJUZzM9Jp/AY9lVzNegznBI4HrntwDwNqgh8hGV5bZYEZ3uubtD6q/UxOvuXeqovr
         6Or1j+qb4cauzPJ5zgGNzOuilyrhxKqfGDRNFYwTiyRYbn2eBxTCsFAzokmJ+eeA13ml
         oNlA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Zy/PQiXU6q0PxUVJIC2yaxOOg5wxUxzGZbiCDbqhrN5MW0lmLdDgRqMMmSt44ZvL8e56ragzvyW3N4aH@vger.kernel.org
X-Gm-Message-State: AOJu0Yye721XvWHcT8ZwykkkZ0Xw3UFaJEJMOX21WpTEV3Die8kAWMmW
	0xZAiKWMCDLnJybjELxD4ZrDZHZBVpKS3m2++qtrMg8/TmBo1pSvSkRYMWw0JIDnszkMXxvAlUD
	53yFI3g==
X-Received: from plbky6.prod.google.com ([2002:a17:902:f986:b0:2a0:84dc:a82f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:2a7:dd37:6e20
 with SMTP id d9443c01a7336-2a870e34d04mr70308785ad.30.1769648609015; Wed, 28
 Jan 2026 17:03:29 -0800 (PST)
Date: Wed, 28 Jan 2026 17:03:27 -0800
In-Reply-To: <20260129003753.GZ1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com> <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
Message-ID: <aXqx3_eE0rNh6nP0@google.com>
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ackerley Tng <ackerleytng@google.com>, Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	TAGGED_FROM(0.00)[bounces-75830-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 24BAFAA7C8
X-Rspamd-Action: no action

On Wed, Jan 28, 2026, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 01:47:50PM -0800, Ackerley Tng wrote:
> > Alexey Kardashevskiy <aik@amd.com> writes:
> > 
> > >
> > > [...snip...]
> > >
> > >
> > 
> > Thanks for bringing this up!
> > 
> > > I am trying to make it work with TEE-IO where fd of VFIO MMIO is a dmabuf
> > > fd while the rest (guest RAM) is gmemfd. The above suggests that if there
> > > is gmemfd - then the memory attributes are handled by gmemfd which is...
> > > expected?
> > >
> > 
> > I think this is not expected.
> > 
> > IIUC MMIO guest physical addresses don't have an associated memslot, but
> > if you managed to get to that line in kvm_gmem_get_memory_attributes(),
> > then there is an associated memslot (slot != NULL)?
> 
> I think they should have a memslot, shouldn't they? I imagine creating
> a memslot from a FD and the FD can be memfd, guestmemfd, dmabuf, etc,
> etc ?

Yeah, there are two flavors of MMIO for KVM guests.  Emulated MMIO, which is
what Ackerley is thinking of, and "host" MMIO (for lack of a better term), which
is what I assume "fd of VFIO MMIO" is referring to.

Emulated MMIO does NOT have memslots[*].  There are some wrinkles and technical
exceptions, e.g. read-only memslots for emulating option ROMs, but by and large,
lack of a memslot means Emulated MMIO.

Host MMIO isn't something KVM really cares about, in the sense that, for the most
part, it's "just another memslot".  KVM x86 does need to identify host MMIO for
vendor specific reasons, e.g. to ensure UC memory stays UC when using EPT (MTRRs
are ignored), to create shared mappings when SME is enabled, and to mitigate the
lovely MMIO Stale Data vulnerability.

But those Host MMIO edge cases are almost entirely contained to make_spte() (see
the kvm_is_mmio_pfn() calls).  And so the vast, vast majority of "MMIO" code in
KVM is dealing with Emulated MMIO, and when most people talk about MMIO in KVM,
they're also talking about Emulated MMIO.

> > Either way, guest_memfd shouldn't store attributes for guest physical
> > addresses that don't belong to some guest_memfd memslot.
> > 
> > I think we need a broader discussion for this on where to store memory
> > attributes for MMIO addresses.
> > 
> > I think we should at least have line of sight to storing memory
> > attributes for MMIO addresses, in case we want to design something else,
> > since we're putting vm_memory_attributes on a deprecation path with this
> > series.
> 
> I don't know where you want to store them in KVM long term, but they
> need to come from the dmabuf itself (probably via a struct
> p2pdma_provider) and currently it is OK to assume all DMABUFs are
> uncachable MMIO that is safe for the VM to convert into "write
> combining" (eg Normal-NC on ARM)

+1.  For guest_memfd, we initially defined per-VM memory attributes to track
private vs. shared.  But as Ackerley noted, we are in the process of deprecating
that support, e.g. by making it incompatible with various guest_memfd features,
in favor of having each guest_memfd instance track the state of a given page.

The original guest_memfd design was that it would _only_ hold private pages, and
so tracking private vs. shared in guest_memfd didn't make any sense.  As we've
pivoted to in-place conversion, tracking private vs. shared in the guest_memfd
has basically become mandatory.  We could maaaaaybe make it work with per-VM
attributes, but it would be insanely complex.

For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
is all or nothing, and can never change, then the only entity that can track that
info is the owner of the dmabuf.  And even if the private vs. shared attributes
are constant, tracking it external to KVM makes sense, because then the provider
can simply hardcode %true/%false.

As for _how_ to do that, no matter where the attributes are stored, we're going
to have to teach KVM to play nice with a non-guest_memfd provider of private
memory.

