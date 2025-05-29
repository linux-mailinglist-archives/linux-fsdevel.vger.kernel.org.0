Return-Path: <linux-fsdevel+bounces-50105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0CAC834C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4742AA2507A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB06292921;
	Thu, 29 May 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qs46Qli6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E429290B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551082; cv=none; b=tEjtLQraIaHAf73wU1sAglCMDsog0/vvbosJqUDtB+Pet4y3yDsY2zVjeIIVHqjE/xCZV42EMTV1Gpec1pmvmTHKZRD+FOkTNdLPosuDmc4G/AvIiJvLqGp+9lcL75JrPd+v7Sz6u4eW8IXYJNJCzQv7L7k2F8gzcQHEHPTAjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551082; c=relaxed/simple;
	bh=YlMZkgKT0PTtfAbkMV6chM1PgSM2gnGOq/j8wCCE5T0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVmm/uR3oYm+xW9u3m+NePHg4AI4ywxUb6V67IREzRIcDj+lP+AIPG2fZCvbwmB449UP0AbUDpdWhLkuJEvHlFM8TIjBd0sEgBF1V4GunCakv8YmU37htiT7ioNfTCuQb5knsE9JIqARbZyGcFg5/6j72Jg4NmKtf9F8kyqty4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qs46Qli6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso1019559b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748551080; x=1749155880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V0aEgZlDdaEbVhQ7MZDJBQiQ6ReHKrQ1z+MrifNuLA=;
        b=qs46Qli6aiR/YW2e7BoII3FqwZG4mgGOI9IdPrQ/I6xQWFNZRc0to4+7N+kzoQ/OiG
         OmooqyzoJHNZ2x3MfgWRGFiS1sjXdpeSTs8ie3m8hgqVHxoG71sicKB3qN2f0BeL9nBV
         bHfGtWJ46ZMb3rSVKx109Q6x0Cmwdf8hIvw8roJHdOGnCORwJczxhKhW1kvZS7tkOLKD
         ij4ppshscVdkSO73PUfgqqGVxfJ49VxUN0UsXYUyhJ6DSrYx7u5A2UloKv42XOy3fJs8
         GnlR8G19VTGsrb25Zv+/Y4Z3cACxxHDTJwL5Q/NldrKxFLNJ2rC4EAG556Ojk7oguMAN
         N0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748551080; x=1749155880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8V0aEgZlDdaEbVhQ7MZDJBQiQ6ReHKrQ1z+MrifNuLA=;
        b=pJq3BElOBErTXsI87k261Huctffqk+FoENedIjEp3RArekuFBf9MD7vlXq1udUnUVm
         DTGrd34Uj3e2SXBQDg6H0jexwOlFC7i0b1EJuMivZDo+XFTO28Ee7Ss0b+SUbFhF3RCL
         o9/WmmSCIzSzuEO7btIxCSEeyalNbuH92sdBEHF+oOgoSbcXx7mcROJjHTExSvRVlgyz
         e+Aa2G6rBMuvRheP15qz6S2EZbW69w1IYeeKuzZUpRagq0yAEcJAZsakVSZG80IyzqC+
         jnSIZ6T0fp4NFZW63xtukv/MP63/0a+upKuA5pc9oozlasg9CuVHTgPe+qggoQawszQo
         RCAA==
X-Forwarded-Encrypted: i=1; AJvYcCXGW4xEUgEGbCjAt22s6Xsk7e72btLlvBDBOMHvbZ9/0HC+ES79Q9yozwYkLM/L9mRqWTH/eNf1roBtPoZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXP4jmbsCL6F+Vji/4qA742FsCvUr7h+PKKJTTztWzk2kzmVj
	H+bG3icbKkZ19+pX6n9H40rWwsF4dINJ0uVz+Bb7l/+FM69lRcPZD6Da95aGHEHUOP/ZqFrd9Dq
	BLiAOvSd0t8tLHaWBhX0H1wDSqA==
X-Google-Smtp-Source: AGHT+IFjOdk4yT4NM/QaqhOJD4gsMe2ihRDu+Gs7HGOAnaMlSmAglIltMP37EmZjJc9BSmEgYJS63ATu0p6hhP84/w==
X-Received: from pfuw1.prod.google.com ([2002:a05:6a00:14c1:b0:746:32ae:99d5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8882:0:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-747bd97408amr1069146b3a.10.1748551079940;
 Thu, 29 May 2025 13:37:59 -0700 (PDT)
Date: Thu, 29 May 2025 13:37:58 -0700
In-Reply-To: <diqz7c1z6zp0.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <9483e9e3-9b29-49c6-adcc-04fe45ac28fd@linux.intel.com> <diqz7c1z6zp0.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <diqz34cn6tll.fsf@ackerleytng-ctop.c.googlers.com>
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
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Binbin Wu <binbin.wu@linux.intel.com> writes:
>
>> On 5/15/2025 7:41 AM, Ackerley Tng wrote:
>>> Track guest_memfd memory's shareability status within the inode as
>>> opposed to the file, since it is property of the guest_memfd's memory
>>> contents.
>>>
>>> Shareability is a property of the memory and is indexed using the
>>> page's index in the inode. Because shareability is the memory's
>>> property, it is stored within guest_memfd instead of within KVM, like
>>> in kvm->mem_attr_array.
>>>
>>> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
>>> retained to allow VMs to only use guest_memfd for private memory and
>>> some other memory for shared memory.
>>>
>>> Not all use cases require guest_memfd() to be shared with the host
>>> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
>>> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
>>> private to the guest, and therefore not mappable by the
>>> host. Otherwise, memory is shared until explicitly converted to
>>> private.
>>>
>>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>>> Co-developed-by: Fuad Tabba <tabba@google.com>
>>> Signed-off-by: Fuad Tabba <tabba@google.com>
>>> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
>>> ---
>>>   Documentation/virt/kvm/api.rst |   5 ++
>>>   include/uapi/linux/kvm.h       |   2 +
>>>   virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>>>   3 files changed, 129 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index 86f74ce7f12a..f609337ae1c2 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>>>   The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>>>   This is validated when the guest_memfd instance is bound to the VM.
>>>   
>>> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
>>> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.
>>
>> It seems that the sentence is stale?
>> Didn't find the definition of KVM_CAP_GMEM_CONVERSIONS.
>>
>
> Thanks. This should read
>
> If the capability KVM_CAP_GMEM_SHARED_MEM is supported, and
> GUEST_MEMFD_FLAG_SUPPORT_SHARED is specified, then the 'flags' field
> supports GUEST_MEMFD_FLAG_INIT_PRIVATE.
>

My bad, saw your other email. Fixing the above:

If the capability KVM_CAP_GMEM_CONVERSION is supported, and
GUEST_MEMFD_FLAG_SUPPORT_SHARED is specified, then the 'flags' field
supports GUEST_MEMFD_FLAG_INIT_PRIVATE.

>>> Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
>>> +will initialize the memory for the guest_memfd as guest-only and not faultable
>>> +by the host.
>>> +
>> [...]
>>>   
>>>   static int kvm_gmem_init_fs_context(struct fs_context *fc)
>>> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>>>   static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>>   						      loff_t size, u64 flags)
>>>   {
>>> +	struct kvm_gmem_inode_private *private;
>>>   	struct inode *inode;
>>> +	int err;
>>>   
>>>   	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>>>   	if (IS_ERR(inode))
>>>   		return inode;
>>>   
>>> +	err = -ENOMEM;
>>> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
>>> +	if (!private)
>>> +		goto out;
>>> +
>>> +	mt_init(&private->shareability);
>>
>> shareability is defined only when CONFIG_KVM_GMEM_SHARED_MEM enabled, should be done within CONFIG_KVM_GMEM_SHARED_MEM .
>>
>>
>
> Yes, thank you! Will also update this to only initialize shareability if
> (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED).
>
>>> +	inode->i_mapping->i_private_data = private;
>>> +
>>> +	err = kvm_gmem_shareability_setup(private, size, flags);
>>> +	if (err)
>>> +		goto out;
>>> +
>>>   	inode->i_private = (void *)(unsigned long)flags;
>>>   	inode->i_op = &kvm_gmem_iops;
>>>   	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>>   	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>>   
>>>   	return inode;
>>> +
>>> +out:
>>> +	iput(inode);
>>> +
>>> +	return ERR_PTR(err);
>>>   }
>>>   
>>>
>> [...]

