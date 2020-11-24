Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9163B2C1E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgKXGs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:48:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXGs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:48:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO6YUdL072498;
        Tue, 24 Nov 2020 06:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NgLwLhDoHtKt48FPe5ehFzKg373bxotg3X+/Q5tBLnY=;
 b=AA/XK03JNFsgTtsMiRQvOaKtrJsxXO6sXXKdyJT2yoR/GOSFRvPQTq28cftJLLd0qi+N
 pdKIcJZLHBWGJyc9EGAEa9qhSjnAx9ANqRBnVSqDJ0YkEWENJiPnkhmt8L4dq9eily4q
 KR+XsvaMlkqG6UABSLx0Bk3rzElkLIY1+m2w/WasmpMVb7UHW67AHteoOj9hE1FphUgY
 jZeojMHlNFL6MICF+AKAZEgnIG9JBpcN1IbRsdaq+JUC1CidwHAtYVgykkmbYbjoG7WA
 drqZdb1mKVMldj9SDxqutHHQYRm3zxuwNGFH2nC3xq4dtDu1m6igiegb63STm9HK4kNt gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34xtum0udw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 06:48:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO6Zp91109720;
        Tue, 24 Nov 2020 06:46:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ycns2ae8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 06:46:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AO6kbur003203;
        Tue, 24 Nov 2020 06:46:38 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 22:46:37 -0800
Subject: Re: [PATCH v10 11/41] btrfs: implement log-structured superblock for
 ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <5aa30b45e2e29018e19e47181586f3f436759b69.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <69855ff1-4737-3d4c-f191-f31f8307fe88@oracle.com>
Date:   Tue, 24 Nov 2020 14:46:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5aa30b45e2e29018e19e47181586f3f436759b69.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240038
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> Superblock (and its copies) is the only data structure in btrfs which has a
> fixed location on a device. Since we cannot overwrite in a sequential write
> required zone, we cannot place superblock in the zone. One easy solution is
> limiting superblock and copies to be placed only in conventional zones.
> However, this method has two downsides: one is reduced number of superblock
> copies. The location of the second copy of superblock is 256GB, which is in
> a sequential write required zone on typical devices in the market today.
> So, the number of superblock and copies is limited to be two.  Second
> downside is that we cannot support devices which have no conventional zones
> at all.
> 


> To solve these two problems, we employ superblock log writing. It uses two
> zones as a circular buffer to write updated superblocks. Once the first
> zone is filled up, start writing into the second buffer. Then, when the
> both zones are filled up and before start writing to the first zone again,
> it reset the first zone.
> 
> We can determine the position of the latest superblock by reading write
> pointer information from a device. One corner case is when the both zones
> are full. For this situation, we read out the last superblock of each
> zone, and compare them to determine which zone is older.
> 
> The following zones are reserved as the circular buffer on ZONED btrfs.
> 
> - The primary superblock: zones 0 and 1
> - The first copy: zones 16 and 17
> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>    to it

Superblock log approach needs a non-deterministic and inconsistent
number of blocks to be read to find copy #0. And, to use 4K bytes
we are reserving a lot more space. But I don't know any better way.
I am just checking with you...

At the time of mkfs, is it possible to format the block device to
add conventional zones as needed to support our sb LBAs?
  OR
For superblock zones why not reset the write pointer before the
transaction commit?

Thanks.


> If these reserved zones are conventional, superblock is written fixed at
> the start of the zone without logging.


> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>



