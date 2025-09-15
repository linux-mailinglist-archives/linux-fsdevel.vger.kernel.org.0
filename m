Return-Path: <linux-fsdevel+bounces-61421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355BB57EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C33189F19E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F54A326D54;
	Mon, 15 Sep 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r3sqyolF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF22F39AE;
	Mon, 15 Sep 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946458; cv=none; b=I9X1KODb5Sweh4hknjTye/1pcgjnJ/Ml6RenXbVAnjW/kMM81vqCbnfz2v11zeovLeQgCzz5ER2pb2vrXu3RkelzAgoV8NTiTZ9OV5tUXD/PkqJ8bbgO4FeM/daNQvc6J4SkhDvF2xtyXtMnSb31oAXw7yRXY1a/zL+Kdmf2/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946458; c=relaxed/simple;
	bh=UR2OzmXG8ec89TIxokqMWyC22lGLqmnSJ94CoLJ8Oj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQZYEgkFHtWoYcvaomCq7nSiVf95qTMBvqoz68Jz06DBQDUqMuZBZ/LDNN/iRuMPCtaZjklgeio4y+x3KGiDfZ8Do/65W+BGKjw+kfUpbLgNN5RXdJUWi31b6khxURBpjDDikjTjHoyvmdrGC7vTjtxx1ea69yrxsguHtG55/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r3sqyolF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9auat018700;
	Mon, 15 Sep 2025 14:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=93gOvoDcBdDF+uhxagbjeVgcwGtEHX
	2Ajjpa7s8ksys=; b=r3sqyolFInDCeWDViJZMPqSncd/mubfFPzlJRMqhGniqLt
	i0svHLuD24/wgKmko+PVfQ0dPS0L2xwCX9nuPIoU9im8LEl3TB6JbNtlFKrp9c9f
	Ul60BOC/R1QomaUkpW5Q9qksws694I8cEAxtvwtovsRKjGRlT3J0aqxOTYqF6d6F
	65szjdMct/qYq2awarrH5MXGmNQCWF78ggkDxUs1cPXK6zLVHGdYKWYt9f44VC0R
	iMQ5o1EkXSywDP5INlMBBEKuZ8lwCbdbwIVBDtjv9MI/zOk6rAAfdIJXxv56KfMZ
	xAJIJDE73H9lJu0ZuWDBOHseGxExRNhG51NBsHxA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat1gxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:26:19 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FE2KcE000732;
	Mon, 15 Sep 2025 14:26:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat1gxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:26:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBale5022328;
	Mon, 15 Sep 2025 14:26:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpevrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 14:26:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FEQD2U58196468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 14:26:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E294D20043;
	Mon, 15 Sep 2025 14:26:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE34720040;
	Mon, 15 Sep 2025 14:26:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Sep 2025 14:26:13 +0000 (GMT)
Date: Mon, 15 Sep 2025 16:26:12 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Venkat <venkat88@linux.ibm.com>
Cc: Julian Sun <sunjunchao@bytedance.com>, tj@kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        songmuchun@bytedance.com, shakeelb@google.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mhocko@suse.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com,
        ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [linux-next20250911]Kernel OOPs while running generic/256 on
 Pmem device
Message-ID: <20250915142612.1412769A80-agordeev@linux.ibm.com>
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com>
 <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
 <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c8220b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=OU48e3ldqOrICINtdUEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jgtZKvDpLeX2b3zEu8f2-Dy7WMTShlp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX8rssnOatAT47
 qK4h0PeWsydAe0MHXzSRtuYWyO575+9NysLJBvrGV6juLdCCu6snHKxKDFdJJKo31gh+AWG/lqp
 JCbTkekkCgnHIudxddKp5Qsj6Oml6txHzFZZ9iIojl35whvWSirBu9qgHHJv8DQGtPo2cWmsM/2
 9FAJt4Li/srUK7PgaVNFHZBjmDdiOd5Dd+kercpV0Bi7B13WgEbXUfQ+HnBrquXDnF/YWzlLxdH
 tMQLRuqWhsSlZNYbKpbyOYLYG2l5k743FHJi7SvDZBILwkoM9LfFHD2/7WhlFAz4mbKI8BV5b65
 nxLJnGik0jq5Ld2KyrctTPfSI0E/JuANG6/mVJ8F7SbxuLsxOtqFfb9+I+x3sOH/LJwyeMP44J3
 z2t7BtXP
X-Proofpoint-ORIG-GUID: k3kwdpkBN8cmqlPUljTfmONvIC_Jnwqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

On Mon, Sep 15, 2025 at 07:49:26PM +0530, Venkat wrote:
> Hello,
> 
> Thanks for the fix. This is fixing the reported issue.
> 
> While sending out the patch please add below tag as well.
> 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

And Reported-by as well, if I may add ;)

> Regards,
> Venkat.

Thanks!

