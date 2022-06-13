Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140654878D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385951AbiFMOq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385923AbiFMOoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:44:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D76B2EA1;
        Mon, 13 Jun 2022 04:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNpyXwXhGGrBIaNRpxb0o7f7PJIILiXXDyQyvQkw8G829OorY7DNj+M/VDV/utddoivc5sJLxs/D5zmkuz5x9///KlVhxvot7vqMwAofpKk2AMROXyJHP5hkGanJ8/o1keiZqdm9sDmSC/2i0RP5u88vUy2P8fOxayvIuXdz6EXxpPFSxNrz7Xcvinbxg51IC+P9f08ZbKxc34Wn2oq/zSGnXPcw0HnE7R30CPDJ7WgNbNc+jitY+PYWOw48XWYLMYokgab8MvfZLY6S/51eff47kFmhFYvf3t9siZ1ns0C584XPbaosnOgr7eOeo8QQDVRd3OElrsR6wFD0+DHIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIz7+06G+8Too1uS7gtSGTR2zn2LrH7bHEs7qr5PVOk=;
 b=CHzfuGuf3zA48rRok3n8tX7ONnxn6C9eoXTL6BGFDpYbH5sWqklsXUuOkKPHXpqK/JgJ4PqrsderBSmXSf2wfuobNLXg4GLDZSXtGLo6nWQ5EZpmLPsGniOhCVPyz9Ie6F+Rm4bZgLbQ760h+TXJjCrImEILUQYC3IsvM0oPB9Gclwq50hxIu//c+dUXY+zqAbNUNbU7YCdQ7d6cthTowTUyi9yjJuXxyFJLp1505+tWRCyRqTWR9ZfciXHWwe6YBgQQcRWEulebVBxD41mhRgjjEMEKmhMp3pZj/zSsyszv4SLe5mDXJ+PxP76t3ZZRMPo/A7K4ForPzDlh0PthFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIz7+06G+8Too1uS7gtSGTR2zn2LrH7bHEs7qr5PVOk=;
 b=Am/mT1NSiYAQwxPnX3vFQbUsZqqObWDUKiitktOWaQfSfXf11IuMlb/Y0shGiG3XSZ7q3gALyHtzir5WD/5ymWXuw6kSdQuI8U4+ZK/7CEY+FjGe1zEblz+spz4VJJGtqEEXyOFB4KBUkfPDPwWdNbVW9z+Hbw+kduQS/0D/qeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2347.namprd12.prod.outlook.com (2603:10b6:907:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 11:50:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.019; Mon, 13 Jun 2022
 11:50:37 +0000
Message-ID: <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
Date:   Mon, 13 Jun 2022 13:50:28 +0200
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
References: <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a6ea1b8-4ba2-40d8-1f86-08da4d32ee86
X-MS-TrafficTypeDiagnostic: MW2PR12MB2347:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2347E91FD8857E13DA8E452583AB9@MW2PR12MB2347.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMpvz95+kZGCgEvFGwsy19S/+NL7tLzp0SSDHEoGe7OwM7/cJw6CsAluBVjtOBKPQV6mhzYuzWTV9ehO84ij+4yajzpbZ/RoYZyD2wagks/B86X4SP/Q/9d9Pay4NOuuibJVA9AHcvbcTssxXpXytoiwf/x01Pyd8/7XcgmN2iKs8MbaVo0/EtlivQZDUcTlRfG7Eqi5IR1SP/YBJs924E5HC9xAZOs/21mW5u+LPCnR7I6shsxhyWpsBu0P8fti9X9kJ7xMUfTFIQYYY6sIbusQy7XVtl2AEamcsqdXCaJes7Gj6vm21BXKOOcUc93Zg7KJqUo6nifURlwRgNxLubb8Z3SA0nTjJP3rVZqqZJ13g68biia6aAaHUbaVO6jM+zROxRk6cR3oueOMiFPo9zOqcJir2rWxoTJN5xC+xbPrNBq5OyN2/0uAcmqObdO8AKu5RrL95xEoirnWCzsoQ5N/7RnBsqJPvDbvS2QR1R+S0B1DEfHiLQzdZhZJgsz5DEmU12CBIg9wEGMHgHIYnUCNbBYMsllCpolH1moM0is8k56j0klN3zJQXEXvqvog1+JSdCIRSmrVMFDH1AVHHYNU3ww8uNvI/Lgc8DKlIT71C/1/82eTw+A90q/E8dm/VdH6ryiAmAWIZGwQGwGYU+JXct3LoX2ntuMLGoKfgHyeTDPCKqLP38bf+P2FaiHFWSTnGmMPz26tbiyDeaHt9tGxeOaXPZhqqAZC08GOnfPw6rV4YD0WhB4qEIv2oPQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(8676002)(31686004)(86362001)(36756003)(5660300002)(7416002)(110136005)(8936002)(66476007)(66556008)(66946007)(6486002)(316002)(2906002)(186003)(26005)(2616005)(508600001)(6666004)(6506007)(31696002)(6512007)(83380400001)(38100700002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFIZEdOcFNxUUQvT0REcjFQaTZjcVdWUldqTisyYzNQYWlYMWsxbTFqMGw4?=
 =?utf-8?B?Smg2WHRNQzJDQ3NQMjhwVk9NanV3N0FTNVQvejhDS01zZ3MySVZhSkJHUHYx?=
 =?utf-8?B?K0NqamR2MXZxblM3TzVQMms3WWpNdG9xK055ck1YQkFqY2JlNElQazNBK1hT?=
 =?utf-8?B?NjlkVzNLY2xQSWhicHZqY21FWmpZdUlkcWhBcHA4OE9NQ043bmR5cU93OHN4?=
 =?utf-8?B?QlZldW9BcnorNFhlUWdkcGY4WktMMFNtTUxvTDVsWlhMWDljcDg1UHpQMk1M?=
 =?utf-8?B?d0pIaDc1YndPbVlMalRzaEFzb1BCSnZZZXlnYjVoZ3orMFphcFN1eHlRUjVF?=
 =?utf-8?B?N3JEUzR0aWYzUGw1KzlLUGhLUFhoNHhVMXNKcEFjc2hIL3BDVGgzQ3lqRlQx?=
 =?utf-8?B?dnNpbjNwbGk3alJQcUlVUVYzbWFselpqNlZaSVZIMlhhTXEwd0FsdFFOL1Nx?=
 =?utf-8?B?TWR2ajVnSGRVRUdBb24rN1dVWVRBNDBhN3E4WW1yYXZ6dEM0TjdjejVxUVRD?=
 =?utf-8?B?MGU1QklCdSszUW9PaE5XWFhlVW5oZUJmZTdzZWRJOHdJQjcxZWZjVUpEd3FZ?=
 =?utf-8?B?cjlUd3lxeGlTNWNuczRsZjB5N2lOaDdQWlI5RkMvNEM3WnhDQ1hXZ3BoQ2xi?=
 =?utf-8?B?WDFmRXY3c3RCRkxBaXhOeFpIVkVTYVQvdkdjMzYvZitEVERWUXd4SGRmZ3ZZ?=
 =?utf-8?B?YmYwc0Z3ZTRHWDBIRnIraEd3d1JqelVadkRsRXRxRlMvT2R2VWU1eVJzd2Vn?=
 =?utf-8?B?Y2drbTBZT0VFZ0g5VlFQbEFmVjFKbDQ5bUswSG9HVVRtYWxHY1BVTCtPU1RK?=
 =?utf-8?B?NCtRQlc5YzFwYzVyRzJ4SzYvd0grRW14MGpMc2Y2TTBWVE9RM3NsOVBaeGly?=
 =?utf-8?B?enFTd2hMVmIwZmJ4NUUzL0prQ3gvdTd3MVdVUGtQTmNHZWlaZkNUcTIyOTA1?=
 =?utf-8?B?dUQyVE02c2Z4cm1JeW1ZZlFUYkZNQzlKWXJFd1Iyb3l4SVYyd1pvd3plSVIy?=
 =?utf-8?B?QUNLekRWV293MEpPTnovbG9PZmFPMEhSUG45ZTd2a1NnN2VJYlBrQ0JxOUt3?=
 =?utf-8?B?b2hmU09IeG9TVURjbzVJQTVOU1k1NXhBbVYzRm5YakdkeVZFYlJoajc1TkVz?=
 =?utf-8?B?bGxkR1cvYTZJZnpIY3dERGdSR1hJUXZoeGthc2ZaVUlvbnpSUjlMNm45M0Fr?=
 =?utf-8?B?VUtvM1N4aTdEKzNoaHlaY0xHUGkyUnRFVUV6UGpMdm55TFdDM0NxenRqOWYv?=
 =?utf-8?B?QWxTNTdtWU90R0NIWDdwazBPRWVIS1QvRGFhZlJlVGN3MnpiY3ljV1U1blZY?=
 =?utf-8?B?L2dXMmdaS2hreVBhWXhTY3JnRjZ0STNkTms3a1pHWEpISWtEUUljM0VMWkVN?=
 =?utf-8?B?cnFSU1dVSDhNcG1ZS2JNSHRucGFnWTBrYnovVDJtZ0pHY0g2NjhYVWNrR2hS?=
 =?utf-8?B?dWc1eDZHY3F0ckNaeFFwMVdHRVcvTmNIblFMaTRIaGgrSTVVNCtpRjRONW1t?=
 =?utf-8?B?Lyt5YXY3MVRQcHBzUWh3WDhCWTN6NXl5bm8zdFc0Q3NEYXp5amxHYkpwZVlQ?=
 =?utf-8?B?RTZLN2pDYUd1UDZwTTBHUW0wbkxQUkpwYXVCa0lCelFLWDhEcHRaQ09lejFr?=
 =?utf-8?B?SkFkaU0wYUNSdkdqNTVjVi9lQlJLL0x0MkQ5SG93VnRqenI5ejBnVWVHODBB?=
 =?utf-8?B?VWkrZEVpWUZaSCtOSkFBZXdWMDVQSmZWMmR2Uy9TQVBvU3RXY1NMd2hWTS9o?=
 =?utf-8?B?eThpYWlEejRqQjBVMFllSHB2UDd1b204Tm82RWJLQW42bHh6ejI3dUhMZWxj?=
 =?utf-8?B?ZGZCV2gvZFFHRlE1dGh2VW12UlpiWGRqUHRrbVhnUXluV3pSbXpOemU2NWxY?=
 =?utf-8?B?QlRpVFVwcWFxTDgzWlFtMk00akZnL1RaRDVmR3BVTHpwYlhzYWJxY0RrWWc2?=
 =?utf-8?B?YzdCTUM0UzRWTFVOQlI3aFVYS1VDMkdJR2x2ZVFMcWMwejBrZjhZT0ZkRnFq?=
 =?utf-8?B?UTRkR3JDK2N4cWNRdFlsUTBpQjNDbUJQZmxqSWlQVCtvdm5tRnphU2VobFQ2?=
 =?utf-8?B?dTFrL2xBRHRYR3FwcUgwYlV3ZlJZZUpCSEQ5OTZKRzdGQ2pmT0JKZGI1Y1Ay?=
 =?utf-8?B?d2NlTUwyRVJiYUd2bVJhbEdQenlKdFRZemgwTU9VaWFqMmZGRHNCODFyWmxL?=
 =?utf-8?B?OXBmUUFtZGFZaHM1ZUZLSnNXdjdYT1krSEZ0bGlNUGVaZElCam56MzdDNWZh?=
 =?utf-8?B?K1ErdjZaS29sdjZZc1RKOHpZMEZqTERJeDFmTXlmM2RwaWZCNHZQS216Vm5r?=
 =?utf-8?B?dTVRNTNqbDhjWnBXMHg2d0NlMENVMkovWENvbDZ4NFVUeklNL2s1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6ea1b8-4ba2-40d8-1f86-08da4d32ee86
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 11:50:37.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE/TMEX/aN6YSmK1QXWb93UJZ327wus5/rdTndnfOgqg6Yj8DX4ymzLrKDVocXqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2347
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 13.06.22 um 09:45 schrieb Michal Hocko:
> On Sat 11-06-22 10:06:18, Christian König wrote:
>> Am 10.06.22 um 16:16 schrieb Michal Hocko:
> [...]
>> I could of course add something to struct page to track which memcg (or
>> process) it was charged against, but extending struct page is most likely a
>> no-go.
> Struct page already maintains is memcg. The one which has charged it and
> it will stay constatnt throughout of the allocation lifetime (cgroup v1
> has a concept of the charge migration but this hasn't been adopted in
> v2).
>
> We have a concept of active_memcg which allows to charge against a
> different memcg than the allocating context. From your example above I
> do not think this is really usable for the described usecase as the X is
> not aware where the request comes from?

Well X/Wayland is aware, but not the underlying kernel drivers.

When X/Wayland would want to forward this information to the kernel we 
would need to extend the existing UAPI quite a bit. And that of course 
doesn't help us at all with existing desktops.

>> Alternative I could try to track the "owner" of a buffer (e.g. a shmem
>> file), but then it can happen that one processes creates the object and
>> another one is writing to it and actually allocating the memory.
> If you can enforce that the owner is really responsible for the
> allocation then all should be fine. That would require MAP_POPULATE like
> semantic and I suspect this is not really feasible with the existing
> userspace. It would be certainly hard to enforce for bad players.

I've tried this today and the result was: "BUG: Bad rss-counter state 
mm:000000008751d9ff type:MM_FILEPAGES val:-571286".

The problem is once more that files are not informed when the process 
clones. So what happened is that somebody called fork() with an 
mm_struct I've accounted my pages to. The result is just that we messed 
up the rss_stats and  the the "BUG..." above.

The key difference between normal allocated pages and the resources here 
is just that we are not bound to an mm_struct in any way.

I could just potentially add a dummy VMA to the mm_struct, but to be 
honest I think that this would just be an absolutely hack.

So I'm running out of ideas how to fix this, except for adding this per 
file oom badness like I proposed.

Regards,
Christian.
