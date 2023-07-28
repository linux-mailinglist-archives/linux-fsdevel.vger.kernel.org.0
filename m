Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA57669F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjG1KNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjG1KNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBB2D60
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690539163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36P+r7DbNPBfWo4XOeJBPnwWmXV8Z/JHFi2a2sUUCQw=;
        b=RgH19BrCz6kgKRAFCusN4Bsn0Soj2cQ+cKLRG+CUYliuxnL7bXl+v2hoPW1ZvFvfolpGun
        ZBeQWZ1T0D4OeTtRazwILa3vNmskai8e62bVbo7yfRsMf5gse5pHqcZ3xF6PeIl3JYLU21
        V1SxDoCahRQdpVIWXBNdpojmNpj3m+s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-xONXqUmqMtGQqpZFYSFA6Q-1; Fri, 28 Jul 2023 06:12:41 -0400
X-MC-Unique: xONXqUmqMtGQqpZFYSFA6Q-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bba270c62dso13135525ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539160; x=1691143960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36P+r7DbNPBfWo4XOeJBPnwWmXV8Z/JHFi2a2sUUCQw=;
        b=g0ot9ji9wGCZ2CtSIwDSMYflAHKGG8l/m6gKqikKwpNIOsLrjj/iguydXEkK2JfY85
         1ONx26PbcrYdK65mTJF/BaACje+fFVKCCXb+X9aZiC426bQFoFpgLN4At5rXjx3zy1fx
         yLE/DF58CYhR16kLBZO4e93IN9n2vX/GybvpEeZ18Zq1HRtSyG7cDPphXhviUgQXgAnp
         hzuYiEWpdBQL/P9lyCd+TrGp30WOoYGhiCdpeDtnDEuadZ01D5Abp2CBzM8VmUHZ88Af
         rrC2GzffNskA2J7R3Y82J5Me5vX5U/AnS6umdiji4K2INFWlcPNJhak/vB+2xv674KYX
         Cj+Q==
X-Gm-Message-State: ABy/qLavTCD83Cy2c+t6W5uJtXEr0MjvilhXnGU4s7ltB81uWlP0ylaN
        PuMI7me2x0kJZEEgXquMLqxwJHDDS2l6EBR7wGvEP4aXMAhI0elrPtQGwDF0Sto8g9xzXxtxV9t
        d+1D5Q1Yp4Tftz2XbGXz6kVx9Kg==
X-Received: by 2002:a17:902:b187:b0:1b8:4e69:c8f7 with SMTP id s7-20020a170902b18700b001b84e69c8f7mr874684plr.23.1690539160550;
        Fri, 28 Jul 2023 03:12:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEj2r656ptP3/mIAQnYQLkqNV8TpnDyEz+Xd4nj5KeJpMksPMVzmWQhfo4lJjd/gQd41BswEw==
X-Received: by 2002:a17:902:b187:b0:1b8:4e69:c8f7 with SMTP id s7-20020a170902b18700b001b84e69c8f7mr874678plr.23.1690539160270;
        Fri, 28 Jul 2023 03:12:40 -0700 (PDT)
Received: from [10.72.112.17] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b8a3e2c241sm3205019plp.14.2023.07.28.03.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:12:39 -0700 (PDT)
Message-ID: <e1f56462-e8e7-d93f-9ff0-99b0c67f82fc@redhat.com>
Date:   Fri, 28 Jul 2023 18:12:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in
 create_request_message()
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
Content-Language: en-US
In-Reply-To: <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/27/23 22:46, Stéphane Graber wrote:
> On Thu, Jul 27, 2023 at 5:48 AM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com>  wrote:
>> On Thu, Jul 27, 2023 at 11:01 AM Christian Brauner<brauner@kernel.org>  wrote:
>>> On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote:
>>>> On Thu, Jul 27, 2023 at 7:30 AM Xiubo Li<xiubli@redhat.com>  wrote:
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
>>>>>> [1]https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
>>>>>> [2]https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>>>>>>
>>>>>> Cc: Xiubo Li<xiubli@redhat.com>
>>>>>> Cc: Jeff Layton<jlayton@kernel.org>
>>>>>> Cc: Ilya Dryomov<idryomov@gmail.com>
>>>>>> Cc:ceph-devel@vger.kernel.org
>>>>>> Co-Developed-by: Alexander Mikhalitsyn<aleksandr.mikhalitsyn@canonical.com>
>>>>>> Signed-off-by: Christian Brauner<christian.brauner@ubuntu.com>
>>>>>> Signed-off-by: Alexander Mikhalitsyn<aleksandr.mikhalitsyn@canonical.com>
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
>>>> ( example:https://github.com/brauner/mount-idmapped/tree/master  )
>>>>
>>>>> IMO we should fail the mounting from the beginning.
>>>> Unfortunately, we can't fail mount from the beginning. Procedure of
>>>> the idmapped mounts
>>>> creation is handled not on the filesystem level, but on the VFS level
>>> Correct. It's a generic vfsmount feature.
>>>
>>>> (source:https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774a004c0424260a90bd/fs/namespace.c#L4277
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

> Some kind of mount option, module option or the like would all be fine for this.
>
> Stéphane
>

