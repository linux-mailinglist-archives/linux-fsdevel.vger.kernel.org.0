Return-Path: <linux-fsdevel+bounces-25101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E58949206
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FA9B2C2DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB71BD009;
	Tue,  6 Aug 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DEW6QBmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619B1D2F76;
	Tue,  6 Aug 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951792; cv=none; b=juzTc9NlnkqwIdqj5ctjmyW7dSiGM4bo0zNpskL74gbxzfbH3q/FrEtmvMhnuOpyBI4U+M3apa/3Qw0yH1QE6evGB6h74Lo/w+kY3eQh0C4Tn1nyTS6eUAoWPXQHTfnTEeXLFnID+VqGiDXTltAJ+jNZdUD+6v2mbK/WFCZhQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951792; c=relaxed/simple;
	bh=lA082ip22lLVe8x0ZBmmSfhhxufL60K2q987v+em9hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHek6JvqRtDh6mHdkJ0v3//96YymNBOYY2031GCL/v2+UfkHMrcdwtRR7hyR/wl6LzpT/KtxQ/YZGNpQB+MOh1Ywg7Mici1e0Y3Rkur+V3qfNWPABiXHkY3RblTvOJpm1Imz29Bm9NXYzWfiTwi2ulxcmnYC7iQDY5r0dtR6l8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DEW6QBmm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DRoHH018110;
	Tue, 6 Aug 2024 13:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	ViIYKO1MfeiBQ75UOWsEMrvjkCQ9oS8o3NQEk+YD2SY=; b=DEW6QBmmpr1DTyaq
	t/tb2eW3cW39ts4r8GQiQCZIdtWv59eyB12PC5kT0hSvwojxns5giEi8eyo3IlCS
	xujOA+kCrZy+/MXCCVvE+Pt29SptJH418l6+GtfXbvJpeIS2M2Go/9MKM2vHdRVU
	ZDIySbCU+HNsCet0n0Q0k5xG1S49u0qU9C8mNaBeEN7Se/6cEIb5mTgCpggTRNJB
	CyvJeHOz5YkJJnaJPwwSMvHPzed7r0oQcxyL7gzq9GTdEuvCd+phB8daoKXUAzrb
	EobOHbX80GNAr05M1hWI+o3X/Tt7wV0gvPPNxbxCmyjaAJwkxkud9j7urQUZmJdK
	cRU/Vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqw0153-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:42:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DgwUb013419;
	Tue, 6 Aug 2024 13:42:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqw0151-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:42:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476D07E5006490;
	Tue, 6 Aug 2024 13:42:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mbjpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:42:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476DgpSx18809256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 13:42:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1242004E;
	Tue,  6 Aug 2024 13:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C71E20043;
	Tue,  6 Aug 2024 13:42:51 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 13:42:51 +0000 (GMT)
Date: Tue, 6 Aug 2024 15:42:49 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v1 00/11] mm: replace follow_page() by folio_walk
Message-ID: <20240806154249.7dbfe37e@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UghynHGbhXTN53HNCkKi-DtAS3l2Q8wb
X-Proofpoint-ORIG-GUID: _M5No_THOE1ACOCJ7EhjKWEJXSyhoXHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxlogscore=371
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060093

On Fri,  2 Aug 2024 17:55:13 +0200
David Hildenbrand <david@redhat.com> wrote:

> Looking into a way of moving the last folio_likely_mapped_shared() call
> in add_folio_for_migration() under the PTL, I found myself removing
> follow_page(). This paves the way for cleaning up all the FOLL_, follow_*
> terminology to just be called "GUP" nowadays.
> 
> The new page table walker will lookup a mapped folio and return to the
> caller with the PTL held, such that the folio cannot get unmapped
> concurrently. Callers can then conditionally decide whether they really
> want to take a short-term folio reference or whether the can simply
> unlock the PTL and be done with it.
> 
> folio_walk is similar to page_vma_mapped_walk(), except that we don't know
> the folio we want to walk to and that we are only walking to exactly one
> PTE/PMD/PUD.
> 
> folio_walk provides access to the pte/pmd/pud (and the referenced folio
> page because things like KSM need that), however, as part of this series
> no page table modifications are performed by users.
> 
> We might be able to convert some other walk_page_range() users that really
> only walk to one address, such as DAMON with
> damon_mkold_ops/damon_young_ops. It might make sense to extend folio_walk
> in the future to optionally fault in a folio (if applicable), such that we
> can replace some get_user_pages() users that really only want to lookup
> a single page/folio under PTL without unconditionally grabbing a folio
> reference.
> 
> I have plans to extend the approach to a range walker that will try
> batching various page table entries (not just folio pages) to be a better
> replace for walk_page_range() -- and users will be able to opt in which
> type of page table entries they want to process -- but that will require
> more work and more thoughts.
> 
> KSM seems to work just fine (ksm_functional_tests selftests) and
> move_pages seems to work (migration selftest). I tested the leaf
> implementation excessively using various hugetlb sizes (64K, 2M, 32M, 1G)
> on arm64 using move_pages and did some more testing on x86-64. Cross
> compiled on a bunch of architectures.
> 
> I am not able to test the s390x Secure Execution changes, unfortunately.

the series looks good; we will do some tests and report back if
everything is ok

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> 
> David Hildenbrand (11):
>   mm: provide vm_normal_(page|folio)_pmd() with
>     CONFIG_PGTABLE_HAS_HUGE_LEAVES
>   mm/pagewalk: introduce folio_walk_start() + folio_walk_end()
>   mm/migrate: convert do_pages_stat_array() from follow_page() to
>     folio_walk
>   mm/migrate: convert add_page_for_migration() from follow_page() to
>     folio_walk
>   mm/ksm: convert get_mergeable_page() from follow_page() to folio_walk
>   mm/ksm: convert scan_get_next_rmap_item() from follow_page() to
>     folio_walk
>   mm/huge_memory: convert split_huge_pages_pid() from follow_page() to
>     folio_walk
>   s390/uv: convert gmap_destroy_page() from follow_page() to folio_walk
>   s390/mm/fault: convert do_secure_storage_access() from follow_page()
>     to folio_walk
>   mm: remove follow_page()
>   mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk
> 
>  Documentation/mm/transhuge.rst |   6 +-
>  arch/s390/kernel/uv.c          |  18 ++-
>  arch/s390/mm/fault.c           |  16 ++-
>  include/linux/mm.h             |   3 -
>  include/linux/pagewalk.h       |  58 ++++++++++
>  mm/filemap.c                   |   2 +-
>  mm/gup.c                       |  24 +---
>  mm/huge_memory.c               |  18 +--
>  mm/ksm.c                       | 127 +++++++++------------
>  mm/memory.c                    |   2 +-
>  mm/migrate.c                   | 131 ++++++++++-----------
>  mm/nommu.c                     |   6 -
>  mm/pagewalk.c                  | 202 +++++++++++++++++++++++++++++++++
>  13 files changed, 413 insertions(+), 200 deletions(-)
> 


