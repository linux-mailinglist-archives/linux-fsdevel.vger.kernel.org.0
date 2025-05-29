Return-Path: <linux-fsdevel+bounces-50095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F4AC8223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0003A31D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E423182F;
	Thu, 29 May 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xbphVhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C522D4F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543183; cv=none; b=d6xCMVp/dvnh6MNNj5tIYbA7SDeU1UnUbAFe7QmvSAr2H2MbbhJdpZk6/9RT2MZ9nb+OSYIWuJ0Jc2yP1FpvXmt7FE2BCi+8Mu8eXbyPefBv8+iGQDitXiBdfMv1zIiiyVj97zIqdFsjWP8Ji3I0hbqI/Mt6kIaGZydXHu2eeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543183; c=relaxed/simple;
	bh=HRPOn1meoE3XwDlWZS9bRRz1m47Q+lkEUYw+u1TxoQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nfs2FtzgJAk1brNibjdgzUZMvk3sa8EFXmutNTcFUfv1Q+y8e0icPQ4IHqihlIKP0qT8kAOD76fvCvU6VJLqNkzLW/6BebHz6RiZva8QOan6hhhUUnwuVHRhw1coerAqIu/qisIN3jzQTn+fen4Ue8WVbBSj5t/vcZrUyaNmgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xbphVhH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742aa6581caso934760b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748543181; x=1749147981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIz4VHixxBnPERxzo7x/dFPIiGKuMB366F2mMctZln0=;
        b=4xbphVhHNXA6yZbetoaVij+4KNPK54hyCUs/hpeo7rdcXAnr3JDi0nhmSUqGZQTvlR
         EZAjsY0mZoosFQ/QFMHhSBzO3veeYhHPV16GUGjxLnvJiqXP7mjO003D66gsMES7P08/
         rFglmdTGrJ0UFYeusyqVe5ncDZ9axlvJnUozo0rjPjJXyC7QIxxQo3a/Xa+GX8Cplkhb
         2XL1ywqYpfKq84OsPTI5kFSKdBDhXvPnpiBlAOAoBtzzeJYheXrPHFUr8slhBnjAVlV4
         WQQPrmedUrCW6X81UOZdcMQq1pT+0Lpowoh7hPLo292VVFjtqNEfV5wIIdDMXClJI4NB
         mqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748543181; x=1749147981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIz4VHixxBnPERxzo7x/dFPIiGKuMB366F2mMctZln0=;
        b=PrSElNbI1yx/n5I0YVfRXunhm6UWGZHw7qupzKiSHSg6C/ZoCgL8+9ja5gE1FRn4Xy
         0EY+4ZphPaVZHxE86nph8+wUm91KDH0tmUKpSxHXOy6PVYesYLba7Iho249f/FJbfQb0
         /R3qUDD5UNvb3LXDuUhpKU9as/GA/dVyHxpwJEqepMAnRVZnUal6Mzbv6dw7lZk8tFGX
         5OJzLuLa26W2zrwvYHkEF62aId7x1SJSdNRy1VLyHG1xp5XQAlZB2X5oPUFZN9c0lPjY
         MXuhsj6KRUzZ70FasPl4KLdibjuWuNYJe9JGCFw9kik+X0HJ0dkdpjrwsslSxgfvzpAb
         +oTA==
X-Forwarded-Encrypted: i=1; AJvYcCXVLsuXSf62rQZRyzxkeCN0Pz0KTGzTp0ok0k5jNB8KPZBLOc5hBegbWIAPZMXW8w6LPDaYQFSm7JKkWgAQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2bt5rHyNSJovFDA0CSy/Y8LGImwiDGVfM8IdaDwLJVpxYGYx
	T2Q6h1tqpJYZ5sckqf9a2+4EAt66P2CTq0/hqx7h4foL5sePjR9A3BBnp5apLfDnb+6xvwrPf8g
	lnsNl+fE8fitSpS07TvoV5UWBjw==
X-Google-Smtp-Source: AGHT+IGjY0JDCBO+9ghg+QzLazgbH2ijeDdvz/kcUyol+8Id7VYmeYH8PDj4sd4Uw3Qudd2dyxDoTCTFkpAd+/2KBw==
X-Received: from pfve9.prod.google.com ([2002:a05:6a00:1a89:b0:73c:26eb:39b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc9:b0:742:8d52:62f1 with SMTP id d2e1a72fcca58-747bd97d3abmr694232b3a.8.1748543180604;
 Thu, 29 May 2025 11:26:20 -0700 (PDT)
Date: Thu, 29 May 2025 11:26:19 -0700
In-Reply-To: <9483e9e3-9b29-49c6-adcc-04fe45ac28fd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <9483e9e3-9b29-49c6-adcc-04fe45ac28fd@linux.intel.com>
Message-ID: <diqz7c1z6zp0.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
From: Ackerley Tng <ackerleytng@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
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

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>> Track guest_memfd memory's shareability status within the inode as
>> opposed to the file, since it is property of the guest_memfd's memory
>> contents.
>>
>> Shareability is a property of the memory and is indexed using the
>> page's index in the inode. Because shareability is the memory's
>> property, it is stored within guest_memfd instead of within KVM, like
>> in kvm->mem_attr_array.
>>
>> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
>> retained to allow VMs to only use guest_memfd for private memory and
>> some other memory for shared memory.
>>
>> Not all use cases require guest_memfd() to be shared with the host
>> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
>> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
>> private to the guest, and therefore not mappable by the
>> host. Otherwise, memory is shared until explicitly converted to
>> private.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Co-developed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
>> ---
>>   Documentation/virt/kvm/api.rst |   5 ++
>>   include/uapi/linux/kvm.h       |   2 +
>>   virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 86f74ce7f12a..f609337ae1c2 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>>   The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>>   This is validated when the guest_memfd instance is bound to the VM.
>>   
>> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
>> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.
>
> It seems that the sentence is stale?
> Didn't find the definition of KVM_CAP_GMEM_CONVERSIONS.
>

Thanks. This should read

If the capability KVM_CAP_GMEM_SHARED_MEM is supported, and
GUEST_MEMFD_FLAG_SUPPORT_SHARED is specified, then the 'flags' field
supports GUEST_MEMFD_FLAG_INIT_PRIVATE.

>> Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
>> +will initialize the memory for the guest_memfd as guest-only and not faultable
>> +by the host.
>> +
> [...]
>>   
>>   static int kvm_gmem_init_fs_context(struct fs_context *fc)
>> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>>   static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>   						      loff_t size, u64 flags)
>>   {
>> +	struct kvm_gmem_inode_private *private;
>>   	struct inode *inode;
>> +	int err;
>>   
>>   	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>>   	if (IS_ERR(inode))
>>   		return inode;
>>   
>> +	err = -ENOMEM;
>> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
>> +	if (!private)
>> +		goto out;
>> +
>> +	mt_init(&private->shareability);
>
> shareability is defined only when CONFIG_KVM_GMEM_SHARED_MEM enabled, should be done within CONFIG_KVM_GMEM_SHARED_MEM .
>
>

Yes, thank you! Will also update this to only initialize shareability if
(flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED).

>> +	inode->i_mapping->i_private_data = private;
>> +
>> +	err = kvm_gmem_shareability_setup(private, size, flags);
>> +	if (err)
>> +		goto out;
>> +
>>   	inode->i_private = (void *)(unsigned long)flags;
>>   	inode->i_op = &kvm_gmem_iops;
>>   	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>   	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>   
>>   	return inode;
>> +
>> +out:
>> +	iput(inode);
>> +
>> +	return ERR_PTR(err);
>>   }
>>   
>>
> [...]

