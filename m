Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2421D345ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCWM74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 08:59:56 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com ([40.107.20.123]:2304
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231476AbhCWM7a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwHsrB2IT3b7iu55CZUVFE8hPeFk55hg4zXlX+TXWffjCr/1RnoVxXlL3as4j9H3qV8ZYxukr1JBalPsFmrjlKQ9V0dNEEZ87O7UWY0nZL6Zj/y3rYdfaQLZ4Z/2i0R5tnpdo0uuOv2Fs4FhK0wIyWQlDkstE4BmVVrd/eTvE4Y5bi1tUeR3ce/RuZWiNJBCGmlYW8iQprn7fBJdeO1IzHwSW2zeCXpj6CaPRgEjCI+bCMihvQTp2ipjVqLx444P1YzOnY+Mi3cjsD19XmG/TCmixjahvGWDsmH+jj06PWh+WPMFz8DDTHhyX/GonEGNLakY8PaW2oC4aEu338gibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uTZCJBdMzr/PKsLaVRWLGZlNcMBGDRnutxP+WyVVIo=;
 b=L/oLmqXSNUZto6myYxz+/CaANGZKgpnDime2kNKWBw0z0NjKAeTncdGvxt44OqMY7I+Bvw7jzP/0pnUuW3sJY+MEFFQSNOTRFsz8EXWUJNJoqX5icTDS1/87FEvYToCRrwt2K2NVx8HspLUy9ARvOk3zgFmBQyZwSnHjz419C/BhHqRtSjlBXGni1VbjyjS/OSM8L8INtGw00iI3hLwXQCWMQy1KoIAf6oh/RSi2pnGku+kjIzEpK8xq66JZvK5PrDkeqbNgdHN9LZgDM2ZEXJw9toYr+Hd8BuuNvLZiUylZcae4rdoFfGYO5AElRqvnWxpUk2SzKh+jDIcMxSyUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uTZCJBdMzr/PKsLaVRWLGZlNcMBGDRnutxP+WyVVIo=;
 b=bZtLD69RNPIGcaPsx2tFgIRSPce1QLuEVavdN0LTN8pl8ISc3rEM5QKelXnzWxTdyumzcrTlMZxsBAqWsjX5tIHQ0R3wW4+Y4oigILdWre9R8E4dyvSF3/NnzljtizhqMCOWBJIFmIAgjkclcd26P9uJxgBOYFDHbs9YDqoAKUc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB5375.eurprd08.prod.outlook.com (2603:10a6:803:130::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 12:59:26 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 12:59:26 +0000
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Andrei Vagin <avagin@gmail.org>,
        Pavel Tikhomirov <snorcht@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, crml <criu@openvz.org>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20170510235834.GA7889@outlook.office365.com>
Subject: Re: [CRIU] [PATCH] mnt: allow to add a mount into an existing group
Message-ID: <aba1e14c-8af8-e171-dbf8-c9000ddccb70@virtuozzo.com>
Date:   Tue, 23 Mar 2021 15:59:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
Content-Type: multipart/mixed;
 boundary="------------34BE2693C3EC608F4771CA57"
Content-Language: en-US
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM3PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:207::17)
 To VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (81.200.17.122) by AM3PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:207::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 12:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2d2d24-5d63-47c6-1561-08d8edfb7d01
X-MS-TrafficTypeDiagnostic: VI1PR08MB5375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5375B4CD0CD610979891366CB7649@VI1PR08MB5375.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uzo0V88lLT9YWcE9+w/943BnsupKApkUM00c6r2w4LyWUld7QbUGOQPCoCrdEHSkOyqudvC+99cseq5hc7KyMDNU98abYbCahSVa28sfQNqRfuyc9fz/D6JYyTnj2yDNIl4mwpKGO7RgdCnSyqVqzQUtffl73AbGO8lYR48cJA1UqfzXAosPX9FYSv7n+7gWdp2AVsaALLwutg41AYFEaAiOArp1gehyncBjxSNpeBQUDtEznFpqqNscOLJlhFy8Ea8IkkYXGnB/YXFvpRTYsjAVm4M2P5napfAe6pop5ZK4zrC/DJPvOPwynFCgTaGzyjFqeHs6/40YBhkyLQk/gRYgZgALwribDl/nSfpa500Ai2GKJl6ifOjR8Xy+zW6e8xBuS4VIRmhTAm3TjIr0Mlwq2aEoaq86D3d+CF6sOHEi6y7S2Px1GCI/xWPjTmUl+CiIDySIVyQPXdQCvRN0WEDJS074hv9blDBDeXPTUMDrlmhWDdFB4lSVL9bVRYEsj9U1JaZRS6oosT2gQmlXJct8Fuat5ZuXWGVk0CwUwFOhWeaxDGOYQFWLzzPtaRk8A/Jn0NaeEW4R0QmCXPTu452/ChHGKkspiwRH/UPQ8TaSsZYuwK0UpZbcC2n402qSoSHGFRKw8Zi2/cOBFR/AA3N0+Mdlw7wyntJhNQJGoLqv9j9DmRANYZMGlqU/jgV4gMW2powYyuGTeCyP4QE4eQEssnB61PSrWu+/lXWzay6y4cFX9EyWZTiVNvTYgJcUVgl9yBgCMhukDfAYUvaTnPOQ9+5Xf4VSrTx3tMB46gA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39840400004)(366004)(376002)(16576012)(31696002)(54906003)(86362001)(26005)(5660300002)(956004)(110136005)(2616005)(6486002)(16526019)(316002)(31686004)(235185007)(66476007)(66556008)(186003)(66616009)(66946007)(478600001)(36756003)(38100700001)(2906002)(8936002)(83380400001)(107886003)(52116002)(4326008)(33964004)(8676002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z0Z6OGxwK3dYYVNCUkIvd2Y0UkZ6NSt6bFVWUlQySUlUUU5kbzlXOWdzbnF0?=
 =?utf-8?B?K2JUc0NWbkR5TGdmREltRkN4eDErSFRoa21nUHdxWERVRTNueDFXUm5tY2tM?=
 =?utf-8?B?NzB2MWxQT29nS1pybHdmY1BIcTJzZVg2M1M3VDkzajVBV05ycHJCRnZsVDh0?=
 =?utf-8?B?Z1lxbnlJRm05UEhUZExmR3Brd2xrQm1XUjhVSHBmWTdJaUs0UWxhRElLaWNu?=
 =?utf-8?B?Nm5YVVczMGhtQmUvR0JndjdBdGVQZ0owWWZBRTNuSmpEdlNodHVwdlQ3RGlY?=
 =?utf-8?B?MGtid0hscW5ValpDMEV0K1paZGxtNXZsV0pkTDFrbTNTc1hvVElTTTZYOERV?=
 =?utf-8?B?NktEMzd1ZGp0WHFaVDA4T2c3ay8rR2NVSFc2bTU1Rk1vajF5ek0yMXpSd2o3?=
 =?utf-8?B?MVU4azJEY0EwZlAzQXFTOVpQYm82WDVxN3pmVkxZOE5mTG9EbWNkQW1TSlFh?=
 =?utf-8?B?RFlCL3F5OGdENUJyeFlmR1lZSmlCM3JVRVg4NW5IOEZmbjh5RTA4VVpsaEZS?=
 =?utf-8?B?UWo5UlQ0TWNka2VVdXljdnRwOE9XTlB4d2pmU2hnZVI0bGswaU1VVFNCRUcv?=
 =?utf-8?B?c2IyZUl5ZFU0VFQ1U1FBUTBLWTJCSm4vYjNqcXhqRDV1TUdyUG5ZS2E2UHQz?=
 =?utf-8?B?eENGUkkwNCtONkdRU0RvR1RkOThEd3BUL2ZZU216c2NMTzBEM3gvUHR5R0Rj?=
 =?utf-8?B?dW45c3JUOWZEMkgxdXdHbkJhSEluMEJoR09va1NxWG43OEpIcXNUczNXalMv?=
 =?utf-8?B?ZjdlejVBQTRha2VObjhxeW5xSklja3dRSDdlRDlXOUZnZkpsWXphNU9Wa3dG?=
 =?utf-8?B?bjkrTmdjZ3B2MUJIdmt6VW1oajJreVdoN2JRVUxRRU9ZaWhEd1ZVckthWG5p?=
 =?utf-8?B?dXUrTEJ5NVRyaUdKaExqcXZoWUpHUmxwZGlldmRBNGVpeHVJdTRmNXB1VEtL?=
 =?utf-8?B?UXcvSVo3N0pRZGhwZ2JHQ0hRM2FjUTdKUFZiUkthYnV3VWJZS1UxSmovV0FS?=
 =?utf-8?B?Uit4dFJHaXZucVRKdGFGM2lNNFBLOGtLdEVLUmtGUUJLR20xUjBwRndicVA3?=
 =?utf-8?B?eGhMN2dCQ2JoRUpNOUtURjR3VHVzbytYd2orL000c3FDeFcydjhKWVNwNzNL?=
 =?utf-8?B?LzcyamVMVlo5NE5sVEhhMTJqVU1IRFA4TkU3WlZXUnVvWTVLL1poRkx4VytK?=
 =?utf-8?B?V1ArNVNJbTZlYnJKbjNJbFh2MGxqM3FoT1RCQzdOZUh5Tk9yRDh4eW5FQ2JL?=
 =?utf-8?B?ekVhNjdiR1prZTZLNktjOFJlUVRLa3RuaVVOZ1I4bzlKRWhRQTUvVG1NNzlX?=
 =?utf-8?B?WnpRWVh5UXQ0T3JUamhvbVNRZkhnMmZOV05OYlA0V2d2cU1LQ0ZMWlBSSmwy?=
 =?utf-8?B?UzZJbmJoc1lBSXVXbUFWbDMvcjVCWC9Ob0ZZVHQ4UEw3eUhydWlQcHMrR243?=
 =?utf-8?B?STlsay81ZzY1RkVFS24xeDVMVDVjUng4cDZuOElxbU5RZ1l4ZnRzdDhvTkRJ?=
 =?utf-8?B?SmNsemYyWFRPVUxiRlF2L2l0QzJ3WWt5ZmlaaWMxSHdjY2gxSHhKblNhK3dC?=
 =?utf-8?B?alNOL2Q4aEtaSWI2MDRqdzdYVWFsRkhuSzRndnMvazlRRkVsT0NqTFVvY2JI?=
 =?utf-8?B?WC8xZGU0eTlEV3JqYkQ4RkZKRjIxVkNXVTRKUTlob2syMVNIZjFmVjByR0RC?=
 =?utf-8?B?WW1rMmJZWjcvTlNCdEMvWGlhTC9ZL0FRWGdoY1FTV1ExcFlVMkMwQzEwVDAv?=
 =?utf-8?Q?vwP23Sq2Nz1d4OEQEt6nLcy+LnEvy2UU0JQi0bN?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2d2d24-5d63-47c6-1561-08d8edfb7d01
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 12:59:26.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UX5Pow8KxCdC1A+ufW30UNLzMUdQnp6tScQFGPl6MmUcaj7d95jqlRVYHuGDeMZzS4V4PuBmsDMAMRfFugwtm9ysXXmNXZlGuDNuCcG15OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5375
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------34BE2693C3EC608F4771CA57
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi! Can we restart the discussion on this topic?

In CRIU we need to be able to dump/restore all mount trees of system 
container (CT). CT can have anything inside - users which create their 
custom mounts configuration, systemd with custom mount namespaces for 
it's services, nested application containers inside the CT with their 
own mount namespaces, and all mounts in CT mount trees can be grouped by 
sharing groupes (e.g. same shared_id + master_id pair), and those groups 
can depend one from another forming a tree structure of sharing groups.

1) Imagine that we have this sharing group tree (in format (shared_id, 
master_id), 0 means no sharing, we don't care about actual mounts for 
now only master-slave dependencies between sharing groups):

(1,0)
   |- (2,1)
   |- (3,1)
        |- (4,3)
             |- (0,4)

The main problem of restoring mounts is the fact that sharing groups 
currently can be only inherited, e.g. if you have one mount (first) with 
shared_id = x, master_id = y, the only way to get another mount with 
(x,y) is to create a bindmount from the first mount. Also to create 
mount (y,z) from mount (x,y) one should also first inherit (x,y) via 
bindmount and than change to (y,z).

This means that mentioned above tree puts restriction on the mounts 
creation order, one need to have at least one mount for each of sharing 
groups (1,0), (3,1) and (4,3) before creating the first mount of the 
sharing group (0,4).

But what if we want to mount (restore) actual mounts in this mount tree 
"reverse" order:

mntid	parent	mountpoint	(shared_id, master_id)
101	0	/tmp		(0,4)
102	101	/tmp		(4,3)
103	102	/tmp		(3,1)
104	103	/tmp		(1,0)

Mount 104's sharing group should be created before mount 101, 102 and 
103 sharing groups, but mount 104 should be created after those mounts. 
One can actually prepare this setup (on mainstream kernel) by 
pre-creating sharing groups elsewhere and then binding to /tmp in proper 
order with careful unmounting of propagations (see test.sh attached):

[root@snorch propagation-tests]# bash ../test.sh
------------
960 1120 0:56 / /tmp/propagation-tests/tmp rw,relatime master:452 - 
tmpfs propagation-tests-src rw,inode64
958 960 0:56 / /tmp/propagation-tests/tmp/sub rw,relatime shared:452 
master:451 - tmpfs propagation-tests-src rw,inode64
961 958 0:56 / /tmp/propagation-tests/tmp/sub/sub rw,relatime shared:451 
master:433 - tmpfs propagation-tests-src rw,inode64
963 961 0:56 / /tmp/propagation-tests/tmp/sub/sub/sub rw,relatime 
shared:433 - tmpfs propagation-tests-src rw,inode64
------------

But this "pre-creating" from test.sh is not universal at all and only 
works for this simple case. CRIU does not know anything about the 
history of mount creation for system container, it also does not know 
anything about any temporary mounts which were used and then removed. So 
understanding the proper order is almost impossible like Andrew says.

I've also prepared a presentation on Linux Plumbers last year about how 
much problems propagation brings to mounts restore in CRIU, you can take 
a look here https://www.linuxplumbersconf.org/event/7/contributions/640/

2) Propagation creates tons of mounts
3) Mount reparenting
4) "Mount trap"
5) "Non-uniform" propagation
6) “Cross-namespace” sharing groups

Allowing to create mounts private first and create sharing groups later 
and copy sharing groups later instead of inheriting them resolves all 
the problems with propagation at once.

One can take a look on the implementation of sharing group restore in 
CRIU if we have this (mnt: allow to add a mount into an existing group) 
patch applied: 
https://github.com/Snorch/criu/blob/bebbded98128ec787950fa8365a6c74ce6a3b2cb/criu/mount-v2.c#L898

Obviously this does not solve all the problems with mounts I know about 
but it's a big step forward in properly supporting them in CRIU. We 
already have this tested in Virtuozzo for almost a year and it works nice.

Notes:

- There is another idea, but I should say early that I don't like it, 
because with it restoring mounts with criu would be still super complex. 
We can add extra flag to mount/move_mount syscall to disable propagation 
temporary so that CRIU can restore the mount tree without problems 2-5, 
also we can now create cross-namespace bindmounts with 
(copy_tree+move_mount) to solve 6. But this solution does not help much 
with problem 1 - ordering and the need of temporary mounts. As you can 
see in test.sh you would still need to think hard to solve different 
similar configurations of reverse order between mounts and sharing groups.

- We can actually prohibit cross-namespace MS_SET_GROUP if you like. (If 
both namespaces are non abstract.) We can use open_tree to create a copy 
of the mount with the same sharing group and only then copy sharing from 
the copy while being in proper mountns.

- We still need it:

 > this code might be made unnecessary by allowing bind mounts between
 > mount namespaces.

No, because of problem 1. Guessing right order would be still to complex.

- This approach does not allow creation of any "bad" trees.

 > Can they create loops in mount propagation trees that we can not 
create today?

There would be no loops in "sharing groups tree" for sure, as this new 
MS_SET_GROUP only adds one _private_ mount to one group (without moving 
between groups), the tree itself is unchanged after mount(MS_SET_GROUP).

- Probably mount syscall is not the right place for MS_SET_GROUP. I see 
new syscall mount_setattr, first I thought reworking MS_SET_GROUP to be 
a part of it, but interface of mount_setattr for copying is not 
convenient. Probably we can add MS_SET_GROUP flag to move_mount which 
has exactly what we want path to source and destination relative to fd:

static inline int move_mount(int from_dfd, const char *from_pathname,
                              int to_dfd, const char *to_pathname,
                              unsigned int flags)

As in mount-v2 now I had to use proc hacks to access mounts at dfd:

https://github.com/Snorch/criu/blob/bebbded98128ec787950fa8365a6c74ce6a3b2cb/criu/mount-v2.c#L923

- I hope that we still have a chance for MS_SET_GROUP, this way we can 
port mount-v2 to mainstream CRIU.

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.

--------------34BE2693C3EC608F4771CA57
Content-Type: application/x-shellscript;
 name="test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.sh"

bWtkaXIgdGVzdDEgdGVzdDIgdGVzdDMgdG1wCm1vdW50IC10IHRtcGZzIHByb3BhZ2F0aW9uLXRl
c3RzLXNyYyB0ZXN0MQptb3VudCAtLW1ha2Utc2hhcmVkIHRlc3QxCm1vdW50IC0tYmluZCB0ZXN0
MSB0ZXN0Mgptb3VudCAtLW1ha2Utc2xhdmUgdGVzdDIKbW91bnQgLS1tYWtlLXNoYXJlZCB0ZXN0
Mgptb3VudCAtLWJpbmQgdGVzdDIgdGVzdDMKbW91bnQgLS1tYWtlLXNsYXZlIHRlc3QzCm1vdW50
IC0tbWFrZS1zaGFyZWQgdGVzdDMKbW91bnQgLS1iaW5kIHRlc3QzIHRtcAptb3VudCAtLW1ha2Ut
c2xhdmUgdG1wCm1rZGlyIHRtcC9zdWIKCm1vdW50IC0tYmluZCB0ZXN0MSB0ZXN0Mi9zdWIKbW91
bnQgLS1tYWtlLXJwcml2YXRlIHRlc3QxCnVtb3VudCAtbCB0ZXN0MQptb3VudCAtLW1ha2UtcnBy
aXZhdGUgdGVzdDMvc3ViCnVtb3VudCAtbCB0ZXN0My9zdWIKCm1vdW50IC0tcmJpbmQgdGVzdDIg
dGVzdDMvc3ViCm1vdW50IC0tbWFrZS1ycHJpdmF0ZSB0ZXN0Mgp1bW91bnQgLWwgdGVzdDIKbW91
bnQgLS1tYWtlLXJwcml2YXRlIHRtcC9zdWIKdW1vdW50IC1sIHRtcC9zdWIKCm1vdW50IC0tcmJp
bmQgdGVzdDMgdG1wL3N1Ygptb3VudCAtLW1ha2UtcnByaXZhdGUgdGVzdDMKdW1vdW50IC1sIHRl
c3QzCgplY2hvICItLS0tLS0tLS0tLS0iCmNhdCAvcHJvYy9zZWxmL21vdW50aW5mbyB8IGdyZXAg
cHJvcGFnYXRpb24tdGVzdHMtc3JjCmVjaG8gIi0tLS0tLS0tLS0tLSIK

--------------34BE2693C3EC608F4771CA57--
