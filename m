Return-Path: <linux-fsdevel+bounces-63386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA3BB7B6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5711B208B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858632DA77F;
	Fri,  3 Oct 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PYzluhqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D323AB8B;
	Fri,  3 Oct 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512257; cv=none; b=HzrQ33R6jSr73rss7QJqqKnvn011X9VpLQm/MyxJKuP4S6singbOibSfDgVj7qxxn1aEVbB7vQ25mAkx1XYXKO2KHHyLRlf9HGw0tECR2NWawwSRT2WyEFtxIfu/lfCMxv2V6qU9mVT2WZG1Xfaka8HSi/73c7Qj6tNOXJjaCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512257; c=relaxed/simple;
	bh=mFfzPBlsrBjZYoYWR5CsI5nmru5owMjyTu2F9V71tbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RLgvw3Fl5LNVXnK9/PZ/uTYyPls+YRjK9HqBsWGQRzmgvks4JuRyq0C2122Ct9M6xZHki2TODAbb3SFS51W9lFA/jKdx/eewvoMtCAAOIjpH4k3XvcW1C2srTV5yhUj4Omu9tl1V2nAeO+T+fZxE9N+et9q23qzosi6zOeYt64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PYzluhqd; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759512256; x=1791048256;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=eKU8SJ09O6RAdk9rzTuf+EPgBar7M5OPCHBeslmadhA=;
  b=PYzluhqdFytr1f+tIZuEP0ntdTnpWqNu0WSc/koi1UXBGs5BjfXL0nAh
   +U3k4A0OniF19BA7AUoqLRtAIUFdHBMLQ1NQEzjX50OjBeNa8pY3iURWW
   end8AbZsvxBHjUyhmuwK2PBeIFaciTo1Lul/fIdrxt7j41PSLCrbXsHiB
   nIZpUsxFBLjjfLcUtk3aHgGAOLU6CfUpFlREe+2nN8MCibzc0mgaqCqg3
   b/mpAgwQAcc3iDecGybznr6u8ffqfZZp2BdmqywoL5cZIRJKCNRpKxib7
   CMZMi91qiIRjyQFVwft0oXCKXh/a1nkAsALSKKfbGDPHHX8lPYi8p4iHa
   g==;
X-CSE-ConnectionGUID: /bGeMqI5QHGO7ZeMBtXCHg==
X-CSE-MsgGUID: d1ZXsYzERHSwet8rfgRFpg==
X-IronPort-AV: E=Sophos;i="6.18,313,1751241600"; 
   d="scan'208";a="2975643"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 17:24:05 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:5746]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.147:2525] with esmtp (Farcaster)
 id f44c7b7f-75fc-43b3-8033-16cf4d5d0ded; Fri, 3 Oct 2025 17:24:04 +0000 (UTC)
X-Farcaster-Flow-ID: f44c7b7f-75fc-43b3-8033-16cf4d5d0ded
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 17:24:04 +0000
Received: from [192.168.4.149] (10.106.83.12) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 17:24:02 +0000
Message-ID: <fc0bb268-07b7-41ef-9a82-791d381f56ac@amazon.com>
Date: Fri, 3 Oct 2025 18:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH 15/34] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	"Oliver Upton" <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
	"Michael Ellerman" <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
	"Paul Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson
	<seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, "Andrew Morton" <akpm@linux-foundation.org>
CC: <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kvm-riscv@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, Jarkko Sakkinen
	<jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, David Matlack
	<dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?=
	<mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve
	<vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, "Maciej
 Szmigiero" <mail@maciej.szmigiero.name>, David Hildenbrand
	<david@redhat.com>, Quentin Perret <qperret@google.com>, Michael Roth
	<michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, Liam Merwick
	<liam.merwick@oracle.com>, "Isaku Yamahata" <isaku.yamahata@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
 <20231105163040.14904-16-pbonzini@redhat.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <20231105163040.14904-16-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D013EUA004.ant.amazon.com (10.252.50.48) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 05/11/2023 16:30, Paolo Bonzini wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Introduce an ioctl(), KVM_CREATE_GUEST_MEMFD, to allow creating file-based
> memory that is tied to a specific KVM virtual machine and whose primary
> purpose is to serve guest memory.

...
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f1a575d39b3b..8f46d757a2c5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

...

> -static int check_memory_region_flags(const struct kvm_userspace_memory_region2 *mem)
> +static int check_memory_region_flags(struct kvm *kvm,
> +				     const struct kvm_userspace_memory_region2 *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>   
> +	if (kvm_arch_has_private_mem(kvm))
> +		valid_flags |= KVM_MEM_GUEST_MEMFD;
> +
> +	/* Dirty logging private memory is not currently supported. */
> +	if (mem->flags & KVM_MEM_GUEST_MEMFD)
> +		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;

I was wondering whether this restriction is still required at this stage 
or can be lifted in cases where the guest memory is accessible by the 
host.  Specifically, it would be useful to support differential memory 
snapshots based on dirty page tracking in Firecracker [1] or in live 
migration.  As an experiment, I removed the check and was able to 
produce a diff snapshot and restore a Firecracker VM from it.

[1] 
https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/snapshot-support.md#creating-diff-snapshots

> +
>   #ifdef __KVM_HAVE_READONLY_MEM
>   	valid_flags |= KVM_MEM_READONLY;
>   #endif
> @@ -2018,7 +2029,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	int as_id, id;
>   	int r;
>   
> -	r = check_memory_region_flags(mem);
> +	r = check_memory_region_flags(kvm, mem);
>   	if (r)
>   		return r;

