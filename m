Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866F679D64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 02:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfG3Ag1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 20:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfG3Ag0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:36:26 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C222070B;
        Tue, 30 Jul 2019 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564446985;
        bh=KhPYRx4m6xfAnJ1MITKt5VBEq7YANZou64QdZgQk6aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bll4copUxMRU+/VRQS/9arl3WDnXVMNOvbSTmFhpmI3Cllp0VLUr8RHjVBv0VXE9B
         R/6EIIZbPfGZPhlipbIliwTA1p6lvFf/NwjbpYs6sIlrRDvcXzF+4LGnM1oqVdoRpw
         9Q+hUCAHQeuyOfKHt7iVbV7NeILJisfQnJZej5Pc=
Date:   Mon, 29 Jul 2019 17:36:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 14/16] f2fs: wire up new fscrypt ioctls
Message-ID: <20190730003624.GA47389@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-15-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-15-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/26, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up the new ioctls for adding and removing fscrypt keys to/from the
> filesystem, and the new ioctl for retrieving v2 encryption policies.
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY also required making f2fs_drop_inode() call
> fscrypt_drop_inode().
> 
> For more details see Documentation/filesystems/fscrypt.rst and the
> fscrypt patches that added the implementation of these ioctls.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks,

> ---
>  fs/f2fs/file.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/super.c |  2 ++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f8d46df8fa9ee..d81dda290b829 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2184,6 +2184,40 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  	return err;
>  }
>  
> +static int f2fs_ioc_get_encryption_policy_ex(struct file *filp,
> +					     unsigned long arg)
> +{
> +	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;
> +
> +	return fscrypt_ioctl_get_policy_ex(filp, (void __user *)arg);
> +}
> +
> +static int f2fs_ioc_add_encryption_key(struct file *filp, unsigned long arg)
> +{
> +	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;
> +
> +	return fscrypt_ioctl_add_key(filp, (void __user *)arg);
> +}
> +
> +static int f2fs_ioc_remove_encryption_key(struct file *filp, unsigned long arg)
> +{
> +	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;
> +
> +	return fscrypt_ioctl_remove_key(filp, (const void __user *)arg);
> +}
> +
> +static int f2fs_ioc_get_encryption_key_status(struct file *filp,
> +					      unsigned long arg)
> +{
> +	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;
> +
> +	return fscrypt_ioctl_get_key_status(filp, (void __user *)arg);
> +}
> +
>  static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -3109,6 +3143,14 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_get_encryption_policy(filp, arg);
>  	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
>  		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
> +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> +		return f2fs_ioc_get_encryption_policy_ex(filp, arg);
> +	case FS_IOC_ADD_ENCRYPTION_KEY:
> +		return f2fs_ioc_add_encryption_key(filp, arg);
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> +		return f2fs_ioc_remove_encryption_key(filp, arg);
> +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
> +		return f2fs_ioc_get_encryption_key_status(filp, arg);
>  	case F2FS_IOC_GARBAGE_COLLECT:
>  		return f2fs_ioc_gc(filp, arg);
>  	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
> @@ -3236,6 +3278,10 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_SET_ENCRYPTION_POLICY:
>  	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
>  	case F2FS_IOC_GET_ENCRYPTION_POLICY:
> +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> +	case FS_IOC_ADD_ENCRYPTION_KEY:
> +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
> +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
>  	case F2FS_IOC_GARBAGE_COLLECT:
>  	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
>  	case F2FS_IOC_WRITE_CHECKPOINT:
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6de6cda440315..f5fae8d511a20 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -913,6 +913,8 @@ static int f2fs_drop_inode(struct inode *inode)
>  		return 0;
>  	}
>  	ret = generic_drop_inode(inode);
> +	if (!ret)
> +		ret = fscrypt_drop_inode(inode);
>  	trace_f2fs_drop_inode(inode, ret);
>  	return ret;
>  }
> -- 
> 2.22.0
