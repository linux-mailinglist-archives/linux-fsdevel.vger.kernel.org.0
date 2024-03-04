Return-Path: <linux-fsdevel+bounces-13439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C886FEE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 11:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314E428454A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203739AF1;
	Mon,  4 Mar 2024 10:20:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC460224F9;
	Mon,  4 Mar 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547631; cv=none; b=L8bvgzOWt8wTxX8mp2FbDw6XktHOY3tJCVuD39iCyiD//JzSuZJstisDxkAQSGTHf4K/8Nu/8MlZ2KA/VBsgrfvBl1B4S81poPpdIxjvdrprjV1LmnfBMdqaHEMtvlto79/NCbvGv9/jInDQy4uNJxw3/l0z6qgWw5/7ODoyERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547631; c=relaxed/simple;
	bh=w741xtU6JN1TVvn/J0kQJ41j00UtJv+ZD9k8RAXfQbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlN9AzOCug8h7IBmyEQPz9D8w0QMmmh4Gax/eXwBiDWzIzX/p6vRKSURtVj6VMRbU+AVew8H5LQ/pjUe4ALveXCdUHu71tC35k0DkPuBDysn8+5SoVYSJ6tvadTIY+OTZnxvWPSb+F6bB2Ru3PLR3LZMiZIUyku3SvANDN6Tvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpDnn3kRdz9xGgp;
	Mon,  4 Mar 2024 18:04:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 992D0140796;
	Mon,  4 Mar 2024 18:20:14 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBlNoOVlNsuwAw--.61382S2;
	Mon, 04 Mar 2024 11:20:13 +0100 (CET)
Message-ID: <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
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
Date: Mon, 04 Mar 2024 11:19:54 +0100
In-Reply-To: <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3YBlNoOVlNsuwAw--.61382S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr47ArWUtw13Kr1rWr4rKrg_yoWrKr47pF
	WftF9xKrWrXry7Wr18ta1Dua4F9ayfGFW7urW293sYywnrGr1ftr4xCr18CFy3Cr97Wr1Y
	k3ZFyr98GwsrAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5rxjAAAsf

On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> Use the vfs interfaces for fetching file capabilities for killpriv
> checks and from get_vfs_caps_from_disk(). While there, update the
> kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> from vfs_get_fscaps_nosec().
>=20
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  security/commoncap.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/security/commoncap.c b/security/commoncap.c
> index a0ff7e6092e0..751bb26a06a6 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
>   */
>  int cap_inode_need_killpriv(struct dentry *dentry)
>  {
> -	struct inode *inode =3D d_backing_inode(dentry);
> +	struct vfs_caps caps;
>  	int error;
> =20
> -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> -	return error > 0;
> +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
> +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> +	return error =3D=3D 0;
>  }
> =20
>  /**
> @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struc=
t dentry *dentry)
>  {
>  	int error;
> =20
> -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);

Uhm, I see that the change is logically correct... but the original
code was not correct, since the EVM post hook is not called (thus the
HMAC is broken, or an xattr change is allowed on a portable signature
which should be not).

For completeness, the xattr change on a portable signature should not
happen in the first place, so cap_inode_killpriv() would not be called.
However, since EVM allows same value change, we are here.

Here is how I discovered this problem.

Example:

# ls -l test-file
-rw-r-Sr--. 1 3001 3001 5 Mar  4 10:11 test-file

# getfattr -m - -d -e hex test-file
# file: test-file
security.capability=3D0x0100000202300000023000000000000000000000
security.evm=3D0x05020498c82b5300663064023052a1aa6200d08b3db60a1c636b97b526=
58af369ee0bf521cfca6c733671ebf5764b1b122f67030cfc688a111c19a7ed302303989596=
6cf92217ea55c1405212ced1396c2d830ae55dbdb517c5d199c5a43638f90d430bad4819114=
9dcc7c01f772ac
security.ima=3D0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52=
e6ccc26fd2
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a756e6c6162=
656c65645f743a733000

# chown 3001 test-file

# ls -l test-file
-rw-r-Sr--. 1 3001 3001 5 Mar  4 10:14 test-file

# getfattr -m - -d -e hex test-file
# file: test-file
security.evm=3D0x05020498c82b5300673065023100cdd772fa7f9c17aa66e654c7f9c124=
de1ccfd36abbe5b8100b64a296164da45d0025fd2a2dec2e9580d5c82e5a32bfca02305ea34=
58b74e53d743408f65e748dc6ee52964e3aedac7367a43080248f4e000c655eb8e1f4338bec=
b81797ea37f0bca6
security.ima=3D0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52=
e6ccc26fd2
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a756e6c6162=
656c65645f743a733000


which breaks EVM verification.

Roberto

>  	if (error =3D=3D -EOPNOTSUPP)
>  		error =3D 0;
>  	return error;
> @@ -719,6 +720,10 @@ ssize_t vfs_caps_to_user_xattr(struct mnt_idmap *idm=
ap,
>   * @cpu_caps:	vfs capabilities
>   *
>   * Extract the on-exec-apply capability sets for an executable file.
> + * For version 3 capabilities xattrs, returns the capabilities only if
> + * they are applicable to current_user_ns() (i.e. that the rootid
> + * corresponds to an ID which maps to ID 0 in current_user_ns() or an
> + * ancestor), and returns -ENODATA otherwise.
>   *
>   * If the inode has been found through an idmapped mount the idmap of
>   * the vfsmount must be passed through @idmap. This function will then
> @@ -731,25 +736,16 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   struct vfs_caps *cpu_caps)
>  {
>  	struct inode *inode =3D d_backing_inode(dentry);
> -	int size, ret;
> -	struct vfs_ns_cap_data data, *nscaps =3D &data;
> +	int ret;
> =20
>  	if (!inode)
>  		return -ENODATA;
> =20
> -	size =3D __vfs_getxattr((struct dentry *)dentry, inode,
> -			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> -	if (size =3D=3D -ENODATA || size =3D=3D -EOPNOTSUPP)
> +	ret =3D vfs_get_fscaps_nosec(idmap, (struct dentry *)dentry, cpu_caps);
> +	if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EOVERFLOW)
>  		/* no data, that's ok */
> -		return -ENODATA;
> +		ret =3D -ENODATA;
> =20
> -	if (size < 0)
> -		return size;
> -
> -	ret =3D vfs_caps_from_xattr(idmap, inode->i_sb->s_user_ns,
> -				  cpu_caps, nscaps, size);
> -	if (ret =3D=3D -EOVERFLOW)
> -		return -ENODATA;
>  	if (ret)
>  		return ret;
> =20
>=20


