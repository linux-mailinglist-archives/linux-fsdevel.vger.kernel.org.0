Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3DE48DA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 16:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiAMPGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 10:06:52 -0500
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:25697
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230242AbiAMPGw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:06:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3vtrkL/obEzND/O+ocns/0InEPql8ExWESyIZbEyA59eiOvdBVMXNtY0pdbIM9DncRYjWmfrY5Etu4SNWO5mXM93j3fraHpHq9U/w8JfJeYFaHW0P9Sjaw49IdVNsEiFSeWsS0CQojxThBtmeoxplMD88az5j2fGrK4kAxPuojSG6KW1TZ3MYBFkRmmr/CGKWe0CGd5ROuHPM4tbyWy/9CqWOZXCFpBZR7LC5eej4WNxUusP+a1Z4x3gZZAUugATmVCsoAtJ9UCPlk5vlfNmrqaeswODVv4VmLxu+LcIh+B7sDirZfVqsreHPQ2iSTb4IlrfNK+cgiHQr6u7F9I0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRcsbazB7c0cvQcJjuSeQhsNr+lHP6vAYcszEnY7zRY=;
 b=NunLElLeKx7XSoH6LWtRTCpkIFMLIYOFScd6X9Bzaq1Oi2Isv2lAucpwyxp71ywh2xwGX1G5hTxCpbc1QdrxIZ/O6QAscUcsPDrTmmGdVZaTHZp/CK0kyMOfAEOJyCT7N+Jet1A8Cv2AQMSOTQ7nvXlsUZ15owM8tHt05QDpLIoi6ExhdSZt8j+34hSXMEnF6xHznIZ+kbJphKdwtW2rTgvcpqu76NGcAj73IUWjHIOOcusb9KARhDVoz7td/s3POeYa+CG3MiW5srM+9RSc56/5sUnK7XQd69tLweI/X6rljdatQ5aHQd/uJ13N1SvtCaMUfq/+hn+XRJcEbBZuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRcsbazB7c0cvQcJjuSeQhsNr+lHP6vAYcszEnY7zRY=;
 b=EIQBkS8pOc2ElXfEp1W6Jwz/8lrxVA6zetWpp0dM18+l/pfVYwi7ahZ1WQpElWU53weZ+EFyESYXV+V9VaGLKDIFWyhNXxz+06FduS6ZBmoS2BFoBkMq7ZZT2NkORNRnbChG7iVmLkozy7tEAqfkSr7wikLCDd8kknyEj3r3QUkN9V4hSNbUY3K0NTqEW3zR8thodx4G501UxyOBGDX2WCR0ZwiQhNYp5cmths8IBuVuiAyumdRdG+t2dsNWcJ5cfLZG0RPW7zyqdQALI7f85LOrQIzbYYQat3kjy/5INZMFFbCVlVYGC0msHBiFelP+T84WwDZN8twQ9skJihCvdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Thu, 13 Jan 2022 15:06:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 15:06:50 +0000
Subject: Re: [PATCH v3 12/13] ext4: switch to the new mount api
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-13-lczerner@redhat.com>
 <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
 <20220113120807.xlyg4wmbbhajuftu@work>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0535c04a-db7c-fa10-149e-91110eb18804@nvidia.com>
Date:   Thu, 13 Jan 2022 15:06:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220113120807.xlyg4wmbbhajuftu@work>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0040.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0258fc99-0ff5-4d87-4027-08d9d6a653b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4878:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB487839393BD8562FF80BFB10D9539@DM6PR12MB4878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASJ8bomRuABj0DHkxVu7H9r17WPHCr/kRVzORp4DL2Wh6T62SuPQkTDQhwOnU/82Lr5hSSoBGN1Fg1I0x7cgalLN6WgQ1Jm9B1UlO/vTPzS4vZtDvVXGFN1J3/UQ5Z0KoyET03zrNsRa+EAP70DAtfbD1nfoIfjqDIwkiOv8BgAmzBAoUU6sotoHcebLZb4MtRBkQQFHnobwe8n1ojTPuK4LtuW6gcFoFvZEcR5k53bgo8IDyKXnfhiAC5lL+Lmj/DgiKnOiT/J4kC4cebSO0AihX4O+rjDm1ga6h5JY1zmUHYgztNgjpcRzTtK3AI2M4dycyWxAydC3MLsamwOzfUjwhX+tsc6SO3CdTvsopQURjAQkNCxF0PqcH7oNQqyfTRdVwDPrDX3XwOudQ4E25nmZu/SbR+tKyNeeHjnlsZy5bt7fltvefB6kP/0nuGeGB/h2Z4Uz5zkXX575kmquEnONYFMLE7qjVA8YFxWN3dcKlJg1rWkRtpJ7gJWgu3gMMf8qDCm4pZEao8IRHYSZTaXWyL91R/G0lNkmpc1qkZDWmWIzqjPm7kPAfepHxOe3JtcA3+X/mKoyasaR/O9ZPRRUxApN7zVRVaRj5aht8X/gJOG8a2/hv2YAeT9bfEONA+wYWXa6Q2OQs2qRplZl7Umh44zMe66JI9BlJ5kV5aKsDtvWgpCP43hyTEEGSpgv9NVnIOnT6xQMNYgGbK8jndNv65Fwd9KraqMP82/U6BHW+JgBDNsG+JAXUjAyqjrG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(31686004)(4326008)(6916009)(186003)(5660300002)(55236004)(8936002)(31696002)(508600001)(83380400001)(6506007)(8676002)(6512007)(6486002)(66556008)(66946007)(38100700002)(2906002)(316002)(2616005)(26005)(86362001)(66476007)(6666004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRFNEJsc1VROCtyaEVyRzVoYklxSTdBUlltTlUwSzZUTjc1NDNCUHVuME1G?=
 =?utf-8?B?aUgxYXRqaEJDYlNQWG9NZFRoZEZYSXNOZ2loVnRXNjdhODBPS0p4ZXVZSXpU?=
 =?utf-8?B?RTMvbTlXQVZiU0ZwUktxYW1yNHgxVHZFL2MzeThGZkJEbUxjSm9vL0xNS0hL?=
 =?utf-8?B?bHBjV1NNeURxWmtpd24vZGFpVmhVWUg0M3hWVWhkOStQeXRmVFU2cWdyNXov?=
 =?utf-8?B?OENETFZ2LzhwZWZGTWExeXFPYTZadURNQ0xFVmtEbWM2clBUYTc4bS9ERXZk?=
 =?utf-8?B?bUFHWVk1NVNodHFwUEZ0R2I1Zkp5K0p3TXQxWmcxT2JGQ0szZDMxaFVYVmw0?=
 =?utf-8?B?S3lHaXIrS3dmb3VIT1pKdUpKZFlRVFhvV2FxRlJzdFl3TUxBZEkvS3NMdE5k?=
 =?utf-8?B?VjJUekFjOEs0a0k0ZmFtWG1wZDN5bnFEWmk3R1c5MW5PREoydm9RcDdYc2hR?=
 =?utf-8?B?aVZPZU5KY0hXMkd0UGZmTWZLakc1VnJiaEdDYmM4MCtGVTVZeUpnY0JNemVk?=
 =?utf-8?B?endOeVJIbk5xeVE2RnZmOUlURHJBQW1yajBISkF3VkF0aWhxWGxYV29sMGhv?=
 =?utf-8?B?ZkI1ZEpkY0o1eGZ6Z3hXemdaTmMxT3lzbUJVZ0p5b1g3cVdZTXhKNEhFTXEr?=
 =?utf-8?B?QmJDSTFySVJQTllDVkwxQi9vb3JFNTByZWIwejVZckZvbXBTR2JGN3JYdWdI?=
 =?utf-8?B?QWdzSXJsM0pua1pkVmkzOVgzdFZEczBuMFBGN1NnMlc2OUFoM2g2Um5uQ3ZQ?=
 =?utf-8?B?aUhzbUYxcG1LbWRvV2E0TDM3eDU1Yy9YRm9kU0hUOXBTOEcrRm82Si9EenNV?=
 =?utf-8?B?Rkd3eTN2M2FaNEZDcXJjUHFZc1pERHBVM0VSY2hTWWIzeWF3OEZpL2gxSTZO?=
 =?utf-8?B?OXNPUVRQNzhUaUZTWGVhZEhCQWRPc0JGUnlSNG9McitNQjdCTERuNEF2QkEr?=
 =?utf-8?B?ZWV2TEVxVDQ2NEFVTHkydUplc0pPaVo0TnRZMXo4ZVd2eFZxZXZWSXRwVUR2?=
 =?utf-8?B?blR2cTgvSk9PajczQ3d6TERJQXNoZnAyd1BtcTRHR1NUWStoSThDM3JFdnRp?=
 =?utf-8?B?VG5qVWkyU2hPNWZVRGdmUGlOb0JET1kxUVhmTytIOGtWajZUU3cxUHlJY3pn?=
 =?utf-8?B?eHpLa20rdFZHbHZMa1dtM0xMTy9PTXIzV1JsTWZkZWtDNEdqWUdDMGRsdlR6?=
 =?utf-8?B?OVcveEtnZHVDc2Ztb1NlUmkxUDczQ3lOeFhITGVvOEFrdUd0ZWNxLy85ajd5?=
 =?utf-8?B?MzROaFNKT2RmZ2hkU2RuZSs2R2R1YXFkbkNKRUhVT2RLLzRlRmJTVWppN2FQ?=
 =?utf-8?B?SHFZSjAyUlZ6V0duVmF4Wi9VZ2FhQ04rNE1QQmxZNmlyN0VLUVJ3QkN2RE9R?=
 =?utf-8?B?WVR2cEZwS01rVTZVQXoxNHY5L2FpSkRnTm5kQ1NzRmIweGpFN2ptaHBSZDBD?=
 =?utf-8?B?NU1wQmppM2t4Znp5ZkRUVWU4bldLY2lPUDE5ejRYNFpUTGZIT0g3dW90NGVI?=
 =?utf-8?B?RzlCY2dZRWJ6Vk53Wlg5SGIvMTBrY2RsOGJJQi9EVXZQbGNIQnlJbFcrRndL?=
 =?utf-8?B?bU5RWHZ5aVNGVENmWUpaeExiOVpUNVF5bTA1UHpjUE8xOXZxRFFkREF1U2Q4?=
 =?utf-8?B?WUJtQTRqU2Z5TkRNa1B1SU02bE1GUExocHdlbFNrNEFaNUNXcXVDbkhUMExS?=
 =?utf-8?B?S2kxOCtrdzZlSmp1OGhORnVkR1hnWmpMQ3dRcGhqTWtNM2taY0pUV0krRVNK?=
 =?utf-8?B?bzBiSk5EY3JGT1NrcWRyTVlXZTNySm8vNmZqWXRMcWp1WCsxN0VkbzdENm9n?=
 =?utf-8?B?ZmJ6Z20rbjdRQ3VNcmFBZlpVRFl3VEg1c3Rzbm9XRk53UVU0VDFoOGljNUVU?=
 =?utf-8?B?WUd4YmpTTmVBTmRXYXRHSlFhNDQ0MUlldFFvSDZZTUZhdXBNOU5hOGpkVkxI?=
 =?utf-8?B?V2Vha3A3MVliZzl0YnZDUUZsYTlWUjYwd3hRZ1NEVVltMTQyWVZaTUJwa1Rh?=
 =?utf-8?B?bGlYQ3UySTlvWURKZkMyWWpodTJ0ZnBQbnE4Uit2VE9ZS2lNYzE5a3YzbGpy?=
 =?utf-8?B?R2hhSjVjMXBZamx3WWJBWUdKN0NCRGdENlcyS0YwdHlkL01abFIrNHMyTDY1?=
 =?utf-8?B?cmpTbHM5TUhQWmNwMXBYWm1BZnc2UG1KaDZNOFVWNjMrR0ZGNThJckJrdXJH?=
 =?utf-8?Q?DN6pRGqejXv2iyu9Xjw2/Mg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0258fc99-0ff5-4d87-4027-08d9d6a653b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:06:50.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTniARrpazGpcXPHhOt9fteLhM0wAbsn/ZIU6oVJF4djPqah4/1K8ShP4lpMX5Y/OhF7DF1ePVsxtxtlXcCNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/01/2022 12:08, Lukas Czerner wrote:
> On Thu, Jan 13, 2022 at 11:29:24AM +0000, Jon Hunter wrote:
>> Hi Lukas,
>>
>> On 21/10/2021 12:45, Lukas Czerner wrote:
>>> Add the necessary functions for the fs_context_operations. Convert and
>>> rename ext4_remount() and ext4_fill_super() to ext4_get_tree() and
>>> ext4_reconfigure() respectively and switch the ext4 to use the new api.
>>>
>>> One user facing change is the fact that we no longer have access to the
>>> entire string of mount options provided by mount(2) since the mount api
>>> does not store it anywhere. As a result we can't print the options to
>>> the log as we did in the past after the successful mount.
>>>
>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>>
>>
>> I have noticed the following error on -next on various ARM64 platforms that
>> we have ...
>>
>>   ERR KERN /dev/mmcblk1: Can't open blockdev
>>
>> I have bisected this, to see where this was introduced and bisect is
>> pointing to this commit. I have not looked any further so far, but wanted to
>> see if you had any ideas/suggestions?
> 
> Hi,
> 
> this error does not come from the ext4, but probably rather from vfs. More
> specifically from get_tree_bdev()
> 
>          bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type);
>          if (IS_ERR(bdev)) {
>                  errorf(fc, "%s: Can't open blockdev", fc->source);
>                  return PTR_ERR(bdev);
>          }

Yes, obviously this warning has been there for a while but only seen 
after this change was made.

> I have no idea why this fails in your case. Do you know what kind of
> error it fails with? Any oher error or warning messages preceding the one you
> point out in the logs?

No only this one.

> I assume that this happens on mount and the device that you're trying to
> mount contains ext4 file system? Ext4 is not the only file system
> utilizing the new mount api, can you try the same with xfs on the device?

This is happening on a board in the test farm and so not easy to 
reformat. Looking some more /dev/mmcblk1 is not a valid device, I only 
see /dev/mmcblk0 from the bootlogs on this board. Hmmm, OK I will have 
to take a closer look to see where this is coming from.

> Does this happen only on some specific devices? I see that the error
> is mentioning /dev/mmcblk1. Is it the case that it only affects MMC ?
> Does this happen when you try to mount a different type of block device
> with ext4 on it?

So far I have only seen this with the MMC, but I have not tried others.
> Any specific mount options you're using? Is it rw mount? If so, any
> chance the device is read only?

Interestingly we are booting with NFS and so not mounting any MMC by 
default.

> Do you have any way of reliably reproducing this?

I see it on every boot and this is causing a warning test to fail. This 
is a new failure and I have not seen this before. I don't see it on the 
mainline with the same hardware, only on -next.

Cheers
Jon

-- 
nvpublic
