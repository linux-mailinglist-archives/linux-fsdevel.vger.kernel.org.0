Return-Path: <linux-fsdevel+bounces-35406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7B9D4A8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B811282EC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130391CD200;
	Thu, 21 Nov 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyZX4BaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2F5FEED;
	Thu, 21 Nov 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183978; cv=none; b=n3GTinA29inGk0ZuVmfzNO3unJa5fXiqw1ldrUicZ1egsBM+3CwzNMOEbG6YJOZCUnRSp0qFi9+bYFVjTc5dxuYBJ+oj4uXhvzmDvFCRFeEg/NXCFe/c/Z0tF63r9G5mGFjlA8cwzbsaDrqyUFQrUqlIvZT4mrV7k28bYmv1q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183978; c=relaxed/simple;
	bh=6eiFaJrYM90rvCLkLlof6VzZqT6tcdWrRcNLWTHa+aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Git/gvJhHdMWZk3EumWw4lJXuS3sr2MGG4V8JNkxKOshyBnWkOep9dNAerS2X8EcMkfuKMre65fBcioIiXDo8Ekvp2UOiNSp/elHbox3tt5Tj5kxiFPc6uhohM3wLFAnlulZT/rzZvGEEemsxGeL8QdtKHU5RsWdpl7vo92+b64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyZX4BaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83098C4CECC;
	Thu, 21 Nov 2024 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732183978;
	bh=6eiFaJrYM90rvCLkLlof6VzZqT6tcdWrRcNLWTHa+aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyZX4BaOE2H7wAKl0O4Zee18KkAzJdiHIfODYDQuNXKcfovxm323pwz+3QZPrBAmh
	 0JAhgsyCbo+vdhaoU2q9euo7AkaJO2nnm8I53iUHX6gLg75iXuHCm8UUsDjv6+H83L
	 t5m3215mGYygSkP8Z2delemLfw8jmry/2v2f4Odhm1TVRbP+UrUZHBhmtWbzF7PQjH
	 DmntSFVpYMD4YZ4jlF+nMxZbycIvFpQhYVwKdhsZyQ/+T1qQjzOtR16ymwkslVlHcX
	 4CHAWz651aJ0U7LZM+6E7/lwV0qag5NpOeeFudZtTQH7zTinK7rKsw/Ht5e+bgmaWy
	 FRnJkMICYv+GA==
Date: Thu, 21 Nov 2024 11:12:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] vfs: support caching symlink lengths in inodes
Message-ID: <20241121-seilschaft-zeitig-7c8c3431bd00@brauner>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241120112037.822078-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120112037.822078-2-mjguzik@gmail.com>

On Wed, Nov 20, 2024 at 12:20:34PM +0100, Mateusz Guzik wrote:
> When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
> speed up when issuing readlink on /initrd.img on ext4.
> 
> Filesystems opt in by calling inode_set_cached_link() when creating an
> inode.
> 
> The size is stored in a new union utilizing the same space as i_devices,
> thus avoiding growing the struct or taking up any more space.
> 
> Churn-wise the current readlink_copy() helper is patched to accept the
> size instead of calculating it.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c                     | 34 +++++++++++++++++++---------------
>  fs/proc/namespaces.c           |  2 +-
>  include/linux/fs.h             | 15 +++++++++++++--
>  security/apparmor/apparmorfs.c |  2 +-
>  4 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 9d30c7aa9aa6..e56c29a22d26 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5272,19 +5272,16 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
>  				getname(newname), 0);
>  }
>  
> -int readlink_copy(char __user *buffer, int buflen, const char *link)
> +int readlink_copy(char __user *buffer, int buflen, const char *link, int linklen)
>  {
> -	int len = PTR_ERR(link);
> -	if (IS_ERR(link))
> -		goto out;
> +	int copylen;
>  
> -	len = strlen(link);
> -	if (len > (unsigned) buflen)
> -		len = buflen;
> -	if (copy_to_user(buffer, link, len))
> -		len = -EFAULT;
> -out:
> -	return len;
> +	copylen = linklen;
> +	if (unlikely(copylen > (unsigned) buflen))
> +		copylen = buflen;
> +	if (copy_to_user(buffer, link, copylen))
> +		copylen = -EFAULT;
> +	return copylen;
>  }
>  
>  /**
> @@ -5304,6 +5301,9 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>  	const char *link;
>  	int res;
>  
> +	if (inode->i_opflags & IOP_CACHED_LINK)
> +		return readlink_copy(buffer, buflen, inode->i_link, inode->i_linklen);
> +
>  	if (unlikely(!(inode->i_opflags & IOP_DEFAULT_READLINK))) {
>  		if (unlikely(inode->i_op->readlink))
>  			return inode->i_op->readlink(dentry, buffer, buflen);
> @@ -5322,7 +5322,7 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>  		if (IS_ERR(link))
>  			return PTR_ERR(link);
>  	}
> -	res = readlink_copy(buffer, buflen, link);
> +	res = readlink_copy(buffer, buflen, link, strlen(link));
>  	do_delayed_call(&done);
>  	return res;
>  }
> @@ -5391,10 +5391,14 @@ EXPORT_SYMBOL(page_put_link);
>  
>  int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>  {
> +	const char *link;
> +	int res;
> +
>  	DEFINE_DELAYED_CALL(done);
> -	int res = readlink_copy(buffer, buflen,
> -				page_get_link(dentry, d_inode(dentry),
> -					      &done));
> +	link = page_get_link(dentry, d_inode(dentry), &done);
> +	res = PTR_ERR(link);
> +	if (!IS_ERR(link))
> +		res = readlink_copy(buffer, buflen, link, strlen(link));
>  	do_delayed_call(&done);
>  	return res;
>  }
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index 8e159fc78c0a..c610224faf10 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -83,7 +83,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
>  	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
>  		res = ns_get_name(name, sizeof(name), task, ns_ops);
>  		if (res >= 0)
> -			res = readlink_copy(buffer, buflen, name);
> +			res = readlink_copy(buffer, buflen, name, strlen(name));
>  	}
>  	put_task_struct(task);
>  	return res;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..2cc98de5af43 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -626,6 +626,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_XATTR	0x0008
>  #define IOP_DEFAULT_READLINK	0x0010
>  #define IOP_MGTIME	0x0020
> +#define IOP_CACHED_LINK	0x0040
>  
>  /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -723,7 +724,10 @@ struct inode {
>  	};
>  	struct file_lock_context	*i_flctx;
>  	struct address_space	i_data;
> -	struct list_head	i_devices;
> +	union {
> +		struct list_head	i_devices;
> +		int			i_linklen;
> +	};

I think that i_devices should be moved into the union as it's really
only used with i_cdev but it's not that easily done because list_head
needs to be initialized. I roughly envisioned something like:

union {
        struct {
                struct cdev             *i_cdev;
                struct list_head        i_devices;
        };
        struct {
                char                    *i_link;
                unsigned int            i_link_len;
        };
        struct pipe_inode_info          *i_pipe;
        unsigned                        i_dir_seq;
};

But it's not important enough imho.

