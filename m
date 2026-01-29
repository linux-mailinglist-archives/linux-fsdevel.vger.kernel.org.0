Return-Path: <linux-fsdevel+bounces-75824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPtXOPSremmv9AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:38:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E71AA44F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA60C301D6B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B852252917;
	Thu, 29 Jan 2026 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k3z974Mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02224677D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647077; cv=none; b=NrsZIfMA0qkn3P79UX/Klb2eqeRMNmvP/QUKWOx7f5JbpyHpNyutCw62JMc7S35clTcBSA0VNHY/CArONCgEZjAuf7VKW6v8YPIhspHCsSbg2nlMZjrL7h/oAWCMgoL+0epj9BuMsH2N22xwn0Yb9A8gGK5184MyGLcsVWPGuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647077; c=relaxed/simple;
	bh=tXNj0V0FG3jDHp0sl6ptuF//zDhb0DbdK89SgU01AH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT0l1wv8vey7YpbwtnKvyRFsvqCJ6OdQKmLUq1vDWhlLLwBYqSz60nsG/PCFGmlSJJ78DgiyuAxyDexCFOP0H4gYsuGrer3RITKKZd/oDIyx1VF34wAfDE70k4NXroT2gSeqgdicnfXc62ZaqW27umknI5U7oZxsmnvW/KygGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k3z974Mo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6af798a83so56250685a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769647075; x=1770251875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OWzBPKnyrz01i64zQ4S/hZaAIPcGy0JKcdMQLZXMgA=;
        b=k3z974MoBekrskW+4yDuSvtzoUeR4tzTJU2yvyD4rQigVuBdm4BzN3Xg8Zzela1ij1
         PtIBJOHG+48zicSasaJj88LsAp9Idss6arEvECeDPDvI1+/bGMecOxg2xZIYwnFVlh0e
         N0DvTFOVBrdLgm2SKMS+gRiwkBiRJcJWUntisKKjBYWClnHFRtNhDwWc+rSNwr+1UjqW
         hx681JKT5lyNNWCAUjt1BcDoxqd1Xi1LEySTm+fAhUY0zEB5n4V31HSnaVxU+vLpaw6P
         OslVl70bntspz23oY0Aox/yOyL0R7Sg8jXzzls2Zxn0sc+rXC4pcAybAV0qWKdtqzTn8
         u/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647075; x=1770251875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OWzBPKnyrz01i64zQ4S/hZaAIPcGy0JKcdMQLZXMgA=;
        b=ESHwbKYbSzYSTyqE5sqMT62IV8Y+mLpVWCv/HlNoihSCgJjzaGC1osvHUAJnvg3S4r
         TuUYt+0CbthHPcuknHwEIJTiKgFqXSfzggNeMXD9xkyfES5jmwnct6keONt9Z9P0JGtc
         PhFlLITfkeQVVL+ORkzJUi1t9D6CZ8H0uJJElwV8ahjVlYOu6mRleoxjxf74qRKqqELp
         zZDtbCuRmww+Tk6/dmuCvAFQhsZmOFI/XzZS5N8hK/J4cFQ4dKlrd0ZTeB/UiLYQrByB
         LMGl3fYW8KtBXBEDxV2H9sfzHM4F21b0WWsQo7TlSjP5GqLfmWwWg1/qtC3wpOX6trqI
         xaRA==
X-Forwarded-Encrypted: i=1; AJvYcCUZFG9A8LNQXMaH9+3PwDbaXdApguHvL6AMlSkPnuW+gHL1wdk7Z+EnU1vLpxgpaDgZusJXRfMBh6qDYNCB@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcU7VzG8R8Q/gm2jFeaPXn+7/F5xndLPbl8ibRi9yD/Dv4iKe
	mUGerOD8hi1KQrUouVqf8h6av9iAeCrDUk4TVJJ+IHvwzT2xN+YQ0qycH5bmNKRkGE8=
X-Gm-Gg: AZuq6aLjwzfLNb6mjfcqnlNO/KkyjjX3ewPgh9uQnnfMhcgYxT7HeFqVq4XEEbO1Vo8
	HsMwwnkGop+t1yCBp42d11HzH7xNwJnjRrToCUrIPrq54NEMKYoUYUzCp8Xt7HBKpZx/FH7lLF8
	E0WhlZvx8OikFLxVUY3ErFp1AxjR95wDEgP4hCwF1wTZ0fMgTjeHMtf2Saf1rM96WdN+JA3gw43
	e7Ly9uETDwIkDajzlTqnPh37KkY5mb+NAUS0hCtA89FcRhaOCTVclwe8emCRsaFOd73IJFdrd1Y
	L7ROkqJ6VXS/GkenmNmVl2i86fmYoFfwYGgdJiMBfRP5l8X8HrzQyNQthlGCBVTj6mwy6yChkcj
	lYcwA9rIOr05wFJwu2JQ3A1GjctBjVr303dQ7C9GHWP27heCI66iUEtJCoU4oJLrH8vf/kkmz1D
	/i/CINez8lUsxK631nEhw7RPACyAc+G5xQCIh6rYRtAQIWNMcrOsGFV+I3fhuhs+jiCNs=
X-Received: by 2002:ae9:c202:0:b0:8c7:126e:e901 with SMTP id af79cd13be357-8c7126eeb1amr465687985a.22.1769647074488;
        Wed, 28 Jan 2026 16:37:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d29aa2sm294243485a.35.2026.01.28.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 16:37:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlG2j-00000009g5p-04Lm;
	Wed, 28 Jan 2026 20:37:53 -0400
Date: Wed, 28 Jan 2026 20:37:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org,
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
	seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org,
	steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz,
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
	will@kernel.org, willy@infradead.org, wyihan@google.com,
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260129003753.GZ1641016@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,google.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75824-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 45E71AA44F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:47:50PM -0800, Ackerley Tng wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> >
> > [...snip...]
> >
> >
> 
> Thanks for bringing this up!
> 
> > I am trying to make it work with TEE-IO where fd of VFIO MMIO is a dmabuf fd while the rest (guest RAM) is gmemfd. The above suggests that if there is gmemfd - then the memory attributes are handled by gmemfd which is... expected?
> >
> 
> I think this is not expected.
> 
> IIUC MMIO guest physical addresses don't have an associated memslot, but
> if you managed to get to that line in kvm_gmem_get_memory_attributes(),
> then there is an associated memslot (slot != NULL)?

I think they should have a memslot, shouldn't they? I imagine creating
a memslot from a FD and the FD can be memfd, guestmemfd, dmabuf, etc,
etc ?

> Either way, guest_memfd shouldn't store attributes for guest physical
> addresses that don't belong to some guest_memfd memslot.
> 
> I think we need a broader discussion for this on where to store memory
> attributes for MMIO addresses.
> 
> I think we should at least have line of sight to storing memory
> attributes for MMIO addresses, in case we want to design something else,
> since we're putting vm_memory_attributes on a deprecation path with this
> series.

I don't know where you want to store them in KVM long term, but they
need to come from the dmabuf itself (probably via a struct
p2pdma_provider) and currently it is OK to assume all DMABUFs are
uncachable MMIO that is safe for the VM to convert into "write
combining" (eg Normal-NC on ARM)

Jason


