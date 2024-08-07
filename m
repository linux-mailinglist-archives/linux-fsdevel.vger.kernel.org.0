Return-Path: <linux-fsdevel+bounces-25243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAF94A426
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D09E1C227CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC851D47DC;
	Wed,  7 Aug 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8uIgdYC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79111D173C;
	Wed,  7 Aug 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022320; cv=none; b=JFf6QgVLqPAOn+bcIXRL+deJW5NlohkHv4K7KXG6TB5W3MCoKtjVvhzqcbrN/TLiLksfaJguTrmQuXiB5QEKXcW2IBIA8fw+zNQ4GlLnD0jC1Ot2RsOlHt5sXH8UAE4+lMUONOWWGtOGBDWpnv4lZNuYhwU4rtHUrS5cLUo8mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022320; c=relaxed/simple;
	bh=T8aTSO/2dVI8mA2YKsGyWRKn9IOf+B60wNr56E2kEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK13oSDhnHXwecs14J0hZLGRK1yjKegIKcjpM0iz3AmoS5pQSt8Iko5Xl8rt1IAKCophFpl9xqTWvNO+T/7/JkckqwOE2kib9jfkli4l/yLDT/boTSurJmpzXPk0q5MyK2YoSkwIy75eAS7KLYAU9kUfbiIYBz6TuWYb+tjbuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8uIgdYC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4773nI23011920;
	Wed, 7 Aug 2024 09:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	FRPcOw9tGf8OE4fz7ACturwmuj00LFYF//zFLstL00Q=; b=C8uIgdYCTigL7u9W
	OXMfG5WPYDZKL7N1xvj+DZYCO4rBbIGPOcPeqR5DpzWhjcizmHZUAByuV02zY7uX
	ju9suFYFrJvlKFjjsFfLUUE9w7tNGTseH9f5s8TWREvA4O83XjeVBSRkATR7ZBIw
	5G9kl++2kAppzJ0JnD2l3trxLCstTdd7nXQS9QvA5qCPBlZb8+3vuP+05G8vn9/i
	YHo4LuTCzSP8/LM4RwBTllrm9RVyHTsVXh0tK5uZd7sBnGIKjnKrTOI8mXtQNZxk
	MXffm2Y6aGWg4EspICuV2iVxwuGji80UIHhOFV/qoDJNIEvMNaUcnTu6zZMNerGr
	tXOOMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40upxjswb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:31 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4779IUjF023086;
	Wed, 7 Aug 2024 09:18:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40upxjswb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4778BNgT006470;
	Wed, 7 Aug 2024 09:18:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mg0tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4779IO6353674478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 09:18:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 392682004B;
	Wed,  7 Aug 2024 09:18:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB92420049;
	Wed,  7 Aug 2024 09:18:23 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 09:18:23 +0000 (GMT)
Date: Wed, 7 Aug 2024 11:15:34 +0200
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
Message-ID: <20240807111534.4e79d7fd@p-imbrenda.boeblingen.de.ibm.com>
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
X-Proofpoint-ORIG-GUID: xUQMTYr_VaqOcbiA3sXVGf_dZFejfHGh
X-Proofpoint-GUID: gJb4lrngEdlo87sVXyxLlBfCnkQ93xgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_06,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=486
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070061

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

The whole series looks good to me, but I do not feel confident enough
about all the folio details to actually r-b any of the non-s390
patches. (I do have a few questions, though)

As for the s390 patches: they look fine. I have tested the series on
s390 and nothing caught fire.

We will be able to get more CI coverage once this lands in -next.

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


