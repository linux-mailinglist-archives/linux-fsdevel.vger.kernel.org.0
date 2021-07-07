Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66F73BE7A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhGGMNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGMNF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:13:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 064BE61C98;
        Wed,  7 Jul 2021 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659825;
        bh=WF6lEoJ3VN5kC7RJfR15+77t/yX8VO1gAyVRIvu5iCc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W8nSKlt6jaal/ySaRs23fyIf/hqGBln5U1CG63d/OHz3czDJQLyGzmMxTDzREyz+s
         L7TsADj4JxofVWYcsxOFSoHiZ2uiw1iC45/5QXD4A0vU5ak8tPoArXDjKnKLbHnd6F
         7Wewg+YFf+bH6gEdvnQj/go2Zr7aOU8VKIhJq5stO6oK9bkGAKI2mwvDO95Y3j5Zw7
         HBptVi9Pkqj8xeMXsGyzNdjlP9aaoaWwZ7+155OR9/R1psswTeKqP8wabegEoQ7v6X
         mC6/j94jWr1xDrUVZREZ9Svq4+N//AjuRjgOvvc7tQ4TxFcSz9m3nC0ep+7ZhxLW5P
         pkA5/Dt5kSMbg==
Message-ID: <0851e6b29825cd428bdeab6275638e1a463b153e.camel@kernel.org>
Subject: Re: [RFC PATCH v7 08/24] ceph: add ability to set fscrypt_auth via
 setattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:10:23 -0400
In-Reply-To: <4bb32761-93b5-16fb-b8ab-36897d469a39@redhat.com>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-9-jlayton@kernel.org>
         <4bb32761-93b5-16fb-b8ab-36897d469a39@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 16:11 +0800, Xiubo Li wrote:
> On 6/25/21 9:58 PM, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/acl.c                |  4 ++--
> >   fs/ceph/inode.c              | 30 ++++++++++++++++++++++++++++--
> >   fs/ceph/mds_client.c         | 31 ++++++++++++++++++++++++++-----
> >   fs/ceph/mds_client.h         |  3 +++
> >   fs/ceph/super.h              |  7 ++++++-
> >   include/linux/ceph/ceph_fs.h | 21 +++++++++++++--------
> >   6 files changed, 78 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > index 529af59d9fd3..6e716f142022 100644
> > --- a/fs/ceph/acl.c
> > +++ b/fs/ceph/acl.c
> > @@ -136,7 +136,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >   		newattrs.ia_ctime = current_time(inode);
> >   		newattrs.ia_mode = new_mode;
> >   		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> > -		ret = __ceph_setattr(inode, &newattrs);
> > +		ret = __ceph_setattr(inode, &newattrs, NULL);
> >   		if (ret)
> >   			goto out_free;
> >   	}
> > @@ -147,7 +147,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >   			newattrs.ia_ctime = old_ctime;
> >   			newattrs.ia_mode = old_mode;
> >   			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> > -			__ceph_setattr(inode, &newattrs);
> > +			__ceph_setattr(inode, &newattrs, NULL);
> >   		}
> >   		goto out_free;
> >   	}
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index b620281ea65b..7821ba04eef3 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -2086,7 +2086,7 @@ static const struct inode_operations ceph_symlink_iops = {
> >   	.listxattr = ceph_listxattr,
> >   };
> >   
> > -int __ceph_setattr(struct inode *inode, struct iattr *attr)
> > +int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
> >   {
> >   	struct ceph_inode_info *ci = ceph_inode(inode);
> >   	unsigned int ia_valid = attr->ia_valid;
> > @@ -2127,6 +2127,32 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
> >   
> >   	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
> >   
> > +	if (cia && cia->fscrypt_auth) {
> > +		u32 len = offsetof(struct ceph_fscrypt_auth, cfa_blob) +
> > +			  le32_to_cpu(cia->fscrypt_auth->cfa_blob_len);
> > +
> > +		if (len > sizeof(*cia->fscrypt_auth))
> > +			return -EINVAL;
> > +
> 
> Possibly we can remove this check here since in the patch followed will 
> make sure the 'cia' is valid.
> 
> 

Good point. I'll plan to clean that up.

> 
> > +		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
> > +			ceph_vinop(inode), ci->fscrypt_auth_len, len);
> > +
> > +		/* It should never be re-set once set */
> > +		WARN_ON_ONCE(ci->fscrypt_auth);
> > +
> > +		if (issued & CEPH_CAP_AUTH_EXCL) {
> > +			dirtied |= CEPH_CAP_AUTH_EXCL;
> > +			kfree(ci->fscrypt_auth);
> > +			ci->fscrypt_auth = (u8 *)cia->fscrypt_auth;
> > +			ci->fscrypt_auth_len = len;
> > +		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0) {
> > +			req->r_fscrypt_auth = cia->fscrypt_auth;
> > +			mask |= CEPH_SETATTR_FSCRYPT_AUTH;
> > +			release |= CEPH_CAP_AUTH_SHARED;
> > +		}
> > +		cia->fscrypt_auth = NULL;
> > +	}
> > +
> >   	if (ia_valid & ATTR_UID) {
> >   		dout("setattr %p uid %d -> %d\n", inode,
> >   		     from_kuid(&init_user_ns, inode->i_uid),
> > @@ -2324,7 +2350,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >   	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
> >   		return -EDQUOT;
> >   
> > -	err = __ceph_setattr(inode, attr);
> > +	err = __ceph_setattr(inode, attr, NULL);
> >   
> >   	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
> >   		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 9c994effc51d..4aca8ce1c135 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2529,8 +2529,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
> >   	return r;
> >   }
> >   
> > -static void encode_timestamp_and_gids(void **p,
> > -				      const struct ceph_mds_request *req)
> > +static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
> >   {
> >   	struct ceph_timespec ts;
> >   	int i;
> > @@ -2543,6 +2542,21 @@ static void encode_timestamp_and_gids(void **p,
> >   	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
> >   		ceph_encode_64(p, from_kgid(&init_user_ns,
> >   					    req->r_cred->group_info->gid[i]));
> > +
> > +	/* v5: altname (TODO: skip for now) */
> > +	ceph_encode_32(p, 0);
> > +
> > +	/* v6: fscrypt_auth and fscrypt_file */
> > +	if (req->r_fscrypt_auth) {
> > +		u32 authlen = le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> > +
> > +		authlen += offsetof(struct ceph_fscrypt_auth, cfa_blob);
> 
> For the authlen calculating, maybe we could add one helper ? I found 
> there have some other places are also doing this.
> 
> 

Yes. I'll plan to do that.

> > +		ceph_encode_32(p, authlen);
> > +		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
> > +	} else {
> > +		ceph_encode_32(p, 0);
> > +	}
> > +	ceph_encode_32(p, 0); // fscrypt_file for now
> >   }
> >   
> >   /*
> > @@ -2591,6 +2605,13 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >   	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
> >   		sizeof(struct ceph_timespec);
> >   	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
> > +	len += sizeof(u32); // altname
> > +	len += sizeof(u32); // fscrypt_auth
> > +	if (req->r_fscrypt_auth) {
> > +		len += offsetof(struct ceph_fscrypt_auth, cfa_blob);
> > +		len += le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> > +	}
> > +	len += sizeof(u32); // fscrypt_file
> >   
> >   	/* calculate (max) length for cap releases */
> >   	len += sizeof(struct ceph_mds_request_release) *
> > @@ -2621,7 +2642,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >   	} else {
> >   		struct ceph_mds_request_head *new_head = msg->front.iov_base;
> >   
> > -		msg->hdr.version = cpu_to_le16(4);
> > +		msg->hdr.version = cpu_to_le16(6);
> >   		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
> >   		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
> >   		p = msg->front.iov_base + sizeof(*new_head);
> > @@ -2672,7 +2693,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >   
> >   	head->num_releases = cpu_to_le16(releases);
> >   
> > -	encode_timestamp_and_gids(&p, req);
> > +	encode_mclientrequest_tail(&p, req);
> >   
> >   	if (WARN_ON_ONCE(p > end)) {
> >   		ceph_msg_put(msg);
> > @@ -2781,7 +2802,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
> >   		rhead->num_releases = 0;
> >   
> >   		p = msg->front.iov_base + req->r_request_release_offset;
> > -		encode_timestamp_and_gids(&p, req);
> > +		encode_mclientrequest_tail(&p, req);
> >   
> >   		msg->front.iov_len = p - msg->front.iov_base;
> >   		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 0c3cc61fd038..800eed49c2fd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -278,6 +278,9 @@ struct ceph_mds_request {
> >   	struct mutex r_fill_mutex;
> >   
> >   	union ceph_mds_request_args r_args;
> > +
> > +	struct ceph_fscrypt_auth *r_fscrypt_auth;
> > +
> >   	int r_fmode;        /* file mode, if expecting cap */
> >   	const struct cred *r_cred;
> >   	int r_request_release_offset;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index e032737fe472..ad62cde30e0b 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -1035,7 +1035,12 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
> >   }
> >   extern int ceph_permission(struct user_namespace *mnt_userns,
> >   			   struct inode *inode, int mask);
> > -extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
> > +
> > +struct ceph_iattr {
> > +	struct ceph_fscrypt_auth	*fscrypt_auth;
> > +};
> > +
> > +extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
> >   extern int ceph_setattr(struct user_namespace *mnt_userns,
> >   			struct dentry *dentry, struct iattr *attr);
> >   extern int ceph_getattr(struct user_namespace *mnt_userns,
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> > index e41a811026f6..a45a82c7d432 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -355,14 +355,19 @@ enum {
> >   
> >   extern const char *ceph_mds_op_name(int op);
> >   
> > -
> > -#define CEPH_SETATTR_MODE   1
> > -#define CEPH_SETATTR_UID    2
> > -#define CEPH_SETATTR_GID    4
> > -#define CEPH_SETATTR_MTIME  8
> > -#define CEPH_SETATTR_ATIME 16
> > -#define CEPH_SETATTR_SIZE  32
> > -#define CEPH_SETATTR_CTIME 64
> > +#define CEPH_SETATTR_MODE              (1 << 0)
> > +#define CEPH_SETATTR_UID               (1 << 1)
> > +#define CEPH_SETATTR_GID               (1 << 2)
> > +#define CEPH_SETATTR_MTIME             (1 << 3)
> > +#define CEPH_SETATTR_ATIME             (1 << 4)
> > +#define CEPH_SETATTR_SIZE              (1 << 5)
> > +#define CEPH_SETATTR_CTIME             (1 << 6)
> > +#define CEPH_SETATTR_MTIME_NOW         (1 << 7)
> > +#define CEPH_SETATTR_ATIME_NOW         (1 << 8)
> > +#define CEPH_SETATTR_BTIME             (1 << 9)
> > +#define CEPH_SETATTR_KILL_SGUID        (1 << 10)
> > +#define CEPH_SETATTR_FSCRYPT_AUTH      (1 << 11)
> > +#define CEPH_SETATTR_FSCRYPT_FILE      (1 << 12)
> >   
> >   /*
> >    * Ceph setxattr request flags.
> 

-- 
Jeff Layton <jlayton@kernel.org>

