Return-Path: <linux-fsdevel+bounces-25242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47394A423
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6CA1C22687
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82B1D47AF;
	Wed,  7 Aug 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eficly/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8E1CCB44;
	Wed,  7 Aug 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022319; cv=none; b=m5bfyjU171ydW29MA4WarCpunELBG7cP19p2vwqpyu+LINgo7Ovzt7lUZziMAsy9aH7jJTDjR0R4DA/3YT0h+by7qOrJFjpG+IYm4gOivPklobmaVOYCML9IzLdcrsCLn26XgpzpPbm/kru15/tO6hQFcRkdBxoR+JE1DoqAdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022319; c=relaxed/simple;
	bh=F7JHj5tx/WNkjygiOjcFymG8PkigNzUK09jzCY2n4cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jq+pvl9ILrBxM4Xmb8eFUGgepmLYaZ6vddZUFjVioJn13Wyb3RpDMQyoyYudMekDoRUORtVAQPBPvRWKaeBpf4U8TuR+qaphjAWOGubRuUGT753rFOFCcge9h17oxOJ+/mnU869Uju+VNCNai4oYqZTGeD+6cL7SAVGcdSONRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eficly/Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772MdjR012388;
	Wed, 7 Aug 2024 09:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	7mws3e+hPiZ9f81L9jK8hNBJFT3o16/dbOtA4SrzPe8=; b=eficly/Qy/axfXtC
	iIBxs5amh72AMJu/MNn+9tcte6uD5ViowwjjKXtjbE04o/tbf/dxyIiyld6DS+0e
	FfreqXS8yOd9dKi4ZJQ4H3+gRWRKNcZAyHAwdf9iUWoG6TGh0IloLICP7qm337cD
	1rBEoHrU70jB98vRKnndPl3UIcPShZ61L5stUTCg67SMAd3bjRghfuJ8NQiiLT1g
	t43HZGalmfDkK7jyD9XMIuuTCoT7IF1IMp3j9RZyK6SzsL88yxBZ8OEmudhYmWrh
	OFrfV/TznLa/7LQFzKG6iqIigg1nd8SbvTi0xFu1PPhh2L8xrfGV2pL3RDrvX6mJ
	mZZf6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3v40h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:31 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4779IU5x006018;
	Wed, 7 Aug 2024 09:18:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3v40f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4776sGMF024166;
	Wed, 7 Aug 2024 09:18:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpga88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:18:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4779IMlT56164680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 09:18:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 947142004E;
	Wed,  7 Aug 2024 09:18:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3937520040;
	Wed,  7 Aug 2024 09:18:22 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 09:18:22 +0000 (GMT)
Date: Wed, 7 Aug 2024 10:59:42 +0200
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
Subject: Re: [PATCH v1 08/11] s390/uv: convert gmap_destroy_page() from
 follow_page() to folio_walk
Message-ID: <20240807105942.09088ba3@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240802155524.517137-9-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
	<20240802155524.517137-9-david@redhat.com>
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
X-Proofpoint-GUID: o2XgfFV8At_JQmYslZlIFngIZRsFBdsZ
X-Proofpoint-ORIG-GUID: 5-0t-jLhML_N2kJujz8vN9m8CxVGzemV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_06,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070061

On Fri,  2 Aug 2024 17:55:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's get rid of another follow_page() user and perform the UV calls
> under PTL -- which likely should be fine.
> 
> No need for an additional reference while holding the PTL:
> uv_destroy_folio() and uv_convert_from_secure_folio() raise the
> refcount, so any concurrent make_folio_secure() would see an unexpted
> reference and cannot set PG_arch_1 concurrently.
> 
> Do we really need a writable PTE? Likely yes, because the "destroy"
> part is, in comparison to the export, a destructive operation. So we'll
> keep the writability check for now.
> 
> We'll lose the secretmem check from follow_page(). Likely we don't care
> about that here.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kernel/uv.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 35ed2aea8891..9646f773208a 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -14,6 +14,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/pagewalk.h>
>  #include <asm/facility.h>
>  #include <asm/sections.h>
>  #include <asm/uv.h>
> @@ -462,9 +463,9 @@ EXPORT_SYMBOL_GPL(gmap_convert_to_secure);
>  int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
>  {
>  	struct vm_area_struct *vma;
> +	struct folio_walk fw;
>  	unsigned long uaddr;
>  	struct folio *folio;
> -	struct page *page;
>  	int rc;
>  
>  	rc = -EFAULT;
> @@ -483,11 +484,15 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
>  		goto out;
>  
>  	rc = 0;
> -	/* we take an extra reference here */
> -	page = follow_page(vma, uaddr, FOLL_WRITE | FOLL_GET);
> -	if (IS_ERR_OR_NULL(page))
> +	folio = folio_walk_start(&fw, vma, uaddr, 0);
> +	if (!folio)
>  		goto out;
> -	folio = page_folio(page);
> +	/*
> +	 * See gmap_make_secure(): large folios cannot be secure. Small
> +	 * folio implies FW_LEVEL_PTE.
> +	 */
> +	if (folio_test_large(folio) || !pte_write(fw.pte))
> +		goto out_walk_end;
>  	rc = uv_destroy_folio(folio);
>  	/*
>  	 * Fault handlers can race; it is possible that two CPUs will fault
> @@ -500,7 +505,8 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
>  	 */
>  	if (rc)
>  		rc = uv_convert_from_secure_folio(folio);
> -	folio_put(folio);
> +out_walk_end:
> +	folio_walk_end(&fw, vma);
>  out:
>  	mmap_read_unlock(gmap->mm);
>  	return rc;


