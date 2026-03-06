Return-Path: <linux-fsdevel+bounces-79623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGdYJ3fpqmmOYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:49:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC62230C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA66303A84E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472C3A9DAE;
	Fri,  6 Mar 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fonT5YtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903C3382FC;
	Fri,  6 Mar 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808551; cv=none; b=Psu1dAEhH2KprCP2bSN1J2eukWTYZLSERLJUroO15Fch29btLlnee98glXLjZLazOtAFy7s9FMgxAAkwBOTLkeFafqVLyeD1w3eg3xYxGQZALKoxU/ldl526jq2T3mkf/Sab8fYGDfB9XYYcr/AUlUT1mcGuqy0Tgrf8DKyZ4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808551; c=relaxed/simple;
	bh=8bmP3Oyc5gkMF738qgsi2QsdZpPm2BaaO2Zy05DiOgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=okXPrYZmuiRK5tkHPurtnWd3Mch659ioVnyKqaQWm8uXbrtkbPm9RuxVqqpS49EJwwTAHSokMqmmS9i4uvLjOhd4CHU7jBRf+IakAGFQHjIuIsvsmxR9DcNmaE8Txr+RnRXOubqKO21kcgIQXIYaB9dTq8JmTD/7t1lD/CP+RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fonT5YtO; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772808549; x=1804344549;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Jal/VdxlygY/Jp/VACbX2II5K9b9pb+hAy31tgKOGlo=;
  b=fonT5YtOX03ZXWHcN5zVbmcTqGzvDBPFtKyD9oVxn8RvqIo+6W8KzN5R
   9vvl43mlh6cZ4bPho1Zdb+HCmdaXwMGnG8u1M2qgORzPY2hPAc/S/vW7z
   OifqJSPO2E2ub3KDB9nvRrFtTzlee00Bvxt1UB6cxnCEHrx8HsimtRb5w
   DdHcZp939e9AuA3ROqJLjiMlfmgiJIDZY7QPbtpRwrKMNp5aE+AD3lfsH
   1SZKSI3PVf8MhquUgkCKxGZ0eHGzNh3rrmq9bdru7V7/mwH/4YsAU5qCx
   S7MNCAxoxfk2vH5dT+MqxXwdt4ekkcjmjT9j4CSxCJY+OuO6PAYTgEWeW
   A==;
X-CSE-ConnectionGUID: ljHSVQB7TzG5jw32RYNa5w==
X-CSE-MsgGUID: OUQPopD9QXKeR6PpigJL3Q==
X-IronPort-AV: E=Sophos;i="6.23,105,1770595200"; 
   d="scan'208";a="10442482"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:49:04 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:10240]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.96:2525] with esmtp (Farcaster)
 id 785449e4-4a3c-45cd-8b65-b1aa1ddf183f; Fri, 6 Mar 2026 14:49:04 +0000 (UTC)
X-Farcaster-Flow-ID: 785449e4-4a3c-45cd-8b65-b1aa1ddf183f
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 6 Mar 2026 14:49:04 +0000
Received: from [192.168.2.180] (10.106.83.26) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 6 Mar 2026
 14:48:58 +0000
Message-ID: <38deb26a-918c-4743-b35f-92a1330dbf40@amazon.com>
Date: Fri, 6 Mar 2026 14:48:57 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v10 02/15] set_memory: add folio_{zap, restore}_direct_map
 helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com"
	<jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>
References: <20260126164445.11867-1-kalyazin@amazon.com>
 <20260126164445.11867-3-kalyazin@amazon.com>
 <af2d4dcd-60a8-4a5a-b508-d9600b1f2275@kernel.org>
 <e2834fd9-e4ec-473c-90cd-6c3a5049747f@amazon.com>
 <40bd6f9b-d5c0-4844-81bc-d221cd9b058f@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
In-Reply-To: <40bd6f9b-d5c0-4844-81bc-d221cd9b058f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D005EUB004.ant.amazon.com (10.252.51.126) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)
X-Rspamd-Queue-Id: 59CC62230C8
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
	TAGGED_FROM(0.00)[bounces-79623-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
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
	RCPT_COUNT_GT_50(0.00)[104];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[kalyazin@amazon.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 06/03/2026 14:17, David Hildenbrand (Arm) wrote:
> On 3/6/26 13:48, Nikita Kalyazin wrote:
>>
>>
>> On 05/03/2026 17:34, David Hildenbrand (Arm) wrote:
>>> On 1/26/26 17:47, Kalyazin, Nikita wrote:
>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>>
>>>> These allow guest_memfd to remove its memory from the direct map.
>>>> Only implement them for architectures that have direct map.
>>>> In folio_zap_direct_map(), flush TLB on architectures where
>>>> set_direct_map_valid_noflush() does not flush it internally.
>>>
>>> "Let's provide folio_{zap,restore}_direct_map helpers as preparation for
>>> supporting removal of the direct map for guest_memfd folios. ...
>>
>> Will update, thanks.
>>
>>>
>>>>
>>>> The new helpers need to be accessible to KVM on architectures that
>>>> support guest_memfd (x86 and arm64).  Since arm64 does not support
>>>> building KVM as a module, only export them on x86.
>>>>
>>>> Direct map removal gives guest_memfd the same protection that
>>>> memfd_secret does, such as hardening against Spectre-like attacks
>>>> through in-kernel gadgets.
>>>
>>> Would it be possible to convert mm/secretmem.c as well?
>>>
>>> There, we use
>>>
>>>           set_direct_map_invalid_noflush(folio_page(folio, 0));
>>>
>>> and
>>>
>>>           set_direct_map_default_noflush(folio_page(folio, 0));
>>>
>>> Which is a bit different to below code. At least looking at the x86
>>> variants, I wonder why we don't simply use
>>> set_direct_map_valid_noflush().
>>>
>>>
>>> If so, can you add a patch to do the conversion, pleeeeassse ? :)
>>
>> Absolutely!
>>
>>>
>>>>
>>>> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
>>>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>>>> ---
>>>>    arch/arm64/include/asm/set_memory.h     |  2 ++
>>>>    arch/arm64/mm/pageattr.c                | 12 ++++++++++++
>>>>    arch/loongarch/include/asm/set_memory.h |  2 ++
>>>>    arch/loongarch/mm/pageattr.c            | 12 ++++++++++++
>>>>    arch/riscv/include/asm/set_memory.h     |  2 ++
>>>>    arch/riscv/mm/pageattr.c                | 12 ++++++++++++
>>>>    arch/s390/include/asm/set_memory.h      |  2 ++
>>>>    arch/s390/mm/pageattr.c                 | 12 ++++++++++++
>>>>    arch/x86/include/asm/set_memory.h       |  2 ++
>>>>    arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++
>>>>    include/linux/set_memory.h              | 10 ++++++++++
>>>>    11 files changed, 88 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/
>>>> include/asm/set_memory.h
>>>> index c71a2a6812c4..49fd54f3c265 100644
>>>> --- a/arch/arm64/include/asm/set_memory.h
>>>> +++ b/arch/arm64/include/asm/set_memory.h
>>>> @@ -15,6 +15,8 @@ int set_direct_map_invalid_noflush(const void *addr);
>>>>    int set_direct_map_default_noflush(const void *addr);
>>>>    int set_direct_map_valid_noflush(const void *addr, unsigned long
>>>> numpages,
>>>>                                  bool valid);
>>>> +int folio_zap_direct_map(struct folio *folio);
>>>> +int folio_restore_direct_map(struct folio *folio);
>>>>    bool kernel_page_present(struct page *page);
>>>>
>>>>    int set_memory_encrypted(unsigned long addr, int numpages);
>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>> index e2bdc3c1f992..0b88b0344499 100644
>>>> --- a/arch/arm64/mm/pageattr.c
>>>> +++ b/arch/arm64/mm/pageattr.c
>>>> @@ -356,6 +356,18 @@ int set_direct_map_valid_noflush(const void
>>>> *addr, unsigned long numpages,
>>>>         return set_memory_valid((unsigned long)addr, numpages, valid);
>>>>    }
>>>>
>>>> +int folio_zap_direct_map(struct folio *folio)
>>>> +{
>>>> +     return set_direct_map_valid_noflush(folio_address(folio),
>>>> +                                         folio_nr_pages(folio), false);
>>>> +}
>>>> +
>>>> +int folio_restore_direct_map(struct folio *folio)
>>>> +{
>>>> +     return set_direct_map_valid_noflush(folio_address(folio),
>>>> +                                         folio_nr_pages(folio), true);
>>>> +}
>>>
>>> Is there a good reason why we cannot have two generic inline functions
>>> that simply call set_direct_map_valid_noflush() ?
>>>
>>> Is it because of some flushing behavior? (which we could figure out)
>>
>> Yes, on x86 we need an explicit flush.  Other architectures deal with it
>> internally.
> 
> So, we call a _noflush function and it performs a ... flush. What.

Yeah, that's unfortunately the status quo as pointed by Aneesh [1]

[1] https://lore.kernel.org/kvm/yq5ajz07czvz.fsf@kernel.org/

> 
> Take a look at secretmem_fault(), where we do an unconditional
> flush_tlb_kernel_range().
> 
> Do we end up double-flushing in that case?

Yes, looks like that.  I'll remove the explicit flush and rely on 
folio_zap_direct_map().

> 
>> Do you propose a bespoke implementation for x86 and a
>> "generic" one for others?
> 
> We have to find a way to have a single set of functions for all archs
> that support directmap removal.

I believe Dave meant to address that with 
folio_{zap,restore}_direct_map() [2].

[2] 
https://lore.kernel.org/kvm/9409531b-589b-4a54-b122-06a3cf0846f3@intel.com/

> 
> One option might be to have some indication from the architecture that
> no flush_tlb_kernel_range() is required.
> 
> Could be a config option or some simple helper function.

I'd be inclined to know what arch maintainers think because I don't have 
a strong opinion on that.

> 
> --
> Cheers,
> 
> David


