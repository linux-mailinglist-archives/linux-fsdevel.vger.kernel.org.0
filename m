Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEE355824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhDFPhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:37:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237872AbhDFPhk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:37:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A66BAD7C;
        Tue,  6 Apr 2021 15:37:31 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id ebf918cd;
        Tue, 6 Apr 2021 15:38:54 +0000 (UTC)
Date:   Tue, 6 Apr 2021 16:38:54 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 19/19] ceph: add fscrypt ioctls
Message-ID: <YGyAjn5PcG9J/07/@suse.de>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210326173227.96363-20-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326173227.96363-20-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff!

On Fri, Mar 26, 2021 at 01:32:27PM -0400, Jeff Layton wrote:
> We gate most of the ioctls on MDS feature support. The exception is the
> key removal and status functions that we still want to work if the MDS's
> were to (inexplicably) lose the feature.
> 
> For the set_policy ioctl, we take Fcx caps to ensure that nothing can
> create files in the directory while the ioctl is running. That should
> be enough to ensure that the "empty_dir" check is reliable.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/ioctl.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 6e061bf62ad4..34b85bcfcfc7 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -6,6 +6,7 @@
>  #include "mds_client.h"
>  #include "ioctl.h"
>  #include <linux/ceph/striper.h>
> +#include <linux/fscrypt.h>
>  
>  /*
>   * ioctls
> @@ -268,8 +269,56 @@ static long ceph_ioctl_syncio(struct file *file)
>  	return 0;
>  }
>  
> +static int vet_mds_for_fscrypt(struct file *file)
> +{
> +	int i, ret = -EOPNOTSUPP;
> +	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
> +
> +	mutex_lock(&mdsc->mutex);
> +	for (i = 0; i < mdsc->max_sessions; i++) {
> +		struct ceph_mds_session *s = mdsc->sessions[i];
> +
> +		if (!s)
> +			continue;
> +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
> +			ret = 0;
> +		break;
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +	return ret;
> +}
> +
> +static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
> +{
> +	int ret, got = 0;
> +	struct page *page = NULL;
> +	struct inode *inode = file_inode(file);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +
> +	ret = vet_mds_for_fscrypt(file);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Ensure we hold these caps so that we _know_ that the rstats check
> +	 * in the empty_dir check is reliable.
> +	 */
> +	ret = ceph_get_caps(file, CEPH_CAP_FILE_SHARED, 0, -1, &got, &page);
> +	if (ret)
> +		return ret;
> +	if (page)
> +		put_page(page);
> +	ret = fscrypt_ioctl_set_policy(file, (const void __user *)arg);
> +	if (got)
> +		ceph_put_cap_refs(ci, got);
> +	return ret;
> +}
> +
>  long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> +	int ret;
> +	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
> +
>  	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
>  	switch (cmd) {
>  	case CEPH_IOC_GET_LAYOUT:
> @@ -289,6 +338,51 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	case CEPH_IOC_SYNCIO:
>  		return ceph_ioctl_syncio(file);
> +
> +	case FS_IOC_SET_ENCRYPTION_POLICY:
> +		return ceph_set_encryption_policy(file, arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_POLICY:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> +
> +	case FS_IOC_ADD_ENCRYPTION_KEY:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		atomic_inc(&ci->i_shared_gen);

I've spent a few hours already looking at the bug I reported before, and I
can't really understand this code.  What does it mean to increment
->i_shared_gen at this point?

The reason I'm asking is because it looks like the problem I'm seeing goes
away if I remove this code.  Here's what I'm doing/seeing:

# mount ...
# fscrypt unlock d

  -> 'd' dentry is eventually pruned at this point *if* ->i_shared_gen was
     incremented by the line above.

# cat d/f

  -> when ceph_fill_inode() is executed, 'd' isn't *not* set as encrypted
     because both ci->i_xattrs.version and info->xattr_version are both
     set to 0.

cat: d/f: No such file or directory

I'm not sure anymore if the issue is on the client or on the MDS side.
Before digging deeper, I wonder if this ring any bell. ;-)

Cheers,
--
Luís


> +		ceph_dir_clear_ordered(file_inode(file));
> +		ceph_dir_clear_complete(file_inode(file));
> +		return fscrypt_ioctl_add_key(file, (void __user *)arg);
> +
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> +		atomic_inc(&ci->i_shared_gen);
> +		ceph_dir_clear_ordered(file_inode(file));
> +		ceph_dir_clear_complete(file_inode(file));
> +		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
> +
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
> +		atomic_inc(&ci->i_shared_gen);
> +		ceph_dir_clear_ordered(file_inode(file));
> +		ceph_dir_clear_complete(file_inode(file));
> +		return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
> +		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_NONCE:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
>  	}
>  
>  	return -ENOTTY;
> -- 
> 2.30.2
> 
