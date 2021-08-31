Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002CB3FC20E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 07:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhHaFIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 01:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhHaFIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630386425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z53hHE4MJVaMmZ2WYtgkUWx43esfqOv+4RMCZIaA9+Q=;
        b=D4GjGDOLIgVE29VSc+JyG5887/MBGA1wdCPHOikYDuXW5PDDQ24yWWJ62T8bmKyE6CXcGv
        GNb2lu5G2odK4tgvnL8hNA0XbqSH6gD7fFdNWVROQ09zG9tlJVGPDgCdji0zBBxsH5A+s8
        spsiT6mSQitNy62YA3nWIW877DDIjDA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-leg1gMK3NrmM7gCg5B-BFA-1; Tue, 31 Aug 2021 01:07:04 -0400
X-MC-Unique: leg1gMK3NrmM7gCg5B-BFA-1
Received: by mail-pf1-f198.google.com with SMTP id q26-20020aa7961a000000b003ef3d207770so5228450pfg.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 22:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z53hHE4MJVaMmZ2WYtgkUWx43esfqOv+4RMCZIaA9+Q=;
        b=IiwZaJitBtdp4Dd06l4GZ32NKxSYvgWwZno+rtKBGzsl+7j83X+t4X5oDeF7HDefGC
         n+0I+FX3CLwonZthqB9p1rAcdiFZQUKZ8QOXQghUI4OtJ7NWVl7Rl2/jMULw2AZUAoRf
         JRX41Zm7+BVkNow9FTmOqicPM6CTvSECBm+TNI35vweCTiKNalXOp+Iw3/s6Mm/1lGm0
         SL01z+Yh9W7xB9iAPiUUxuuVeSGVexzwit/oG/Ib62uAuN+nnBsRrOceyfmHrVdb9oYY
         /WqR+Pplb5jYYQIrOhhae2ZxM7j/8Ods5XgoboG9kcWO+xZ7pJ8k8XxglmGPCdH0XmMl
         OZzQ==
X-Gm-Message-State: AOAM533fA6j2jowAE2vuH1xcjf7I7S+uDmxJtqoMzHVGp+rh+ApnNCvx
        OsRFNA4zx/uhqNZlwQcOodR3x3QZ7/F0JV8/+v8oyc5aJhlmE2Sx/bRggoMDUOBet8mw7BBK1hg
        pyOHeIVscykF+iA9if3Kc6b3qUA==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr3171218pjg.92.1630386422625;
        Mon, 30 Aug 2021 22:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDIUsPgoGYpDASEcQRBcW7EbfSDlk5lFJO6CUKY5lKTrrNbNww/z2uibmpNySO1j7ChYcfjg==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr3171185pjg.92.1630386422200;
        Mon, 30 Aug 2021 22:07:02 -0700 (PDT)
Received: from [10.72.12.157] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k20sm17266646pfu.133.2021.08.30.22.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 22:07:01 -0700 (PDT)
Subject: Re: [RFC PATCH v8 09/24] ceph: add ability to set fscrypt_auth via
 setattr
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, lhenriques@suse.de, khiremat@redhat.com,
        ebiggers@kernel.org
References: <20210826162014.73464-1-jlayton@kernel.org>
 <20210826162014.73464-10-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <27f6a038-94a6-ec58-c7a5-0fafc2c9d779@redhat.com>
Date:   Tue, 31 Aug 2021 13:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210826162014.73464-10-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/27/21 12:19 AM, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/acl.c                |  4 +--
>   fs/ceph/crypto.h             |  9 +++++-
>   fs/ceph/inode.c              | 33 ++++++++++++++++++++--
>   fs/ceph/mds_client.c         | 54 ++++++++++++++++++++++++++++++------
>   fs/ceph/mds_client.h         |  3 ++
>   fs/ceph/super.h              |  7 ++++-
>   include/linux/ceph/ceph_fs.h | 21 ++++++++------
>   7 files changed, 108 insertions(+), 23 deletions(-)
>
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 529af59d9fd3..6e716f142022 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -136,7 +136,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   		newattrs.ia_ctime = current_time(inode);
>   		newattrs.ia_mode = new_mode;
>   		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> -		ret = __ceph_setattr(inode, &newattrs);
> +		ret = __ceph_setattr(inode, &newattrs, NULL);
>   		if (ret)
>   			goto out_free;
>   	}
> @@ -147,7 +147,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   			newattrs.ia_ctime = old_ctime;
>   			newattrs.ia_mode = old_mode;
>   			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> -			__ceph_setattr(inode, &newattrs);
> +			__ceph_setattr(inode, &newattrs, NULL);
>   		}
>   		goto out_free;
>   	}
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 6c3831c57c8d..6dca674f79b8 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -14,8 +14,15 @@ struct ceph_fscrypt_auth {
>   	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
>   } __packed;
>   
> -#ifdef CONFIG_FS_ENCRYPTION
>   #define CEPH_FSCRYPT_AUTH_VERSION	1
> +static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
> +{
> +	u32 ctxsize = le32_to_cpu(fa->cfa_blob_len);
> +
> +	return offsetof(struct ceph_fscrypt_auth, cfa_blob) + ctxsize;
> +}
> +
> +#ifdef CONFIG_FS_ENCRYPTION
>   void ceph_fscrypt_set_ops(struct super_block *sb);
>   
>   #else /* CONFIG_FS_ENCRYPTION */
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index a541f5e9c5ed..ae800372e42d 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2083,7 +2083,7 @@ static const struct inode_operations ceph_symlink_iops = {
>   	.listxattr = ceph_listxattr,
>   };
>   
> -int __ceph_setattr(struct inode *inode, struct iattr *attr)
> +int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
>   {
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   	unsigned int ia_valid = attr->ia_valid;
> @@ -2124,6 +2124,34 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   
>   	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
>   
> +	if (cia && cia->fscrypt_auth) {
> +		u32 len = ceph_fscrypt_auth_len(cia->fscrypt_auth);
> +
> +		if (len > sizeof(*cia->fscrypt_auth)) {
> +			err = -EINVAL;
> +			spin_unlock(&ci->i_ceph_lock);
> +			goto out;
> +		}
> +
> +		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
> +			ceph_vinop(inode), ci->fscrypt_auth_len, len);
> +
> +		/* It should never be re-set once set */
> +		WARN_ON_ONCE(ci->fscrypt_auth);
> +

Maybe this should return -EEXIST if already set ?


> +		if (issued & CEPH_CAP_AUTH_EXCL) {
> +			dirtied |= CEPH_CAP_AUTH_EXCL;
> +			kfree(ci->fscrypt_auth);
> +			ci->fscrypt_auth = (u8 *)cia->fscrypt_auth;
> +			ci->fscrypt_auth_len = len;
> +		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0) {

For this, shouldn't we always set the req->r_fscrypt_auth even the 
"CEPH_CAP_AUTH_SHARED" cap is issued ?

Maybe this should be:

} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 || !ci->fscrypt_auth) {

??

> +			req->r_fscrypt_auth = cia->fscrypt_auth;
> +			mask |= CEPH_SETATTR_FSCRYPT_AUTH;
> +			release |= CEPH_CAP_AUTH_SHARED;
> +		}
> +		cia->fscrypt_auth = NULL;
> +	}
> +
>   	if (ia_valid & ATTR_UID) {
>   		dout("setattr %p uid %d -> %d\n", inode,
>   		     from_kuid(&init_user_ns, inode->i_uid),
> @@ -2284,6 +2312,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   		req->r_stamp = attr->ia_ctime;
>   		err = ceph_mdsc_do_request(mdsc, NULL, req);
>   	}
> +out:
>   	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
>   	     ceph_cap_string(dirtied), mask);
>   
> @@ -2321,7 +2350,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>   	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
>   		return -EDQUOT;
>   
> -	err = __ceph_setattr(inode, attr);
> +	err = __ceph_setattr(inode, attr, NULL);
>   
>   	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
>   		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 240b53d58dda..449b4e78366e 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -15,6 +15,7 @@
>   
>   #include "super.h"
>   #include "mds_client.h"
> +#include "crypto.h"
>   
>   #include <linux/ceph/ceph_features.h>
>   #include <linux/ceph/messenger.h>
> @@ -927,6 +928,7 @@ void ceph_mdsc_release_request(struct kref *kref)
>   	put_cred(req->r_cred);
>   	if (req->r_pagelist)
>   		ceph_pagelist_release(req->r_pagelist);
> +	kfree(req->r_fscrypt_auth);
>   	put_request_session(req);
>   	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
>   	WARN_ON_ONCE(!list_empty(&req->r_wait));
> @@ -2618,8 +2620,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
>   	return r;
>   }
>   
> -static void encode_timestamp_and_gids(void **p,
> -				      const struct ceph_mds_request *req)
> +static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
>   {
>   	struct ceph_timespec ts;
>   	int i;
> @@ -2632,6 +2633,20 @@ static void encode_timestamp_and_gids(void **p,
>   	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
>   		ceph_encode_64(p, from_kgid(&init_user_ns,
>   					    req->r_cred->group_info->gid[i]));
> +
> +	/* v5: altname (TODO: skip for now) */
> +	ceph_encode_32(p, 0);
> +
> +	/* v6: fscrypt_auth and fscrypt_file */
> +	if (req->r_fscrypt_auth) {
> +		u32 authlen = ceph_fscrypt_auth_len(req->r_fscrypt_auth);
> +
> +		ceph_encode_32(p, authlen);
> +		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
> +	} else {
> +		ceph_encode_32(p, 0);
> +	}
> +	ceph_encode_32(p, 0); // fscrypt_file for now
>   }
>   
>   /*
> @@ -2676,12 +2691,14 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   		goto out_free1;
>   	}
>   
> +	/* head */
>   	len = legacy ? sizeof(*head) : sizeof(struct ceph_mds_request_head);
> -	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
> -		sizeof(struct ceph_timespec);
> -	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
>   
> -	/* calculate (max) length for cap releases */
> +	/* filepaths */
> +	len += 2 * (1 + sizeof(u32) + sizeof(u64));
> +	len += pathlen1 + pathlen2;
> +
> +	/* cap releases */
>   	len += sizeof(struct ceph_mds_request_release) *
>   		(!!req->r_inode_drop + !!req->r_dentry_drop +
>   		 !!req->r_old_inode_drop + !!req->r_old_dentry_drop);
> @@ -2691,6 +2708,25 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	if (req->r_old_dentry_drop)
>   		len += pathlen2;
>   
> +	/* MClientRequest tail */
> +
> +	/* req->r_stamp */
> +	len += sizeof(struct ceph_timespec);
> +
> +	/* gid list */
> +	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
> +
> +	/* alternate name */
> +	len += sizeof(u32);	// TODO
> +
> +	/* fscrypt_auth */
> +	len += sizeof(u32); // fscrypt_auth
> +	if (req->r_fscrypt_auth)
> +		len += ceph_fscrypt_auth_len(req->r_fscrypt_auth);
> +
> +	/* fscrypt_file */
> +	len += sizeof(u32);
> +
>   	msg = ceph_msg_new2(CEPH_MSG_CLIENT_REQUEST, len, 1, GFP_NOFS, false);
>   	if (!msg) {
>   		msg = ERR_PTR(-ENOMEM);
> @@ -2710,7 +2746,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   	} else {
>   		struct ceph_mds_request_head *new_head = msg->front.iov_base;
>   
> -		msg->hdr.version = cpu_to_le16(4);
> +		msg->hdr.version = cpu_to_le16(6);
>   		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>   		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
>   		p = msg->front.iov_base + sizeof(*new_head);
> @@ -2761,7 +2797,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
>   
>   	head->num_releases = cpu_to_le16(releases);
>   
> -	encode_timestamp_and_gids(&p, req);
> +	encode_mclientrequest_tail(&p, req);
>   
>   	if (WARN_ONCE(p > end, "p=%p end=%p len=%d\n", p, end, len)) {
>   		ceph_msg_put(msg);
> @@ -2870,7 +2906,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
>   		rhead->num_releases = 0;
>   
>   		p = msg->front.iov_base + req->r_request_release_offset;
> -		encode_timestamp_and_gids(&p, req);
> +		encode_mclientrequest_tail(&p, req);
>   
>   		msg->front.iov_len = p - msg->front.iov_base;
>   		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 98a8710807d1..e7d2c8a1b9c1 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -278,6 +278,9 @@ struct ceph_mds_request {
>   	struct mutex r_fill_mutex;
>   
>   	union ceph_mds_request_args r_args;
> +
> +	struct ceph_fscrypt_auth *r_fscrypt_auth;
> +
>   	int r_fmode;        /* file mode, if expecting cap */
>   	const struct cred *r_cred;
>   	int r_request_release_offset;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6bb6f9f9d79a..bc74c0b19c4f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1040,7 +1040,12 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
>   }
>   extern int ceph_permission(struct user_namespace *mnt_userns,
>   			   struct inode *inode, int mask);
> -extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
> +
> +struct ceph_iattr {
> +	struct ceph_fscrypt_auth	*fscrypt_auth;
> +};
> +
> +extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
>   extern int ceph_setattr(struct user_namespace *mnt_userns,
>   			struct dentry *dentry, struct iattr *attr);
>   extern int ceph_getattr(struct user_namespace *mnt_userns,
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index bc2699feddbe..a7d801a6ac88 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -356,14 +356,19 @@ enum {
>   
>   extern const char *ceph_mds_op_name(int op);
>   
> -
> -#define CEPH_SETATTR_MODE   1
> -#define CEPH_SETATTR_UID    2
> -#define CEPH_SETATTR_GID    4
> -#define CEPH_SETATTR_MTIME  8
> -#define CEPH_SETATTR_ATIME 16
> -#define CEPH_SETATTR_SIZE  32
> -#define CEPH_SETATTR_CTIME 64
> +#define CEPH_SETATTR_MODE              (1 << 0)
> +#define CEPH_SETATTR_UID               (1 << 1)
> +#define CEPH_SETATTR_GID               (1 << 2)
> +#define CEPH_SETATTR_MTIME             (1 << 3)
> +#define CEPH_SETATTR_ATIME             (1 << 4)
> +#define CEPH_SETATTR_SIZE              (1 << 5)
> +#define CEPH_SETATTR_CTIME             (1 << 6)
> +#define CEPH_SETATTR_MTIME_NOW         (1 << 7)
> +#define CEPH_SETATTR_ATIME_NOW         (1 << 8)
> +#define CEPH_SETATTR_BTIME             (1 << 9)
> +#define CEPH_SETATTR_KILL_SGUID        (1 << 10)
> +#define CEPH_SETATTR_FSCRYPT_AUTH      (1 << 11)
> +#define CEPH_SETATTR_FSCRYPT_FILE      (1 << 12)
>   
>   /*
>    * Ceph setxattr request flags.

