Return-Path: <linux-fsdevel+bounces-65335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398FCC01AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD373BB24D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010631A56B;
	Thu, 23 Oct 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvgvWu7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907732AACB
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228078; cv=none; b=F7L9LaFx5fMejnDOKJ/b8Te8Tf+JMHNn5ezBEZ+/PJI2fze62iLNd0mZR0zylmoI37dO/RTtSHQ3pJzgoiKTBF6js466AC6PwcYtTUmn79W22zukfqcQJzvkJlviPEDbrRh08OdByiP5Ox2tHffb2fX5s7P5QSuBAAnb4Bd43Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228078; c=relaxed/simple;
	bh=nf2ne/DcUThRcyjkcAtbjjiK8XPQU5PLVC7WSh7jfZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsmlktkvVed/rKcb9EL3dzKhRWRQU0kAfQB6fLewr7oz+l4IdI05I92sTRglZTE+YunF/X1jfRIRNJUbXn0xZpQMyoTZ7jqRFdMGNZlc35V5DQ3y5SIvLfWhdyY22DZj61LmQWdvf3dAXv+9NMU7oc9fN+4yam6ZCQ1fSc8bEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvgvWu7l; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7810289cd5eso1884489b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761228075; x=1761832875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inXfddpf6Feyogc8n8Jl5cqVWZOSr51ivnMHY9v0Ey4=;
        b=FvgvWu7lfkFsFHXEZtj4lw7glbTHzzUEGsEFkLBSyj5lOlrLDU1oghGofvy5n8eOsf
         hNVds9VXo38wQYB6NTIGzXHSQxJqYajWlPt7009pp2gIii3hh6WwEU9ZD/I4QT7d2bea
         WCWA56SQxCTKKATjTNzT+lP8oUtynF4+UfwgKPQjst0Xh/ycZHGg8SpB0lZqE/5jPJp6
         CFTvHYr2ydcrrce3Dm0itC9rIq2bP6EIsKxFqfTiJrJTlg+JsT7q3befgm83FU6T6yNe
         NI15GlfmkS+YcZs/EH0m47+UgRKGlt6IVvi766TFbKBUkqMBdAj7OK5mBSQiizp6e0mx
         bTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228075; x=1761832875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inXfddpf6Feyogc8n8Jl5cqVWZOSr51ivnMHY9v0Ey4=;
        b=m8NOpxXL+roR/3S8Jys+ljuvLOJ8D5H8g7cSymU5wJo7Qq/NigRzpDfop+0MZqNSpW
         juR4ZvfkEo/4ycJ/XVRx8ROu3Z0WiPneivUtSKQy04kgi94Cp6Ilxs9+Hym6joGS44L8
         uyuV0RGIXpM1W/wAHoa+zb6eSYJtLckMqQAH1atTBesdOXDhj1swi31lg8BVS6sqBV8S
         I2QanzhecWkRu0ZIsN7Ois4wGpWer+06W4SQPEVZaLjvdbSUgwHjmEZlr1nqvLn6VLUc
         PPXoMQL3KiGXMB6hzgTPmzv1P8gv4pCQVX2rvShedKwC2SgZqK5WQkyGuISPsX4ouAU3
         zE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEboeJY4akrdZBtXmiSo3DoZmvpvjqbytQTXF3ys1bbsaD8cy6FMUjXuPSC4PWelrYQxXHRqYu8JkfxoAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwINcKsh8ry/BPOijLGpvHulSTxoDdkBzDKjBDbMJ02OzuBTygk
	pyZmaZog7av+JQpF6NW7ue5856kHBFqaU5sGX6WJ5TKRrO3ouhBUdpxVxoseHcxUExM4GJOwiQG
	Genky2hCw9pU3sGdE4x49H2l0hw==
X-Google-Smtp-Source: AGHT+IFIN8uFRC6EtqcEGeMEkYd8inzutN6W/XJij2WhQjtYZx5ArSxhlm3XOqfP/3yjcqmWzVtyJ1fSE/ev6eLgRw==
X-Received: from pjnu4.prod.google.com ([2002:a17:90a:8904:b0:339:dc19:ae5d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3956:b0:334:91ab:f182 with SMTP id adf61e73a8af0-334a85286f8mr35842433637.10.1761228074886;
 Thu, 23 Oct 2025 07:01:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 07:01:13 -0700
In-Reply-To: <aPlpKbHGea90IebS@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
Message-ID: <diqzv7k5emza.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
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
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 22, 2025, Ackerley Tng wrote:
>> Ackerley Tng <ackerleytng@google.com> writes:
>> 
>> Found another issue with KVM_CAP_MEMORY_ATTRIBUTES2.
>> 
>> KVM_CAP_MEMORY_ATTRIBUTES2 was defined to do the same thing as
>> KVM_CAP_MEMORY_ATTRIBUTES, but that's wrong since
>> KVM_CAP_MEMORY_ATTRIBUTES2 should indicate the presence of
>> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2.
>
> No?  If no attributes are supported, whether or not KVM_SET_MEMORY_ATTRIBUTES2
> exists is largely irrelevant.

That's true.

> We can even provide the same -ENOTTY errno by
> checking that _any_ attributes are supported, i.e. so that doing
> KVM_SET_MEMORY_ATTRIBUTES2 on KVM without any support whatsoever fails in the
> same way that KVM with code support but no attributes fails.
>

IIUC KVM_SET_MEMORY_ATTRIBUTES doesn't fail with -ENOTTY now when there
are no valid attributes.

Even if there's no valid attributes (as in
kvm_supported_mem_attributes() returns 0), it's possible to call
KVM_SET_MEMORY_ATTRIBUTES with .attributes set to 0, which will be a
no-op, but will return 0.

I think this is kind of correct behavior since .attributes = 0 is
actually a valid expression for "I want this range to be shared", and
for a VM that doesn't support private memory, it's a valid expression.


The other way that there are "no attributes" would be if there are no
/VM/ attributes, in which case KVM_SET_MEMORY_ATTRIBUTES, sent to as a
vm ioctl, will return -ENOTTY.

> In other words, I don't see why it can't do both.  Even if we can't massage the
> right errno, I would much rather KVM_SET_MEMORY_ATTRIBUTES2 enumerate the set of

Did you mean KVM_CAP_MEMORY_ATTRIBUTES2 in the line above?

> supported attributes than simply '1'.  E.g. we have no plans to support
> KVM_SET_MEMORY_ATTRIBUTES on guest_memfd, and so returning simply '1' creates an
> unwanted and unnecessary dependency.
>

Okay I'll switch this back to what it was.

>> @@ -1617,4 +1618,15 @@ struct kvm_pre_fault_memory {
>>  	__u64 padding[5];
>>  };
>>  
>> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES2 */
>> +#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd6, struct kvm_memory_attributes2)
>
> Please use the same literal number, 0xd2, as
>
>   #define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct kvm_memory_attributes)
>
> The "final" ioctl number that userspace sees incorporates the directionality and
> the size of the struct, i.e. KVM_SET_MEMORY_ATTRIBUTES and KVM_SET_MEMORY_ATTRIBUTES2
> are guaranteed to be distinct even if they both use 0xd2 as the "minor" number.
>

Will do.

>> +
>> +struct kvm_memory_attributes2 {
>> +	__u64 address;
>> +	__u64 size;
>> +	__u64 attributes;
>> +	__u64 flags;
>> +	__u64 reserved[4];
>
> Maybe be paranoid and reserve 12 u64s?

Will do.

