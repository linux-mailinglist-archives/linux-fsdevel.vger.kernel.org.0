Return-Path: <linux-fsdevel+bounces-654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFEE7CDF37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844A3281D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7BD374D9;
	Wed, 18 Oct 2023 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in80ri9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FCBE5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0BFC433C7;
	Wed, 18 Oct 2023 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638685;
	bh=UB2hb8s5CEd3FPPIfnwCMCcqL6WX+kKb6T2In5KzbfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=in80ri9duSGMlOA42NDLRVWiGWKWI1hoLO2QmWeLNj/jIvZ5lbrv7jmTfP8Tk0kUG
	 CwyLBHEsmB0SnfD64r+zGIXAQEsWHt9urtYBoihNMBmXRr06JDIMwAamTYPY7pv3Qc
	 j8f8LcsHfksAouIIB2JvIKMPcCbYlfbBmLeGHjYg5RXUya+NryZIgaqU47jcC1zeYB
	 Qd8AHBA8jZ9xqsRty0odusQRmgQqrtn6E6QMkByNKd0cfq77ebbAjNCxMcmQK8n8m6
	 f9BNAD0kvuvQ4mzv14BErDYZoId3MS+LG2EQG1rQeUZJBuycxbde5648nmzT1qYscI
	 uuuT4mW2XNY+w==
Message-ID: <4106d2d1f94dcc992d6bd9b4d478f9a5588c6403.camel@kernel.org>
Subject: Re: [PATCH 4/5] exportfs: define FILEID_INO64_GEN* file handle types
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Date: Wed, 18 Oct 2023 10:18:03 -0400
In-Reply-To: <20231018100000.2453965-5-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
	 <20231018100000.2453965-5-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 12:59 +0300, Amir Goldstein wrote:
> Similar to the common FILEID_INO32* file handle types, define common
> FILEID_INO64* file handle types.
>=20
> The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> values returned by fuse and xfs for 64bit ino encoded file handle types.
>=20
> Note that these type value are filesystem specific and they do not define
> a universal file handle format, for example:
> fuse encodes FILEID_INO64_GEN as [ino-hi32,ino-lo32,gen] and xfs encodes
> FILEID_INO64_GEN as [hostr-order-ino64,gen] (a.k.a xfs_fid64).
>=20
> The FILEID_INO64_GEN fhandle type is going to be used for file ids for
> fanotify from filesystems that do not support NFS export.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/inode.c          |  7 ++++---
>  include/linux/exportfs.h | 11 +++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2e4eb7cf26fb..e63f966698a5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1002,7 +1002,7 @@ static int fuse_encode_fh(struct inode *inode, u32 =
*fh, int *max_len,
>  	}
> =20
>  	*max_len =3D len;
> -	return parent ? 0x82 : 0x81;
> +	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
> =20
>  static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
> @@ -1010,7 +1010,8 @@ static struct dentry *fuse_fh_to_dentry(struct supe=
r_block *sb,
>  {
>  	struct fuse_inode_handle handle;
> =20
> -	if ((fh_type !=3D 0x81 && fh_type !=3D 0x82) || fh_len < 3)
> +	if ((fh_type !=3D FILEID_INO64_GEN &&
> +	     fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
>  		return NULL;
> =20
>  	handle.nodeid =3D (u64) fid->raw[0] << 32;
> @@ -1024,7 +1025,7 @@ static struct dentry *fuse_fh_to_parent(struct supe=
r_block *sb,
>  {
>  	struct fuse_inode_handle parent;
> =20
> -	if (fh_type !=3D 0x82 || fh_len < 6)
> +	if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
>  		return NULL;
> =20
>  	parent.nodeid =3D (u64) fid->raw[3] << 32;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 6b6e01321405..21eeb9f6bdbd 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -98,6 +98,17 @@ enum fid_type {
>  	 */
>  	FILEID_FAT_WITH_PARENT =3D 0x72,
> =20
> +	/*
> +	 * 64 bit inode number, 32 bit generation number.
> +	 */
> +	FILEID_INO64_GEN =3D 0x81,
> +
> +	/*
> +	 * 64 bit inode number, 32 bit generation number,
> +	 * 64 bit parent inode number, 32 bit parent generation.
> +	 */
> +	FILEID_INO64_GEN_PARENT =3D 0x82,
> +
>  	/*
>  	 * 128 bit child FID (struct lu_fid)
>  	 * 128 bit parent FID (struct lu_fid)

Reviewed-by: Jeff Layton <jlayton@kernel.org>

