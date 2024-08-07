Return-Path: <linux-fsdevel+bounces-25240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CED94A419
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3FB1F23A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33891D1F70;
	Wed,  7 Aug 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b7x8/XSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75C1C9DDC;
	Wed,  7 Aug 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022318; cv=none; b=RnRv8ewM5UcHLyz6D8IRzOo3Ybfwulq/OHSJj/me5xPPCNuPvaX03ipaXhf0WtG9v02qO4YCgyytWOYnLJzm/0q+LHX1LPuX8VmZrOr7cV8Qy3o+LzOlXxUE7gEiIRyopdCmnkUW9MCghZMrtJ8IiN9dZmnkZN1bcuckAD7UFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022318; c=relaxed/simple;
	bh=Vb9DQkDGbQBYEGrh11KN21qOTMJAjoEaYp8KcQ5q9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1IvdKTim26NkVarXbefaFXZmnLmkeKgBemLNqNZuVQDzRH49fA7dsMNC9uvAczagssjq57BLeM8yoKzSehYrk36HGrOypXXQp5z1sVbNgnSf2n2UG2NwQ8Wii0/jjeZ3RSqR0XvuE7m8rz+JpuxALRRFSa9IeNU6+SZLl9op9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b7x8/XSz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772NPGG013699;
	Wed, 7 Aug 2024 09:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	ZK+j0DYj8+ExGSLvMB9OQLr9JtUhTZFf+Egoyrl1SN4=; b=b7x8/XSzMZDO/doU
	At92hcRT4hXmcyUY/VhszVzu3v54ci74ehTXLlI2qPOA50XDumg1DSlKdSBj17gE
	6shnK/qdpgrZck7IC2ldcuOuElmoBlhrLESCpHbqVL9MCFGKGLGymqkTE7+ICHik
	tB0eGtzb9S1Hg0xBUPy07JxBpf7ckUe4U/E0+Vr0gYGLmqZe6uB9JPGMAaZXOtmR
	0zQ3W+Gid8geNfwKZNN5IYY3EKAbpJhQCL0gjBiQ+WjCqkllUlxKnaBR84lSLuev
	n7I3AlzRx5G9bSBJRdAdzT7MDHbgV4EUdDbTy3e4e6x1MJPr+XvAUzydlhCDGKZ/
	e84Evw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3v40d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:27 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4779IQZR005973;
	Wed, 7 Aug 2024 09:18:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3v407-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4776YKZK024322;
	Wed, 7 Aug 2024 09:18:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90re68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4779IJY950331948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 09:18:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC0020040;
	Wed,  7 Aug 2024 09:18:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1BD220049;
	Wed,  7 Aug 2024 09:18:18 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 09:18:18 +0000 (GMT)
Date: Wed, 7 Aug 2024 10:59:54 +0200
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
Subject: Re: [PATCH v1 09/11] s390/mm/fault: convert
 do_secure_storage_access() from follow_page() to folio_walk
Message-ID: <20240807105954.088fcb2d@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240802155524.517137-10-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
	<20240802155524.517137-10-david@redhat.com>
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
X-Proofpoint-GUID: nIJf_P5zv6azeuD6BJUKKhUaM836BwTW
X-Proofpoint-ORIG-GUID: y_wj4MLlF6XmpZ56xj7N4YNPQauFq_Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_06,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070061

On Fri,  2 Aug 2024 17:55:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's get rid of another follow_page() user and perform the conversion
> under PTL: Note that this is also what follow_page_pte() ends up doing.
> 
> Unfortunately we cannot currently optimize out the additional reference,
> because arch_make_folio_accessible() must be called with a raised
> refcount to protect against concurrent conversion to secure. We can just
> move the arch_make_folio_accessible() under the PTL, like
> follow_page_pte() would.
> 
> We'll effectively drop the "writable" check implied by FOLL_WRITE:
> follow_page_pte() would also not check that when calling
> arch_make_folio_accessible(), so there is no good reason for doing that
> here.
> 
> We'll lose the secretmem check from follow_page() as well, about which
> we shouldn't really care about.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/mm/fault.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 8e149ef5e89b..ad8b0d6b77ea 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -34,6 +34,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/hugetlb.h>
>  #include <linux/kfence.h>
> +#include <linux/pagewalk.h>
>  #include <asm/asm-extable.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/ptrace.h>
> @@ -492,9 +493,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>  	union teid teid = { .val = regs->int_parm_long };
>  	unsigned long addr = get_fault_address(regs);
>  	struct vm_area_struct *vma;
> +	struct folio_walk fw;
>  	struct mm_struct *mm;
>  	struct folio *folio;
> -	struct page *page;
>  	struct gmap *gmap;
>  	int rc;
>  
> @@ -536,15 +537,18 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		vma = find_vma(mm, addr);
>  		if (!vma)
>  			return handle_fault_error(regs, SEGV_MAPERR);
> -		page = follow_page(vma, addr, FOLL_WRITE | FOLL_GET);
> -		if (IS_ERR_OR_NULL(page)) {
> +		folio = folio_walk_start(&fw, vma, addr, 0);
> +		if (!folio) {
>  			mmap_read_unlock(mm);
>  			break;
>  		}
> -		folio = page_folio(page);
> -		if (arch_make_folio_accessible(folio))
> -			send_sig(SIGSEGV, current, 0);
> +		/* arch_make_folio_accessible() needs a raised refcount. */
> +		folio_get(folio);
> +		rc = arch_make_folio_accessible(folio);
>  		folio_put(folio);
> +		folio_walk_end(&fw, vma);
> +		if (rc)
> +			send_sig(SIGSEGV, current, 0);
>  		mmap_read_unlock(mm);
>  		break;
>  	case KERNEL_FAULT:


