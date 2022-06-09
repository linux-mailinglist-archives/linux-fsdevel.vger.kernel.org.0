Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D954508D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiFIPTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiFIPT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:19:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F24AE04;
        Thu,  9 Jun 2022 08:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMFuzyM+3cZnhV+LPN7Rq0gBQDA2Hp9zpMqCI/TozWTsoVBYWt2gHbE/6CEoiaKQwpLeulM2jKDHE+oOEbCR1heX/j+rN6Lgy8CDB0/9HviWt8Sy+z0RNYGcIvQQrPOMDLHKLRGKet+82et2u4AWW7d6CWCXKDcP+8nK9XrCIJulAY4rKlXQ2mSmEVJ9Nqo1f/lK8/NmnhsFdqcM7QOPvvK3KpIfbH3ThxMiSBoZym0vMtg43LpfBPvXHyfzBqitj1+2HzBGVwzTx9g7+8tXlts8UyfwLt+CaHsyM3e0yvx6VF7B1sAupTPnrofgsaWlmn77MPR4PEzWKz2gMx9H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCCBpwtBHvQFKcINMNKQ6wDAoldeLoGv35z6/xPC/F4=;
 b=FNhMrKR7fE7xoi7STnihsNG1Kl/Ai5Q37Vf0kKbMqf6oCLL1dBJxUelF9PfUIHbCwdkmTsIuR1ebNjpO/WPRmR39a4mlnQCn6ZImALciXRNcr0Q5P90Kthia4bsEMAggw4GL378Mo0mFxC7ySDTqZGMFwntiQ0Q0Db1XLhm2tDirSlHKQbnqI17qOli4CsBB1lOS6QWoblSF5KJhUFzmfnlvjY14hJOGNVyzFdSwcWKFtqW0M0FhrS5FU3+HDKDP6ADxOamJUzbud+ycHtbjsGhoRTVznYVdZqOq+7dsnHFCRZmowg+LJS9oVuEnLzWolXLUhK2+clYOmuA7tT9I3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCCBpwtBHvQFKcINMNKQ6wDAoldeLoGv35z6/xPC/F4=;
 b=WEnvhZBKhwY+JW5z2+5ttJtdWvPvfqcq82OMKnuI+6JWlUR8VIECEz5oTZGQH4nTzUYwPHDAKyFR/BEAd2RyvgLeq13B9bkLC61CnaVB0vaqK5mVpRaZsAOqovMZxNIWgGvLfcBTIpRfmh3G3RF9hlluDFWEjsngvcpc/N5Ba3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 15:19:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 15:19:25 +0000
Message-ID: <d841c1ab-c0d1-5130-11fc-c8ea04cc9511@amd.com>
Date:   Thu, 9 Jun 2022 11:19:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664f4fe9-e0ab-490f-fe1e-08da4a2b705b
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5757F723690A4BD912C0D30C92A79@PH7PR12MB5757.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9OikCJP1mEGvyS392X+biLkMVTasCerdApDeXnmqQXPX3hy3ZID0JI1nltP8vCFdqK30T4sFWo8vWMMytrZzSUOqPC/csy1bJjXWoPPhnP++vVd/iwqfuvrZpQKXwvJy0phqPhvJaAcjxkTGaLuG+LFV2hfnzYwIdi5VMQMlDa5pt6mTmAGeF63pVvlu2ngihzXrk6loyG1ivuQ3JJKbxU5n1koqAvtA5llFz6obbWv8GSXWsBKXOQd0g7ubV7IuomO2Vq7QtY5P4g3l1jk1++dRz0iYmL+ObUt5MPcDMI4RtNKj9jSc2pWbR4MalgNjDE7PleBvjs+Rd6x6Uti1UTqpXQXWZt45qAQ2UjnCrl96IiaQwK6ns6NTT/Su85hhmUfqBPTZiQm0YkJ26sbomNmXBUdGYVKM/NiwQmaKxGM3JleI3p6q8bjKd9P0fMihYFoHBRzLUqDiXotMv5+uUriZx62P+JklvZQhPlepozO3dFtRFhl1bocODiSFjfVXZmvg4QhIxoxhl/HH/eZ/QSfvooIDqbKr3/IdXoBSke9Ayj6GSoop2HkFEfR5y4FVLGfMpZSsr0M/ynMpyVj3JWVYYAhpNLC76ZGxo7Uc+WpxUWG6npAcPSuvYH+ps96Ue8nfHpCLsglOo6MeGMjpVpZz1dn94QBA3mXjGLjZB2PAY7VZv+StId9CqTYH59BCATYpu9DVUpDltOX2pOZle8AxJmdD88qOBS9aDNgo7gN5JXF1w6K/xzY1gvIZLmP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(66574015)(6506007)(66556008)(8676002)(66476007)(5660300002)(44832011)(31686004)(7416002)(38100700002)(66946007)(4326008)(186003)(8936002)(36756003)(2616005)(6486002)(31696002)(2906002)(316002)(83380400001)(6512007)(508600001)(86362001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1rMFZKajZHNFcyeFpCMnF6VGNkMnUxMnJ0Ymcwdmlqb3JJaCtlamJHZUFx?=
 =?utf-8?B?eVR6a3dScDJ2cmpNNHlhMmlDUkdsWHFkZXpJS0V0aWd3bmNVZXAvODdRL0ZS?=
 =?utf-8?B?M0xvdmFHZ3kzaVdhZDFDVHdzd1ArcHVQWk10a3JUR2VBRFJqTWZ5Qit6Nlhv?=
 =?utf-8?B?NEJlTUR0cURZWllaM2Nkc1VaNm5TTVR5YVBFN1V4dnRhS0pvZE96YklUOHAx?=
 =?utf-8?B?YmhQUE1wZWhMTlBuODlmY092Y3dhN1J1dTU3azF6bUlNL3RXdFkwRzhlam96?=
 =?utf-8?B?VEUzRGhvWHB4d2ZJS0JuRHQ4WWhEWXFkTnphbVRNSHZORjdocWZ5bCs1RXVI?=
 =?utf-8?B?dGgzSmExZjVmVGlnT1pTemNZei8rY2JJWWFtd1JTT2YrZitlRDZRdjM1aDJn?=
 =?utf-8?B?TUcxUWVLbGI3d1ZFRU5QSnNFQkp6S0hqaE84aHFIWHVXakdHa3lWMXVFSHJN?=
 =?utf-8?B?UXdrV1pIVEJFcGpHYTB2MmlESk9FVDB5Lzd2S0tWZ3BuSXVxcVpRSXdsZzRm?=
 =?utf-8?B?ZDM2QXVzMkhmQ3FNNDM4Q2FISEQ0V1VSVi9wVDNHSERkVVAxcHJMN2t3UHdz?=
 =?utf-8?B?V2J6WElCVnY4SGZ2M0pSK3kvUnM4cFkwcUp3c013VU1CZmVRUnJsd0cxKzJO?=
 =?utf-8?B?Z1k5Q1ZmN3Q2dEFQd29VWnBYMTZnZENObjMzcjVJUThJSUhPeEYrRnFiM1JD?=
 =?utf-8?B?VWJ2MEFsVFlkWlpOQUJBZnFOREY4RitMcjVIK2pGSURJSnJQUnhLTzh3N2Ns?=
 =?utf-8?B?bkhIYzk4UEg5VFEwYnhrNE13MFUwNHNGM09Qemp5Ty9TZTd0ZzBRR2hkRGlz?=
 =?utf-8?B?QkdsQkxPWkFGY091bFFGdUdKNHFVL2k1dld0elJWR25oM0hNWU5pbkZpaGdL?=
 =?utf-8?B?OEhmWHV5ekFYdkEzRkd0aVBvMEgrVDViMTJuY05LZkZsZ3RJRzN0N2JObVNs?=
 =?utf-8?B?QU9vSGNkaGFWWDVvcUtPUHBrUnIwYVRUTGQ5amxEanhiZEFkWUgzOGxnbkxS?=
 =?utf-8?B?MFEyZkJPa28ycHVqUjhWUkYrNUlnQkNJdGU3WHVDSHZ6RElFZnRTaWZtc0Va?=
 =?utf-8?B?RWp3K3lXTytQekZMUVlPcERpbElnR2dVMHBsaFdQcWVJNUJKSHo0Z1RqQkRR?=
 =?utf-8?B?TDVQRXNtRVptbVZRa1ZHdDlqeStXbXlVSmpQSFkwZDcwcU43VEx5VUZQbmo3?=
 =?utf-8?B?R0RnV0cveG1oNXNmbXk5NjZ1cVFxcFNQczBKL1EzZWpEelNaOEZrUDFwb2ZX?=
 =?utf-8?B?cmxEVkRsaW9PaVpGVHBERDlzR3JMOHhDdi9XVkNKM2lBWDZrYkhjWWJ2NUZz?=
 =?utf-8?B?Z2lsTU1FUktEak1YSmRwalRxWWhoZGc2WmJqWlZ0NERGcWFaSjJuMTlnQWhJ?=
 =?utf-8?B?TXZqWnZxeEszMHY4aktNSkFSa21na2I4M0VDYTVEUXZmRVFaWnZhQ3QwTFRC?=
 =?utf-8?B?VHdxWG9JLzQ0U2hld0NjMngzVnI5MlFVcXc3dlFtMjh0VGUyQXpIZk1menZI?=
 =?utf-8?B?RVpiWEpNTHEyb1N6UDZoYmxKbTNObS9KeFZjWmFxRk9xQVRJWnFOdTRKUXF1?=
 =?utf-8?B?Ymx5ZnR2d2hta3RpdWlRWjVhUGxPY3BuNEU3RkswdTFtbFEvYzkrRTdrejBG?=
 =?utf-8?B?azFSTklGUGJlZUNvUitxclJ0R21Hc0xxRWlZWGNSdmdxeTFyV1NpZkhqWVhW?=
 =?utf-8?B?c2k2Z0xRRDE5L2NKclRCK3g3YWNESzVqR1RmUStSS2FQbG5BejNjbC9QMFVU?=
 =?utf-8?B?YlN5Nk1rdHRsLzdaWEd2ZnFUb0c0VVBiVlRCZDhXblJ5Nzl1WHpldWFwb2FS?=
 =?utf-8?B?bW9ydkc0UnB3QUxFUmFOZnFFY1g5dHNWbkZrQTZhZHFlUFMwV2VzRXdQL2ow?=
 =?utf-8?B?K2ZZM0R6TlliTVB5OW4vZHVzL0dlTUVGa0JlRUpWZ0dTNzAzbTYwNVUrRTND?=
 =?utf-8?B?L0ppVEV1ZEFETFdlY2FLRTBkY0Zsb2xJS1F0NGtPNHVYTjB3UGJHVVdzK1hq?=
 =?utf-8?B?R0llcFlCYzVLZDVFT3VGdE5BNGJuQnNUTWJiSW5QbG0xSzI4S28xdWU0eFg0?=
 =?utf-8?B?cmFJSG5NQ2IwdTdyU0NSdC9vT25ueHJ6ektlUGdmT2RFcTlEZ1U2TFdjT01N?=
 =?utf-8?B?enNKV0pkd2E1a0xKWS9nZEp3bGNuMWFwaG9QcDI1Z0ZxNmUzMVNBSDN0Y3Bs?=
 =?utf-8?B?VjNVRExpS1hCZ0JmanY2d0pIVnZnZU1QMVh1SW1iTzJoZ09xTHJJT3lIWE1D?=
 =?utf-8?B?c3lDMlNIeGRvOFpPQUFSYWZkREZDQ2Vqc2k2d281SlQ1NWhlcFltdlcrQ0xl?=
 =?utf-8?B?RmlpK3lpbWRuNnFBY2FNbFdVNk9ZYjJlbWt4WEFpQnU4ZlZVc1RpQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664f4fe9-e0ab-490f-fe1e-08da4a2b705b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 15:19:25.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlKJqEwT1t1Wfgh/cT4XGkspICWpXoldJF3BowHYX91SjVPODGue8LvgF6Exz2fmRzKWf6kRPYSxSlIiMIPZjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 2022-06-09 um 10:21 schrieb Michal Hocko:
> On Thu 09-06-22 16:10:33, Christian König wrote:
>> Am 09.06.22 um 14:57 schrieb Michal Hocko:
>>> On Thu 09-06-22 14:16:56, Christian König wrote:
>>>> Am 09.06.22 um 11:18 schrieb Michal Hocko:
>>>>> On Tue 31-05-22 11:59:57, Christian König wrote:
>>>>>> This gives the OOM killer an additional hint which processes are
>>>>>> referencing shmem files with potentially no other accounting for them.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> ---
>>>>>>     mm/shmem.c | 6 ++++++
>>>>>>     1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index 4b2fea33158e..a4ad92a16968 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>>>>>>     	return inflated_addr;
>>>>>>     }
>>>>>> +static long shmem_oom_badness(struct file *file)
>>>>>> +{
>>>>>> +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
>>>>>> +}
>>>>> This doesn't really represent the in memory size of the file, does it?
>>>> Well the file could be partially or fully swapped out as anonymous memory or
>>>> the address space only sparse populated, but even then just using the file
>>>> size as OOM badness sounded like the most straightforward approach to me.
>>> It covers hole as well, right?
>> Yes, exactly.
> So let's say I have a huge sparse shmem file. I will get killed because
> the oom_badness of such a file would be large as well...

Would killing processes free shmem files, though? Aren't those 
persistent anyway? In that case, shmem files should not contribute to 
oom_badness at all.

I guess a special case would be files that were removed from the 
filesystem but are still open in some processes.

Regards,
   Felix


>
>>>> What could happen is that the file is also mmaped and we double account.
>>>>
>>>>> Also the memcg oom handling could be considerably skewed if the file was
>>>>> shared between more memcgs.
>>>> Yes, and that's one of the reasons why I didn't touched the memcg by this
>>>> and only affected the classic OOM killer.
>>> oom_badness is for all oom handlers, including memcg. Maybe I have
>>> misread an earlier patch but I do not see anything specific to global
>>> oom handling.
>> As far as I can see the oom_badness() function is only used in
>> oom_kill.c and in procfs to return the oom score. Did I missed
>> something?
> oom_kill.c implements most of the oom killer functionality. Memcg oom
> killing is a part of that. Have a look at select_bad_process.
>
