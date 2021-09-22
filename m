Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834AC414272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 09:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhIVHUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 03:20:17 -0400
Received: from mail-eopbgr1320077.outbound.protection.outlook.com ([40.107.132.77]:25440
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232946AbhIVHUN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WymYTTs2+nZZN/uX7sWswsENg8IuWxepu3JklsQ/vRcFWW9jGv0aRCL1fKojYobReUB2YfUJsQ0+c83DAyPdumEtgAcm+vSvzU3CHwt2LxQyeYLl6FOtuNgX+LEX5zjAkv3XCHGAk7f6L9Zwi9bzhKrX8XMwwHeRJq5J7SPHxzCYYpMvxrhIDdwhdygdVgqIhbOdmbsVa+KuTYz+dPaWLXnQl61ro6xQi5bPAW7xBQUfaDANL7zoPDuCJEKtX4pnz2M2AqzjafEOMwLcuDaTo5FqVTAlpRwiD7PPl3xVvN0/+DTiOWYJa0aIVm6zJy48P4UZ1gQQtb7As1Kps0HADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iVYlbrCS++cgx9Lwzyg7u3ctNhsDYDeMq4D7uhY+NEk=;
 b=nxdmtAsruhjRuJbu0TV7czdFggYS4gWCk0f0+06WZ/D9gMI83pZGA7itl6PR+D5LSbZRi/oeIq55rZHviPG1slF1f8BWV8wzkj3byLTNS6qtoqGm+5g3rvTJhHKr3tmhe49jm2kMjhuP8vP1JZgCNwCaS8/K53TprRlns2YcpAck7j+wGR19FsD9+hq16u/+/1v6CS/ud0d2pWqyZ+FTN0t5iCPI1Xas4iR3ra9x9DRFhZy2AfNQR1kN603WDdsJNnQnHFMQjsNEMpTf2+/JpmZuwyfQXmCGkXWAwgA5IeoGuGs7yUVGsmNtGtgNBCTnykcgHNVFxz8wTUb4l9Xg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVYlbrCS++cgx9Lwzyg7u3ctNhsDYDeMq4D7uhY+NEk=;
 b=inog1dBrtxp63Q7moVdWP6oBKN4WNFKUNymxna5/17L04OG2HApVGuCkicwhvk9K1RKIAhJMLL0IYJGpY91cT7QtKij/99abzvdjkABzdHKOg4RT6Ll2NZAtxUcjijttVGEebemrtmW/lFEbZsYfphvkrFjiLzrbRHl4+r5Plis=
Authentication-Results: mykernel.net; dkim=none (message not signed)
 header.d=none;mykernel.net; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3846.apcprd02.prod.outlook.com (2603:1096:4:2a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Wed, 22 Sep 2021 07:18:39 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:18:39 +0000
Subject: Re: [PATCH v2] ovl: fix null pointer when filesystem doesn't support
 direct IO
To:     Chengguang Xu <cgxu519@139.com>, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        chao@kernel.org
Cc:     guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgxu519@mykernel.net
References: <20210918121346.12084-1-huangjianan@oppo.com>
 <20210922034700.15666-1-huangjianan@oppo.com>
 <4ccc5c89-eb13-5e91-9283-c94f755a9c17@139.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
Date:   Wed, 22 Sep 2021 15:18:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4ccc5c89-eb13-5e91-9283-c94f755a9c17@139.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:203:b0::34) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by HK0PR03CA0118.apcprd03.prod.outlook.com (2603:1096:203:b0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:18:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99938e0-3f1e-4574-37ca-08d97d993328
X-MS-TrafficTypeDiagnostic: SG2PR02MB3846:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3846717A00C9D1592A747FCFC3A29@SG2PR02MB3846.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU7Maj5HnDOtckRJjyqqSWZb6J4c7TH+Gc/MvL+tN+7hJoN1fNSitJz4v5uILZEWh3PlAmLVKjAEJftfbKIPZJYFs5sAGa9XIht/zO+XT85LeGrYJ7ivUvFv/s9vqfpwo+RAXx++GSvWaOVpQh1QeE1ms8v6KzMYThcaf9sgB6otBx3q69EI1oQz19XeGDVdeMUn0bTLkq+0P91zPsmbU7Grp09O+r3DnBHqYslb+EwgNynttigLjZmsoPxDhH3U5lfp5eqLqyPqT0qkPQ1nrvXi6Xxx+QvhugS32n1HVn2VMDUMwMK5PNMPHLxAX4wNvdxz9qwctLommYK+9g9EyQ/EgBHtW/xLHGdLGn8no6xJ7OBuKMEkEDJTpVlK5/3ZkcqHAMwhM3cYFC3pWQeV7v3QhG7eZAlmRkZ3QGUH7FtSrUMD56htZwzcrVndjtAMJFNEb6NkHJoCExn4d3/nSBGLznOLJd3+KPtQhdt7/h7SapnRa0LF+cSPY1w/dDjF/dSDbRkCKAEQsUL7wcBEjC6nL/q0A3UPwd+agDjjDajkQ5n+zqNHQiCk6Sr8OziozmOWhADyIYmwdN2rY4ej5WKnB5wYBcoHymv3zXiekKjARS0A4ORhWg3LrK3Hhhb/G2lbBFKeLCdjG81PiD5V/0W2hZ+TkSixpth5iyvIHochcBWzYI/pNS9VxbT0CGYZulBU2s1FKw5wWcaSA0D4LAHqlRTWkL2wN4sQA65vqoi/hoWccYkbJtD+hOCFiz0/DVMHtnmYi/rslHa60V5kyBWDk0zYqdL08LfiSQUk34XVBhxewN6AuYMjRdcSutj5nMfwjiMmEWEwLqWuoDYjnf+2qq71apoa5HAjQaAIevM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(45080400002)(2906002)(66476007)(2616005)(83380400001)(31686004)(66556008)(52116002)(36756003)(508600001)(4326008)(26005)(7416002)(8676002)(38350700002)(16576012)(86362001)(966005)(31696002)(186003)(6486002)(5660300002)(8936002)(38100700002)(66946007)(316002)(11606007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1tMEh1NnFna01mSXVpK1NaeHFGcmhZYXY0bmo0M3VxQXpBWkZ4R09wSGNR?=
 =?utf-8?B?STZzWkx2WHp6WXhldFROZVNERTFWcGp0clJmamljYlhBcmUyMkUvdVdYL1Qy?=
 =?utf-8?B?NDVEdCs0UDJ3cGZ0UDRYcUM0SG9EdHVqT2Z6c296SjZuZGtQUXU3WldQNk10?=
 =?utf-8?B?amhEdVpheVFWY0RLZ0szYTNCN1dsQWFFSlFwQWtpdGJVZlRhQkRxaVNMQ2Mx?=
 =?utf-8?B?OC9wcHZhamRzUUJUZS9mdk5JY0Q0ckc0STVDMk1MZTBVK3M4L015QUwrKytZ?=
 =?utf-8?B?ZmlIZFV4T24xejdiYXh3Q3lFcGNROXVremtRR3d3alptdUV2aGJjOFZIWlhP?=
 =?utf-8?B?Vm1GTFlzYVcxUkVuL3JSVzBBcU1XQklQeVBCaTVab3U0MVNzcFhhZEIySWVH?=
 =?utf-8?B?U1FpV01zQjhuOTNzV0lscEV4MXhWSXBnQ1FRSHZPdVJOTzhpZCtjTCt5QmxY?=
 =?utf-8?B?Sy9HT2pmY1FaR2lUSUFmNHNDQnV4cWsvQ1N1SVl3VGZBRHBXMm9wWnB3MGFv?=
 =?utf-8?B?NGxrVTBRUm9mQ2RaR1NUMjMvRXpERi93SmIzZ21IMklrUWRyM0hZU1NJVUQ2?=
 =?utf-8?B?SCtPR2xaUTU2MkhqK0o2VFpSUzlpNXhkUTRiZkJtYlpyeWVBczlaVG01NmJa?=
 =?utf-8?B?NDVZTmVCTkNNSkFPNmNDZ3NtVjNqYzRmM21nZkZsVUhPMlhZTmtJQ09XbzNu?=
 =?utf-8?B?SHVMc25DdTZDMXdCLzZEbkNnRE9FTDZ5N0x1bDRVeTg5VGYrZEFQTnZxbDVu?=
 =?utf-8?B?Z1JZNVMwUWVVQ2dtREZJckJkNlBOalZqejF2alRFenI1ZEh0Z2lPVVB2NGJ1?=
 =?utf-8?B?bndxTmRXTGJtYTdsbTRBQ1RNY29SVXMvbkZKbnFqeWV2MmVQelkxRUhCOU1W?=
 =?utf-8?B?UFY3amhTcHBCYUVhS3VEUXJLYTBON05mTVFRNjYxS3N5Yk1jZm9IQlRJUktq?=
 =?utf-8?B?eE9lYUJlRHRiVVFLUmI5TXBlMXdGSzJZSFAzaURDTWJuS1FMT0MrdDA2SVpD?=
 =?utf-8?B?S210V0Y4NHp6c0grcTVRaHJibWQwK3VzYklsSkR6Z2IrbU9vWjlUNzhzSVBu?=
 =?utf-8?B?YVdrOGxPNFJvQUR3M3Q2Q3hoSnc1RTBreERERm90ZDhmbUI4MnRWeTJRT2JK?=
 =?utf-8?B?NVdLclJ1RENONzZCaG5xckxycjUwbEtLWTQ4dGp5TkVnSXpCbEF0Q3lMdndS?=
 =?utf-8?B?WEozQ1E5Rkl4L3RTVU85K0IrNDlBL2QzdkRtUVkzQXB6c2VWdUlBaHpLTTJo?=
 =?utf-8?B?MTBhZ1lNRVRkYjdpZlY3UnhxUmZpb2lWWGVLcklzZUo1OTYvY1IvNE4rdFBH?=
 =?utf-8?B?WXM0Mml5VHBwZUo1K2p1UGh0Mk5tbEl5aE9RWVZnN2IvQndkVGV2K3lFTHV3?=
 =?utf-8?B?Sml0Y1JCVVR5M2xOWnljRmx5TW5pcTVFRElMZStMejhOU1poMndVTXA1OHdV?=
 =?utf-8?B?MlZ3emw0cXBqSGEvdVlRVFdYcGJ4RmthMEZVQ2F6eTU1WTVER1dKbkFubVE1?=
 =?utf-8?B?bVc0YW15cjF0RHZSeG9oZTlUSU5rd2lTajdWTFFuUllUaFE0OWg0UUZqRXcx?=
 =?utf-8?B?UC9EWTdkWHJLL1hERTZBb1hnTnBDL1pKOXkzWTc0TW1hZGhncGF6djlMaGsr?=
 =?utf-8?B?Ynp4bStjc0xGOEg1SVNIRE5yK3l4alorSkU1SHlNYXlhajlFNDJYUDkwaFU2?=
 =?utf-8?B?MFhPZXZ0QlNUWTR5YStqWnJuWkU0ekpTeU1nQm83UU1IbnBMa2U2aHd0M1o1?=
 =?utf-8?Q?jGymkRi4EokxY8uuy4ulcLkOSrR8kUqxiq8Fcpl?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99938e0-3f1e-4574-37ca-08d97d993328
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:18:39.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2vHLZjKGkYRm5ezISDwvOCVTH+LM/wJfHoiuPGVucKRqbjtyguTUa1ph4NcSLhXtmSknoez7Zzwgg5c2iZVeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3846
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/9/22 13:09, Chengguang Xu 写道:
> 在 2021/9/22 11:47, Huang Jianan 写道:
>> At present, overlayfs provides overlayfs inode to users. Overlayfs
>> inode provides ovl_aops with noop_direct_IO to avoid open failure
>> with O_DIRECT. But some compressed filesystems, such as erofs and
>> squashfs, don't support direct_IO.
>>
>> Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
>> will read file through this way. This will cause overlayfs to access
>> a non-existent direct_IO function and cause panic due to null pointer:
>>
>> Kernel panic - not syncing: CFI failure (target: 0x0)
>> CPU: 6 PID: 247 Comm: loop0
>> Call Trace:
>>   panic+0x188/0x45c
>>   __cfi_slowpath+0x0/0x254
>>   __cfi_slowpath+0x200/0x254
>>   generic_file_read_iter+0x14c/0x150
>>   vfs_iocb_iter_read+0xac/0x164
>>   ovl_read_iter+0x13c/0x2fc
>>   lo_rw_aio+0x2bc/0x458
>>   loop_queue_work+0x4a4/0xbc0
>>   kthread_worker_fn+0xf8/0x1d0
>>   loop_kthread_worker_fn+0x24/0x38
>>   kthread+0x29c/0x310
>>   ret_from_fork+0x10/0x30
>>
>> The filesystem may only support direct_IO for some file types. For
>> example, erofs supports direct_IO for uncompressed files. So reset
>> f_mapping->a_ops to NULL when the file doesn't support direct_IO to
>> fix this problem.
>>
>> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from 
>> overlayfs over xfs")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>> Change since v1:
>>   - Return error to user rather than fall back to buffered io. 
>> (Chengguang Xu)
>>
>>   fs/overlayfs/file.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index d081faa55e83..38118d3b46f8 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct 
>> file *file)
>>       if (IS_ERR(realfile))
>>           return PTR_ERR(realfile);
>>   +    if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
>> +        !realfile->f_mapping->a_ops->direct_IO))
>> +        file->f_mapping->a_ops = NULL;
>
>
> There are many other functions in a_ops and also address_space struct 
> will be shared
>
> between files which belong to same inode. Although overlayfs currently 
> only defines
>
> ->direct_IO in a_ops, it will be extended in the future. (like 
> containerized sycnfs [1])
>
>
> It seems the simplest solution is directly return error to upper layer.
>

I think that after reset a_ops, do_dentry_open will check 
f_mapping->a_ops->direct_IO
and return error. But return error directly in ovl_open seems to be a 
better solution, and
won't affect future extend of ovl_aops. Thanks for pointing this out.

Thanks,
Jianan

>
> Thanks,
>
> Chengguang
>
>
> [1] 
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-unionfs%2Fmsg08569.html&amp;data=04%7C01%7Chuangjianan%40oppo.com%7Ce01c8bb9ad4e4ac2670008d97d87321c%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637678842352759179%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Wo2uMfbYhqDOzDPSwHci2AVtM9y9nNstmayb741gspQ%3D&amp;reserved=0
>
>
>
>> +
>>       file->private_data = realfile;
>>         return 0;
>

