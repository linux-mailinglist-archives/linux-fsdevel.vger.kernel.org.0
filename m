Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55CC772248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjHGLbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjHGLbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8E4498
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691407503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzWjjr1YkRI8PC5b8h88z+oHcsBj7GLkdaZmjiCU1zM=;
        b=NOe5BvAy8PW5piTSD5cTY4TLjC8+RiL082APkZmVpzAG4tQlUtR0rHYXT/W8R3YIKpuvHG
        uHcCFTyNVKpAqMgZ0dYM1oBNnM3kMtJz/DBS9+WFGHHbcC7rvhGDHiFpOJ+V/NAr97Z4li
        MT5KkIKB7m9TmBF081AdcbNCHZRj5+s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-YMwCs3geMTmkQcfB2OjrnA-1; Mon, 07 Aug 2023 07:21:50 -0400
X-MC-Unique: YMwCs3geMTmkQcfB2OjrnA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26824cb0051so4096782a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 04:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407309; x=1692012109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzWjjr1YkRI8PC5b8h88z+oHcsBj7GLkdaZmjiCU1zM=;
        b=IgLzu3crunOG9BbgPHoI7Ca4NbwhVvD4BE08BF6CRt37qqfQ9LNZGZMgPjCmnqQ1wz
         QLxCfZ84W0gFSDg4j+fIu3A7OWBSUx0yZj73XX2DMi5oViUHxJTekahz6bBWJJ2wnRzI
         cmUh6htkjEyKAKeGIU+HP/lSH4iZ651YcoTkzqjnA6ErsFloOb/xiHjN/0G3er6fXMwo
         qsPsRpPUTKRcgwdVPIs9M8aKXrhJ0Cx9V97hrB2MDtWJfF+dmqF/746MDWloPYyoFQtN
         rZWf69p8JHtfHO4iLExWwMzomU5Cj00hCbnrz5VAdXLDPtLQG2EDp31Rlr3zp8ZMVgW0
         COKw==
X-Gm-Message-State: AOJu0YxcZGBHPMK97zaHCU8YxgupEa/+57fmAnM/0KGehx93Ls0Er16m
        OZW3YwsqrnN5wa9hGGMVTHx12jsJw64pycwz+nvAgmAZyiwaFWMsHNUDvSpUw90QiKK+RyUhfWw
        o6Q60Bjw2G9K0mqhgIfoSU4cuhQ==
X-Received: by 2002:a17:90b:1b46:b0:269:44a3:bd1e with SMTP id nv6-20020a17090b1b4600b0026944a3bd1emr4508934pjb.40.1691407309020;
        Mon, 07 Aug 2023 04:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYgaiQRwp8CaqdHHXZkHTYw70yAHx4hNrVUHwNvsZ8kIIKVpfxa7ETkd4Xbi8JbZUbldPGXg==
X-Received: by 2002:a17:90b:1b46:b0:269:44a3:bd1e with SMTP id nv6-20020a17090b1b4600b0026944a3bd1emr4508918pjb.40.1691407308654;
        Mon, 07 Aug 2023 04:21:48 -0700 (PDT)
Received: from [10.72.112.77] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a800100b00263f41a655esm5709045pjn.43.2023.08.07.04.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:21:48 -0700 (PDT)
Message-ID: <abb24879-1606-7cb4-c136-4ba1f18b1140@redhat.com>
Date:   Mon, 7 Aug 2023 19:21:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
 <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com>
 <CAEivzxedfaD7cPfQ-sspJabw_P6zSJtOrbiAGYN35LGXPoSwcg@mail.gmail.com>
 <d119ef88-d827-5e8d-13e3-74ddfea61d7f@redhat.com>
 <CAEivzxeu9c-ZLRmz6kmvwUpofPK23cGn27XtOBRP3xSgb_JyWA@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxeu9c-ZLRmz6kmvwUpofPK23cGn27XtOBRP3xSgb_JyWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/7/23 18:34, Aleksandr Mikhalitsyn wrote:
> On Mon, Aug 7, 2023 at 12:28 PM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 8/7/23 14:51, Aleksandr Mikhalitsyn wrote:
>>> On Mon, Aug 7, 2023 at 3:25 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>> On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
>>>>> From: Christian Brauner <brauner@kernel.org>
>>>>>
>>>>> Inode operations that create a new filesystem object such as ->mknod,
>>>>> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
>>>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
>>>>> filesystem object.
>>>>>
>>>>> In order to ensure that the correct {g,u}id is used map the caller's
>>>>> fs{g,u}id for creation requests. This doesn't require complex changes.
>>>>> It suffices to pass in the relevant idmapping recorded in the request
>>>>> message. If this request message was triggered from an inode operation
>>>>> that creates filesystem objects it will have passed down the relevant
>>>>> idmaping. If this is a request message that was triggered from an inode
>>>>> operation that doens't need to take idmappings into account the initial
>>>>> idmapping is passed down which is an identity mapping.
>>>>>
>>>>> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
>>>>> which adds two new fields (owner_{u,g}id) to the request head structure.
>>>>> So, we need to ensure that MDS supports it otherwise we need to fail
>>>>> any IO that comes through an idmapped mount because we can't process it
>>>>> in a proper way. MDS server without such an extension will use caller_{u,g}id
>>>>> fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
>>>>> values are unmapped. At the same time we can't map these fields with an
>>>>> idmapping as it can break UID/GID-based permission checks logic on the
>>>>> MDS side. This problem was described with a lot of details at [1], [2].
>>>>>
>>>>> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
>>>>> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>>>>>
>>>>> Link: https://github.com/ceph/ceph/pull/52575
>>>>> Link: https://tracker.ceph.com/issues/62217
>>>>> Cc: Xiubo Li <xiubli@redhat.com>
>>>>> Cc: Jeff Layton <jlayton@kernel.org>
>>>>> Cc: Ilya Dryomov <idryomov@gmail.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>>>> ---
>>>>> v7:
>>>>>         - reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
>>>>> v8:
>>>>>         - properly handled case when old MDS used with new kernel client
>>>>> ---
>>>>>     fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++++++---
>>>>>     fs/ceph/mds_client.h         |  5 +++-
>>>>>     include/linux/ceph/ceph_fs.h |  5 +++-
>>>>>     3 files changed, 52 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>>> index 8829f55103da..41e4bf3811c4 100644
>>>>> --- a/fs/ceph/mds_client.c
>>>>> +++ b/fs/ceph/mds_client.c
>>>>> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
>>>>>         }
>>>>>     }
>>>>>
>>>>> +static inline u16 mds_supported_head_version(struct ceph_mds_session *session)
>>>>> +{
>>>>> +     if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features))
>>>>> +             return 1;
>>>>> +
>>>>> +     if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features))
>>>>> +             return 2;
>>>>> +
>>>>> +     return CEPH_MDS_REQUEST_HEAD_VERSION;
>>>>> +}
>>>>> +
>>>>>     static struct ceph_mds_request_head_legacy *
>>>>>     find_legacy_request_head(void *p, u64 features)
>>>>>     {
>>>>> @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>     {
>>>>>         int mds = session->s_mds;
>>>>>         struct ceph_mds_client *mdsc = session->s_mdsc;
>>>>> +     struct ceph_client *cl = mdsc->fsc->client;
>>>>>         struct ceph_msg *msg;
>>>>>         struct ceph_mds_request_head_legacy *lhead;
>>>>>         const char *path1 = NULL;
>>>>> @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>         void *p, *end;
>>>>>         int ret;
>>>>>         bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
>>>>> -     bool old_version = !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features);
>>>>> +     u16 request_head_version = mds_supported_head_version(session);
>>>>>
>>>>>         ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
>>>>>                               req->r_parent, req->r_path1, req->r_ino1.ino,
>>>>> @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>          */
>>>>>         if (legacy)
>>>>>                 len = sizeof(struct ceph_mds_request_head_legacy);
>>>>> -     else if (old_version)
>>>>> +     else if (request_head_version == 1)
>>>>>                 len = sizeof(struct ceph_mds_request_head_old);
>>>>> +     else if (request_head_version == 2)
>>>>> +             len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>>>>>         else
>>>>>                 len = sizeof(struct ceph_mds_request_head);
>>>>>
>>>>> @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>         lhead = find_legacy_request_head(msg->front.iov_base,
>>>>>                                          session->s_con.peer_features);
>>>>>
>>>>> +     if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
>>>>> +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
>>>>> +             pr_err_ratelimited_client(cl,
>>>>> +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
>>>>> +                     " is not supported by MDS. Fail request with -EIO.\n");
>>>>> +
>>>>> +             ret = -EIO;
>>>>> +             goto out_err;
>>>>> +     }
>>>>> +
>>>>>         /*
>>>>>          * The ceph_mds_request_head_legacy didn't contain a version field, and
>>>>>          * one was added when we moved the message version from 3->4.
>>>>> @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>>>         if (legacy) {
>>>>>                 msg->hdr.version = cpu_to_le16(3);
>>>>>                 p = msg->front.iov_base + sizeof(*lhead);
>>>>> -     } else if (old_version) {
>>>>> +     } else if (request_head_version == 1) {
>>>>>                 struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
>>>>>
>>>>>                 msg->hdr.version = cpu_to_le16(4);
>>>>>                 ohead->version = cpu_to_le16(1);
>>>>>                 p = msg->front.iov_base + sizeof(*ohead);
>>>>> +     } else if (request_head_version == 2) {
>>>>> +             struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>>>> +
>>>>> +             msg->hdr.version = cpu_to_le16(6);
>>>>> +             nhead->version = cpu_to_le16(2);
>>>>> +
>>>>> +             p = msg->front.iov_base + offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>>>>>         } else {
>>>>>                 struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>>>> +             kuid_t owner_fsuid;
>>>>> +             kgid_t owner_fsgid;
>>>>>
>>>>>                 msg->hdr.version = cpu_to_le16(6);
>>>>>                 nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>>>>> +             nhead->struct_len = sizeof(struct ceph_mds_request_head);
>>>>> +
>>>>> +             owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
>>>>> +                                       VFSUIDT_INIT(req->r_cred->fsuid));
>>>>> +             owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
>>>>> +                                       VFSGIDT_INIT(req->r_cred->fsgid));
>>>>> +             nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
>>>>> +             nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
>>>>>                 p = msg->front.iov_base + sizeof(*nhead);
>>>>>         }
>>>>>
>>>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>>>> index e3bbf3ba8ee8..8f683e8203bd 100644
>>>>> --- a/fs/ceph/mds_client.h
>>>>> +++ b/fs/ceph/mds_client.h
>>>>> @@ -33,8 +33,10 @@ enum ceph_feature_type {
>>>>>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>>>>>         CEPHFS_FEATURE_OP_GETVXATTR,
>>>>>         CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>>> +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
>>>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>>>
>>>>> -     CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>>> +     CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>>>     };
>>>>>
>>>>>     #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
>>>>> @@ -49,6 +51,7 @@ enum ceph_feature_type {
>>>>>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
>>>>>         CEPHFS_FEATURE_OP_GETVXATTR,            \
>>>>>         CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
>>>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
>>>>>     }
>>>>>
>>>>>     /*
>>>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>>>>> index 5f2301ee88bc..b91699b08f26 100644
>>>>> --- a/include/linux/ceph/ceph_fs.h
>>>>> +++ b/include/linux/ceph/ceph_fs.h
>>>>> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
>>>>>         union ceph_mds_request_args args;
>>>>>     } __attribute__ ((packed));
>>>>>
>>>>> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
>>>>> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
>>>>>
>>>>>     struct ceph_mds_request_head_old {
>>>>>         __le16 version;                /* struct version */
>>>>> @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
>>>>>
>>>>>         __le32 ext_num_retry;          /* new count retry attempts */
>>>>>         __le32 ext_num_fwd;            /* new count fwd attempts */
>>>>> +
>>>>> +     __le32 struct_len;             /* to store size of struct ceph_mds_request_head */
>>>>> +     __le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
>>>> Let's also initialize them to -1 for all the other requests as we do in
>>>> your PR.
>>> They are always initialized already. As you can see from the code we
>>> don't have any extra conditions
>>> on filling these fields. We always fill them with an appropriate
>>> UID/GID. If mount is not idmapped then it's just == caller_uid/gid,
>>> if mount idmapped then it's idmapped caller_uid/gid.
>> Then in kclient all the request will always initialized the
>> 'owner_{uid/gid}' with 'caller_{uid/gid}'. While in userspace libcephfs
>> it will only set them for 'create/mknod/mkdir/symlink` instead.
>>
>> I'd prefer to make them consistent, which is what I am still focusing
>> on, to make them easier to read and comparing when troubles hooting.
> Dear Xiubo,
>
> Sure, I will do it.
>
> Couldn't you please review all the rest of the patches before I fix
> this particular thing?
> It will allow me to fix and send -v10 with all required fixes
> incorporated in it.

I have gone through them all and they LGTM.

Thanks

- Xiubo


> Kind regards,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>
>>> Kind regards,
>>> Alex
>>>
>>>> Thanks
>>>>
>>>> - Xiubo
>>>>
>>>>
>>>>
>>>>>     } __attribute__ ((packed));
>>>>>
>>>>>     /* cap/lease release record */

