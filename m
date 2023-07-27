Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB2764574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 07:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjG0FbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 01:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjG0FbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5626BC
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690435808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQ2ML1xqw9BhfeU4EwNnCivV5zBOBZFpu/6Cgz/mXpM=;
        b=NLUAVagq9PwC2U2V2KsiVmASwj8Q2iW66t1jkK7PH/wzXkN79fYOpATdl/EVHiIUIufkcM
        YGk0MT8dW7cFINZgXT8rTAIdMwNmAhKp7FuFdTav9mdvGIflDhNAThvDjav+Sb/FHj3VLU
        J11/AshoXiTP7N/o3D5sw4r45thyLf0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-DcHvzNdKMpSu_HVXTz0jNQ-1; Thu, 27 Jul 2023 01:30:07 -0400
X-MC-Unique: DcHvzNdKMpSu_HVXTz0jNQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2680b547d3fso346366a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 22:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435806; x=1691040606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ2ML1xqw9BhfeU4EwNnCivV5zBOBZFpu/6Cgz/mXpM=;
        b=T3mmmAfsayg95B8JW2TqYqOU0lDVK5vFC2I/N6/OAxAkUjjKCgMjPzWmfz/PQHsL7E
         KWwuFYpQumYe4AX2po3aZlC5WqAa4eDWVCPlw62t9Lg2Vv5DIh3l+Q0rEItb4wb0er4i
         ELGy/iHdJRC3tOaoT3fWU6TYiZd8fOoTDkFUP3K09v4D7AJ4SvZi5X2z54neAQl721/F
         27iGdwLq1Y4tmk0y2roGymCDrDERUwMxMKMralQlUD8LRcwSH1LJAhxStN9kcN1W+LJB
         L3bxVNFzfAuDdbZMpqJoar64Bt/kPYBJvvHjzKJWzQfYo0k2cxZnIbF2j+UmQL1Vic4M
         1gSA==
X-Gm-Message-State: ABy/qLZ1aM50R4Rt7Jyx9xDkfR2uyViOfOeZ+MZnHlpokXNvemhbywst
        VE82TaFeFc7jPRlMONjRekcErOI0MJJUbe4BJmoyK9JMZp9eDyRMlsEFiz97BOKpTaQS/pqALn7
        TnROY7mtK3Vs3OsKlJ+lQbDt0Jw==
X-Received: by 2002:a17:90b:3613:b0:268:10a3:cea8 with SMTP id ml19-20020a17090b361300b0026810a3cea8mr3170709pjb.9.1690435805912;
        Wed, 26 Jul 2023 22:30:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEiWX1cXRTnmUuvbhHyZPYAhEe3NIXOKlBtyurVEGkjtBx2QH4v1q50q42s88XaK19jAWdY1Q==
X-Received: by 2002:a17:90b:3613:b0:268:10a3:cea8 with SMTP id ml19-20020a17090b361300b0026810a3cea8mr3170696pjb.9.1690435805597;
        Wed, 26 Jul 2023 22:30:05 -0700 (PDT)
Received: from [10.72.12.248] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0026812c28365sm411949pjl.37.2023.07.26.22.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:30:05 -0700 (PDT)
Message-ID: <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com>
Date:   Thu, 27 Jul 2023 13:29:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> Inode operations that create a new filesystem object such as ->mknod,
> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> filesystem object.
>
> In order to ensure that the correct {g,u}id is used map the caller's
> fs{g,u}id for creation requests. This doesn't require complex changes.
> It suffices to pass in the relevant idmapping recorded in the request
> message. If this request message was triggered from an inode operation
> that creates filesystem objects it will have passed down the relevant
> idmaping. If this is a request message that was triggered from an inode
> operation that doens't need to take idmappings into account the initial
> idmapping is passed down which is an identity mapping.
>
> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> which adds two new fields (owner_{u,g}id) to the request head structure.
> So, we need to ensure that MDS supports it otherwise we need to fail
> any IO that comes through an idmapped mount because we can't process it
> in a proper way. MDS server without such an extension will use caller_{u,g}id
> fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
> values are unmapped. At the same time we can't map these fields with an
> idmapping as it can break UID/GID-based permission checks logic on the
> MDS side. This problem was described with a lot of details at [1], [2].
>
> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v7:
> 	- reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
> ---
>   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
>   fs/ceph/mds_client.h         |  5 ++++-
>   include/linux/ceph/ceph_fs.h |  4 +++-
>   3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c641ab046e98..ac095a95f3d0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   {
>   	int mds = session->s_mds;
>   	struct ceph_mds_client *mdsc = session->s_mdsc;
> +	struct ceph_client *cl = mdsc->fsc->client;
>   	struct ceph_msg *msg;
>   	struct ceph_mds_request_head_legacy *lhead;
>   	const char *path1 = NULL;
> @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	lhead = find_legacy_request_head(msg->front.iov_base,
>   					 session->s_con.peer_features);
>   
> +	if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
> +	    !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
> +		pr_err_ratelimited_client(cl,
> +			"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
> +			" is not supported by MDS. Fail request with -EIO.\n");
> +
> +		ret = -EIO;
> +		goto out_err;
> +	}
> +

I think this couldn't fail the mounting operation, right ?

IMO we should fail the mounting from the beginning.

Thanks

- Xiubo


>   	/*
>   	 * The ceph_mds_request_head_legacy didn't contain a version field, and
>   	 * one was added when we moved the message version from 3->4.
> @@ -3043,10 +3054,19 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   		p = msg->front.iov_base + sizeof(*ohead);
>   	} else {
>   		struct ceph_mds_request_head *nhead = msg->front.iov_base;
> +		kuid_t owner_fsuid;
> +		kgid_t owner_fsgid;
>   
>   		msg->hdr.version = cpu_to_le16(6);
>   		nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>   		p = msg->front.iov_base + sizeof(*nhead);
> +
> +		owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> +					  VFSUIDT_INIT(req->r_cred->fsuid));
> +		owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> +					  VFSGIDT_INIT(req->r_cred->fsgid));
> +		nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
> +		nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
>   	}
>   
>   	end = msg->front.iov_base + msg->front.iov_len;
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index e3bbf3ba8ee8..8f683e8203bd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -33,8 +33,10 @@ enum ceph_feature_type {
>   	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>   	CEPHFS_FEATURE_OP_GETVXATTR,
>   	CEPHFS_FEATURE_32BITS_RETRY_FWD,
> +	CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> +	CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>   
> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_32BITS_RETRY_FWD,
> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>   };
>   
>   #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
> @@ -49,6 +51,7 @@ enum ceph_feature_type {
>   	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,	\
>   	CEPHFS_FEATURE_OP_GETVXATTR,		\
>   	CEPHFS_FEATURE_32BITS_RETRY_FWD,	\
> +	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
>   }
>   
>   /*
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index 5f2301ee88bc..6eb83a51341c 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
>   	union ceph_mds_request_args args;
>   } __attribute__ ((packed));
>   
> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
>   
>   struct ceph_mds_request_head_old {
>   	__le16 version;                /* struct version */
> @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
>   
>   	__le32 ext_num_retry;          /* new count retry attempts */
>   	__le32 ext_num_fwd;            /* new count fwd attempts */
> +
> +	__le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
>   } __attribute__ ((packed));
>   
>   /* cap/lease release record */

