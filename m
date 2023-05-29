Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEF714268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE2DxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjE2DxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 23:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF7AF
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 20:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685332339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yv0BvrOUhZXktYOJqU5ovUPK8BeqNy3BlYh09XT4PBM=;
        b=aRTxvKdQcWRbPTMWUmshlaw7zmErw4y6fVUoRmybuDZAZPBvk54WkaKItQLOn8bDlXVXVF
        mBr6e4CbE6Rhj6nXu66vetdDXJr5QTHr9gn7lwm6wN8hjdp6OyytaLpiVnIgoAuQcboPEQ
        YbnVzVG7FoKTyH9pvdy/WzxshJDD2ek=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-zEVXCK8nNPScovUqAEW2PA-1; Sun, 28 May 2023 23:52:18 -0400
X-MC-Unique: zEVXCK8nNPScovUqAEW2PA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b00f70e6b0so31680135ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685332337; x=1687924337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0BvrOUhZXktYOJqU5ovUPK8BeqNy3BlYh09XT4PBM=;
        b=l41XyoGRSBPyKqMUlcJb1k8ncKbjQDEV7M5I4cnx1WuGoPI0z7sixFKiWAw0KhD/st
         lIYm3/tW7yMrT9dQayzThRYNH7ngGOO8wGW1kyglUjUEmWz0Q1OrTiZUWdGChRTr9c+m
         BjokBjIGUESi/h/XjCEheiyQIkbEje4lnNfwxuUfP8g0je0a28WcKZ1u0/slJfQC0QeE
         bLabjswQmMrLo0rHT+GpF7jFVw+nY6c2LZKceKdGBXo2ySV0LOMjY6KBXszIzGxqvn19
         KQgWzbZKK7Fne/ilLuSv0bGMPMoNT0enkGDAl3daWeMOYX415SxzUC0aZEKw8WGXsxN7
         FNtQ==
X-Gm-Message-State: AC+VfDz6QOityzxgYefDcJVKjl35F4ZdWnNd91r680JHQ5a5bC2fpbyI
        h5IKDYjTqnA0uCrMGsETyZJB2892DBR7GHyZiTevF4cdbh54cmCcI6SCuY0otI41XHNHJUpWDf9
        QKoIpTBPay2erz1dJFz6CCeR/VA==
X-Received: by 2002:a17:902:e54f:b0:1b0:26f0:4c72 with SMTP id n15-20020a170902e54f00b001b026f04c72mr7676196plf.28.1685332337108;
        Sun, 28 May 2023 20:52:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dZq108YskAboWL+3/58iiKfTUBxI3YljCU5QqSKjIqVg3pFOrQW1fFS0+aZ4RDqPSHSJG7w==
X-Received: by 2002:a17:902:e54f:b0:1b0:26f0:4c72 with SMTP id n15-20020a170902e54f00b001b026f04c72mr7676180plf.28.1685332336817;
        Sun, 28 May 2023 20:52:16 -0700 (PDT)
Received: from [10.72.12.188] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d30500b001b04a6707d3sm118297plc.141.2023.05.28.20.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 20:52:16 -0700 (PDT)
Message-ID: <ec6d6cf4-a1f9-ac45-d23d-b69805d81c02@redhat.com>
Date:   Mon, 29 May 2023 11:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/13] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-4-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230524153316.476973-4-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Inode operations that create a new filesystem object such as ->mknod,
> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> filesystem object.
>
> Cephfs mds creation request argument structures mirror this filesystem
> behavior. They don't encode a {g,u}id explicitly. Instead the caller's
> fs{g,u}id that is always sent as part of any mds request is used by the
> servers to set the {g,u}id of the new filesystem object.
>
> In order to ensure that the correct {g,u}id is used map the caller's
> fs{g,u}id for creation requests. This doesn't require complex changes.
> It suffices to pass in the relevant idmapping recorded in the request
> message. If this request message was triggered from an inode operation
> that creates filesystem objects it will have passed down the relevant
> idmaping. If this is a request message that was triggered from an inode
> operation that doens't need to take idmappings into account the initial
> idmapping is passed down which is an identity mapping and thus is
> guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.
>
> The last few weeks before Christmas 2021 I have spent time not just
> reading and poking the cephfs kernel code but also took a look at the
> ceph mds server userspace to ensure I didn't miss some subtlety.
>
> This made me aware of one complication to solve. All requests send the
> caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters for the
> server in exactly two cases:
>
> 1. to set the ownership for creation requests
> 2. to determine whether this client is allowed access on this server
>
> Case 1. we already covered and explained. Case 2. is only relevant for
> servers where an explicit uid access restriction has been set. That is
> to say the mds server restricts access to requests coming from a
> specific uid. Servers without uid restrictions will grant access to
> requests from any uid by setting MDS_AUTH_UID_ANY.
>
> Case 2. introduces the complication because the caller's fs{g,u}id is
> not just used to record ownership but also serves as the {g,u}id used
> when checking access to the server.
>
> Consider a user mounting a cephfs client and creating an idmapped mount
> from it that maps files owned by uid 1000 to be owned uid 0:
>
> mount -t cephfs -o [...] /unmapped
> mount-idmapped --map-mount 1000:0:1 /idmapped
>
> That is to say if the mounted cephfs filesystem contains a file "file1"
> which is owned by uid 1000:
>
> - looking at it via /unmapped/file1 will report it as owned by uid 1000
>    (One can think of this as the on-disk value.)
> - looking at it via /idmapped/file1 will report it as owned by uid 0
>
> Now, consider creating new files via the idmapped mount at /idmapped.
> When a caller with fs{g,u}id 1000 creates a file "file2" by going
> through the idmapped mount mounted at /idmapped it will create a file
> that is owned by uid 1000 on-disk, i.e.:
>
> - looking at it via /unmapped/file2 will report it as owned by uid 1000
> - looking at it via /idmapped/file2 will report it as owned by uid 0
>
> Now consider an mds server that has a uid access restriction set and
> only grants access to requests from uid 0.
>
> If the client sends a creation request for a file e.g. /idmapped/file2
> it will send the caller's fs{g,u}id idmapped according to the idmapped
> mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,u}id
> 0 in the idmapped mount and will be sent over the wire allowing the
> caller access to the mds server.
>
> However, if the caller is not issuing a creation request the caller's
> fs{g,u}id will be send without the mount's idmapping applied. So if the
> caller that just successfully created a new file on the restricted mds
> server sends a request as fs{g,u}id 1000 access will be refused. This
> however is inconsistent.
>
>  From my perspective the root of the problem lies in the fact that
> creation requests implicitly infer the ownership from the {g,u}id that
> gets sent along with every mds request.
>
> I have thought of multiple ways of addressing this problem but the one I
> prefer is to give all mds requests that create a filesystem object a
> proper, separate {g,u}id field entry in the argument struct. This is,
> for example how ->setattr mds requests work.
>
> This way the caller's fs{g,u}id can be used consistenly for server
> access checks and is separated from the ownership for new filesystem
> objects.
>
> Servers could then be updated to refuse creation requests whenever the
> {g,u}id used for access checking doesn't match the {g,u}id used for
> creating the filesystem object just as is done for setattr requests on a
> uid restricted server. But I am, of course, open to other suggestions.
>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/ceph/mds_client.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 810c3db2e369..e4265843b838 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2583,6 +2583,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	void *p, *end;
>   	int ret;
>   	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
> +	kuid_t caller_fsuid;
> +	kgid_t caller_fsgid;
>   
>   	ret = set_request_path_attr(req->r_inode, req->r_dentry,
>   			      req->r_parent, req->r_path1, req->r_ino1.ino,
> @@ -2651,10 +2653,22 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   
>   	head->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
>   	head->op = cpu_to_le32(req->r_op);
> -	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
> -						 req->r_cred->fsuid));
> -	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
> -						 req->r_cred->fsgid));
> +	/*
> +	 * Inode operations that create filesystem objects based on the
> +	 * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() etc. don't
> +	 * have separate {g,u}id fields in their respective structs in the
> +	 * ceph_mds_request_args union. Instead the caller_{g,u}id field is
> +	 * used to set ownership of the newly created inode by the mds server.
> +	 * For these inode operations we need to send the mapped fs{g,u}id over
> +	 * the wire. For other cases we simple set req->r_mnt_idmap to the
> +	 * initial idmapping meaning the unmapped fs{g,u}id is sent.
> +	 */
> +	caller_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> +					VFSUIDT_INIT(req->r_cred->fsuid));
> +	caller_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> +					VFSGIDT_INIT(req->r_cred->fsgid));
> +	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns, caller_fsuid));
> +	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns, caller_fsgid));

Hi Alexander,

You didn't answer Jeff and Greg's concerns in the first version 
https://www.spinics.net/lists/ceph-devel/msg53356.html.

I am also confused as Greg mentioned. If we just map the ids as 1000:0 
and created a file and then map the ids 1000:10, then the file couldn't 
be accessible, right ? Is this normal and as expected ?

IMO the idmapping should be client-side feature and we should make it 
consistent by using the unmapped fs{g,u}id always here.

Thanks

- Xiubo

>   	head->ino = cpu_to_le64(req->r_deleg_ino);
>   	head->args = req->r_args;
>   

