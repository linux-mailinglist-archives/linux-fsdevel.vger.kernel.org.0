Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB67717C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjHGBZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 21:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGBZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82470E6A
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Aug 2023 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691371502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iHyHX4d5SoeUV4Iv3EVq9BzgWq82JWJZco3mAQrgS0=;
        b=UkFE4FVS0yVyF/a87eR1xJ5huW0MlWWlu86cECUkbWYj5MhzM9FoxCs2ZkeWxt9Dl1s2jC
        DRSdgNR5VWPJ2+inzKAifXzTqsEz3nlwRmbypxK081KSIwOOhC1yujoRJgUtAk0r1RdDaU
        QYOXhA54+qhtEPLbe1IyA2PNFrF7Wt0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-PF0Ip2mIOuWEbbWLpcAK-Q-1; Sun, 06 Aug 2023 21:25:01 -0400
X-MC-Unique: PF0Ip2mIOuWEbbWLpcAK-Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c964d031aso4184317a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 18:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691371500; x=1691976300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iHyHX4d5SoeUV4Iv3EVq9BzgWq82JWJZco3mAQrgS0=;
        b=YyW7704cq8OdTOj2TFuur9Ru7DbN1NAO/IffHBKAT8n0zZ/1M0rXHRoJFPyOF2wPDs
         5Pz2NQtTeItQxiXTXPAKos0NQNynOvSwODCnkOcUCDJkI6jEC8vFv3bnOT0N9zIJfanU
         sNuX2ZHBMkGDZhdH9Mfko1e9dv3V6YUo0tTOQhqnFcSNN5W7FU9Cn9209+TwU7y/z2BX
         fY9j3hD7rRpdtyS4D+Y4x2QIlKrJ5zz5pzurHmFU4qeGn6AlzSp2aeqfzRtMqspyKYCr
         NYFpM3zKRL+QNENbEnWCWVvkRojYhJz+01Pz9jh5k5ibtZWBOohwa2sqBKo57KDLtdvJ
         k0gg==
X-Gm-Message-State: AOJu0YyhdvO8xvHf6GARIf/uj3I5g0zML7ZpphAOMT4Yv/NtFEyW7LaV
        dfnHIM/+j1QTENODrxcGDqw2/B7s8TvZjrBWq87YYEDf/KuQ3xMBDFj1+BoNl03KShxvZovz8bZ
        hBCiBpurtlJ8jooEZXkN0CUa3NQ50FKDOTzIg
X-Received: by 2002:a17:902:ec89:b0:1b8:ae12:5610 with SMTP id x9-20020a170902ec8900b001b8ae125610mr9399317plg.7.1691371500529;
        Sun, 06 Aug 2023 18:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVVeg7682K2uZwYTdDNkJ3vWDjPiWEDfzQOiTDXmK//Z5/mZivpJZZVP/z8PiTNwGIXdtRfA==
X-Received: by 2002:a17:902:ec89:b0:1b8:ae12:5610 with SMTP id x9-20020a170902ec8900b001b8ae125610mr9399307plg.7.1691371500207;
        Sun, 06 Aug 2023 18:25:00 -0700 (PDT)
Received: from [10.72.112.59] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001bba3a4888bsm5499307plf.102.2023.08.06.18.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 18:24:59 -0700 (PDT)
Message-ID: <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com>
Date:   Mon, 7 Aug 2023 09:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <brauner@kernel.org>
>
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
> Link: https://github.com/ceph/ceph/pull/52575
> Link: https://tracker.ceph.com/issues/62217
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v7:
> 	- reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
> v8:
> 	- properly handled case when old MDS used with new kernel client
> ---
>   fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++++++---
>   fs/ceph/mds_client.h         |  5 +++-
>   include/linux/ceph/ceph_fs.h |  5 +++-
>   3 files changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 8829f55103da..41e4bf3811c4 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
>   	}
>   }
>   
> +static inline u16 mds_supported_head_version(struct ceph_mds_session *session)
> +{
> +	if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features))
> +		return 1;
> +
> +	if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features))
> +		return 2;
> +
> +	return CEPH_MDS_REQUEST_HEAD_VERSION;
> +}
> +
>   static struct ceph_mds_request_head_legacy *
>   find_legacy_request_head(void *p, u64 features)
>   {
> @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   {
>   	int mds = session->s_mds;
>   	struct ceph_mds_client *mdsc = session->s_mdsc;
> +	struct ceph_client *cl = mdsc->fsc->client;
>   	struct ceph_msg *msg;
>   	struct ceph_mds_request_head_legacy *lhead;
>   	const char *path1 = NULL;
> @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	void *p, *end;
>   	int ret;
>   	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
> -	bool old_version = !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features);
> +	u16 request_head_version = mds_supported_head_version(session);
>   
>   	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
>   			      req->r_parent, req->r_path1, req->r_ino1.ino,
> @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	 */
>   	if (legacy)
>   		len = sizeof(struct ceph_mds_request_head_legacy);
> -	else if (old_version)
> +	else if (request_head_version == 1)
>   		len = sizeof(struct ceph_mds_request_head_old);
> +	else if (request_head_version == 2)
> +		len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>   	else
>   		len = sizeof(struct ceph_mds_request_head);
>   
> @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
>   	/*
>   	 * The ceph_mds_request_head_legacy didn't contain a version field, and
>   	 * one was added when we moved the message version from 3->4.
> @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	if (legacy) {
>   		msg->hdr.version = cpu_to_le16(3);
>   		p = msg->front.iov_base + sizeof(*lhead);
> -	} else if (old_version) {
> +	} else if (request_head_version == 1) {
>   		struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
>   
>   		msg->hdr.version = cpu_to_le16(4);
>   		ohead->version = cpu_to_le16(1);
>   		p = msg->front.iov_base + sizeof(*ohead);
> +	} else if (request_head_version == 2) {
> +		struct ceph_mds_request_head *nhead = msg->front.iov_base;
> +
> +		msg->hdr.version = cpu_to_le16(6);
> +		nhead->version = cpu_to_le16(2);
> +
> +		p = msg->front.iov_base + offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>   	} else {
>   		struct ceph_mds_request_head *nhead = msg->front.iov_base;
> +		kuid_t owner_fsuid;
> +		kgid_t owner_fsgid;
>   
>   		msg->hdr.version = cpu_to_le16(6);
>   		nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
> +		nhead->struct_len = sizeof(struct ceph_mds_request_head);
> +
> +		owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> +					  VFSUIDT_INIT(req->r_cred->fsuid));
> +		owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> +					  VFSGIDT_INIT(req->r_cred->fsgid));
> +		nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
> +		nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
>   		p = msg->front.iov_base + sizeof(*nhead);
>   	}
>   
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
> index 5f2301ee88bc..b91699b08f26 100644
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
> @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
>   
>   	__le32 ext_num_retry;          /* new count retry attempts */
>   	__le32 ext_num_fwd;            /* new count fwd attempts */
> +
> +	__le32 struct_len;             /* to store size of struct ceph_mds_request_head */
> +	__le32 owner_uid, owner_gid;   /* used for OPs which create inodes */

Let's also initialize them to -1 for all the other requests as we do in 
your PR.

Thanks

- Xiubo



>   } __attribute__ ((packed));
>   
>   /* cap/lease release record */

