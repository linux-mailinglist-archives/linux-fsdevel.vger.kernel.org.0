Return-Path: <linux-fsdevel+bounces-652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BA7CDEEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9205E281D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75430374D9;
	Wed, 18 Oct 2023 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgS5BPAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8336B1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB27C43395;
	Wed, 18 Oct 2023 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638513;
	bh=s6aY1ZS/yXo5J/gpAx2yUrzGUVyMMUnsaK92PMe3VII=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GgS5BPAxJF1KKE3iLdd8lnhjobPqK3vI6/tDryYftWSIb5E+JLWCDk4VbkjZ0NCdz
	 6MZWMJ8gyzFNFwhJs5EtoaqrvBu0Bxb5O1aVXJe9yl9TcqSKbyLPMsxE8C+crki0Hh
	 bZBdy5Z+VPiSNNoXOBjWJEhEuwihLF3qiyRd/0S9fjQQSPno863UlZkbXjsj5jpesd
	 3/fXhuQu2Yu2+PdnBqFN4jPTCDt8R4RxbBKeLJ6Yy2P0+I6hBiRy/IpPHiU+v6mhtU
	 c49DbKXVmb/048/8Wp3vK4cJMAhUECdRSVBA6bklHrktJOuqpDalg1BrXCQaDtbUAD
	 xKDVhfVMUfXnw==
Message-ID: <59e186df80ae6a841ccfada0369110b301ebbaa2.camel@kernel.org>
Subject: Re: [PATCH 2/5] exportfs: add helpers to check if filesystem can
 encode/decode file handles
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Date: Wed, 18 Oct 2023 10:15:11 -0400
In-Reply-To: <20231018100000.2453965-3-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
	 <20231018100000.2453965-3-amir73il@gmail.com>
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
> The logic of whether filesystem can encode/decode file handles is open
> coded in many places.
>=20
> In preparation to changing the logic, move the open coded logic into
> inline helpers.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c                |  8 ++------
>  fs/fhandle.c                       |  6 +-----
>  fs/nfsd/export.c                   |  3 +--
>  fs/notify/fanotify/fanotify_user.c |  4 ++--
>  fs/overlayfs/util.c                |  2 +-
>  include/linux/exportfs.h           | 27 +++++++++++++++++++++++++++
>  6 files changed, 34 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index c20704aa21b3..9ee205df8fa7 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -396,11 +396,7 @@ int exportfs_encode_inode_fh(struct inode *inode, st=
ruct fid *fid,
>  {
>  	const struct export_operations *nop =3D inode->i_sb->s_export_op;
> =20
> -	/*
> -	 * If a decodeable file handle was requested, we need to make sure that
> -	 * filesystem can decode file handles.
> -	 */
> -	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
> +	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
> =20
>  	if (nop && nop->encode_fh)
> @@ -456,7 +452,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct f=
id *fid, int fh_len,
>  	/*
>  	 * Try to get any dentry for the given file handle from the filesystem.
>  	 */
> -	if (!nop || !nop->fh_to_dentry)
> +	if (!exportfs_can_decode_fh(nop))
>  		return ERR_PTR(-ESTALE);
>  	result =3D nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
>  	if (IS_ERR_OR_NULL(result))
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 6ea8d35a9382..18b3ba8dc8ea 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -26,12 +26,8 @@ static long do_sys_name_to_handle(const struct path *p=
ath,
>  	/*
>  	 * We need to make sure whether the file system support decoding of
>  	 * the file handle if decodeable file handle was requested.
> -	 * Otherwise, even empty export_operations are sufficient to opt-in
> -	 * to encoding FIDs.
>  	 */
> -	if (!path->dentry->d_sb->s_export_op ||
> -	    (!(fh_flags & EXPORT_FH_FID) &&
> -	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
> +	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
>  		return -EOPNOTSUPP;
> =20
>  	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 11a0eaa2f914..dc99dfc1d411 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -421,8 +421,7 @@ static int check_export(struct path *path, int *flags=
, unsigned char *uuid)
>  		return -EINVAL;
>  	}
> =20
> -	if (!inode->i_sb->s_export_op ||
> -	    !inode->i_sb->s_export_op->fh_to_dentry) {
> +	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
>  		dprintk("exp_export: export of invalid fs type.\n");
>  		return -EINVAL;
>  	}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 537c70beaad0..ce926eb9feea 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1595,7 +1595,7 @@ static int fanotify_test_fid(struct dentry *dentry,=
 unsigned int flags)
>  	 * file handles so user can use name_to_handle_at() to compare fids
>  	 * reported with events to the file handle of watched objects.
>  	 */
> -	if (!nop)
> +	if (!exportfs_can_encode_fid(nop))
>  		return -EOPNOTSUPP;
> =20
>  	/*
> @@ -1603,7 +1603,7 @@ static int fanotify_test_fid(struct dentry *dentry,=
 unsigned int flags)
>  	 * supports decoding file handles, so user has a way to map back the
>  	 * reported fids to filesystem objects.
>  	 */
> -	if (mark_type !=3D FAN_MARK_INODE && !nop->fh_to_dentry)
> +	if (mark_type !=3D FAN_MARK_INODE && !exportfs_can_decode_fh(nop))
>  		return -EOPNOTSUPP;
> =20
>  	return 0;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 89e0d60d35b6..f0a712214ec2 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -55,7 +55,7 @@ int ovl_can_decode_fh(struct super_block *sb)
>  	if (!capable(CAP_DAC_READ_SEARCH))
>  		return 0;
> =20
> -	if (!sb->s_export_op || !sb->s_export_op->fh_to_dentry)
> +	if (!exportfs_can_decode_fh(sb->s_export_op))
>  		return 0;
> =20
>  	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 11fbd0ee1370..5b3c9f30b422 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -233,6 +233,33 @@ extern int exportfs_encode_inode_fh(struct inode *in=
ode, struct fid *fid,
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  			      int *max_len, int flags);
> =20
> +static inline bool exportfs_can_encode_fid(const struct export_operation=
s *nop)
> +{
> +	return nop;
> +}
> +
> +static inline bool exportfs_can_decode_fh(const struct export_operations=
 *nop)
> +{
> +	return nop && nop->fh_to_dentry;
> +}
> +
> +static inline bool exportfs_can_encode_fh(const struct export_operations=
 *nop,
> +					  int fh_flags)
> +{
> +	/*
> +	 * If a non-decodeable file handle was requested, we only need to make
> +	 * sure that filesystem can encode file handles.
> +	 */
> +	if (fh_flags & EXPORT_FH_FID)
> +		return exportfs_can_encode_fid(nop);
> +
> +	/*
> +	 * If a decodeable file handle was requested, we need to make sure that
> +	 * filesystem can also decode file handles.
> +	 */
> +	return exportfs_can_decode_fh(nop);
> +}
> +
>  static inline int exportfs_encode_fid(struct inode *inode, struct fid *f=
id,
>  				      int *max_len)
>  {

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

