Return-Path: <linux-fsdevel+bounces-74199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F9D38418
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B40B30BCAA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FA3A0B29;
	Fri, 16 Jan 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="I0MBfWtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18D30214B;
	Fri, 16 Jan 2026 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587436; cv=none; b=g7y1nceU7TCs46I990qjgsj8T7LqL8wTHkMPAk1NjH/ND0MzYoGZotcb229AFgM8NCc/QWI3nt8z1Az+xqWa538bpnTVHK0wnLg9zcpzFCbPKTNbB/cADLKuQbt4vS2SqyD1dlwxHuFLiY7v/DcegcMuqHLMZ+CqOz0wQ2iT4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587436; c=relaxed/simple;
	bh=zrf911BvhStWuhjVEELF/Ajfn8rz9WHah1btkRBe1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QNqTzRLgx8GAzPMfddKIiAkm/MnHppr0VAyGUZ5h3kjYdO9RFN7+GcNQTv2U2r/uZHkPg032bHmH6HbZJhPZaXmZ38BJL/VlFzo1j/hx1jrmW7wb0PzpiATiJV/pq9Sc7K4GkGESvxagyqPDF5NeDlnJGDJahWSgum62S5/wvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=I0MBfWtw; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768587435; x=1800123435;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=YapVUMmpOwobMagVZxDJCeWDb1gq+ZQf1FJDAqu8vU0=;
  b=I0MBfWtwMj/4d9o8Qo09Bvi97Fdkgii+OIU/xcBtB6vDCdVz930MJlp4
   7iA8wYC6yCRY4gYp8XT91C0q02KlwiFbbAz4hynTpaojFoPxPDqCAHIcV
   yiwg53gCDcQzKo3y611nu0iDN3GzJwHax8XfeZJOM3frY/3jWykM3K4gP
   h0rmyZOFnbEMmUtT/v7F7nWVPh8CUTxjphtA4UROiH2ePTjM1PRr7un5P
   ra7C+XJd+hQAHcjkJ3UUB3L3muRa6t5/doBjDzBHFYUmLFm9Yndpi09xb
   8p6tGrUC/fOisV3rULKXGStpRWS1ge2LyzakX2p5x4jX6GmDeHjHxeAo4
   Q==;
X-CSE-ConnectionGUID: NWjda1oCRYKn9baULLv/sw==
X-CSE-MsgGUID: IK3nVvd5RcyK2jXvKFHlAw==
X-IronPort-AV: E=Sophos;i="6.21,231,1763424000"; 
   d="scan'208";a="8025027"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 18:16:56 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:23681]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.8.163:2525] with esmtp (Farcaster)
 id 6045a328-4a68-479c-a4ff-a5f3e38bc599; Fri, 16 Jan 2026 18:16:56 +0000 (UTC)
X-Farcaster-Flow-ID: 6045a328-4a68-479c-a4ff-a5f3e38bc599
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 18:16:53 +0000
Received: from [192.168.12.13] (10.106.82.9) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Fri, 16 Jan 2026
 18:16:48 +0000
Message-ID: <e4cc7e98-9c1f-4ced-a22f-5d0fe29a6893@amazon.com>
Date: Fri, 16 Jan 2026 18:16:47 +0000
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
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kalyazin@amazon.co.uk"
	<kalyazin@amazon.co.uk>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "david@kernel.org" <david@kernel.org>, "svens@linux.ibm.com"
	<svens@linux.ibm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de"
	<pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org"
	<maz@kernel.org>, "peterx@redhat.com" <peterx@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org"
	<luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "peterz@infradead.org" <peterz@infradead.org>,
	"oupton@kernel.org" <oupton@kernel.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jthoughton@google.com"
	<jthoughton@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"itazur@amazon.co.uk" <itazur@amazon.co.uk>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
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
 <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
 <294bca75-2f3e-46db-bb24-7c471a779cc1@amazon.com>
 <bb58a21f91113ca39f8888d718d4450a5fd72808.camel@intel.com>
 <318407ba-ecb6-4691-8911-645fb8c20250@amazon.com>
 <c42cc00f3902673b1a964c3d098b8c3f236cf9a1.camel@intel.com>
 <98b8ea1e-3bdd-4987-8acc-58112076d451@amazon.com>
 <a84835708eb92d99ba524149bde819c4ba944cb9.camel@intel.com>
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
In-Reply-To: <a84835708eb92d99ba524149bde819c4ba944cb9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D006EUA002.ant.amazon.com (10.252.50.65) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 16/01/2026 18:10, Edgecombe, Rick P wrote:
> On Fri, 2026-01-16 at 17:51 +0000, Nikita Kalyazin wrote:
>> Yes, this is a problem that we'd like to address.  We have been
>> discussing it in [1].  The effect of flushing on memory population
>> that we see on x86 is 5-7x elongation.  We are thinking of making use
>> of the no-direct-map memory allocator that Brendan is working on [2].
> 
> Ah, makes sense.
> 
> Do you plan to merge this before the performance problems are
> addressed? I guess this series focuses on safety and functionality
> first.

Yes, we'd like to merge the functional part first and then optimise it 
in the further series.

> 


