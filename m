Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A783C3BE7CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhGGM26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhGGM2S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8447961C7C;
        Wed,  7 Jul 2021 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625660734;
        bh=7AP6jPM8qXCe22EPXJ9lNdF3LgIDWMqarDdhnGsjWzI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G1oHOgdVRvJvC9SnIr8UwNiwKQrlRGN0OGgG6p9VDgjEHGTByB5c5aBTPIcnbo7G6
         NqBTr8JFYXLJdqCdNsoHNgB4nsVQmbCA+tC1kk4Xf3MC/DhwreVT9tzwZNnVW6bBdz
         hwhn6u33/WzJgV/UrdtzATb4M7uAbiDMy9Gz7YRQbDjgcGzopnqBuRmUUzNkIczPa+
         zqmpj4QwVEBKVtDQC89YaN5Xyfw9KvVoNSdoPr0A6yHYqTSmG6eJdljZMcOqvB649O
         kx5ocPNdIEd98Jlp8Kxse7QfRwonwb/7cuWr2D/+pAcOG6cfLW4+06TtqU1Kkp/jrh
         WFxOR4EGy6z+Q==
Message-ID: <57ae25b3561bd8e4a4bfb635c642fca7eefcd4ef.camel@kernel.org>
Subject: Re: [RFC PATCH v7 08/24] ceph: add ability to set fscrypt_auth via
 setattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:25:32 -0400
In-Reply-To: <YOWGW2CVR3CAEg/e@suse.de>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-9-jlayton@kernel.org> <YOWGW2CVR3CAEg/e@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 11:47 +0100, Luis Henriques wrote:
> On Fri, Jun 25, 2021 at 09:58:18AM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/acl.c                |  4 ++--
> >  fs/ceph/inode.c              | 30 ++++++++++++++++++++++++++++--
> >  fs/ceph/mds_client.c         | 31 ++++++++++++++++++++++++++-----
> >  fs/ceph/mds_client.h         |  3 +++
> >  fs/ceph/super.h              |  7 ++++++-
> >  include/linux/ceph/ceph_fs.h | 21 +++++++++++++--------
> >  6 files changed, 78 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > index 529af59d9fd3..6e716f142022 100644
> > --- a/fs/ceph/acl.c
> > +++ b/fs/ceph/acl.c
> > @@ -136,7 +136,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >  		newattrs.ia_ctime = current_time(inode);
> >  		newattrs.ia_mode = new_mode;
> >  		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> > -		ret = __ceph_setattr(inode, &newattrs);
> > +		ret = __ceph_setattr(inode, &newattrs, NULL);
> >  		if (ret)
> >  			goto out_free;
> >  	}
> > @@ -147,7 +147,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >  			newattrs.ia_ctime = old_ctime;
> >  			newattrs.ia_mode = old_mode;
> >  			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
> > -			__ceph_setattr(inode, &newattrs);
> > +			__ceph_setattr(inode, &newattrs, NULL);
> >  		}
> >  		goto out_free;
> >  	}
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index b620281ea65b..7821ba04eef3 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -2086,7 +2086,7 @@ static const struct inode_operations ceph_symlink_iops = {
> >  	.listxattr = ceph_listxattr,
> >  };
> >  
> > -int __ceph_setattr(struct inode *inode, struct iattr *attr)
> > +int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
> >  {
> >  	struct ceph_inode_info *ci = ceph_inode(inode);
> >  	unsigned int ia_valid = attr->ia_valid;
> > @@ -2127,6 +2127,32 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
> >  
> >  	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
> >  
> > +	if (cia && cia->fscrypt_auth) {
> > +		u32 len = offsetof(struct ceph_fscrypt_auth, cfa_blob) +
> > +			  le32_to_cpu(cia->fscrypt_auth->cfa_blob_len);
> > +
> > +		if (len > sizeof(*cia->fscrypt_auth))
> > +			return -EINVAL;
> 
> This error path needs to be handled differently.  We have 'req' and
> 'prealloc_cf' allocated and, more importantly, we're holding
> ci->i_ceph_lock.
> 

Good catch. I'll fix that.

> > +
> > +		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
> > +			ceph_vinop(inode), ci->fscrypt_auth_len, len);
> > +
> > +		/* It should never be re-set once set */
> > +		WARN_ON_ONCE(ci->fscrypt_auth);
> > +
> > +		if (issued & CEPH_CAP_AUTH_EXCL) {
> > +			dirtied |= CEPH_CAP_AUTH_EXCL;
> > +			kfree(ci->fscrypt_auth);
> 
> If the WARN_ON_ONCE above is correct, we shouldn't need this kfree.
> 

It's a bit odd here actually...

We have to allow this to be set via setattr, so what's the right thing
to do when someone tries to set fscrypt_auth on an inode that already
has it set?

In principle we should probably ignore it, but maybe we need to allow
admins a way to fix up inodes with a corrupted context? For now, I'm
planning to allow you to override it but throw the warning in this case.
It's not ideal though and we may want to change this before merging.

> 
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
> >  	if (ia_valid & ATTR_UID) {
> >  		dout("setattr %p uid %d -> %d\n", inode,
> >  		     from_kuid(&init_user_ns, inode->i_uid),
> > @@ -2324,7 +2350,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
> >  		return -EDQUOT;
> >  
> > -	err = __ceph_setattr(inode, attr);
> > +	err = __ceph_setattr(inode, attr, NULL);
> >  
> >  	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
> >  		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 9c994effc51d..4aca8ce1c135 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2529,8 +2529,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
> >  	return r;
> >  }
> >  
> > -static void encode_timestamp_and_gids(void **p,
> > -				      const struct ceph_mds_request *req)
> > +static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
> >  {
> >  	struct ceph_timespec ts;
> >  	int i;
> > @@ -2543,6 +2542,21 @@ static void encode_timestamp_and_gids(void **p,
> >  	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
> >  		ceph_encode_64(p, from_kgid(&init_user_ns,
> >  					    req->r_cred->group_info->gid[i]));
> > +
> > +	/* v5: altname (TODO: skip for now) */
> > +	ceph_encode_32(p, 0);
> > +
> > +	/* v6: fscrypt_auth and fscrypt_file */
> > +	if (req->r_fscrypt_auth) {
> > +		u32 authlen = le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> > +
> > +		authlen += offsetof(struct ceph_fscrypt_auth, cfa_blob);
> > +		ceph_encode_32(p, authlen);
> > +		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
> > +	} else {
> > +		ceph_encode_32(p, 0);
> > +	}
> > +	ceph_encode_32(p, 0); // fscrypt_file for now
> >  }
> >  
> >  /*
> > @@ -2591,6 +2605,13 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >  	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
> >  		sizeof(struct ceph_timespec);
> >  	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
> > +	len += sizeof(u32); // altname
> > +	len += sizeof(u32); // fscrypt_auth
> > +	if (req->r_fscrypt_auth) {
> > +		len += offsetof(struct ceph_fscrypt_auth, cfa_blob);
> > +		len += le32_to_cpu(req->r_fscrypt_auth->cfa_blob_len);
> > +	}
> > +	len += sizeof(u32); // fscrypt_file
> >  
> >  	/* calculate (max) length for cap releases */
> >  	len += sizeof(struct ceph_mds_request_release) *
> > @@ -2621,7 +2642,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >  	} else {
> >  		struct ceph_mds_request_head *new_head = msg->front.iov_base;
> >  
> > -		msg->hdr.version = cpu_to_le16(4);
> > +		msg->hdr.version = cpu_to_le16(6);
> >  		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
> >  		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
> >  		p = msg->front.iov_base + sizeof(*new_head);
> > @@ -2672,7 +2693,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
> >  
> >  	head->num_releases = cpu_to_le16(releases);
> >  
> > -	encode_timestamp_and_gids(&p, req);
> > +	encode_mclientrequest_tail(&p, req);
> >  
> >  	if (WARN_ON_ONCE(p > end)) {
> >  		ceph_msg_put(msg);
> > @@ -2781,7 +2802,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
> >  		rhead->num_releases = 0;
> >  
> >  		p = msg->front.iov_base + req->r_request_release_offset;
> > -		encode_timestamp_and_gids(&p, req);
> > +		encode_mclientrequest_tail(&p, req);
> >  
> >  		msg->front.iov_len = p - msg->front.iov_base;
> >  		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 0c3cc61fd038..800eed49c2fd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -278,6 +278,9 @@ struct ceph_mds_request {
> >  	struct mutex r_fill_mutex;
> >  
> >  	union ceph_mds_request_args r_args;
> > +
> > +	struct ceph_fscrypt_auth *r_fscrypt_auth;
> > +
> >  	int r_fmode;        /* file mode, if expecting cap */
> >  	const struct cred *r_cred;
> >  	int r_request_release_offset;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index e032737fe472..ad62cde30e0b 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -1035,7 +1035,12 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
> >  }
> >  extern int ceph_permission(struct user_namespace *mnt_userns,
> >  			   struct inode *inode, int mask);
> > -extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
> > +
> > +struct ceph_iattr {
> > +	struct ceph_fscrypt_auth	*fscrypt_auth;
> > +};
> > +
> > +extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
> >  extern int ceph_setattr(struct user_namespace *mnt_userns,
> >  			struct dentry *dentry, struct iattr *attr);
> >  extern int ceph_getattr(struct user_namespace *mnt_userns,
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> > index e41a811026f6..a45a82c7d432 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -355,14 +355,19 @@ enum {
> >  
> >  extern const char *ceph_mds_op_name(int op);
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
> >  /*
> >   * Ceph setxattr request flags.
> > -- 
> > 2.31.1
> > 

-- 
Jeff Layton <jlayton@kernel.org>

