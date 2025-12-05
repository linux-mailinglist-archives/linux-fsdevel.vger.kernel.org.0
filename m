Return-Path: <linux-fsdevel+bounces-70843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C171CA8910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B590C301831B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99962354AE6;
	Fri,  5 Dec 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FSJoaVt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53B346798;
	Fri,  5 Dec 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955415; cv=none; b=C2NDcFPVcNGwFE/sJ0vyb4H5+yVD4PYS60Bgwrru9YkVWfkfqtlO6qIksr7odQqGqcFhL4SUvwG8E75e0lf51+BTzgcQMDBPISzJAxxcvJA+lhg8BG17KYPwhSm0xiDx5SpMfT7Hjg8cMdSm5kcPYo9Oy8W7mGswI+0/bk60Mv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955415; c=relaxed/simple;
	bh=FZI2ceXyv/NOPuyQMweU+D+8Ikh9jJhi181Yt9tWvWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZXwHVyy3vNJUTy/B68bkoWucTVp6VRgniNR38ws0/bMDM2m49NMpBYWKLHY8cxXIpIP2q77Ou4oLkKRE0V8FSRCxDVWyTUOsrFSGf6AjWk8kITKt+ilIQZB2USu7xUF2SaFlOS3sgEa799ZewaM4XDgoWfWBQje2SG+xbJ5QsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FSJoaVt9; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764955413; x=1796491413;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=RienKcTqqmsGG8zizmirrEKiZCGuAJt5fOpB1029IRQ=;
  b=FSJoaVt9qKf1CBcOmrFgR8cs/ZnAFGFucyiVsSG/Ruitvrp97RxrdWls
   RacjR7wzKqevTsQAI5KdwWKQNZTer/jmXOYT45XVVxwgQOoJ6M8cuId5A
   +4e+9i/il1Q9SxX8UnEjW4almT+O2La2Gow43AWKRrzMFefTYQxuG1xpk
   djo/fK12eRk11bXUwPSmHQm3soropqkJTX7vgvzfV6Cs+/XjIDbevAou+
   gkPF1jLBc8AoYzySPNsHPjnYWEozA/RISfoH/R5Y66hKBx5Nqb6kyG2QM
   2bLKTZ5c48BLYpgEiWzPStJq7J8exfPLKfK1+nksUM+3F3yceoLJTK5Ip
   g==;
X-CSE-ConnectionGUID: U9T32tygTySwaMWRVIxYXw==
X-CSE-MsgGUID: ezeiUYqjT6+LtvlkxY9Q1A==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6302828"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 17:23:30 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:4382]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.6.214:2525] with esmtp (Farcaster)
 id ba644cd0-1d42-4328-b08c-52f3a96e0bd0; Fri, 5 Dec 2025 17:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: ba644cd0-1d42-4328-b08c-52f3a96e0bd0
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 17:23:26 +0000
Received: from [192.168.14.68] (10.106.83.5) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 5 Dec 2025
 17:23:23 +0000
Message-ID: <356ece73-83ff-4c0f-a3fb-4b24df7953b3@amazon.com>
Date: Fri, 5 Dec 2025 17:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct
 map
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "song@kernel.org"
	<song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "david@kernel.org"
	<david@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-2-roypat@amazon.co.uk> <yq5ajz07czvz.fsf@kernel.org>
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
In-Reply-To: <yq5ajz07czvz.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D008EUC001.ant.amazon.com (10.252.51.165) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 03/11/2025 07:57, Aneesh Kumar K.V wrote:
> "Roy, Patrick" <roypat@amazon.co.uk> writes:
> 
> ....
> 
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>> +{
>> +     if (kvm_gmem_folio_no_direct_map(folio))
>> +             return 0;
>> +
>> +     int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>> +                                      false);
>> +
>> +     if (!r) {
>> +             unsigned long addr = (unsigned long) folio_address(folio);
>> +             folio->private = (void *) ((u64) folio->private & KVM_GMEM_FOLIO_NO_DIRECT_MAP);
>> +             flush_tlb_kernel_range(addr, addr + folio_size(folio));
>> +     }
>> +
>> +     return r;
>> +}
> 
> These 'noflush' functions are actually doing flush_tlb_kernel
> 
> [-]  ∘ flush_tlb_kernel_range
>   |-[-]  ← __change_memory_common
>   |  `-[-]  ← set_memory_valid
>   |     `-   ← set_direct_map_valid_noflush

Hi Aneesh,

Thanks for pointing at that.  I ran internal tests and it appears that 
the second flush_tlb_kernel_range() call does add a latency similar to 
the one coming from the first call, even though it intuitively should be 
a no-op.  I have to admit that I am not aware of a safe way to avoid the 
second flushing on ARM while keeping the guest_memfd code arch-agnostic. 
  Perhaps I should seek Will's counsel for it.  Nevertheless, I don't 
think there is a concern from the functional point of view.

Nikita

> 
> -aneesh


