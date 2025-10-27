Return-Path: <linux-fsdevel+bounces-65737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29789C0F5ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A315188D3A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18585314B90;
	Mon, 27 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbxakDrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE001314B6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582723; cv=none; b=h3uQQx5BeCGEwsp83dpE2MuKf1VAKwVJA08O7eocd3eJPcVIRitrsZc+/NDbUmy7ukYrbFSJtipi8dCEEOOzeGKwf9E9ohKqy8hU2QtTxAaHwEPuZQPM0rkwdP4rf9LohK+y1Gukq+lKFVg/Ci0pdFVWMmxbRyX415/qZ2PUHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582723; c=relaxed/simple;
	bh=iNeib+L/sv3iKHk1dJkrzOT6vJ28kpHPaFmhxbuhswo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Chv8Yf5Lzccn9c/Kuc/+dtDxMadryq/CTeheEBChBz4+aXjQ2QYl2xirfo5nU5qVcJpqsJUAomkEAAhY/UdDEHrknz+oIy1rnlv4eYj3nDgh0GZRYN9gmhmGagHXiDnu5GLCzH81K4QRPuluJuRpWMQA9A9qE1MM44MOBjfOr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbxakDrD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761582720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a4SSBM/POjfRiBE6DHhiqMi9Y8mKWaQroye8KGKfKMM=;
	b=gbxakDrDCbMabVd6hrUKAHuVAusX/ByplZAFX8NLNCD67r+pbXbddv+TCLDgbI4TmB5Fi9
	mHnM+MJBWXcppVAPZnbVTpPdx8iBz2ehlDQlMIa+NYr5ArvcMhOTYYc9E6YzPUDsLWpXzE
	WxWlwqGOj3Ii6xoAim2Ab/PrcoeQt74=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-tf2kcxpyMPSYmvPQVKpavA-1; Mon, 27 Oct 2025 12:31:59 -0400
X-MC-Unique: tf2kcxpyMPSYmvPQVKpavA-1
X-Mimecast-MFC-AGG-ID: tf2kcxpyMPSYmvPQVKpavA_1761582718
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477124f7c00so3927535e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582718; x=1762187518;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4SSBM/POjfRiBE6DHhiqMi9Y8mKWaQroye8KGKfKMM=;
        b=e30v6EJW7P1/KfFFWPA7zvv8ID2kNam6aOQJ5Xzg/Rq1fGZH/8Q+yDDkLhhV4p0wKz
         XoLsExSG8CMdj9p5wVhwaqr8c14DG06hCsepmYrVKPznmzB940GcEisFIHOVGhWITps6
         W+zbDpNYOj9VulAST64z55ryPoCgcLuM3ujPJHmBjC/MKv5rzDlwHis+iRHA2Chb5QAK
         V0d2KBSlS0+Ur9Kup7kFHFgUbkcNvfjep3zlAtT4ouY6dDDmy4kjkgURNB6qspNRrjKC
         hrABFl60NIhAPn+wCJPgssg7R+ByVCyCUC7t1fwbjcnEsdeuMpoHdZIVsIR6Gm9XJhFh
         WY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWmRZQoQoD8q6PemvFo4pRU7/5sYVPb+JXf2cEKmeCgZebOSlNrC3F388ImjO5HeHXEPr3Vg8xeYTOWkIpd@vger.kernel.org
X-Gm-Message-State: AOJu0YybrV+0zKzygHem7IUKT3jE53NJfgn9qHPokLPeeBu10AOlMac3
	7hOte/cWe/cOQ17+NfMyNVMT3fofNpuX7EC40aXr9mGPoraephTX//fvLKcLntyv0MlB4j38FoB
	FgaLAP6CDE8siscFlUgNrpvNMFRHtt4tHWanlXTbExs2ZMLwGOxTUuN8+OXmjeqvtM+c=
X-Gm-Gg: ASbGncuppD3lfYRIWiudNDm9Ofd++vflelhUd1PU91TP+pBZ9EJ5TkfoPl48zvuhyNe
	gpjJx67qOvwc2eMWf9rQT/3L27x2xspxqmMsR4gfy5DMTOj4dTkUzAryl93BXq5b5uTWNLSzkaj
	lZy3O8Q1jywasVMNHBmEhlO6K7KbDtv/pGpM9nJeM7priXs/+bIWFNJ5DOUskNN9ZMLA4hu0m0N
	tneO9NG6bvGyeHNgecH0HHrwaYSGVo0j8kBKbcfkiQyWQcjqebvWtv3pf3u1+vIex5NWVq9obyA
	SCI73+19aOIElEuuHmn3nOAeGPZR3aoqmzH5OTA/Pa/T+MCWIxhr9j/QdkynoIJ0+AEvBWIycBe
	hpSXeroTEiKO/dKdnk8zOuUykoGzKYhgbek/a4hXojS3SareWZzhiz53QTPZbwV/CYUWHkLBZj9
	eIeTPEp4hQpf2+13OutKq4JptuHqM=
X-Received: by 2002:a05:600c:540d:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-47717e6ae77mr2486235e9.40.1761582717995;
        Mon, 27 Oct 2025 09:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9hBUduL/K2sJ2VMSMKpTvh6O7vT8Cwrl1/5Mssg7iiqgi3rWLBvdxmliRcG5sUi4pRS1k8Q==
X-Received: by 2002:a05:600c:540d:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-47717e6ae77mr2485705e9.40.1761582717529;
        Mon, 27 Oct 2025 09:31:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm141374155e9.5.2025.10.27.09.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:31:56 -0700 (PDT)
Message-ID: <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
Date: Mon, 27 Oct 2025 17:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gregory Price <gourry@gourry.net>,
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
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> I don't love the union.
> 
> How would we determine what type it is, we'd have to have some
> generic_leaf_entry_t type or something to contain the swap type field and then
> cast and... is it worth it?
> 
> Intent of non-present was to refer to not-swap swapentry. It's already a
> convention that exists, e.g. is_pmd_non_present_folio_entry().

Just noting that this was a recent addition (still not upstream) that 
essentially says "there is a folio here, but it's not in an ordinary 
present page table entry.

So we could change that to something better.

-- 
Cheers

David / dhildenb


