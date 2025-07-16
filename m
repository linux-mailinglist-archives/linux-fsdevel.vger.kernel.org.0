Return-Path: <linux-fsdevel+bounces-55089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97685B06D75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2C50116B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0602E8DEA;
	Wed, 16 Jul 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fUNDB1iK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5517D2;
	Wed, 16 Jul 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645061; cv=none; b=BG5DwSiPuhsb2mFwqZJUQwupch0sIpwp7tZf/3OJpsL+83rY8dx1X+NTZopJ2LNmCIUNaNfq+XecG/ceUp27ZDhmnCOa0MQcJbn38v1IH2skiowrZMpMyfzeid1x32fKUNLQcEauCdyLT1xu9iHSnmHxSJl5mJgQu3d1SMLuxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645061; c=relaxed/simple;
	bh=q46vvL0cdhW+fij7BHHjw4OxEuyA13PBh6VX1NpVcL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rp8eEcyPzPbH/33ua7mJHV2kojRH+XQK7MkFB78LqSRmqEq/XBVocv/bv3dpFjMbbpvLs0B31T9/gjbt0wH6nGYbLw3UXfJTOtxowE+OkoIHEABoFkJSb9/i54b2s6NK8Lwh3OQROerMS7TCmzeZHyMhJWabva0vu/DI3eO6IGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fUNDB1iK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0000D016701;
	Wed, 16 Jul 2025 05:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I61Ysx
	kMcSL5KjNUzEumFFJQqgMjHFGv+4NaJWpDZr8=; b=fUNDB1iKwFs0OcnDzCF/Yy
	9ASv4zz65kon90zS0PZAHGl+8pjhfgieuWXfYEptqN/3wDXx16xrLxhLhyTB1mDC
	n0VKZWGBolvfg8Cj3T4Qb1m6B95JVZeIB5eCAoz5kV05q2AvKUGci6Cl89BTyGK3
	EmunL0yrCQUPUa4+HTnGDzIXZwrruB4X9i4CHQ7WN/YuoAyF/IgsGWxRwZJLzoBS
	AQvw6WqJ6yoicauTyXWMaWUu7LYSI7BmMxOWXOBk67vTll1E2KUPOjsM66E71yLO
	6Onfx3usWkMxyYiCzomtY5XqL7xMxNjXY1yiM9QxM1Nw5tJJDFxIjZtue09DJkqA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtxhc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:50:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G23WIW008988;
	Wed, 16 Jul 2025 05:50:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmntef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:50:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56G5oeWT32244368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 05:50:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A214658059;
	Wed, 16 Jul 2025 05:50:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126A158058;
	Wed, 16 Jul 2025 05:50:37 +0000 (GMT)
Received: from [9.43.110.2] (unknown [9.43.110.2])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 05:50:36 +0000 (GMT)
Message-ID: <a1bd4aed-a1c3-4546-bf99-4e427c45ab46@linux.ibm.com>
Date: Wed, 16 Jul 2025 11:20:35 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de> <aHbAZBf12kiEdXfH@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHbAZBf12kiEdXfH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ngaxYKAAVLqcHHt3SW9M3GdVR8WR3_En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA1MCBTYWx0ZWRfX1XIyTzkq4ss9 uJbvVN3xdufRl9u6Qe5SPy7HSWVIj1TPTxg/WSTXb1C7BdWbbtK9Qsl2QXsjWJTc4QHMnQENLbI ZgfIg9JlLVEpSUo8iimqFFOizBlNw4qKu55wtu5ZB5OZT542QuoZbuOhJ+t7l4mOQu4eOvHBF/C
 +6NcdCFScCOno1V8EvPhEcEcJ6YTMFC0NKLiWQcZDsX1MbUvEeeId2kXrO18m4UrMIhUuxhBkaS uMrj+sM3GZrBAIb3XYbpl7LkpJl6PLRi4m7i/zhG3+rsrggJnOUEByTZ/xangBpJYQS0zSHV4XW ZuKdJUZjQMY0YSNuKRdJlNjaoPZNMjPgr4sQ0pR1gfhFfnLvLW9aCBNrO58tm+TbGQC/OYVBbKn
 +YRa/0j7ACGhW5kUV/7BJvhxTS3e/bQFWcSqWWnIL1dcFKsjPAd3+iYetMh0cx1gC1vvMvjP
X-Proofpoint-ORIG-GUID: ngaxYKAAVLqcHHt3SW9M3GdVR8WR3_En
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68773db2 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kLWA3gBXtu5QbDPQ:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Cdajwa0swSnkgbHL8UIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=895 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160050



On 7/16/25 2:26 AM, Keith Busch wrote:
> On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
>> Is is just me, or would it be a good idea to require an explicit
>> opt-in to user hardware atomics?
> 
> IMO, if the block device's limits reports atomic capabilities, it's fair
> game for any in kernel use. These are used outside of filesystems too,
> like through raw block fops.
> 
> We've already settled on discarding problematic nvme attributes from
> consideration. Is there something beyond that you've really found? If
> so, maybe we should continue down the path of splitting more queue
> limits into "hardware" and "user" values, and make filesystems subscribe
> to the udev value where it defaults to "unsupported" for untrusted
> devices.
> 
If we're going down the path of disregarding atomic write support for 
NVMe devices that don't report NAWUPF, then we likely need an opt-in
mechanism for users who trust their device to have a sane AWUPF value.

For example, consider an NVMe disk that does not support NAWUPF, but 
does consistently support AWUPF across all namespaces and for different
LBA sizes. In such cases, I would still want to enable atomic writes on
this disk, even if the kernel driver marks it as "unsupported" due to
missing NAWUPF.

Having an explicit user opt-in mechanism in such scenarios would be very
useful, allowing advanced users to take advantage of hardware capabilities
they trust, despite conservative kernel defaults. 

Thanks,
--Nilay

