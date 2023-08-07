Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDD771E10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHGK3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 06:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjHGK3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97BF1711
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691404123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XN5gC0ZQhXU2kLFdzGcj+W8wiDigmtGB2Pp+bBDFoSU=;
        b=IbPXGQaRk3R24zeDqbVpBvBMxgLdmFNhZkEikNiNQXEB8DkJVR4Z0bwEQntjBLoPsrdum2
        kgFHEjr9W4RWyTuQq3JoTdJWnPkRNv4pXK1pclRkofqveDFgYwZQ03ST933qLOnKvQBwl1
        3rGSDomu786rQHq7BvC6VmlAAqDHsdM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-xUc3GhC-OdWlWU_q4XIE_g-1; Mon, 07 Aug 2023 06:28:42 -0400
X-MC-Unique: xUc3GhC-OdWlWU_q4XIE_g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c04f5827eso2823726a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 03:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691404121; x=1692008921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN5gC0ZQhXU2kLFdzGcj+W8wiDigmtGB2Pp+bBDFoSU=;
        b=iujyrLvfEXTAjMGnzgwurl5EGoSMABm4CT5kEZVd6I8Zf4cAL7/ePMm7jNG38lr0G8
         lVele91uQXxBh52yrZy2bc1g1zG1vieKNgKnxs/FSx/fDtpUyng3L0ipBUGwA6STQA/j
         oqPaAH2hJb1pSXMoP1xz7Uzlfda3md1sEI1b4IBxxi2yUVu5Rv4x7SQvo1wwqw1zrDrk
         wJPqTqFIsTVAbJmRHLJpEQvRaU0vgKaPkl8dgcN+0pXHHcuryVXXmOLo/vpI4xMl18fM
         jB33SIkJaSJfQRIldw2fUGaHJeuCBYQr9WodRDn4XtbPrd3tkeYsgr6x4tfcTXFRWFP1
         j/CQ==
X-Gm-Message-State: AOJu0YwuF4J1kuDaELvI2JJn1zgrIAiI4W4aVHFxpZ5RzufiaeSn8FAm
        P+1kD8cRMstEwrWeJLBFU6CBsVCt0oDACfauIKSLlL2pzgbLXRUUVo2jLbKw336oNLih/8mMPT9
        k3N3er3vZNQP3mGtjd+nygHTgVQ==
X-Received: by 2002:a05:6a20:440f:b0:13e:6447:ce45 with SMTP id ce15-20020a056a20440f00b0013e6447ce45mr11316168pzb.43.1691404121365;
        Mon, 07 Aug 2023 03:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqZ5UzWbNU/K0Wn3ZoOZbyQXnqktfWrcWflO+hgiN2LZKzJ57Xe0+YfWE1WaTxMokIQPfo1w==
X-Received: by 2002:a05:6a20:440f:b0:13e:6447:ce45 with SMTP id ce15-20020a056a20440f00b0013e6447ce45mr11316143pzb.43.1691404120950;
        Mon, 07 Aug 2023 03:28:40 -0700 (PDT)
Received: from [10.72.112.77] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b00687790191a2sm5850320pfo.58.2023.08.07.03.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 03:28:40 -0700 (PDT)
Message-ID: <d119ef88-d827-5e8d-13e3-74ddfea61d7f@redhat.com>
Date:   Mon, 7 Aug 2023 18:28:35 +0800
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
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxedfaD7cPfQ-sspJabw_P6zSJtOrbiAGYN35LGXPoSwcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/7/23 14:51, Aleksandr Mikhalitsyn wrote:
> On Mon, Aug 7, 2023 at 3:25 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
>>> From: Christian Brauner <brauner@kernel.org>
>>>
>>> Inode operations that create a new filesystem object such as ->mknod,
>>> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
>>> filesystem object.
>>>
>>> In order to ensure that the correct {g,u}id is used map the caller's
>>> fs{g,u}id for creation requests. This doesn't require complex changes.
>>> It suffices to pass in the relevant idmapping recorded in the request
>>> message. If this request message was triggered from an inode operation
>>> that creates filesystem objects it will have passed down the relevant
>>> idmaping. If this is a request message that was triggered from an inode
>>> operation that doens't need to take idmappings into account the initial
>>> idmapping is passed down which is an identity mapping.
>>>
>>> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
>>> which adds two new fields (owner_{u,g}id) to the request head structure.
>>> So, we need to ensure that MDS supports it otherwise we need to fail
>>> any IO that comes through an idmapped mount because we can't process it
>>> in a proper way. MDS server without such an extension will use caller_{u,g}id
>>> fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
>>> values are unmapped. At the same time we can't map these fields with an
>>> idmapping as it can break UID/GID-based permission checks logic on the
>>> MDS side. This problem was described with a lot of details at [1], [2].
>>>
>>> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
>>> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>>>
>>> Link: https://github.com/ceph/ceph/pull/52575
>>> Link: https://tracker.ceph.com/issues/62217
>>> Cc: Xiubo Li <xiubli@redhat.com>
>>> Cc: Jeff Layton <jlayton@kernel.org>
>>> Cc: Ilya Dryomov <idryomov@gmail.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>> ---
>>> v7:
>>>        - reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
>>> v8:
>>>        - properly handled case when old MDS used with new kernel client
>>> ---
>>>    fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++++++---
>>>    fs/ceph/mds_client.h         |  5 +++-
>>>    include/linux/ceph/ceph_fs.h |  5 +++-
>>>    3 files changed, 52 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index 8829f55103da..41e4bf3811c4 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
>>>        }
>>>    }
>>>
>>> +static inline u16 mds_supported_head_version(struct ceph_mds_session *session)
>>> +{
>>> +     if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features))
>>> +             return 1;
>>> +
>>> +     if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features))
>>> +             return 2;
>>> +
>>> +     return CEPH_MDS_REQUEST_HEAD_VERSION;
>>> +}
>>> +
>>>    static struct ceph_mds_request_head_legacy *
>>>    find_legacy_request_head(void *p, u64 features)
>>>    {
>>> @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>    {
>>>        int mds = session->s_mds;
>>>        struct ceph_mds_client *mdsc = session->s_mdsc;
>>> +     struct ceph_client *cl = mdsc->fsc->client;
>>>        struct ceph_msg *msg;
>>>        struct ceph_mds_request_head_legacy *lhead;
>>>        const char *path1 = NULL;
>>> @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>        void *p, *end;
>>>        int ret;
>>>        bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
>>> -     bool old_version = !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features);
>>> +     u16 request_head_version = mds_supported_head_version(session);
>>>
>>>        ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
>>>                              req->r_parent, req->r_path1, req->r_ino1.ino,
>>> @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>         */
>>>        if (legacy)
>>>                len = sizeof(struct ceph_mds_request_head_legacy);
>>> -     else if (old_version)
>>> +     else if (request_head_version == 1)
>>>                len = sizeof(struct ceph_mds_request_head_old);
>>> +     else if (request_head_version == 2)
>>> +             len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>>>        else
>>>                len = sizeof(struct ceph_mds_request_head);
>>>
>>> @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>        lhead = find_legacy_request_head(msg->front.iov_base,
>>>                                         session->s_con.peer_features);
>>>
>>> +     if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
>>> +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
>>> +             pr_err_ratelimited_client(cl,
>>> +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
>>> +                     " is not supported by MDS. Fail request with -EIO.\n");
>>> +
>>> +             ret = -EIO;
>>> +             goto out_err;
>>> +     }
>>> +
>>>        /*
>>>         * The ceph_mds_request_head_legacy didn't contain a version field, and
>>>         * one was added when we moved the message version from 3->4.
>>> @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>>>        if (legacy) {
>>>                msg->hdr.version = cpu_to_le16(3);
>>>                p = msg->front.iov_base + sizeof(*lhead);
>>> -     } else if (old_version) {
>>> +     } else if (request_head_version == 1) {
>>>                struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
>>>
>>>                msg->hdr.version = cpu_to_le16(4);
>>>                ohead->version = cpu_to_le16(1);
>>>                p = msg->front.iov_base + sizeof(*ohead);
>>> +     } else if (request_head_version == 2) {
>>> +             struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>> +
>>> +             msg->hdr.version = cpu_to_le16(6);
>>> +             nhead->version = cpu_to_le16(2);
>>> +
>>> +             p = msg->front.iov_base + offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>>>        } else {
>>>                struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>> +             kuid_t owner_fsuid;
>>> +             kgid_t owner_fsgid;
>>>
>>>                msg->hdr.version = cpu_to_le16(6);
>>>                nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>>> +             nhead->struct_len = sizeof(struct ceph_mds_request_head);
>>> +
>>> +             owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
>>> +                                       VFSUIDT_INIT(req->r_cred->fsuid));
>>> +             owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
>>> +                                       VFSGIDT_INIT(req->r_cred->fsgid));
>>> +             nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
>>> +             nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
>>>                p = msg->front.iov_base + sizeof(*nhead);
>>>        }
>>>
>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>> index e3bbf3ba8ee8..8f683e8203bd 100644
>>> --- a/fs/ceph/mds_client.h
>>> +++ b/fs/ceph/mds_client.h
>>> @@ -33,8 +33,10 @@ enum ceph_feature_type {
>>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>>>        CEPHFS_FEATURE_OP_GETVXATTR,
>>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>> +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>
>>> -     CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>> +     CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>    };
>>>
>>>    #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
>>> @@ -49,6 +51,7 @@ enum ceph_feature_type {
>>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
>>>        CEPHFS_FEATURE_OP_GETVXATTR,            \
>>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
>>>    }
>>>
>>>    /*
>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>>> index 5f2301ee88bc..b91699b08f26 100644
>>> --- a/include/linux/ceph/ceph_fs.h
>>> +++ b/include/linux/ceph/ceph_fs.h
>>> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
>>>        union ceph_mds_request_args args;
>>>    } __attribute__ ((packed));
>>>
>>> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
>>> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
>>>
>>>    struct ceph_mds_request_head_old {
>>>        __le16 version;                /* struct version */
>>> @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
>>>
>>>        __le32 ext_num_retry;          /* new count retry attempts */
>>>        __le32 ext_num_fwd;            /* new count fwd attempts */
>>> +
>>> +     __le32 struct_len;             /* to store size of struct ceph_mds_request_head */
>>> +     __le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
>> Let's also initialize them to -1 for all the other requests as we do in
>> your PR.
> They are always initialized already. As you can see from the code we
> don't have any extra conditions
> on filling these fields. We always fill them with an appropriate
> UID/GID. If mount is not idmapped then it's just == caller_uid/gid,
> if mount idmapped then it's idmapped caller_uid/gid.

Then in kclient all the request will always initialized the 
'owner_{uid/gid}' with 'caller_{uid/gid}'. While in userspace libcephfs 
it will only set them for 'create/mknod/mkdir/symlink` instead.

I'd prefer to make them consistent, which is what I am still focusing 
on, to make them easier to read and comparing when troubles hooting.

Thanks

- Xiubo

> Kind regards,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>
>>
>>
>>>    } __attribute__ ((packed));
>>>
>>>    /* cap/lease release record */

