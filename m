Return-Path: <linux-fsdevel+bounces-75142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULD6BAxxcmlpkwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:48:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5A6CAB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD23C300342B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08948377561;
	Thu, 22 Jan 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MJHsmS6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03D3EBF03;
	Thu, 22 Jan 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107711; cv=none; b=mdJvft92ImXQ1WDmbr1bB/kT+vfqdzo65wxV7hk5nbU3OxvphZN+/kCsL7MTxVGbikHWtnhN9uXiYOW/v0ii8oWazlh2ld2KmuvvsV7aa2N13hrW48vGMxVZPmwFPvEyor0FzPToAh6rwD7BTRzmZiELRsK5z9tMituNxQvzRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107711; c=relaxed/simple;
	bh=e473fGbaxEFgQov/AWdKjragoZNg0WVx0cwAlSFTVVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJ5U9tM0oO2q9RzVrHlSIO/jsP5B4fKfbLa/hcOsLIx7BiXMRz4R9Qs52nHV83btDC3l2LcpGVidarur4v9TLL00Qod3kKdcIJ8u08rQkcYTSfH6fFnvjO5IZCuaZoIoG4vl6qg1MQqeUt+c8KYq0c1tUB3hJ+mAwyJeZC7WJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MJHsmS6+; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769107706; x=1800643706;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=EvBM3L4II/cGkagk2VbdKNvKqQzeUtAnRgo+PSoIV/Y=;
  b=MJHsmS6+mfH44e8BXBEhngiAk4MKZAiWWgJy1uRFQ4V6WBLfGuNZKbwZ
   fiz+6bzSVYAsekdqIH74MmSxIRoTU9czCYllXjLu3vaEG+gToXvxCkfEF
   PGXyuy3UFB/E46qsjYGFFKU837+iOfsOf/fZuocv82Gd0HdR3929b/m0K
   mOBEv42ebZ5DBfB2GcWwy2OCS9SI6u0IbFOL1L7opBrAXP4pvAglGLmEX
   wFR0Kwi+85ket/Th484vnHIfMngW170wmjuVG9QaWXDrtmYhu/VPa14h5
   bUADxVqlQFE9x5JB4yAjuglHeMLPUFkQL1A7HWEAnLWyU5vGgoEW6Ew9U
   A==;
X-CSE-ConnectionGUID: tcmKhT3uQH6oov/07SCvrg==
X-CSE-MsgGUID: qNQV+8P6Qz6tQEAKSD8cQQ==
X-IronPort-AV: E=Sophos;i="6.21,246,1763424000"; 
   d="scan'208";a="8196021"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 18:48:03 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:17130]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.47:2525] with esmtp (Farcaster)
 id 32c357db-7900-4592-9eca-47dae0cab1ce; Thu, 22 Jan 2026 18:48:02 +0000 (UTC)
X-Farcaster-Flow-ID: 32c357db-7900-4592-9eca-47dae0cab1ce
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 22 Jan 2026 18:48:02 +0000
Received: from [192.168.23.186] (10.106.82.17) by
 EX19D005EUB003.ant.amazon.com (10.252.51.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 22 Jan 2026 18:47:43 +0000
Message-ID: <cfb0b8e8-b12a-4014-9070-63cfe8693f59@amazon.com>
Date: Thu, 22 Jan 2026 18:47:41 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
To: Ackerley Tng <ackerleytng@google.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kalyazin@amazon.co.uk"
	<kalyazin@amazon.co.uk>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
CC: "david@kernel.org" <david@kernel.org>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>,
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"maz@kernel.org" <maz@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "Annapurve, Vishal"
	<vannapurve@google.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"pjw@kernel.org" <pjw@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"willy@infradead.org" <willy@infradead.org>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "wyihan@google.com" <wyihan@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>,
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "haoluo@google.com" <haoluo@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk"
	<itazur@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com"
	<derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"jannh@google.com" <jannh@google.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-8-kalyazin@amazon.com>
 <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
 <294bca75-2f3e-46db-bb24-7c471a779cc1@amazon.com>
 <CAEvNRgEvd9tSwrkaYrQyibO2DP99vgVj6_zr=jBH5+zMnJwYbA@mail.gmail.com>
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
In-Reply-To: <CAEvNRgEvd9tSwrkaYrQyibO2DP99vgVj6_zr=jBH5+zMnJwYbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D011EUA001.ant.amazon.com (10.252.50.114) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75142-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,arm.com,linux.ibm.com,suse.com,google.com,surriel.com,suse.de,redhat.com,linux.intel.com,suse.cz,ghiti.fr,linutronix.de,infradead.org,os.amperecomputing.com,linux.dev,linux-foundation.org,ziepe.ca,zytor.com,loongson.cn,oracle.com,nvidia.com,intel.com,huawei.com,gmail.com,amd.com,amazon.co.uk,iogearbox.net,eecs.berkeley.edu,amazon.com,fomichev.me,alien8.de,lwn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	HAS_REPLYTO(0.00)[kalyazin@amazon.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BCF5A6CAB8
X-Rspamd-Action: no action



On 22/01/2026 18:37, Ackerley Tng wrote:
> Nikita Kalyazin <kalyazin@amazon.com> writes:
> 
>> On 16/01/2026 00:00, Edgecombe, Rick P wrote:
>>> On Wed, 2026-01-14 at 13:46 +0000, Kalyazin, Nikita wrote:
>>>> +static void kvm_gmem_folio_restore_direct_map(struct folio *folio)
>>>> +{
>>>> +     /*
>>>> +      * Direct map restoration cannot fail, as the only error condition
>>>> +      * for direct map manipulation is failure to allocate page tables
>>>> +      * when splitting huge pages, but this split would have already
>>>> +      * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().
> 
> Do you know if folio_restore_direct_map() will also end up merging page
> table entries to a higher level?

By looking at the callchain in x86 at least, I can't see how it would.

> 
>>>> +      * Thus folio_restore_direct_map() here only updates prot bits.
>>>> +      */
>>>> +     if (kvm_gmem_folio_no_direct_map(folio)) {
>>>> +             WARN_ON_ONCE(folio_restore_direct_map(folio));
>>>> +             folio->private = (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>>>> +     }
>>>> +}
>>>> +
>>>
>>> Does this assume the folio would not have been split after it was zapped? As in,
>>> if it was zapped at 2MB granularity (no 4KB direct map split required) but then
>>> restored at 4KB (split required)? Or it gets merged somehow before this?
> 
> I agree with the rest of the discussion that this will probably land
> before huge page support, so I will have to figure out the intersection
> of the two later.
> 
>>
>> AFAIK it can't be zapped at 2MB granularity as the zapping code will
>> inevitably cause splitting because guest_memfd faults occur at the base
>> page granularity as of now.
> 
> Here's what I'm thinking for now:
> 
> [HugeTLB, no conversions]
> With initial HugeTLB support (no conversions), host userspace
> guest_memfd faults will be:
> 
> + For guest_memfd with PUD-sized pages
>      + At PUD level or PTE level
> + For guest_memfd with PMD-sized pages
>      + At PMD level or PTE level
> 
> Since this guest_memfd doesn't support conversions, the folio is never
> split/merged, so the direct map is restored at whatever level it was
> zapped. I think this works out well.
> 
> [HugeTLB + conversions]
> For a guest_memfd with HugeTLB support and conversions, host userspace
> guest_memfd faults will always be at PTE level, so the direct map will
> be split and the faulted pages have the direct map zapped in 4K chunks
> as they are faulted.
> 
> On conversion back to private, put those back into the direct map
> (putting aside whether to merge the direct map PTEs for now).
> 
> 
> Unfortunately there's no unmapping callback for guest_memfd to use, so
> perhaps the principle should be to put the folios back into the direct
> map ASAP - at unmapping if guest_memfd is doing the unmapping, otherwise
> at freeing time?


