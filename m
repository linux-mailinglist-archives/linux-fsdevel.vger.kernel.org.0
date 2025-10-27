Return-Path: <linux-fsdevel+bounces-65733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C971AC0F3A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18E75016A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A5313526;
	Mon, 27 Oct 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRmV69be"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D943128C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581728; cv=none; b=VlZHzE/Qo1HDX8pGl5cbgTxNWQL3W8h5y7Un0PktM2xCPkhx9XYYEmO57VnHkwINMbANNvvP8HeIF8exxe/94KKSetkwfzrsRwCTQAWqj9tfHtWrLLh8EfdHPNan8bDL9smoVUVYmbSy55N9c7zguUPWofetrXqSgZeuZ1VReh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581728; c=relaxed/simple;
	bh=Y/sGhF7eaQExABxacuOsAJfmcL9WiA4+mWaQYTzpGvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4L4kMPOF6peiKD0d9Temn6605LNFO6fb1aK0kY8vTWci8SaJT87RH27UTpSbOTzoSBOnpcBeYXCSTY/8WZcFpU+cxXMY2EDdgERH23jjTg9gNfCB3ULQO4XmHLOeNbwSUzLh3YzO+oV5w4lL6bhaGRwFDYMJ1OhiGZKCdgPLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRmV69be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761581725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y1mHiJVhO+VjbMfqmTXKhoVt8EjIjofOvtpC7RQVTFk=;
	b=JRmV69bepb6TQX3YZEi3kaBcIh/LHHIQANF8kpvcdwY1zmX9n6XYphaOdMQnfuH1eW1FQW
	TmFdxDH3hB0+dX7NxDx0Aa6+OcS9RwJBj12iE2C+pudaglfysY6m1RyeabPf87DL0EH6YR
	zPeBxTH/uhdQ/LAYInLGTx+qU9ZrIVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-iEWAa3YHMeyFw2UrkLx0Dw-1; Mon, 27 Oct 2025 12:15:24 -0400
X-MC-Unique: iEWAa3YHMeyFw2UrkLx0Dw-1
X-Mimecast-MFC-AGG-ID: iEWAa3YHMeyFw2UrkLx0Dw_1761581723
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso25456785e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581723; x=1762186523;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1mHiJVhO+VjbMfqmTXKhoVt8EjIjofOvtpC7RQVTFk=;
        b=Cu61Ca3/LVOabjzQTNkzdf8Tu/B2D5HvtPLY/HPMHJ8HPNhfLBhLc9Gd8ey4AP1DxV
         vdjFoE8epSe3W1L7qptwEVuMl82OidLxdG/3uNDtgWSu7wBX8kbCUelAPvji5kBLrjcO
         BJde1FACYSFauzLrty6Eh+lSYWyZcKoK3abbJ5eOgU7KyW7sH81uvlDwU7Jhr11kLT15
         OS0si3tPTyw6Y6HxxLE5i1GM3XtTa20FOq/J6NLP5xU7x1BSJKx9+Q1wRr8MV6SC3NoT
         mNAtYQU/qBOxvfQ1yzYohLgQKgRDgpXK6jpmy0CxXvUofl4MFBZ9B3xq6OhOCvsuW27e
         uMeA==
X-Forwarded-Encrypted: i=1; AJvYcCXkMa4Qg/8patyN9l4+/KkdIESN+Z2FxYBpxUJMXRtZzm82gD8Qvv0pBesi9wLGc1Yrqe8GltwCBeJxBvG1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kwsESebnIpcsZlc5btnEucD0T0//mc7vXRhT02LE9EsfznTA
	gUT/gonXLG7g57Ov38zhLnjukO9QYYQ7J+jONzGS4PzHzuVfXRh4p3y7n87Rnj/vA8bcYrQW0SS
	1psrIocRWDs6kARi5uvmtPP+b5FqTuL4QYADc9OurGbURMUXE2HoTxzt0GW8zUFMqgGk=
X-Gm-Gg: ASbGncsEOFpuRS+szNqvD6UKfuXcSTMNM0KqvqTz4yU4yo7GmBzncawggafhLmCEc+j
	AjJ6Evs5twzUH8p3rZ98Gd78aGphsasdTNlQXh/rneddABboAyYTOfgJPMb2RLC9pNMiyQP57pS
	3HmwNEhW4iz+ZXikhPRjDOWqSvBMVKyKg20AF43hchc+uwgBDdJD/4EeUQr7E/fjFUujPsbbfcM
	rEO+4mjjnzODmtp80poGx5DcmXcaNgQuEMqS6Qp5u9hNSwK4TAFSa58HxkUFJhn/j8k18XUMJQL
	VZNbVxLI4JbDgJHGcxIiZjwpMdV1vlLlKgTaVLPIE6vrvSVdYd02//B6yGCYxXe47KesQbgSJsZ
	0NeO7PToAD0+ze+jIxUUdYaWGgI9tD7GHYyizwq81L1qbGM+LCSfnpO19pK5lhbDPyAW3yadjqH
	xxKIb8Sq1stbtyeonLtUkFlV1QIrY=
X-Received: by 2002:a05:600c:8b30:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47717dfc627mr1792055e9.13.1761581722844;
        Mon, 27 Oct 2025 09:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyCGbC2aHxxDVeGlz+puR5Je01gbqwwjxfThnaNAQY+WhG+9Kt2kQaSj/jxsx1EWiCDG1sjQ==
X-Received: by 2002:a05:600c:8b30:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47717dfc627mr1791545e9.13.1761581722398;
        Mon, 27 Oct 2025 09:15:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79absm14855116f8f.3.2025.10.27.09.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:15:21 -0700 (PDT)
Message-ID: <c4a9af3d-498d-4b4e-957d-a5cab0caca79@redhat.com>
Date: Mon, 27 Oct 2025 17:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
To: Jason Gunthorpe <jgg@ziepe.ca>, Gregory Price <gourry@gourry.net>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F> <20251027161146.GG760669@ziepe.ca>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251027161146.GG760669@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 17:11, Jason Gunthorpe wrote:
> On Fri, Oct 24, 2025 at 04:37:18PM -0400, Gregory Price wrote:
>> On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
>>> On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
>>>
>>> So maybe actually that isn't too bad of an idea...
>>>
>>> Could also be
>>>
>>> nonpresent_or_swap_t but that's kinda icky...
>>
>> clearly we need:
>>
>> union {
>> 	swp_entry_t swap;
>> 	nonpresent_entry_t np;
>> 	pony_entry_t pony;
>> 	plum_emtry_t beer;
>> } leaf_entry_t;
>>
>> with
>>
>> leaf_type whats_that_pte(leaf_entry_t);
> 
> I think if you are going to try to rename swp_entry_t that is a pretty
> good idea. Maybe swleaf_entry_t to pace emphasis that it is not used
> by the HW page table walker would be a good compromise to the ugly
> 'non-present entry' term.

Something like that would work for me.

-- 
Cheers

David / dhildenb


