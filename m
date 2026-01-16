Return-Path: <linux-fsdevel+bounces-74156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D94D33189
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F77730BF305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8833985E;
	Fri, 16 Jan 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KXFr1S7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78E145348;
	Fri, 16 Jan 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575769; cv=none; b=JRxEBtknuZyzfIMPlmh0KY7l3GytRyTOlN16Mns708i0nidq5Cr+DC9uWR6y8Eplk6OayanFFAyeJ2RLeZTv13cKba9PpMSYFWq73XGP10LIXqPkocDN4cVlnDNGTzK2MBS2vrVIg1g7L45AeO2DnZoTSUkM0H7t8yD9mZOuwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575769; c=relaxed/simple;
	bh=cgN4RqfbDmJcrcfTrcQfrHaItqoMuRxoHRFBfFkrmTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ryIW+Ax9dfnjt3dExcX4VhnHhe5NwF3fViNdRbfknMnQfYJHHU2H9DndFTRgNPm7OaeqnpZfGAm62W/LTwVGoI56Q342M93r96B3qxDh7BEXa9aJm3QxMknBFlL9RYVnSYFP639xpQBD3GzQuNCpFxDzp/1zLn+My5j6jzyBRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KXFr1S7Y; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768575768; x=1800111768;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=vgEOcPvSDFlnojIEi9fDkTiU/IY1eXjcDPZz2p9VuaI=;
  b=KXFr1S7YmQeyUC9CtGzXkTclRw+QBdbn9yV+oOzlaZ0ZfeuejysK3qdX
   c6DNeOd8GqKRGNH1DdqKhaXtNlJVugcTqZzOGtTtJ6KRx9Eb6Bsv4s5Jy
   Xd5awSgPC251eUPcwI/Q73f2GcJNmDjRw1PegG+R8r9WKochP9z1P6mKb
   L5xYP6NnFILaL7xbvBF6/Oq9dX5on1AY2U4BAiXa7RLU4XnxaxA5JhMm1
   QiA/XDD2BwbbDCKwp1vMQO93KGgfxpeBt+D9TBtGW8DbmibqMONgzujfp
   PRSj2lJqOA4UlcYXweX4eZ3qzXkAGB4/P0hSa1q8p3kOPt2tYOo7a8wln
   A==;
X-CSE-ConnectionGUID: 8rdRYcCTR8imomIXxqbd0Q==
X-CSE-MsgGUID: EJyP+fC3R0m9epUUPjXDgw==
X-IronPort-AV: E=Sophos;i="6.21,231,1763424000"; 
   d="scan'208";a="7920549"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 15:02:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:4746]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.8.163:2525] with esmtp (Farcaster)
 id d396bcea-2275-4311-8348-ff7e15490f17; Fri, 16 Jan 2026 15:02:45 +0000 (UTC)
X-Farcaster-Flow-ID: d396bcea-2275-4311-8348-ff7e15490f17
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 15:02:34 +0000
Received: from [192.168.12.13] (10.106.82.9) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Fri, 16 Jan 2026
 15:02:30 +0000
Message-ID: <208b151b-f458-4327-94bc-eb3f32d20a68@amazon.com>
Date: Fri, 16 Jan 2026 15:02:29 +0000
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
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com"
	<jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
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
In-Reply-To: <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D013EUB001.ant.amazon.com (10.252.51.116) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 15/01/2026 23:04, Edgecombe, Rick P wrote:
> On Wed, 2026-01-14 at 13:46 +0000, Kalyazin, Nikita wrote:
>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
>> ioctl. When set, guest_memfd folios will be removed from the direct map
>> after preparation, with direct map entries only restored when the folios
>> are freed.
>>
>> To ensure these folios do not end up in places where the kernel cannot
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
>>
>> Note that this flag causes removal of direct map entries for all
>> guest_memfd folios independent of whether they are "shared" or "private"
>> (although current guest_memfd only supports either all folios in the
>> "shared" state, or all folios in the "private" state if
>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
>> entries of also the shared parts of guest_memfd are a special type of
>> non-CoCo VM where, host userspace is trusted to have access to all of
>> guest memory, but where Spectre-style transient execution attacks
>> through the host kernel's direct map should still be mitigated.  In this
>> setup, KVM retains access to guest memory via userspace mappings of
>> guest_memfd, which are reflected back into KVM's memslots via
>> userspace_addr. This is needed for things like MMIO emulation on x86_64
>> to work.
> 
> TDX does some clearing at the direct map mapping for pages that comes from gmem,
> using a special instruction. It also does some clflushing at the direct map
> address for these pages. So I think we need to make sure TDs don't pull from
> gmem fds with this flag.

Would you be able to give a pointer on how we can do that?  I'm not very 
familiar with the TDX code.

> 
> Not that there would be any expected use of the flag for TDs, but it could cause
> a crash.


