Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5479D58E82A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiHJHuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHJHuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:50:21 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50111.outbound.protection.outlook.com [40.107.5.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A221255;
        Wed, 10 Aug 2022 00:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By9aaQq1IPJQCMd+5sdjkT07NkLHoZDOEYLxSZpWTlPz4QnwdIK09eyCJIS6wbt13vSRmme2IztXEHhxwZdpZeNuj6e8Ril1IydEyoRLS/jBjHKuwBAANnT4dbJ2BIV7e6DjArMYUNkBrA1C/IpY+19n52g3lEvjXy6J8RDeH7rwnEhIWDDktuhJJMta87u85hGd6qJdWFG7cCHdu2HcPciyQPcBYKVkKwpNB4pvBERchcMhfA0aw5hFgrxFUhipms8SssVOyEzpbjHjmMxH9XGLhC0t383AvsYu4N/TmkIlh24JzkPCmQfwXRb7syP77P/voJEE//br52EzcviVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og0Ga7CN2zmm7lHS6vfelFtnF19oITN01Ty9T1yheVk=;
 b=SMAJ7blG2sVXjC6rw1tAWArsyyg4iKIiUfM/t0YqSqhqphNP+VKwWHtL2cTkX/PLYs7bB8CIR3EOwiPBtuvIrAcerlEH3xxnWbp1tXMrjl+Ry/tqc4fD5BVDPbMO0f1FQsqkKxuLEAjWLFOpGa0Hx42IE23ptApK7L92aataHcjbg6dsIwDXjvGMDdyrDMMdLWaHkM4DkRZUTcuQrFMcyQX4LksQW2D2xMcx4NeGuq+mmJqLrJS6heRK4ASdIfqWW0bbbIvXnrmfnNxglU7f2BMTdvBd54uatAlmMYStsbhs3YrQjXUg+Rwghofjj6t+2PAxPg9x6KzFPihHhM4VQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og0Ga7CN2zmm7lHS6vfelFtnF19oITN01Ty9T1yheVk=;
 b=h0wnO+YFT0PY1KuB6L7BGUV56IJ7h/Axrd5VRmpjv1F/WrY4+5AnsTPTKehrdrn3IU/RJEP2SCeuQXu81m0oHZc6e1asnZ87P/s44v1Yn08fE0CHvaeffCzfj/f0CX6d+XkDH0ayPgFxRc2kQqGoQqk9LaaC2JVaVtofppayg+/AeuBIVTSgbGXSCc5yMPxaVfPPcqOMPtYVVZMHiDfGnZvDmkVsNoZgWSTU+Nc+s8UTfyy0DBqfeA8lsuPaCyEqkTOFK7rH/UJejm9YTPpANjiPyLO5+qFgeryNJajymTxeH0KPlVOG5El7cpiyZFbfokXbu4+S4evIqwVepokGhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com (2603:10a6:10:da::16)
 by DB6PR0802MB2135.eurprd08.prod.outlook.com (2603:10a6:4:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 07:50:16 +0000
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::3d34:b8c3:1c37:5a6a]) by DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::3d34:b8c3:1c37:5a6a%4]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 07:50:15 +0000
Message-ID: <b43de131-24dc-192c-f5f6-09bacee52a00@virtuozzo.com>
Date:   Wed, 10 Aug 2022 10:50:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.1
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809063111-mutt-send-email-mst@kernel.org>
 <d8fd3251-898d-89fe-226e-e166606c6983@virtuozzo.com>
 <20220810020330-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220810020330-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To DBBPR08MB4758.eurprd08.prod.outlook.com
 (2603:10a6:10:da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2911d5b5-d2da-4f2d-5041-08da7aa4f681
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHOvWyh+TmSHKTHGKnwb3VvJHg6/ALA66Y24vf4DpdPfyKPG/ookAH1oq5dckb55zaAiN8jv6rCj7Zb8H1g4fNfqzqC5/LdigCtuqZgOhEizGhCZqKBa2N9iHPq25R9UGuZmHIyWXHq+Cuo6AKZPHDNmEfFkWKn6lQN437up3szJc6gNn65vFUyf6pCFkE6geX6nOyMZ1qgcr+n1VOTkCtFrZ1XqzSVHUJlL4slewwtEkTGc0DeBdocm+RWcbezhasucq//KINyl8qRF5jQoGl5UaVaXzpfyOj1shMAA81xpFIqwYInw2m4UoYB9NUjH0r50cp24/jvh+Um/vJxFTY52+THGxNQpUywXATD2T+jhV52dl+j/sBFoa4ynSzxb0NadYzxWIFem7U/UXrUJYQ9GiLJ7hrC7Qlbtf584S4gh3pSQxx7OHKd5pogEDpGEp/FOpKovw/OM/HGMrXB6EdOISmDk/D4+S13QqLlk98BJID/QJMD/aj3glgcjtYNO9fb/r9g/CAdh2qGLfAfwUKsdkLROGMsU6XwrmIf4Ln999NUvccGJoyfpLlDMRSO7m17F0jUB35KVeZ1F/ZnqXYf3JH5spz5zU3wBaAeixYXlJamCaCJgDmjGXl+3YgROeOCSe4P0y0oYAi18ohq8j0BtMVMWwVJSdf65PHU8YfjZwFQp9eFa8y4FdG30SmJJ/zyeZltn94GqqGIewWghO8KCD2kdNT8qWCGlWid+2Q5I3NfqbHzat6uELPNEc9ynUv2mb+8gap5oLrQwLhegV7o7Y9wE/lKi71Ctz3DRYe2007JlGCpvX7u1MU+dIM92/O5ELRfwal3sAOTdbmkbVCN+TLkNWpFmHOUkXeYbefo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4758.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39850400004)(5660300002)(8676002)(83380400001)(66476007)(4326008)(66556008)(6916009)(66946007)(316002)(7416002)(44832011)(2906002)(8936002)(38350700002)(38100700002)(86362001)(36756003)(31696002)(478600001)(6486002)(26005)(41300700001)(6506007)(54906003)(6512007)(6666004)(53546011)(2616005)(52116002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3VJNUJaUGRHU25EUE5vZDYzMGx3ejFPd3d5bGJ4UFZaUTdFWStkN0V4WlE0?=
 =?utf-8?B?cm9JU0VqQU9XaElUdWxPN3prR1o4dTlEbDdSNDVOaXNwdFRZcENXTndPY2RW?=
 =?utf-8?B?Y1BPQU5Gelg1QkdYRTEwa29WdlRONXZOdERZWVh1UG5xNXJIRHI4b2RlNzJs?=
 =?utf-8?B?OWJpYUN4UjBkRVNCMXh0UnFKRnRsS3JvKzZZMnpnOVhNbk9lclZaNjE1ZTlZ?=
 =?utf-8?B?ZEtPU3phMXl2RW1sak1lMEJFSmpZUFdpZjJhaWtjbkVqOGV5YlpQb3NiWTIw?=
 =?utf-8?B?dlpnVTZ5R0U1SzdXUk9aTFhhNWtmQ2pHcWo0TzR5MDRmMTRqeHM0elFxQ1Bp?=
 =?utf-8?B?WnJOUWo0MHNVYzBTenlDZmFWUS9xY2sveHU0NjhQMkNyTmljTzE3T0lRQVVC?=
 =?utf-8?B?dU9qKzFpOVZxRWRMQWtHcnVwQ1JQVFIxQmtmVzA4V1BJMGRhckY0L0JGUzAw?=
 =?utf-8?B?UlBpWXFPN2h2TTdsV0pOa1Exd3hvdlpzTDlxQXhoMllGVFROVjZYZjdYcFZI?=
 =?utf-8?B?bHpkZGx5a1VtYWdiZ3lJL0o3Z0RZWGdtcTJQV2NNQU5JNGltREtaMXVJSExw?=
 =?utf-8?B?Z3RwQjgzRmtnLzZ5VXZZN2ZhNHV0Y21FUWZYZ3lMQzA2VmM3TnN3OGxzaW1B?=
 =?utf-8?B?KzNRa2dNK2JBMTQxVjNIbmR0VHJzVnNqSm9pcDVKcno5eXFQZ0o0aXpnYmhl?=
 =?utf-8?B?bVcvc016VVpsb1I1M2gvaTY3RWtLcVRmQVhFZkNEYTByNDl5NSt0N29RaHE0?=
 =?utf-8?B?MHRCdHNjTWxMd0dqZ1lybEJEYjAyWFBFTFdxc1NKU1pMSzVDZlBRbjlWRUtN?=
 =?utf-8?B?SlBPbXRjK1prSUwvamQ1SlY3Wk9PeUQ3VjNlTk90MGk5VDBsTC9wYnp6K1p0?=
 =?utf-8?B?TE8zUi9SbkhyazJmaE0yb3FZTmtnTFJVSnFXeTNDejl6a3FiZjJ0alU2cWtZ?=
 =?utf-8?B?dVlWOUVBaDB2Z0R6eXR6SlJ1SCtqRGJtZVNCV3YvdXdkRnhaT2R6dm9oRi8x?=
 =?utf-8?B?QVFtcCtJN2FsSkVmU0VudVFsaVgzcFJuMW03dFhPSndjY2cvcC9rYlN4eHYy?=
 =?utf-8?B?R0djcHMxbHZyaExQd3BSZVhMTkZQT2lnUERjaFlUYUViRDRDcnQ1QVUwSjdC?=
 =?utf-8?B?Qkw4UTZLakRFK2VpMHpSNnpjamZ5M1lkMyszVnBMVmdpRHZmUFdYRzl2Z2tj?=
 =?utf-8?B?SDdYQkIzZDU1SGNUYk1nQzczR0dEc0h0bGNEVzQ0ZC9IeDQ0WjB0aWd5cGRT?=
 =?utf-8?B?MVZLM2x4Z1licVpJOFlFUXZTdlpnaXVNeXBXbWVjN3dkL1Bzd1VZQnJsdGtG?=
 =?utf-8?B?WXhQL1ptemRSQ1pheFNOYkwyallIRHFTUExnZk52Y2dibFVKMGVxVUpReHVQ?=
 =?utf-8?B?STVwZVV5b3BjMEN5czNZa1l3dENORENJUjZnLzhqaExnbDd3cDhNeUVZV1pS?=
 =?utf-8?B?L255OEUySGVZWFRQV1ZTY1ZsKzF0QVRNb2d5UWZzcE94Ni9sOGU2OU9XdVRM?=
 =?utf-8?B?bEJDbzNudmVSSGkzeFFwQWErSHExVmpXdHhiUFE3VzJCZnpqUGpPcGt5WFVD?=
 =?utf-8?B?UCs3SlhINWdYb1lmOXoxOW9Ibm1UZlN3ZGduWVpRM2R3TEE1eWxFQ3hRbXo4?=
 =?utf-8?B?b2dhREpoWUlSaVVGdXZ3dWIwWlBxSjRSQXI1Q01IOTcvdUtSUkpjNmpBLzY3?=
 =?utf-8?B?aXBaaXQ3MkQyM3VJNElOTzJMWG5RTFpWMkhBNzRDUit5ME9UUTFndFNnN3Nt?=
 =?utf-8?B?a29RSkwyVEppMjVXUWE5STlWMXFLWCt6Q252ejZzNEI2QUYrYklPUkI4NHhh?=
 =?utf-8?B?NFU5TjRPdEhQMjgzc0NUSzRJNGZVbFRLSlpjWG1DaXJnSDBQWkY0NTA2SnU3?=
 =?utf-8?B?Zk5wZzB5RTRpTkMzMzg1Mkl5YU1oWi9MM0I2cVdMRWdTOEpVazR0THFCeHlI?=
 =?utf-8?B?V0hiRGdUb2JTWU5RVkluajNxS2k3NlFkQmVCL1BMRGNybHNZWUQxL3plWUx1?=
 =?utf-8?B?RlF6allpMXAwZ0lHaTNJUEEvY0FFK1FPT2xkcTFCc2FyTEZ6UXRnWnNFSGdR?=
 =?utf-8?B?N3ZWampTUjNWMWhpQVdsczJDbWt4M1J1WmhlTWVCVWZObDlERHVPS2dacGdI?=
 =?utf-8?B?UXdFZEg3bVZFNi9PMHcxbVVoTVRpRU9QRzlqYlRHYjdoWW04cjY3K0lFaXBj?=
 =?utf-8?Q?56erYFejgVAHOo6Wc/6RXS8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2911d5b5-d2da-4f2d-5041-08da7aa4f681
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4758.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 07:50:15.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpFC02PVfGx1yB8JU2OW0ZMTC08QVHdNZdQsJvWdd6KVfbdJlIBEPZKPTZ/KT8T/eNjKWCC4Z9fo1l+V6Z2zFNUyMU/RcF7xeZ2ojEKlUcG8feaABNRamiNrDlPoDUlx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 10.08.22 9:05, Michael S. Tsirkin wrote:
> On Wed, Aug 10, 2022 at 08:54:52AM +0300, Alexander Atanasov wrote:
>> On 9.08.22 13:32, Michael S. Tsirkin wrote:
>>> On Tue, Aug 09, 2022 at 12:49:32PM +0300, Alexander Atanasov wrote:
>>>> @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>>    		    global_zone_page_state(NR_FREE_CMA_PAGES));
>>>>    #endif
>>>> +#ifdef CONFIG_MEMORY_BALLOON
>>>> +	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
>>>> +	if (inflated_kb >= 0)
>>>> +		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
>>>> +	else
>>>> +		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
>>>> +#endif
>>>> +
>>>>    	hugetlb_report_meminfo(m);
>>>>    	arch_report_meminfo(m);
>>>
>>>
>>> This seems too baroque for my taste.
>>> Why not just have two counters for the two pruposes?
>>
>> I agree it is not good but it reflects the current situation.
>> Dirvers account in only one way - either used or total - which i don't like.
>> So to save space and to avoid the possibility that some driver starts to use
>> both at the same time. I suggest to be only one value.
> 
> I don't see what would be wrong if some driver used both
> at some point.

If you don't see what's wrong with using both, i might as well add
Cached and Buffers - next hypervisor might want to use them or any other 
by its discretion leaving the fun to figure it out to the userspace?

Single definitive value is much better and clear from user prespective 
and meminfo is exactly for the users.

If a driver for some wierd reason needs to do both it is a whole new 
topic that i don't like to go into. Good news is that currently no such 
driver exists.

> 
>>
>>> And is there any value in having this atomic?
>>> We want a consistent value but just READ_ONCE seems sufficient ...
>>
>> I do not see this as only a value that is going to be displayed.
>> I tried to be defensive here and to avoid premature optimization.
>> One possible scenario is OOM killer(using the value) vs balloon deflate on
>> oom will need it. But any other user of that value will likely need it
>> atomic too. Drivers use spin_locks for calculations they might find a way to
>> reduce the spin lock usage and use the atomic.
>> While making it a long could only bring bugs without benefits.
>> It is not on a fast path too so i prefer to be safe.
> 
> Well we do not normally spread atomics around just because we
> can, it does not magically make the code safe.
> If this needs atomics we need to document why.

Of course it does not. In one of your comments to my other patches you 
said you do not like patches that add one line then remove it in the 
next patch. To avoid that i put an atomic - if at one point it is clear 
it is not required i would be happy to change it but it is more likely 
to be need than not. So i will probably have to document it instead.

At this point the decision if it should be or should not be in the 
meminfo is more important - if general opinion is positive i will 
address the technical details.

-- 
Regards,
Alexander Atanasov

