Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB82634C4D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhC2HYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 03:24:55 -0400
Received: from mail-eopbgr150103.outbound.protection.outlook.com ([40.107.15.103]:54948
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230452AbhC2HY2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArBP3AMrlgsuUmr68tGFUNvzXaIouBdXnZpnDerLkHEqa0yVsLgaru8Iw0gYAcIOD6eno/3Dlyrfisn50SHih3+xhRxV6aCoPp7x0yuerb3xQtkG8zfajVDI+jrmFF4rSX+45y4HdrcHREXXmTfKMUynwfpVCgTg/iir9JGMdmyDRERrPhR1O1TZh5wv/7R64dB/VyzQV2CkkAgb5Co9fcmqRO7bmglRplSHVt1QpBYT4emVFUO2FpGwHFp7sQGqz181lTLIUUagN0vb7H5MAF5vFmqnknCUjl4iJfVBIPju8l6FUUsooyekxXCpQFGgACYlKB91h00ZiYKWt7IDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuL83n6Kdkouq6EmXTRKcoY6Eppvufn9g3PhmUyTjQg=;
 b=Z1CVTtfuxPBA1GeBTmLayW/zWopzuluANSeLt+AKzAySr4nt+CX0udwL0JlQQvxef0n2H5ubXD5wx1TyGBQMSkbyxtkpVi1CFSkCShST6CanfsqTMLyr/KnAlsqwjsWOptbwhRgDppENb1MOhxwDRyCpbxeP2etKKUc8VbhpfBkpbk96p9weEc96rD4pvlj7FgbQ39az+SBVC0HrHlwfL5zNRBWnx1rt3pN1/7TP/Ruj5EPfM7UVaorar/sryLIGKLDuUSrM2cJVdJF150x9MH59V9SwL4al1YJKNHDSuG1QaOUHANvWEl0NtUk2L4Odp0GcYQ9H1k1NE9URLpscLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuL83n6Kdkouq6EmXTRKcoY6Eppvufn9g3PhmUyTjQg=;
 b=HECW1pZSzgohVRoVIA5uHAaC68/N/W8Jwus5PZ8PGiF05xwsCAparDrpsvO260gR7KL+0NEdskwHAdH3e2K3tPjrh8MPRiNSckAhPEl/IZnK15VWP/LQ1K6fI2SxHMjGDojIMdw8CjJ0glAGlg5J2oDT4FhpHlXYWKdI1RLK0ug=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB3198.eurprd08.prod.outlook.com (2603:10a6:803:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 07:24:26 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 07:24:26 +0000
Subject: Re: [PATCH] move_mount: allow to add a mount into an existing group
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20210325121444.87140-1-ptikhomirov@virtuozzo.com>
 <YGD5cqCb9IM907NL@gmail.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <e13726e9-6c33-0344-62da-a749d1b6d282@virtuozzo.com>
Date:   Mon, 29 Mar 2021 10:24:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <YGD5cqCb9IM907NL@gmail.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM0PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::35) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (81.200.17.122) by AM0PR06CA0094.eurprd06.prod.outlook.com (2603:10a6:208:fa::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Mon, 29 Mar 2021 07:24:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3758518-e6e6-4cb5-52a8-08d8f283ae78
X-MS-TrafficTypeDiagnostic: VI1PR08MB3198:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR08MB3198BF93E4C68926EB07FD5AB77E9@VI1PR08MB3198.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPqfqPflxTmaI9bNl81p+2t0+yjcJeLWFGI390kI3Y11qaOuDj4brOBCznhakb/5GpjOG6sBBfR6zSC3XeVXjyJftbSrXAvJIhyo+PAMbb5K9Z/fmRqhTtbQuP0gVmQS0qAF9pfJ1hm5nQ5SH/WinhNX/cY5/5rGTHPEjg1/qQoOEQc0hxdc/5PBqzmW2zFoOd1M9HTwKCf2ECtcvNSpBQEBIgghreh/EHjzOHk9aB7Uq1ymOJXoA3moGEGx6O9C1jEzWusfLFPfZQ6HVjxkzLQKpD61J7CQ1/WjAew2EmRm74650MEMGpblALmcoPw7pxsAsmXoWl9FipasdY3DCn7RExSCg+t+CL8EFip8l+TzJVn1DQQGspdgtYBmjRfgbfbfFpuw2odePGk33yoESbiv1x6zXgMt5oQkmxwYrpw1RwWICO6dGjESuoN1ZucsEkX6iXCe45AO9Qq0ZtgCvPYu7jfDOun/BZjlSWJvHYNGoikhqg+1K5C70RLhFyZ7/fDsqPSCUh4TD/XfLEZBg8im3H6I0WKW8/KGBujqQl81SLDr38RJTbr67SAfX5sYvS8k+N/K3U7GO8M6vvFTiZDRprBkvYiwPQuc0vh4TrRtfAL06q07trQIEGWb9FHqnHSHyZZfFAsC2OIAXzRnj2NFLX9A3q5lseO0FRBqhVXw/Zd31lJUkYkjjecxJgzu7hxp54Bs/k29gJjlxatrj4fykgoDmuJb2o5tYjnz2srq3BbgMo3udaWPpEb5CB5MS6UmupfWiEWqG5vkyOHjyZ8VL6aNuOaNBZ+WjVry/eY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39830400003)(376002)(346002)(86362001)(316002)(31696002)(66946007)(66476007)(66556008)(16526019)(2616005)(7416002)(26005)(2906002)(956004)(5660300002)(16576012)(53546011)(83380400001)(54906003)(478600001)(36756003)(966005)(4326008)(38100700001)(6916009)(8676002)(186003)(31686004)(6486002)(52116002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?koi8-r?Q?G28eQ90JI5wPbhfTtSDo7W81v2WbjbJtXkpd+k/3PvrUS8oy1TAoen6j62jlBH?=
 =?koi8-r?Q?47TmWMXlEspb7xBEN/t/JwBhgg0nZJhFrIA/cSCH7Ky+2Y7JlbMMHkyHkVhBB4?=
 =?koi8-r?Q?jKgnj35EDzzDsV3uAYegUttRtUCFfPLjCPECw/+Iufe7JjS+tlq7BMLG+Pc/oX?=
 =?koi8-r?Q?DIby9QsK9wFICAUMqByBb8TeqkXd4GxY8nti0JL/3T0I5RG25RmS418M97E5xs?=
 =?koi8-r?Q?5ehzI9KHG2jXPfPlr51/I+Sr2Pk06pWYC5/Z3rT8zAEKCpipJMOXWftDpunIaF?=
 =?koi8-r?Q?UF5LIVXTMijnXEqYWsxc75mXcUDiFE20l1q0Ez0HFMlbL6QDeBVw1a9DL/RgMX?=
 =?koi8-r?Q?Tg3Ci+JLKgbKBEslZAm3pVlhL9o+dqm/YoUTkaOQnU8vWhIvETiRw10wr8dntC?=
 =?koi8-r?Q?s82NAO/juJUnliFNsteAfAzAxRytehRFysqCxV2UQ23ccn/ANkDVDOXrlu9ugf?=
 =?koi8-r?Q?D5Drd7jgVqsEvJhyH82AsBSup2VWUAbSxtMBYHVFzuKqDoyPbs9dUcwzPYlCvR?=
 =?koi8-r?Q?Ck8kQdfXafNZnWKInCxJpx9k8an+3CbkmHLILdH5Qcy0IBLsBn4RD1XcsGPDdf?=
 =?koi8-r?Q?tERqIyFcDRlM7aqjYpIqeuD/f+XEvSmvOu2Bjue2dMuyFBlKbbATp1rnSt++20?=
 =?koi8-r?Q?XV2ww73Xv2UqTsn9ChMn4vAxlIuycTTi/wvtIb3HH7VJJfU30IXiJyGMrhq/AS?=
 =?koi8-r?Q?Vi5ijtm0l7P1mDGX9yk+V0ph4fcbw8QOHAIYHN8LMXD+j9CmDjN4DT6bNIixMS?=
 =?koi8-r?Q?OS1OVmsmjwwmAy4E45NGBOaF2x5oaTqqCu86jPVHAU425BaAuT0KgHgEh7M1Oo?=
 =?koi8-r?Q?cMKQ7dnAva5Ff5dyLRXXU2gHBcVWHgM1oq8oh1lGR/HB9Tu1ohPjuylSlTtSy3?=
 =?koi8-r?Q?zjFSZjP6DS8iDk9Fje/nuW4qwyRRFp1BYDwI8pkCwvWu3RUStgQlbcWgXwdPcb?=
 =?koi8-r?Q?fUmQCnHaSWbh5+1Uf+XyGCFZ4Tkt+ONHxeWu2f3xJDBI3VhbDaEBL2R/422YRL?=
 =?koi8-r?Q?zUTgnd+zNBRRD9agL6fajxrSi5Dvb3udFI+PIrDOe4grCDB9ePuKaxLSKgzVVp?=
 =?koi8-r?Q?OaHJxwU/p8HDE08KnUOoo/OHzGwwlpK5UE+QXcwrvpYvJ2z9dngTH5VhESRTWX?=
 =?koi8-r?Q?6Qcio2d6ZKleA92jpy2ruWtjpBAgtZgAUylsOWxHfb3aTg0GgiGLzJhJPG7Ugb?=
 =?koi8-r?Q?0JTGc5vbjpaddlLCDoo6VxILkxAwIWdpoWcrtllXUN68TtQv1KUNN1+opbK+qj?=
 =?koi8-r?Q?SngfiX8eZJIP48wQPGmXlKdS0XariGJOWc1VqvwJa2?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3758518-e6e6-4cb5-52a8-08d8f283ae78
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:24:25.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEC8cdMo3gflTMhLabqIE5YYhuAzTtl8aojz5G6DVtBHha/UXjffmFposlSPhhSeeqQVOOT8VdzwIBJPtEnIujZ7AoTT7YwXQm/Ve4+pINY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3198
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/29/21 12:47 AM, Andrei Vagin wrote:
> On Thu, Mar 25, 2021 at 03:14:44PM +0300, Pavel Tikhomirov wrote:
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
> 
> Thanks for picking this up. Overall it looks good for me. Here is one
> comment inline.
> 
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
>>
>> 3) Also checks wich only apply to actually moving mount which we have in
>> do_move_mount and open_tree are skipped. We don't need to check
>> MNT_LOCKED, unbindable, nsfs loops and ancestor relation as we don't
>> move mounts.
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
>> ---
>>   fs/namespace.c             | 57 +++++++++++++++++++++++++++++++++++++-
>>   include/uapi/linux/mount.h |  3 +-
>>   2 files changed, 58 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 9d33909d0f9e..ab439d8510dd 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2660,6 +2660,58 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
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
> 
> I think we need to check that mnt_root of "to" is in the sub-tree of
> mnt_root of "from".

This is perfectly reasonable, Thanks! I will add this check. (Also this 
should not affect CRIU part too much, looks like we have to chose 
"widest" mount as the "first" one to restore sharing group.)

> Otherwise, there can be a case when a user will get
> access to some extra mounts
> 
> For example, let's imagine that we have three mounts:
> A: root: /test/subtest shared: 1
> B: root: /test
> C: root: / shared: 1
> 
> A and B is in the same mount namespaces and a test user can access them.
> 
> C is in another namespace and the user can't access it.
> 
> Now, we add B to the shared group of A and then another user mounts a
> forth mount to /C/test/subtest2. If we allow to add B to the shared
> group of A, our test user will get access to the new mount via
> B/test/subtest2.
> 
> Thanks,
> Andrei
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
