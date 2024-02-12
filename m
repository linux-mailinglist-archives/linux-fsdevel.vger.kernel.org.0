Return-Path: <linux-fsdevel+bounces-11112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49626851323
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE943B27D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79E3A8D7;
	Mon, 12 Feb 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrqJ+Zzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F53A8D6;
	Mon, 12 Feb 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739575; cv=none; b=U9qmVyKXQulLgwgOR891CyCRixmJU84X4jYQDBZghZrk6VuwA9qqm6i8meYAYJkDpJ95tuS3O/ImAeLZPktOWyATAst10XvRjwEA7fLEPO3Vb27hK+sx0JCVnIhdaw/SW5XUk19XQ7Ufp3Cs7AQ4DdV4z3MZhPw04UHtVnKoIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739575; c=relaxed/simple;
	bh=Wj1Bx+ORc780amYfcnyH0jUkdbacpOiyptGUnVCMAiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRieNER9S/oX7iJjfu0kLe/8cb3d8G8hzA/T7eMlHTk6b3LOffs6yMCUw96PwFwpKUv8/QK+UcNP6wiV3577MuL1oSDJW3LriD2+7fM5PLrg1vH8hrq63xXSrBWqIDUUcaimaIUureGMy94kgWRHBHlP88YReXtkXwf29vbLW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrqJ+Zzn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBuMtg027065;
	Mon, 12 Feb 2024 12:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Wj1Bx+ORc780amYfcnyH0jUkdbacpOiyptGUnVCMAiE=;
 b=LrqJ+ZznGcXpk2/klyB5BIuAalcafhrItd5nJVFkd+PTaEN8KtYViMRZzlmhOTQacDgU
 oviIhp5cjwR+j4oJf+aiDLKOm6vBNNS3H61QGU8gjtqbNGYKtzCT+PnXvLZyJ7vjv67h
 ebMmMltIhIZTaQdKAiZBEOCLhgBKpGX1zh3dT0HnSjzWVcR9RoOumoXteL8GBLCgpUV/
 jiLWAYMG410QaeRqBxdq+SS99J026uOYa6JlVbOFL/GZ38eCxKz2aPGbGVgU3QVfdzIX
 KlGBFX3NAIZsb3GqqQqwnZwIoIIseSaIb2bQracek8jTx7qBOX5qdyz5vsNL7vP9nVOT OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jw8rfm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:06:04 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CBucuv028176;
	Mon, 12 Feb 2024 12:06:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jw8rfku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:06:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CC1ZCt009728;
	Mon, 12 Feb 2024 12:06:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62fwhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:06:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CC5wQg24773246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 12:06:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CEBD20043;
	Mon, 12 Feb 2024 12:05:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F7820040;
	Mon, 12 Feb 2024 12:05:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 12:05:56 +0000 (GMT)
Date: Mon, 12 Feb 2024 17:35:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Message-ID: <ZcoJossEQe6QIIM+@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <ZcXNidyoaVJMFKYW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <36437378-de35-48dc-8b1e-b5c1370e38b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36437378-de35-48dc-8b1e-b5c1370e38b0@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yz_9j8QJ6aXP9aheSmS02njmCgE8aigr
X-Proofpoint-ORIG-GUID: I2AGZZshADJdEP-gsA_Gj8B0Kskv6lmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 mlxlogscore=693 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120091

On Fri, Feb 09, 2024 at 05:30:50PM +0000, John Garry wrote:
> The same goes for atomic write boundary in NVMe. Currently we say that it
> needs to be a power-of-2. However, it really just needs to be a multiple of
> awu_max. So if some HW did report a !power-of-2 atomic write boundary, we

Hey John, sorry for double reply but can you point out where this
requrement is stated in the spec?

For example in NVME 2.1.4.3 Command Set spec I can see that

> The boundary size shall be greater than or equal to the corresponding
> atomic write size

However I'm not able to find the multiple-of-unit-max reqirement in the
spec. Maybe I'm missing something?

Regards,
ojaswin

> could reduce awu_max reported until to fits the power-of-2 rule and also is
> cleanly divisible into atomic write boundary. But that is just not what HW
> will report (I expect). We live in a power-of-2 data granularity world.

