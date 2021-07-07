Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D233BE79D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhGGMMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhGGMMO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7F6761C42;
        Wed,  7 Jul 2021 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659774;
        bh=r+QB+JzSQGd3/A6qO98mAnZEocr9nWdFLTFb7HRGHLg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SclnhBMmHvZMJqF9px/Nb4Irr9Tr8akw/jwHcOslk1DX/pfZmbRpZhpy7wW+9OtJU
         X2QSqPlr54dmT5R2CF6GhAFBjpmxZKogDSnu6VmMFS9iY8wB6oISXLS9plPIV1rnGz
         XxpQJBJsYpO6Ts4WTJEx8NzvvwEUra6W74pYkjfs8z3t9qmMBp9QHcKcgffT44Rcfp
         syoiGsJ7YJMKlEDaBXra2HNA4fyVWS37KDjEKotnU4xdnNAvtgjN0tA5hUoD7UJI6L
         XQ+gGbBiTOFbIN46DMkNLiVWA0QxPGj6JyU5HvS4pG2kwCNBrc1h4/zL3WcqR5RQ6u
         ncOPQ7VEj7d5A==
Message-ID: <ca7405d2353adb1af1b9ff2555785ba01b6266f3.camel@kernel.org>
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:09:32 -0400
In-Reply-To: <fbf80709-e87a-9334-45d7-9cca5726b037@redhat.com>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-7-jlayton@kernel.org>
         <fbf80709-e87a-9334-45d7-9cca5726b037@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 11:53 +0800, Xiubo Li wrote:
> On 6/25/21 9:58 PM, Jeff Layton wrote:
> > ...and store them in the ceph_inode_info.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/file.c       |  2 ++
> >   fs/ceph/inode.c      | 18 ++++++++++++++++++
> >   fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >   fs/ceph/mds_client.h |  4 ++++
> >   fs/ceph/super.h      |  6 ++++++
> >   5 files changed, 74 insertions(+)
> > 
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 2cda398ba64d..ea0e85075b7b 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
> >   	iinfo.xattr_data = xattr_buf;
> >   	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
> >   
> > +	/* FIXME: set fscrypt_auth and fscrypt_file */
> > +
> >   	in.ino = cpu_to_le64(vino.ino);
> >   	in.snapid = cpu_to_le64(CEPH_NOSNAP);
> >   	in.version = cpu_to_le64(1);	// ???
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index f62785e4dbcb..b620281ea65b 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
> >   
> >   	ci->i_meta_err = 0;
> >   
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	ci->fscrypt_auth = NULL;
> > +	ci->fscrypt_auth_len = 0;
> > +	ci->fscrypt_file = NULL;
> > +	ci->fscrypt_file_len = 0;
> > +#endif
> > +
> >   	return &ci->vfs_inode;
> >   }
> >   
> > @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
> >   	struct ceph_inode_info *ci = ceph_inode(inode);
> >   
> >   	kfree(ci->i_symlink);
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	kfree(ci->fscrypt_auth);
> > +#endif
> >   	kmem_cache_free(ceph_inode_cachep, ci);
> >   }
> >   
> > @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> >   		xattr_blob = NULL;
> >   	}
> >   
> > +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> > +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> > +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> > +		iinfo->fscrypt_auth = NULL;
> > +		iinfo->fscrypt_auth_len = 0;
> > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > +	}
> > +
> >   	/* finally update i_version */
> >   	if (le64_to_cpu(info->version) > ci->i_version)
> >   		ci->i_version = le64_to_cpu(info->version);
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 3b3a14024ca0..9c994effc51d 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -183,8 +183,48 @@ static int parse_reply_info_in(void **p, void *end,
> >   			info->rsnaps = 0;
> >   		}
> >   
> > +		if (struct_v >= 5) {
> > +			u32 alen;
> > +
> > +			ceph_decode_32_safe(p, end, alen, bad);
> > +
> > +			while (alen--) {
> > +				u32 len;
> > +
> > +				/* key */
> > +				ceph_decode_32_safe(p, end, len, bad);
> > +				ceph_decode_skip_n(p, end, len, bad);
> > +				/* value */
> > +				ceph_decode_32_safe(p, end, len, bad);
> > +				ceph_decode_skip_n(p, end, len, bad);
> > +			}
> > +		}
> > +
> > +		/* fscrypt flag -- ignore */
> > +		if (struct_v >= 6)
> > +			ceph_decode_skip_8(p, end, bad);
> > +
> > +		if (struct_v >= 7) {
> > +			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
> > +			if (info->fscrypt_auth_len) {
> > +				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
> > +				if (!info->fscrypt_auth)
> > +					return -ENOMEM;
> > +				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
> > +						      info->fscrypt_auth_len, bad);
> > +			}
> > +			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
> > +			if (info->fscrypt_file_len) {
> > +				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
> > +				if (!info->fscrypt_file)
> > +					return -ENOMEM;
> 
> Should we kfree(info->fscrypt_auth) before return ?
> 
> I didn't anywhere is freeing it.
> 

It'll get freed in destroy_reply_info(). We could do it here, but it
should be fine to wait until we're tearing the "info" structure down.

> 
> 
> > +				ceph_decode_copy_safe(p, end, info->fscrypt_file,
> > +						      info->fscrypt_file_len, bad);
> > +			}
> > +		}
> >   		*p = end;
> >   	} else {
> > +		/* legacy (unversioned) struct */
> >   		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
> >   			ceph_decode_64_safe(p, end, info->inline_version, bad);
> >   			ceph_decode_32_safe(p, end, info->inline_len, bad);
> > @@ -625,6 +665,10 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
> >   
> >   static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
> >   {
> > +	kfree(info->diri.fscrypt_auth);
> > +	kfree(info->diri.fscrypt_file);
> > +	kfree(info->targeti.fscrypt_auth);
> > +	kfree(info->targeti.fscrypt_file);
> >   	if (!info->dir_entries)
> >   		return;
> >   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 64ea9d853b8d..0c3cc61fd038 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
> >   	s32 dir_pin;
> >   	struct ceph_timespec btime;
> >   	struct ceph_timespec snap_btime;
> > +	u8 *fscrypt_auth;
> > +	u8 *fscrypt_file;
> > +	u32 fscrypt_auth_len;
> > +	u32 fscrypt_file_len;
> >   	u64 rsnaps;
> >   	u64 change_attr;
> >   };
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 0cd94b296f5f..e032737fe472 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -429,6 +429,12 @@ struct ceph_inode_info {
> >   
> >   #ifdef CONFIG_CEPH_FSCACHE
> >   	struct fscache_cookie *fscache;
> > +#endif
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	u32 fscrypt_auth_len;
> > +	u32 fscrypt_file_len;
> > +	u8 *fscrypt_auth;
> > +	u8 *fscrypt_file;
> >   #endif
> >   	errseq_t i_meta_err;
> >   
> 

-- 
Jeff Layton <jlayton@kernel.org>

