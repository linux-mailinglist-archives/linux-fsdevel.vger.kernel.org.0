Return-Path: <linux-fsdevel+bounces-11113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F985132C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35501C208BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B33BB41;
	Mon, 12 Feb 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oxcAnoTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FD3BB24;
	Mon, 12 Feb 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739631; cv=none; b=WOm4KwFYN5fzs7dM5jmpyc5/Ur3bWeVpdp5O+GPjmpRN0MogKZfHwudusmkX1Gu57tQeVz7dUGkPccytPLCfVk26SML4DCf9Z+SOe6pyMO8MEMQRwqWN3hZwOdSo5+BsYT+xNTWZLbx+HQfDANi90DKzhIvx+d9gS8APGhM0kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739631; c=relaxed/simple;
	bh=0DyiaGyyGIHgup9XhsyQjnGll8E1135K/YwtSLtvfVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcI7pegp7Ezu0ZzwJnvv3BkByV0iXebzbTudjSE9oOweB/14/gsACmTLzRfzbiQM7VDWvznKA+onv/Fz6bw+YfWhxGSiPEbzWerwEXoDqf3uvgEfevwjN9VHWNn5SbNgH90jQeGyzYVWjdbsf57eGwydMnxoIMtaG4Kq9NMImzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oxcAnoTM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CC3B3D000955;
	Mon, 12 Feb 2024 12:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dGG9SILZKV/Oz0gPPI9T8rSU4QPX3nFvHXj7JOyTqvY=;
 b=oxcAnoTMQedDlO3gplAKicH/zyFcQAsYVZs2R3bamvFCBesi/pDm2Sf6hedDstbaogW1
 Lb8qRsGoBLMqp5G2yQM/NXKMyN/Tg4nEj9eiLbRo/NEIyGYVjt0uGhZcpQ64TPO23+dU
 mIjspfOAymB5ZqDHS+rfZ0b6VQ9xAse8Sp7cNNkIH5USyFzMclJX2Gdp8rOssryplDka
 RqGehGUulfNc+Z9MXQEVULLIwH56dJyYdrKp+3mGqIxSonKGnHKzI93xOJPMjVEuyoq7
 i96CZcl3zpKXPnbL/8ZdgbzyKcfzchCzyCS/9DvLq1xsNuAbjgjKvDcoFtVvAtxTRGt3 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7k0a02c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:07:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CC3YTu002029;
	Mon, 12 Feb 2024 12:07:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7k0a029u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:07:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAO7EX024888;
	Mon, 12 Feb 2024 12:06:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp0cqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:06:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CC6nl363570366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 12:06:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64AE820040;
	Mon, 12 Feb 2024 12:06:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1656020043;
	Mon, 12 Feb 2024 12:06:47 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 12:06:46 +0000 (GMT)
Date: Mon, 12 Feb 2024 17:36:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <ZcoJ1IqADvWdYgFa@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <ZcXQ879zXGFOfDaL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <66e0b76e-c1aa-4e65-9372-07a1fccaeb6b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e0b76e-c1aa-4e65-9372-07a1fccaeb6b@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yi_Qjc2kOH7LAh_FkIuacgaQAClRoDaf
X-Proofpoint-GUID: ySSzboXxOFKAKju86qpfYKgmU7Radp3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=876
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120092

On Fri, Feb 09, 2024 at 09:22:20AM +0000, John Garry wrote:
> On 09/02/2024 07:14, Ojaswin Mujoo wrote:
> > On Wed, Jan 24, 2024 at 02:26:39PM +0000, John Garry wrote:
> > > This series expands atomic write support to filesystems, specifically
> > > XFS. Since XFS rtvol supports extent alignment already, support will
> > > initially be added there. When XFS forcealign feature is merged, then we
> > > can similarly support atomic writes for a non-rtvol filesystem.
> > 
> > Hi John,
> > 
> > Along with rtvol check, we can also have a simple check to see if the
> > FS blocksize itself is big enough to satisfy the atomic requirements.
> > For eg on machines with 64K page, we can have say 16k or 64k block sizes
> > which should be able to provide required allocation behavior for atomic
> > writes. In such cases we don't need rtvol.
> > 
> I suppose we could do, but I would rather just concentrate on rtvol support
> initially, and there we do report atomic write unit min = FS block size
> (even if rt extsize is unset).

Okay understood. 

Thanks,
ojaswin

> 
> In addition, I plan to initially just support atomic write unit min = FS
> block size (for both rtvol and !rtvol).
> 
> Thanks,
> John

