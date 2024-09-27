Return-Path: <linux-fsdevel+bounces-30245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C901A9884C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060181C229BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8918C918;
	Fri, 27 Sep 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGYFe9qA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3918BC1D;
	Fri, 27 Sep 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440228; cv=none; b=XVPug9M6MPzWVPiUlOCznRqengRME4Ica52MvwoN/7Hd3c2TmwCbo6iqdZf2g3aOmuLaWRkmyo2A02v0aSTjtWY5IC+N6XbMKSLjE9sFCXwYmHl+uuEQD1xUL0OO8etj/o+rVJHUwTI8tpGxDKu0Nl6MFnfjmGHVhL25qVRk8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440228; c=relaxed/simple;
	bh=a3h2hbkd2SAJD+szjSc9cqtg5L0XsCkXzbVeCe0Gqd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Kt62lz6DzUXBe4if/ORe/PQ5j1hzqLNjIlZOcSv53xAfcCzlu+VeMvpR3Qp6IJzxyioER8oGtn3xR68fip2Df8S36N6a6kI5rgqsu9sHUWEMMJtsVLxkJZFsjyVe8Ezbs0IRBAX621mHNTZ4xwVsOMdx/Ya/KuOqeK1Yr/gbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGYFe9qA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R26XTD005581;
	Fri, 27 Sep 2024 12:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=X3KPffXxGN0FIhLP5f2K/FrqF2R
	GS6QdxDbR1ndTZX0=; b=sGYFe9qAb/CiVmT4JsSABkFSS1iewD180v/BmBSG1tx
	aSMKrjKxF+MOqGzv+5hc9KigJpdY2e3K6eIumU1MNSsK3qB/HOnHeajJNqxzg/a5
	MdnYFUPK5gKSRKskepU17H87XqAn+5YL0VPxKQU7A2/8wQTfMPFqEh9fu4+HSGgg
	lSASwpn9GFduHZfSXDk5jxHMZTUVh0yFNcPcLflHvzF3qTGM2L/WTtKDL9z6BSWE
	74VHjrADXjwIlBVQKNHGGRvOjcUWwj8MvY+3OE/BCW7a12s8ToSgpHIcGqPctGiw
	kMyoDCNnxrSVlcxM+SqQMS8KkROb7e8ZQs1dJKXEh5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnjgx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:29:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RCTYnK016144;
	Fri, 27 Sep 2024 12:29:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnjgx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:29:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RA8lXn008722;
	Fri, 27 Sep 2024 12:29:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v1mxbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:29:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48RCTV7v15270396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:29:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FFF520043;
	Fri, 27 Sep 2024 12:29:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5867C20040;
	Fri, 27 Sep 2024 12:29:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.79.55])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Sep 2024 12:29:29 +0000 (GMT)
Date: Fri, 27 Sep 2024 14:29:27 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
        jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
        ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
        tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
        peterx@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 11/12] mm: Remove pXX_devmap callers
Message-ID: <ZvalJ9O/SV9Riiws@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oFQh9Q3qdgOsP-PvuakR2OvYRSStdcRF
X-Proofpoint-ORIG-GUID: 9y1XQY94BFekLXDgIVhFUpi4XYvsL7VN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=771
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270086

On Tue, Sep 10, 2024 at 02:14:36PM +1000, Alistair Popple wrote:

Hi Alistair,

> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 5a4a753..4537a29 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -193,7 +192,7 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
>  	pmd_t pmd;
>  	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
>  	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
> -		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
> +		   || !pmd_present(*pmdp));

That looks broken.

>  	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
>  	/*
>  	 * if it not a fullmm flush, then we can possibly end up converting

Thanks!

