Return-Path: <linux-fsdevel+bounces-51371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A254AD6235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001B81BC00D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500824A049;
	Wed, 11 Jun 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WUbSSLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C2248878
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679847; cv=none; b=KSCvy9tEU7smm1ECZ+qlTF/q+F6Cv7CXwOurrk5N+QvbU6KriJyh8nhAPxULMZ2R4Ciovkp2tnsMqS0BZHzAHZIqMMk9T7mMOauAUXXdtaxBJ0tEHceDtlG0qE2X52XubIJRkbPaub9BFFuQlT33i+wLA4SawUpzgiqAE2rIRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679847; c=relaxed/simple;
	bh=fJlLfJlljhy2uz7a+9EWTi7+90pXlTDADppvxEHxEoI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=h2ME1fJ3h31P5SokkGPOpqBIre8rkw1s/xzgutDumhAF8kyAXILWG8+JXRrYbjTEonhqprYLyBjPAIyl26O23YoL8k5Wp9v6AYULgFs5ppe3fDCYKzwa7VWVIHlkS6Scu7hm6DKFZeHHyVIAa0ZboV3TuaiZ3OP3NvHTJY7PxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WUbSSLE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740774348f6so239185b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749679845; x=1750284645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H6zqQTmUzvZAJemTZAf+mRTjr1EfUfxJu4CNbewIY38=;
        b=1WUbSSLELnXRVChMo7U0RalH0+8HLOu9b/Clfrx+CF4PhEOzb08kJ6C+LhLgqIc41M
         cP6XfgR4wNmCC0GrgBeduniKbOCm+RJa0v4JxmfyQRfGFUNQyZ2eDNCndNFMca6eJshR
         B0P9CfyV4ThcvqmDbKc6VphyRlUDOkXQ226I0rdBdUr4T8vJ2IqtKIZToD6NNdI31xCW
         klJ8NYaOwZJd3bS4jtLL7ZNdv/pb2Fuk1WWunws8TqRn/1Fdo4yTwZS8ePnu3jKV6oZH
         t/1d2lqP0COtFdMYBuHsVhJoBbE8zfZ2ZILFqEB1bX0Vkw3Oionr3xlTf+KIEOvhzfTR
         J4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749679845; x=1750284645;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6zqQTmUzvZAJemTZAf+mRTjr1EfUfxJu4CNbewIY38=;
        b=v8ozbZOM6KYZNs/YiO56qZVT+NPCBlSCIFNXivGymX4IvC/5PFUnBNXDNLjw3bFf1/
         4OOk2UK0gPsFabRgulSbXemFlyY8x9Fanf43uKd+OINWfZ4PNHB78M3Fwu4mBQpkzeF8
         FfKYyNJYI90lehiQvhzAPfZRz4qw+f2NsCVJaRvX7OmJMwLXfDlghpqjDpIp0Zb9J15C
         TDtcMIsHmHhXw2g1I3hjhqzVZ55Jjne1iR5mTpNw6orFcLNkb5Feg4iKo806bizAsZuy
         CAvEMPSYFfpHuxBVh8YV6qov7NqklaMb8NMP9j6Dunw7LF7Prx7QP8ol8QdTCvFZmjT8
         ginA==
X-Forwarded-Encrypted: i=1; AJvYcCUkySNzy8iNiWXdiqH01a80bh3GAqaQ32q7G2pWLXZm1Cv4wFhxv88Xx4OC6wU9irH5G9BbAbXlj8zUgI03@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuAGvc0+nbOj9UkN5cjhy3wo+nRFieRyEwLtKEGoLNAC33vb8
	QqEMDFIyQdmvcDxmyrRvtawf8lAtIg3wTmzqASy+b6gWR4/jpu740x/s1vrVkTDakqhn69QrJ7Z
	IuDy0+hAJ7S3qgkqV9AnEKpIMQQ==
X-Google-Smtp-Source: AGHT+IG8KruwiUMvb+ATJBOZLNay31OV+ptC3k/zywhlmKWLbMkv7bf57V8cnC+4Oz/vdx8qXs/OaaWPkktFHE2Tng==
X-Received: from pfbna4.prod.google.com ([2002:a05:6a00:3e04:b0:746:2ae9:24a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:483:b0:21a:df04:3285 with SMTP id adf61e73a8af0-21f97870b51mr1918983637.22.1749679844831;
 Wed, 11 Jun 2025 15:10:44 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:10:43 -0700
In-Reply-To: <20250529054227.hh2f4jmyqf6igd3i@amd.com> (message from Michael
 Roth on Thu, 29 May 2025 00:42:27 -0500)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzy0tyudy4.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

> On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:

Missed out responses on the second two comments!

[...]

>> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
>> +
>> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
>> +				      loff_t size, u64 flags)
>> +{
>> +	enum shareability m;
>> +	pgoff_t last;
>> +
>> +	last = (size >> PAGE_SHIFT) - 1;
>> +	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
>> +						    SHAREABILITY_ALL;
>> +	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
>> +				 GFP_KERNEL);
>
> One really nice thing about using a maple tree is that it should get rid
> of a fairly significant startup delay for SNP/TDX when the entire xarray gets
> initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBUTES
> (which is the current QEMU default behavior).
>
> I'd originally advocated for sticking with the xarray implementation Fuad was
> using until we'd determined we really need it for HugeTLB support, but I'm
> sort of thinking it's already justified just based on the above.
>

We discussed this at the guest_memfd upstream call, and I believe the
current position is to go with maple_trees. Thanks for bringing this up!

> Maybe it would make sense for KVM memory attributes too?
>

I think so, but I haven't had the chance to work on that.

>> +}
>> +

[...]

>> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	if (!file)
>>  		return -EFAULT;
>>  
>> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
>> +

In this RFC, the filemap_invalidate_lock() was basically used to
serialize everything that could modify shareability.

>
> I like the idea of using a write-lock/read-lock to protect write/read access
> to shareability state (though maybe not necessarily re-using filemap's
> invalidate lock), it's simple and still allows concurrent faulting in of gmem
> pages. One issue on the SNP side (which also came up in one of the gmem calls)
> is if we introduce support for tracking preparedness as discussed (e.g. via a
> new SHAREABILITY_GUEST_PREPARED state) the
> SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occur at
> fault-time, and so would need to take the write-lock and no longer allow for
> concurrent fault-handling.
>
> I was originally planning on introducing a new rw_semaphore with similar
> semantics to the rw_lock that Fuad previously had in his restricted mmap
> series[1] (and simiar semantics to filemap invalidate lock here). The main
> difference, to handle setting SHAREABILITY_GUEST_PREPARED within fault paths,
> was that in the case of a folio being present for an index, the folio lock would
> also need to be held in order to update the shareability state. Because
> of that, fault paths (which will always either have or allocate folio
> basically) can rely on the folio lock to guard shareability state in a more
> granular way and so can avoid a global write lock.
>
> They would still need to hold the read lock to access the tree however.
> Or more specifically, any paths that could allocate a folio need to take
> a read lock so there isn't a TOCTOU situation where shareability is
> being updated for an index for which a folio hasn't been allocated, but
> then just afterward the folio gets faulted in/allocated while the
> shareability state is already being updated which the understand that
> there was no folio around that needed locking.
>
> I had a branch with in-place conversion support for SNP[2] that added this
> lock reworking on top of Fuad's series along with preparation tracking,
> but I'm now planning to rebase that on top of the patches from this
> series that Sean mentioned[3] earlier:
>
>   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
>   KVM: Query guest_memfd for private/shared status
>   KVM: guest_memfd: Skip LRU for guest_memfd folios
>   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
>   KVM: guest_memfd: Introduce and use shareability to guard faulting
>   KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes
>
> but figured I'd mention it here in case there are other things to consider on
> the locking front.

We discussed this a little at the last guest_memfd call: I'll summarize
the question I raised during the call here in text. :)

Today in guest_memfd the "prepared" and "zeroed" concepts are tracked
with the folio's uptodate flag.

Preparation is only used by SNP today and TDX does the somewhat
equivalent "preparation" at time of mapping into the guest page table.

Can we do SNP's preparation at some other point in time and not let the
"prepared" state be handled by guest_memfd at all?

This might simplify locking too, so preparedness would be locked
whenever SNP needs to, independently of shareability tracking.

Also, this might simplify the routines that use kvm_gmem_populate(),
perhaps remove the need for kvm_gmem_populate()? The current callers are
basically using kvm_gmem_populate() to allocate pages, why not call
kvm_gmem_get_folio() to do the allocation?

Another tangential point: it's hard to use the uptodate flag for
tracking preparedness, since when there are huge pages, the uptodate
flag can only indicate if the entire folio is prepared, but a user of
the memory might only have part of the folio prepared.

>
> Definitely agree with Sean though that it would be nice to start identifying a
> common base of patches for the in-place conversion enablement for SNP, TDX, and
> pKVM so the APIs/interfaces for hugepages can be handled separately.
>
> -Mike
>
> [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google.com/
> [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2/
> [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
>
>>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
>>  	if (IS_ERR(folio)) {
>>  		r = PTR_ERR(folio);
>> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  		*page = folio_file_page(folio, index);
>>  	else
>>  		folio_put(folio);
>> -
>>  out:
>> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>>  	fput(file);
>>  	return r;
>>  }
>> -- 
>> 2.49.0.1045.g170613ef41-goog
>> 

