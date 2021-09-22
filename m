Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22041401B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 05:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhIVDk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 23:40:57 -0400
Received: from mail-eopbgr1300041.outbound.protection.outlook.com ([40.107.130.41]:22854
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230054AbhIVDk4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:40:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjxwDFKvwoAtaPhPGiSGIO9cZuZ6IUYVsEeaB7l8AJyxfTvaT1Eh3EBTt3DEDcV+0iZxzT0I2w6wy6ESX2WkSxk3QPsFFTYtU9vsExDpCV66x9oT24IqQFWFFy6sUzpum5CwYx3Tc6GeR4zYlw2uw2vlaCBexKOViLKxOnMj1V8EL8oW0z9zOHdNvEU7oXYHhBM1Mu6Ddw8wv6oL+z1kzMaYy0yzj7LiSycHmbP6rbIaMOTWIetzmmtmKZ/uKH6yu5/ZqtctOIGEceMObeL8O4E0xmu6xc50NK2dIeqxDa9nGL8dFNqPnw6SQ49y523IQRM7PodShwcwnG36zp5HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s5vHlmaW1B856mrFUdH/qqRerCMy0YOyNrfY5CBSJEw=;
 b=YBLoKR3bs7qo1wIWvEJnebwS116KvGXnL7AQLGK2rGKqNHyg8qgX1VrXJUSH3cUJIEvCQKO+w9xYr8l1q3mnWNQMCjnWDSnDI9fXe4VD12LqElpUSMqTgczdPMg+jVexMwSPPlstXotsJQGca1UrFbU3B/X7XwngDT/6IVY0yVRdGNpQdXS1FNEIa+L8r/3Kv4n6dbZZlTO6LwPgL9+4ufPI3cymcIv7aSmf7vfz+4xBzRHQz0pst38QzXt7kMMF2sJSrj8PQnhxlN8WNbqjhOVASTpQGW1ofZs+I/TGq/W5PWmfNzAY2X7ONtGjJQIq7XV0EZqkOxgDQghmJvxJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5vHlmaW1B856mrFUdH/qqRerCMy0YOyNrfY5CBSJEw=;
 b=PXBVz+x2t7dx34+jhHWfx7a0lMEBbTfiQWjrlFQSQK1Q4J9h1wYrsSO10DG8/7U5oUGvhmXsUaedSjq9V5HKmS4E+JFXLT0mFJw/f/trIlz2HyAseLGFgZj0RiG2n+ylQRPqBXk23b5zxnyXws5nKJ1O073yLAZrFtRizw4rEzk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3113.apcprd02.prod.outlook.com (2603:1096:4:5a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Wed, 22 Sep 2021 03:39:21 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 03:39:21 +0000
Subject: Re: [PATCH] ovl: fix null pointer when filesystem doesn't support
 direct IO
To:     Chengguang Xu <cgxu519@139.com>, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        chao@kernel.org
Cc:     guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210918121346.12084-1-huangjianan@oppo.com>
 <3633c6e5-028c-fc77-3b8e-da9903f97ac5@139.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <76cfd82b-47c8-d5aa-e946-f9e53f78ad81@oppo.com>
Date:   Wed, 22 Sep 2021 11:39:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3633c6e5-028c-fc77-3b8e-da9903f97ac5@139.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by HK2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:202:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 03:39:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a642429e-f439-4ab4-53da-08d97d7a907f
X-MS-TrafficTypeDiagnostic: SG2PR02MB3113:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB31139CA82AAF807C4695C1ECC3A29@SG2PR02MB3113.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUc0FyJnIPG/09WXFht+G8IFVSaIQ4F8bMNmN7KBnS5n7GhcvQcd1ElhtaNfOue31Z8AsxNq4XSeM5OM7TG2OeQHwoUueRIf//6xa/LnjlK6TWwX8QLmQ1HHpBmFYVLKWRx1UhPc1gYrkAxGaHS7hScOjm9/MBh2mtWD8/nG5YnIm0iXj+ff0jL47Ji4ixCX0jM/mXlM4sJRMy1eueBVjOzKnc+ZJk6ORXM1rRRM7vvF3WrGAyQmKMD+tC3RtrDLPptizAVHFOC0hc3T0VNKNHSUCAN8TvlHks/6SK/6KKsIEciRfFWx/p5aMHsRbeHxwpoTgdEclBua+V9J+KKBJlxE/x9d8M7QjiC2USfg0ro2CDPo9QjNxDb6b2l9AnLjr4stnHyVZb07f50bMFe2jXV+aui//p5p10zGDazLjMBKtookMzBdIW16mt67e0DRKcy6LvcX8tzUSQ8nwkHp3nTJORotqdrD5m+CHurF+0+xAjY92j7rHQ27MHD+BWRLj9JFyQdWUWsbj4GOjITl3QtvIO4i/JQZNWp5S9bohVPPzU8bInhutIX7+2JRTPXTyXexfdbcFktglyLKpHZY8wHVmPBh4OKHccs8xnLlc5bnx//csr3HX4umZYazcSQ6j37f0+TFw8TMmV2RLf6vP2+B+l8/VRbhb3Y65ztMdcPtTlpTEXvO1KLEv3ZkNLvsS/9YzZ3Ka3t+1ErpDT45QSngtXzfDL6ZepiMEOSaxd9kVtLAmP0JP78xGT5ujg1fo1saA3W+slczNNtDl4azAf9DqCXxGx2DVbjAUI8qD6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(956004)(2616005)(66556008)(316002)(66946007)(5660300002)(66476007)(508600001)(4326008)(38350700002)(186003)(8936002)(31696002)(38100700002)(36756003)(52116002)(31686004)(6486002)(26005)(16576012)(8676002)(86362001)(83380400001)(11606007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdxVXZTTGN0MjEyZnZXMHh2TktsWFhaeFRSbHhGUGVMUTdXZkVHMjcvajZT?=
 =?utf-8?B?Q1AzVGttZjZDU3kzRVRPNjNQaDRUdm5jclA1YU9GaEJtS1F6dW53aG9FYUtN?=
 =?utf-8?B?T0tPUlZXV014cnBiU3NMMElrSytSaEtpQU40ZDBBby9XT0VrRFNnK20vVUVz?=
 =?utf-8?B?MHcrYUZSYy9tMjBtdlhaWmxFR3pqNk5URzhIcnF0VjZzRGQ3bjNCWTJaT2Ns?=
 =?utf-8?B?U1Z0eW55OHZtTnRkSXhRWXlYdnNsSTdINld0a0laeXJlSkJhZTVvR3VCNVhV?=
 =?utf-8?B?SnZ3YXNYeHUxbVprRHQwVmNCZC9UWmoyc1NacXFQaVpmVWE0YWtYd1JtbDJC?=
 =?utf-8?B?cnVsRGtMWU5Dd2xDaktWU1BXUkhVWVlBM1BMbS9xdTE2MEFlemk3aUdaRXR3?=
 =?utf-8?B?dFp5TnBNelc5UlhrT0RRZkJncFpRbFlZeWVJQ3NKdStCNVpxVUtHdFBNbTBJ?=
 =?utf-8?B?dkxXMnpYMmZPaUFxaStiZ1N6cGFXK2pqVEROa0NwTDNVbDM5bElpVVAyeUUw?=
 =?utf-8?B?K1NhZndtQU9QUjFKT1cvQ2lIR3R3b1RGY3pqZkRCSms1dDdHK0NXaEt0THIv?=
 =?utf-8?B?b2pWRkxqSTgzd29PMlNuemgzbnBKNUNJdTVjcE10enIreXpNdjUwdUI3SHN3?=
 =?utf-8?B?S1I1ZW4yU2R2T1VXSnZYYU1zMVNKbHJKQUZnbzlwMmdMSWtENEd5V1BianR2?=
 =?utf-8?B?M0pPK29iN2lqVWt5SDhmcEc4bmM5cmtBVFJhRWwwVThXS2JzaFI3akp3K2hY?=
 =?utf-8?B?aTJmQWdLMllvTDRKY2ZNUXg1NUlxeDY2Mnk3Z200ZXdmSUJwZXFVQktKUDEw?=
 =?utf-8?B?Y0JtbjBZb1VGUk9FSEx4WkNJWW1qTVI5ak82UFJDZXl2MVh2TWNBS1ZRMDZR?=
 =?utf-8?B?M3VoR2VRRFp3SnlkbXR0VEdXYUlnU0lJalpZTWhVeWQ3MDFzeC9pZmF5MmFH?=
 =?utf-8?B?bGgvY3JHeERXVGIzSGF2UVp6SUorNnNCaFp5OWIxTWxNNHJ5QWVuUHVSOU5v?=
 =?utf-8?B?SGN5b1JDaHRHVEJ5OXlSNTVCdVo1NGNYODIzcWJWNFJHbFFlU0VzUENSUXI0?=
 =?utf-8?B?OGhjQndwTy8vbDhBS1E1Z2Vmc1d6T1dCd2QrUDF5TDJoMmYzK0tlaGwyb0xh?=
 =?utf-8?B?SlNDV3diTTBVTzE2MXNOMGt6dFVKazJ6dWhHZmJ5cC93aTJxQlVoN3RnQzE5?=
 =?utf-8?B?M0I4WFZGZU91a3BIaDEzQjZIaTF5WFFYVjJNQ2pGeVFnVWhsbzJ2UHRMR0NJ?=
 =?utf-8?B?QTZYWnZMZVFMTnByVCtZNFJ1WUhLRHo3aXFrcXNobzUxeERsdzV1cUNwUG16?=
 =?utf-8?B?SUJ0NEJJejlZcmRyeWRvbURZUG1QKzR4RUZOdmtSR2VYaW94K2tubVBVcDlJ?=
 =?utf-8?B?TGQvYW9xM2ZWYmtDcEd1OHVEV2VkaHdFT25RWUI3NUpIZk9PQ3VjVFZmRDBG?=
 =?utf-8?B?cTk1WTNoOXVRMTJtVW9tNzhJWWZwZFljM3JnanZNSVFhbTlTTFA3ZEJ2K1Ew?=
 =?utf-8?B?NEhiT1NJcjI0WVRTeExEMkQ1clo5aGhzcndJNlpJSTNTZlJjOWJYNVNIZjA3?=
 =?utf-8?B?QnlWUFFyc00rcE1TL0o2SEMwcW1OcVg0Y1BYbXJBVWtIcDhzWG12WWlJaEp3?=
 =?utf-8?B?cFFSb2RWVUVIdTFLMFhYTmI1UEFvUEI4OFpIejY2a3VSVDVYdmZyU0JrVE5T?=
 =?utf-8?B?TWRuaDVHYU1Tb3hjSjV3Z0hKRXRhM3ZDN3BNOFlldU93dHJnMGdyMStBRC9X?=
 =?utf-8?Q?97gnqfnG1C+sUFFRqYCWHNq+otc02TsQEVrLCJb?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a642429e-f439-4ab4-53da-08d97d7a907f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 03:39:21.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPYsOKXLJpar9MDnzQoV19NclXU8H7qMTWdE+Kltb9Smnzfp76g+vjcvA1nCmrgJGyhZ/m8e7uHYYzGkIrUkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3113
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/9/22 9:56, Chengguang Xu 写道:
> 在 2021/9/18 20:13, Huang Jianan 写道:
>> From: Huang Jianan <huangjianan@oppo.com>
>>
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
>> example, erofs supports direct_IO for uncompressed files. So fall
>> back to buffered io only when the file doesn't support direct_IO to
>> fix this problem.
>
>
> IMO, return error to user seems better option than fall back to
>
> buffered io directly.
>
Agreed, I will send v2 to fix it.

Thanks,
Jianan
>
> Thanks,
>
> Chengguang
>
>
>>
>> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from 
>> overlayfs over xfs")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   fs/overlayfs/file.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index d081faa55e83..998c60770b81 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -296,6 +296,10 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, 
>> struct iov_iter *iter)
>>       if (ret)
>>           return ret;
>>   +    if ((iocb->ki_flags & IOCB_DIRECT) && 
>> (!real.file->f_mapping->a_ops ||
>> +        !real.file->f_mapping->a_ops->direct_IO))
>> +        iocb->ki_flags &= ~IOCB_DIRECT;
>> +
>>       old_cred = ovl_override_creds(file_inode(file)->i_sb);
>>       if (is_sync_kiocb(iocb)) {
>>           ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
>

