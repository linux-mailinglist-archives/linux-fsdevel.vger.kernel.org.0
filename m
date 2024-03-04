Return-Path: <linux-fsdevel+bounces-13481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540168704B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E29B257AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310C46B8B;
	Mon,  4 Mar 2024 15:01:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0843FB02;
	Mon,  4 Mar 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564516; cv=none; b=hN6BQM1BRCEh2A/KxLOsYEcRyv/v+XbhhTHkF9a0V1m/1uoMN60lTV8PgEMPOwKaX6sehhcLnUbxj7wTPWIMRITtXaD/1O3aHR0fE0cs+26d34Cq1pN0tBmb1O6Xn15HiSxmaLaaYmjHB/XBnSn/BPyJUUFaEnk1LfNlxrOzoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564516; c=relaxed/simple;
	bh=qQLeHyzP/10SUVh0HKe6LCuS9vd0k0BXoiQvBK31dsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYHifAzRVSIQ1PKY7ccL/uvP6KTFkxPLgdsoks1UEG9Fe1SsGiCEk5g8lNXLfzZJC9Ah/uqha9R132NxyD739zm4SJM8H39w0woMiwzWQaNHNC3UhoPr5wgxWMDntBeqImj5H9gWxKpIGnQ8tpC478ajIJDYlLNtcFF6Jr59AyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TpM2Y1fS9z9v7H0;
	Mon,  4 Mar 2024 22:46:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 424BD140E86;
	Mon,  4 Mar 2024 23:01:43 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDn2hNG4uVlYQC0Aw--.59338S2;
	Mon, 04 Mar 2024 16:01:42 +0100 (CET)
Message-ID: <60bdae79a059fe8fd4eaff68ccae6eb2207591bf.camel@huaweicloud.com>
Subject: Re: [PATCH v2 14/25] evm: add support for fscaps security hooks
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
Date: Mon, 04 Mar 2024 16:01:22 +0100
In-Reply-To: <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDn2hNG4uVlYQC0Aw--.59338S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15GFy5XF4DGw1rtryxKrg_yoW7Gr43pF
	45J3Z5Cw45Jry3WryFqF4UZa4S9F1fW3yUZaySg34SyFnxKr4rtF1I9ryjyryfJrW8Grn0
	qF1Ygrn5Cw47t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj5bz5AABs7

On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> Support the new fscaps security hooks by converting the vfs_caps to raw
> xattr data and then handling them the same as other xattrs.

I realized that you need to register hooks for IMA too.

This should be the content to add in ima_appraise.c:

int ima_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
                         const struct vfs_caps *caps, int flags)
{
       if (evm_revalidate_status(XATTR_NAME_CAPS))
               ima_reset_appraise_flags(d_backing_inode(dentry), false);

       return 0;
}

int ima_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
{
       return ima_inode_set_fscaps(idmap, dentry, NULL, XATTR_REPLACE);
}

Thanks

Roberto

> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/evm.h               | 39 +++++++++++++++++++++++++
>  security/integrity/evm/evm_main.c | 60 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 99 insertions(+)
>=20
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 36ec884320d9..aeb9ff52ad22 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -57,6 +57,20 @@ static inline void evm_inode_post_set_acl(struct dentr=
y *dentry,
>  {
>  	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
>  }
> +extern int evm_inode_set_fscaps(struct mnt_idmap *idmap,
> +				struct dentry *dentry,
> +				const struct vfs_caps *caps, int flags);
> +static inline int evm_inode_remove_fscaps(struct dentry *dentry)
> +{
> +	return evm_inode_set_fscaps(&nop_mnt_idmap, dentry, NULL, XATTR_REPLACE=
);
> +}
> +extern void evm_inode_post_set_fscaps(struct mnt_idmap *idmap,
> +				      struct dentry *dentry,
> +				      const struct vfs_caps *caps, int flags);
> +static inline void evm_inode_post_remove_fscaps(struct dentry *dentry)
> +{
> +	return evm_inode_post_set_fscaps(&nop_mnt_idmap, dentry, NULL, 0);
> +}
> =20
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  			    const struct qstr *qstr, struct xattr *xattrs,
> @@ -164,6 +178,31 @@ static inline void evm_inode_post_set_acl(struct den=
try *dentry,
>  	return;
>  }
> =20
> +static inline int evm_inode_set_fscaps(struct mnt_idmap *idmap,
> +				       struct dentry *dentry,
> +				       const struct vfs_caps *caps, int flags)
> +{
> +	return 0;
> +}
> +
> +static inline int evm_inode_remove_fscaps(struct dentry *dentry)
> +{
> +	return 0;
> +}
> +
> +static inline void evm_inode_post_set_fscaps(struct mnt_idmap *idmap,
> +					     struct dentry *dentry,
> +					     const struct vfs_caps *caps,
> +					     int flags)
> +{
> +	return;
> +}
> +
> +static inline void evm_inode_post_remove_fscaps(struct dentry *dentry)
> +{
> +	return;
> +}
> +
>  static inline int evm_inode_init_security(struct inode *inode, struct in=
ode *dir,
>  					  const struct qstr *qstr,
>  					  struct xattr *xattrs,
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index cc7956d7878b..ecf4634a921a 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -805,6 +805,66 @@ void evm_inode_post_removexattr(struct dentry *dentr=
y, const char *xattr_name)
>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>  }
> =20
> +int evm_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			 const struct vfs_caps *caps, int flags)
> +{
> +	struct inode *inode =3D d_inode(dentry);
> +	struct vfs_ns_cap_data nscaps;
> +	const void *xattr_data =3D NULL;
> +	int size =3D 0;
> +
> +	/* Policy permits modification of the protected xattrs even though
> +	 * there's no HMAC key loaded
> +	 */
> +	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
> +		return 0;
> +
> +	if (caps) {
> +		size =3D vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
> +					 sizeof(nscaps));
> +		if (size < 0)
> +			return size;
> +		xattr_data =3D &nscaps;
> +	}
> +
> +	return evm_protect_xattr(idmap, dentry, XATTR_NAME_CAPS, xattr_data, si=
ze);
> +}
> +
> +void evm_inode_post_set_fscaps(struct mnt_idmap *idmap, struct dentry *d=
entry,
> +			       const struct vfs_caps *caps, int flags)
> +{
> +	struct inode *inode =3D d_inode(dentry);
> +	struct vfs_ns_cap_data nscaps;
> +	const void *xattr_data =3D NULL;
> +	int size =3D 0;
> +
> +	if (!evm_revalidate_status(XATTR_NAME_CAPS))
> +		return;
> +
> +	evm_reset_status(dentry->d_inode);
> +
> +	if (!(evm_initialized & EVM_INIT_HMAC))
> +		return;
> +
> +	if (is_unsupported_fs(dentry))
> +		return;
> +
> +	if (caps) {
> +		size =3D vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
> +					 sizeof(nscaps));
> +		/*
> +		 * The fscaps here should have been converted to an xattr by
> +		 * evm_inode_set_fscaps() already, so a failure to convert
> +		 * here is a bug.
> +		 */
> +		if (WARN_ON_ONCE(size < 0))
> +			return;
> +		xattr_data =3D &nscaps;
> +	}
> +
> +	evm_update_evmxattr(dentry, XATTR_NAME_CAPS, xattr_data, size);
> +}
> +
>  static int evm_attr_change(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr)
>  {
>=20


