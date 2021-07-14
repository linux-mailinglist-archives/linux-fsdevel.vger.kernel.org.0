Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12763C886E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhGNQPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:15:08 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:21070
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230376AbhGNQPI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZloRl8Yxr/fYnjRPUzmA6ysFQqMHxbM2iL7S8T6DalaOXM6ZVwWteP3RIHRAm9Zu0mUGq142jTxOG0qmb+8Oj4UM4AQb0jorqSOWq7/JJ0mdhRFxitmK72BhOxh4MchLqRJ9gYwNxGOXfllU9kBrGRKqEAbovFlWTByqjFMm+KRdjdvA0xUO43+rmxlkhSwficNuXrRK8kN+xIFs/0o0bRyU5nj0zhNAsNGF7jbNA0mV4Fg0Jk2LHxxeBbJIjLMBioHI+vvb6kCfdGACkfrTRSB5uLbd2WXpZbFBNYs10B8GTeX8yfQFRHE3gVy0DxtRIP/fhigGN7n2zDzh7pDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mnVioa53krEFrSE8a4rhwOIp4o/cZ65reZFHiKzdCk=;
 b=EHjp6cxU5PA9zz7XhyPuEZcv9UriVENNlk5gV7hPrb2E9nOeGvs9WYXdVHi1utiDDC2Y0JLkcgDUxyaSl6WjscOw8hgCJiG60lzGgSADBLSeR/Rob8Jvo2jqe+PyAonlDw+cbodqJw03kzaYHx5fOXgQgNifQkvUr68KHeQ67Bgq+12wDyHLmVnx1WQXbEPbdgcwVSj7esT5i5UuhrY9dJG1l3yl/OgIsczv8EcfKXjXvd71JaPouwZX1bxgR7+yi8VNX50mx5jT4snY2XAZv5NIoC02Lmjuohwt231sXvZx/ZNxZcC9qpvbHpgFNCxUoLVEbGxaEPyiRRltyi3x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mnVioa53krEFrSE8a4rhwOIp4o/cZ65reZFHiKzdCk=;
 b=SORNHDEXwxUZfWRbdsT53/ed0n0cV1OvUTJUVPRnhD1qR+qGnzu03687wmtoRpFKQal+/B32M76w7CdSYmD+nm4xLaS1CUERyxtD5ePkAVOatY98ufb5XA/ZXHCTP4UDODoj00u5/A9J6ZFTILYBciiSxe+GSZp7V8g9hSsvr1I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VE1PR08MB4879.eurprd08.prod.outlook.com (2603:10a6:802:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 16:12:14 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 16:12:14 +0000
Subject: Re: [PATCH v3 1/2] move_mount: allow to add a mount into an existing
 group
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <20210714132754.94633-1-ptikhomirov@virtuozzo.com>
 <20210714144326.eddq4oerz6f6ekz5@wittgenstein>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <1398005d-1842-afc8-7e9f-4d79353b2506@virtuozzo.com>
Date:   Wed, 14 Jul 2021 19:12:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210714144326.eddq4oerz6f6ekz5@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.100] (91.207.170.60) by AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22 via Frontend Transport; Wed, 14 Jul 2021 16:12:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81812f82-8a45-460f-dc3f-08d946e224a5
X-MS-TrafficTypeDiagnostic: VE1PR08MB4879:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Antispam-PRVS: <VE1PR08MB48799EF189AA8BAB9605E1F3B7139@VE1PR08MB4879.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4g5jatIcRb64JATB1U4xddvbZ9A0NNdj/09da8KCNhm97v1o56UIMLg7qpnniFSIjNrixXvnIFos7fnSf5JmDuxZmJwzdt3wGWnABPLlVKI8TFzFTXl77eElFnBFoUp5cJAaLN6XlXdGF0fXAUaFStzwI7+ocvsY2m+vt13tHr18WvVqnazZZ4kkbzNgoMvRgPIqA0R7saju3C3Qj8FP3QgvxpVlVcpCc12Ay8fgy7fIeaOWyIGH3mKBlTpxwPvojxWXmg/A9Q6MrCzV1GmS5kiGbEn2JI1YWYY4wmEobGiWJ4SEq2Gi9Bif+Oz4ILi8kAWXfINbqCNmWsy/g/N0qcNAHNBHpk4XXIdbjWObkFHLjJFnHoXzxaECpcHdoE+OrTm1CBptWziePXM3fsbixJyjiDMnVbUozHWMlDabjeBe1MBI98p3z3hGuKkUgZd60n51qmMtpRAUkxfTfBE1iSiYID6jxInItMIMppouhGe9j4GK25GamTNbeE6WLfBPWvZEe2jm6iD6L7LEJlz2JG2EAiC5073eqzP6kukaxJLTrLDXdjhBgxP+oGuYpx+VjReNmHyYsiE5tKmqltGG++dbKa7/Nj+5ENq6DTQuG6j72HPcL70T1jnBL/1lFyz4yGVGdYp3kr5xaNtNU5IKbnu/RkxnPcFhIXPfWPmvHAxxY1SN+HxX4XEEDbzf6yCPYjI0syUWd4nNsd/lId3A4ZB/4j0mHfMIgk7W/ohG4EIwSsBTHV9eHPSvZ0oeMH6orTdMN2SOh09x98xoscpTSutQDaTCKC/fTzpOX7JlFi8ZRGjqlZLhav1M3FlmLHpA7OFWhkVL4PyD1htERfdPr4APZRG+YWbFd55xB7lZXpzyrujAHefhXsu2lwTtW1C7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39830400003)(8676002)(6486002)(53546011)(54906003)(36756003)(186003)(52116002)(66556008)(26005)(478600001)(66946007)(31696002)(86362001)(66476007)(31686004)(8936002)(16576012)(316002)(966005)(6916009)(4326008)(2906002)(6666004)(5660300002)(83380400001)(956004)(2616005)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlMwcWpNRUkzVTZNREEvWk9xb1FVeWJ1MkNSNEprS1RWTXNXNld4ckMySmpG?=
 =?utf-8?B?WmRSd01DQVl2NWdVYm9LWW9MSDFmRGtISFl0TlpJRXc1TStqRnVvSVJoZWh1?=
 =?utf-8?B?V3FZdWtJK3JMTlh5WDZONHZYdy9FakdGNE4xZmNxZXhsb090VjhTTFFlS2xi?=
 =?utf-8?B?aWFiTTB4b1Fja1JTVFFiYVliMkRkaFJFT2VVMGdzRUx6MENCNUg1ekNoMCtq?=
 =?utf-8?B?WTd3ZDZpR1JOMnplZWpyWlVnc1hQaWFuME80c1hnUGNLa0FsWldVZk1QTFcz?=
 =?utf-8?B?c2h4OWx5YnpwOEhJdmZWQTc5ZzVrMUMzUVdHZTBZcWhnYmJRYUdaVE0yamhO?=
 =?utf-8?B?QVByM0xFRGRsQTZ0OXl4aFYrRE40RGFmcmxtYkcrdWt0Yk5UR0tKRjI2TXNk?=
 =?utf-8?B?Q2lFUjdvc1U1K3Rwdnpob2R2THNueS96SjNUejZsOXhOYytna2RJSGVabmt5?=
 =?utf-8?B?MmNkTWRTL1ZDYVFoNHlaTHNmTXVUb3djTWM2czVKdVdMNzhUUXZTbDNJVnMw?=
 =?utf-8?B?eTI0VDBqUFRQVWltTkJDRWxCVzdFVDAwY3QwMUZ1SmkwTit0VGtRZ05NSU1r?=
 =?utf-8?B?ZFFUYTRVV1h1Qzh4TUkyQ2ovSStGS2tSYlpVTkhZVFFJQTNrY3kvU0FocmFW?=
 =?utf-8?B?OU1HQTUwYU9tSzJjMDYxWHkvZDdlcW9hcjdkbTdCKytEVkZ6YXVaUTBJR1FM?=
 =?utf-8?B?a3NCMVVLL1FvVlVQdGsvK0VaYmhhS1BHeFNud1czcTlsY2ZiZHovSDhnaXhl?=
 =?utf-8?B?Z3ovR0RHZTJjb0hzeVdTL0NEcVBDY3Z1SEpPL21YRWsyQ2ZxMkV1a2tUb0pI?=
 =?utf-8?B?N3pXS2k3Ukl4OUJLOTNlSm9OVGRxRk45ckNjUFc0ek02c1NkdUhxSW01UHJl?=
 =?utf-8?B?ZnpWU2NPUDM4dWxpT1gwbnIwaXI0VGZxMTV5dVY2MFhjRERIY2c5Wm5ocGZ2?=
 =?utf-8?B?TWxlMk1NODlYYngyUDViTTRqRGdVdThYWnJRVHplZnlVSGs5NVo3UDdEc3Zm?=
 =?utf-8?B?bnlKdU9tY0hUUktpR3Npb0RsY2RjWlRNOExHR0JpU1h1ckFlNnZWKzZ6WnpP?=
 =?utf-8?B?enBuMk5HdEVucnF0ZG1rQk9PbjQ1V2FBVW45RmRCemtQd1VheVB2OEM2amo3?=
 =?utf-8?B?YWZ5MXBBbzlkVmtJYy9nQjJjZ2s3YnFqMUNGckhoUHlMbjJVN2ZyV2RpV0JO?=
 =?utf-8?B?NUFNZ2RzV2FIZGpZY1RXUnJIUCtiU3ZJZVl4U0EyYk1DanVYRUFDc3hUSmFC?=
 =?utf-8?B?UkJsbmRnYUpRQWNXcVBUMTN0dHppL3RZeE9seUN5M0lYTElrZUNjcHNUTVBO?=
 =?utf-8?B?VFEwNHNvQ2lVVGozZWlKT3Q3NnI2VmIwL2FnMmJ6VEllU0ZoazBGMkJjanRq?=
 =?utf-8?B?YWM1V3pFTGNZOFVTNzBJMHNUaTVxem52ZHJ1MzFPVUhGeEFHMVlBNHBFdEhZ?=
 =?utf-8?B?ZVB0dTBPbktBVS92dSttaVdVdTd5Qm5MLzJXNy82YzBjOHM3MDltVEJKSlBo?=
 =?utf-8?B?VzJMZ2VBVVQ0TTAzOU04aDNBNEdTcEtxbmdpNTVoSTBnQ2ZGVjMwSnlqcGRu?=
 =?utf-8?B?dTUySFdXOG5uKzUyM3NQeFVPcDBEbkk5QTlDc2xTeTdsRU5sQnFha2ZDRG1o?=
 =?utf-8?B?QmxVRU50MWNOYVpqeEFXblprR2xMdi9uZFJCcjJyZVhqa0twbUJ0ZURpNUFs?=
 =?utf-8?B?SWZTcm12NnFNRldVc2lmYXg2Z05TRHRJOGpqam9NWGFkMTk2cVpiMWVudG53?=
 =?utf-8?Q?PcQiHXU9ODDLkCrjy4uX88iBU8BwbnQ8G8hvU57?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81812f82-8a45-460f-dc3f-08d946e224a5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:12:14.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XTDNtAtlDe+0seQ1wF3BA7uuJZZH3aPiOueZkLsB688A5EI84lAHJEMzaW5tdmxVDDUVyoEvHwvDjSDcmEsWyofnauGilzuRioorYoPjqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4879
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 14.07.2021 17:43, Christian Brauner wrote:
> On Wed, Jul 14, 2021 at 04:27:53PM +0300, Pavel Tikhomirov wrote:
>> Previously a sharing group (shared and master ids pair) can be only
>> inherited when mount is created via bindmount. This patch adds an
>> ability to add an existing private mount into an existing sharing group.
>>
>> With this functionality one can first create the desired mount tree from
>> only private mounts (without the need to care about undesired mount
>> propagation or mount creation order implied by sharing group
>> dependencies), and next then setup any desired mount sharing between
>> those mounts in tree as needed.
>>
>> This allows CRIU to restore any set of mount namespaces, mount trees and
>> sharing group trees for a container.
>>
>> We have many issues with restoring mounts in CRIU related to sharing
>> groups and propagation:
>> - reverse sharing groups vs mount tree order requires complex mounts
>>    reordering which mostly implies also using some temporary mounts
>> (please see https://lkml.org/lkml/2021/3/23/569 for more info)
>>
>> - mount() syscall creates tons of mounts due to propagation
>> - mount re-parenting due to propagation
>> - "Mount Trap" due to propagation
>> - "Non Uniform" propagation, meaning that with different tricks with
>>    mount order and temporary children-"lock" mounts one can create mount
>>    trees which can't be restored without those tricks
>> (see https://www.linuxplumbersconf.org/event/7/contributions/640/)
>>
>> With this new functionality we can resolve all the problems with
>> propagation at once.
>>
>> Link: https://lore.kernel.org/r/20210714132754.94633-1-ptikhomirov@virtuozzo.com
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>> Cc: Mattias Nissler <mnissler@chromium.org>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Andrei Vagin <avagin@gmail.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-api@vger.kernel.org
>> Cc: lkml <linux-kernel@vger.kernel.org>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>> This is a rework of "mnt: allow to add a mount into an existing group"
>> patch from Andrei. https://lkml.org/lkml/2017/4/28/20
>>
>> New do_set_group is similar to do_move_mount, but with some restrictions
>> of do_move_mount removed and that's why:
>>
>> 1) Allow "cross-namespace" sharing group set. If we allow operation only
>> with mounts from current+anon mount namespace one would still be able to
>> setns(from_mntns) + open_tree(from, OPEN_TREE_CLONE) + setns(to_mntns) +
>> move_mount(anon, to, MOVE_MOUNT_SET_GROUP) to set sharing group to mount
>> in different mount namespace with source mount. But with this approach
>> we would need to create anon mount namespace and mount copy each time,
>> which is just a waste of resources. So instead lets just check if we are
>> allowed to modify both mount namespaces (which looks equivalent to what
>> setns-es and open_tree check).
>>
>> 2) Skip checks wich only apply to actually moving mount which we have in
>> do_move_mount and open_tree. We don't need to check for MNT_LOCKED,
>> d_is_dir matching, unbindable, nsfs loops and ancestor relation as we
>> don't move mounts.
>>
>> Also let's add some new checks:
>>
>> 1) Don't allow to copy sharing from mount with narrow root to a wider
>> root, so that user does not have power to receive more propagations when
>> user already has. (proposed by Andrei)
>>
>> 2) Don't allow to copy sharing from mount with locked children for the
>> same reason, as user shouldn't see propagations to areas overmounted by
>> locked mounts (if the user could not already do it before sharing
>> adjustment).
>>
>> 3) If From is private for MOVE_MOUNT_SET_GROUP let's report an error
>> instead of just doing nothing, so that the user knows that there is
>> probably some logical usage error. (proposed by Christian)
>>
>> Security note: there would be no (new) loops in sharing groups tree,
>> because this new move_mount(MOVE_MOUNT_SET_GROUP) operation only adds
>> one _private_ mount to one group (without moving between groups), the
>> sharing groups tree itself stays unchanged after it.
>>
>> In Virtuozzo we have "mount-v2" implementation, based with the original
>> kernel patch from Andrei, tested for almost a year and it actually
>> decreased number of bugs with mounts a lot. One can take a look on the
>> implementation of sharing group restore in CRIU in "mount-v2" here:
>>
>> https://src.openvz.org/projects/OVZ/repos/criu/browse/criu/mount-v2.c#898
>>
>> This works almost the same with current version of patch if we replace
>> mount(MS_SET_GROUP) to move_mount(MOVE_MOUNT_SET_GROUP), please see
>> super-draft port for mainstream criu, this at least passes
>> non-user-namespaced mount tests (zdtm.py --mounts-v2 -f ns).
>>
>> https://github.com/Snorch/criu/commits/mount-v2-poc
>>
>> v2: Solve the problem mentioned by Andrei:
>> - check mnt_root of "to" is in the sub-tree of mnt_root of "from"
>> - also check "from" has no locked mounts in subroot of "to"
>> v3: Add checks:
>> - check paths to be mount root dentries
>> - return EINVAL if From is private (no sharing to copy)
>>
>> ---
>>   fs/namespace.c             | 75 +++++++++++++++++++++++++++++++++++++-
>>   include/uapi/linux/mount.h |  3 +-
>>   2 files changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index ab4174a3c802..a7828e695e03 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2684,6 +2684,76 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
>>   	return ret;
>>   }
>>   
>> +static int do_set_group(struct path *from_path, struct path *to_path)
>> +{
>> +	struct mount *from, *to;
>> +	int err;
>> +
>> +	from = real_mount(from_path->mnt);
>> +	to = real_mount(to_path->mnt);
>> +
>> +	namespace_lock();
>> +
>> +	err = -EINVAL;
>> +	/* To and From must be mounted */
>> +	if (!is_mounted(&from->mnt))
>> +		goto out;
>> +	if (!is_mounted(&to->mnt))
>> +		goto out;
>> +
>> +	err = -EPERM;
>> +	/* We should be allowed to modify mount namespaces of both mounts */
>> +	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
>> +		goto out;
>> +	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
>> +		goto out;
>> +
>> +	err = -EINVAL;
>> +	/* To and From paths should be mount roots */
>> +	if (from_path->dentry != from_path->mnt->mnt_root)
>> +		goto out;
>> +	if (to_path->dentry != to_path->mnt->mnt_root)
>> +		goto out;
>> +
>> +	/* Setting sharing groups is only allowed across same superblock */
>> +	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
>> +		goto out;
>> +
>> +	/* From mount root should be wider than To mount root */
>> +	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
>> +		goto out;
>> +
>> +	/* From mount should not have locked children in place of To's root */
>> +	if (has_locked_children(from, to->mnt.mnt_root))
>> +		goto out;
>> +
>> +	/* Setting sharing groups is only allowed on private mounts */
>> +	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
>> +		goto out;
>> +
>> +	/* From should not be private */
>> +	if (!IS_MNT_SHARED(from) && !IS_MNT_SLAVE(from))
>> +		goto out;
>> +
>> +	if (IS_MNT_SLAVE(from)) {
>> +		struct mount *m = from->mnt_master;
>> +
>> +		list_add(&to->mnt_slave, &m->mnt_slave_list);
>> +		to->mnt_master = m;
>> +	}
>> +
>> +	if (IS_MNT_SHARED(from)) {
>> +		to->mnt_group_id = from->mnt_group_id;
>> +		list_add(&to->mnt_share, &from->mnt_share);
>> +		set_mnt_shared(to);
> 
> Thanks for the updated patch.
> 
> Note, set_mnt_shared() writes to the vfsmount so this should be:
> 
> if (IS_MNT_SHARED(from)) {
> 	to->mnt_group_id = from->mnt_group_id;
> 	list_add(&to->mnt_share, &from->mnt_share);
> 	lock_mount_hash();
> 	set_mnt_shared(to);
> 	unlock_mount_hash();
> }

Thanks for pointing that out! Sent v4 to fix it.

> 
>> +	}
> 
> 
>> +	}
>> +
>> +	err = 0;
>> +out:
>> +	namespace_unlock();
>> +	return err;
>> +}
>> +
>>   static int do_move_mount(struct path *old_path, struct path *new_path)
>>   {
>>   	struct mnt_namespace *ns;
>> @@ -3669,7 +3739,10 @@ SYSCALL_DEFINE5(move_mount,
>>   	if (ret < 0)
>>   		goto out_to;
>>   
>> -	ret = do_move_mount(&from_path, &to_path);
>> +	if (flags & MOVE_MOUNT_SET_GROUP)
>> +		ret = do_set_group(&from_path, &to_path);
>> +	else
>> +		ret = do_move_mount(&from_path, &to_path);
>>   
>>   out_to:
>>   	path_put(&to_path);
>> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
>> index dd7a166fdf9c..4d93967f8aea 100644
>> --- a/include/uapi/linux/mount.h
>> +++ b/include/uapi/linux/mount.h
>> @@ -73,7 +73,8 @@
>>   #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
>>   #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
>>   #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
>> -#define MOVE_MOUNT__MASK		0x00000077
>> +#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
>> +#define MOVE_MOUNT__MASK		0x00000177
>>   
>>   /*
>>    * fsopen() flags.
>> -- 
>> 2.31.1

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
