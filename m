Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E82C3A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 08:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKYHUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 02:20:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58180 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgKYHUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:20:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP78dtC035974;
        Wed, 25 Nov 2020 07:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=P11wfyw6N9I5O2TUURcfkhBRfDzRLjlWVpteChZnBqc=;
 b=lJ5FVu75iAH8IaqJy/9aoubXb/XpzMh8MaskZWTzO+Ou84u4bKDkyDLD1AjufjXJFh1C
 FYIOz5mDlu6QPAlxW75qDoQfRlmOXXsaQUngkXQQvuF9Gv/QM9MfzpggMkVobHallEha
 frSfUAXkLZPaG05gFtytUmIlYhdP4JuAB/VYTSeKDwuJQDjYRjv+ZTWl4cQHv9yhja5r
 YsIKRXKZLxa0AvrMc0HtJFT+g17pYZjvzCYT4J79pqi0iXYhHLuxZ0Bb28yIAe4M/XyT
 ipHjJf88cP55aWBh6XoZt7SzMbakU60xw0+JXybAu3V+dU6XQksRsHM+OyIpChhkVIbM Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3514q8k4rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 07:19:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP7Fhk5004041;
        Wed, 25 Nov 2020 07:17:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34yx8ktt43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 07:17:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AP7HqeN024591;
        Wed, 25 Nov 2020 07:17:53 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 23:17:52 -0800
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
 <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
 <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c4e78093-0518-49b2-5728-79d68dc87dc5@oracle.com>
Date:   Wed, 25 Nov 2020 15:17:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250041
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 25/11/20 9:57 am, Naohiro Aota wrote:
> On Tue, Nov 24, 2020 at 07:36:18PM +0800, Anand Jain wrote:
>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>> This commit implements a zoned chunk/dev_extent allocator. The zoned
>>> allocator aligns the device extents to zone boundaries, so that a zone
>>> reset affects only the device extent and does not change the state of
>>> blocks in the neighbor device extents.
>>>
>>> Also, it checks that a region allocation is not overlapping any of the
>>> super block zones, and ensures the region is empty.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>
>> Looks good.
>>
>> Chunks and stripes are aligned to the zone_size. I guess zone_size won't
>> change after the block device has been formatted with it? For testing,
>> what if the device image is dumped onto another zoned device with a
>> different zone_size?
> 
> Zone size is a drive characteristic, so it never change on the same device.
> 
> Dump/restore on another device with a different zone_size should be banned,
> because we cannot ensure device extents are aligned to zone boundaries.

Fair enough. Do we have any checks to fail such mount? Sorry if I have 
missed it somewhere in the patch?
Thanks.
