Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE402347B2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhCXOwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 10:52:45 -0400
Received: from mail-eopbgr130139.outbound.protection.outlook.com ([40.107.13.139]:30023
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236247AbhCXOwQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:52:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doS3oVgOOcs8uNwpdR0R/S0X5zdPXZfhQ/XUvehUn5kzxDet2NFVAc9VAtnwHlD9o6wtpp8wx46ApDYMkEvqaas33EKaeW5WWTvIU91ij6BcuaH+6q+HFMATokJ5PompwNG7Hl7yxFvKxvqJb8JvM4Fj8tHDhAtwzmgFPqbSSk+vPBMNUYBRCDnk1Bc5Pn7w3gjtoGtNwx2QBfqYVJQUCvTaw4GFoyMe5L0lVx3xBpXGFJaQXOURLWaR73EQgXJUZnitYNVeAPJvkPrJsXa6VnSumG8h0zzPYiEMD8csXcnb8ER5ZU02U09rM/jQv3DwOAK5ZKRBvhp5Rh2QxpCJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmWVw3J5HTQRBFgUg20wZue6CmfiEvxFpRG3knnhMv0=;
 b=fgGmEphdc0+ueVfKfyD0htoWg3vmhaXwpxA+N3p11bcoHkLTiWo2eG5G7YmLq4ia3oUWANBs+S1IOY6vddezO0y/tHW5W1L+D+owxi5gQECnKTr9eMl4CEA13PIWkQhAcEfTRoKovRf3DTondLVSKO4EGbtbQ2EW9zoCXsUDq1TbyruXor18QcIjKFOlmUcYAJncK+VrietvPxSflW/dgIDUmrRfVTiJ83bf0IUgqquf8Ng1wb7t47kE1k6/udCfoHnTLZS/SCogoeERoFVlOP2D2ETNF0QBMVmEL7UCA7m2uEd3KX4X24VR2GGge5nWnG+S8zqLy0Ifc0V7BAnELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmWVw3J5HTQRBFgUg20wZue6CmfiEvxFpRG3knnhMv0=;
 b=juZZoH8hi1I6wPH674mwrCnhtXY17EZG8A3xdATwafTy+7PTuM336rVhT71kJToXFCjUOMzkSNLt3oUpd5q50dtUoI2YyyMu8JqpU7xRoqH8+xeLuVsHVK7B4rDPP8sxP3kebp3xuad2KeFSQlAhEU1QdCMbJ5cRx3GDFVomWUg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR0801MB1632.eurprd08.prod.outlook.com (2603:10a6:800:57::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 14:52:12 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a%5]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 14:52:11 +0000
Subject: Re: [CRIU] [PATCH] mnt: allow to add a mount into an existing group
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Pavel Tikhomirov <snorcht@gmail.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, crml <criu@openvz.org>,
        Andrei Vagin <avagin@gmail.com>
References: <aba1e14c-8af8-e171-dbf8-c9000ddccb70@virtuozzo.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <96115c40-3fc7-e3d6-ecd8-1be2969e5ff4@virtuozzo.com>
Date:   Wed, 24 Mar 2021 17:52:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <aba1e14c-8af8-e171-dbf8-c9000ddccb70@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM9P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::28) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (81.200.17.122) by AM9P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 24 Mar 2021 14:52:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2d7a3ae-2ad6-4a67-a9b0-08d8eed467b7
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1632:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1632C6C1C9403760AE2AF193B7639@VI1PR0801MB1632.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //LDa+yWi39Hr+oWdrTggoU/hx75fZKMNLnadF9EynFVh8SKJjOEE7pf1pPS0Wt5uYSNSoNo+IpDLIXUGIasCRQP1OMMNddLTS02SsqgrwIz9tT/OLUbJOZNIPJOpO/CeiX8bnq4JtmbNjQZU2U4nJ5OlFjB/BnDX6KNAX7CtKBS02cqe1m1aGrTpRRqJ/6zeP8sjMsEb8AeI3D0vs+VrqYIx7yGxhoql7YbzhjDMlV3fSw39Vpj2dZjok195NiWOTXsVqyKn/EySOWkiaUUO7QAtxaT7Ylfb0wtX0NEHvf/Pz9bfbHsOl0e2miQu9qzD1+cMXFErvuQXt4Ybn020mZpAXYkzyJc0sAkr2w0YiPdfwumazKs6LUGsqDgh4KNv5OuoVNdGC4eXzr3juw1d1qQp1SJx8dN6KVG7PBYvfJtxOOJkAQ5bQTQzFxH2Ytx5SqY2yb4DsPdvp4+vF25j06oAArqliIWfpEHQs+2AhJIrsbMHS8Rmay/fiRjAAP4dMkaI1A9GKDJ5a8Xc/fe+49dexwRkzPXEcDnklWo7I0Za1/JLF8knCLdPe4GGJTqbMkKycaQ2qoqMJsgMfN4KU8s/ten1e6m0SRc4vX6p30Hmmfy8whx3uel5j9g60M4vIZoFKh2Ukd3a9dTWTYINkVd4AGBCCZefh7vM0L5BvgDjwkTPYIvIsB/hwjX4crvWj70/hAwjrZcH9ouiJtNO8HnfJCgFmQycVr//S4lx5awp65SZmEjcdZp77V9T6b6qxviOX4Sh+l+J9rymTWn0L9MqlI1deAYbXuYHSXHwiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(366004)(396003)(376002)(346002)(2616005)(478600001)(83380400001)(110136005)(956004)(8936002)(6486002)(5660300002)(31696002)(36756003)(31686004)(54906003)(966005)(16576012)(52116002)(316002)(86362001)(53546011)(16526019)(186003)(38100700001)(66946007)(66556008)(2906002)(26005)(8676002)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZFpPVEYxYjA1OFhsODVibllYczFlTUNOeGwxdFdRL1BLZ2xsd3BodStCK2NQ?=
 =?utf-8?B?NEZoQjUxWTVmN3ptNFdDdzhpU25KNFFHVld2RHFwT21Xc2JCRzg3YzZmMnF2?=
 =?utf-8?B?blROb1NJMWhYS2NsYVF6VGR0SkZQM2hyR2swVS8xZlJ6c1k1dWk4SVo4Sjkr?=
 =?utf-8?B?cS94Q3l0KzhjLzlXRXdMWXZxeHdJL0Nxa3dlUGNZczdNeEdxYkFsL09WSkhi?=
 =?utf-8?B?bmN6TTVaWGVjanlwaW5ubFBncW81Z3UzRzhIQVhpSjJFQjJDTitSVFR5SjRZ?=
 =?utf-8?B?V0dTNTZMVFBuQzdSY3Z6MnlETjBhTFJycy9SNjIyZnhIZHVJdEtHaHFES2NP?=
 =?utf-8?B?UGM3UGRZbGE5cTVKMXdkUFZObll6bDE2NG9taERka3VUa2tNWWxnSmpDMFZp?=
 =?utf-8?B?YnNmUWJTZW9GVE9OVXlqTDNaSWxhT1ZBMjlFWkJPTXloVHl6VkhOTWppdW85?=
 =?utf-8?B?Wlh1NnQ0cllKN1V4T3dMUkFEeHNPYjlhd0hzcnVUaFpHMVc2WU9VWmJFUFVC?=
 =?utf-8?B?SEs0YzZSYW90eXEvT0hleTdYTUZrV2hHdTQyVGUvYTcxdkxkWXYzOEJNSHU3?=
 =?utf-8?B?dktEY3M4ckIyWWZuSkdUYTF6RktzQ2RXdmpMVEFac3laS2NHRTVFakRpMVJn?=
 =?utf-8?B?bkRxQ3FmcExwV0RUbWNLRFQ0RGZUZjdGU1NZNGpCRjd0aU9IM0tDakJrYkFQ?=
 =?utf-8?B?VE1teStqNHpFWXNUYWpLT0lsWXVwS25Nb1JnZnc2ZmNpckdVNEQvY2Z2WEtH?=
 =?utf-8?B?UEUvZ0V0YzdWcFIwWm9JZG5aTGMrZEVXWjNsZjU3TGJrMndJUCtFNDUvM0Ew?=
 =?utf-8?B?QnU3YnJETzlxUk9KMmllUVk2dEdTeTJVT3BBRi94NU56T0VOek9EcE1uTGpN?=
 =?utf-8?B?YTRxMHVkZ0NvT1dWbVNjcnBPaXROem91Q2RTMzA2TmhDL2lDVmtzcFNNdTJQ?=
 =?utf-8?B?QmxNUGFGZ2h0ME1WbkxHM1ZIeEFCSFQyT1NOSVlDeTBqeXl0MEtwODZiWXZQ?=
 =?utf-8?B?NUIzbW9NUVJDNWtSMEg4c1ZZeks2dmVOeFo4Z3hXVmlib3dtSWE3Tk55N2h0?=
 =?utf-8?B?cUx3Zzd1SGxJdjE5QUJvcnVZWCtaWnAzSFdERG1MQks5L2RPam5LQnZJSkV1?=
 =?utf-8?B?eVVObFB0OFRXb2hOUHh0SWtiTlE5bVpEUkNtRUZ6aldvNmg3ZDdPeGNyU1pi?=
 =?utf-8?B?YUZUR2tMQUo4UmVCeldvMmV2WnkvVWhkWjJnWm50eEhMRGRJNXREak1tWUNj?=
 =?utf-8?B?T3NGemU5VDR1d0d5V3pES3VnUjVpeWNRZ3lhS1VvTlNLdEtFb0xtVFRUNFNZ?=
 =?utf-8?B?YjBicVVCTWxSVlVNazZNdjBPcUxNeXE1R2hNUkRnalBLeHlnRW1hVlZ4OVNr?=
 =?utf-8?B?bjdMRmpOWndTVC9OMXZBUWJodXhuaHBxbUVJTkdqbU5zb250V0IyOUR4Q3U5?=
 =?utf-8?B?MGpDNXZwVmZuTjBVOCtCU2oxZS9xWVBYU2RMWDBmOFcweFhLNWpiMWNoVTU4?=
 =?utf-8?B?dGRJTDQ0Yyt5blJFTFFhRkxGTGs5VjRZTkhvNzhGQ0xLak1LRStjb0syY1Rz?=
 =?utf-8?B?NFBIZlZkLzFTT1IvazZvV2s3Zm4zeENHR0hvRmxhYU1EemlaN1M0TU9NQjBw?=
 =?utf-8?B?Tkk1WnQzMFJSak5CQWU0UmVLRzQycERNV0Y3SENjaHBqMDZ4Zml4eUxpWHpl?=
 =?utf-8?B?K1AwdDF2UkM4bkpkd1VuQ0J4M0lHUVdoODFPYThIYUtNMVF6M2lNMEp1U0Nh?=
 =?utf-8?Q?Ew5YqMWvzJrKv0D4NMNY9lugxlbEdVwg39WPlSD?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d7a3ae-2ad6-4a67-a9b0-08d8eed467b7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 14:52:11.8569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3F0RYGqHGx0b+rnwvpLSm5HkCaHPCXMikTGPLScKINV8PCDdYrCTt98ijNqmFkcrBRoVA01RHhvWdzb/U/fHa9SafntRTiZo+VG2K+tDxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1632
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Andrew to CC with the right email.

On 3/23/21 3:59 PM, Pavel Tikhomirov wrote:
> Hi! Can we restart the discussion on this topic?
> 
> In CRIU we need to be able to dump/restore all mount trees of system 
> container (CT). CT can have anything inside - users which create their 
> custom mounts configuration, systemd with custom mount namespaces for 
> it's services, nested application containers inside the CT with their 
> own mount namespaces, and all mounts in CT mount trees can be grouped by 
> sharing groupes (e.g. same shared_id + master_id pair), and those groups 
> can depend one from another forming a tree structure of sharing groups.
> 
> 1) Imagine that we have this sharing group tree (in format (shared_id, 
> master_id), 0 means no sharing, we don't care about actual mounts for 
> now only master-slave dependencies between sharing groups):
> 
> (1,0)
>    |- (2,1)
>    |- (3,1)
>         |- (4,3)
>              |- (0,4)
> 
> The main problem of restoring mounts is the fact that sharing groups 
> currently can be only inherited, e.g. if you have one mount (first) with 
> shared_id = x, master_id = y, the only way to get another mount with 
> (x,y) is to create a bindmount from the first mount. Also to create 
> mount (y,z) from mount (x,y) one should also first inherit (x,y) via 
> bindmount and than change to (y,z).
> 
> This means that mentioned above tree puts restriction on the mounts 
> creation order, one need to have at least one mount for each of sharing 
> groups (1,0), (3,1) and (4,3) before creating the first mount of the 
> sharing group (0,4).
> 
> But what if we want to mount (restore) actual mounts in this mount tree 
> "reverse" order:
> 
> mntid    parent    mountpoint    (shared_id, master_id)
> 101    0    /tmp        (0,4)
> 102    101    /tmp        (4,3)
> 103    102    /tmp        (3,1)
> 104    103    /tmp        (1,0)
> 
> Mount 104's sharing group should be created before mount 101, 102 and 
> 103 sharing groups, but mount 104 should be created after those mounts. 
> One can actually prepare this setup (on mainstream kernel) by 
> pre-creating sharing groups elsewhere and then binding to /tmp in proper 
> order with careful unmounting of propagations (see test.sh attached):
> 
> [root@snorch propagation-tests]# bash ../test.sh
> ------------
> 960 1120 0:56 / /tmp/propagation-tests/tmp rw,relatime master:452 - 
> tmpfs propagation-tests-src rw,inode64
> 958 960 0:56 / /tmp/propagation-tests/tmp/sub rw,relatime shared:452 
> master:451 - tmpfs propagation-tests-src rw,inode64
> 961 958 0:56 / /tmp/propagation-tests/tmp/sub/sub rw,relatime shared:451 
> master:433 - tmpfs propagation-tests-src rw,inode64
> 963 961 0:56 / /tmp/propagation-tests/tmp/sub/sub/sub rw,relatime 
> shared:433 - tmpfs propagation-tests-src rw,inode64
> ------------
> 
> But this "pre-creating" from test.sh is not universal at all and only 
> works for this simple case. CRIU does not know anything about the 
> history of mount creation for system container, it also does not know 
> anything about any temporary mounts which were used and then removed. So 
> understanding the proper order is almost impossible like Andrew says.
> 
> I've also prepared a presentation on Linux Plumbers last year about how 
> much problems propagation brings to mounts restore in CRIU, you can take 
> a look here https://www.linuxplumbersconf.org/event/7/contributions/640/
> 
> 2) Propagation creates tons of mounts
> 3) Mount reparenting
> 4) "Mount trap"
> 5) "Non-uniform" propagation
> 6) “Cross-namespace” sharing groups
> 
> Allowing to create mounts private first and create sharing groups later 
> and copy sharing groups later instead of inheriting them resolves all 
> the problems with propagation at once.
> 
> One can take a look on the implementation of sharing group restore in 
> CRIU if we have this (mnt: allow to add a mount into an existing group) 
> patch applied: 
> https://github.com/Snorch/criu/blob/bebbded98128ec787950fa8365a6c74ce6a3b2cb/criu/mount-v2.c#L898 
> 
> 
> Obviously this does not solve all the problems with mounts I know about 
> but it's a big step forward in properly supporting them in CRIU. We 
> already have this tested in Virtuozzo for almost a year and it works nice.
> 
> Notes:
> 
> - There is another idea, but I should say early that I don't like it, 
> because with it restoring mounts with criu would be still super complex. 
> We can add extra flag to mount/move_mount syscall to disable propagation 
> temporary so that CRIU can restore the mount tree without problems 2-5, 
> also we can now create cross-namespace bindmounts with 
> (copy_tree+move_mount) to solve 6. But this solution does not help much 
> with problem 1 - ordering and the need of temporary mounts. As you can 
> see in test.sh you would still need to think hard to solve different 
> similar configurations of reverse order between mounts and sharing groups.
> 
> - We can actually prohibit cross-namespace MS_SET_GROUP if you like. (If 
> both namespaces are non abstract.) We can use open_tree to create a copy 
> of the mount with the same sharing group and only then copy sharing from 
> the copy while being in proper mountns.
> 
> - We still need it:
> 
>  > this code might be made unnecessary by allowing bind mounts between
>  > mount namespaces.
> 
> No, because of problem 1. Guessing right order would be still to complex.
> 
> - This approach does not allow creation of any "bad" trees.
> 
>  > Can they create loops in mount propagation trees that we can not 
> create today?
> 
> There would be no loops in "sharing groups tree" for sure, as this new 
> MS_SET_GROUP only adds one _private_ mount to one group (without moving 
> between groups), the tree itself is unchanged after mount(MS_SET_GROUP).
> 
> - Probably mount syscall is not the right place for MS_SET_GROUP. I see 
> new syscall mount_setattr, first I thought reworking MS_SET_GROUP to be 
> a part of it, but interface of mount_setattr for copying is not 
> convenient. Probably we can add MS_SET_GROUP flag to move_mount which 
> has exactly what we want path to source and destination relative to fd:
> 
> static inline int move_mount(int from_dfd, const char *from_pathname,
>                               int to_dfd, const char *to_pathname,
>                               unsigned int flags)
> 
> As in mount-v2 now I had to use proc hacks to access mounts at dfd:
> 
> https://github.com/Snorch/criu/blob/bebbded98128ec787950fa8365a6c74ce6a3b2cb/criu/mount-v2.c#L923 
> 
> 
> - I hope that we still have a chance for MS_SET_GROUP, this way we can 
> port mount-v2 to mainstream CRIU.
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
