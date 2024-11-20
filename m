Return-Path: <linux-fsdevel+bounces-35258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604E9D32E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 05:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB3EB22A00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 04:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E42156F3B;
	Wed, 20 Nov 2024 04:15:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374E40BE5;
	Wed, 20 Nov 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732076126; cv=none; b=CxfKxCyfCSfaksxcRQo5w6dk/UGqjwbPymWgf6wTXIRfNg8ut6Tjj03vBJ2C0Z1uxYAC/roX7wh/nd3it0pqE311yqrCdlufsHvaqya2QK7ULwdoaVHOsJuUSu1wZ8JfYUQjdruGLKZc5b71XVFTr9ioUWeWtJtCeFrwaS+TyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732076126; c=relaxed/simple;
	bh=qt2aGpe/ZKwPmKb1YE5dtUUieqz+F7tO6qvYmjfTNz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gSj2b77btsDOStBy+hPhr+vuDOx0eCq1LoNJnnxaJt0e/jeQV0wN2LEjPNOonIfYKF8mKbCrsIlZHUYJaKO3qY0A+GRIXm1lqnxa+u0/tpJYUy0txN2wLrvf4DZQtYHseA2v21cmmXB8Os7IUee8qTpH8wI7T4UuDqq4+mUCVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XtShN6wdFz1yp5c;
	Wed, 20 Nov 2024 12:15:32 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 16E0D1A0188;
	Wed, 20 Nov 2024 12:15:20 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 12:15:18 +0800
Message-ID: <f7cc4ce1-9c20-4a5b-8a66-69b1f00a7776@huawei.com>
Date: Wed, 20 Nov 2024 12:15:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vfs: support caching symlink lengths in inodes
To: Mateusz Guzik <mjguzik@gmail.com>, <brauner@kernel.org>
CC: <viro@zeniv.linux.org.uk>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <hughd@google.com>,
	<linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <linux-mm@kvack.org>
References: <20241119094555.660666-1-mjguzik@gmail.com>
 <20241119094555.660666-2-mjguzik@gmail.com>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20241119094555.660666-2-mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/11/19 17:45, Mateusz Guzik wrote:
> When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
> speed up when issuing readlink on /initrd.img on ext4.
> 
> Filesystems opt in by calling inode_set_cached_link() when creating an
> inode.
> 
> The size is stored in what used to be a 4-byte hole. If necessary the
> field can be made smaller and converted into a union with something not
> used with symlinks.
> 
> Churn-wise the current readlink_copy() helper is patched to accept the
> size instead of calculating it.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>   fs/namei.c                     | 34 +++++++++++++++++++---------------
>   fs/proc/namespaces.c           |  2 +-
>   include/linux/fs.h             | 12 ++++++++++--
>   security/apparmor/apparmorfs.c |  2 +-
>   4 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 9d30c7aa9aa6..e56c29a22d26 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5272,19 +5272,16 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
>   				getname(newname), 0);
>   }
>   
> -int readlink_copy(char __user *buffer, int buflen, const char *link)
> +int readlink_copy(char __user *buffer, int buflen, const char *link, int linklen)
>   {
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
>   }
>   
>   /**
> @@ -5304,6 +5301,9 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>   	const char *link;
>   	int res;
>   
> +	if (inode->i_opflags & IOP_CACHED_LINK)
> +		return readlink_copy(buffer, buflen, inode->i_link, inode->i_linklen);
> +
>   	if (unlikely(!(inode->i_opflags & IOP_DEFAULT_READLINK))) {
>   		if (unlikely(inode->i_op->readlink))
>   			return inode->i_op->readlink(dentry, buffer, buflen);
> @@ -5322,7 +5322,7 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>   		if (IS_ERR(link))
>   			return PTR_ERR(link);
>   	}
> -	res = readlink_copy(buffer, buflen, link);
> +	res = readlink_copy(buffer, buflen, link, strlen(link));
>   	do_delayed_call(&done);
>   	return res;
>   }
> @@ -5391,10 +5391,14 @@ EXPORT_SYMBOL(page_put_link);
>   
>   int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>   {
> +	const char *link;
> +	int res;
> +
>   	DEFINE_DELAYED_CALL(done);
> -	int res = readlink_copy(buffer, buflen,
> -				page_get_link(dentry, d_inode(dentry),
> -					      &done));
> +	link = page_get_link(dentry, d_inode(dentry), &done);
> +	res = PTR_ERR(link);
> +	if (!IS_ERR(link))
> +		res = readlink_copy(buffer, buflen, link, strlen(link));
>   	do_delayed_call(&done);
>   	return res;
>   }
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index 8e159fc78c0a..c610224faf10 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -83,7 +83,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
>   	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
>   		res = ns_get_name(name, sizeof(name), task, ns_ops);
>   		if (res >= 0)
> -			res = readlink_copy(buffer, buflen, name);
> +			res = readlink_copy(buffer, buflen, name, strlen(name));
>   	}
>   	put_task_struct(task);
>   	return res;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 972147da71f9..30e332fb399d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -626,6 +626,7 @@ is_uncached_acl(struct posix_acl *acl)
>   #define IOP_XATTR	0x0008
>   #define IOP_DEFAULT_READLINK	0x0010
>   #define IOP_MGTIME	0x0020
> +#define IOP_CACHED_LINK	0x0040
>   
>   /*
>    * Keep mostly read-only and often accessed (especially for
> @@ -686,7 +687,7 @@ struct inode {
>   
>   	/* Misc */
>   	u32			i_state;
> -	/* 32-bit hole */
> +	int			i_linklen;	/* for symlinks */
>   	struct rw_semaphore	i_rwsem;
>   
>   	unsigned long		dirtied_when;	/* jiffies of first dirtying */
> @@ -749,6 +750,13 @@ struct inode {
>   	void			*i_private; /* fs or device private pointer */
>   } __randomize_layout;
>   
> +static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
> +{
> +	inode->i_link = link;
> +	inode->i_linklen = linklen;
Just curious, is this linklen equal to inode size? if it is, why don't 
use it?
> +	inode->i_opflags |= IOP_CACHED_LINK;
> +}
> +
>   /*
>    * Get bit address from inode->i_state to use with wait_var_event()
>    * infrastructre.
> @@ -3351,7 +3359,7 @@ extern const struct file_operations generic_ro_fops;
>   
>   #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
>   
> -extern int readlink_copy(char __user *, int, const char *);
> +extern int readlink_copy(char __user *, int, const char *, int);
>   extern int page_readlink(struct dentry *, char __user *, int);
>   extern const char *page_get_link(struct dentry *, struct inode *,
>   				 struct delayed_call *);
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 01b923d97a44..60959cfba672 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2611,7 +2611,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
>   	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
>   		       d_inode(dentry)->i_ino);
>   	if (res > 0 && res < sizeof(name))
> -		res = readlink_copy(buffer, buflen, name);
> +		res = readlink_copy(buffer, buflen, name, strlen(name));
>   	else
>   		res = -ENOENT;
>   
-- 
Regards


