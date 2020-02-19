Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A981646E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBSO01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:26:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21918 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727833AbgBSO00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582122384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9fjE6rsOAwyQiq4pfi6EDuCXzrrOq14lwt7tMumFugU=;
        b=HhPBSN7cnVJ6DTOE0j/wGKdy+b7uRaNz4KRrXyQzrOKJvL/pG4BD0/L0jM+hzAdyMksYo0
        pHOpU2uQUwu2hqlBM99dM4EzEGcvsvV0ynOTcd9ICFbsb8hibVdkTAER1bUT7pbFUvHKwE
        sCiYj922SQcciPdDm/Q5BrympSNKdXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-XEpGKbVwMquyi4AJm3yr1A-1; Wed, 19 Feb 2020 09:26:21 -0500
X-MC-Unique: XEpGKbVwMquyi4AJm3yr1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 013C28010CA;
        Wed, 19 Feb 2020 14:26:20 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5230A89F01;
        Wed, 19 Feb 2020 14:26:19 +0000 (UTC)
Date:   Wed, 19 Feb 2020 09:26:17 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: remove the kuid/kgid conversion wrappers
Message-ID: <20200219142617.GD24157@bfoster>
References: <20200218210020.40846-1-hch@lst.de>
 <20200218210020.40846-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210020.40846-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:00:20PM -0800, Christoph Hellwig wrote:
> Remove the XFS wrappers for converting from and to the kuid/kgid types.
> Mostly this means switching to VFS i_{u,g}id_{read,write} helpers, but
> in a few spots the calls to the conversion functions is open coded.
> To match the use of sb->s_user_ns in the helpers and other file systems,
> sb->s_user_ns is also used in the quota code.  The ACL code already does
> the conversion in a grotty layering violation in the VFS xattr code,
> so it keeps using init_user_ns for the identity mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/libxfs/xfs_inode_buf.c |  8 ++++----
>  fs/xfs/xfs_acl.c              | 12 ++++++++----
>  fs/xfs/xfs_dquot.c            |  4 ++--
>  fs/xfs/xfs_inode_item.c       |  4 ++--
>  fs/xfs/xfs_itable.c           |  4 ++--
>  fs/xfs/xfs_linux.h            | 26 --------------------------
>  fs/xfs/xfs_qm.c               | 23 +++++++++--------------
>  7 files changed, 27 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index bc72b575ceed..17e88a8c8353 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -222,8 +222,8 @@ xfs_inode_from_disk(
>  	}
>  
>  	to->di_format = from->di_format;
> -	inode->i_uid = xfs_uid_to_kuid(be32_to_cpu(from->di_uid));
> -	inode->i_gid = xfs_gid_to_kgid(be32_to_cpu(from->di_gid));
> +	i_uid_write(inode, be32_to_cpu(from->di_uid));
> +	i_gid_write(inode, be32_to_cpu(from->di_gid));
>  	to->di_flushiter = be16_to_cpu(from->di_flushiter);
>  
>  	/*
> @@ -276,8 +276,8 @@ xfs_inode_to_disk(
>  
>  	to->di_version = from->di_version;
>  	to->di_format = from->di_format;
> -	to->di_uid = cpu_to_be32(xfs_kuid_to_uid(inode->i_uid));
> -	to->di_gid = cpu_to_be32(xfs_kgid_to_gid(inode->i_gid));
> +	to->di_uid = cpu_to_be32(i_uid_read(inode));
> +	to->di_gid = cpu_to_be32(i_gid_read(inode));
>  	to->di_projid_lo = cpu_to_be16(from->di_projid & 0xffff);
>  	to->di_projid_hi = cpu_to_be16(from->di_projid >> 16);
>  
> diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> index cd743fad8478..e7314b525b19 100644
> --- a/fs/xfs/xfs_acl.c
> +++ b/fs/xfs/xfs_acl.c
> @@ -67,10 +67,12 @@ xfs_acl_from_disk(
>  
>  		switch (acl_e->e_tag) {
>  		case ACL_USER:
> -			acl_e->e_uid = xfs_uid_to_kuid(be32_to_cpu(ace->ae_id));
> +			acl_e->e_uid = make_kuid(&init_user_ns,
> +						 be32_to_cpu(ace->ae_id));
>  			break;
>  		case ACL_GROUP:
> -			acl_e->e_gid = xfs_gid_to_kgid(be32_to_cpu(ace->ae_id));
> +			acl_e->e_gid = make_kgid(&init_user_ns,
> +						 be32_to_cpu(ace->ae_id));
>  			break;
>  		case ACL_USER_OBJ:
>  		case ACL_GROUP_OBJ:
> @@ -103,10 +105,12 @@ xfs_acl_to_disk(struct xfs_acl *aclp, const struct posix_acl *acl)
>  		ace->ae_tag = cpu_to_be32(acl_e->e_tag);
>  		switch (acl_e->e_tag) {
>  		case ACL_USER:
> -			ace->ae_id = cpu_to_be32(xfs_kuid_to_uid(acl_e->e_uid));
> +			ace->ae_id = cpu_to_be32(
> +					from_kuid(&init_user_ns, acl_e->e_uid));
>  			break;
>  		case ACL_GROUP:
> -			ace->ae_id = cpu_to_be32(xfs_kgid_to_gid(acl_e->e_gid));
> +			ace->ae_id = cpu_to_be32(
> +					from_kgid(&init_user_ns, acl_e->e_gid));
>  			break;
>  		default:
>  			ace->ae_id = cpu_to_be32(ACL_UNDEFINED_ID);
> diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
> index 3579de9306c1..711376ca269f 100644
> --- a/fs/xfs/xfs_dquot.c
> +++ b/fs/xfs/xfs_dquot.c
> @@ -829,9 +829,9 @@ xfs_qm_id_for_quotatype(
>  {
>  	switch (type) {
>  	case XFS_DQ_USER:
> -		return xfs_kuid_to_uid(VFS_I(ip)->i_uid);
> +		return i_uid_read(VFS_I(ip));
>  	case XFS_DQ_GROUP:
> -		return xfs_kgid_to_gid(VFS_I(ip)->i_gid);
> +		return i_gid_read(VFS_I(ip));
>  	case XFS_DQ_PROJ:
>  		return ip->i_d.di_projid;
>  	}
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index 83d7914556ef..f021b55a0301 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -308,8 +308,8 @@ xfs_inode_to_log_dinode(
>  
>  	to->di_version = from->di_version;
>  	to->di_format = from->di_format;
> -	to->di_uid = xfs_kuid_to_uid(inode->i_uid);
> -	to->di_gid = xfs_kgid_to_gid(inode->i_gid);
> +	to->di_uid = i_uid_read(inode);
> +	to->di_gid = i_gid_read(inode);
>  	to->di_projid_lo = from->di_projid & 0xffff;
>  	to->di_projid_hi = from->di_projid >> 16;
>  
> diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
> index 497db4160283..d10660469884 100644
> --- a/fs/xfs/xfs_itable.c
> +++ b/fs/xfs/xfs_itable.c
> @@ -86,8 +86,8 @@ xfs_bulkstat_one_int(
>  	 */
>  	buf->bs_projectid = ip->i_d.di_projid;
>  	buf->bs_ino = ino;
> -	buf->bs_uid = xfs_kuid_to_uid(inode->i_uid);
> -	buf->bs_gid = xfs_kgid_to_gid(inode->i_gid);
> +	buf->bs_uid = i_uid_read(inode);
> +	buf->bs_gid = i_gid_read(inode);
>  	buf->bs_size = dic->di_size;
>  
>  	buf->bs_nlink = inode->i_nlink;
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 8738bb03f253..bc43cd98697b 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -163,32 +163,6 @@ struct xstats {
>  
>  extern struct xstats xfsstats;
>  
> -/* Kernel uid/gid conversion. These are used to convert to/from the on disk
> - * uid_t/gid_t types to the kuid_t/kgid_t types that the kernel uses internally.
> - * The conversion here is type only, the value will remain the same since we
> - * are converting to the init_user_ns. The uid is later mapped to a particular
> - * user namespace value when crossing the kernel/user boundary.
> - */
> -static inline uint32_t xfs_kuid_to_uid(kuid_t uid)
> -{
> -	return from_kuid(&init_user_ns, uid);
> -}
> -
> -static inline kuid_t xfs_uid_to_kuid(uint32_t uid)
> -{
> -	return make_kuid(&init_user_ns, uid);
> -}
> -
> -static inline uint32_t xfs_kgid_to_gid(kgid_t gid)
> -{
> -	return from_kgid(&init_user_ns, gid);
> -}
> -
> -static inline kgid_t xfs_gid_to_kgid(uint32_t gid)
> -{
> -	return make_kgid(&init_user_ns, gid);
> -}
> -
>  static inline dev_t xfs_to_linux_dev_t(xfs_dev_t dev)
>  {
>  	return MKDEV(sysv_major(dev) & 0x1ff, sysv_minor(dev));
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 54dda7d982c9..de1d2c606c14 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -326,8 +326,7 @@ xfs_qm_dqattach_locked(
>  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
>  
>  	if (XFS_IS_UQUOTA_ON(mp) && !ip->i_udquot) {
> -		error = xfs_qm_dqattach_one(ip,
> -				xfs_kuid_to_uid(VFS_I(ip)->i_uid),
> +		error = xfs_qm_dqattach_one(ip, i_uid_read(VFS_I(ip)),
>  				XFS_DQ_USER, doalloc, &ip->i_udquot);
>  		if (error)
>  			goto done;
> @@ -335,8 +334,7 @@ xfs_qm_dqattach_locked(
>  	}
>  
>  	if (XFS_IS_GQUOTA_ON(mp) && !ip->i_gdquot) {
> -		error = xfs_qm_dqattach_one(ip,
> -				xfs_kgid_to_gid(VFS_I(ip)->i_gid),
> +		error = xfs_qm_dqattach_one(ip, i_gid_read(VFS_I(ip)),
>  				XFS_DQ_GROUP, doalloc, &ip->i_gdquot);
>  		if (error)
>  			goto done;
> @@ -1625,6 +1623,7 @@ xfs_qm_vop_dqalloc(
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct inode		*inode = VFS_I(ip);
> +	struct user_namespace	*user_ns = inode->i_sb->s_user_ns;
>  	struct xfs_dquot	*uq = NULL;
>  	struct xfs_dquot	*gq = NULL;
>  	struct xfs_dquot	*pq = NULL;
> @@ -1664,7 +1663,7 @@ xfs_qm_vop_dqalloc(
>  			 * holding ilock.
>  			 */
>  			xfs_iunlock(ip, lockflags);
> -			error = xfs_qm_dqget(mp, xfs_kuid_to_uid(uid),
> +			error = xfs_qm_dqget(mp, from_kuid(user_ns, uid),
>  					XFS_DQ_USER, true, &uq);
>  			if (error) {
>  				ASSERT(error != -ENOENT);
> @@ -1688,7 +1687,7 @@ xfs_qm_vop_dqalloc(
>  	if ((flags & XFS_QMOPT_GQUOTA) && XFS_IS_GQUOTA_ON(mp)) {
>  		if (!gid_eq(inode->i_gid, gid)) {
>  			xfs_iunlock(ip, lockflags);
> -			error = xfs_qm_dqget(mp, xfs_kgid_to_gid(gid),
> +			error = xfs_qm_dqget(mp, from_kgid(user_ns, gid),
>  					XFS_DQ_GROUP, true, &gq);
>  			if (error) {
>  				ASSERT(error != -ENOENT);
> @@ -1815,8 +1814,7 @@ xfs_qm_vop_chown_reserve(
>  			XFS_QMOPT_RES_RTBLKS : XFS_QMOPT_RES_REGBLKS;
>  
>  	if (XFS_IS_UQUOTA_ON(mp) && udqp &&
> -	    xfs_kuid_to_uid(VFS_I(ip)->i_uid) !=
> -			be32_to_cpu(udqp->q_core.d_id)) {
> +	    i_uid_read(VFS_I(ip)) != be32_to_cpu(udqp->q_core.d_id)) {
>  		udq_delblks = udqp;
>  		/*
>  		 * If there are delayed allocation blocks, then we have to
> @@ -1829,8 +1827,7 @@ xfs_qm_vop_chown_reserve(
>  		}
>  	}
>  	if (XFS_IS_GQUOTA_ON(ip->i_mount) && gdqp &&
> -	    xfs_kgid_to_gid(VFS_I(ip)->i_gid) !=
> -			be32_to_cpu(gdqp->q_core.d_id)) {
> +	    i_gid_read(VFS_I(ip)) != be32_to_cpu(gdqp->q_core.d_id)) {
>  		gdq_delblks = gdqp;
>  		if (delblks) {
>  			ASSERT(ip->i_gdquot);
> @@ -1927,16 +1924,14 @@ xfs_qm_vop_create_dqattach(
>  
>  	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
>  		ASSERT(ip->i_udquot == NULL);
> -		ASSERT(xfs_kuid_to_uid(VFS_I(ip)->i_uid) ==
> -			be32_to_cpu(udqp->q_core.d_id));
> +		ASSERT(i_uid_read(VFS_I(ip)) == be32_to_cpu(udqp->q_core.d_id));
>  
>  		ip->i_udquot = xfs_qm_dqhold(udqp);
>  		xfs_trans_mod_dquot(tp, udqp, XFS_TRANS_DQ_ICOUNT, 1);
>  	}
>  	if (gdqp && XFS_IS_GQUOTA_ON(mp)) {
>  		ASSERT(ip->i_gdquot == NULL);
> -		ASSERT(xfs_kgid_to_gid(VFS_I(ip)->i_gid) ==
> -			be32_to_cpu(gdqp->q_core.d_id));
> +		ASSERT(i_gid_read(VFS_I(ip)) == be32_to_cpu(gdqp->q_core.d_id));
>  
>  		ip->i_gdquot = xfs_qm_dqhold(gdqp);
>  		xfs_trans_mod_dquot(tp, gdqp, XFS_TRANS_DQ_ICOUNT, 1);
> -- 
> 2.24.1
> 

