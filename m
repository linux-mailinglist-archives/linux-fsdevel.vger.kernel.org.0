Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65F51DDBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443848AbiEFQpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443847AbiEFQpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:45:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC475FF07;
        Fri,  6 May 2022 09:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeknEKxbl9mAHgS/alMiXQS6BnPLfvojQi/glpTLY4o0YnBKV5CS5M7oBBIN4uRiB2CLX4zw+jC+S1svn54R6tTtaq9hkl36+4/3OO/gvY4eXaHWT6tjMW2n+CAcxmpvLd1azllZERJJMyp/gD18hP/i4y17SQW7aTZoWNbwyUNqYUSLKKlyIPp/nDJBMIYMZYU5PcrF+jFuVJhrw6sKvuK2HUOm1Zc/yBW/44cpw4bh4VGn9uUPz4vcxQvHRKZwCqgfKQAgiucl03pF3AxvnQ9lxhwsMypvTEXeO0l2a5pZ6jdMF1SSH6FJlvqpXVNSPRraYVxQsmzPTwrDBgFr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpKq8a07gPzDGJIyo48tn5mlciefYarPzn2/xktvghs=;
 b=QTSydKK2zQ8lWoYZWzVJnfG1SkiVOcMveuPro9k+/NJ/FevvAwiERS8vPE2mqT59YhDrTmiJ62pJW14Qd5eLfzl8+Ri2c79ogjz4Thkbk9Ah3X0Gc5zzxzV5XOkfvEEqUOZ6MikIl/VlQPJo/o61wuK1q3JsWtXWUpw+Cu+mJ4Ze0FTSlCaTLknt+DD6uFSRSLC+OiiDb6mFawf/2a+4teFN2vjMaP0bBystBbW7xT4HyfvW9ZI0Az7pg7etTfG/RvW6nGF7pleoaQ5hFUzqOJGD/MfQbCqN9o737u0iiWr41QyP8h4CS2gqssBf8R0xvwM75c36N28fo2g2rZLyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpKq8a07gPzDGJIyo48tn5mlciefYarPzn2/xktvghs=;
 b=U3xoDNPWKRViOIJVByTX1Kxv6agfQKrJOH/YMyInWFLO9Aj+1ImmZiXq614GLrPTA0lVJ6k/cRczh8S0prPNoDobAU90MpSOF+Q+uLerYg8stW+In9J1eXPDEQZk7eBEXMd3mqn/+TKzH12Q8DU3gpVQAupBBkYvyNTEjEeYhL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BN8PR19MB2641.namprd19.prod.outlook.com (2603:10b6:408:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 16:41:22 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8072:43ab:7fd0:26a%4]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 16:41:22 +0000
Message-ID: <78c2beed-b221-71b4-019f-b82522d98f1e@ddn.com>
Date:   Fri, 6 May 2022 18:41:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Content-Language: fr
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
 <YnPeqPTny1Eeat9r@redhat.com>
 <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
 <YnUsw4O3F4wgtxTr@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YnUsw4O3F4wgtxTr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::31) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8397d7e2-9442-44f6-0d05-08da2f7f40f3
X-MS-TrafficTypeDiagnostic: BN8PR19MB2641:EE_
X-Microsoft-Antispam-PRVS: <BN8PR19MB2641F0E0AA12C3DC11DB5D7BB5C59@BN8PR19MB2641.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3VbK8eM8exM03zWU8Jy7MXwGug7pRG3f8qjjbbtZSqeIlLyUtofJWIwccp6DSuZem/V92OWp0UMga9UxdZvonbbziPWo4u9GSrVjr+S85iZ0KzChObjGOOKq0XS2u0BwK7JnO//6PHtbZGaOsS8fMdSLx5otTgwn5JcJLcfOSDA5AfEVnhzILPpjULP2i3NnYdoUjag5lFXvOOYnxAC3C7u7M0KgTVyAPxospCvO8pM9FxMteLF9zANZe98qjpo/QGIPmgvs+y5FD6aNexaomTuBWsqsLy+HTGS7/CjDc02Hq4nCXkCcXYRkLHdoGDVjxGV9lJbUeiiqcem5P0uvk9R5bJjzyMj6E128JSKxGUX9K8vsGSh9gq4/F4/oCPwVDF5oBY5GMrqKOVEBKLcWl9W9TpcJd+7OHwX1aek6ksvEOn3tjfYxGMn1PQC46HzMwnNFwtsggbgkmVMoy9MiKHqc76vogQJHTwTUuSUUOC/Kd9vA72M3YvYmjeM3/FcsncSyTss47rv0PI7lRP9j6uAZ7eE2nCaMMFQBNzrAiai9R9FrqglcHB3W3Jwc5X5lRnx//OBLLpaeSQ1JC+w2dJdeMhgf7XbKot4xNp1cx3ilyo1a6GsEVjLhf4bmMTZWzdWNDBRBu4k2oRZnRQA9yPnonVhsVgZam837pODBmZC9kopDuFAm16wYoAHiModLclh5WXVFH+2tday+E+no/5v/3Cat/lO/WFJotQ/O10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(186003)(2616005)(316002)(110136005)(83380400001)(31686004)(53546011)(36756003)(5660300002)(6506007)(508600001)(31696002)(6666004)(2906002)(8936002)(6486002)(38100700002)(6512007)(4326008)(8676002)(86362001)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZXckVjTzFvVGVkREtVcGhqZ1c2YmNtUjBsc0E3dXRjZGRCT21vYVM2b2Jy?=
 =?utf-8?B?UVhkdEQ0ck1QTTlTbWdxNFg0akhIWXdBU3pnRDJRSjZ6MnhJdnJwL0tzL21X?=
 =?utf-8?B?STN6aFZvVlgwMzFhUS9CRW9qenZXVldlUHlTaG9oYVJVYSt0MkVZQ09URmFm?=
 =?utf-8?B?UDlibVYvVmRPSFVPejZQV0lLN25MZFlTWG1qSGxpUFp6dFpZdGxIS2YxR1N5?=
 =?utf-8?B?VXJRVEExdHNNWGVFV1czWXNlY3V0eFNyV0d3VEJtWkRxaUllSXdValJlejRR?=
 =?utf-8?B?Z0NNcDBRMHN1N3E3eDF5T3FnaFQxVUdyR01vWjZVN1NVbnJNR3NhaEZuNTJa?=
 =?utf-8?B?Q0EvRGYzUk4zRndHelg0VVhaZ3BYd1IvTjRPVGU3MzByWWl2VXRXYmdCaHpK?=
 =?utf-8?B?UjdNbkdKc0p2b2g0MVkvMzlnaWh5WFNwbGVydDBPdWFRcEJ6OWIzRlEyNUx2?=
 =?utf-8?B?N0piUGtPNktKTDR2NGhuMWZoNUtXQTcwNElCQURpNHZJY1h2dnZVbGVLMmlD?=
 =?utf-8?B?L0pSSkFWVHpkZUtvNzI4UEdzN2JmRjRSaWxpQVEwZEk3cTlBcUpzZ1ZuMDA1?=
 =?utf-8?B?NENONVd2RUk0anJCVUhUZXNjNnJxVktKd25TVFBaYzg1VURzK0RVb0ZRVUNE?=
 =?utf-8?B?NnlRd1c4MlUwTE84NlY5SGNIblM3ZllVWmVqV0I3dlcvTERUN1BkdjZ5NGI5?=
 =?utf-8?B?S01UUHBzaFBheUJlV2V3UWV4eVlEQy9HbHE2M3VXd1RudE9QWEZxemZnRFJ5?=
 =?utf-8?B?ZER2eVVFVUhEVlAyald5T04wQkIxeE9Md0ZiTFd6U0FGWC9QaTd5elNUc1dl?=
 =?utf-8?B?ckVnYkdJd1p6dHlUMWNCUGJZOHl2VSs0MHBMM1ovVlBRbVN4RUdlVThTYzVk?=
 =?utf-8?B?NnFPdW1EeW1HSEV1YkdxUjRqRkpmeU96QlZydWVYUXZNRUV6Y3JlaVBuWnVI?=
 =?utf-8?B?OW1XMHl4RnhKOGFHS1RGcm9RS0s0YVZYWktQcCtPdjVtTmt2eWJLOGFrMUll?=
 =?utf-8?B?NnJ2Zm5GWldBd0tNUUdzM2cvMG9vQkxhR2hES1g2Z2RzYVN0a05iOWNpamt2?=
 =?utf-8?B?b1YxNUQ5S3MrTXN1RHpHaGF6SkljRFVZdTFpdlJ2UXhqM0pJKzROck5mdGRq?=
 =?utf-8?B?aE1PU1VBRmJ3eFQ4ZFFORXNtS1JjZjU2YWpEK1NOYUtoUG9LOGdTajMzM2lh?=
 =?utf-8?B?Q2x3ZmU2Qi9OQzBKU2JaRU9jOWc0WXVGWDRnQmYrNk5GK3k3eEExV2xUeisz?=
 =?utf-8?B?UWRVWmRDRW01UThBaDhiaUFwOTdmWVgyajZFMlRVWm84MytYRTk2Z2R2U21y?=
 =?utf-8?B?dlhDdzZKUzdvV21NNFpsZnBPU0NjblhGS1lKQVJNcFhQN3lFb1NSN1R1dEV6?=
 =?utf-8?B?enFENWMwN2NqRzNXZXhZc2ZaNkFoOHFIUDJRVWlWaEFGRW12Q21WckU1MEwz?=
 =?utf-8?B?WVYwcXVPM0pCVmpvYy9wL1hVeEpRY1h6d0lQeitkM1lxcmY0ZU0vRTRwbTVI?=
 =?utf-8?B?Q0pNanVUWW5Od2RCMUp0S2Q3ZENVemxSNmNwQUVrd2E2R0FiN3FmclNxN3Zn?=
 =?utf-8?B?VTVZRTJVdkJCcHFwa1pJMDdnM2UyTlNBUjBTU0U1RU44ZVd2ODhYZ3MxeFFy?=
 =?utf-8?B?UENBQ0sra3VLZzUwK1UvK3MvbUZGajZRc2I2K0hNcEVMRk5ta1FhMk5iMU05?=
 =?utf-8?B?NjZJZGZiNjdkdy9rdVZCYklYcFdWeXBwcWg5ZjJXM05YdjVPcko3YXp4bTRD?=
 =?utf-8?B?U3ZTUWRhQTVaRVVXeFgweS91eEk1UW0xOCtSaXBFeFRhQWN4NmxjdjBxL0hE?=
 =?utf-8?B?eXNWMmtjL2RmRnpBQnlFVWdGeC9OOTRZOUxpRWR3SFhNR3dzbndSaVMxa3oz?=
 =?utf-8?B?UVRJeFdUYU5qWTNhRFczZm5seXFLM3BqM3FEN3RzNFkrakxnOUdEYjdYcjBD?=
 =?utf-8?B?YUJpNThQUWc3UUpOUy9EcWV1RnIvOWNUci9uRTZlK2VNUE9YS0p5SnNxZkJm?=
 =?utf-8?B?NlN5dlZUY0JqQk54a3l0MFMvejlNVENicnBFb2ZtQTBDTWJ6VkVlTEVqeUdz?=
 =?utf-8?B?NVlzMGViZU1xL1RaS3VsQmZ4S1RId2JFSEZnbFVlclVtR0tFYjNJZ1NtVVds?=
 =?utf-8?B?bngwaWpvRmkrTG03RzZWaktnU2RNRTlzRVc5RkkvMElvQjJvdWp6YVNWN3Ft?=
 =?utf-8?B?T2VpK0hFNm5kZ2RGVEduVlk5dGM2ZW8yQkRBenhlVHN4TzFVZlR1Q1RHL1N3?=
 =?utf-8?B?cVNtaGY3WkNEYTgreE4rdEEreWN2TTNndmdOR3pBenVYVTVMdmJVM0lYK1pR?=
 =?utf-8?B?ekc2bnJPNU9UajFuR3RCZTJBTWQwSEhRSDdqNDlha3NXV0lyWE1sYnR1T3Ey?=
 =?utf-8?Q?97L7nQw1xX0JJFrbD0thshgwhDzZkXrfkUAc722/JxIsE?=
X-MS-Exchange-AntiSpam-MessageData-1: WOJqkT7xZ3lZ4w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8397d7e2-9442-44f6-0d05-08da2f7f40f3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 16:41:22.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKixAemioT5ePCtlvX8ixOmFsyyKpzaiI36OhYO06Wa9J9la0o1xjqNQd2Nl05zjQBCOvdQVZawg2M9C3j5PEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR19MB2641
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/6/22 16:12, Vivek Goyal wrote:

[...]

> On Fri, May 06, 2022 at 11:04:05AM +0530, Dharmendra Hans wrote:

> 
> Ok, looks like your fuse file server is talking to a another file
> server on network and that's why you are mentioning two network trips.
> 
> Let us differentiate between two things first.
> 
> A. FUSE protocol semantics
> B. Implementation of FUSE protocl by libfuse.
> 
> I think I am stressing on A and you are stressing on B. I just want
> to see what's the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE
> from fuse protocol point of view. Again look at from kernel's point of
> view and don't worry about libfuse is going to implement it.
> Implementations can vary.

Agreed, I don't think we need to bring in network for the kernel to 
libfuse API.

> 
>  From kernel's perspective FUSE_CREATE is supposed to create + open a
> file. It is possible file already exists. Look at include/fuse_lowlevel.h
> description for create().
> 
>          /**
>           * Create and open a file
>           *
>           * If the file does not exist, first create it with the specified
>           * mode, and then open it.
>           */
> 
> I notice that fuse is offering a high level API as well as low level
> API. I primarily know about low level API. To me these are just two
> different implementation but things don't change how kernel sends
> fuse messages and what it expects from server in return.
> 
> Now with FUSE_ATOMIC_CREATE, from kernel's perspective, only difference
> is that in reply message file server will also indicate if file was
> actually created or not. Is that right?
> 
> And I am focussing on this FUSE API apsect. I am least concerned at
> this point of time who libfuse decides to actually implement FUSE_CREATE
> or FUSE_ATOMIC_CREATE etc. You might make a single call in libfuse
> server (instead of two) and that's performance optimization in libfuse.
> Kernel does not care how many calls did you make in file server to
> implement FUSE_CREATE or FUSE_ATOMIC_CREATE. All it cares is that
> create and open the file.
> 
> So while you might do things in more atomic manner in file server and
> cut down on network traffic, kernel fuse API does not care. All it cares
> about is create + open a file.
> 
> Anyway, from kernel's perspective, I think you should be able to
> just use FUSE_CREATE and still be do "lookup + create + open".
> FUSE_ATOMIC_CREATE is just allows one additional optimization so
> that you know whether to invalidate parent dir's attrs or not.
> 
> In fact kernel is not putting any atomicity requirements as well on
> file server. And that's why I think this new command should probably
> be called FUSE_CREATE_EXT because it just sends back additional
> info.
> 
> All the atomicity stuff you have been describing is that you are
> trying to do some optimizations in libfuse implementation to implement
> FUSE_ATOMIC_CREATE so that you send less number of commands over
> network. That's a good idea but fuse kernel API does not require you
> do these atomically, AFAICS.
> 
> Given I know little bit of fuse low level API, If I were to implement
> this in virtiofs/passthrough_ll.c, I probably will do following.
> 
> A. Check if caller provided O_EXCL flag.
> B. openat(O_CREAT | O_EXCL)
> C. If success, we created the file. Set file_created = 1.
> 
> D. If error and error != -EEXIST, send error back to client.
> E. If error and error == -EEXIST, if caller did provide O_EXCL flag,
>     return error.
> F. openat() returned -EEXIST and caller did not provide O_EXCL flag,
>     that means file already exists.  Set file_created = 0.
> G. Do lookup() etc to create internal lo_inode and stat() of file.
> H. Send response back to client using fuse_reply_create().
>     
> This is one sample implementation for fuse lowlevel API. There could
> be other ways to implement. But all that is libfuse + filesystem
> specific and kernel does not care how many operations you use to
> complete and what's the atomicity etc. Of course less number of
> operations you do better it is.
> 
> Anyway, I think I have said enough on this topic. IMHO, FUSE_CREATE
> descritpion (fuse_lowlevel.h) already mentions that "If the file does not
> exist, first create it with the specified mode and then open it". That
> means intent of protocol is that file could already be there as well.
> So I think we probably should implement this optimization (in kernel)
> using FUSE_CREATE command and then add FUSE_CREATE_EXT to add optimization
> about knowing whether file was actually created or not.
> 
> W.r.t libfuse optimizations, I am not sure why can't you do optimizations
> with FUSE_CREATE and why do you need FUSE_CREATE_EXT necessarily. If
> are you worried that some existing filesystems will break, I think
> you can create an internal helper say fuse_create_atomic() and then
> use that if filesystem offers it. IOW, libfuse will have two
> ways to implement FUSE_CREATE. And if filesystem offers a new way which
> cuts down on network traffic, libfuse uses more efficient method. We
> should not have to change kernel FUSE API just because libfuse can
> do create + open operation more efficiently.

Ah right, I like this. As I had written before, the first patch version 
was using FUSE_CREATE and I was worried to break something. Yes, it 
should be possible split into lookup+create on the libfuse side. That 
being said, libfuse will need to know which version it is - there might 
be an old kernel sending the non-optimized version - libfuse should not 
do another lookup then. Now there is 'fi.flags = arg->flags', but these 
are already taken by open/fcntl flags - I would not feel comfortable to 
overload these. At best, struct fuse_create_in currently had a padding 
field, we could convert these to something like 'ext_fuse_open_flags' 
and then use it for fuse internal things. Difficulty here is that I 
don't know if all kernel implementations zero the struct (BSD, MacOS), 
so I guess we would need to negotiate at startup/init time and would 
need another main feature flag? And with that I'm not be sure anymore if 
the result would be actually more simple than what we have right now for 
the first patch.


Thanks,
Bernd

