Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC36073C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJUJRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJUJRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:17:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31802565D1;
        Fri, 21 Oct 2022 02:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKWb6hkqkaZkUKMGFsOaDzL8b+1p8LlFw8vQr+21SMT603NyXReWvpd5WekWT15bN45HFnBRA6gxBwF5bSdsEiAi043MfYlTSgZG2Q8RxtTLC9L6ApwZqzHMzCcTPM54ZqabsqIjqI8GlF/Z/p3e49udk+NmOiqJFMuy4ovZbYVSeL+aBN+STbVVtq0+MbFrsiSHUaWDxcMNsmIw8oWmEEK/9o50dIPfruQCzt6k/ckTa2CZ3l5udLXy3zz2miD2zf3MmW/XsMSuZbAt7ObThOgzIoJ7ZpB1ShEGtBy17wlSwuomEd+f13XfTD6hN5ckX+uTM9fs6pXSnhmyGc34aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM0B/kMFr+I6bnO+nGQL1HBgyGVL47kz2RGM5zJKax4=;
 b=GMZRVcV+vFBSJ+pZC7PkPk5PuU9bc4WMHhwAUS4svii/49L8KEiNABFpWTk+ssa2MKuuGeMjDGuHpRBOSizbHQyExxMFYlWNy+sapukMXZmn4K/Ytzl3piivUrUuaSo8HYu+kpNfCyA79ZplLHFEQmISmVQ4nkLE+WxIJeMoR5arYGKu6c+S52aiHSK556jHJZjpnVhCJTlucbXn0TFuX0m4G1HyGFblVr4UIOS8Mvb4TglCXbPg5cKjLRtIVrbVZJ3hTxpLGKb9czVMl3tsohRp1oi7YnLLrHAoc+z81cp3zIMD7GHVx2JJj8Jsdf6OrW5ifOAKcbXJ3y98m9xzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM0B/kMFr+I6bnO+nGQL1HBgyGVL47kz2RGM5zJKax4=;
 b=UoO4BLY3fj1cD78MpJAa/XQBZe6uIuieNFrIxKyAtcAGq29obUqr4L3rku9C/VDQH6ZkWDM5y+qCHvRzU1vjS1fTmd1vU2J0FIEt4AtgVI0CBZwxr6kDni+VVs5wRDWJ+hE1rvo6KksosVYBO1TD8gVYVh0xGBvP12W38hOe0QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH7PR19MB6659.namprd19.prod.outlook.com (2603:10b6:510:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 09:17:04 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::c261:9a38:3a92:d1d1]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::c261:9a38:3a92:d1d1%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 09:17:04 +0000
Message-ID: <25693837-04a0-c81f-e46b-b39cfde9bb5b@ddn.com>
Date:   Fri, 21 Oct 2022 11:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: de-CH
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
 <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
 <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
 <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
 <CAJfpegt6QBZK68aXMg2OA=id3fMjBPZHTr6AqkKVqzV3eA_4Fw@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegt6QBZK68aXMg2OA=id3fMjBPZHTr6AqkKVqzV3eA_4Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|PH7PR19MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6042b221-6df6-4ea7-5197-08dab34504d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZIwIzFdohfNulk+R6aErqwuHdT64fQHzPtgaBTZzX+MmQuTc43GrH9K2fJiQEn4qS+22bYOvaWtKjTiFQR5K1ZrInX1Fkd1eHsdBc3Curr4B1r3ZLoirRmA67PfdTNF4vir28TU4l3NmXpi+ms1XvpaWF2ADTZfAEOlrJkCsttYXVyd5PRnaHeSLsYDQDNwjjcS9MI4wbaOlmyePmTjwkC2MyO7hTASxHoCoQ81dC/xob5iMxw7W55/WRU2VyJedfeXA4kvorB+7k36Fjf+aY9egV36aXs8ABRl3rovu+uRC5eZhhdCNDL1pGxv8MaG7GA0tizHDfoi57s177Kc2f9AR8i6c8+ie7smeQfoenTFS2c9iIC82x5mo+IPzC7SSEHVKJmtwfpFG8nD+4k7X401wLlnQqCd7KMwfN7b0DhvQuPrZaoguG7gpMtaQoCHnPplssUS5MKblJtDvD8HKARh755z/nYD+mH8aJOev8Of0/dK6Fn93k+Xw3Y3mjDAiGzNAqFSdSfsCsBrJ9WhdUtlQrXNz3pViqH38cB6zZXca6VuNuhktW5SChHbNCJWAdPxTnbIgu9j9TjvP7aA4h8Yzwi9FDA42nfkZdLdmOkIYkLowVAwEB9qiJsVNP884vsuadAvA0Y5DYg8HbuVuAoD6YA8Q9yAMzxL5lxaXehh9I+pgarvu9vX9MA+aD1yY7jnD9KnobH2fORDuBH1hfmB2ONwPiEh9BUHPJZjGOK6PlAQtl9gRup0SfiSHFXQlh6zxRaooSzsowm8N5S8TTFKpOlsT/WGSDOeKQjhZMMy8Mj04rEZn1b0zjtm63Cn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(31686004)(966005)(6486002)(38100700002)(8936002)(6666004)(316002)(6916009)(54906003)(86362001)(53546011)(36756003)(83380400001)(41300700001)(31696002)(478600001)(6506007)(2616005)(66946007)(2906002)(186003)(8676002)(4326008)(6512007)(66556008)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wi91dkJ0MHpFK2RlTnUyUFJBaFE1dHBnMEo3YTI1ZWxMMll4RzFLTEo3bmVp?=
 =?utf-8?B?STBjc0VLbW9qRmRuTTlrN3M4ZXZjd1ZGZnNHbTB5d29pdkM5Z1ZsVlVLT0ly?=
 =?utf-8?B?Z00rVDdKcW1jdnFJYlFvZFl5MGxQcWpock51RERHWmQvNmMyMlJqMFNuN0Yx?=
 =?utf-8?B?UFkvaktaZnBhTVJMV0sxRTQxTnZnS29pcWd4WG5QVEQxLyt1aUtWQjdCOW9u?=
 =?utf-8?B?VmdXZi9sMk1aQ0VtUDNXQzVHaElYZlJMcmcrNDdvVklzZmJLVmtmVDVhVGo0?=
 =?utf-8?B?NEh2QSt4VlB6cWVEUm5PS1lRblZRUllDdnJhWmJnRGRVa2w3TW9XRXF1ZVBz?=
 =?utf-8?B?L3RjaHdPbS9XSFJIb2Q1eHJyWWxnYS9KSVdzLy9pdDEzSXU0cFpvWTAzVlVn?=
 =?utf-8?B?dmZZZ0dmd0Fkd1R0emUzaWVNMjBCV2ZZYWFscWZ1bHdpVjFiM1IwM3NCTlZx?=
 =?utf-8?B?TDVpMFplNEJnamd5V1hjU1ZSUkZJdW5BeVZ4ZEo5ZDA2MXhGd0xEbCtGVnp2?=
 =?utf-8?B?OG9Wd0NsZlV6eHJPaVRXU0Zjck5HZkVtUTc0YlBCNnJwYkhqVDlwellCd0l3?=
 =?utf-8?B?cGowaU9pSVAxUXdGakVsdDFrNjQ1U3BZaUJMWFJQNnFLNjU2NEpOeEpSL1pr?=
 =?utf-8?B?bUR2MEpac0tLNmVnSENtZGRyZFZaMmQ1N2RDbjk3ZWRIM3h6MU9tUis1ZTA5?=
 =?utf-8?B?RnFQMDd1ekRJOGRlaDh5VjJMT3crL0tDRzFlZEZGekc1U1pTYzAyV0o2cUtN?=
 =?utf-8?B?OHl5YjkyNzNJd3UwT1BkN0JFY05hYlR4SXoxSDMvRnZ1MGhaSUEyOFk5ZHJm?=
 =?utf-8?B?UHVKR1dRQkVnNDhhOHliMkM5THAxNUlQbXFhcVdVbE9wcVFDODRGSXRCcDUz?=
 =?utf-8?B?WG85dUplU0pHZ0lVSldIUVQxK3FnekVRV2FBcmsrdXBZcFlsNGpkMFVYR0RU?=
 =?utf-8?B?NnIvMWhTQlNSSVA1WEoxL2J3STRZNGVMMzYwbnEzdWR5TDBybzBmdy85OVpK?=
 =?utf-8?B?U3hQK1FJc2ZHM2xJYVU3M0tYYlQ2Mkp2M0xQeUN5bzlPQmpxRU1Vdm55eVIy?=
 =?utf-8?B?UEhqeUZhZlJURndGRjVQL1ltaGJDcllDekx3SW9FOFBqS3FuRUhuSkR5UDVE?=
 =?utf-8?B?S2NFRFFYck9NNDlmWmVvbS9ucGhjUXprQ2VzN2ppNnhYeEhMRDNMRTA0bzNx?=
 =?utf-8?B?NUpFM213dTBTdlFqcGYvY3VxaWVNc0FvaHlnWi9JeCtLanVlaHNrZFRhRkF3?=
 =?utf-8?B?MCtDNnF3OFMrS1EwNUIyZElHNXNZbUdRS3k5TTBqMzJnMVdEVk1TN2l5Nk1w?=
 =?utf-8?B?MEQ4ZUtXNGhra2J1UGlTZlpKWjhZZGNCd0p4S1RONE5pdVNLOUM4SXFGS3Vo?=
 =?utf-8?B?RHZ1UXRmSlJyRVQvWVdxNldQbmdacXhUZURhdmk4dmlFcnZuVEdDNjRxdERh?=
 =?utf-8?B?dzhycGlzZ2lzcXhSb2ZuM0tPWkkvQURNaXJNb1ViTG9VbjZ5U2pIK2JlSUlv?=
 =?utf-8?B?a3JGWWhjN3pSU0I3VThtb2g5Z3JMeGNrTjh0LzViM0IyenY3WE9Hdmk5MWFh?=
 =?utf-8?B?T05NMWpoSHBjOHdGdWM2YlpSZjBHS21Ba3ova1BsMXFKS2MzcnJHUjFHRENj?=
 =?utf-8?B?UkIxb1NqOW9ha0xPNUNZWnArVGJ0d2dUUWo5d0o1Rm91aFF2dUdHQzZrZXNo?=
 =?utf-8?B?NGVWQ2dTcXhzbnBJRGtrR1g3ZUZDMVY2S1l0dTJ3dXJGQ0g0YmRscVoyZDFR?=
 =?utf-8?B?N2NvYXlrR3JGNDVVWDZFN0kzMnA2NnZkUTAySkoyMExZQ1YzcXorZXM1SkRj?=
 =?utf-8?B?STlRdVJCZjVSVVUxRm9WUWREbzhpaTkvTWE5S2oraWN5ZG9lTVE3UXl0KzZ6?=
 =?utf-8?B?a3Y0cFl1Q0RjdTRaMS8xcnFlanRXNStoekMvdG5nUGhsM3ZVR0U1aDJ4UTZ4?=
 =?utf-8?B?dGpwOXlZTGx6cE5GTEhLZlhBbFpDM0lhVWNjV3ZOdU5NNGJaOWtneGhLVUZp?=
 =?utf-8?B?YnBXc2RnODNBb1E0alRFMWYrbFZNbWJjK1hFK09CdXV0NitnZHdsdFBPVzN4?=
 =?utf-8?B?YkQ2djZXeTZnMmNZaUpMem1uZmcrOU1pUm9LdlNXMFVjNnN2aVkvaDh0YW9B?=
 =?utf-8?B?NmloRHF5bVZ3TUxMU2k1Q3YvU1VtWWRFNUREdW52aVh4bVVtSmFETU1kMU0r?=
 =?utf-8?Q?TFRRgnZje2uqEMZa+KlKAuhZXqMDGJu7cjkxC3rLQD6L?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6042b221-6df6-4ea7-5197-08dab34504d9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 09:17:04.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FFMJomIs1GgrFxPuWD/diqvW6Ssbv3wczy4XEJNXewSdj9IHpm3fwvpXKeD7O6YsO33LBXz7EaMsaS4c2PjqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/21/22 08:57, Miklos Szeredi wrote:
> On Tue, 13 Sept 2022 at 10:44, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>>
>>
>> On 6/17/22 14:43, Miklos Szeredi wrote:
>>> On Fri, 17 Jun 2022 at 11:25, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Hi Miklos,
>>>>
>>>> On 6/17/22 09:36, Miklos Szeredi wrote:
>>>>> On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>>>>>
>>>>>> This patch relaxes the exclusive lock for direct non-extending writes
>>>>>> only. File size extending writes might not need the lock either,
>>>>>> but we are not entirely sure if there is a risk to introduce any
>>>>>> kind of regression. Furthermore, benchmarking with fio does not
>>>>>> show a difference between patch versions that take on file size
>>>>>> extension a) an exclusive lock and b) a shared lock.
>>>>>
>>>>> I'm okay with this, but ISTR Bernd noted a real-life scenario where
>>>>> this is not sufficient.  Maybe that should be mentioned in the patch
>>>>> header?
>>>>
>>>>
>>>> the above comment is actually directly from me.
>>>>
>>>> We didn't check if fio extends the file before the runs, but even if it
>>>> would, my current thinking is that before we serialized n-threads, now
>>>> we have an alternation of
>>>>           - "parallel n-1 threads running" + 1 waiting thread
>>>>           - "blocked  n-1 threads" + 1 running
>>>>
>>>> I think if we will come back anyway, if we should continue to see slow
>>>> IO with MPIIO. Right now we want to get our patches merged first and
>>>> then will create an updated module for RHEL8 (+derivatives) customers.
>>>> Our benchmark machines are also running plain RHEL8 kernels - without
>>>> back porting the modules first we don' know yet what we will be the
>>>> actual impact to things like io500.
>>>>
>>>> Shall we still extend the commit message or are we good to go?
>>>
>>> Well, it would be nice to see the real workload on the backported
>>> patch.   Not just because it would tell us if this makes sense in the
>>> first place, but also to have additional testing.
>>
>>
>> Sorry for the delay, Dharmendra and me got busy with other tasks and
>> Horst (in CC) took over the patches and did the MPIIO benchmarks on 5.19.
>>
>> Results with https://github.com/dchirikov/mpiio.git
>>
>>                  unpatched    patched      patched
>>                  (extending) (extending)  (non-extending)
>> ----------------------------------------------------------
>>                   MB/s        MB/s            MB/s
>> 2 threads     2275.00      2497.00       5688.00
>> 4 threads     2438.00      2560.00      10240.00
>> 8 threads     2925.00      3792.00      25600.00
>> 16 threads    3792.00     10240.00      20480.00
>>
>>
>> (Patched-nonextending is a manual operation on the file to extend the
>> size, mpiio does not support that natively, as far as I know.)
>>
>>
>>
>> Results with IOR (HPC quasi standard benchmark)
>>
>> ior -w -E -k -o /tmp/test/home/hbi/test/test.1 -a mpiio -s 1280 -b 8m -t 8m
>>
>>
>>                  unpatched       patched
>>                  (extending)     (extending)
>> -------------------------------------------
>>                     MB/s           MB/s
>> 2 threads       2086.10         2027.76
>> 4 threads       1858.94         2132.73
>> 8 threads       1792.68         4609.05
>> 16 threads      1786.48         8627.96
>>
>>
>> (IOR does not allow manual file extension, without changing its code.)
>>
>> We can see that patched non-extending gives the best results, as
>> Dharmendra has already posted before, but results are still
>> much better with the patches in extending mode. My assumption is here
>> instead serializing N-writers, there is an alternative
>> run of
>>          - 1 thread extending, N-1 waiting
>>          - N-1 writing, 1 thread waiting
>> in the patched version.
>>
> 
> Okay, thanks for the heads up.
> 
> I queued the patch up for v6.2
> 

Thank you!
