Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC73F5F6FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiJFVA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJFVA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:00:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16801A7A81;
        Thu,  6 Oct 2022 14:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEmKkzcs6QZ7X6ovzRjp4MVT+FfRl5B2WUJmmXcLy9CVR60tb1N0AcuqNMU0Pqj3qkBKHOVaezgdmayVkGqPxfhUpmtTG0WVQv7F/eXXL8VxxGSNlML9e5u/WPGdIAtIQAvBcqHtC81Rwya7UZizUdyky7orwHGttl9JOhAyMTthHpjS9n0y5TibxywlXsJ229nChwAskf+a3cNaDZ09+mYQSE73aHGYZLDrBIrBW3dF74s2wkUO9jrwo29+yj8hUi6tPtQWKWD4GsRqJz4oyC47lX8XMvdIGdyhf+7tOgv5grL/ggQP9Jsgn3ZEIZNUI66qi+uE7XhE1NvIo3qMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x5AjyarsZzpUt/ZTAy1O/T6yc18gtjzLBO7Yc72/uw=;
 b=Wn/4n10va05nuByaAkfd5ro2SagC7FkT5a21xAC2F3Wnbhg43vu4Ct9TY9g7qPVTrRn/p2Gi0mdDzDHXNHygTazR2L8y3NUZRwE/D1lLM0Gx5PzjUIDxY14FwDDdQHZabGc5lCeDCkc8UufZs3uedWXX5PtFtrczXDUTWx0SEzpmNvexUTc8TUPqBTsBg+Z2Nw2UvSLnbH/p4nDVWjHq3D/U+kahK8CY3mp/JWn1wYB9djglRtibPC8NFbvJcPQeEI+NzwLzkoOpodvPISAlugh+WCBx674wPt1LzdCNjhEvS+UmulQqRTfg+D/VRIpuCi/oZ+jP/wLNpqOJ5NRnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x5AjyarsZzpUt/ZTAy1O/T6yc18gtjzLBO7Yc72/uw=;
 b=lcsu+CJDwjvqZRH1KmiRlD2vwMP7Ow1H3R7IfFBrezeq6Jfb5sQINmb3tUcf2LUZqSnSxJdyJ5yL6ThtirANWJjQfczxuq9HfF2sleVx75lJLzPLD3yTFM7vAnZbbtBRaJ158BrBDgMD5dPG9zqcr1U50cGmKJ/I8DPLRgOXXJL4pzjmXHEpNJEeZREBmkr5X+UlmK5tdSb9tCViziDKIFiYcDTWlwnz0QMV8yLvxzqNtjmaRddAR8yaxN4a8icrCpCEQUxy1oVXa1VdLLftj3UUNvGOh9Wb+O2QsMp7cH6Xg0Sy/lDHWLfMsmn0o0UUBq6qsHKiIFZXVGOOFhvo4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by SA1PR03MB6515.namprd03.prod.outlook.com (2603:10b6:806:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:00:53 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:00:53 +0000
Message-ID: <4d354ca6-75b1-dd91-d33b-b8b4e892b751@bu.edu>
Date:   Thu, 6 Oct 2022 17:00:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 02/10] x86/boot: Load the PT_TLS segment for Unikernel
 configs
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, masahiroy@kernel.org,
        michal.lkml@markovi.net,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-3-aliraza@bu.edu>
 <cecf0a31-8473-47bc-9af6-8a809267c9e6@app.fastmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <cecf0a31-8473-47bc-9af6-8a809267c9e6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:208:a8::22) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|SA1PR03MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 06737f61-63ff-47e6-26e9-08daa7dddb3b
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MzvAzqN2981B3NrpmOrsLirBVDmBlXEooPFZeLjdSTij5YuWDfdxOh5tmRGYiBFFvb2BA0Cv826yNZOL/V3U4LQ4/a7j8w/wWb8c6D7pW8+LyTFDYJ55KvhdVy875bCnij478Ks561+ALDZYLxF6CHs3kgPiKinHdoCKgKAJzypHXBs2RSzK8Vat/0z1mjXLfg+STm97bP5gnnozlHVateAG1b/eKl1cgUazV7lXh9NDoJ91ebD5tScbgS1Ucth2HNKBbD29KERFhRCWEq+J3xeqb8YAoFMwScyCXeLskK0QvLMgeRt/0fG74AjoRRrVHGnD+mlmwBNgMYZLU0+6mb/f3cuWEToG8lJbvVkpl1YENvu+LyX4TKpJPYFrx9PK6jRL0yJphRTcYiA6JSaMaDmgOQYemllNVtA7vm4Gp0ENNGHOHBr1B6Xd9oe91PCiFWfeMM4WdMO/LhHeKrZmD7t5q47aiaeXfTu/6YYP2ANLgtgbFANoxNem/2i5Ma5Nxq60R5tgCj3fGJbywCOrw58ixL1TMKkfPjw/HPgmV6yWSgQ0Wgw7RtIQZ2QYxxdja1h1h1DIlY0imm/A9B/amp8Ff6AVX2AS7pEfSZ9nhJzWwUeyMKQ9sTy7nJNBQFEhMnZtreT0GzuNuBBLNAUroODJE0H+X0G6GcFqKKo1xTNJbJbIfjGLP+v6gG2X/BDDG1lPAdZz1+yfocutEajqxQEmRAzPIe0TrK5s6SCcSlGBgi1OH9ZxvX2TNChF99eZjO7oATXcjNMGoZLGk0vKnitMA2/NRr3xCpZtgmey60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(2906002)(5660300002)(7406005)(7416002)(8936002)(31686004)(41300700001)(53546011)(316002)(36756003)(110136005)(54906003)(31696002)(38100700002)(41320700001)(6506007)(6486002)(66556008)(8676002)(66476007)(4326008)(66946007)(478600001)(86362001)(786003)(26005)(2616005)(6512007)(186003)(75432002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9CN1VXTXhoT2xtempHL2ZlWFdicTZONXh6L1VnM2ZadUVDeEtSRWRuUkhy?=
 =?utf-8?B?ODNhSzNCWWxjc3oyVWZTTjlOeDJuMDVOVEx3UWRGU0RkUlFaMGlQd3Y3OGI5?=
 =?utf-8?B?VVg3NGtMeWJYQXUwNXo3THFKY3YwVXdmc244ZGFpMlVyblA3ZnFxcnlma09o?=
 =?utf-8?B?ZFp5UEg5dlFCU09wd0JTZXhwMUpxYWx1R3d6djZleTU4TE5kdE4vUm95djBn?=
 =?utf-8?B?Zy90ckEzNmVBd0dCY1Q1STJ2cGVJSW9LM0hZUDBHaHBLQVVDbFFIY2M5dGFs?=
 =?utf-8?B?Mkc4YjUwUFpIcHpsV0FvSTN1dWhpdEtocXRvYU56TFhnUmljSitDcEdxRGgv?=
 =?utf-8?B?WUVCTE5nR1A3d21Balh0Z1JIdkNZc1lmc0N5cU5yZEoyN2dNaTNvQ3k3NWg1?=
 =?utf-8?B?MXFKOTVGWkFwY0grMjFqaU9yN081RDJHSVZOSXRvVkYrWXFNZ0c4YUwrNlor?=
 =?utf-8?B?Ynh3VWtPalNIQ3l0cEpnMkRmcGhYZXRYZEw0cTgydEhlbERDcEkrQTBpUTNS?=
 =?utf-8?B?QUVrNEJwUVJBblFwUmg2eXBlcHd0VklzVFVSZmtyc2puY054eVN2aXBvNGt2?=
 =?utf-8?B?TDB1V3NnU0Y5NERnQ1ZhWStIK0cxVndQQU1Qd1ZUeDU1YUNsSFg5YXg3czI2?=
 =?utf-8?B?YWt6aWE3ZDdDdXVWejNLdm5YdkQ3ejJFVzRaUXpIWUQrcUlPNHh3WmJiY2RE?=
 =?utf-8?B?dHJpUDI2bUhLY3B2bXBZNUFiQUhJbVpQbTNlbkVjaVVYejRRc2lYY0VmTXRx?=
 =?utf-8?B?T1pvTGd1TjlRYm9QL1owa1hjRmRRSnJmb0I1WTRWQW9LcVhxOVdYZVZyazFn?=
 =?utf-8?B?ck1DYmR4S2JGZjRCc1NqNHQ4NUgyMjNBdllZN1hpRURSVWRRaFRyZlRMcm1M?=
 =?utf-8?B?d2Vrc2tCM0daZEpkczVmLzRwTEdSU2V0UVozUmd6bjErRGg4NjBTMHNYeEh3?=
 =?utf-8?B?Z2dEd3BPQmJXMm8wOVoydU1DMWxTRktSOEQ1VVM0TGFGR3VHbHVJK2ptM2k5?=
 =?utf-8?B?bEM5czVkdDlVWHhCeUdZS0V5eGZ5a2RFYW5jU3N6SEVQcWRBL2ppWFZtaVoz?=
 =?utf-8?B?N0lzL0UyS3EydGZCUDFYYTVLRnpQSGFtWDliT3k2L1J2Q0pPMFZ5bGNnNE1N?=
 =?utf-8?B?YzdqejNoeGNUWEVPRnZLS1dvakJGTStvQS8zZ3dGcC9PYXFsLzVrRUZhZWFL?=
 =?utf-8?B?L05pK0pLK2J5VkhqZEpFSE9FaFYyR0lQRm8zWnVvT211M0RaTVJsSVYrWmp3?=
 =?utf-8?B?czM0MU5KSHhnNjFiTHlLaktKN2JYbzRCVkppSnRZL2l5MlJUbnpYbGlPNTNx?=
 =?utf-8?B?Qys4WHBYZ0FlUUxjVHdqSmozRVRRNm9LTmZwdHpHV2t6eDRTTWh0dXRaTStN?=
 =?utf-8?B?TWZha1N2akU2Q25EUXAyTkxRZUkxbGJodTdEN2hHT1BDNWxrYmhDWUxzUFl5?=
 =?utf-8?B?SlBXQVhNZHdyaWZFcHcxeWo2akp6SVNCb0MyT0xVVXBNQnZLK1hLcmczaC9S?=
 =?utf-8?B?MlZKc1hNR0NlbElneXJBTEFiaWxpaVUwdzQ5Tm8rNFRkNFJla0duZXMvODkw?=
 =?utf-8?B?NkVBbzcvNFUrMlN6ajhGbURtMU5oNFBrUXVKR1hqUkJNeWQvZjJXZ1c1bnFo?=
 =?utf-8?B?dGRkdHFXRE1aaTdjaDdCcTA3cDZGcHl6cTBia2JKbVY3MFpLZENFSkZvK0NY?=
 =?utf-8?B?TFBVU0RqblliU1NEcUpyNWVydWJuMzloYlA4WTBrOHp5eFJJS2VaMjN0S3ND?=
 =?utf-8?B?cUdSM0VoQ2trL2JQNzFjZmVsSU9vdnVMeGZTZTBHS1FIVzN1L2pocStGUGNB?=
 =?utf-8?B?WnUvUW1FcjNoU2xOZ2phOTY3Lzd5dm1URm5NdFc3NmRtQ2pPb0xWem96WHdw?=
 =?utf-8?B?R1p5RHdNQ1RrRE5BZTl0Vmk5RGNNKzdNVm5xSkJkVGNOdGxYa1I0VGlIek1z?=
 =?utf-8?B?L3dqRnl0VkU5ZnlZbzlscU5BRXBhZ3FYTENFT2dkQ2J5ZTEzdWxzSjRXSWZj?=
 =?utf-8?B?V2NaUEJIZXJydVdQcTdic0pGQ05xa0xVU2VpUnlzMlVyOTRRQUtNUFR4UjZr?=
 =?utf-8?B?ZlF0SFVKWVlTNXNmOU8wMzJldmVHV2JZY1k2TndqWmNQbHo5R3V6V3hsblRB?=
 =?utf-8?Q?FAyNKS4Jbj6Dq6M6BTbr3SS13?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06737f61-63ff-47e6-26e9-08daa7dddb3b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:00:53.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSLJkR4x5L3gDtO+3p6TyShqSVsB1Ibk3Z5to4zD26PoobW82rsQZi7m8a7MuI6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6515
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 13:30, Andy Lutomirski wrote:
> On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
>> The kernel normally skips loading this segment as it is not inlcuded in
>> standard builds. However, when linked with an application in the Unikernel
>> configuration the segment will be present. Load PT_TLS when configured as a
>> unikernel.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> Signed-off-by: Ali Raza <aliraza@bu.edu>
>> ---
>>  arch/x86/boot/compressed/misc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>> index cf690d8712f4..0d07b5661c9c 100644
>> --- a/arch/x86/boot/compressed/misc.c
>> +++ b/arch/x86/boot/compressed/misc.c
>> @@ -310,6 +310,9 @@ static void parse_elf(void *output)
>>  		phdr = &phdrs[i];
>>
>>  		switch (phdr->p_type) {
>> +#ifdef CONFIG_UNIKERNEL_LINUX
>> +		case PT_TLS:
>> +#endif
> 
> Can you explain why exactly a Linux boot image would have a TLS segment?  What does it do?

Thank you for taking the time to review the patch. 

A UKL boot image will have a TLS segment if an application has it, or is
linked with glibc, and the resulting binary is then linked with the
kernel. This will allow applications depending on TLS to function
without modification in the UKL setting.

That is why, the first patch in this series adds TLS section to the
kernel linker script. Also, if you use an application binary that does
not have a TLS section (like the one given with this patchset in
samples/ukl), you can turn it off through the CONFIG_UKL_TLS option.
This means the size of the TLS section would be zero and this code will
effectively not load anything.

> 
>>  		case PT_LOAD:
>>  #ifdef CONFIG_X86_64
>>  			if ((phdr->p_align % 0x200000) != 0)
>> -- 
>> 2.21.3

