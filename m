Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6393120C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGBtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Feb 2021 20:49:19 -0500
Received: from mail-eopbgr1320040.outbound.protection.outlook.com ([40.107.132.40]:37555
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229570AbhBGBtP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:49:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZtOtqw2LmaxJSTH/15013Kc6qBIr75GztWiJ3WufyM7CU3NpseUOkCCtnD6GcEhyC06osYX36xzd5I+qrPLiSM+rdvT/wsr4Ia+Thm48rCOFx73AXzlzp0bjaYo/bjZ4aWQ8AXEnAdRWIaaXdrdCvLg5QO22CtcG+xdBhIynxd1dN9RjJLHRIJC31U4v9TD/No6H9awXsLkX304WB564bfercDTDZDvdY1u/MiHpk01bDXf4M3l7Bdrqutbt+YJxtiwimcD41cz3pU36XdWUj0LMEujxCK4TMSkTYZVSMHH0yoTgmTfAafMdrvl1q3bwc7dvviSu64lIdK73AHZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umm3y3bQubx0X/I6KPbyLDmZvWBbk+//v6izfuFUV4M=;
 b=D230jluVZJRf7Vee5POx1oW3tO7a+N+ULwL3F7FH4AjRxKGvJOpz4mlXLDeudn9A0ntqgyiCtsz7S/eXF8ZwG4pikkCHQoFTbA3R4EPjmP77d6101NMaz+zsSFCEUEM+gU002HuIelYlrmVKe7dUG0T9ID5h73IoEcc1mjg+a+3WVP1AW2ufKo3zBTwFjU+9u1u/2HmgQreK2fnRWu/gXq5nCVOtohKU7PtfJKTRuZVYkqUgdx+Jgs14aQz4/JyafMD9LL1B5dIS8itnT/IjVmmIuaGvPpmgt2gbzOpiYhNM05ty6M3ksRjp3AYDJPsbC824tK8GznLzWH0IuzqY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umm3y3bQubx0X/I6KPbyLDmZvWBbk+//v6izfuFUV4M=;
 b=YwZwZieJflumxrPFVZHTjQ9OkxanZ9SwL4RdKIVBSaM+yVHgZhSGv2oqbCYJ0Gfa12ChKe0PsJv5JZHVKxQxb7X0r47ROSMWfPRfDfgq1173V1ugusmO6AJat+U1pjX7JZeOaihDAiPFbH8jDJXqMrEdjCe8UZkFCNdlLbMxs9g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3575.apcprd02.prod.outlook.com (2603:1096:4:36::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.24; Sun, 7 Feb 2021 01:47:39 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3805.030; Sun, 7 Feb 2021
 01:47:38 +0000
Subject: Re: [fuse-devel] [PATCH] fuse: avoid deadlock when write fuse inode
To:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu
Cc:     guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210202040830.26043-1-huangjianan@oppo.com>
 <ced84fb1-0dc1-a18f-0e61-556cd9e28003@oppo.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <888b7732-abb3-3025-6e91-0d5cb5675efd@oppo.com>
Date:   Sun, 7 Feb 2021 09:47:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <ced84fb1-0dc1-a18f-0e61-556cd9e28003@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Sun, 7 Feb 2021 01:47:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b9e2691-72ab-46e9-fbed-08d8cb0a5972
X-MS-TrafficTypeDiagnostic: SG2PR02MB3575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3575EFBCB9B0C7DBEF3E2B90C3B09@SG2PR02MB3575.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLurmXsx3jvC3+9888NknzDkKamocW9u8zcScTQM3INgCpGNnh6s0Y2it0Fn/C6vmXxg7i8Yd8G5gXFLKoWM375FHBhLGyQz8Aoperc/RjlAQsurDWpmekYt+BfxT6rNrw+7LQ6RkMW4/WiPAiuNsvM6Qxk35NUZseUSrh26w5vmgONMu+KqC+qJJ8lgTMMU0L5HlzFzQOdK22Y4ubSplJRVFxuywPPbJFBvQFYsnwieD4UI+PkEIcqzkVcW7WCq28UI+C6i6rwFSz0dfufPa3kfyTO71A6pR1StbxR2vM/hCNpzJvTRqj7TsyeFh3H2jgqoXBGC3X1UjvNkcr+M+LMIEEtG1W+DeleQ2jBnuN1phkKMHYhGPRKs14uDvPAlv9TgARtLwamSenrEHojiokgFR0ueoTGZObiTWUz+wQAehpwzpHudObV24pgtyUXLxGyEnlcgufM9WrWquA3PZ/OOeaMk/P/jbSakBojnHkVErssvFGJySMAiy5fH4X6E0dSoG6f1FKW3h1wx6ptzcEuW9FnM5btE3eOnPEoZHpPK9DfoEros0zSMdT35HqXGVL3BkJ0EuYwFnsiBmaPr/dWmmBjZEON6hLDgW9mZ45wEO+71IlRXDKeXcTXcUY1S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(4326008)(16526019)(31686004)(186003)(26005)(36756003)(2906002)(5660300002)(8936002)(8676002)(86362001)(956004)(2616005)(66476007)(66946007)(52116002)(66556008)(83380400001)(16576012)(478600001)(316002)(53546011)(31696002)(6486002)(11606006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NUg3MFRYbkFYNHdOY3JNQzBiYTRzY2x5eVZDVnNIY3dJQXhHaEF3MmwxOHBI?=
 =?utf-8?B?K2xUSm1VNS91UGk0eGtIWTAxRW1qZzlYa1UzcFJXS3hVTC8vLy92SERIWjFG?=
 =?utf-8?B?M3BNRmc1TEkwN1owYVFRMmZDTEYzUlJmNS80OTRMemlBVW9EMVFiM1dCYUF2?=
 =?utf-8?B?cVBKSktJa1QxTFBPelJXSm5xcU15L3crT2dqQm9iL2EyWXRHR21RWTFHbkdX?=
 =?utf-8?B?dlYvdTJnWFhWWCtCd08veEQxQmpjbW41YUVBVitPWm96UlptaEplTFJNZytU?=
 =?utf-8?B?STNweFVnRlNSWmhQMUVFNm9DZmRJeGlDYlppVTQ4Y0V0SVdWOEpGTHBUb1kx?=
 =?utf-8?B?N0orL1BuVXRRSDdpRzZEQlFmTEFYNXVMUzQvWUFqY2NyQSs5SlhYMG5hUnAv?=
 =?utf-8?B?NVNZN2NsN3JydEw4SDl1aTY4T3dHRHJ4M0MrMDNMaTdKL3lmMFJObWtOOTJZ?=
 =?utf-8?B?MUp1Z2I3a0dEdDVadStDUmdkM0l1TXRWWTNpcGlTR0s0ckliRkM2ZjgzWG92?=
 =?utf-8?B?S2IvbFg1emhxLzNFaHc1SHFxRExJL0p5M1VvWjFwMkhaMGQwTjFPanBnbUJp?=
 =?utf-8?B?bkF3d3BPMmFNUUdjMUJDbERPRWt6Z09jaG5pYm42UTQ4MnJ4SnpzcG9Vck4x?=
 =?utf-8?B?bTlCemtiYlZqNWR4eFpTYW13VWt1KzRYdThYb1FJbC85VXp5ZEdxd0FjT25F?=
 =?utf-8?B?MlJrWnFaVWJON0FqVG91bHdjNEd3NzkrdFN2amRWYnN1NXFjUEZJZHZGd1ZS?=
 =?utf-8?B?dG02cVk2NGR3akpTTG51dkhCbitUVXhpNEFGY3NhM1BFZDJLM0FrdjR2T3g3?=
 =?utf-8?B?d096dUIyalU1Ri81MXdBSlhFVHJqOE5Cd1B6YzQwQVFIMzhUZ0t1ZUt2R0pQ?=
 =?utf-8?B?MFJlb083eGlIdnBweDV2Tm9NbTY1bGlrZkNCQnRlV0lieUh6VUF5UWMwbzdJ?=
 =?utf-8?B?bGVLeUNub0ordXNkd0NXekM5Y2x0NjF1ZzhJNnQ5eE5iakplVzRGRE84VFNU?=
 =?utf-8?B?OFpTbWM5c1RSK1djYmYvOVYrZlBhc29UVlhnclJrL3BDb2NEMStNZHJHOTBV?=
 =?utf-8?B?MW5TdXhWYm8rQWROV28xWVlVS3huUllSTVRZNFNjbk1yYUVlTjYyWnJWYWp2?=
 =?utf-8?B?bjJBTkdVbTRFSlRrcDRBQ3UvbzRCU2NZY3NkaVlvM0RBQktpVXV5VS9xaFhu?=
 =?utf-8?B?aDNCMU15SWFkMVpaMngxTXVUK0Q0Q1NFM2JQZjhucmtCNEY4UFV2aXRNYmZr?=
 =?utf-8?B?R1orN2FlT1VXSUZoTlVuMDFhQS9QbEJyTmVFaEdRYy93cnpQSEpaVHRnemtL?=
 =?utf-8?B?bEg1eEh5VDNla3hibS9SS2duYWxOanpHWlV6dXk2NEpQY2ZRTUozajJWQTZC?=
 =?utf-8?B?OHR4OGdGSTFWT2ZBMDZUaDl0NVB2ZWl4NGNoQkZtWEVyZlB3VzY5QkFWMTJJ?=
 =?utf-8?B?WU9JdnNtY0RVY3FOQUVRU3BtbHk0TDhSNHZ4Q1NzVEx3SUNUSUcvTnpKOXUy?=
 =?utf-8?B?Vm1qZ1hNSDVQSmNydGdoSzdwakNISnNYVnV4cnJsMlRwdEJPRTlPN0RPcjV3?=
 =?utf-8?B?QVc0eGpjREFTS3Vic05qQTJCRU5ZalpkUitkZDFrUW40ZmlTK2Fpd3M0aWJy?=
 =?utf-8?B?QWc2RVJsMXpJWlY5WU8xenNNQkk4VWIxSjdLeEIzaFdSNFI1a2p0V1loUUFN?=
 =?utf-8?B?SmhWMXhKa3dFOS9jc2VjT1libmx4WllKbEV4UFNhZGNyYmVLeU91Y01HRlF4?=
 =?utf-8?Q?hcRIRfgjIvHw8zPAPWE8XCgxuQp1vQoOYOX6QIK?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9e2691-72ab-46e9-fbed-08d8cb0a5972
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 01:47:38.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnLtyeipSymbGODDt66h2wkHPjNwTLIkeOT5mJbuPr5dgCryOk4+GagLJyaE5tdNvesVX/TZ4g17I7/W0WysGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3575
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

friendly ping ... 😁

On 2021/2/2 12:11, Huang Jianan via fuse-devel wrote:
> Hi all,
>
>
> This patch works well in our product, but I am not sure this is the 
> correct
>
> way to solve this problem. I think that the inode->i_count shouldn't be
>
> zero after iput is executed in dentry_unlink_inode, then the inode won't
>
> be writeback. But i haven't found where iget is missing.
>
>
> Thanks,
>
> Jianan
>
> On 2021/2/2 12:08, Huang Jianan wrote:
>> We found the following deadlock situations in low memory scenarios:
>> Thread A                         Thread B
>> - __writeback_single_inode
>>   - fuse_write_inode
>>    - fuse_simple_request
>>     - __fuse_request_send
>>      - request_wait_answer
>>                                   - fuse_dev_splice_read
>>                                    - fuse_copy_fill
>>                                     - __alloc_pages_direct_reclaim
>>                                      - do_shrink_slab
>>                                       - super_cache_scan
>>                                        - shrink_dentry_list
>>                                         - dentry_unlink_inode
>>                                          - iput_final
>>                                           - inode_wait_for_writeback
>>
>> The request and inode processed by Thread A and B are the same, which
>> causes a deadlock. To avoid this, we remove the __GFP_FS flag when
>> allocating memory in fuse_copy_fill, so there will be no memory
>> reclaimation in super_cache_scan.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>> ---
>>   fs/fuse/dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 588f8d1240aa..e580b9d04c25 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state 
>> *cs)
>>               if (cs->nr_segs >= cs->pipe->max_usage)
>>                   return -EIO;
>>   -            page = alloc_page(GFP_HIGHUSER);
>> +            page = alloc_page(GFP_HIGHUSER & ~__GFP_FS);
>>               if (!page)
>>                   return -ENOMEM;
>
>
