Return-Path: <linux-fsdevel+bounces-13299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047486E4DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41FD284D97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41F70027;
	Fri,  1 Mar 2024 15:59:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3D70044;
	Fri,  1 Mar 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308799; cv=none; b=pw067gSUKma0wrBzPHtb4MkklevLVHpzd/eUPM7bIM+9T/IbsWIgMYrnYbfQyl21tiSXvoGNKY4+qXT9OHAfTSyFltG8iDrWFjjVFHbtoE1YIi08z5ERQz693CobfSOT8Z8akxuISJoLGGyRHn8e/111l50bP5AxFaK2IH5Ngnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308799; c=relaxed/simple;
	bh=kDTvRc/rJJuZ/ZVMznCa0bNE9fhdVJ07LePSL3ijCaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQNjjRmEACJuZcSTbj3vxSEotkGBW4gC8JRhtjceWx2ET5IYyQpQdWry13gT/wi5u+zyGnESrU2O+D5+uHI/VdjhTf9S+ZAyEKQmyHGd3+BuDdfCYbX2EwoOPe6ILZz23dZ4ZJOtRj4immUaHt5qmNkTHPHulOCV4nZQlomFOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TmXND29r2z9xGXC;
	Fri,  1 Mar 2024 23:40:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 610721405A2;
	Fri,  1 Mar 2024 23:59:37 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBChY++Fl5Qt8Aw--.52748S2;
	Fri, 01 Mar 2024 16:59:36 +0100 (CET)
Message-ID: <c5b496e53dac2b4b5402cc5aa9a09178d63323b7.camel@huaweicloud.com>
Subject: Re: [PATCH v2 11/25] security: add hooks for set/get/remove of
 fscaps
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Paul Moore
 <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, James Morris
 <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej
 Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi
 <miklos@szeredi.hu>,  Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Date: Fri, 01 Mar 2024 16:59:16 +0100
In-Reply-To: <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXBChY++Fl5Qt8Aw--.52748S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1fWw1DtF1DKF4xGw45Wrg_yoWxXFWfpF
	4rt3ZxGw4SqFyagr18tF45u39a9FyfC3y7ArW2gwnIyFnrtr15KFsa9FyUCryfCrWUGr90
	qFnIyrs8Cw13JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5biNgABs9

On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> In preparation for moving fscaps out of the xattr code paths, add new
> security hooks. These hooks are largely needed because common kernel
> code will pass around struct vfs_caps pointers, which EVM will need to
> convert to raw xattr data for verification and updates of its hashes.
>=20
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  7 +++++
>  include/linux/security.h      | 33 +++++++++++++++++++++
>  security/security.c           | 69 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 109 insertions(+)
>=20
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 76458b6d53da..7b3c23f9e4a5 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -152,6 +152,13 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *id=
map,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
> +LSM_HOOK(int, 0, inode_set_fscaps, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_fscaps, struct mnt_idmap *id=
map,
> +	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
> +LSM_HOOK(int, 0, inode_get_fscaps, struct mnt_idmap *idmap, struct dentr=
y *dentry);
> +LSM_HOOK(int, 0, inode_remove_fscaps, struct mnt_idmap *idmap,
> +	 struct dentry *dentry);

Uhm, there should not be semicolons here.

Roberto

>  LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
>  	 struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..40be548e5e12 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -378,6 +378,13 @@ int security_inode_getxattr(struct dentry *dentry, c=
onst char *name);
>  int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
> +int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry,
> +			      const struct vfs_caps *caps, int flags);
> +void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
> +				    struct dentry *dentry,
> +				    const struct vfs_caps *caps, int flags);
> +int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry);
> +int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry =
*dentry);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dent=
ry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -935,6 +942,32 @@ static inline int security_inode_removexattr(struct =
mnt_idmap *idmap,
>  	return cap_inode_removexattr(idmap, dentry, name);
>  }
> =20
> +static inline int security_inode_set_fscaps(struct mnt_idmap *idmap,
> +					    struct dentry *dentry,
> +					    const struct vfs_caps *caps,
> +					    int flags)
> +{
> +	return 0;
> +}
> +static void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
> +					   struct dentry *dentry,
> +					   const struct vfs_caps *caps,
> +					   int flags)
> +{
> +}
> +
> +static int security_inode_get_fscaps(struct mnt_idmap *idmap,
> +				     struct dentry *dentry)
> +{
> +	return 0;
> +}
> +
> +static int security_inode_remove_fscaps(struct mnt_idmap *idmap,
> +					struct dentry *dentry)
> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 3aaad75c9ce8..0d210da9862c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2351,6 +2351,75 @@ int security_inode_remove_acl(struct mnt_idmap *id=
map,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
> =20
> +/**
> + * security_inode_set_fscaps() - Check if setting fscaps is allowed
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @caps: fscaps to be written
> + * @flags: flags for setxattr
> + *
> + * Check permission before setting the file capabilities given in @vfs_c=
aps.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry,
> +			      const struct vfs_caps *caps, int flags)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return 0;
> +	return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
> +}
> +
> +/**
> + * security_inode_post_set_fscaps() - Update the inode after setting fsc=
aps
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @caps: fscaps to be written
> + * @flags: flags for setxattr
> + *
> + * Update inode security field after successfully setting fscaps.
> + *
> + */
> +void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
> +				    struct dentry *dentry,
> +				    const struct vfs_caps *caps, int flags)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, flags);
> +}
> +
> +/**
> + * security_inode_get_fscaps() - Check if reading fscaps is allowed
> + * @dentry: file
> + *
> + * Check permission before getting fscaps.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return 0;
> +	return call_int_hook(inode_get_fscaps, 0, idmap, dentry);
> +}
> +
> +/**
> + * security_inode_remove_fscaps() - Check if removing fscaps is allowed
> + * @idmap: idmap of the mount
> + * @dentry: file
> + *
> + * Check permission before removing fscaps.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry =
*dentry)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return 0;
> +	return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr op=
eration
>   * @dentry: file
>=20


