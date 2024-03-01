Return-Path: <linux-fsdevel+bounces-13254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEAB86DE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2283EB259CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E956A8B1;
	Fri,  1 Mar 2024 09:19:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84296A333;
	Fri,  1 Mar 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284786; cv=none; b=L+56X2iSnVQabyAoRxwBTFyWQ/esYS5tQ35CNNzpcIFgEeJqj995BOwMuMcr/4J8fYV/T7kzySWPJkZhZYzExEfs+VrwbXM4YOw/xSppMN8vTRI9zq7NaDwlyujNRCh4TI2Gp2zRInO69vyFXI5HZWzU/fnnGNj697ojJc+z6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284786; c=relaxed/simple;
	bh=V2N7MGSgdyGPxrhJtiTatU21KOYhXXTnYWVquWX1ox4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ow7vgljQCxhMfP/ea2F3Vcq6QJI12CsGFzNUYhR5Sdcf+GgrLllzVvcEj+WIfFZh/XwiP7pCLqGgh3dyN5tM/s1u3wTSJv6PEW3E8gJqFcZHJwj8scluISOfRntH8OYDcGWNXOYEkjaoP4QifFuvCDR7y7SuJJWJtnw2Yxgp/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmMb237kbz9xvhF;
	Fri,  1 Mar 2024 17:03:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A9A4F140428;
	Fri,  1 Mar 2024 17:19:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHfheUneFlFot_Aw--.47301S2;
	Fri, 01 Mar 2024 10:19:33 +0100 (CET)
Message-ID: <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
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
Date: Fri, 01 Mar 2024 10:19:13 +0100
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
X-CM-TRANSID:LxC2BwCHfheUneFlFot_Aw--.47301S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr17Xw4UKFW3tFyUKw18uFg_yoWxXrWxpF
	W5Ja1Fkw1rJFy3WryFqF4UZa1S9F1fG3yUZa4xW34SyFnxJrWxtFyIkryjyr1fJr48GrnI
	qFs0vrn5Cw43t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUguHqUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5bb3QADst

On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> Support the new fscaps security hooks by converting the vfs_caps to raw
> xattr data and then handling them the same as other xattrs.

Hi Seth

I started looking at this patch set.

The first question I have is if you are also going to update libcap
(and also tar, I guess), since both deal with the raw xattr.

From IMA/EVM perspective (Mimi will add on that), I guess it is
important that files with a signature/HMAC continue to be accessible
after applying this patch set.

Looking at the code, it seems the case (if I understood correctly,
vfs_getxattr_alloc() is still allowed).

To be sure that everything works, it would be really nice if you could
also extend our test suite:

https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/portable=
_signatures.test

and

https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/evm_hmac=
.test


The first test we would need to extend is check_cp_preserve_xattrs,
which basically does a cp -a. We would need to set fscaps in the
origin, copy to the destination, and see if the latter is accessible.

I would also extend:

check_tar_extract_xattrs_different_owner
check_tar_extract_xattrs_same_owner
check_metadata_change
check_evm_revalidate
check_evm_portable_sig_ima_appraisal
check_evm_portable_sig_ima_measurement_list

It should not be too complicated. The purpose would be to exercise your
code below.


Regarding the second test, we would need to extend just check_evm_hmac.


Just realized, before extending the tests, it would be necessary to
modify also evmctl.c, to retrieve fscaps through the new interfaces,
and to let users provide custom fscaps the HMAC or portable signature
is calculated on.


You can run the tests locally (even with UML linux), or make a PR in
Github for both linux and ima-evm-utils, and me and Mimi will help to
run them. For Github, for now please use:

https://github.com/linux-integrity/linux
https://github.com/mimizohar/ima-evm-utils/

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


