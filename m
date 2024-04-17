Return-Path: <linux-fsdevel+bounces-17128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FB8A8363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248CCB22590
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2313D296;
	Wed, 17 Apr 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WyUY8cEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7663D72;
	Wed, 17 Apr 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358073; cv=none; b=P7jfeGiKUvqb8hRwUJeG/XVvKiaeLkWTGyey/gQ/97bviGPHBUV/X3EEnUwWVHydLDg/V+uV5MuzUk12d79jyhZAb4TmWeRYn9Fy2CRMTCCT92DQbZRnTEanP9+iWxkJ1Udg2IpMr5Vp/DQIIgUxXAaywksSP3OCK2cUzBoQpf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358073; c=relaxed/simple;
	bh=yxbc01E0e4nTR/6Zi239IWaOS8B4C9D8BXhUt4FFEj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRBF4N8Y4A+QNLeWsr4ozFRq8M7Vlki8leUckdmAnBlx5MRLWiXm45AycpKleLbxGGgsYWSkGqZrHv8i2iPYowq2MiHOZzjTxXeLvVNLeouzlkgq1xfytuUB0VZ7uOQ5JMMAwm/D077qqoNaN/gZe3wA8wCEqFg7dgu2HxDUnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WyUY8cEF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HCgJlx010002;
	Wed, 17 Apr 2024 12:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MXPOw+Np7H2q/8CV5vR1O5+Cs6lgumWnTKFEEgRg/7U=;
 b=WyUY8cEFN529rohcvw7bolSO9r+RiVXjiDDg1yDVFOAEFPqXT6Q9xydy1kIqrLwZLIGw
 qO+hCVg3AgU39HZZEE992QLY/9Iq9LJd53jW+WEBfX5MSfF7VX3UNGEynJQ77KlLuHr9
 qnnwofYH8EBsCNNptBFJXHh8lu0VG0qTgsr7ePbOabopzo3nZfCBSplhABVIlWw8NGMb
 /cQSXk/BuNZByz4EjsJAYjYXQRZytJSSx/nzDDTnfStA/rf3Pwgm8X5PNND5EA1/m0kh
 vbKP1dW+kKD2cL/6522tMqViSZk5CH6/DQ+KTaM3Qf8HT8V4UcUReZnfpSbE2C3yP6HH rQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjenqg0ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:47:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HCJktH015835;
	Wed, 17 Apr 2024 12:47:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vmcbw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:47:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HClHFM25559758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:47:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37A8658061;
	Wed, 17 Apr 2024 12:47:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C55D58057;
	Wed, 17 Apr 2024 12:47:15 +0000 (GMT)
Received: from [9.152.212.230] (unknown [9.152.212.230])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 12:47:14 +0000 (GMT)
Message-ID: <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
Date: Wed, 17 Apr 2024 14:47:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de, brauner@kernel.org,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
 <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y94lO4p7X-84KujGc7Oc6H9VBrYPh5dA
X-Proofpoint-ORIG-GUID: Y94lO4p7X-84KujGc7Oc6H9VBrYPh5dA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170088

Am 16.04.24 um 10:47 schrieb Alexander Gordeev:
> On Tue, Apr 16, 2024 at 02:35:55AM +0100, Al Viro wrote:
>>>   drivers/s390/block/dasd_ioctl.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
>>> index 7e0ed7032f76..c1201590f343 100644
>>> --- a/drivers/s390/block/dasd_ioctl.c
>>> +++ b/drivers/s390/block/dasd_ioctl.c
>>> @@ -215,8 +215,9 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
>>>   	 * enabling the device later.
>>>   	 */
>>>   	if (fdata->start_unit == 0) {
>>> -		block->gdp->part0->bd_inode->i_blkbits =
>>> -			blksize_bits(fdata->blksize);
>>> +		rc = set_blocksize(block->gdp->part0, fdata->blksize);
>> Could somebody (preferably s390 folks) explain what is going on in
>> dasd_format()?  The change in this commit is *NOT* an equivalent
>> transformation - mainline does not evict the page cache of device.
>>
>> Is that
>> 	* intentional behaviour in mainline version, possibly broken
>> by this patch
>> 	* a bug in mainline accidentally fixed by this patch
>> 	* something else?
>>
>> And shouldn't there be an exclusion between that and having a filesystem
>> on a partition of that disk currently mounted?
> CC-ing Stefan and Jan.
>
> Thanks!

Hi,
from my point of view this was an equivalent transformation.

set_blocksize() does basically also set i_blkbits like it was before.
The dasd_format ioctl does only work on a disabled device. To achieve this
all partitions need to be unmounted.
The tooling also refuses to work on disks actually in use.

So there should be no page cache to evict.

The comment above this code says:

/* Since dasdfmt keeps the device open after it was disabled,
  * there still exists an inode for this device.
  * We must update i_blkbits, otherwise we might get errors when
  * enabling the device later.
  */

This is the reason for updating i_blkbits.

However, I get your point to question the code itself.

Honestly this code exists for many years and I can not tell if the
circumstances of the comment have changed in between somehow.
A quick test without this code did not show any change or errors but
there might be corner cases I am missing.

Maybe you can give a hint if this makes any sense from your point of view.

Thanks,
Stefan


