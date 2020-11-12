Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97C2B0237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 10:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKLJqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 04:46:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47454 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLJqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:46:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC9UBgu048173;
        Thu, 12 Nov 2020 09:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O+ykYzp0ZE9cVThHzRPU9L4M92wvga6cLzUpbqdXUfk=;
 b=r6D3EWPtZvSF5V4eKlaYsNjuaPzyQwfiXCWDPU76+/VcMNrPXcci4KHO15Jdjnrn9egW
 ug3Xw3HktkZD84/nGy3d3/+r69a10OyO73NTxUQrySP1G3LCW1sVUaeq2vrb7Idia4HZ
 F0+Hl9+QcHgVZ69i5+xrzNKD7nUcxlnOeEuJhzN1bB33caodmLqEjJjrqkmqm16EFemw
 /h7bqBvs6TNNeFmgApQpAo8UUmWTpwYjruH3h62BitjK7GJlrxSi2N7YcSAHOM77YAq0
 CFvLGXjX1dL4F0uDm5kHClQx5WbdbkE8nNF3T0PrGOUavE8ClKOONsHHvZFpC/K69ikq CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3b4kyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:46:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC9VYTi004181;
        Thu, 12 Nov 2020 09:44:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55qytx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 09:44:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AC9iIZ6029413;
        Thu, 12 Nov 2020 09:44:18 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 01:44:18 -0800
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
 <SN4PR0401MB35981D84D03C4D54A3EF627F9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514AAB6133006372B04711DE7E70@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4a796bcd-ebac-eff2-6085-346a102b5952@oracle.com>
Date:   Thu, 12 Nov 2020 17:44:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB6514AAB6133006372B04711DE7E70@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120058
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/11/20 3:44 pm, Damien Le Moal wrote:
> On 2020/11/12 16:35, Johannes Thumshirn wrote:
>> On 12/11/2020 08:00, Anand Jain wrote:
>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>> index 8840a4fa81eb..ed55014fd1bd 100644
>>>> --- a/fs/btrfs/super.c
>>>> +++ b/fs/btrfs/super.c
>>>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>>>>    #endif
>>>>    #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>>    			", ref-verify=on"
>>>> +#endif
>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>> +			", zoned=yes"
>>>> +#else
>>>> +			", zoned=no"
>>>>    #endif
>>> IMO, we don't need this, as most of the generic kernel will be compiled
>>> with the CONFIG_BLK_DEV_ZONED defined.
>>> For review purpose we may want to know if the mounted device
>>> is a zoned device. So log of zone device and its type may be useful
>>> when we have verified the zoned devices in the open_ctree().
>>>
>>
>> David explicitly asked for this in [1] so we included it.
>>
>> [1] https://lore.kernel.org/linux-btrfs/20201013155301.GE6756@twin.jikos.cz
>>
> 
> And as of now, not all generic kernels are compiled with CONFIG_BLK_DEV_ZONED.
> E.g. RHEL and CentOS. That may change in the future, but it should not be
> assumed that CONFIG_BLK_DEV_ZONED is always enabled.
> 

Ok. My comment was from the long term perspective. I am fine if you want 
to keep it.
