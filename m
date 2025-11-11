Return-Path: <linux-fsdevel+bounces-67924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED9C4E062
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E444E8967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A05328247;
	Tue, 11 Nov 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg0OtVLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021373246F5;
	Tue, 11 Nov 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866393; cv=none; b=rIw/Zzli9dpzekIhskdkrOION/uadSKCRGmUxyrBbocoPKQ6TLZsJgFwB9ovAKqaZVZt+CzSrblzuFFXQcuxJvp9KCOh0JAsVWDiUa7aK8A5s+B6g+XWm5ToHEcoa0QJq64n+Wo7YYNKjlotukNAOSj3OHSv/XUz1GOsHLjnAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866393; c=relaxed/simple;
	bh=ahDE0Hde9+gZsnP0JCOLdJBo8hGroTd4JJCH/jgFj/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcyFDvhd5C3pJgGaufhpTbLBW+xIlW3dgzZmEuqgiIf5efj9EIHHpzh9qAnFz12H4YF4BWm9mJ41ePu1U0SqUyQLT4DLUY1FSR6G3tKjBo3dS+JcYx86/h5BssdVHxdSuIj4gRnyq5WwDuyecfnLjFN9lblKk2idScNaSwhwvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg0OtVLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E9AC16AAE;
	Tue, 11 Nov 2025 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762866392;
	bh=ahDE0Hde9+gZsnP0JCOLdJBo8hGroTd4JJCH/jgFj/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tg0OtVLz3wAXRZo7tCvWTInHjKpVK4LV67NTO+lYAZ/bR93jyG2IyFgcvsue4SRjB
	 0h8QMWesGpk3qXoW3f/y5g5hNGaIhpu5ZvQWDGwHfLvH2QohrLgDnSv/T7XK5D98wL
	 z5paZ8OThivObxShM274wdwZcvtkA9PuAU6b+qI29fKv1akghKWsQ9OqLPjtgfb1tU
	 4dhW8r72DwTtl22M6htocWaDV7hTEh5uNlGrHZ2wikbz5TAqNJgsCaWZxjg5IGzZHl
	 e2ra3fX+DjamK0ohLsg2Y80OH6UCT/oI2TuutGRfJ5NWGrLux815QwhhypwuSp+iZj
	 JUT65tT6i+w6g==
Message-ID: <6c7c5f86-a9d5-4b7e-aa08-968077f66ace@kernel.org>
Date: Tue, 11 Nov 2025 14:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.25 04:25, Zi Yan wrote:
> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
> 
>> The kernel maintains leaf page table entries which contain either:
>>
>> - Nothing ('none' entries)
>> - Present entries (that is stuff the hardware can navigate without fault)
> 
> This is not true for:
> 
> 1. pXX_protnone(), where _PAGE_PROTNONE flag also means pXX_present() is
> true, but hardware would still trigger a fault.
> 2. pmd_present() where _PAGE_PSE also means a present PMD (see the comment
> in pmd_present()).

I'll note that pte_present/pmd_present etc is always about "soft-present".

For example, if the hardware does not have a hw-managed access bit, 
doing a pte_mkyoung() would also clear the hw-valid/hw-present bit 
because we have to catch any next access done by hardware.

[fun fact: some hardware has an invalid bit instead of a valid/present 
bit :) IIRC s390x falls into that category]

Similar things happen on ordinary PROT_NONE of course (independent of 
pte_protnone).

A better description might be "there is a page/pfn mapped here, but it 
might not be accessible by the CPU right now".

We have device-exclusive/device-private nonswap (before this series) 
entries that fall into the same category, unfortunately ("there is 
something mapped there that is not accessible by the CPU")

-- 
Cheers

David

