Return-Path: <linux-fsdevel+bounces-18110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7A8B5BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E0C1F22001
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479182499;
	Mon, 29 Apr 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G6jIuhkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CD823A8;
	Mon, 29 Apr 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402008; cv=none; b=gO+N8La36zQmhqbFz9o63re/fxU2FTWBVMrtXHkR4ZFgViPjheTmKpncp+Q7u6RkmngmNBupmLP2guIoJmn492JwrLCCgOprvJhoHGh6NNvptKhSOmUuJSDFJNQjAAbrL2Ey3O78Z2UDp5AeTwquH5xN2619ySW0CJN0d/IhkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402008; c=relaxed/simple;
	bh=Fhs83ZbAkYZQXQM56ipxdCCgzackLcW+b3mmf1PvGHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+34kPEgLLTXXZNStaXwjQF78FY/A1R1l7qFdP8jvtqeNRhlwF8iTZjkqcSw2aKLMqCcRi/7ib6gPV4kbW4lLuYw2Hvzi2Aho1x18oHuYu8FKNMD+55CXkns8JDMm86+FJXaYoypoDe6tMaSCXRxBQ9dIMC1kIIqXn3iQChCYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G6jIuhkS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TEkGA7032074;
	Mon, 29 Apr 2024 14:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QO8ml3oM6AEXnzIgf1uRDOXfLnFMIu07iom+fZ5HZn8=;
 b=G6jIuhkSYqlYKH7UcTEkLfBTxhtX/Ysl+D68ZnlAlGukGS5cW9XALH1qKArxx4FvKuBI
 n9VZjtQfjib4BAnDMeKHChR07V80gCeQE7DoVBDYCDjMnB++Cr1R2Tjw9UKxFFoluqBA
 bOrK0m86kKrKgRylvWAmxa/L+eSgzvNaivS9T88Zg+1rbERsP1FiSw9lNHZ108ujN8JB
 ttYBafZWc4qEKbgXzP95xltOKTMcPDNe9dgJL0ZPoyLQHHXehdHlhZg7DlJLOPxyMXmz
 boT4k30JhELejPJyZ+BIXNoB/dfLZa1GUUbfYKAoKN9Rxuwzrw/MQMsKcZozT6jddugF kQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtcy6r4fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:46:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TE2Snx001443;
	Mon, 29 Apr 2024 14:41:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptr1up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:41:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TEfMtQ58524094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:41:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 968CE58066;
	Mon, 29 Apr 2024 14:41:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E87A158068;
	Mon, 29 Apr 2024 14:41:19 +0000 (GMT)
Received: from [9.171.53.131] (unknown [9.171.53.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 14:41:19 +0000 (GMT)
Message-ID: <dc4325fb-d723-4d9f-adb7-7ee65a195231@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:41:19 +0200
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
 <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
 <20240428185823.GW2118490@ZenIV> <20240428232349.GY2118490@ZenIV>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240428232349.GY2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F5U40lbmVabxMZE9O7j__YMMi9ehI18J
X-Proofpoint-ORIG-GUID: F5U40lbmVabxMZE9O7j__YMMi9ehI18J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290093

Am 29.04.24 um 01:23 schrieb Al Viro:
> On Sun, Apr 28, 2024 at 07:58:23PM +0100, Al Viro wrote:
>> On Wed, Apr 17, 2024 at 02:47:14PM +0200, Stefan Haberland wrote:
>>
>>> set_blocksize() does basically also set i_blkbits like it was before.
>>> The dasd_format ioctl does only work on a disabled device. To achieve this
>>> all partitions need to be unmounted.
>>> The tooling also refuses to work on disks actually in use.
>>>
>>> So there should be no page cache to evict.
>> You mean this?
>>          if (base->state != DASD_STATE_BASIC) {
>>                  pr_warn("%s: The DASD cannot be formatted while it is enabled\n",
>>                          dev_name(&base->cdev->dev));
>>                  return -EBUSY;
>>          }
>>
>> OK, but what would prevent dasd_ioctl_disable() from working while
>> disk is in use?  And I don't see anything that would evict the
>> page cache in dasd_ioctl_disable() either, actually...
>>
>> What am I missing here?

Thank you for your input.
Let me provide some more insides how it is intended to work.
Maybe there is something we should improve.

This whole code is basically intended to be used by the dasdfmt tool.

For the dasdfmt tool and the dasd_format ioctl we are talking about DASD
ECKD devices.
An important note: for those devices a partition has to be used to access
the disk because the first tracks of the disks are not safe to store user
data. A partition has to be created by fdasd.

A disk in use has the state DASD_STATE_ONLINE.
To format a device the dasdfmt tool has to be called, it does the
following:

The dasdfmt tool checks if the disk is actually in use and refuses to
work on an 'in use' DASD.
So for example a partition that was in use has to be unmounted first.

Afterwards it does the following calls:

BIODASDDISABLE
  - to disable the device and prevent further usage
  - sets the disk in state DASD_STATE_BASIC
BIODASDFMT
  - does the actual formatting
  - checks if the disk is in state DASD_STATE_BASIC (if BIODASDDISABLE was
    called before)
  - this ioctl is usually called multiple times to format smaller parts of
    the disk each time
  - in the first call to this ioctl the first track (track 0) is
    invalidated (basically wiped out) and format_data_t.intensity equals
DASD_FMT_INT_INVAL
  - the last step is to finally format the first track to indicate a
    successful formatting of the whole disk
BIODASDENABLE
  - to enable the disk again for general usage
  - sets the disk to state DASD_STATE_ONLINE again
  - NOTE: a disabled device refuses an open call, so the tooling needs to
    keep the file descriptor open.

So the assumption in this processing is that a possibly used page cache is
evicted when removing the partition from actual usage (e.g. unmounting, ..).

While writing this I get to the point that it might not be the best idea to
rely on proper tool handling only and it might be a good idea to check for
an open count in BIODASDDISABLE as well so that the ioctls itself are safe
to use. (While it does not make a lot sense to use them alone.)
My assumption was that this is already done but obviously it isn't.

> BTW, you are updating block size according to new device size, before
>          rc = base->discipline->format_device(base, fdata, 1);
> 	if (rc == -EAGAIN)
> 		rc = base->discipline->format_device(base, fdata, 0);
> Unless something very unidiomatic is going on, this attempt to
> format might fail...

This is true. I guess the idea here was that the actual formatting of
track 0 is done last after the whole disk was successfully formatted and
everything went fine.
But actually also the invalidation of the first track would do this here.

So we should not only move this after the format_device call but we should
also add a check for DASD_FMT_INT_INVAL which is the first step in the
whole formatting.


My current conclusion would be that this patch itself is fine as is but I
should submit patches later to address the findings in this discussion.



