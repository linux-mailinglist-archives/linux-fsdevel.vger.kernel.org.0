Return-Path: <linux-fsdevel+bounces-73911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63BD240E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E2D305DE59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB537418C;
	Thu, 15 Jan 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZmBQUXDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0893624C4;
	Thu, 15 Jan 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475063; cv=none; b=PCpVEgi8kTopIScrdvxB1Yis7PeCAF2qQmrDVd+04rGOTYFD+qWdZK5IHBMoHyBJ7eDufI7lImCcTWPZPaQ+OeR/7BjMckJ9fT11aWDnAUsAtPBHiuCz1TNkIcmnFhaSNWJxnaoNC9Y/nKMR/mV3j9qJemByBGNdCqCwPj4JudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475063; c=relaxed/simple;
	bh=3PFB344/1JVRWGs+D2Rl641FmNl+HKaPGoGER5dyQi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=js1JkTQsyU4lBt1+gxms2CJ7BWrCCCKNOG8q7dAooOx5HCCRdX2n+gnecWwX707+rBYHDzDi7lAMJ/J82RpxZaVWUpbQUJdyJ1wJAaYBi9I7OPTPysesRw0Noy2Kup1nDHUqP2ibO0bNx21owyJP5XJdvwI7mMM9hKyqVw863/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZmBQUXDL; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768475061; x=1800011061;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=mJnfQzk/Ndl7hOirTyKcnaRJiF2TZLcunnrc7x/sQ1k=;
  b=ZmBQUXDLWchdhlsj5vu9AvEU8oKEzeIu33Z+vQuXFSwLfbjcBRCtEZWo
   JICKq3UXKJhE1dLYbbvjjccd+6ZiNsAXCYMFCxx48gNgQ62e8rYszP9Rj
   azoLXIZBgxn5V8mJR7K3+u4hfwndOBTZmgZqCXi+2y/WVjqUg0HyFC6dE
   YZebrDdeKyDmvaRRkUb+lcaONnxg0FJsR+ivzF1BzXrVrE9QgvN0itKei
   n+Uj5yL9ynq+ndbfG6Dwy0FF0v5ctNBB02ZS9ieqDgaUCqy/Hr9cGq9BM
   lw4eQ0nz3hYobDuOh09rK7DqWjuTeNtdbuAeu7EkvbN7qr3Ul9SoMlmhL
   A==;
X-CSE-ConnectionGUID: tMK6TlvWQCyiAhzaIHOmmQ==
X-CSE-MsgGUID: 4v5E16YYSDiYhbf89Ug3ZA==
X-IronPort-AV: E=Sophos;i="6.21,228,1763424000"; 
   d="scan'208";a="7947458"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 11:04:01 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:31144]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.30.60:2525] with esmtp (Farcaster)
 id 78798bdf-4355-47da-99ae-a3a26432276e; Thu, 15 Jan 2026 11:04:00 +0000 (UTC)
X-Farcaster-Flow-ID: 78798bdf-4355-47da-99ae-a3a26432276e
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 15 Jan 2026 11:04:00 +0000
Received: from [192.168.15.69] (10.106.82.11) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Thu, 15 Jan 2026
 11:03:57 +0000
Message-ID: <373776f9-fe57-4374-8f8f-c43fdb193f19@amazon.com>
Date: Thu, 15 Jan 2026 11:03:56 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v9 01/13] set_memory: add folio_{zap, restore}_direct_map
 helpers
To: Huacai Chen <chenhuacai@kernel.org>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>,
	"oupton@kernel.org" <oupton@kernel.org>, "joey.gouly@arm.com"
	<joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org"
	<david@kernel.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
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
	<borntraeger@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com"
	<wyihan@google.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-2-kalyazin@amazon.com>
 <CAAhV-H6S4bVdpwbER84-iwSE+bQrFu_gF=Ww-bCFxThJ7WiUwQ@mail.gmail.com>
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
In-Reply-To: <CAAhV-H6S4bVdpwbER84-iwSE+bQrFu_gF=Ww-bCFxThJ7WiUwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D015EUA002.ant.amazon.com (10.252.50.219) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 15/01/2026 10:54, Huacai Chen wrote:
> Hi, Nikita,

Hi Huacai,

> 
> On Wed, Jan 14, 2026 at 9:45 PM Kalyazin, Nikita <kalyazin@amazon.co.uk> wrote:
>>
>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> These allow guest_memfd to remove its memory from the direct map.
>> Only implement them for architectures that have direct map.
>> In folio_zap_direct_map(), flush TLB on architectures where
>> set_direct_map_valid_noflush() does not flush it internally.
>>
>> The new helpers need to be accessible to KVM on architectures that
>> support guest_memfd (x86 and arm64).  Since arm64 does not support
>> building KVM as a module, only export them on x86.
>>
>> Direct map removal gives guest_memfd the same protection that
>> memfd_secret does, such as hardening against Spectre-like attacks
>> through in-kernel gadgets.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   arch/arm64/include/asm/set_memory.h     |  2 ++
>>   arch/arm64/mm/pageattr.c                | 12 ++++++++++++
>>   arch/loongarch/include/asm/set_memory.h |  2 ++
>>   arch/loongarch/mm/pageattr.c            | 16 ++++++++++++++++
>>   arch/riscv/include/asm/set_memory.h     |  2 ++
>>   arch/riscv/mm/pageattr.c                | 16 ++++++++++++++++
>>   arch/s390/include/asm/set_memory.h      |  2 ++
>>   arch/s390/mm/pageattr.c                 | 18 ++++++++++++++++++
>>   arch/x86/include/asm/set_memory.h       |  2 ++
>>   arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++
>>   include/linux/set_memory.h              | 10 ++++++++++
>>   11 files changed, 102 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
>> index 90f61b17275e..d949f1deb701 100644
>> --- a/arch/arm64/include/asm/set_memory.h
>> +++ b/arch/arm64/include/asm/set_memory.h
>> @@ -14,6 +14,8 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
>>   int set_direct_map_invalid_noflush(struct page *page);
>>   int set_direct_map_default_noflush(struct page *page);
>>   int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
>> +int folio_zap_direct_map(struct folio *folio);
>> +int folio_restore_direct_map(struct folio *folio);
>>   bool kernel_page_present(struct page *page);
>>
>>   int set_memory_encrypted(unsigned long addr, int numpages);
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index f0e784b963e6..a94eff324dda 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -357,6 +357,18 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>          return set_memory_valid(addr, nr, valid);
>>   }
>>
>> +int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), false);
>> +}
>> +
>> +int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), true);
>> +}
>> +
>>   #ifdef CONFIG_DEBUG_PAGEALLOC
>>   /*
>>    * This is - apart from the return value - doing the same
>> diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
>> index 55dfaefd02c8..9bc80ac420a9 100644
>> --- a/arch/loongarch/include/asm/set_memory.h
>> +++ b/arch/loongarch/include/asm/set_memory.h
>> @@ -18,5 +18,7 @@ bool kernel_page_present(struct page *page);
>>   int set_direct_map_default_noflush(struct page *page);
>>   int set_direct_map_invalid_noflush(struct page *page);
>>   int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
>> +int folio_zap_direct_map(struct folio *folio);
>> +int folio_restore_direct_map(struct folio *folio);
>>
>>   #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
>> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
>> index f5e910b68229..14bd322dd112 100644
>> --- a/arch/loongarch/mm/pageattr.c
>> +++ b/arch/loongarch/mm/pageattr.c
>> @@ -236,3 +236,19 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>
>>          return __set_memory(addr, 1, set, clear);
>>   }
>> +
>> +int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       int ret;
>> +
>> +       ret = set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                          folio_nr_pages(folio), false);
>> +
>> +       return ret;
> Why not use a single statement which is the same as the ARM64 version?
> The RISCV version has the same problem.

No reason for them to be different.  Will update in the next version. 
Thank you!

> 
> Huacai
> 
>> +}
>> +
>> +int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), true);
>> +}
>> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
>> index 87389e93325a..16557b70c830 100644
>> --- a/arch/riscv/include/asm/set_memory.h
>> +++ b/arch/riscv/include/asm/set_memory.h
>> @@ -43,6 +43,8 @@ static inline int set_kernel_memory(char *startp, char *endp,
>>   int set_direct_map_invalid_noflush(struct page *page);
>>   int set_direct_map_default_noflush(struct page *page);
>>   int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
>> +int folio_zap_direct_map(struct folio *folio);
>> +int folio_restore_direct_map(struct folio *folio);
>>   bool kernel_page_present(struct page *page);
>>
>>   #endif /* __ASSEMBLER__ */
>> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
>> index 3f76db3d2769..2c218868114b 100644
>> --- a/arch/riscv/mm/pageattr.c
>> +++ b/arch/riscv/mm/pageattr.c
>> @@ -401,6 +401,22 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>          return __set_memory((unsigned long)page_address(page), nr, set, clear);
>>   }
>>
>> +int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       int ret;
>> +
>> +       ret = set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                          folio_nr_pages(folio), false);
>> +
>> +       return ret;
>> +}
>> +
>> +int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), true);
>> +}
>> +
>>   #ifdef CONFIG_DEBUG_PAGEALLOC
>>   static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
>>   {
>> diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
>> index 94092f4ae764..fc73652e5715 100644
>> --- a/arch/s390/include/asm/set_memory.h
>> +++ b/arch/s390/include/asm/set_memory.h
>> @@ -63,6 +63,8 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
>>   int set_direct_map_invalid_noflush(struct page *page);
>>   int set_direct_map_default_noflush(struct page *page);
>>   int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
>> +int folio_zap_direct_map(struct folio *folio);
>> +int folio_restore_direct_map(struct folio *folio);
>>   bool kernel_page_present(struct page *page);
>>
>>   #endif
>> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
>> index d3ce04a4b248..df4a487b484d 100644
>> --- a/arch/s390/mm/pageattr.c
>> +++ b/arch/s390/mm/pageattr.c
>> @@ -412,6 +412,24 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>          return __set_memory((unsigned long)page_to_virt(page), nr, flags);
>>   }
>>
>> +int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       unsigned long addr = (unsigned long)folio_address(folio);
>> +       int ret;
>> +
>> +       ret = set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                          folio_nr_pages(folio), false);
>> +       flush_tlb_kernel_range(addr, addr + folio_size(folio));
>> +
>> +       return ret;
>> +}
>> +
>> +int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), true);
>> +}
>> +
>>   bool kernel_page_present(struct page *page)
>>   {
>>          unsigned long addr;
>> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
>> index 61f56cdaccb5..7208af609121 100644
>> --- a/arch/x86/include/asm/set_memory.h
>> +++ b/arch/x86/include/asm/set_memory.h
>> @@ -90,6 +90,8 @@ int set_pages_rw(struct page *page, int numpages);
>>   int set_direct_map_invalid_noflush(struct page *page);
>>   int set_direct_map_default_noflush(struct page *page);
>>   int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
>> +int folio_zap_direct_map(struct folio *folio);
>> +int folio_restore_direct_map(struct folio *folio);
>>   bool kernel_page_present(struct page *page);
>>
>>   extern int kernel_set_to_readonly;
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 6c6eb486f7a6..3f0fc30eb320 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2656,6 +2656,26 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>          return __set_pages_np(page, nr);
>>   }
>>
>> +int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       unsigned long addr = (unsigned long)folio_address(folio);
>> +       int ret;
>> +
>> +       ret = set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                          folio_nr_pages(folio), false);
>> +       flush_tlb_kernel_range(addr, addr + folio_size(folio));
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(folio_zap_direct_map, "kvm");
>> +
>> +int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
>> +                                           folio_nr_pages(folio), true);
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(folio_restore_direct_map, "kvm");
>> +
>>   #ifdef CONFIG_DEBUG_PAGEALLOC
>>   void __kernel_map_pages(struct page *page, int numpages, int enable)
>>   {
>> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
>> index 3030d9245f5a..8d1c8a7f7d79 100644
>> --- a/include/linux/set_memory.h
>> +++ b/include/linux/set_memory.h
>> @@ -40,6 +40,16 @@ static inline int set_direct_map_valid_noflush(struct page *page,
>>          return 0;
>>   }
>>
>> +static inline int folio_zap_direct_map(struct folio *folio)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int folio_restore_direct_map(struct folio *folio)
>> +{
>> +       return 0;
>> +}
>> +
>>   static inline bool kernel_page_present(struct page *page)
>>   {
>>          return true;
>> --
>> 2.50.1
>>
>>


