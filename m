Return-Path: <linux-fsdevel+bounces-52838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF57AE7507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F54A166DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D31D8E10;
	Wed, 25 Jun 2025 02:56:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3E16E863;
	Wed, 25 Jun 2025 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750820160; cv=none; b=idsZvv9VfQT6jpe+U3dCb2LYwavRy+hkvKJC+LCo3u5dH6DP9GbzWfcLguOjSRmS5TzQJ6RlYS6RcFAEh2D7tM5GiPvf9cDn9hlBKkHkY7O1eg3LT1+JpkkcNHe+iiO8DAZK5MXeCkF1Tllmq5BWJoWv/JPwPsKIAa3BD73D2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750820160; c=relaxed/simple;
	bh=UtkW3qucY6iNeZ6QdEnlpOKX0CFNUk0ZJoZv9+yY7WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQhIPzF2wj6dYwpA9zfs7jtqxXBYuu9e5qJ5u4eo1gw9P/LDAFnoxECdeaHFOvs84WkeR6wWXFRlyaiv1j5iUhklmorYKC/HJNOSYb5MqNzhi3jYxWjJV2kSe4GB8yo9nhzqLCQBZ/PFxyoYDNQky1B3PF06WW8Hnp6uzwvV3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4927B12FC;
	Tue, 24 Jun 2025 19:55:40 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6A63F58B;
	Tue, 24 Jun 2025 19:55:38 -0700 (PDT)
Message-ID: <46432a2e-1a9d-44f7-aa09-689d6e2a022a@arm.com>
Date: Wed, 25 Jun 2025 08:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] use vm_flags_t consistently
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/25 1:12 AM, Lorenzo Stoakes wrote:
> The VMA flags field vma->vm_flags is of type vm_flags_t. Right now this is
> exactly equivalent to unsigned long, but it should not be assumed to be.
> 
> Much code that references vma->vm_flags already correctly uses vm_flags_t,
> but a fairly large chunk of code simply uses unsigned long and assumes that
> the two are equivalent.
> 
> This series corrects that and has us use vm_flags_t consistently.
> 
> This series is motivated by the desire to, in a future series, adjust
> vm_flags_t to be a u64 regardless of whether the kernel is 32-bit or 64-bit
> in order to deal with the VMA flag exhaustion issue and avoid all the
> various problems that arise from it (being unable to use certain features
> in 32-bit, being unable to add new flags except for 64-bit, etc.)
> 
> This is therefore a critical first step towards that goal. At any rate,
> using the correct type is of value regardless.
> 
> We additionally take the opportunity to refer to VMA flags as vm_flags
> where possible to make clear what we're referring to.
> 
> Overall, this series does not introduce any functional change.
> 
> Lorenzo Stoakes (3):
>   mm: change vm_get_page_prot() to accept vm_flags_t argument
>   mm: update core kernel code to use vm_flags_t consistently
>   mm: update architecture and driver code to use vm_flags_t

Hello Lorenzo,

Just wondering which tree-branch this series applies ? Tried all the usual
ones but could not apply the series cleanly.

v6.16-rc3
next-20250624
mm-stable
mm-unstable

b4 am cover.1750274467.git.lorenzo.stoakes@oracle.com
git am ./20250618_lorenzo_stoakes_use_vm_flags_t_consistently.mbx

- Anshuman

