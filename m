Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD49269AA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgIOApZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgIOApY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:45:24 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D89212CC;
        Tue, 15 Sep 2020 00:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600130724;
        bh=kyKKdRaTCV/s4X55muFdIcXA2/axV9JJXA4yvtPTozg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMT2tLvWrITnEVpp6UiX/kzuF1/bzz7clmENbrUQP/+NCJUDRn4EGm1WnR7Fo1WNk
         H7PYgdEYx0WL2TU9LPPZDIrpXtkPEutH63RS52wiVCAxaK1lA06IW65/GGyTqZ/ZKX
         BoAjMfhJCBLbm8MeIw5W6WSp7qUzaMaYiDHJwtOM=
Date:   Mon, 14 Sep 2020 17:45:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 06/16] ceph: add fscrypt ioctls
Message-ID: <20200915004522.GF899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-7-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:57PM -0400, Jeff Layton wrote:
> Boilerplate ioctls for controlling encryption.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/ioctl.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 6e061bf62ad4..381e44b2d60a 100644
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
> @@ -289,6 +290,30 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	case CEPH_IOC_SYNCIO:
>  		return ceph_ioctl_syncio(file);
> +
> +	case FS_IOC_SET_ENCRYPTION_POLICY:
> +		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_POLICY:
> +		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
> +
> +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> +		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> +
> +	case FS_IOC_ADD_ENCRYPTION_KEY:
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
> +		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);

Will you be implementing an encryption feature flag for ceph, similar to what
ext4 and f2fs have?  E.g., ext4 doesn't allow these ioctls unless the filesystem
was formatted with '-O encrypt' (or 'tune2fs -O encrypt' was run later).  There
would be various problems if we didn't do that; for example, old versions of
e2fsck would consider encrypted directories to be corrupted.

- Eric
