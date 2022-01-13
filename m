Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5A48DB69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiAMQKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 11:10:39 -0500
Received: from mail-mw2nam08on2054.outbound.protection.outlook.com ([40.107.101.54]:46177
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbiAMQKj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:10:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxR2nBPtDzmw7B1KOmbf5H4iZRzuIA3SDTkJSbNpLMju9D3k4hOfgnDdSnHeMTryt3+ZrroygLKyCTE1pC5zhJef4812eUzrTEMlfx5HzGdu/H37CZsPV8VIOkydcQfK9nL47zefi/PxA8uzeWgyjJ/h6OwVrBe+Bu2qSnYkd4i4CpJBx6nGoaUpLugZDdKPE2LW9qaE8ASOiD5h5MDeILXFJzYwzARGWkQISwjJ2LbLGeaAczaaSYOUyAMnnBrEKTWJ6syiQzhdYWKfri9qroBhs+trh+0A+mbfR6/X9Sm1t919/GMGVGXpBf2jQ84V9WtwsYCK9jc8ydgchfcAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/6d49dadxESDjBjlAJvT+Y8+zuqn0Ttz21PvswQ9Es=;
 b=bXYRD2IfdK/1OrGStxYdHtIXPOKDq/BKRBdEl5/IfJKLUhIFUmxHgittB3EWLAQhIdu1nwmNZK6FU1SE1hfpMXjUCurRrewyHCirrN3x8u9El2y8k72xDPMOCAHzVLqVFt0+PKlbNx71p31U6ge3XQMv9ymHHwjKzEcUFAxPwtLY1Ql0KYCUA99htidrRHgqR9Ex764Xb8LOcgd2ITdELKIwPYf644cLipbNIfGDZvqd81DMdarippOkTK1mMgp/0RIKmY4PEcIGUNk3LDA+U59xoBG0XemHJmIm6MK5JHwiAsbaOaR75uMDdfQ7UlDGUEYHgAwdzLUPmtPk7o53Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/6d49dadxESDjBjlAJvT+Y8+zuqn0Ttz21PvswQ9Es=;
 b=IcOzGQ/r3VvNXWDFKnHqKncEOT9ObVVwUCBXWFTVhfF0Jg6ZNcwbHlExS+IvhZXSLO8aZZ7FQ3JOw1zGDROt99IVFaw0dmhqD3MDD7rdzk2aRgnwsipfPpHd4DkFTY4XBJC+nPzWBkKQj3MH5RGLhJTZeRo4XM2DHXBcpdW2psEQUd7UKkJT/27OzbMcqmOteEDmkYNYkjlJCnY5HjxK3I1zS8PcqFGbsw5WDSgFsOQxSJhn5N0NdzzgEKg/qBNZ42WYjTDeY3eUnwV/xKDMt/2Fzqxq9Q0zetYc2vMaiQ1wmWdpd+na8OStzUD2l/aPNHjrRFk2Y2h4rhk7bxW8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 13 Jan 2022 16:10:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 16:10:37 +0000
Subject: Re: [PATCH v3 12/13] ext4: switch to the new mount api
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-13-lczerner@redhat.com>
 <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
 <20220113120807.xlyg4wmbbhajuftu@work>
 <0535c04a-db7c-fa10-149e-91110eb18804@nvidia.com>
Message-ID: <afa501e4-802d-e8a2-4272-4b67572c6d14@nvidia.com>
Date:   Thu, 13 Jan 2022 16:10:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <0535c04a-db7c-fa10-149e-91110eb18804@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:206:1::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a0e9902-395b-4c9e-795c-08d9d6af3c7d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1253:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB125345CB1B06592DBEECE8F9D9539@CY4PR12MB1253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hk0UGQHMZZOfkXt3sZW4Dy+5Nk8L40Htxv0bgfZWbIWMAqb4OgeCK7Bx3rHBJo9k3jlAtw8MPVp3aWlNNHdRNr1vwTGcUK4c4l/Qs6hiHi/UE51HAaTZENYQBjHjB4XeF1R4MZq34PHSOSCqHWRHZQ24QDA47rQET4Yy9xxuu6SKewnJJf2ocuGXxnBqhvkSmvYP2Ng1f5zCbyIn8fJ4vbTIU7WgWyTAdtnzg7lskjEuOHhBgKT2//cewcgcnZcjv1ZncPVXQ0CbeHzSWCDm9GZHCituvb0VkVl6Zv1PDsm5JLfkKVykfpxhFKG+PzGeVxqH6XeaP8wDinCaANOdTgw9RQ27bAvHLOiD2yRhospKAOebVo6cE+JK0Mu3g+A2kd0gBLunSsklIp+1rZRP12O579ttUAMKpk/vPtkM0YbEAjb4I0Ntb1n23ng4GeW9dmzYbhlM5m5D8d2OJec7yOhVl83S42DP4VbPZ2SMX0HGcQpoeDDVQTTar+Thspnriq+VXIJ1aGtaqw5qC4yPI3tnyrdlVVTyxc1morZBVaVFXCRuApTe4ZxwmaaaZRoPAT60xzdvWFHBQexsN9Wfp9rgYPnH7mRJCSZGsBqwoZolaptah7mG17YBO98atR3k1Bxw18pbIT2M1LumdqNcv2x3gBILYnokKas6IgAUdDbaX3RZ8Ba/LwV3MMe0iNvEQm2X+3qGumKV8ha1H3tf2zRIznU5vdOHnaU2DgMRqHEa4svDRPI15kvmOI7nYCDo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(38100700002)(4326008)(316002)(83380400001)(31686004)(6506007)(6666004)(508600001)(186003)(6916009)(86362001)(66946007)(66476007)(66556008)(26005)(31696002)(36756003)(2616005)(8676002)(6512007)(53546011)(5660300002)(8936002)(55236004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRDTkxPaUMyQ092czUyQ0JSbDFCQ2Y0YTc5TFptVGd2aVYwWHk1ejNIdDhB?=
 =?utf-8?B?WDRpRWx0TEN6VzV0S3FHTURzODZROWpNVWdOLzZrR1RmZnRZRVU3RTBoQk9V?=
 =?utf-8?B?SFFjMHVOb2tZTWNQb3Joa3EwWS9EYUgydlhtSmlvL1pjVGlwWTJwK2Rhb2RL?=
 =?utf-8?B?M05qaE9vNytHOXJXaE1YZHU0Z3dOOXBjUWtISEtsck0yZ2wzSUpxOXFwTW91?=
 =?utf-8?B?OFdFNXM1cmp4ak9vNTFPYzlKbDdrTUtBaXNrSE8yZm5yMU1FVU5CeExIMnFo?=
 =?utf-8?B?QW9TRHllVjFBb01mZlVsODBFck5mUloxRWJGS3FDYktHblhsajFROTNOSWUy?=
 =?utf-8?B?UXBpMmx4S2l0OHd0OGVDNFBHRExxT2d5VXJxQ0Z5RmwxSVIzUGEydXZDU0Nh?=
 =?utf-8?B?VFRmQzhHb1ExTENoYXM0Z0FnUy9SekM5eTNueDFWRWovUmNNRkRFOXkzbXl6?=
 =?utf-8?B?aHNJeTcyUGJ1Qy9JVlZFNmY5QWVPNENqSXN1TSszZm5tUTlPUXVOTDhnZVlG?=
 =?utf-8?B?YkkwZDVkR255ODRaTlByeldQYVU3ZFhFUHdQWkVNNEhrTUlhS1NmeXg5TG1h?=
 =?utf-8?B?WE1aMTBuVjZIWTZGL0NwcW02ZFVGNU9KUFgyYVpsbU1ybEhMZStRMzFQM1hD?=
 =?utf-8?B?M1g3RURUY29vZ1FyUHRhSmVrREp2MTB2aXc2ZkU5NlBtS0VYY1NNTVB3UVdl?=
 =?utf-8?B?V2k0N3g2Mkd1VXJzbjJlblVIdDVBN3Y0UlgyYStidTA3TjNkN3BjQUlHYVBD?=
 =?utf-8?B?eTEvM25iSFBURHQ4L3daUmZsc0ZULzArMDhJS29vV2xUU2R1RHNyY3JVbGVr?=
 =?utf-8?B?Q09IM1FUcjlocnJES2tWeGZVZFgvRk1oc2FsZWpLNGFQeFpCOXVpOEVrOUZO?=
 =?utf-8?B?azJrZFhFY3RtVTdubHloaFRaTS9vRi9WM3h6Rms2YSs2S3FocnFWWFFvck9I?=
 =?utf-8?B?SnVhTk4ramprVEczRDNGTGNGZXdSUUhFMW1pamIzUHJSOHQ5eWxrMVhjd29Q?=
 =?utf-8?B?SHVnOFA2RGVBdnRvSitVOHVGWGx2S2tOZDhXSWF1WVBqTkJtcFduUHBZbzJD?=
 =?utf-8?B?aFo4NlZ5dW5DQ0dMeUh2KzdBNWladHFta0dPcWhYOFlNbGZPeW5SUk5LV25I?=
 =?utf-8?B?Z2lGbUtoL3lZMTdCTm82bVVoSWRsb3Q4a0tXeEd3bHNsZFhBWVM2WFFEZ09t?=
 =?utf-8?B?bDhUeEZ0SitnSEc2eGNQcVNBNjhCWFdtK2Z1WmVSWkJPcjVrT0NTd3RaZ2d1?=
 =?utf-8?B?dVVvNk8vdEVQRGI0cVRzMC9abnhkQWZVcEU3ZHovcFFlN2xPY1U4MU02ckQr?=
 =?utf-8?B?NHFQb2RMQS9kb3hRZldYU1J1ZURmS3ZIRis0LzRqM1NOMXAxZnA0Y1JLQ2NO?=
 =?utf-8?B?amt1RXdoL0RRNkd4NVBkcm10WUtUZFIycUpjOGFBTTMvM0pIOGFsN0grcHhl?=
 =?utf-8?B?cXB5azZTVlYydE1URmlBc0hycmg5TDQzMHArWEpYUW1jTDVjTUJEMEhnLzRv?=
 =?utf-8?B?bklhS0hCQ00yODVxMit1aVRvUWZoNkpHWXV2bGppcFJhN1doS0t1VktlMzFW?=
 =?utf-8?B?R0JnWDhkallvYXVGSFZnL3NjNUlLRTZZSDNqcUJlMUI4TGhHdWFPU0dFVnRq?=
 =?utf-8?B?Yi9NUFBkUTJadjRrN3o4QnQ1bUlrMCswUkNJUk53L3diMzA0UHcxL3QrNHdF?=
 =?utf-8?B?WnIxOHFqVXIvQ1hld3NJV25zNEVTNlJWb2pZQ2lyY2x0UkdBTFdNdkFFT2Nq?=
 =?utf-8?B?aS96ejBTSkIvMEJhcHBWWjZJNHFaaE9uczNzaDB1aUJzTDdCTjBwYkFod3Rr?=
 =?utf-8?B?RTdQWWhwK3p5eFRlT041R1oyUWJEZnU1RllwYzUzeUFQazNnOGJMUTNENkx0?=
 =?utf-8?B?WUhXNlVFZk5nMGdUWUl6SHNxR0hUUitvVkVLYVdJaG5lOEl0clJYUmJWWkZG?=
 =?utf-8?B?RWtnRzFDaFBmZmdTNWErZVo3MUxnS3dQWDhpRERJcm14dWhhSk5udkNpL2Va?=
 =?utf-8?B?VXJJRzBKTFJvZjVLRXB1TGtvYzJEQ0UxcldEbVA2bTAvQnBVUGVsS1YxbGNS?=
 =?utf-8?B?VmZoQ2habjVPQ1N6Z3lUWTd5Q2hZT2dWOE5rUnhyTm41S082bW9BOHMwazFL?=
 =?utf-8?B?ZFliY0g2Z1RpY2pBYmp5RkRBVFV5R3dvdkdXNzFIc01LYk1Ed2NFUHpSeGlZ?=
 =?utf-8?Q?iTKChnF00gdZuhpGSx3I81w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0e9902-395b-4c9e-795c-08d9d6af3c7d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:10:37.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZeK8TxNGXXR73SX56mO24OtIe0M6p0A/M4k4N78EBeCl/91bSdOeR/8LThNQSNnaTSqasqz6jbWS0lVlBxiQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/01/2022 15:06, Jon Hunter wrote:
> 
> On 13/01/2022 12:08, Lukas Czerner wrote:
>> On Thu, Jan 13, 2022 at 11:29:24AM +0000, Jon Hunter wrote:
>>> Hi Lukas,
>>>
>>> On 21/10/2021 12:45, Lukas Czerner wrote:
>>>> Add the necessary functions for the fs_context_operations. Convert and
>>>> rename ext4_remount() and ext4_fill_super() to ext4_get_tree() and
>>>> ext4_reconfigure() respectively and switch the ext4 to use the new api.
>>>>
>>>> One user facing change is the fact that we no longer have access to the
>>>> entire string of mount options provided by mount(2) since the mount api
>>>> does not store it anywhere. As a result we can't print the options to
>>>> the log as we did in the past after the successful mount.
>>>>
>>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>>>
>>>
>>> I have noticed the following error on -next on various ARM64 
>>> platforms that
>>> we have ...
>>>
>>>   ERR KERN /dev/mmcblk1: Can't open blockdev
>>>
>>> I have bisected this, to see where this was introduced and bisect is
>>> pointing to this commit. I have not looked any further so far, but 
>>> wanted to
>>> see if you had any ideas/suggestions?
>>
>> Hi,
>>
>> this error does not come from the ext4, but probably rather from vfs. 
>> More
>> specifically from get_tree_bdev()
>>
>>          bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type);
>>          if (IS_ERR(bdev)) {
>>                  errorf(fc, "%s: Can't open blockdev", fc->source);
>>                  return PTR_ERR(bdev);
>>          }
> 
> Yes, obviously this warning has been there for a while but only seen 
> after this change was made.
> 
>> I have no idea why this fails in your case. Do you know what kind of
>> error it fails with? Any oher error or warning messages preceding the 
>> one you
>> point out in the logs?
> 
> No only this one.
> 
>> I assume that this happens on mount and the device that you're trying to
>> mount contains ext4 file system? Ext4 is not the only file system
>> utilizing the new mount api, can you try the same with xfs on the device?
> 
> This is happening on a board in the test farm and so not easy to 
> reformat. Looking some more /dev/mmcblk1 is not a valid device, I only 
> see /dev/mmcblk0 from the bootlogs on this board. Hmmm, OK I will have 
> to take a closer look to see where this is coming from.


OK, I see what is happening. It appears that our test harness always 
tries to mount a device called /dev/mmcblk1. Prior to this change there 
was not kernel error generated and looking at the logs I would see ...

mount: /mnt: special device /dev/mmcblk1 does not exist.

Following this change, now a kernel warning is generated and I see ...

[  137.078994] /dev/mmcblk1: Can't open blockdev
mount: /mnt: special device /dev/mmcblk1 does not exist.

So there is a change in behaviour but at the same time the error looks 
correct. So sorry for the false-positive.

Cheers
Jon



-- 
nvpublic
