Return-Path: <linux-fsdevel+bounces-13301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02686E5A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553371F222F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE943522C;
	Fri,  1 Mar 2024 16:31:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B713C0C;
	Fri,  1 Mar 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310691; cv=none; b=HwhHrurFVGXXDKOjgvg24pLZrFX8oZg1spLFpfL7IK8gAySMHodqVWysF5IPg9Fed5VBqN1Y3mljigXOg1Npvs1R21/Dsfk5HO1/SMeIIspFh/xuM32tIQoXAop2WVfDWKkitU0pSK2HEQQUT11IcwKkgKrgF5l9dYfPxVn8ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310691; c=relaxed/simple;
	bh=nWJgQGGG70LERlt+zA44EH111JyeJQ52BUWBclarei0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soHpOREqmSD726CNcmV1C9v8R8r/Nl6izqMMKLCLMjUroiMtSDuN1ps7FOW4Sf5lgUssxo/GtYm2E9Tzd82RCPoYr74gOYcrGY3JqMTndj12BTOPi1tl9RXzXg3O/cWOpQOcSYbhq00qP5tVKwXXVDfdERXoP9E5D7Pb96AQeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmY9K4wPQz9ynTB;
	Sat,  2 Mar 2024 00:15:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 45C0D14059C;
	Sat,  2 Mar 2024 00:31:16 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHcyfDAuJl3mZ8Aw--.52713S2;
	Fri, 01 Mar 2024 17:31:15 +0100 (CET)
Message-ID: <7633ab5d5359116a602cdc8f85afd2561047960e.camel@huaweicloud.com>
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
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
Date: Fri, 01 Mar 2024 17:30:55 +0100
In-Reply-To: <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHcyfDAuJl3mZ8Aw--.52713S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGrW8ZFW8ArW8tw1DurW7urg_yoWktFykpF
	yfKr13KF4Iyryagr18Jw4jv34F9FyfAryxXry8C3sYy3Z5Kry2gr1Ik34rAryYkw4kGr18
	Xa1qkFZ0kF9xAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj5rjQwABsG

On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> To pass around vfs_caps instead of raw xattr data we will need to
> convert between the two representations near userspace and disk
> boundaries. We already convert xattrs from disks to vfs_caps, so move
> that code into a helper, and change get_vfs_caps_from_disk() to use the
> helper.
>=20
> When converting vfs_caps to xattrs we have different considerations
> depending on the destination of the xattr data. For xattrs which will be
> written to disk we need to reject the xattr if the rootid does not map
> into the filesystem's user namespace, whereas xattrs read by userspace
> may need to undergo a conversion from v3 to v2 format when the rootid
> does not map. So this helper is split into an internal and an external
> interface. The internal interface does not return an error if the rootid
> has no mapping in the target user namespace and will be used for
> conversions targeting userspace. The external interface returns
> EOVERFLOW if the rootid has no mapping and will be used for all other
> conversions.
>=20
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/capability.h |  10 ++
>  security/commoncap.c       | 228 +++++++++++++++++++++++++++++++++++----=
------
>  2 files changed, 187 insertions(+), 51 deletions(-)
>=20
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index eb46d346bbbc..a0893ac4664b 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -209,6 +209,16 @@ static inline bool checkpoint_restore_ns_capable(str=
uct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
> =20
> +/* helpers to convert between xattr and in-kernel representations */
> +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> +			struct user_namespace *src_userns,
> +			struct vfs_caps *vfs_caps,
> +			const void *data, size_t size);
> +ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +			  struct user_namespace *dest_userns,
> +			  const struct vfs_caps *vfs_caps,
> +			  void *data, size_t size);
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   const struct dentry *dentry,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index a0b5c9740759..7531c9634997 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -619,54 +619,41 @@ static inline int bprm_caps_from_vfs_caps(struct vf=
s_caps *caps,
>  }
> =20
>  /**
> - * get_vfs_caps_from_disk - retrieve vfs caps from disk
> + * vfs_caps_from_xattr - convert raw caps xattr data to vfs_caps
>   *
> - * @idmap:	idmap of the mount the inode was found from
> - * @dentry:	dentry from which @inode is retrieved
> - * @cpu_caps:	vfs capabilities
> + * @idmap:      idmap of the mount the inode was found from
> + * @src_userns: user namespace for ids in xattr data
> + * @vfs_caps:   destination buffer for vfs_caps data
> + * @data:       rax xattr caps data
> + * @size:       size of xattr data
>   *
> - * Extract the on-exec-apply capability sets for an executable file.
> + * Converts a raw security.capability xattr into the kernel-internal
> + * capabilities format.
>   *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then
> - * take care to map the inode according to @idmap before checking
> - * permissions. On non-idmapped mounts or if permission checking is to b=
e
> - * performed on the raw inode simply pass @nop_mnt_idmap.
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return 0; on error, return < 0.
>   */
> -int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> -			   const struct dentry *dentry,
> -			   struct vfs_caps *cpu_caps)
> +int vfs_caps_from_xattr(struct mnt_idmap *idmap,
> +			struct user_namespace *src_userns,
> +			struct vfs_caps *vfs_caps,
> +			const void *data, size_t size)
>  {
> -	struct inode *inode =3D d_backing_inode(dentry);
>  	__u32 magic_etc;
> -	int size;
> -	struct vfs_ns_cap_data data, *nscaps =3D &data;
> -	struct vfs_cap_data *caps =3D (struct vfs_cap_data *) &data;
> +	const struct vfs_ns_cap_data *ns_caps =3D data;
> +	struct vfs_cap_data *caps =3D (struct vfs_cap_data *)ns_caps;
>  	kuid_t rootkuid;
> -	vfsuid_t rootvfsuid;
> -	struct user_namespace *fs_ns;
> -
> -	memset(cpu_caps, 0, sizeof(struct vfs_caps));
> -
> -	if (!inode)
> -		return -ENODATA;
> =20
> -	fs_ns =3D inode->i_sb->s_user_ns;
> -	size =3D __vfs_getxattr((struct dentry *)dentry, inode,
> -			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> -	if (size =3D=3D -ENODATA || size =3D=3D -EOPNOTSUPP)
> -		/* no data, that's ok */
> -		return -ENODATA;
> -
> -	if (size < 0)
> -		return size;
> +	memset(vfs_caps, 0, sizeof(*vfs_caps));
> =20
>  	if (size < sizeof(magic_etc))
>  		return -EINVAL;
> =20
> -	cpu_caps->magic_etc =3D magic_etc =3D le32_to_cpu(caps->magic_etc);
> +	vfs_caps->magic_etc =3D magic_etc =3D le32_to_cpu(caps->magic_etc);
> =20
> -	rootkuid =3D make_kuid(fs_ns, 0);
> +	rootkuid =3D make_kuid(src_userns, 0);
>  	switch (magic_etc & VFS_CAP_REVISION_MASK) {
>  	case VFS_CAP_REVISION_1:
>  		if (size !=3D XATTR_CAPS_SZ_1)
> @@ -679,39 +666,178 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap=
,
>  	case VFS_CAP_REVISION_3:
>  		if (size !=3D XATTR_CAPS_SZ_3)
>  			return -EINVAL;
> -		rootkuid =3D make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
> +		rootkuid =3D make_kuid(src_userns, le32_to_cpu(ns_caps->rootid));
>  		break;
> =20
>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	rootvfsuid =3D make_vfsuid(idmap, fs_ns, rootkuid);
> -	if (!vfsuid_valid(rootvfsuid))
> -		return -ENODATA;
> +	vfs_caps->rootid =3D make_vfsuid(idmap, src_userns, rootkuid);
> +	if (!vfsuid_valid(vfs_caps->rootid))
> +		return -EOVERFLOW;
> =20
> -	/* Limit the caps to the mounter of the filesystem
> -	 * or the more limited uid specified in the xattr.
> +	vfs_caps->permitted.val =3D le32_to_cpu(caps->data[0].permitted);
> +	vfs_caps->inheritable.val =3D le32_to_cpu(caps->data[0].inheritable);
> +
> +	/*
> +	 * Rev1 had just a single 32-bit word, later expanded
> +	 * to a second one for the high bits
>  	 */
> -	if (!rootid_owns_currentns(rootvfsuid))
> -		return -ENODATA;
> +	if ((magic_etc & VFS_CAP_REVISION_MASK) !=3D VFS_CAP_REVISION_1) {
> +		vfs_caps->permitted.val +=3D (u64)le32_to_cpu(caps->data[1].permitted)=
 << 32;
> +		vfs_caps->inheritable.val +=3D (u64)le32_to_cpu(caps->data[1].inherita=
ble) << 32;
> +	}
> +
> +	vfs_caps->permitted.val &=3D CAP_VALID_MASK;
> +	vfs_caps->inheritable.val &=3D CAP_VALID_MASK;
> +
> +	return 0;
> +}
> +
> +/*
> + * Inner implementation of vfs_caps_to_xattr() which does not return an
> + * error if the rootid does not map into @dest_userns.
> + */
> +static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +				   struct user_namespace *dest_userns,
> +				   const struct vfs_caps *vfs_caps,
> +				   void *data, size_t size)
> +{
> +	struct vfs_ns_cap_data *ns_caps =3D data;
> +	struct vfs_cap_data *caps =3D (struct vfs_cap_data *)ns_caps;
> +	kuid_t rootkuid;
> +	uid_t rootid;
> +
> +	memset(ns_caps, 0, size);

size -> sizeof(*ns_caps) (or an equivalent change)

I was zeroing more (the size of the buffer passed to vfs_getxattr()).

Roberto

> +
> +	rootid =3D 0;
> +	switch (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) {
> +	case VFS_CAP_REVISION_1:
> +		if (size < XATTR_CAPS_SZ_1)
> +			return -EINVAL;
> +		size =3D XATTR_CAPS_SZ_1;
> +		break;
> +	case VFS_CAP_REVISION_2:
> +		if (size < XATTR_CAPS_SZ_2)
> +			return -EINVAL;
> +		size =3D XATTR_CAPS_SZ_2;
> +		break;
> +	case VFS_CAP_REVISION_3:
> +		if (size < XATTR_CAPS_SZ_3)
> +			return -EINVAL;
> +		size =3D XATTR_CAPS_SZ_3;
> +		rootkuid =3D from_vfsuid(idmap, dest_userns, vfs_caps->rootid);
> +		rootid =3D from_kuid(dest_userns, rootkuid);
> +		ns_caps->rootid =3D cpu_to_le32(rootid);
> +		break;
> =20
> -	cpu_caps->permitted.val =3D le32_to_cpu(caps->data[0].permitted);
> -	cpu_caps->inheritable.val =3D le32_to_cpu(caps->data[0].inheritable);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	caps->magic_etc =3D cpu_to_le32(vfs_caps->magic_etc);
> +
> +	caps->data[0].permitted =3D cpu_to_le32(lower_32_bits(vfs_caps->permitt=
ed.val));
> +	caps->data[0].inheritable =3D cpu_to_le32(lower_32_bits(vfs_caps->inher=
itable.val));
> =20
>  	/*
>  	 * Rev1 had just a single 32-bit word, later expanded
>  	 * to a second one for the high bits
>  	 */
> -	if ((magic_etc & VFS_CAP_REVISION_MASK) !=3D VFS_CAP_REVISION_1) {
> -		cpu_caps->permitted.val +=3D (u64)le32_to_cpu(caps->data[1].permitted)=
 << 32;
> -		cpu_caps->inheritable.val +=3D (u64)le32_to_cpu(caps->data[1].inherita=
ble) << 32;
> +	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) !=3D VFS_CAP_REVISION=
_1) {
> +		caps->data[1].permitted =3D
> +			cpu_to_le32(upper_32_bits(vfs_caps->permitted.val));
> +		caps->data[1].inheritable =3D
> +			cpu_to_le32(upper_32_bits(vfs_caps->inheritable.val));
>  	}
> =20
> -	cpu_caps->permitted.val &=3D CAP_VALID_MASK;
> -	cpu_caps->inheritable.val &=3D CAP_VALID_MASK;
> +	return size;
> +}
> +
> +
> +/**
> + * vfs_caps_to_xattr - convert vfs_caps to raw caps xattr data
> + *
> + * @idmap:       idmap of the mount the inode was found from
> + * @dest_userns: user namespace for ids in xattr data
> + * @vfs_caps:    source vfs_caps data
> + * @data:        destination buffer for rax xattr caps data
> + * @size:        size of the @data buffer
> + *
> + * Converts a kernel-internal capability into the raw security.capabilit=
y
> + * xattr format.
> + *
> + * If the xattr is being read or written through an idmapped mount the
> + * idmap of the vfsmount must be passed through @idmap. This function
> + * will then take care to map the rootid according to @idmap.
> + *
> + * Return: On success, return the size of the xattr data. On error,
> + * return < 0.
> + */
> +ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
> +			  struct user_namespace *dest_userns,
> +			  const struct vfs_caps *vfs_caps,
> +			  void *data, size_t size)
> +{
> +	struct vfs_ns_cap_data *caps =3D data;
> +	int ret;
> +
> +	ret =3D __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
> +	if (ret > 0 &&
> +	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) =3D=3D VFS_CAP_REVISI=
ON_3 &&
> +	     le32_to_cpu(caps->rootid) =3D=3D (uid_t)-1)
> +		return -EOVERFLOW;
> +	return ret;
> +}
> +
> +/**
> + * get_vfs_caps_from_disk - retrieve vfs caps from disk
> + *
> + * @idmap:	idmap of the mount the inode was found from
> + * @dentry:	dentry from which @inode is retrieved
> + * @cpu_caps:	vfs capabilities
> + *
> + * Extract the on-exec-apply capability sets for an executable file.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then
> + * take care to map the inode according to @idmap before checking
> + * permissions. On non-idmapped mounts or if permission checking is to b=
e
> + * performed on the raw inode simply pass @nop_mnt_idmap.
> + */
> +int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
> +			   const struct dentry *dentry,
> +			   struct vfs_caps *cpu_caps)
> +{
> +	struct inode *inode =3D d_backing_inode(dentry);
> +	int size, ret;
> +	struct vfs_ns_cap_data data, *nscaps =3D &data;
> +
> +	if (!inode)
> +		return -ENODATA;
> =20
> -	cpu_caps->rootid =3D rootvfsuid;
> +	size =3D __vfs_getxattr((struct dentry *)dentry, inode,
> +			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> +	if (size =3D=3D -ENODATA || size =3D=3D -EOPNOTSUPP)
> +		/* no data, that's ok */
> +		return -ENODATA;
> +
> +	if (size < 0)
> +		return size;
> +
> +	ret =3D vfs_caps_from_xattr(idmap, inode->i_sb->s_user_ns,
> +				  cpu_caps, nscaps, size);
> +	if (ret =3D=3D -EOVERFLOW)
> +		return -ENODATA;
> +	if (ret)
> +		return ret;
> +
> +	/* Limit the caps to the mounter of the filesystem
> +	 * or the more limited uid specified in the xattr.
> +	 */
> +	if (!rootid_owns_currentns(cpu_caps->rootid))
> +		return -ENODATA;
> =20
>  	return 0;
>  }
>=20


