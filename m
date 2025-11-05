Return-Path: <linux-fsdevel+bounces-67210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76319C38135
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880A23BE158
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C262D9EC7;
	Wed,  5 Nov 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je8ivg3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323228695
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378162; cv=none; b=PFT18mwD6spK3Svv7uk5Am/TRdjPC9B/ZzPWIsbtpmyvT2LOFqI2rnlwdTG3SwT/UUs6jFiAHo7T98+ieOhqumlS8OY0R7bdqAeCMDqc2t34wQdv+H7jJjPAZvwmS2jqyTGZR+lKl1asPFc5vYhAcJO7PHuXycXqxtZ0V6VALnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378162; c=relaxed/simple;
	bh=PAlZ6tNkRMkFTMYnzRbwscVzdBJrBlWT3kjK7f2AI7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEP7Phuy/558rlh+qQKpcvdNpcZSeofYuLQooZ3Y8DTvYIdQScMvREe9EI+dKt+TAG9mGdn0nLm+Dz1POpsZfID5ZGjiRvkVUXw2jt2U4mYHHY65tyReurW0MyI4Aga//MoC0XQFNS9ty1Qp7+UC7Yp+FbKH5JYGrRs+GeDZLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je8ivg3q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4283be7df63so146725f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762378159; x=1762982959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FXHSyf2tmThjEU70iMaM/iQ+kQ6AR9dxeHlynBInUg=;
        b=je8ivg3qNRWkcbC9jLHd7gNGYTWySEogHAKOKKuu7+YvltCk74Psr3GfL+BYpmfBVk
         tmmWGTcN1qcJRaKqXEHPAjzJ/BsA6HH7E+7YYPYN65DoKAC0oq4hQx3meFta0VAasN3P
         sRKgMNhjFZSyhvSD+0rByGvgMwlt8tGbqeFKWr2GggkqXjfGZUcwJA2cTeAPeFOn6WTc
         qDjhRRjBT5dIvlvV4n9ASBxhYghJExkCblTsxE75YGuWgJMB/g73v/YqbwKHBlGFJcpn
         tlA6hds5Jx36yzW+o5jZMyTgBApqND2xcHspff3Mx6ZC6MrLf2DyaYWVTJnlqPqTyxpc
         B2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762378159; x=1762982959;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FXHSyf2tmThjEU70iMaM/iQ+kQ6AR9dxeHlynBInUg=;
        b=JeCwjCJ/dLICSE7Hid4Ml6xpoeXi3UPpGNRZ2UHwoinSWm57zSHP9DDa9vEBLaN0G0
         SEGTPf1PucZjBA/92Xp5UNwvFA2YzRcS52sp0Sv9sstSzbaQrK8JBp9CAWN1D+yh7UeV
         V/8lAkgALandYLmsYzOZ5A2+dkN7GVNOF+Osj1gyMKgCraoLcbY1hVg4M20ab0IISAUh
         QdMrH3U4VCNc3AdxzgvQMtNPK0OVmJHK2O9/MceoNB9uYnDD3qj3BDHiofZ+UMZ+7uqj
         qa/5O25c42CsmIVkrKM50ysF3KvWMTrDwsjQYXk1iD3ffbgPDY+DhA+oJAvAvBqVlBcp
         Oi3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9FdMaVFZ4U+pI7eUGdg2pxPZBQkVjTQt4jc4axlauQqMS0BHs45GxRPI2vnNqQ/gQWHVYLkeirJS8+8oM@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFZWOdn+zXe2RlE8kUQSB/tsV418w6KDLaBLcFOsQHQ18FdTw
	B/9crQlNthPUIWR+5Gb6N5OglYEpClQ7GOuLq97c+HTwtlrwOrCXs4Hp
X-Gm-Gg: ASbGncu2sX/sNvgWGesEEqbylxRwgPzfWughmAme97PTp1EyZPEYuW6mpJSLzexa8Y8
	hu4n6oTAdZdXdRmow2l+4XOHQBL7D0nZ7d2JMd8gP3biS4BZvnd82HNsF3RBuZ0ooBtmXIPMZ/u
	AuO+MCiEIHytwwzHbJ1kjnjL94T/1l3tqzK2MuNE561z8fS6WnTD9FVknUSwaK3IuxcgBuPIDyP
	a3sTIf4ttcsQEThTdmUrGp7CBSFEsUG/qxstACRsbecR5U68CeT/y6rme1ZW20fylBdPqJU34nC
	p1WDiwj7R+Gju2O8KpR6y5ZIa/sGV0UEm9SqRTbCRBa3dHJWNp8vvOQSaPvn1J02SGGBFB0PRkq
	S/oWU4a2wapPWEx8+r8p5dP23so2pMrW8BDBEoi/an+C4+xecs3u5M1mK0BxyZPe2yh6O3QogT5
	/lsBsfxlqBOxYYn+M/WvU4pVHMXxjqVk2q9lOzIrD3tCFvwa72SLvZlhW7HT0CZQCnyyAXPxr4p
	w6gnXDv74txkFFzS6Eh7F9n1yYMet0=
X-Google-Smtp-Source: AGHT+IFI9Wwvq/A5D0mlqZlN00u3cG6xT1eMWW/nCv3lLfCOJ9IihPCMHOqYjym3ZOcL+eAXbx3BBQ==
X-Received: by 2002:a05:6000:410a:b0:429:bbfa:2305 with SMTP id ffacd0b85a97d-429e330579dmr3946595f8f.35.1762378158606;
        Wed, 05 Nov 2025 13:29:18 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403747sm874380f8f.4.2025.11.05.13.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 13:29:17 -0800 (PST)
Message-ID: <bc94d739-d66f-4cd6-a3f2-68938cfd08c1@gmail.com>
Date: Wed, 5 Nov 2025 22:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
 <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
 <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
 <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
 <563246df-cca4-4d21-bad0-7269ab5a419c@gmail.com>
 <52dd0c85-9e06-4cb2-a9f9-71662922cba9@lucifer.local>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <52dd0c85-9e06-4cb2-a9f9-71662922cba9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 22:24, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 10:15:51PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 05.11.25 22:08, Lorenzo Stoakes wrote:
>>> On Wed, Nov 05, 2025 at 09:11:45PM +0100, David Hildenbrand (Red Hat) wrote:
>>>> On 05.11.25 21:05, Lorenzo Stoakes wrote:
>>>>> On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
>>>>>> On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
>>>>>>>> On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
>>>>>>> I thought about doing this but it doesn't really work as the type is
>>>>>>> _abstracted_ from the architecture-specific value, _and_ we use what is
>>>>>>> currently the swp_type field to identify what this is.
>>>>>>>
>>>>>>> So we would lose the architecture-specific information that any 'hardware leaf'
>>>>>>> entry would require and not be able to reliably identify it without losing bits.
>>>>>>>
>>>>>>> Trying to preserve the value _and_ correctly identify it as a present entry
>>>>>>> would be difficult.
>>>>>>>
>>>>>>> And I _really_ didn't want to go on a deep dive through all the architectures to
>>>>>>> see if we could encode it differently to allow for this.
>>>>>>>
>>>>>>> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>>>>>>>
>>>>>>
>>>>>> Reasonable - names are hard, but just about anything will be better than swp_entry.
>>>>>>
>>>>>> SWE / sw_entry seems perfectly reasonable.
>>>>>
>>>>> I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
>>>>>
>>>>> I am quite fond of my suggested soft_leaf_t, softleaf_xxx()
>>>>
>>>> We do have soft_dirty.
>>>>
>>>> It will get interesting with pte_swp_soft_dirty() :)
>>>
>>> Hmm but that's literally a swap entry, and is used against an actual PTE entry
>>> not an abstracted s/w leaf entry so I doubt that'd require renaming on any
>>> level.
>>
>> It's used on migration entries as well. Just like pte_swp_uffd_wp().
>>
>> So, it's ... tricky :)
>>
>> But maybe I am missing your point (my brain is exhausted from uffd code)
> 
> We'd either not rename it or rename it to something like pte_is_uffd_wp(). So
> it's not even so relevant.

We do have pte_uffd_wp() for present ptes.

> 
> We'd probably call that something like pte_is_soft_dirty() in the soft dirty
> case. The 'swp' part of that is pretty redundant.

We do have pte_soft_dirty() for present ptes.

So we'd need some indication that these are for softleaf entries (where 
the bit positions will differ).

> 
> If people were insistent on having softleaf in there we could call it
> pte_softleaf_is_soft_dirty() which isn't qutie so bad. But I'd not want to put
> softleaf in there anyway.
> 
> sw_entry or sw_leaf or sw_leaf_entry would all have the same weirdness.
> 
> I want it to be something that is readable + not hideous to look at but still
> clear as to what it's referring too. Softleaf covers all of that off... :)

I think you misunderstood me: I have nothing against softleaf, I was 
rather saying that we already use the "soft" terminology elsewhere 
(soft_dirt), so it's not too crazy.


