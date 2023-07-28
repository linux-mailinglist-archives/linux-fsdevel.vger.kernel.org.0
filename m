Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82857669F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjG1KN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjG1KNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837BB2D67
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690539135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVTrdKONuZJ8X8z6/JDKIqzW1vcvdhBBj7CBWpchIeA=;
        b=BjWsXF+4ETyxB3IwV46uj3ei97IHZyp53Coevw6DHAqFc7P5ydxI2grK3hfK7Mg3IK8nVi
        JSSfdDHL/2XyJz2sS4j9q4BfrvCzAmpbS4sz280OF43KPVSgwKl4eSul8n4MLqjGfeyNfh
        qHxw/YlvyX/9rmPFK0dHQmPrw4Ijalk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-D94BHk7WMe6taJ65MawYbg-1; Fri, 28 Jul 2023 06:12:14 -0400
X-MC-Unique: D94BHk7WMe6taJ65MawYbg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55bf2bf1cdeso1775915a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539133; x=1691143933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVTrdKONuZJ8X8z6/JDKIqzW1vcvdhBBj7CBWpchIeA=;
        b=ev29MbTRihMGFRt5gpj5c3P3sFkHaDMbj9CFGoO2yGomAnc0kYigca0qse4Rq6DMAD
         pCBszly3Mwf62gRBHY1K6hR/02wk3Q02Z8W4wOeWv070hLSZdJ3cwN4qtHhXR7kSspIS
         e0cCQcxCESQAn5MmGphjlSyQx/sFlDTfBnEMJLNfwqkEUFxnn0hTKTEIgBUtkUkyGysG
         s+LG5Luny7p96039nhQ4/OanPSS/PW4hes2+7BNBtBWoGP5J+ZYzxZhwz24JJRs5RAt5
         Y6hY4atgbajHGnhoRb1q1yeR9iHJKS4L2SrrwTdtXYVUjVeet+ikHzvFVI/Xe+KYf8Bg
         sXuA==
X-Gm-Message-State: ABy/qLbfK3+9UpRDWBapEM9rQjpgafzJ+sXQIWol5tvDyauoshAg6zBp
        DXF8fqOZCl8FK+PNzrq4VEHJmbFWnbO0Kt+aHLAOcVl9hAzUUNfqJcUugJdd6A+StAyBLDzK0Jf
        iqNLk/AWDWyhlJN/zF6J/foCesA==
X-Received: by 2002:a17:90b:3712:b0:262:e6d2:2d6 with SMTP id mg18-20020a17090b371200b00262e6d202d6mr1339743pjb.47.1690539133484;
        Fri, 28 Jul 2023 03:12:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHeJERDSg1rmrndYhymaBmDwNAPGudzcHiIHpPycBSm5xkVLwyT06jzf+MmS1WinFCz3l3qbg==
X-Received: by 2002:a17:90b:3712:b0:262:e6d2:2d6 with SMTP id mg18-20020a17090b371200b00262e6d202d6mr1339718pjb.47.1690539133132;
        Fri, 28 Jul 2023 03:12:13 -0700 (PDT)
Received: from [10.72.112.17] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001ac95be5081sm3180459ple.307.2023.07.28.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:12:12 -0700 (PDT)
Message-ID: <a441f975-86c0-0f95-5ad0-ad6139a2d705@redhat.com>
Date:   Fri, 28 Jul 2023 18:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
 <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com>
 <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
 <20230727-bedeuten-endkampf-22c87edd132b@brauner>
 <CAEivzxcx31k3M1jWhhDrx6jxYtw=VOd84N-cMNWc+BZjq6QuFQ@mail.gmail.com>
 <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/27/23 22:46, Stéphane Graber wrote:
> On Thu, Jul 27, 2023 at 5:48 AM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
>> On Thu, Jul 27, 2023 at 11:01 AM Christian Brauner <brauner@kernel.org> wrote:
>>> On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote:
>>>> On Thu, Jul 27, 2023 at 7:30 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>
>>>>> On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
>>>>>> Inode operations that create a new filesystem object such as ->mknod,
>>>>>> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
>>>>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
>>>>>> filesystem object.
>>>>>>
>>>>>> In order to ensure that the correct {g,u}id is used map the caller's
>>>>>> fs{g,u}id for creation requests. This doesn't require complex changes.
>>>>>> It suffices to pass in the relevant idmapping recorded in the request
>>>>>> message. If this request message was triggered from an inode operation
>>>>>> that creates filesystem objects it will have passed down the relevant
>>>>>> idmaping. If this is a request message that was triggered from an inode
>>>>>> operation that doens't need to take idmappings into account the initial
>>>>>> idmapping is passed down which is an identity mapping.
>>>>>>
>>>>>> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
>>>>>> which adds two new fields (owner_{u,g}id) to the request head structure.
>>>>>> So, we need to ensure that MDS supports it otherwise we need to fail
>>>>>> any IO that comes through an idmapped mount because we can't process it
>>>>>> in a proper way. MDS server without such an extension will use caller_{u,g}id
>>>>>> fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
>>>>>> values are unmapped. At the same time we can't map these fields with an
>>>>>> idmapping as it can break UID/GID-based permission checks logic on the
>>>>>> MDS side. This problem was described with a lot of details at [1], [2].
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
>>>>>> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>>>>>>
>>>>>> Cc: Xiubo Li <xiubli@redhat.com>
>>>>>> Cc: Jeff Layton <jlayton@kernel.org>
>>>>>> Cc: Ilya Dryomov <idryomov@gmail.com>
>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>>>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>>>>> ---
>>>>>> v7:
>>>>>>        - reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
>>>>>> ---
>>>>>>    fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
>>>>>>    fs/ceph/mds_client.h         |  5 ++++-
>>>>>>    include/linux/ceph/ceph_fs.h |  4 +++-
>>>>>>    3 files changed, 27 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>>>> index c641ab046e98..ac095a95f3d0 100644
>>>>>> --- a/fs/ceph/mds_client.c
>>>>>> +++ b/fs/ceph/mds_client.c
>>>>>> @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>>    {
>>>>>>        int mds = session->s_mds;
>>>>>>        struct ceph_mds_client *mdsc = session->s_mdsc;
>>>>>> +     struct ceph_client *cl = mdsc->fsc->client;
>>>>>>        struct ceph_msg *msg;
>>>>>>        struct ceph_mds_request_head_legacy *lhead;
>>>>>>        const char *path1 = NULL;
>>>>>> @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>>        lhead = find_legacy_request_head(msg->front.iov_base,
>>>>>>                                         session->s_con.peer_features);
>>>>>>
>>>>>> +     if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
>>>>>> +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
>>>>>> +             pr_err_ratelimited_client(cl,
>>>>>> +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
>>>>>> +                     " is not supported by MDS. Fail request with -EIO.\n");
>>>>>> +
>>>>>> +             ret = -EIO;
>>>>>> +             goto out_err;
>>>>>> +     }
>>>>>> +
>>>>> I think this couldn't fail the mounting operation, right ?
>>>> This won't fail mounting. First of all an idmapped mount is always an
>>>> additional mount, you always
>>>> start from doing "normal" mount and only after that you can use this
>>>> mount to create an idmapped one.
>>>> ( example: https://github.com/brauner/mount-idmapped/tree/master )
>>>>
>>>>> IMO we should fail the mounting from the beginning.
>>>> Unfortunately, we can't fail mount from the beginning. Procedure of
>>>> the idmapped mounts
>>>> creation is handled not on the filesystem level, but on the VFS level
>>> Correct. It's a generic vfsmount feature.
>>>
>>>> (source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774a004c0424260a90bd/fs/namespace.c#L4277
>>>> )
>>>>
>>>> Kernel perform all required checks as:
>>>> - filesystem type has declared to support idmappings
>>>> (fs_type->fs_flags & FS_ALLOW_IDMAP)
>>>> - user who creates idmapped mount should be CAP_SYS_ADMIN in a user
>>>> namespace that owns superblock of the filesystem
>>>> (for cephfs it's always init_user_ns => user should be root on the host)
>>>>
>>>> So I would like to go this way because of the reasons mentioned above:
>>>> - root user is someone who understands what he does.
>>>> - idmapped mounts are never "first" mounts. They are always created
>>>> after "normal" mount.
>>>> - effectively this check makes "normal" mount to work normally and
>>>> fail only requests that comes through an idmapped mounts
>>>> with reasonable error message. Obviously, all read operations will
>>>> work perfectly well only the operations that create new inodes will
>>>> fail.
>>>> Btw, we already have an analogical semantic on the VFS level for users
>>>> who have no UID/GID mapping to the host. Filesystem requests for
>>>> such users will fail with -EOVERFLOW. Here we have something close.
>>> Refusing requests coming from an idmapped mount if the server misses
>>> appropriate features is good enough as a first step imho. And yes, we do
>>> have similar logic on the vfs level for unmapped uid/gid.
>> Thanks, Christian!
>>
>> I wanted to add that alternative here is to modify caller_{u,g}id
>> fields as it was done in the first approach,
>> it will break the UID/GID-based permissions model for old MDS versions
>> (we can put printk_once to inform user about this),
>> but at the same time it will allow us to support idmapped mounts in
>> all cases. This support will be not fully ideal for old MDS
>>   and perfectly well for new MDS versions.
>>
>> Alternatively, we can introduce cephfs mount option like
>> "idmap_with_old_mds" and if it's enabled then we set caller_{u,g}id
>> for MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID, if it's disabled
>> (default) we fail requests with -EIO. For
>> new MDS everything goes in the right way.
>>
>> Kind regards,
>> Alex
> Hey there,
>
> A very strong +1 on there needing to be some way to make this work
> with older Ceph releases.
> Ceph Reef isn't out yet and we're in July 2023, so I'd really like not
> having to wait until Ceph Squid in mid 2024 to be able to make use of
> this!

IMO this shouldn't be an issue, because we can backport it to old releases.

Thanks

- Xiubo

>
> Some kind of mount option, module option or the like would all be fine for this.
>
> Stéphane
>

