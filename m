Return-Path: <linux-fsdevel+bounces-25241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1A94A41A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB82A1F24385
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE81D278B;
	Wed,  7 Aug 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jKh1Fz+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B41CB32D;
	Wed,  7 Aug 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022318; cv=none; b=dSNrF3w23mig2v1c2wKNN+uYaoI3ujpY6zvoJg7D8v7vvqFr8AL8pHK1Myt/DGbjII05Z9xPtxXcRjmZEKBYsXwbLKJD0qXHcty/Q4S5gQhs527FmsYHebC7InvLr2xBzDMHew0PDxxzjocJRCpi4pJVy0zg59HyJC5gY5fuU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022318; c=relaxed/simple;
	bh=5cQDfC5Igy+dOMaINi4faL+vMKFD/gr0baG/OSkyspE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHNg6Jpht97wYoIIHS6ChXAX1IZ5h401HcXysgHqMMpvnUhT20msAtavaIiJnPR7dQsasfUDUVKuHk4PfLbcfE4FF3ZaAZvdFYsfGgkMdrp06f900bVwjX7yM6eajMWsmvoRbfIwHnVDviuJFbfIXKD9CpM65mLVgKyPbQsNnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jKh1Fz+F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772Mg4V004360;
	Wed, 7 Aug 2024 09:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	uNsMZGr2oVWjL++x60ijGM9WGe6WYWv/kbq2yJwXg+M=; b=jKh1Fz+FBFi0mwqO
	MV3ItSrRBe5scKiJTwWW1PHeaa9Ev790KK5d2nJzivCLdClu+POXpTChtz/qFybu
	zriBWKLessToKX7ns9HjHiAuCkviaZ6BTvL3hpvEcbrPyoIZ3RHcVM9ZQnJRUQWI
	bFJUXA219PmVG6jyKIJWKZje/Vx3qci2v4UDIoFUn6M9YtLlRzgWFKe4U4ArHDvM
	h8J5zCbNm8gf0l58iQ/RLaMii68ylpcLtx5CiLp09nN8mRxb+CYUKNTmonj7+rJ/
	j6P2eDeq+Sf3aT6dVPqb3HfFe+6E8UlrBUxcPJQQFHpWn2KZzIwA2F1m9Qk5ZWl/
	eVhx8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uqcmsuqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4779ISxt022027;
	Wed, 7 Aug 2024 09:18:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uqcmsuqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4776jchf024334;
	Wed, 7 Aug 2024 09:18:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90re6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4779ILBw44499382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 09:18:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E777D2004D;
	Wed,  7 Aug 2024 09:18:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915442005A;
	Wed,  7 Aug 2024 09:18:20 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 09:18:20 +0000 (GMT)
Date: Wed, 7 Aug 2024 11:17:54 +0200
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
Subject: Re: [PATCH v1 02/11] mm/pagewalk: introduce folio_walk_start() +
 folio_walk_end()
Message-ID: <20240807111754.2148d27e@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240802155524.517137-3-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
	<20240802155524.517137-3-david@redhat.com>
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
X-Proofpoint-GUID: QZDnbRCTrHzGHPwcFsTSM6OgIGkWYGg-
X-Proofpoint-ORIG-GUID: ExZxiMrxkJBcLr00SNuG5SU2WVyrL9U6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_06,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=258 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070061

On Fri,  2 Aug 2024 17:55:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> We want to get rid of follow_page(), and have a more reasonable way to
> just lookup a folio mapped at a certain address, perform some checks while
> still under PTL, and then only conditionally grab a folio reference if
> really required.
> 
> Further, we might want to get rid of some walk_page_range*() users that
> really only want to temporarily lookup a single folio at a single address.
> 
> So let's add a new page table walker that does exactly that, similarly
> to GUP also being able to walk hugetlb VMAs.
> 
> Add folio_walk_end() as a macro for now: the compiler is not easy to
> please with the pte_unmap()->kunmap_local().
> 
> Note that one difference between follow_page() and get_user_pages(1) is
> that follow_page() will not trigger faults to get something mapped. So
> folio_walk is at least currently not a replacement for get_user_pages(1),
> but could likely be extended/reused to achieve something similar in the
> future.

[...]

> +struct folio *folio_walk_start(struct folio_walk *fw,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		folio_walk_flags_t flags)
> +{
> +	unsigned long entry_size;
> +	bool expose_page = true;
> +	struct page *page;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +	spinlock_t *ptl;
> +	pgd_t *pgdp;
> +	p4d_t *p4dp;
> +
> +	mmap_assert_locked(vma->vm_mm);
> +	vma_pgtable_walk_begin(vma);
> +
> +	if (WARN_ON_ONCE(addr < vma->vm_start || addr >= vma->vm_end))
> +		goto not_found;
> +
> +	pgdp = pgd_offset(vma->vm_mm, addr);
> +	if (pgd_none_or_clear_bad(pgdp))
> +		goto not_found;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (p4d_none_or_clear_bad(p4dp))
> +		goto not_found;
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = pudp_get(pudp);
> +	if (pud_none(pud))
> +		goto not_found;
> +	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pud_leaf(pud)) {
> +		ptl = pud_lock(vma->vm_mm, pudp);
> +		pud = pudp_get(pudp);
> +
> +		entry_size = PUD_SIZE;
> +		fw->level = FW_LEVEL_PUD;
> +		fw->pudp = pudp;
> +		fw->pud = pud;
> +
> +		if (!pud_present(pud) || pud_devmap(pud)) {
> +			spin_unlock(ptl);
> +			goto not_found;
> +		} else if (!pud_leaf(pud)) {
> +			spin_unlock(ptl);
> +			goto pmd_table;
> +		}
> +		/*
> +		 * TODO: vm_normal_page_pud() will be handy once we want to
> +		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
> +		 */
> +		page = pud_page(pud);
> +		goto found;
> +	}
> +
> +pmd_table:
> +	VM_WARN_ON_ONCE(pud_leaf(*pudp));

is this warning necessary? can this actually happen?
and if it can happen, wouldn't it be more reasonable to return NULL?

> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = pmdp_get_lockless(pmdp);
> +	if (pmd_none(pmd))
> +		goto not_found;
> +	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pmd_leaf(pmd)) {
> +		ptl = pmd_lock(vma->vm_mm, pmdp);
> +		pmd = pmdp_get(pmdp);
> +
> +		entry_size = PMD_SIZE;
> +		fw->level = FW_LEVEL_PMD;
> +		fw->pmdp = pmdp;
> +		fw->pmd = pmd;
> +
> +		if (pmd_none(pmd)) {
> +			spin_unlock(ptl);
> +			goto not_found;
> +		} else if (!pmd_leaf(pmd)) {
> +			spin_unlock(ptl);
> +			goto pte_table;
> +		} else if (pmd_present(pmd)) {
> +			page = vm_normal_page_pmd(vma, addr, pmd);
> +			if (page) {
> +				goto found;
> +			} else if ((flags & FW_ZEROPAGE) &&
> +				    is_huge_zero_pmd(pmd)) {
> +				page = pfn_to_page(pmd_pfn(pmd));
> +				expose_page = false;
> +				goto found;
> +			}
> +		} else if ((flags & FW_MIGRATION) &&
> +			   is_pmd_migration_entry(pmd)) {
> +			swp_entry_t entry = pmd_to_swp_entry(pmd);
> +
> +			page = pfn_swap_entry_to_page(entry);
> +			expose_page = false;
> +			goto found;
> +		}
> +		spin_unlock(ptl);
> +		goto not_found;
> +	}
> +
> +pte_table:
> +	VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));

same here

> +	ptep = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
> +	if (!ptep)
> +		goto not_found;
> +	pte = ptep_get(ptep);
> +
> +	entry_size = PAGE_SIZE;
> +	fw->level = FW_LEVEL_PTE;
> +	fw->ptep = ptep;
> +	fw->pte = pte;
> +
> +	if (pte_present(pte)) {
> +		page = vm_normal_page(vma, addr, pte);
> +		if (page)
> +			goto found;
> +		if ((flags & FW_ZEROPAGE) &&
> +		    is_zero_pfn(pte_pfn(pte))) {
> +			page = pfn_to_page(pte_pfn(pte));
> +			expose_page = false;
> +			goto found;
> +		}
> +	} else if (!pte_none(pte)) {
> +		swp_entry_t entry = pte_to_swp_entry(pte);
> +
> +		if ((flags & FW_MIGRATION) &&
> +		    is_migration_entry(entry)) {
> +			page = pfn_swap_entry_to_page(entry);
> +			expose_page = false;
> +			goto found;
> +		}
> +	}
> +	pte_unmap_unlock(ptep, ptl);
> +not_found:
> +	vma_pgtable_walk_end(vma);
> +	return NULL;
> +found:
> +	if (expose_page)
> +		/* Note: Offset from the mapped page, not the folio start. */
> +		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
> +	else
> +		fw->page = NULL;
> +	fw->ptl = ptl;
> +	return page_folio(page);
> +}


