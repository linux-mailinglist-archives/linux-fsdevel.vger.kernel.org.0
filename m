Return-Path: <linux-fsdevel+bounces-1705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD37DDD24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 08:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13001B2113A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6D569D;
	Wed,  1 Nov 2023 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOVCUeoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6845680;
	Wed,  1 Nov 2023 07:25:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D88C2;
	Wed,  1 Nov 2023 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698823539; x=1730359539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qWRVoltW9FVs6NYX3CWyFfOjxesJ7ml8CJp5xBKO3/4=;
  b=EOVCUeozcT1NzVrIgdJtfxx6i7mCK1uws2kYos0e8yuYTfLr0dwqwGKp
   QmmOYY1fS3NH5F53S2ybE14BH7mliFv39x9GKPVX/usRuck+DRk9o4jv9
   Ynx6d2WAo/NwEDiXKHCkdMIhKZaWDgQvgxnlbH3kLKd1L/Xv7qdFLqw9d
   dCvggauYe/b9lAJqQ6XLXAnppfmQXv6irZ+4Sn9ipwMNDymUyKr51/nXK
   GBjnXY5dncs81GadtrECWaJvVwxMMkGZ9bFFnodamezNFVyEAZHSjZ1gc
   N7Aq+p4E9q1Tofjmx/V6UuhBce+/wOcYDJiGF9Rtay9IRC/Q5G7u/L+Bg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="392307402"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="392307402"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="8964294"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.9.145]) ([10.93.9.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:25:26 -0700
Message-ID: <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com>
Date: Wed, 1 Nov 2023 15:25:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>,
 David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com>
 <ZUEML6oJXDCFJ9fg@google.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZUEML6oJXDCFJ9fg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/2023 10:16 PM, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Xiaoyao Li wrote:
>> On 10/28/2023 2:21 AM, Sean Christopherson wrote:
>>> Extended guest_memfd to allow backing guest memory with transparent
>>> hugepages. Require userspace to opt-in via a flag even though there's no
>>> known/anticipated use case for forcing small pages as THP is optional,
>>> i.e. to avoid ending up in a situation where userspace is unaware that
>>> KVM can't provide hugepages.
>>
>> Personally, it seems not so "transparent" if requiring userspace to opt-in.
>>
>> People need to 1) check if the kernel built with TRANSPARENT_HUGEPAGE
>> support, or check is the sysfs of transparent hugepage exists; 2)get the
>> maximum support hugepage size 3) ensure the size satisfies the alignment;
>> before opt-in it.
>>
>> Even simpler, userspace can blindly try to create guest memfd with
>> transparent hugapage flag. If getting error, fallback to create without the
>> transparent hugepage flag.
>>
>> However, it doesn't look transparent to me.
> 
> The "transparent" part is referring to the underlying kernel mechanism, it's not
> saying anything about the API.  The "transparent" part of THP is that the kernel
> doesn't guarantee hugepages, i.e. whether or not hugepages are actually used is
> (mostly) transparent to userspace.
> 
> Paolo also isn't the biggest fan[*], but there are also downsides to always
> allowing hugepages, e.g. silent failure due to lack of THP or unaligned size,
> and there's precedent in the form of MADV_HUGEPAGE.
> 
> [*] https://lore.kernel.org/all/84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com

But it's different than MADV_HUGEPAGE, in a way. Per my understanding, 
the failure of MADV_HUGEPAGE is not fatal, user space can ignore it and 
continue.

However, the failure of KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is fatal, which 
leads to failure of guest memfd creation.

For current implementation, I think maybe 
KVM_GUEST_MEMFD_DESIRE_HUGEPAGE fits better than 
KVM_GUEST_MEMFD_ALLOW_HUGEPAGE? or maybe *PREFER*?

