Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95006518F54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiECUvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbiECUvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 16:51:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30C2F03B;
        Tue,  3 May 2022 13:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMAU8VRzdEdwxQrGdbM7FdYb6KiGNSs7+V2WqQWm9Vo33lXDiGLlPWcOYV3Y/MhtxzjZdYg1eGPYRNaaXtVaJUp20+U2jmMv32WmEUtGv2X5FIGMapsvXiahSu8WGnP73es4yckU4KMAqBqsYSaQpCUcyAtJ8i6+Yo5rHvoBkMhc8f/3Urtio2xkf+xl8MCtdwImLC7xBugPsI3/Qt5YmdhhPaw6DTKfMOCOzfxo+qF6CKNux9q2XjgkgdrPHtUAZDqAaiWSWTZWVzrlYGgDOhEV4dU1WkD/gnkvzGUM7BNAwmhio93iL46g3t+eHCzjvTN7T94WI9OJ/rTp+a47jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+P6Xxl8RyiDh2/CPJms1K/9PNFxoxDe2GFdVl3z/J0=;
 b=ekmQVWd8AXMg5fU6mGBgN1TKvYo+za57kB+NFYnlxkCyYUYitdIZ3madMv2XsQl1uHp8u21FKQbSoFPI+qx/25AycjxeqQF0MlCqAYNkg+hqSR33lGARlcOHKHakthXVGNN0A/qcma3wyv+okLbZZYk+t/k01gnsNHcIwgQtz0qy5wgQVICGcV8wTiThC/d/GikJGz3oj2K7l6D0GokEnu/LwMjqqnOirwT/27e45dpWpcUMRyQFrPUlU9l27nwAgZDfNf2Foh9+xuWlepbdkhG+ZfVWM9bhiiXPioejZKdHQ7O+M9uvKZ8oS4H1eHon5C/R4S5MSfjMJaAN9jf2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+P6Xxl8RyiDh2/CPJms1K/9PNFxoxDe2GFdVl3z/J0=;
 b=K4bmFVUvBbUYnUAzagEZP4BjxlF5MRuvvwnLVKPhK5ocYzHVOuTYMWl8UM+mGyZgfIJ9Ex9Ft8340RblO75JqqLaHU2Gj/Mwz4Ztxol8dv9g3+E+UPOn6CEw1OuOdX+O4S3CyWX78BPpOb9Gi5Dfqy+h4D1AlYkIrO4VW3k6XNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM4PR19MB6003.namprd19.prod.outlook.com (2603:10b6:8:6e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Tue, 3 May 2022 20:48:12 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 20:48:12 +0000
Message-ID: <05262a89-1c70-3cdc-abd9-32f6730d763f@ddn.com>
Date:   Tue, 3 May 2022 22:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnGIUOP2BezDAb1k@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::13) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f189e487-66ea-4394-bc33-08da2d463cff
X-MS-TrafficTypeDiagnostic: DM4PR19MB6003:EE_
X-Microsoft-Antispam-PRVS: <DM4PR19MB6003D7642D0C6439D2684560B5C09@DM4PR19MB6003.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Un4XCIXbUDe7t5ptqQmpjpBtsfzMYg91sHPQ12kN9hr77rvrpJxU1aNsc0+6gPvmF23JFQg9oxG/dwmDTdrlx0R4AiM/6EpYKAbWoHWmOhgUeG+kLOJputRF/oTAoyvQ5vwy/ZIpUWywma/EEGSMRwMwBeniiGhPdEJfg1BzrrU99RNDjRhPCJ0uORuL8Sns+5FUqaAS1cjGbmRJ9UbvKpXBrwUxT0sGCVpkxd/JvTlAmg+a9C5F6JkzF6JpRkCW6q4dg89Fqx7d70IkJyr47IUwEg1ac/oOvOolRN5ncrxICXpu3zAnwRw2/sgLayvEHiSmQA9vwtkAGCBlfbDLwTWvkIqXuC0dhTddl+88ye/DEDa04MJGgGVcVUf24PEKJ7WYoDFvnr9g4AYMqk6AcmVdlSzyoWVkDVY0uKGCae/F2te6zSkq3xiN+dox8nR3xBBh3cLD8TK1weygr0ncID3tEzSQhIsEltEcWg9BlXqCrePlHNBhxsq1MmE3SLgcQEj9eI3IMAOHquJBzPH1ZMl/2+sAiKNknvU2O1+98HUfFMdK7ff8ao9Bfc+g5I6NH2GQ1IMz/dbqHBF8n7YJ6mfvI6NV1MavD24/1ZOEJAu6XMRAPC99T12+KLSpmsUsHkTrgZHVjLuHlG/zT5qD+G/w+dm6NVsKiinkilQXnmLjZc+E/KRZ4TizbkVnzhZIu5R6RKV9DjsMeVxz6a9QJn69ESP2V3A7+JP67LfCkY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(66556008)(66946007)(31696002)(110136005)(66476007)(86362001)(8936002)(316002)(38100700002)(6512007)(2906002)(53546011)(508600001)(36756003)(6506007)(6666004)(83380400001)(2616005)(5660300002)(6486002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVuR3hER0V6RVZOZnNmQVhCT3Y1NFN0K2tXbUp2cTAyQlBxa1hWZUFXK294?=
 =?utf-8?B?a2Vtc2ZSeE96RTQ3dFpZUVA2ZHpuSXV5Tm5MZUN5QmdPa0xQaDFvdHljYUM5?=
 =?utf-8?B?OU1DU3JReTkwaVJxOVJDQ0VKWXJQUDB6dW5SbmdYelpIeEZmbEFQVEllZWZY?=
 =?utf-8?B?Y0lrb0ZOWFVSZldNaStjb3dLTm1iS0FvUGxxdGU0U1dTSk1XY0o3VS9OdjFn?=
 =?utf-8?B?Yk9Ca09RSHBNdFl4bldPbE8wamlMdytBTTlDOHZ3bk5LVE9DMTMxY2ZGMmlv?=
 =?utf-8?B?TVFLcWdoQklkVS8rUU5VUmtQK3JFdDRxOTZoZzNUK2dhTlFmalhsb1hmQ282?=
 =?utf-8?B?aEszTENtM1FOcDRBTVptTFJxRGY5ZFFpSmhhWGhnWHd2TUp1dnNINHJYSHo3?=
 =?utf-8?B?VEc2QXN6K1F4SU1Id2VSSDd2djdubmYzVjVCMmJDcUgrSCtmV3pCSVNQbGxa?=
 =?utf-8?B?WmxWenl3U2JrRE5GMzNYaXAwR1pEeG4yS01XQWVMa0pyQkF3ajE5b0lubUMx?=
 =?utf-8?B?bkMveHJIL0Q3M2t4ZVk4bTBtamxEaTVEWnYvRDVBYlMyYWxDVk1QblFqL3ht?=
 =?utf-8?B?SlUvNUJUQ3ZWOFhnYVk5bXlTOXRJTThBVDQwaHJpZy84ZnlIM2g4TGwrcFlT?=
 =?utf-8?B?S0RhRmFrMlRIMzcvRXQwZzZzd2I2aTZ3VjNhSGdId29rckxlMEpySjYwQ1dY?=
 =?utf-8?B?cWVENSthUXFxTkdiSE1CSUw5RVNsQjkvWGJOSHBqV1FWMlkrcmFSNXBMNVdv?=
 =?utf-8?B?RG92eCsyOEE0ZWl4MUtwN0tZZWsxOFZydUFXMDBjaW9lc1RWV1hndDlKUmpB?=
 =?utf-8?B?YjA0cWkxZENEdm1mTWxHQTNhTWVYK1V4Q2hpZU1RQjZPOGJiK3QvMXNCY0J4?=
 =?utf-8?B?OExPa2NSaDVnMEY1TWowYk95bmgrMUdkQXRaV3RkM24wbUg2bWVCbUJxVTMv?=
 =?utf-8?B?SHEvQlhYa0EwRWJxa2FYaElDQmtKRkVKMXlrMlZoSWVjRjBpclBDQ2pOZmdt?=
 =?utf-8?B?RXRlRGhnanJqNUxLZ0x3L1V3OTliRkwzSDhGd1NTMmJwb1hLUVdTYlZLRHh2?=
 =?utf-8?B?UGdhL0d1c2ZCT3Q0RHc5TjcrR2M1YXB4YzBzKzZzMVhsZ0xrV3pFaVo2czla?=
 =?utf-8?B?VzdlZGFWdUtBaWovR09xWmttRDUrMGFYdE5zVEoxcjhoS0lMaFdoRXdhaDkr?=
 =?utf-8?B?MHZUay9wRE1FME9UZC8yM0JmWHFKc29LbmRKOU9GVUs1Mm4wc2gwS2JHSW9P?=
 =?utf-8?B?RlNsNXB5NDBUai9zL3A3UFZUMDcyWm1MZitHTG45L0l0QzRhbDQ3Y2RLZnV5?=
 =?utf-8?B?c2NYdEE3enZQckdSM0w1MWF0cDZXRzdmTDJqRWxvblRlSEwzcFVuVFBhaGpn?=
 =?utf-8?B?Z3UrM1VsdVRBa2t5QlRJZkZQVFpLOGhvUS9JbWE3cVcvemdJRStoblk3d3M5?=
 =?utf-8?B?bUl2Zm1NQ2ZXcXg1SlVKNmRjZjh3dHR5ZEhKK1UyL3JwMCs0QnlPRzZ1UVMx?=
 =?utf-8?B?WDQyVWlaV2VGRlRMZDB0R0tEYU5mRHE0M1ZwOVEwd0JuZngwNDIrK3FGMFJX?=
 =?utf-8?B?bUtNNXpZdENQeEdMNzZJMTY0ZHN3T3luS0pDakpHT0VTWStPTlF4RUJobmFk?=
 =?utf-8?B?Y1czZ1FwL1o5aUtuMXVxWHZNcFhpVWVDSE41NzBKanJKOFQwM0c4YlZ4TnpQ?=
 =?utf-8?B?SDlQbWtQeDFEakpDTHBLL3BrTngyTjB2OGphL3orWVBkckxjZEd0MHk0S2VX?=
 =?utf-8?B?OTZaYjBmditQTG5SQmhITVBFN1F1cHpNTmVzdzE3U2RhQk1zdmFGSU0rUmFt?=
 =?utf-8?B?bkpUeCtBZG8zTC9jdE4xeWxISjFUaTNxT0hXVkI4WGVLSUkyeXZFY2x3SGsy?=
 =?utf-8?B?RFVJdjVKb2xYeU16eHRNS2dvcDBNdHJkTnBYaXQxcndMRUxzTFk3aHVodTVG?=
 =?utf-8?B?b0xISS83a1FkSEZzTmtFV2ltVGdTWFZxMExzeXZzcG5VN24zdlZrWUQrZ0RN?=
 =?utf-8?B?SEUwVDBXUm5WV00wSFNyMGJMS0lwOGlNTXpHR1NJS1cvV3RGOVVtcThsQ0t4?=
 =?utf-8?B?cGJEb2xEZ1BvQUVBbEt0TU9QMi9jc2JQRUwxbHczSkxZNW5GbEtudElUeU9S?=
 =?utf-8?B?UVduSXpqK09SbXVDZmVucndHR0dYaW0vcUZmNjY0RXFxOVA3UDB2L2U0dDAy?=
 =?utf-8?B?VDExdzVOczBGMEJwUlNHOGU4RHliejFSTUdIck9PM1RTZHpFdzRkejBicUFN?=
 =?utf-8?B?aWthamRsRHVLb0F4dlZzeGY0bVpFYm9kaSs2YlIrMHRKSEQrYzA0V1k1emNm?=
 =?utf-8?B?TnVCa3hLeTB5QVZ0WlRHd3RnQ080NVI3RWRXZ05VcURHTkdPTjRKd2ZSZVZZ?=
 =?utf-8?Q?sqNb/LsaGP0bhzf7gbYHJ4BPHRjJ8MQlNGi+hvsvZnxHg?=
X-MS-Exchange-AntiSpam-MessageData-1: KtsByil27NX4ng==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f189e487-66ea-4394-bc33-08da2d463cff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:48:12.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6cghAEAVyRWhLhcHh9XduZmaeMTh/9leBpJrXmEu3TQ0Ahw3VIZxRLwuJHo4W2FnM0IIYZwvMIfZ7F0od73XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6003
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

On 5/3/22 21:53, Vivek Goyal wrote:
> Reading the existing code a little bit more and trying to understand
> existing semantics. And that will help me unerstand what new is being
> done.
> 
> So current fuse_atomic_open() does following.
> 
> A. Looks up dentry (if d_in_lookup() is set).
> B. If dentry is positive or O_CREAT is not set, return.
> C. If server supports atomic create + open, use that to create file and
>     open it as well.
> D. If server does not support atomic create + open, just create file
>     using "mknod" and return. VFS will take care of opening the file.
> 
> Now with this patch, new flow is.
> 
> A. Look up dentry if d_in_lookup() is set as well as either file is not
>     being created or fc->no_atomic_create is set. This basiclally means
>     skip lookup if atomic_create is supported and file is being created.
> 
> B. Remains same. if dentry is positive or O_CREATE is not set, return.
> 
> C. If server supports new atomic_create(), use that.
> 
> D. If not, if server supports atomic create + open, use that
> 
> E. If not, fall back to mknod and do not open file.
> 
> So to me this new functionality is basically atomic "lookup + create +
> open"?
> 
> Or may be not. I see we check "fc->no_create" and fallback to mknod.
> 
>          if (fc->no_create)
>                  goto mknod;
> 
> So fc->no_create is representing both old atomic "create + open" as well
> as new "lookup + create + open" ?
> 
> It might be obvious to you, but it is not to me. So will be great if
> you shed some light on this.

we are going to reply more in detail tomorrow, it gets rather late for 
me as well. Anyway yes, goal is basically to avoid lookups as much 
possible.
AFAIK, lookup-intents had been first introduced years ago by Lustre 
developers - I guess to reduce network and server load - same reason for 
us. Later Miklos had introduced atomic_open, which makes code 
using/avoiding lookup much easier to read.
I guess unoticed that time, fuse was not fully using all possibilities 
of atomic-open - we can see quite some lookup/revalidate traffic for our 
file system.


I guess the commit message and introduction letter should be updated 
with your A/B/C/D/E scheme. A) changes a bit in patch 2/3, which extents 
it to normal file open, and patch 3/3 adds in revalidate.


Hope it helps,
Bernd
