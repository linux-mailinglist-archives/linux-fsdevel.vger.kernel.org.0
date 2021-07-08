Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4813BF8F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGHL3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhGHL2y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:28:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B803C6141E;
        Thu,  8 Jul 2021 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625743573;
        bh=xAx1YGMu4YepmaoVRDQ4NU8vgJe/tqaV87Kx3kL9RSU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TDzWm+rfaN0AF+41PeDd4P9lsPTkz8RMcnVajrc8LcMLs7tgDUoYAfkRID/QE7BtL
         Qw5xQ1zUha0+KxJ4dZ+Sdz4yei5VRJQdcurc5ns/2vqk6pI0c5nwymg8kMF7h430gX
         fAET0TWeN6i8g1zEYGyWay8CbUEOBtTI9xAXxs1+tBaq0Gy6AGF8wSJve9nUs4NzoH
         uqN40sKwnN/QKbdIk5GGuAsIqbrFYtm4SRWoDYYXkY0VR+L5Pq9ByNPEiDe5o0TuB3
         qh/a++n3dch65u/ABwU4nIcBULkONM7bqH54nhLOBzA4q4W/3ctAdEU8zqSHjk8MvK
         /27JPR6qUQkIw==
Message-ID: <63ed309073c0d57cdb1a02ea43c566fd3d4116b9.camel@kernel.org>
Subject: Re: [RFC PATCH v7 12/24] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 08 Jul 2021 07:26:11 -0400
In-Reply-To: <912b5949-ae85-f093-0f23-0650aad606fc@redhat.com>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-13-jlayton@kernel.org>
         <912b5949-ae85-f093-0f23-0650aad606fc@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-07-08 at 15:30 +0800, Xiubo Li wrote:
> On 6/25/21 9:58 PM, Jeff Layton wrote:
> > We gate most of the ioctls on MDS feature support. The exception is the
> > key removal and status functions that we still want to work if the MDS's
> > were to (inexplicably) lose the feature.
> > 
> > For the set_policy ioctl, we take Fcx caps to ensure that nothing can
> > create files in the directory while the ioctl is running. That should
> > be enough to ensure that the "empty_dir" check is reliable.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 83 insertions(+)
> > 
> > diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> > index 6e061bf62ad4..477ecc667aee 100644
> > --- a/fs/ceph/ioctl.c
> > +++ b/fs/ceph/ioctl.c
> > @@ -6,6 +6,7 @@
> >   #include "mds_client.h"
> >   #include "ioctl.h"
> >   #include <linux/ceph/striper.h>
> > +#include <linux/fscrypt.h>
> >   
> >   /*
> >    * ioctls
> > @@ -268,8 +269,54 @@ static long ceph_ioctl_syncio(struct file *file)
> >   	return 0;
> >   }
> >   
> > +static int vet_mds_for_fscrypt(struct file *file)
> > +{
> > +	int i, ret = -EOPNOTSUPP;
> > +	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
> > +
> > +	mutex_lock(&mdsc->mutex);
> > +	for (i = 0; i < mdsc->max_sessions; i++) {
> > +		struct ceph_mds_session *s = mdsc->sessions[i];
> > +
> > +		if (!s)
> > +			continue;
> > +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
> > +			ret = 0;
> > +		break;
> > +	}
> > +	mutex_unlock(&mdsc->mutex);
> > +	return ret;
> > +}
> > +
> > +static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
> > +{
> > +	int ret, got = 0;
> > +	struct inode *inode = file_inode(file);
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +	ret = vet_mds_for_fscrypt(file);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Ensure we hold these caps so that we _know_ that the rstats check
> > +	 * in the empty_dir check is reliable.
> > +	 */
> > +	ret = ceph_get_caps(file, CEPH_CAP_FILE_SHARED, 0, -1, &got);
> 
> In the commit comment said it will host the Fsx, but here it is only 
> trying to hold the Fs. Will the Fx really needed ?
> 

No. What we're interested in here is that the directory remains empty
while we're encrypting it. If we hold Fs caps, then no one else can
modify the directory, so this is enough to ensure that.

> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fscrypt_ioctl_set_policy(file, (const void __user *)arg);
> > +	if (got)
> > +		ceph_put_cap_refs(ci, got);
> > +
> > +	return ret;
> > +}
> > +
> >   long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >   {
> > +	int ret;
> > +
> >   	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
> >   	switch (cmd) {
> >   	case CEPH_IOC_GET_LAYOUT:
> > @@ -289,6 +336,42 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >   
> >   	case CEPH_IOC_SYNCIO:
> >   		return ceph_ioctl_syncio(file);
> > +
> > +	case FS_IOC_SET_ENCRYPTION_POLICY:
> > +		return ceph_set_encryption_policy(file, arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_POLICY:
> > +		ret = vet_mds_for_fscrypt(file);
> > +		if (ret)
> > +			return ret;
> > +		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> > +		ret = vet_mds_for_fscrypt(file);
> > +		if (ret)
> > +			return ret;
> > +		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> > +
> > +	case FS_IOC_ADD_ENCRYPTION_KEY:
> > +		ret = vet_mds_for_fscrypt(file);
> > +		if (ret)
> > +			return ret;
> > +		return fscrypt_ioctl_add_key(file, (void __user *)arg);
> > +
> > +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> > +		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
> > +
> > +	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
> > +		return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
> > +		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
> > +
> > +	case FS_IOC_GET_ENCRYPTION_NONCE:
> > +		ret = vet_mds_for_fscrypt(file);
> > +		if (ret)
> > +			return ret;
> > +		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> >   	}
> >   
> >   	return -ENOTTY;
> 

-- 
Jeff Layton <jlayton@kernel.org>

