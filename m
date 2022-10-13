Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968885FDEAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJMRJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMRJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:09:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2128.outbound.protection.outlook.com [40.107.101.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11055B4893;
        Thu, 13 Oct 2022 10:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHlqGApfYsFnQTpeVNS/PMg2EK2rSPdvnVnZIP5GXcTqHInhgZcjwjZbHnQ4ihpVxNx2Rha9XNfUbnmicI3sU8Ub4urwTKSMPPrFJjRegxp4fo1dmq9qAEUW2JlNeJfnInWFCANg+jpLGjeZz+yM8265iTgBZ2aQpOETYxBoqbAScB6+VEw+24CpIkXtdUunDZf9X7buJ/Taa8vF1at4JWOYOCSsr4Msb85tI6a1aMCV+WBMer5p/7Wv0JB+QprVPAnKsDz/liitN33FMK+UnpLqz62SaD8OL/Tsja0lMMAIi7tqcM4iiOxf+JbTihdHG2sp8a4DaY3Pr/pS4erKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHCSsJ+NTPZKshltTGwnKokpNkpiDs2fQeVQ7Yjuwow=;
 b=dqWMJgvZBGDHZdPUZ2fbAryVzO4SVUTvpqhizlFPKE4Ci3E7M28LHHNu88VixBAii2s8Fnq1d4kcSh/O82SsRgXzoGAXS4DlJ0AK10tC/qGFzcMRspASIxz9j0uK60jcLZveqScjAgmD9uwd4aa58CrDtTwbNABJOmXPKaXOJjw3KMyVfGTVN1tUffFApokrnx4T6DQzYHC9rXmV6ZfnvFszgoffwrS9f3AAH0SGxArd4kOk3Xsrx4FF+ALIcAnlJid8/fjBn+kFZ93fnpf5MFbMMwVtBv8ogLAxjawhkZgv3EmmdEULXuVFJMbRxKZkoV02hAJSjjD+pKTYSHwOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHCSsJ+NTPZKshltTGwnKokpNkpiDs2fQeVQ7Yjuwow=;
 b=efWG0B0UqcA3/QnIqVD6BnxIKNJTSXDivjpZSo1isP+jyM6cr088AnD3/g37qxG7nTOrL8Q9N0vpa9EFb+WYTwWdktj/1W1Mvhy54YoaJjDZvikPODHIXu+XmMBye7NWja+J68oCPbMu0zHfQCSyBPEPKNBIg3pBC/ePWhg4+UirDi9zLueP6gocAZr58259ggvwFFCJ8Sm0M8Y8YVd6PX/0yYueDGX7uS2paL1UgQjJ1CgKtwBtLkO6EWc8Jeik8+LUgdvh/jSB5FT3VX7ms3KUEXBwlp2uAvCUYBZQ3YMq1QZ2D0EfGte3nuJlSgHZcJPZp0QvYVKHYWP74QupoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 17:08:58 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 17:08:58 +0000
Message-ID: <4ae5f680-9db6-a087-a11b-a8b1ff7237a0@bu.edu>
Date:   Thu, 13 Oct 2022 13:08:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 10/10] Kconfig: Add config option for enabling and
 sample for testing UKL
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, michal.lkml@markovi.net, ndesaulniers@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, arnd@arndb.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, pbonzini@redhat.com,
        jpoimboe@kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, rjones@redhat.com, munsoner@bu.edu, tommyu@bu.edu,
        drepper@redhat.com, lwoodman@redhat.com, mboydmcse@gmail.com,
        okrieg@bu.edu, rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-11-aliraza@bu.edu>
 <d2089a89-21a9-1e05-5d58-91b8411f7141@gmail.com>
 <53c84c25-31ff-29d5-c6fb-85cb307f1704@bu.edu>
 <CAK7LNAT-Q=sS-9L1eRuOnomqqDNyRp2knZh+2SYLqB2Gn8ekHg@mail.gmail.com>
Content-Language: en-US
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <CAK7LNAT-Q=sS-9L1eRuOnomqqDNyRp2knZh+2SYLqB2Gn8ekHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:208:23b::12) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|DM6PR03MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b6728b-3ef1-48b7-21d1-08daad3d9dd6
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dczwaZO5QeIJyszKutqsMeqGH7JJPLmkQ1PmjZmwGwd5gDOy7lqqxrvTZHSIgjp4qHxTKThsyRUKaYduVkB1+ns9uXWCxNsaQlr5mjYEJn0Fo+xQo0QsV2/wCY8r61hcw1mIc8uVzIMDm80ehLzy1K1/ZZCsDf9ATSGSNgpcY+BOyMSW46XKJFvoRP85+S5hRB37oRm0WOF5L+XxkzIdY2Px0IbvjkIa+ubdgRdKP8HCXyIRP7AQcgxyPFuomVXE1sE6e9oIkEOhlTv5P6OJdiMqEhgH4yHVq0QBJY512aXh2/OsZ0/SN8PIj5xRKqK6OIG7Ax65HY0n0z5hL8jCfMkimJzrdPFPCwk8InZjRjAMSRANZuyfNf84QaVExuVUGOehqxCk1NHmAUrBg8IU9+GMgN84m7JplHWVvyC7xWGo28itVkFLczc/KJ6N6TF770IISFcDzoI1GNbcPikQaIzuntZgQAeICcpGAAcHYIbT7xY13MdOYjr57yIZFLZcRlUBh1gJXZ+7yuuPQQ2SRK6jR/eqIowcbSEWqs2nC8QPXDnysltn0LkGpSpHlAosCMpWuOJXt0afD6+cNNv7MTzpleemF8v+e8SlHNSo8142VaOPneM9lcRoYZYVZr9stYCjKzibEyNUokZIx/vaNjfXXX2t4nq+WRE+Lpje5JF0mirFvPkdaXKRsESpR9WqI8ppqZN+0tZrwmD8HgeXM2WwJ8g2tjSD5R4HVNHnGBQjQjDIHHFUR5WkpMMm9OsGktdkZBYOm0xEeilqsHk36cgGwJERRKDVc7qERJBXP0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(36756003)(2616005)(186003)(26005)(6512007)(2906002)(41320700001)(786003)(316002)(6916009)(41300700001)(86362001)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(31696002)(6666004)(53546011)(75432002)(38100700002)(7416002)(6506007)(478600001)(5660300002)(7406005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGo1aXNRQUxEaENVV3hXUkZEdGU1eTF2RXNMYzVyQnhoeTBLRkFHNEl3b2RB?=
 =?utf-8?B?bmtxZ05MRTJOQTVQb3VsR2VWOVYrVjdWWXVLVkdwSW5UNTZZTldzRjFuV09F?=
 =?utf-8?B?YSs2S2ZUNWNMaFVOWmVKVWlUR0hlWStyMXpTV1FlRENVenJkNGVLa0s3VTJi?=
 =?utf-8?B?b1Q0NnptdU1VbFFIY2kvV1RQT2VFamtCYzd5eUFzQzJhU2t2aE1hTFBKenho?=
 =?utf-8?B?c0N2QnQ2Z3kzMk5YTGdkZ2RVRWdyNE5XQnhzVmdlcS9yTk1vQVRtdWFvTnUz?=
 =?utf-8?B?RE5sOGx0azRCODJGYk1GSUF1eUFBN3ZINFh3ZUpYblVXUThiSHNqVS9WcDJj?=
 =?utf-8?B?cmVXVkZGeng0UXgyS3VHaU9sNUk1cHo4ZENzNTJiUktBcm5qV0tFWmxJWTA3?=
 =?utf-8?B?cUJ1MXZxL20zdXdwL0FvWlVOZHJVTTk4VzQ3TFNEeUcrZVRiakVYdEdMY3Ez?=
 =?utf-8?B?ZGhXWUg0dTZmekd0dElVNzdYbDRUd2taa3Z5RDdWWHBlOUdZNFRzOFAwVW5p?=
 =?utf-8?B?eU5nOFdXOE80bEJpOXBqNFJpcGsrK2lMa2dNSmhiNzFCOWYyMXU3dDJYcHZQ?=
 =?utf-8?B?Y2hPazFLdSt4YW1iUXp3MTd1RFpvOTlTOWhmWUZLcmNaNlRDK0RNTEtQcEY2?=
 =?utf-8?B?c2g3L1NSdFJqVW02eExZTW0zdDRseC9FS0RIYm5KK242UUhSaFE3d2FLbmQ1?=
 =?utf-8?B?azlUVXFSSUFndGplbmh1aTlDcEE4UDExOGtYdnU0UVhhSS9KYjlMNGNIc21T?=
 =?utf-8?B?a0VEQkN4ejNOM0hjcElHUWVIaW1Db1RGRjg3SFRVVS9PRnRCRzZQR201eEda?=
 =?utf-8?B?MW1QTjVzU0tKOHVnYjhoRTBPYm5UV0U5VWErRDFHdm5uQmF2R24zVTBxZ3RW?=
 =?utf-8?B?MmVJME5pTVFKT3V5YWJGYXJrVm1FbDh3ZWwvZXZmNGxLLy9uQTE2RElZQUZG?=
 =?utf-8?B?bG8wWUcrSi95L3F4UDZFWG9UdlhhbVduNHpyK3BUY29hbzY2NnZ4VlR2cmp0?=
 =?utf-8?B?OW1QT3RZc0N6d3l4emRFVTVLZTZYVHYwMHhhaU05RFRUYy91aVlkcTlVVnl0?=
 =?utf-8?B?VjRtL1JHOWEzOWl2MUNJbCs3K21rZ1J0RUliNmhLSFFYbFRraERxZ3ErZ2t4?=
 =?utf-8?B?VTdsdDhoZm4wQVh6UnNvSExGVmplN24xVlZqVjZHMDEwRFhpWS9HNnBHNG5n?=
 =?utf-8?B?TzBwWE9zTXE3N2oxQkxmWDhtcVgrNXB3dlgzc2U3Sm9nN2RMUmJsb2FXdlhP?=
 =?utf-8?B?RkpSOE5CL2Y0SEpTNW5tVXJUdE5qVmhCT0lBU29DNGlWNXl3VW5ERDZETGZi?=
 =?utf-8?B?ajBXbDVReEJyR0RhT2JLdWJ2bzlDSDFCdnFBR0dHQTdWKzJhTEJzaWlsQW5n?=
 =?utf-8?B?ZUpSUXNYakd2OUtjL1VxL0RqVlpXVi9kRURqNjN1NmlQeEsxNnFONlAxa0ZL?=
 =?utf-8?B?eGw0WXBxa3lPZzJJemZtRS9mR3hDVUZLeEhUVkhXcWFkd3lQZ1VDVklpUlB0?=
 =?utf-8?B?NkdOWkhuV3hudDJlbGRxUlhRcW56bERETHZQZzJwTEJTZkRGN0tDTEhINkZH?=
 =?utf-8?B?a0VYdVlJWDJtS3cwUzhSbEVrMmZtYlRYY2R1SSsvaFZXYUtxamhmSUU1ZEZz?=
 =?utf-8?B?QUFjbUhDOUxhYkhEL0FzRlNYSkF4TnhYeHBzakVSVlAvSnVVSE1ETndxVVNx?=
 =?utf-8?B?MkVHem4yZGxMRS9VRUloZFA4V1MwRXp0SDdqekJGNkUvL1NzWVVSNWhlaEJJ?=
 =?utf-8?B?ZEhFQUtzdjE4Mjl5WWg4MXFEdlk0dnlxRnQ4dDNyZkZwSlRhN0hxZlVzbVpZ?=
 =?utf-8?B?TGF2dGdHczNEMmNuMU5Pc3hxZEhzZHZnTnFkVUVhYm42Vmttd3F0U1oxenBJ?=
 =?utf-8?B?MkUrUFUwbnhoQmI0NjRTYU54c1VaUVhmYm1IMWU5cGMzYS8vUGpuRnJVT2dJ?=
 =?utf-8?B?TjNETG93Y1BIZ0ZlcU9BWHdEaGlDcS92S2VaeVp1SlJCalFuZHdBTXZLaHdM?=
 =?utf-8?B?d1o2TkdweTVicmp1TjNDclk5aVZQUmc1SmMxeHp0SzlESEtLOGh5cUhNT3Nt?=
 =?utf-8?B?SlJoajl4dFZJMExKV09PR2d6OTgxTXJZRGxYcjJnazFVV2x0TlNPYXhGU1dS?=
 =?utf-8?Q?wlR3MNjbt0OrQdKqbdq1VLgCT?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b6728b-3ef1-48b7-21d1-08daad3d9dd6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 17:08:58.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15HgxxxuIWCwGQyGWEwrCD6YuPuoee5/y3ljgXH+RrSOdf958FPZU6SvjopOH8LN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/22 06:21, Masahiro Yamada wrote:
> On Fri, Oct 7, 2022 at 6:29 AM Ali Raza <aliraza@bu.edu> wrote:
>>
>> On 10/3/22 22:11, Bagas Sanjaya wrote:
>>> On 10/4/22 05:21, Ali Raza wrote:
>>>> Add the KConfig file that will enable building UKL. Documentation
>>>> introduces the technical details for how UKL works and the motivations
>>>> behind why it is useful. Sample provides a simple program that still uses
>>>> the standard system call interface, but does not require a modified C
>>>> library.
>>>>
>>> <snipped>
>>>>  Documentation/index.rst   |   1 +
>>>>  Documentation/ukl/ukl.rst | 104 ++++++++++++++++++++++++++++++++++++++
>>>>  Kconfig                   |   2 +
>>>>  kernel/Kconfig.ukl        |  41 +++++++++++++++
>>>>  samples/ukl/Makefile      |  16 ++++++
>>>>  samples/ukl/README        |  17 +++++++
>>>>  samples/ukl/syscall.S     |  28 ++++++++++
>>>>  samples/ukl/tcp_server.c  |  99 ++++++++++++++++++++++++++++++++++++
>>>>  8 files changed, 308 insertions(+)
>>>>  create mode 100644 Documentation/ukl/ukl.rst
>>>>  create mode 100644 kernel/Kconfig.ukl
>>>>  create mode 100644 samples/ukl/Makefile
>>>>  create mode 100644 samples/ukl/README
>>>>  create mode 100644 samples/ukl/syscall.S
>>>>  create mode 100644 samples/ukl/tcp_server.c
>>>
>>> Shouldn't the documentation be split into its own patch?
>>>
>> Thanks for pointing that out.
>>
>> --Ali
>>
> 
> 
> The commit subject "Kconfig:" is used for changes
> under scripts/kconfig/.
> 
> Please use something else.
> 
> 
Will do, thank you!

--Ali
