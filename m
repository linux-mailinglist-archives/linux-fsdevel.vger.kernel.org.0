Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237193C7517
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhGMQnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 12:43:00 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com ([40.107.20.136]:25312
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230132AbhGMQm6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:42:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcqnv2ZKNn38nbbJcZZGiFbhlKo3EtsG4VpIZ5oKPF8AF+9lcSDanqp1SVwBn0/EDLgIRVpbpduq3zd+hWDACAG3rTmK4WsPPKcXFrLkeIrBG5ePqxwdHvNhYPvlKGuntFOEykbeuVQ0eUi/RMuNAVtUlWKnGNGNTh0XMEtWadr4QDaKmxfQL7Q/x7ktp/gmniQqcbXKlsLiXVjdRJtQdsVfOnln9ZGnSl1W+P68Qiy0C8hk0iO09EfzNDeBaES41eYXzrIgYpU09jCEyKtzzGdWRYmkwpbiM0S7O+GNJFaoMrfP3VqYspVinkmjBwz5ln3EwcB1zALcQogByfsV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1nx3oaGJjbjf8u/Ydrr1ATlSdJxzQn2pj0gHc2flH0=;
 b=e9/rDHf8rdX59GoftUnQRTCE/CSn8cgrlnCWofK4YfWVgw58Pueus7GD3CvejS+fubot5V4PM2cCoS5SUW3Mm/C2c3XU25h5wjI4KSsF8lBlvBazrtswqApVf5BTwNbCIrItRkC+5SRyDWguU/n8eh+AxC5tNVPYCeFbNMI3zBdSigFcUVmgM3wRnFopK7RrdoGzzHjSH5zkdSWS3mw7Yae/JcJdiylo6whdqAWAqMifjpai//6fUHbBReVXiAB91A9W4YtCU8lzbpYTbhlbtLZSTj95bkC9R9ZukJcOc7oP5phH38zVVdT4nr3Rqf+zQTw1PLhNA7afQT00dOIdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1nx3oaGJjbjf8u/Ydrr1ATlSdJxzQn2pj0gHc2flH0=;
 b=ctGj+i54z6s9eT3kz5L7xOEmNjDWR0fuJXnrDuYSSAR0hw15tg2SNPm++PNK0i1oAVMPb+o6CZTOqXa6EW23oTcTTAoQHUQKxZMgDgjnBDLV97/cBzVDud/rZl/Es74SsyaC9RIRu/wQLFo9RxePuykoeaZmOKWQheTkODKnnA4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VE1PR08MB5629.eurprd08.prod.outlook.com (2603:10a6:800:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 16:40:04 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:40:04 +0000
Subject: Re: [PATCH v2] move_mount: allow to add a mount into an existing
 group
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <20210713115636.352504-1-ptikhomirov@virtuozzo.com>
 <20210713144036.3kiwqgff364hw3pt@wittgenstein>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <03d9c60b-736f-9182-86cc-9c26c144eae2@virtuozzo.com>
Date:   Tue, 13 Jul 2021 19:39:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210713144036.3kiwqgff364hw3pt@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::18) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.100] (91.207.170.60) by PR1P264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:40:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b64dfe0-fced-4808-b0cb-08d9461cdd8f
X-MS-TrafficTypeDiagnostic: VE1PR08MB5629:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Antispam-PRVS: <VE1PR08MB56290BF2DCBD1C11F0AF4CEBB7149@VE1PR08MB5629.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNO7Uu9ehN97weQyU7pRrGL3RxRpV2xuppOv5T+68OQIKei44OIc/312kFIUtBm8tKC5cw+ekp3u3YudKZohW5ngaqDVnqqb7oSy4vcRHxKaQ5z/ltDgBMXOT9pPHY7T/CCAt63GPsBE1dVk8JYrN2bGp1ln3PkedoFVzaUrDlxtPEW4cWpovndn1RmQZr+UFmBQ4+CJnCBbl56UAiOoVnPn8SBuSZ/QtzrqJwXU0B4zeUC627FDRcw+i2MIyZPzyE65UMQwvpU5mYjUJD3p9gH+I7AWhoJynLv4mZ1XTuMIYJljiwULlvGpz5MYAUUeRqR9qsZpaoXNVGAf7AlclT+Hf7KYneLshHTzUc7dzM7LodtcehIj4kpebc0iBV6cYSKIS77Y7dOPBLQ0gZeZaoWF9+UY5lGHwKSxc6w27C4acMdY6UA08XEfX5G0i5RrcttzT/rU+7uNrS9aCm2v2kfg0Vf17P+ZCnK3IKH18tSysysbThARiN1PqTccAiFpcXRiac2nzmJrRCPb6V5yJPG+jA+ampmfWZt+/oLhRKRdfOBq+qSx5J3LIpmQfm0UDc28oVI+HO4teMcZbVXHk3oDKs9rX3HomA7sc0pnTCb8CtOqJWpUDGKBuPM2/CtLcvi6YO0hdh2sd8mJyYEA34Eln292ByWvGQHfjneFh9OwqTzRnz6+8oEnONYPcn+Dpb2gT4Bj4kn0yezqttYIF5LyAjdWSFQnUFgMUzlQOmJQLjczxGBB115W+RSaWwXRuOyL4q3RYXKaqc8R36QSJtYKy832jkcGRIb1GqD+mL9bhZtEiJyvR+OGgFJ+0vNjnKlLGKK0lGdkusrqjazERlFL474iHzfvFCVO21WbovBQuMD3zt+aGgJ8GnBw7CRk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39830400003)(16576012)(2906002)(54906003)(8676002)(5660300002)(31686004)(6666004)(186003)(66476007)(966005)(316002)(4326008)(478600001)(31696002)(6916009)(38350700002)(66556008)(83380400001)(53546011)(52116002)(86362001)(26005)(36756003)(8936002)(66946007)(2616005)(6486002)(956004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxDc2hhZ1dub1piMnZHNnpCRFZzMGowWjJubHo5VVcrY2Vvck9hUTgydzQ3?=
 =?utf-8?B?YVZBc0xjOVJiSTdtNWFlWnpWcmpoTFl1UmRpSHpzQUZtdjhjdm5jUGo0NWdF?=
 =?utf-8?B?dUY5aVpuK0wzSFE4eHRGdFJSUitneE01TU5IYjVUQ1UreGM0YTJBWTF6Vklv?=
 =?utf-8?B?YTFtQnB0Z25pTmhiQXBRczRqOTZIelhpdHlJdElIdXpuYzRIMmRTMGJYT21D?=
 =?utf-8?B?SkJBY29qd1lzVHZwMklvaC9rcHRiRW90dXQwYVZPY2xJT2F5UDVGMjNVTytl?=
 =?utf-8?B?L0RrREUwZDNjSmZqOEt5VWllT2JER2dYQUNKRW5xV0gvWm1ycDF5RzF5QllR?=
 =?utf-8?B?OTVvYlczNE9JWHJmbk5zenUrdEVhUmExdVh6VVl2ZnBBMGRLR01uVEJXUjE0?=
 =?utf-8?B?blNLQzRKOVpBYmVOSkYvMzkwRFNLaWEzU0ZISUpxL09jRGlZUGhsbXBlYnJl?=
 =?utf-8?B?eWpMY2JlRXUzNWJpbTM3QUtXRXhVbGtkMVJpNXIwT3VHVHdGa0ErOHhWaDVx?=
 =?utf-8?B?M0pmQ1lkYmh3MWcwYWlMOSt4Zk15eElNRWhiWnpCVG02eEFuR3BzSE1Ubk10?=
 =?utf-8?B?Y1QwOVczME1qQzJ2LzFCb2l2eE40bXo5TVZybHNpelZ0TU5iSm54Z3hTSVp1?=
 =?utf-8?B?Rys3NEF2UjlHdnluQnhaQ1N5SElxNlRGUGJSNXRxTnNlQmtiMmJZc3JHck8w?=
 =?utf-8?B?d3FvbGhIRmx1aU96b0g2Q3NhSDFhcnRpakRRQ2JoeGYrdjdEclpsY2l4a3dt?=
 =?utf-8?B?aTdTK1RXc0FjRmIzeTJ2ZUk1OHhTY2NqaVcrckdlakpNNStkMTgzaUFsZFUz?=
 =?utf-8?B?Y2hHUmIrZlJFTnpCazVMd2JzdGd5eEFyd0dqVWkwbi9ZbGsvOVVFWnNMcGhk?=
 =?utf-8?B?dEpvRUorU0NrVW9JNmhIYUFDVWF5b2c2UC9iTUNkazY5RDBFc0FWM0pUZzhO?=
 =?utf-8?B?OGRhVG5zVWRKbVh1SDM0cWdTcDBCRkxhM1dIMG5ocmE1TjNiTGtqYTJTUHlH?=
 =?utf-8?B?NkxtMEZIdldEazc4VWVxVWFPM3p2bGMydWZYQjJPMUd0Q3hmanVScXo4TU1R?=
 =?utf-8?B?U2NHZ3dmbmtDMGJMeWM2WTA3ZkVLanJ0ZGJZcnVWdHlud1VnSjh5enpjYVBC?=
 =?utf-8?B?S2RmMjF6alByZSsrRGM3NTcvNFJhRU9OUHUvbURESzlKbEkvREVxLzROdDI4?=
 =?utf-8?B?bzM2QmZqWjdQeStVMzYyS0lReU9MYVlTUkgzb1dhYk8xQmQzUjhhLyt5SFJy?=
 =?utf-8?B?L3FZNFY2cVRMVnE5ekFhdCtjc1FIMi9qdFRBWEk2SnRGY20zRDJFUVl0Umhq?=
 =?utf-8?B?RjJvdEdkOFMvMGkzREhPaVdBN1p3eFBuZFRsYU1CdlVJdjFaRThObHBSRm5N?=
 =?utf-8?B?WE9ycVFZdkpVdzhWcGpEUSs4ZjVaVTVOQnBDeWNRb0VqQkhaemZrTktmM3hE?=
 =?utf-8?B?OFBVVEJybG5mWFU3cXdUWndDbW83YlVud0hzYlkyL0tab1U2UytILzhldlFh?=
 =?utf-8?B?VzRsYTJCOXNXbUNSRXpsWmc0VVE0SzlLSnU5Wm9aekFZZUw2ejY5V1IwcnpI?=
 =?utf-8?B?dHVVdTNQMVArczdKai9vL2hoRVZTb25ibmlrb2M1ck9xZWJ2djdZc2treE9O?=
 =?utf-8?B?TUV0a1hLYnZlSXNwcVdoeWwwOUd5MysrSHdmdDU2VTR0Wk9CZ1U1c1FMak5K?=
 =?utf-8?B?d3VDOWphckM2L3lzM3FEY2RhUlhJNGF4blkvWTFHZzcxcEpVV3JpYmo3Nmpr?=
 =?utf-8?Q?tEKXqrncDWLLnt57WQYBXQCQvm09xcNd5uaNUbM?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64dfe0-fced-4808-b0cb-08d9461cdd8f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:40:04.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp+9yc/t11RhVF44HSloP66EB1LqLESXDikAVFrMFyJZJkDDZj4L9Cg4sAt4U/hp2ZuPPvZkFDLPUvyv8ogukw+qLkjK2zEgHeShMaAvgB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5629
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 13.07.2021 17:40, Christian Brauner wrote:
> On Tue, Jul 13, 2021 at 02:56:36PM +0300, Pavel Tikhomirov wrote:
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
> 
> Thanks for working on this. We can make good use of this flag as well
> when setting up mount layouts and so can systemd so I'm happy to drive
> this.

I really appreciate it, Thanks Christian!

> 
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
>>
>> ---
>> This is a rework of "mnt: allow to add a mount into an existing group"
>> patch from Andrei. https://lkml.org/lkml/2017/4/28/20
>>
>> New do_set_group is similar to do_move_mount, but with many restrictions
>> of do_move_mount removed and that's why:
>>
>> 1) Allow "cross-namespace" sharing group set. If we allow operation only
>> with mounts from current+anon mount namespace one would still be able to
>> setns(from_mntns) + open_tree(from, OPEN_TREE_CLONE) + setns(to_mntns) +
>> move_mount(anon, to, MOVE_MOUNT_SET_GROUP) to set sharing group to mount
> 
> That's similar to how we can do limited delegated mounting.

Hope it means that we can allow it then. Because (1) looks like the most 
expensive thing from CRIU point of view to disallow.

> 
>> in different mount namespace with source mount. But with this approach
>> we would need to create anon mount namespace and mount copy each time,
>> which is just a waste of resources. So instead lets just check if we are
>> allowed to modify both mount namespaces (which looks equivalent to what
>> setns-es and open_tree check).
>>
>> 2) Allow operating on non-root dentry of the mount. As if we prohibit it
>> this would require extra care from CRIU side in places where we wan't to
>> copy sharing group from mount on host (for external mounts) and user
>> gives us path to non-root dentry. I don't see any problem with
>> referencing mount with any dentry for sharing group setting. Also there
>> is no problem with referencing one by file and one by directory.
> 
> I would prefer to not do this as it doesn't line up with any other
> mount modifying syscalls.

Actually open_tree(from, OPEN_TREE_CLONE) does not check "from" to be 
root dentry. And also when we do bind-mounts "from" can also be any 
non-root file/directory. But that's a bit different case of mount 
creation, not configuration. So yes, it would probably become more 
secure with those checks. -> Will add them.

> 
>>
>> 3) Also checks wich only apply to actually moving mount which we have in
>> do_move_mount and open_tree are skipped. We don't need to check
>> MNT_LOCKED, unbindable, nsfs loops and ancestor relation as we don't
>> move mounts.
>>
>> Also let's add some new checks (offered by Andrei):
>>
>> 1) Don't allow to copy sharing from mount with narrow root to a wider
>> root, so that user does not have power to receive more propagations when
>> user already has.
>>
>> 2) Don't allow to copy sharing from mount with locked children for the
>> same reason, as user shouldn't see propagations to areas overmounted by
>> locked mounts (if the user could not already do it before sharing
>> adjustment).
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
>>
>> ---
> 
> Can you please add a simple test for this to selftests?

Ok.

> 
>>   fs/namespace.c             | 65 +++++++++++++++++++++++++++++++++++++-
>>   include/uapi/linux/mount.h |  3 +-
>>   2 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index ab4174a3c802..521cfd400d06 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2684,6 +2684,66 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
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
>> +	}
> 
> Should we report EINVAL if a private mount is passed? Though that would
> require you to know in advance whether this is one so might actually be
> worth doing it like you do now.

Yes, sounds reasonable. In CRIU case we always know in advance. If we 
try to restore some sharing it's good to know that it was actually 
restored and not private by some mistake. -> Will do.

> 
>> +
>> +	err = 0;
>> +out:
>> +	namespace_unlock();
>> +	return err;
>> +}
>> +
>>   static int do_move_mount(struct path *old_path, struct path *new_path)
> 
> Technically this could also be part of mount_setattr() (You'd need a new
> struct member though.) but it's fine here too.

I've looked at mount_setattr(), I saw that I would need to add to_dfd + 
to_path into mount_attr there while in move_mount we already have 
everything at hand, that's why I chose move_mount.

> 
>>   {
>>   	struct mnt_namespace *ns;
>> @@ -3669,7 +3729,10 @@ SYSCALL_DEFINE5(move_mount,
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
>>

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
