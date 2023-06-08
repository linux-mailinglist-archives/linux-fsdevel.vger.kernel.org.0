Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78E727539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjFHCu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjFHCu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A811FF7
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 19:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686192610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tuec0jKorjW3abx5vC9xzgC+qO8AVpXPFGA3JYTZHxw=;
        b=iDSoOENgjYrDCraA/+zw8DOrJB2GN5Hz2OPqI05DOSP2m86gUTKUvZPSiZlcsVeM59bl/I
        95KjDA6UuqEpswO7RdspJ38SVrpxZl5WhOlDlaql6VNFZHFntdYS4W3ONc+ApXyXoViedy
        PypwgnSroIlssUCRj5zclNczLyZwOXk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-kl7tGc-nPh6XrvzoSOstFg-1; Wed, 07 Jun 2023 22:50:09 -0400
X-MC-Unique: kl7tGc-nPh6XrvzoSOstFg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b0314f0aadso1616835ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 19:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686192608; x=1688784608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuec0jKorjW3abx5vC9xzgC+qO8AVpXPFGA3JYTZHxw=;
        b=WD1V0cByUOjEU06Po+MyTntjnfroPmuKFdJsT1Os0KALlWWQhfgh5JszuTi2OH/zvE
         ZRHDiFSaTsLJqeS0UxLmJycwCnXVxhXzYnhHCjMHppMXoHfAbXjsXC6UWOMrH6t49Nkn
         JLJhNRGFPuOUomlAHAUkQOr7HLeuhQHtKImjPD59wx++OCRjFTVlX6fZ9VI73QB/8KqZ
         Ftr341QeSbDxF4c6zTkRmj0Ve2HHyRytWy8eecUTkpKlCmVvIoofFjIOdalI/rCSL9KA
         bM6CW94LHWFPCdJ7E3WrkzO8RJ2lm1ZlcTQiy4t9RFmzLMHXISrRwEYBM2a50wIMYlrb
         zEtQ==
X-Gm-Message-State: AC+VfDyTunbJT6gdkr4AhWfLXvOu8jlOoxQmsMAD1evTymwz1wg3SgG4
        s4BEWmIj92XxKkbnixxaypAtdzyqWkrR/b0Ncq+vMQPyqNMtzMNez8C6bcd2Jh/fyWSSPILjWAf
        yiOz+yEDT1WtYh5M+ZRxcPGiRMg==
X-Received: by 2002:a17:903:230a:b0:1ad:d542:6e14 with SMTP id d10-20020a170903230a00b001add5426e14mr973623plh.12.1686192608196;
        Wed, 07 Jun 2023 19:50:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6itOIvrnnLnEWMdjTRy3f3rHNskO67Z99VSuETtLabd21ScJatQO03ScLrZTuzsiiYoqJWcg==
X-Received: by 2002:a17:903:230a:b0:1ad:d542:6e14 with SMTP id d10-20020a170903230a00b001add5426e14mr973606plh.12.1686192607910;
        Wed, 07 Jun 2023 19:50:07 -0700 (PDT)
Received: from [10.72.13.135] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001b176ba9f17sm195739plg.149.2023.06.07.19.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 19:50:07 -0700 (PDT)
Message-ID: <f1e81edf-595b-3f7c-3f00-2c96718fbb69@redhat.com>
Date:   Thu, 8 Jun 2023 10:49:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 11/14] ceph: allow idmapped setattr inode op
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
 <20230607180958.645115-12-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230607180958.645115-12-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/8/23 02:09, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
> of passing down the mount's idmapping.
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> [ adapted to b27c82e12965 ("attr: port attribute changes to new types") ]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v4:
> 	- introduced fsuid/fsgid local variables
> v3:
> 	- reworked as Christian suggested here:
> 	https://lore.kernel.org/lkml/20230602-vorzeichen-praktikum-f17931692301@brauner/
> ---
>   fs/ceph/inode.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index bcd9b506ec3b..ca438d1353b2 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2052,31 +2052,35 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
>   	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
>   
>   	if (ia_valid & ATTR_UID) {
> +		kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
> +
>   		dout("setattr %p uid %d -> %d\n", inode,
>   		     from_kuid(&init_user_ns, inode->i_uid),
>   		     from_kuid(&init_user_ns, attr->ia_uid));
>   		if (issued & CEPH_CAP_AUTH_EXCL) {
> -			inode->i_uid = attr->ia_uid;
> +			inode->i_uid = fsuid;
>   			dirtied |= CEPH_CAP_AUTH_EXCL;
>   		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
> -			   !uid_eq(attr->ia_uid, inode->i_uid)) {
> +			   !uid_eq(fsuid, inode->i_uid)) {
>   			req->r_args.setattr.uid = cpu_to_le32(
> -				from_kuid(&init_user_ns, attr->ia_uid));
> +				from_kuid(&init_user_ns, fsuid));
>   			mask |= CEPH_SETATTR_UID;
>   			release |= CEPH_CAP_AUTH_SHARED;
>   		}
>   	}
>   	if (ia_valid & ATTR_GID) {
> +		kgid_t fsgid = from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid);
> +
>   		dout("setattr %p gid %d -> %d\n", inode,
>   		     from_kgid(&init_user_ns, inode->i_gid),
>   		     from_kgid(&init_user_ns, attr->ia_gid));
>   		if (issued & CEPH_CAP_AUTH_EXCL) {
> -			inode->i_gid = attr->ia_gid;
> +			inode->i_gid = fsgid;
>   			dirtied |= CEPH_CAP_AUTH_EXCL;
>   		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
> -			   !gid_eq(attr->ia_gid, inode->i_gid)) {
> +			   !gid_eq(fsgid, inode->i_gid)) {
>   			req->r_args.setattr.gid = cpu_to_le32(
> -				from_kgid(&init_user_ns, attr->ia_gid));
> +				from_kgid(&init_user_ns, fsgid));
>   			mask |= CEPH_SETATTR_GID;
>   			release |= CEPH_CAP_AUTH_SHARED;
>   		}
> @@ -2241,7 +2245,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	if (ceph_inode_is_shutdown(inode))
>   		return -ESTALE;
>   
> -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> +	err = setattr_prepare(idmap, dentry, attr);
>   	if (err != 0)
>   		return err;
>   
> @@ -2256,7 +2260,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	err = __ceph_setattr(idmap, inode, attr);
>   
>   	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
> -		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
> +		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
>   
>   	return err;
>   }

You should also do 'req->r_mnt_idmap = idmap;' for sync setattr request.

the setattr will just cache the change locally in client side if the 'x' 
caps are issued and returns directly or will set a sync setattr reqeust.

Thanks

- Xiubo

