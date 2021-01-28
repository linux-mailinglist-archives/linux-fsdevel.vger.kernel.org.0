Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69E3075D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhA1MVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 07:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:46068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhA1MVv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:21:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 408A5AC45;
        Thu, 28 Jan 2021 12:21:10 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 855d98e6;
        Thu, 28 Jan 2021 12:22:03 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 17/17] ceph: add fscrypt ioctls
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-18-jlayton@kernel.org>
Date:   Thu, 28 Jan 2021 12:22:02 +0000
In-Reply-To: <20210120182847.644850-18-jlayton@kernel.org> (Jeff Layton's
        message of "Wed, 20 Jan 2021 13:28:47 -0500")
Message-ID: <87y2gdi74l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> Most of the ioctls, we gate on the MDS feature support. The exception is
> the key removal and status functions that we still want to work if the
> MDS's were to (inexplicably) lose the feature.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/ioctl.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 6e061bf62ad4..832909f3eb1b 100644
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
> @@ -268,8 +269,29 @@ static long ceph_ioctl_syncio(struct file *file)
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
> +		struct ceph_mds_session *s = __ceph_lookup_mds_session(mdsc, i);
> +
> +		if (!s)
> +			continue;
> +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
> +			ret = 0;

And another one, I believe...?  We need this here:

		ceph_put_mds_session(s);

Also, isn't this logic broken?  Shouldn't we walk through all the sessions
and return 0 only if they all have that feature bit set?

Cheers,
-- 
Luis

> +		break;
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +	return ret;
> +}
> +
>  long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> +	int ret;
> +
>  	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
>  	switch (cmd) {
>  	case CEPH_IOC_GET_LAYOUT:
> @@ -289,6 +311,45 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	case CEPH_IOC_SYNCIO:
>  		return ceph_ioctl_syncio(file);
> +
> +	case FS_IOC_SET_ENCRYPTION_POLICY:
> +		ret = vet_mds_for_fscrypt(file);
> +		if (ret)
> +			return ret;
> +		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
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
> +		return fscrypt_ioctl_add_key(file, (void __user *)arg);
> +
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> +		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
> +
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
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
>
> 2.29.2
>
