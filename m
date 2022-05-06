Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E251DF40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386541AbiEFStT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385537AbiEFStR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 14:49:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95015FE0;
        Fri,  6 May 2022 11:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeIUIWMCPMqmuLkPYs0UkIyvzSP78p+2KG9/rbXI1qKN7ZTg+WoYzg0mREh4E6eS8jIi5BYhLTGcOkfUMa1sjEADvpiwmbkuZ8z9R+WngtoS2n9t5XEdiGClgGRlWYic4lEi7o8RA1FbGzOebXYRWUbODyZjV0C+ZMoBNhxZXR7sMfAJLP24bWLZqOoB1jyB4vAsZfM2BolVMwaUt5/oHvBFCehXZTdVuQDoxe469Lwr5Bq0zYUbqFYhvqz+pmccmZqqMmiaQN+6Cj4h9XmiHjB/9wJDbOQSaMhtMxtfzaoJWs0z9rD0V3+M9Dhk30yToiCqUN/i7UfCtAYVdZdWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JbFa0p8R3ay0GQ0LEOPw0G6y1x3Ahw3i8OotwoN82Y=;
 b=fP+TXmAIfx9qSRn/uVsVU4F8Z9/eWPZTrbKZP87kIgharHpZvGNn7j0KKZ5FnjWhLx3jHtpH39wz8isSqDiVkgGColD+DjnlIAnaqKBL51r5wgKLi/7qvgQYBPBwQZ5GzmYlgOmVdnxopc16J9MSVtfzk7jbXNNd4wHrEtkQc20DIwHHF4minWwd0N4PL0H/orUix9bU+Sh1jN2WclWA8fZuH81EPQ8lVLh7+1F2aFgsEyL5jOXWzEIwWKzCLYSOnJU8fDtwpCCP/dGFBNRcmYJhig5ll3eOni0zm0e2ERdFee8Ac3TJFoVcOVBWEwd16szF8zGJ4G7kk9GriCL3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JbFa0p8R3ay0GQ0LEOPw0G6y1x3Ahw3i8OotwoN82Y=;
 b=yCpjgCs2RtTQy6/O1KnYt+YhpAjjlBoacywe7P5yxk3sWzOr6W02rIVUD1iFXxFzEVxXHTVmGOuApmZeQXJxMEnARZBiHetsKT7FQPn/aaTJ4j5t6hEbf4vb/bL0Tmp+/Fypos9Y0cJmGlnde75CSBOmxNJbVUDIyvFeGieU6/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BY5PR19MB3906.namprd19.prod.outlook.com (2603:10b6:a03:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 18:45:26 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 18:45:26 +0000
Message-ID: <90fbe06b-4af7-c9ce-4aca-393aed709722@ddn.com>
Date:   Fri, 6 May 2022 20:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Content-Language: fr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
 <YnPeqPTny1Eeat9r@redhat.com>
 <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
 <YnUsw4O3F4wgtxTr@redhat.com> <78c2beed-b221-71b4-019f-b82522d98f1e@ddn.com>
 <YnVV2Rr4NMyFj5oF@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnVV2Rr4NMyFj5oF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::33) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5201412-f7e1-4943-3da3-08da2f9095dc
X-MS-TrafficTypeDiagnostic: BY5PR19MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR19MB3906CE277A67F71479EDA1B6B5C59@BY5PR19MB3906.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/uJGhy1UZ9UZv4IyI2KG/WrImcdIMZTO73wr+uFWYCKUzV2jmyFPS2D5zRmcNPrUwaouPHOPpQS1ZwLLU1x4gRx2K+yiHBXlqz6yDkwGu3g+J2OvGFDp0DO6JjTS1TmcEupJt9DbjxzgE3j1X/IZiIzZUrKYmRdJuAtifzx+JKx0DcRDQ0uskkVPfV+XwooeVKDDgucR4IF+6xFvmkewM9E6wjdSBUWRobYV2kSy/0o19HevcB38QpFrNpjHGMBb4CL+ezm+sbUBop2Mw7PLuzG6shL/aec0F/PdvMEUfkzODy/in2QfCZK+aJ1eSaQgZoiR3JP2rIyeKLRaNgVudelYrKCc0L86C0/338IPBBXRw3NNJCvT6K5Imot2ptKZeTUgAr3dTko7WIt9fCtte6JZnyG5rfx0YJsim9fX/C9RpMbkDn1Jqt4ty3J+3pJtUXKGtEiLCymcbax8aMioj2+Rwd2g357QOifNueuNIHkTLqLhDCbUjCiyMdb7UMe+sn1cDBbY0ahMP8YkyeMCqh8xsnfNCdTyfjuJfC4xDcn3Ebx14QYnUoHJQXR2vnetr8Y9WDbk5bdxZlKPh/K5p5DGfO047SCz5VIRXeBNWJiAYyvfUsA2IQtOO5YM9zHFoWSn6LLf0HwzwckouRvOgzgQjZquvQUV2421mL0tubQD7c1mJJkCZ1l9aJkGRjXV8svbmF+Gk/B+s3ceTIljC5VksyaSD36Y33/sc7C275lJn4evNLMx6lNJ1p14s/dxECSkdB+zCL8YUKcbV4lwcHaYEBe49s0r3At3sx+euUeX4JLLBeb3G2kgWVVJqIw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(66556008)(66476007)(31686004)(6916009)(8676002)(36756003)(54906003)(83380400001)(38100700002)(316002)(66946007)(53546011)(31696002)(4326008)(86362001)(6506007)(6512007)(5660300002)(508600001)(966005)(6486002)(2906002)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElvMi80RWdjS3kxcit0S3FENEQ1RTlRZEthZ0FOL040UnM2bzdNenpmYk1j?=
 =?utf-8?B?eTQ1L21pOFFlNzBQM0h4eVlnTFJUU0lrZVJuVFZKZkx6N29VdHFtNm0xVTZl?=
 =?utf-8?B?MiswWTBtMmo3V2lGWDQyekI4QmFOSktZZVVkRlQ1d2ptQzJpN0tWOXkxTW5T?=
 =?utf-8?B?L3JuOVJGN05WZDZZYVVJYmZrZlNsS0E1RXNrQWtWWVcwYWpieUpZVlN2S2dp?=
 =?utf-8?B?REwva0w2TkpaVE5JV0FWdGk0V3czY1FRMXFnc2IwaWozUkR3OG9vMC8waUFG?=
 =?utf-8?B?Tm9sSHVIMGpBUzJOd3RtZFFCZmhadVZzWlhkeUZqUDBtQUVkei9mT1p4Q1pz?=
 =?utf-8?B?N1VlcklEd0U3MHZTM3MrK3pRYzYwVGpMdXZseWRxOWNrQlNTOWRpckF4MDNm?=
 =?utf-8?B?T1E2VTBxREcrT052TnZQQ1FmcDRDSmZsZlJFUGs3NGhpSWwrOTBHclBUYjdG?=
 =?utf-8?B?SzFwbUR2VjFodEQ3WkQvd2hpVU1nQnBkU1p6SDJ6eEE1OW5GbFRuRjZxa01G?=
 =?utf-8?B?K3VqMzN4WVp4emw3MTJqb09wSVNPVFhRMGZjT0k0cCtjT3Y3UlZ1RUdEMzRZ?=
 =?utf-8?B?K1h1RHd6Z1NoekJnWFV4MDVjRk9HeTJ6V29nS3k3Q1A3R3orM1hnalI2b1Qw?=
 =?utf-8?B?YjUzNzU4bDFtQXJxZ3FpZDJEb0dyWXJHamF0NFp0OGVUemo1SFQvd0ZvRzBa?=
 =?utf-8?B?TXRTZGF0bWVlL0FRQTZXL3VvUm1DK1prOXdsZWdHQk5aMnVsTHorRGIvWllo?=
 =?utf-8?B?OCs4YUNYSzZQZUl0dExsV0Ivd0h6YzJXRnNoVUtSM2VBRWVzREZCR3JuSTc4?=
 =?utf-8?B?RmkyR211OWFnWTJDTTQ3WW96YWhMayt0MWdMM0w5bUgrMmRzV1Q1dFRyTzUv?=
 =?utf-8?B?NUhPejhiWnhJRm5lVHNRMHdma3Y1YkVVRDVpWEpvelhOT1ZqK2o1Z0RHaCtC?=
 =?utf-8?B?WnBySm41UXpzQUZjQ1RucUNRdUxDT2cyN01vbWszS0tEcGQ3RVlNcTN6czFr?=
 =?utf-8?B?NlEycUd2U0xhaEtSb09jbk5jSnFqN0ozcGdzd1BhOHI3S2xwaHdlcVdydmc2?=
 =?utf-8?B?SXFXUE5rdzEvRHR3MnMrWllETm5HUXByUDdXUjBnRys2dWhITzZmUkI5QzVB?=
 =?utf-8?B?M1FSSGkwQVoxcW5MTW5GWjhNN1VRV2hRWDBMOUdwZG1DQVJka3ZqZGcxZk9w?=
 =?utf-8?B?NzRGaGtrZmw0NG94b1VqZkk5dzNTQmtjZzZBTDJwM3BEN1p4eUdDdVBHVHl1?=
 =?utf-8?B?SEpLMk9yQnFSS21KUXFEcHNSNFJlMEtEMmFSUS8xbzF2blY1Mlc3M0VkQ0Zk?=
 =?utf-8?B?cjBzS2luOWZUN3dYZi8zYytXYkdJTHB2R05IYjYxL3dDVVk2MFVzUVFCTEpa?=
 =?utf-8?B?bk91Z21tbHQ2bXVqUGpMdDEzMmdXSEhhZnFseWpDczc1T2k0NCt6WmpZT3NL?=
 =?utf-8?B?d1E2bGxQK25DL3Baektta3pSWTI0VzY0ZzlNUnNqbjg0ejZGdHdQYzFwbWNa?=
 =?utf-8?B?eE1xOGduWDVsTk9heEs3NlNTTXAwQTQ5SWgxS0I5QWF1Z0JWKzVMUFdudlJG?=
 =?utf-8?B?VHpyTHUvbTdyR0pOT1pVQ3NHTzV3aVFwY2tZMzlZOFhFdkxsTkRQVHQ2SGxE?=
 =?utf-8?B?Z2o0ZVhMNnNqeUI0VVU5cVRNWE9DUjhoZnVELzAzOEdtQTFiRXFuTytaVkdx?=
 =?utf-8?B?bVhObHZsMTFwcUNkcWpSMDU2c1lsVzdpUkNOZzNtMFlyOTFFK01nZGZwb3hP?=
 =?utf-8?B?b25FK29tK0NBUUNJNE9rM0ZoSTY2SE5vMG9oaldIYTl5QmZQY1lzVWluNXk5?=
 =?utf-8?B?V0pNdWhiM1MvTXVBQndXNFJMWnluWXh0U0lSQ2l2NHNNMzRaR0l6ZnY5L2VX?=
 =?utf-8?B?K0ZEU1J3bytycU9FeXF4QVY4cTFDNUR0OHh4Uzh3V0ZZampOSlFoeWJQVG5U?=
 =?utf-8?B?RnhVbUhPaUNGRHp4QlY2REZWRlB2OGNiVTZib01vdkczSFp2M2hRcHFrZDNq?=
 =?utf-8?B?d044V3lhRVMwWmhwRDVDN2Y5WU1iRGJYVk15Qk5iMHl1YU1LUnlta0QwL2FD?=
 =?utf-8?B?VVRmM1FCZ2kvdE1nZjlGU3g3TmJIL3lUWVdueEJodWwyNlhLUTJkQlE3OWNx?=
 =?utf-8?B?SVVMNEtHWWZZRDJkM3JGaTc4QkVHWXc2bXIwYjJ2OXNGaWhWcFUyOHUwV2FO?=
 =?utf-8?B?RWRmV2YvQVhuaDZIcGNmYnFxYUNoa1VrUEgwbTF0R2lucGJ6ZjlzTzVwOGtU?=
 =?utf-8?B?d04xYlU0dmNtbjliaDFDT0xJNDZPMjRvNHhCSVh2ak5RandCSm5rS0VZZ3ZE?=
 =?utf-8?B?MDZFU1A2alNnd2xVQndDc2l0ZS9TV0owMlkzRlVGT0VRcTN1R0N6NkZ1eDVL?=
 =?utf-8?Q?VAQmncZr2KlgSUkBPcmlgGoP5/WGkWw/Iy71RY+m+lI7V?=
X-MS-Exchange-AntiSpam-MessageData-1: f/2/Ai6WcuxXVg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5201412-f7e1-4943-3da3-08da2f9095dc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:45:26.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNtTCTt87EGrzLIJA8uI9I+oSUhd5GAkFxgjg4KtwMihgRjV42WxwlTzH6hLvonR79xn4oClWa7S0XJOip6xxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3906
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/6/22 19:07, Vivek Goyal wrote:
> On Fri, May 06, 2022 at 06:41:17PM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/6/22 16:12, Vivek Goyal wrote:
>>
>> [...]
>>
>>> On Fri, May 06, 2022 at 11:04:05AM +0530, Dharmendra Hans wrote:
>>
>>>
>>> Ok, looks like your fuse file server is talking to a another file
>>> server on network and that's why you are mentioning two network trips.
>>>
>>> Let us differentiate between two things first.
>>>
>>> A. FUSE protocol semantics
>>> B. Implementation of FUSE protocl by libfuse.
>>>
>>> I think I am stressing on A and you are stressing on B. I just want
>>> to see what's the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE
>>> from fuse protocol point of view. Again look at from kernel's point of
>>> view and don't worry about libfuse is going to implement it.
>>> Implementations can vary.
>>
>> Agreed, I don't think we need to bring in network for the kernel to libfuse
>> API.
>>
>>>
>>>   From kernel's perspective FUSE_CREATE is supposed to create + open a
>>> file. It is possible file already exists. Look at include/fuse_lowlevel.h
>>> description for create().
>>>
>>>           /**
>>>            * Create and open a file
>>>            *
>>>            * If the file does not exist, first create it with the specified
>>>            * mode, and then open it.
>>>            */
>>>
>>> I notice that fuse is offering a high level API as well as low level
>>> API. I primarily know about low level API. To me these are just two
>>> different implementation but things don't change how kernel sends
>>> fuse messages and what it expects from server in return.
>>>
>>> Now with FUSE_ATOMIC_CREATE, from kernel's perspective, only difference
>>> is that in reply message file server will also indicate if file was
>>> actually created or not. Is that right?
>>>
>>> And I am focussing on this FUSE API apsect. I am least concerned at
>>> this point of time who libfuse decides to actually implement FUSE_CREATE
>>> or FUSE_ATOMIC_CREATE etc. You might make a single call in libfuse
>>> server (instead of two) and that's performance optimization in libfuse.
>>> Kernel does not care how many calls did you make in file server to
>>> implement FUSE_CREATE or FUSE_ATOMIC_CREATE. All it cares is that
>>> create and open the file.
>>>
>>> So while you might do things in more atomic manner in file server and
>>> cut down on network traffic, kernel fuse API does not care. All it cares
>>> about is create + open a file.
>>>
>>> Anyway, from kernel's perspective, I think you should be able to
>>> just use FUSE_CREATE and still be do "lookup + create + open".
>>> FUSE_ATOMIC_CREATE is just allows one additional optimization so
>>> that you know whether to invalidate parent dir's attrs or not.
>>>
>>> In fact kernel is not putting any atomicity requirements as well on
>>> file server. And that's why I think this new command should probably
>>> be called FUSE_CREATE_EXT because it just sends back additional
>>> info.
>>>
>>> All the atomicity stuff you have been describing is that you are
>>> trying to do some optimizations in libfuse implementation to implement
>>> FUSE_ATOMIC_CREATE so that you send less number of commands over
>>> network. That's a good idea but fuse kernel API does not require you
>>> do these atomically, AFAICS.
>>>
>>> Given I know little bit of fuse low level API, If I were to implement
>>> this in virtiofs/passthrough_ll.c, I probably will do following.
>>>
>>> A. Check if caller provided O_EXCL flag.
>>> B. openat(O_CREAT | O_EXCL)
>>> C. If success, we created the file. Set file_created = 1.
>>>
>>> D. If error and error != -EEXIST, send error back to client.
>>> E. If error and error == -EEXIST, if caller did provide O_EXCL flag,
>>>      return error.
>>> F. openat() returned -EEXIST and caller did not provide O_EXCL flag,
>>>      that means file already exists.  Set file_created = 0.
>>> G. Do lookup() etc to create internal lo_inode and stat() of file.
>>> H. Send response back to client using fuse_reply_create().
>>> This is one sample implementation for fuse lowlevel API. There could
>>> be other ways to implement. But all that is libfuse + filesystem
>>> specific and kernel does not care how many operations you use to
>>> complete and what's the atomicity etc. Of course less number of
>>> operations you do better it is.
>>>
>>> Anyway, I think I have said enough on this topic. IMHO, FUSE_CREATE
>>> descritpion (fuse_lowlevel.h) already mentions that "If the file does not
>>> exist, first create it with the specified mode and then open it". That
>>> means intent of protocol is that file could already be there as well.
>>> So I think we probably should implement this optimization (in kernel)
>>> using FUSE_CREATE command and then add FUSE_CREATE_EXT to add optimization
>>> about knowing whether file was actually created or not.
>>>
>>> W.r.t libfuse optimizations, I am not sure why can't you do optimizations
>>> with FUSE_CREATE and why do you need FUSE_CREATE_EXT necessarily. If
>>> are you worried that some existing filesystems will break, I think
>>> you can create an internal helper say fuse_create_atomic() and then
>>> use that if filesystem offers it. IOW, libfuse will have two
>>> ways to implement FUSE_CREATE. And if filesystem offers a new way which
>>> cuts down on network traffic, libfuse uses more efficient method. We
>>> should not have to change kernel FUSE API just because libfuse can
>>> do create + open operation more efficiently.
>>
>> Ah right, I like this. As I had written before, the first patch version was
>> using FUSE_CREATE and I was worried to break something. Yes, it should be
>> possible split into lookup+create on the libfuse side. That being said,
>> libfuse will need to know which version it is - there might be an old kernel
>> sending the non-optimized version - libfuse should not do another lookup
>> then.
> 
> I am confused about one thing. For FUSE_CREATE command, how does it
> matter whether kernel has done lookup() before sending FUSE_CREATE. All
> FUSE_CREATE seems to say that crate a file (if it does not exist already)
> and then open it and return file handle as well as inode attributes. It
> does not say anything about whether a LOOKUP has already been done
> by kernel or not.
> 
> It looks like you are assuming that if FUSE_CREATE is coming, that
> means client has already done FUSE_LOOKUP. So there is something we
> are not on same page about.
> 
> I looked at fuse_lowlevel API and passthrough_ll.c and there is no
> assumption whether FUSE_LOOKUP has already been called by client
> before calling FUSE_CREATE. Similarly, I looked at virtiofs code
> and I can't see any such assumption there as well.

The current linux kernel code does this right now, skipping the lookup 
just changes behavior.  Personally I would see it as bug if the 
userspace implementation does not handle EEXIST for FUSE_CREATE. 
Implementation developer and especially users might see it differently 
if a kernel update breaks/changes things out of the sudden. 
passthrough_ll.c is not the issue here, it handles it correctly, but 
what about the XYZ other file systems out there - do you want to check 
them one by one, including closed source ones? And wouldn't even a 
single broken application count as regression?

> 
> https://github.com/qemu/qemu/blob/master/tools/virtiofsd/passthrough_ll.c
> 
> So I am sort of lost. May be you can help me understsand this.

I guess it would be more interesting to look at different file systems 
that are not overlay based. Like ntfs-3g - I have not looked at the code 
yet, but especially disk based file system didn't have a reason so far 
to handle EEXIST. And

> 
>> Now there is 'fi.flags = arg->flags', but these are already taken by
>> open/fcntl flags - I would not feel comfortable to overload these. At best,
>> struct fuse_create_in currently had a padding field, we could convert these
>> to something like 'ext_fuse_open_flags' and then use it for fuse internal
>> things. Difficulty here is that I don't know if all kernel implementations
>> zero the struct (BSD, MacOS), so I guess we would need to negotiate at
>> startup/init time and would need another main feature flag? And with that
>> I'm not be sure anymore if the result would be actually more simple than
>> what we have right now for the first patch.
> 
> If FUSE_CREATE indeed has a dependency on FUSE_LOOKUP have been called
> before that, then I agree that we can't implement new semantics with
> FUSE_CREATE and we will have to introduce a new op say
> FUSE_ATOMIC_CREATE/FUSE_LOOKUP_CREATE/FUSE_CREATE_EXT.
> 
> But looking at fuse API, I don't see FUSE_CREATE ever guaranteeing that
> a FUSE_LOOKUP has been done before this.

It is not in written document, but in the existing (linux) kernel behavior.


You can look up "regressions due to 64-bit ext4 directory cookies" - 
patches from me had been once already the reason for accidental breakage 
and back that time I did not even have the slightest chance to predict 
it, as glusterfs was relying on max 32bit telldir results and using the 
other 32bit for its own purposes. Kernel behavior changed and 
application broke, even though the application was relying on non-posix 
behavior. In case of fuse there is no document like posix, but just API 
headers and current behavior...

Thanks,
Bernd




