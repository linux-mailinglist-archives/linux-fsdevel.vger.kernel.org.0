Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5886654666B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbiFJMRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiFJMRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:17:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5B25F932;
        Fri, 10 Jun 2022 05:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN0m77pfrJtbBKhU6Qzfi4f53El/W1dfpmXJIegYoaJWJtOXhj2jTW+TyrtmYWbZvpPre7iR2szcddJmCwH/5SkjLZHCDJfNsIGXiKYsI4UzuHmnho5ZSaMJmAo6ylc0iU+IpfVBcIswDhvhMfCOdXr9m9tbUsL2WMfl2hrsudhli43NDTomkJaSWfD27B5fugs8aig9qjyd7jIeQ5WZOxRXA4UiETO2ayl/rt4kDzsDB4+lQQAeLVEGXP6XRng6TURcGNJ212z4tXedpQl4KsdGY52d8nAq7ZMqoPageaci6ZV/3NLHzP1yDGO1ZfFTZXiqEWdoqGTbuvJ8ZCR6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSVe3h2btA7RagEo00B0AhD5kEw78Y1wH9n/L+s8yrc=;
 b=KZ+fHoMBULkwaTsqfGc4Ux4wPP0uP9X7mp6JA4gdygE7GxuIJcyIihbDPKWS08n8eHZ5pJ6Jo7z9FSkdxFRRHSdac5xr+T35ETeOwkOzb5zkF2ECjEKq4tJQmHuuht/s20PzeTzCqjsZ0A466bdIwNAbLwEI9p7cF6UjMo5v7SXt6Q6tfJxTLyhtNixZg/EZJMctUv35IqIVl24xV72EVvLF4pCu99HyYP3AEPAjV7GPHHCPTWAhTBxu17BnvPRCHKCk3//EpVb9v0x1B8m+hTjOXWdLfZs/J7S+9Z+UoCsi8TjCqDZAmHI3p/nPItOmSrVk4Bk3SpaO4yPLbKt91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSVe3h2btA7RagEo00B0AhD5kEw78Y1wH9n/L+s8yrc=;
 b=4Ti0jqNpf594XOtxF/clj+LyOPpE5X8eiA2Yk7pDj0rKai5QJp1QJdIwYUI+f/RTvkYq+dsO5rIpZ2R53lP/eBBr5dm1CAkz5z4lRSG0RUq46DgDcQQ6N42H2yUgZpaWzCR4v+QZV+C/GlO1JNxn49Xk7jUzJRcb4/atWioz7BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 12:17:34 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 12:17:34 +0000
Message-ID: <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
Date:   Fri, 10 Jun 2022 14:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 333a0ec7-f578-4625-c457-08da4adb32c6
X-MS-TrafficTypeDiagnostic: BL3PR12MB6450:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6450DFD9552F013FAE35405683A69@BL3PR12MB6450.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skMKg9tz6wisoNK2qE/hVmbhkky11s9xzvrYbXn2zV4bu1KWIU8zPteOiyYT1OaWAt9EOM3rNuXW79YD4odSFQ3oWCek3XfoMY9wrcRPHb8ifOLRSuYgWIG4LF480vRD5FF/Etbm7ItCbuGtTfrHy8KVoknNqzfgwqb4CcC2viW0TTD367v7wUwfWIEqlqCZlnCT3zhnBIsa9BVlYrPODoIRND+IzmdCE0pug8OzxdlVyw3hq2Fd4Vnfu3UIJ2CElOOhIh2PftmBEEDLrwi96CLwf15MhLadoagZQYH571ybbTS8ETFF6vd18Lz+hoaPwfeRKBJ7WemwsFf3bqQHm6HOcVKNvtWD+d1AtZpkWPRLNrxkX1e+yY6AvSU4sCA0VxkbtJq7+lfifK1tJU45INSn06Kt0iPTY1lrhMFktUcG+oLIRpkSdZ4Xpfae3w5iPKM1JvBheea5ElLiX9UDeSdDUpzbbtk1i1DkUlpLT1Llp32RB/gB4haUiif0KdcCKcMw8CWA4vaapbjl/Wk4uJ9TIKhsBWogGFNgWxuw+Lri9mBU1JEwZze1nqI/DFmen9ZL+/V+MwSr0tiSe0cVvDtC/7w9hCqWsr75JdbYoSMwcSJOC2TjS17HzEV66VV39KiEj4cA5QJqxoKkQmtZub5yflHzrb+mSkrlaIHnjtvoNW3YIx9GhkJKKWBOMIZsVpn9WZTrdICZPGdrzYWLReFxXGqOk6LobFCNHjCL4Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(26005)(6486002)(31686004)(36756003)(2906002)(7416002)(508600001)(83380400001)(66574015)(186003)(8676002)(66946007)(66556008)(4326008)(316002)(110136005)(8936002)(5660300002)(86362001)(2616005)(6506007)(38100700002)(6666004)(6512007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZZQTJ5ajR2bldHU3JsVmtWcmtTa1pDbEZKamRHN081cnJ2TitxVkJZK3J0?=
 =?utf-8?B?NkNkYUUvaUlDR0dPQnVlTjJ3eGgvYlQ4VnZsb1pmbndMWk5ZZExkbXZjREpO?=
 =?utf-8?B?K1pXUmVGZ1dZVUpEcXh2d3hCMWh3SlA5RWxLcnlFVmZnRGJBdzR1QXMweFRP?=
 =?utf-8?B?M0s1U0FGejI0OWZVdmhZNFBFWUV4SlpoamVxeUFNdnVvUWpDOTdwV3gwd0pW?=
 =?utf-8?B?UnJhNW5wbVkydWJ0SW1GQUN6NDlwU210bS8yR1N0MWd1aXZzcHZHRXkwOTJP?=
 =?utf-8?B?ZmpyM3JmdG9kWmMzSEcvcUxqUGVpL3FUd2ZubDhpT3o1Y2dXU3hTQWlxSnVw?=
 =?utf-8?B?TTRGS3FGWXBHclpMNlljMUQxQVFpUFJIT29GaXFWUGNpY3RoN0x2ZHFMdUc3?=
 =?utf-8?B?enpCYnB0cGJiSEF1bHd6bFJ2Q2t2UndIdk96ZGg2K1FVYWhZUG1DdHRGS3A2?=
 =?utf-8?B?NGVGajArWi85K0VSYjJ4cUJQQkNvTDd3Tmp0RWU4VmxCRFdFdDhoekowUHRh?=
 =?utf-8?B?QVlhMnN2U3Mvd05jWElZR2gvWFRzQjlmUVI1d0drRVV2QU5qNEk2ajFYbWd2?=
 =?utf-8?B?dEJ4MmtvdmJ1d2pRNlh1VFJFZHVBUVhITlpmRVFRQXptUDBPemFMejNzRUJW?=
 =?utf-8?B?SjVsMjdJOWppSGdkWmpVd0lGc2pmWUVxTzJvRU5vSit3QitadzY0V1V2czZj?=
 =?utf-8?B?Vnd3dXViRlJIbUNDa2k3RzNMaU8wazVJbHNYTG1GcVpZTHE1VXlQOUhKdjdj?=
 =?utf-8?B?Y2ZCTmFINTQzeDB2RTJJVUhKcVA2YnZUWEpHUnVERFJIdnZzV2ZSbHhmSnFH?=
 =?utf-8?B?OEJTYVMzcDlLTndkcTJNVDQzWXZUY1VuUEF4MzdVRGpEYWkydjVwdXduTmJl?=
 =?utf-8?B?cFc1blY2ODRzR0hCSDg4UGdTT1JJZVBqNHhaWTFzaXlhb1pyeDF2QnhvNnBF?=
 =?utf-8?B?WG81WjV6SGlyYlFGWXZmTHBMbVJWTmVmWkZYdDhKUFpCVy9BS3VzaHpaeW1x?=
 =?utf-8?B?dXRHRnB6NXVHMFhtUjA3ZmFnVjR0NXR1OXllTEh0dDQ3OFovUXdkTkhtWlB4?=
 =?utf-8?B?bXducmw1N1A1am9mVGh6bVN1WHNrV1Y3bDlyQkZOelN3T3hETFJqQXh6bWtU?=
 =?utf-8?B?SDZiRnBWK2VvUjNtS0dCdU5FSmRnUmFnb1lRNFpqWnBEaVlLeDZBWTlYV0Y1?=
 =?utf-8?B?dWtMZHFrNjhzZHlQMitUSXM5N0x6T1ZOdFFQVGRvK2R2cktJcjFlNCtteUNB?=
 =?utf-8?B?bHE1WkVoZlZPR2o0Rk1xUWdFTU5vUmJ2ajF6bnIxeGxuSVlPZXdnQnEzTUpT?=
 =?utf-8?B?WStXMmJKeVZySWtIZ1ptbm80Tkc5SEdWT3pLSFBNeEhCVzBoMWw2cW9pbjJQ?=
 =?utf-8?B?bE5FVUdEdlpwMEFHSmJoWUs4WEVsV2Z0Z0JmV1lQRGFmVnhiNFRJeWtYOXRH?=
 =?utf-8?B?eTlDSk9qeUZEcjdzbWlJb0xBV08xRStuVVB3S2cwVi9VeDlCZ2xJQWlucklS?=
 =?utf-8?B?TFQzclVlQjcwWkhYZWNaSmFnaE5oZVFBS1NKbU9Qcm9Kd3orVldTRW9KSWxL?=
 =?utf-8?B?Q3F2M3kwcWdBdXJLYTAzYXVhaTM0dlFGTXdsVGp3VmRoYUpNQlV0MkJEa2tP?=
 =?utf-8?B?dHJaQkNTa3JzTC8vMUoyZy81L1JFTFgvV21mVDZiM3ZQeER6bC9RQVJZWm85?=
 =?utf-8?B?WVgyaUZ4eG5GOUZBL0EwN2VQV000Mi9YMTRQclEvTnpWdjZjMnZwWDBGaExv?=
 =?utf-8?B?UlZkUGY0QUF2QkJzaTd3TEJzeG5WWCs0dDVZemcxR2tpVXpLNDdvaDlyek9Y?=
 =?utf-8?B?em5JeWI4UncvL1pPR0dFUXdlYzJybzBKSjl5UHBGQ21VWFNxaURXNWZ4MjBR?=
 =?utf-8?B?dVNCazJNcVdKQWRJMmkzZXJSM1pYOG56SXJEaEpBSzNmenFveGFlSkRZMUpu?=
 =?utf-8?B?VnIvSkM1dzVlSWN4Mms2L1pHRkE5M3huU1lnSjY5bjZnUE5PZ09aWlVxei9v?=
 =?utf-8?B?bzVaSVhwY05mcUwrK2tzZlI2TnZjeXp1clVWekVJNHBsT1djRC9nTkwwcVJr?=
 =?utf-8?B?OXBIU1h2czRLbU0zUWMzSXVscUsvQlZkUUZiN3didktVOElaYWdWbGY1akFO?=
 =?utf-8?B?OXZleW5vaUJ5RUJnSEMzM2ZIVUk5VnZkWFhNcnpGd0paOW0zZHlBaXdtbCsy?=
 =?utf-8?B?TklzTmFuSG8vWGRYbC9FSzVpbU4rbGtsc0JaNEVVT3JvMzAySzNhcjdTUGlM?=
 =?utf-8?B?UEVxSG1zUW1LNjhrUmRnbEtQR2V3NmhEcXZGVElyMG8zdkcxb2JOOHpKMWcw?=
 =?utf-8?B?cFUraGRqN1BRY3lKaE8rUnczOFdueXFiTUVhbTlVc1E5b3JqWWlaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a0ec7-f578-4625-c457-08da4adb32c6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 12:17:33.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqCzSFOuEbI8602L//QgHi3ORU0oN8emOOjNpYZZ/RbuE3+ycHTNHLiTxof+qji7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 10.06.22 um 13:44 schrieb Michal Hocko:
> On Fri 10-06-22 12:58:53, Christian König wrote:
> [SNIP]
>>> I do realize this is a long term problem and there is a demand for some
>>> solution at least. I am not sure how to deal with shared resources
>>> myself. The best approximation I can come up with is to limit the scope
>>> of the damage into a memcg context. One idea I was playing with (but
>>> never convinced myself it is really a worth) is to allow a new mode of
>>> the oom victim selection for the global oom event.
> And just for the clarity. I have mentioned global oom event here but the
> concept could be extended to per-memcg oom killer as well.

Then what exactly do you mean with "limiting the scope of the damage"? 
Cause that doesn't make sense without memcg.

>>> It would be an opt in
>>> and the victim would be selected from the biggest leaf memcg (or kill
>>> the whole memcg if it has group_oom configured.
>>>
>>> That would address at least some of the accounting issue because charges
>>> are better tracked than per process memory consumption. It is a crude
>>> and ugly hack and it doesn't solve the underlying problem as shared
>>> resources are not guaranteed to be freed when processes die but maybe it
>>> would be just slightly better than the existing scheme which is clearly
>>> lacking behind existing userspace.
>> Well, what is so bad at the approach of giving each process holding a
>> reference to some shared memory it's equal amount of badness even when the
>> processes belong to different memory control groups?
> I am not claiming this is wrong per se. It is just an approximation and
> it can surely be wrong in some cases (e.g. in those workloads where the
> share memory is mostly owned by one process while the shared content is
> consumed by many).

Yeah, completely agree. Basically we can only do an educated guess.

Key point is that we should do the most educated guess we can and not 
just try to randomly kill something until we hit the right target. 
That's essentially what's happening today.

> The primary question is whether it actually helps much or what kind of
> scenarios it can help with and whether we can actually do better for
> those.

Well, it does help massively with a standard Linux desktop and GPU 
workloads (e.g. games).

See what currently happens is that when games allocate for example 
textures the memory for that is not accounted against that game. Instead 
it's usually the display server (X or Wayland) which most of the shared 
resources accounts to because it needs to compose a desktop from it and 
usually also mmaps it for fallback CPU operations.

So what happens when a games over allocates texture resources is that 
your whole desktop restarts because the compositor is killed. This 
obviously also kills the game, but it would be much nice if we would be 
more selective here.

For hardware rendering DMA-buf and GPU drivers are used, but for the 
software fallback shmem files is what is used under the hood as far as I 
know. And the underlying problem is the same for both.

> Also do not forget that shared file memory is not the only thing
> to care about. What about the kernel memory used on behalf of processes?

Yeah, I'm aware of that as well. But at least inside the GPU drivers we 
try to keep that in a reasonable ratio.

> Just consider the above mentioned memcg driven model. It doesn't really
> require to chase specific files and do some arbitrary math to share the
> responsibility. It has a clear accounting and responsibility model.

Ok, how does that work then?

> It shares the same underlying problem that the oom killing is not
> resource aware and therefore there is no guarantee that memory really
> gets freed.  But it allows sane configurations where shared resources do
> not cross memcg boundaries at least. With that in mind and oom_cgroup
> semantic you can get at least some semi-sane guarantees. Is it
> pefect? No, by any means. But I would expect it to be more predictable.
>
> Maybe we can come up with a saner model, but just going with per file
> stats sounds like a hard to predict and debug approach to me. OOM
> killing is a very disruptive operation and having random tasks killed
> just because they have mapped few pages from a shared resource sounds
> like a terrible thing to debug and explain to users.

Well to be honest I think it's much saner than what we do today.

As I said you currently can get any Linux system down within seconds and 
that's basically a perfect deny of service attack.

>> If you really think that this would be a hard problem for upstreaming we
>> could as well keep the behavior for memcg as it is for now. We would just
>> need to adjust the paramters to oom_badness() a bit.
> Say we ignore the memcg side of things for now. How does it help long
> term? Special casing the global oom is not all that hard but any future
> change would very likely be disruptive with some semantic implications
> AFAICS.

What else can we do? I mean the desktop instability we are facing is 
really massive.

Regards,
Christian.
