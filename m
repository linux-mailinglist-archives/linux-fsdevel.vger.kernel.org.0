Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0947660686B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJTSvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJTSu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:50:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CF111BBE
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 11:50:54 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29KHa0XF010949;
        Thu, 20 Oct 2022 11:50:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=pXLZZcamqMZmOD69TsHlTHJdP8QwGQiwJ1oRhGrJG9w=;
 b=MfQX+QKv4gEPfXFkoRa6L2bQsSHyPza+f4YCug7PMU/FpFvDFtek7YIyVixXje6dajUt
 RDcYV1jis4Uv+6qNc9WJSTZc99LUPsFSQ/LaCPKEZl+jIExie9MvxQ5wfBT4z+8RY9/q
 ZW2ng8Vv87VmT2xLnTQ46t45IATbqBOeCvT1K+ZOPJSf/yDEBp1u8uz3u1OzDWCbDbid
 UIzL9ghvjuJHHTKjcfKHU8TmVvEOW82sWKYmaMueVMcacdgpsuohA/2nFsSL0fFP29jv
 Q5mDev9n6po7TUAPZb+kvBXGI8JEJpN+88tj+aE8RE0/K0Soiz9oFFuVHDW/v+920xMO xQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kb2qpe6xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 11:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs8mGVsxhY1mb1ehZi41pvuQ/05AYYCni+3uZy2Rkhyc1uh7kf457r1YAq3CDHSkoLA44vNV1GCHN7QSqQx6YSNn7Gv0X1nh3ewZSIsgnmeNssbnk9MNqq516it0cWnpILqPjE8oobO5cBUdytw6bPnDZJDi0NKXcnXUAYgjJwIqIk/zn3KF2XATeZXMS/mPWr8T822jecSUMpBMSwLrHE4+ZoJlOux5Q8H2bfnFxe7kwrJnEBEGhV+Jph/ftMzjzQ61Hl6jartBxneDHOvbkQS/Sj71Pc2ZDmtQXuTBQIXGsJgcEKKqtuW7x+XWm6UJiydhvcle2FkGzdhRCB+suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXLZZcamqMZmOD69TsHlTHJdP8QwGQiwJ1oRhGrJG9w=;
 b=nMr7fGbULuSjK+kOyHz3QaSM7+m0WUVpPqWXpRr9bdRjaq4E34agBbkrpexhj9yIB9Fa7vP2BIF8Prgc1b9cn2f24L6oFGDesAbKpYDim714Y/lHbPWNlHmcmLpCTd9jZkUzpVmpY7N4wxM7Oi27YFA/broLS5j8/840CskUOBnklAfpXYtWbKvo7nXRfX9yw3sY20P6bw4BeR5b3qa10FXrQZbIqwaqWNDXHDnJHHZkujNG9L1lmt+QXu1Vu4yNXB9cLIsnkWw0DbQUmHWKe9oHNcLuE3iJwRmKytcMoNsAawNsxm+AE8CVOejWZXbUiq6WNLytRcbFBFuLa2dIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MWHPR15MB1406.namprd15.prod.outlook.com (2603:10b6:300:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 18:50:47 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 18:50:47 +0000
Message-ID: <75da122d-2f73-3468-ae5c-d458ffc441a5@meta.com>
Date:   Thu, 20 Oct 2022 14:50:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] fuse: Rearrange fuse_allow_current_process checks
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20221020183830.1077143-1-davemarchevsky@fb.com>
 <CAEf4BzZE9Sq-Ho=64F=B1C_k-wN4Wkk75j3qJrWRbjDFW3YbUw@mail.gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAEf4BzZE9Sq-Ho=64F=B1C_k-wN4Wkk75j3qJrWRbjDFW3YbUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MWHPR15MB1406:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5c4adf-0a14-460c-6dcf-08dab2cc0055
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHajaLRGtWi79uO6kNteGrQR7Lp4EYtkRfehmIg0OOiMkhCKfsgtRE/PhzNTPI08+B1bclcYY1eyCx86EobfyeADt0AoOF+YsNeu6Tfck4ygQGCdjpVJHrM33qDB4t5zaKyqFyZ4vBTStGebFLKKk4k1yMqOTDMUVS9MnuussAdJaxleTFcgc20Awki8+sWDNCZGjwNB6o5OSBNssj5ZQbjaGbzCBDqaMN63kw08/I/AH8Kwgy3rqLuUlc82i1MBS/1884Pa1BYASjw0iHTV1cPSltqhL0+R7+p3YQ9gGe+AuiO+AW6YcNOedcaS2lgBTpmxswIGBP6u0kXZjGRJYhFROfGbqUncDwkLeqXrzSBqXISsA63EcP7NNHlrsUDR6e8eQ6M41zw18fZ/r9gOHg3DkwnZMknnDoHxZcH3MKLQbWHC6O73i2mg0R+2B/X8yRx1n1p67Wyq6eUhApDIN8XWoym3IqgixNWnh6Au7l9Cn8crxSS+02NP0z0Fbp+ia9gIF0cylYTsOdkTkjs1/6BRgziCx4bXQJvrqWbT9fu5JD2s7ImLZ1pMm4FT77d/2CdxH4kJHxJF42YPmjpHBIWzm9rTuIOZzbII01UA8ynzpaRQNFR1/gv547IgNZJLDAjDZZ6aHNRK86f9BNDOno2tpIfbUQYDtw7uxkwGzK3amW09+jk94QB2urEJHHZXbyuDAhgz1t5Ado50kNGqa5MbiwXAiA+JrQiUYLowkAulJ7ckGmsgEZ57wpGRP1xauVTf4GxtGuUqaz4zts7VM/LjLMK19aaPVpQGXCgbdOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(4326008)(86362001)(31696002)(36756003)(41300700001)(53546011)(6512007)(8676002)(6506007)(5660300002)(8936002)(66476007)(6486002)(478600001)(110136005)(66946007)(66556008)(316002)(2616005)(54906003)(38100700002)(2906002)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3FmZG84WTZGU2xpdXVEMmRDeFFZZENuaFVIT0xhS1VUdDB4UEREVWF4aG1t?=
 =?utf-8?B?Nmlta2dON2QvbFF1bjhjRUZoa3Y1ZUcxUk14aENyN0RFNEhXNnVIeEd6TmRR?=
 =?utf-8?B?WndRZ2pHcEdWMFNyUHB6YnpWR2ZScFF5K3FtbjNrcEFjNEo1WnpYMkl1ckoy?=
 =?utf-8?B?RHdUaU5HUnh2eitiRzVnSkpOZXdCUmRFZnRyVmRCV2pldHQ3RVAzaTB3Sm90?=
 =?utf-8?B?WGNEb2lwa3ZVZCs3a1JpQ1RacG16YTc4S0ZRZHFaVmM5b25OWW9La1UwNzM0?=
 =?utf-8?B?eWFwcHlMSzRITWIzN2xyNDVpM2g3ZUNMM2NUaWxVYy9UNE9zemxGS1lZK25I?=
 =?utf-8?B?QklQak5SeCtkNG5oRTZ4dXpuT21hRVlneERJSDZrdGtLQ05FcHZKRnVzb2NV?=
 =?utf-8?B?YkZyWEhQdDhRNElwWTYyb04zeCtNR2VWWU9OQTIzQXRWZDE5Zjg1VFQ2VmVL?=
 =?utf-8?B?eVQ4SlA5RXJlUkY1QnJ5K2hrVHJ4MFRqNmVwL3dMQkVpMVh6UVcxdGYwRFRO?=
 =?utf-8?B?QmN6STVjcDdTOHRua1RZWlh5UVgxd3BsOFFmbEowaDZZQ3ZoR1VhcUxCYkhC?=
 =?utf-8?B?NmVHRk5jYkpmcThiMk50OWhCNDA0VUZVaWcrMmkvc3ZmWng5anlwdGhIYnNE?=
 =?utf-8?B?L3BpWE9zb0x4Wm5NQTRDUmt4S0todjVQMytGR0hRSE44NVNKQ0VlWUU1Mlkv?=
 =?utf-8?B?MHlFU2FQRmJpZnhIb2lCTVdoSzEzS3Fnc0loTzcrRmROb1VvUVNOMFJHZlhw?=
 =?utf-8?B?T2d5OEcwa001ZmFwaWpMMXk1UC9SOHVNMHZ3Uys4eVlwekRONmNoeSs2WE1L?=
 =?utf-8?B?Q2N5R090UzdKdGo0RVNlQS96VFlMc0RxaVpPaTkzS054ejZXWmd6UktFNEdK?=
 =?utf-8?B?T3lVMGhRWjM5UDRwNitVd1ZGOUNmRlZaWDBrR0FESnRvRVVQMGhnTlh4YlVm?=
 =?utf-8?B?SHZtOHRMRFJNakZoOEVXWEhHVjRMUE9kQy8zVk9FWVBqQUNuT2xXRmE0TjRE?=
 =?utf-8?B?YlR5eVo3ZC8wYVB3aGpaYVhUaSszN2I1djFCNTRXZkR3TUpVdWg1anFxRnky?=
 =?utf-8?B?MEJuaTRnSHE5aUlwbTAyQ1FVWFkvQktrVmN0RkIvT0RDYit4Mm1sam9kaFdT?=
 =?utf-8?B?UnJiQmRodE9Ib1dRY3V0SUZNTXM1TS9FY042ZGplaFJncklKajRiaVF3QkVJ?=
 =?utf-8?B?TlQwaDNYbExOWHhrT3VGQ1gwR0RPV0NtQ0VoOFhsK0VOQkNpQ3BSK0ZQdHhr?=
 =?utf-8?B?eTZtWHh5SFRYbVdnZWNnNlJrM2kvd0FPeW9oTVJNNlVZTU9laWxSVTAvNDVy?=
 =?utf-8?B?RFhxdWV4bEF3dU5pS1YxVmV4NE9YYzFEWDRMTW96Y1dJRlJDVzhwcklHMkJS?=
 =?utf-8?B?MXFVTEgwekl0UGx1MU11ZzA2QVhGbGJUY05WVFFXTFc4U3pSVm9YN0N3Zkhu?=
 =?utf-8?B?MHkwU3BTcEVFZEE0MUhxbzhEbmF6TElDWVp5bVZCTDhMMmsvUldRMStXR1Fs?=
 =?utf-8?B?RjZjQ292ckZVWjYrSjYwYTVWekZNZTFicmZJQW1Ha3M1T3JNU1JwczdqcHkv?=
 =?utf-8?B?U1dXVDR0RnMrcnBGR0NKYjRQZGIyb3FqREJzcGFKUkViazVJUHhmTm5lWmNG?=
 =?utf-8?B?ZGw2QmMySDJvajJ6TUpjbld2bHgwSWpXak4zcVlUd25Dd1pXKzFiWXF2cGtn?=
 =?utf-8?B?MEZ0ZlFISVdEdjFqcEVHZ1c3amszc2ZHRDAvZXQrMmpFeWdUcHkvbGdxSU4v?=
 =?utf-8?B?Vm4zTU1jTDZTZUVrTCtsRGt4RStlUlA2NUZQQVZRRlk2TUc3czIvb2x6SUps?=
 =?utf-8?B?cWhLcFZYWWhBbk8zTVFFUWplcW9TcmVEWGNRTU91OTlmRWp6SGZxL3BJUDZ0?=
 =?utf-8?B?aUloOVB1eitwRTYrS2lVOHkyTVp4bkJhQ21pZVFwUFltUEJZSlNVNkVBSUtr?=
 =?utf-8?B?dVBYZUQ0YW5jbUIrUjl5R0h1RCs4UUZuVDVIaFpHNUpCK2w0dU92c0Z5YmJo?=
 =?utf-8?B?ZzZTNW9iRnJIRms3eVNaZ0ZxMjVzRENWcXlydndJZE83RXhFV2pMVWxmMVEz?=
 =?utf-8?B?aUhEOS9LemZ2UnV5anc4V2M5MUczSy9HNHVOekNpd21MNnAxS01HcXJQMjc3?=
 =?utf-8?B?UXZ5SGRxSExWNkorRm9NdDFuY0Y2aHZPTFY5bWxOcHYwZWJtcXU1RW5LeWI0?=
 =?utf-8?Q?qlR91ladVPyW+2lFehc+Tm8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5c4adf-0a14-460c-6dcf-08dab2cc0055
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 18:50:47.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ3BuAsaHaSDdkCjknKrYzfWs4cFCI1p9gchbdfmgYVOhv5f+M24/0FJ2233KvXWM2lASv99PHmKWp62lRTW5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1406
X-Proofpoint-GUID: vec7-H4vTfg8F-YPlhk-4hOtmIdkt5wy
X-Proofpoint-ORIG-GUID: vec7-H4vTfg8F-YPlhk-4hOtmIdkt5wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/20/22 2:41 PM, Andrii Nakryiko wrote:
> On Thu, Oct 20, 2022 at 11:39 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> This is a followup to a previous commit of mine [0], which added the
>> allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
>> rearranges the order of checks in fuse_allow_current_process without
>> changing functionality.
>>
>> [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
>> beginning of the function, with the reasoning that
>> allow_sys_admin_access should be an 'escape hatch' for users with
>> CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
>>
>> However, placing this new check first results in many capable() calls when
>> allow_sys_admin_access is set, where another check would've also
>> returned 1. This can be problematic when a BPF program is tracing
>> capable() calls.
>>
>> At Meta we ran into such a scenario recently. On a host where
>> allow_sys_admin_access is set but most of the FUSE access is from
>> processes which would pass other checks - i.e. they don't need
>> CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
>> call for each fs op. We also have a daemon tracing capable() with BPF and
>> doing some data collection, so tracing these extraneous capable() calls
>> has the potential to regress performance for an application doing many
>> FUSE ops.
>>
>> So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
>> hatch' is checked last. Previously, if allow_other is set on the
>> fuse_conn, uid/gid checking doesn't happen as current_in_userns result
>> is returned. It's necessary to add a 'goto' here to skip past uid/gid
>> check to maintain those semantics here.
>>
>>   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Christian Brauner <brauner@kernel.org>
>> ---
>>  fs/fuse/dir.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 2c4b08a6ec81..070e1beba838 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1254,11 +1254,10 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>  {
>>         const struct cred *cred;
>>
>> -       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
>> -               return 1;
>> -
>>         if (fc->allow_other)
> 
> {
> 
>> -               return current_in_userns(fc->user_ns);
>> +               if (current_in_userns(fc->user_ns))
>> +                       return 1;
>> +               goto skip_cred_check;
> 
> } ?
> 

Oops! Originally the goto was in an else clause.

> 
> Otherwise, makes sense, thanks!
> 
>>
>>         cred = current_cred();
>>         if (uid_eq(cred->euid, fc->user_id) &&
>> @@ -1269,6 +1268,10 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>>             gid_eq(cred->gid,  fc->group_id))
>>                 return 1;
>>
>> +skip_cred_check:
>> +       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
>> +               return 1;
>> +
>>         return 0;
>>  }
>>
>> --
>> 2.30.2
>>
