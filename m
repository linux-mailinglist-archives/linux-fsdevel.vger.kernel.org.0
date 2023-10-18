Return-Path: <linux-fsdevel+bounces-653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6A7CDF0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817A4280D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5C374DA;
	Wed, 18 Oct 2023 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVjp/OuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818D20307
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993ADC433D9;
	Wed, 18 Oct 2023 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697638580;
	bh=b6/S+vC9UP+EI3YTuEUg+pGgKKUHj7q9M+pY2nQ0754=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KVjp/OuUhiSms0S8MEONCtwyIFrNfD0LrZca7uV4gSUQWFFWy+OUrIEf+guYPQ2bR
	 3ZmtYh1//Yo+bhzefHre/GXuiKs45l0KykmzjzqAMHQz4sq9V42wvKlQQ/5upE396T
	 0Vky6CcnJynpfoGkm+rGOQeU6/QMO4JRjNJr8e5jO1cv9OGEh1H4PgzJv//xA23nHf
	 yyqTlzocSc00ZVhqaFyoCetuLGHZ+iA4i4hTfLfm2ml2f27s4TxO3YjwaIt/Y/G3zI
	 C4gmHaZp6CoiG/DXgiQJPawkvW3fJ06kgkKAIn1fj5V2y0i8v5xbXcjskbeYHADGSh
	 aycFbfjJf86Xw==
Message-ID: <b873e5f40babe559bd53fd730d13b358066942fa.camel@kernel.org>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>, Luis de
 Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, Gao
 Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,  Theodore Ts'o
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Dave
 Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Steve French
 <sfrench@samba.org>,  Phillip Lougher <phillip@squashfs.org.uk>, Evgeniy
 Dushistov <dushistov@mail.ru>
Date: Wed, 18 Oct 2023 10:16:17 -0400
In-Reply-To: <20231018100000.2453965-4-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
	 <20231018100000.2453965-4-amir73il@gmail.com>
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
> export_operations ->encode_fh() no longer has a default implementation to
> encode FILEID_INO32_GEN* file handles.
>=20
> Rename the default helper for encoding FILEID_INO32_GEN* file handles to
> generic_encode_ino32_fh() and convert the filesystems that used the
> default implementation to use the generic helper explicitly.
>=20
> This is a step towards allowing filesystems to encode non-decodeable file
> handles for fanotify without having to implement any export_operations.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  7 ++-----
>  Documentation/filesystems/porting.rst       |  9 +++++++++
>  fs/affs/namei.c                             |  1 +
>  fs/befs/linuxvfs.c                          |  1 +
>  fs/efs/super.c                              |  1 +
>  fs/erofs/super.c                            |  1 +
>  fs/exportfs/expfs.c                         | 14 ++++++++------
>  fs/ext2/super.c                             |  1 +
>  fs/ext4/super.c                             |  1 +
>  fs/f2fs/super.c                             |  1 +
>  fs/fat/nfs.c                                |  1 +
>  fs/jffs2/super.c                            |  1 +
>  fs/jfs/super.c                              |  1 +
>  fs/ntfs/namei.c                             |  1 +
>  fs/ntfs3/super.c                            |  1 +
>  fs/smb/client/export.c                      |  9 +++------
>  fs/squashfs/export.c                        |  1 +
>  fs/ufs/super.c                              |  1 +
>  include/linux/exportfs.h                    |  4 +++-
>  19 files changed, 39 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index 4b30daee399a..de64d2d002a2 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -122,12 +122,9 @@ are exportable by setting the s_export_op field in t=
he struct
>  super_block.  This field must point to a "struct export_operations"
>  struct which has the following members:
> =20
> -  encode_fh (optional)
> +  encode_fh (mandatory)
>      Takes a dentry and creates a filehandle fragment which may later be =
used
> -    to find or create a dentry for the same object.  The default
> -    implementation creates a filehandle fragment that encodes a 32bit in=
ode
> -    and generation number for the inode encoded, and if necessary the
> -    same information for the parent.
> +    to find or create a dentry for the same object.
> =20
>    fh_to_dentry (mandatory)
>      Given a filehandle fragment, this should find the implied object and
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 4d05b9862451..197ef78a5014 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when=
 the devices are closed:
>  As this is a VFS level change it has no practical consequences for files=
ystems
>  other than that all of them must use one of the provided kill_litter_sup=
er(),
>  kill_anon_super(), or kill_block_super() helpers.
> +
> +---
> +
> +**mandatory**
> +
> +export_operations ->encode_fh() no longer has a default implementation t=
o
> +encode FILEID_INO32_GEN* file handles.
> +Fillesystems that used the default implementation may use the generic he=
lper
> +generic_encode_ino32_fh() explicitly.
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index 2fe4a5832fcf..d6b9758ee23d 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -568,6 +568,7 @@ static struct dentry *affs_fh_to_parent(struct super_=
block *sb, struct fid *fid,
>  }
> =20
>  const struct export_operations affs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D affs_fh_to_dentry,
>  	.fh_to_parent =3D affs_fh_to_parent,
>  	.get_parent =3D affs_get_parent,
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 9a16a51fbb88..410dcaffd5ab 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -96,6 +96,7 @@ static const struct address_space_operations befs_symli=
nk_aops =3D {
>  };
> =20
>  static const struct export_operations befs_export_operations =3D {
> +	.encode_fh	=3D generic_encode_ino32_fh,
>  	.fh_to_dentry	=3D befs_fh_to_dentry,
>  	.fh_to_parent	=3D befs_fh_to_parent,
>  	.get_parent	=3D befs_get_parent,
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index b287f47c165b..f17fdac76b2e 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -123,6 +123,7 @@ static const struct super_operations efs_superblock_o=
perations =3D {
>  };
> =20
>  static const struct export_operations efs_export_ops =3D {
> +	.encode_fh	=3D generic_encode_ino32_fh,
>  	.fh_to_dentry	=3D efs_fh_to_dentry,
>  	.fh_to_parent	=3D efs_fh_to_parent,
>  	.get_parent	=3D efs_get_parent,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3700af9ee173..edbe07a24156 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -626,6 +626,7 @@ static struct dentry *erofs_get_parent(struct dentry =
*child)
>  }
> =20
>  static const struct export_operations erofs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D erofs_fh_to_dentry,
>  	.fh_to_parent =3D erofs_fh_to_parent,
>  	.get_parent =3D erofs_get_parent,
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 9ee205df8fa7..30da4539e257 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *=
name, struct dentry *child)
>  }
> =20
>  /**
> - * export_encode_fh - default export_operations->encode_fh function
> + * generic_encode_ino32_fh - generic export_operations->encode_fh functi=
on
>   * @inode:   the object to encode
> - * @fid:     where to store the file handle fragment
> + * @fh:      where to store the file handle fragment
>   * @max_len: maximum length to store there
>   * @parent:  parent directory inode, if wanted
>   *
> - * This default encode_fh function assumes that the 32 inode number
> + * This generic encode_fh function assumes that the 32 inode number
>   * is suitable for locating an inode, and that the generation number
>   * can be used to check that it is still valid.  It places them in the
>   * filehandle fragment where export_decode_fh expects to find them.
>   */
> -static int export_encode_fh(struct inode *inode, struct fid *fid,
> -		int *max_len, struct inode *parent)
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len=
,
> +			    struct inode *parent)
>  {
> +	struct fid *fid =3D (void *)fh;
>  	int len =3D *max_len;
>  	int type =3D FILEID_INO32_GEN;
> =20
> @@ -380,6 +381,7 @@ static int export_encode_fh(struct inode *inode, stru=
ct fid *fid,
>  	*max_len =3D len;
>  	return type;
>  }
> +EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
> =20
>  /**
>   * exportfs_encode_inode_fh - encode a file handle from inode
> @@ -402,7 +404,7 @@ int exportfs_encode_inode_fh(struct inode *inode, str=
uct fid *fid,
>  	if (nop && nop->encode_fh)
>  		return nop->encode_fh(inode, fid->raw, max_len, parent);
> =20
> -	return export_encode_fh(inode, fid, max_len, parent);
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
> =20
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index aaf3e3e88cb2..b9f158a34997 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -397,6 +397,7 @@ static struct dentry *ext2_fh_to_parent(struct super_=
block *sb, struct fid *fid,
>  }
> =20
>  static const struct export_operations ext2_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D ext2_fh_to_dentry,
>  	.fh_to_parent =3D ext2_fh_to_parent,
>  	.get_parent =3D ext2_get_parent,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dbebd8b3127e..c44db1915437 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1646,6 +1646,7 @@ static const struct super_operations ext4_sops =3D =
{
>  };
> =20
>  static const struct export_operations ext4_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D ext4_fh_to_dentry,
>  	.fh_to_parent =3D ext4_fh_to_parent,
>  	.get_parent =3D ext4_get_parent,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a8c8232852bb..60cfa11f65bf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3282,6 +3282,7 @@ static struct dentry *f2fs_fh_to_parent(struct supe=
r_block *sb, struct fid *fid,
>  }
> =20
>  static const struct export_operations f2fs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D f2fs_fh_to_dentry,
>  	.fh_to_parent =3D f2fs_fh_to_parent,
>  	.get_parent =3D f2fs_get_parent,
> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
> index 3626eb585a98..c52e63e10d35 100644
> --- a/fs/fat/nfs.c
> +++ b/fs/fat/nfs.c
> @@ -279,6 +279,7 @@ static struct dentry *fat_get_parent(struct dentry *c=
hild_dir)
>  }
> =20
>  const struct export_operations fat_export_ops =3D {
> +	.encode_fh	=3D generic_encode_ino32_fh,
>  	.fh_to_dentry   =3D fat_fh_to_dentry,
>  	.fh_to_parent   =3D fat_fh_to_parent,
>  	.get_parent     =3D fat_get_parent,
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 7ea37f49f1e1..f99591a634b4 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -150,6 +150,7 @@ static struct dentry *jffs2_get_parent(struct dentry =
*child)
>  }
> =20
>  static const struct export_operations jffs2_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.get_parent =3D jffs2_get_parent,
>  	.fh_to_dentry =3D jffs2_fh_to_dentry,
>  	.fh_to_parent =3D jffs2_fh_to_parent,
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 2e2f7f6d36a0..2cc2632f3c47 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -896,6 +896,7 @@ static const struct super_operations jfs_super_operat=
ions =3D {
>  };
> =20
>  static const struct export_operations jfs_export_operations =3D {
> +	.encode_fh	=3D generic_encode_ino32_fh,
>  	.fh_to_dentry	=3D jfs_fh_to_dentry,
>  	.fh_to_parent	=3D jfs_fh_to_parent,
>  	.get_parent	=3D jfs_get_parent,
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index ab44f2db533b..d7498ddc4a72 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -384,6 +384,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_=
block *sb, struct fid *fid,
>   * and due to using iget() whereas NTFS needs ntfs_iget().
>   */
>  const struct export_operations ntfs_export_ops =3D {
> +	.encode_fh	=3D generic_encode_ino32_fh,
>  	.get_parent	=3D ntfs_get_parent,	/* Find the parent of a given
>  						   directory. */
>  	.fh_to_dentry	=3D ntfs_fh_to_dentry,
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 5661a363005e..661ffb5aa1e0 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -789,6 +789,7 @@ static int ntfs_nfs_commit_metadata(struct inode *ino=
de)
>  }
> =20
>  static const struct export_operations ntfs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D ntfs_fh_to_dentry,
>  	.fh_to_parent =3D ntfs_fh_to_parent,
>  	.get_parent =3D ntfs3_get_parent,
> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
> index 37c28415df1e..834e9c9197b4 100644
> --- a/fs/smb/client/export.c
> +++ b/fs/smb/client/export.c
> @@ -41,13 +41,10 @@ static struct dentry *cifs_get_parent(struct dentry *=
dentry)
>  }
> =20
>  const struct export_operations cifs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.get_parent =3D cifs_get_parent,
> -/*	Following five export operations are unneeded so far and can default:
> -	.get_dentry =3D
> -	.get_name =3D
> -	.find_exported_dentry =3D
> -	.decode_fh =3D
> -	.encode_fs =3D  */
> +/*	Following export operations are mandatory for NFS export support:
> +	.fh_to_dentry =3D */
>  };
> =20
>  #endif /* CONFIG_CIFS_NFSD_EXPORT */
> diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
> index 723763746238..62972f0ff868 100644
> --- a/fs/squashfs/export.c
> +++ b/fs/squashfs/export.c
> @@ -173,6 +173,7 @@ __le64 *squashfs_read_inode_lookup_table(struct super=
_block *sb,
> =20
> =20
>  const struct export_operations squashfs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry =3D squashfs_fh_to_dentry,
>  	.fh_to_parent =3D squashfs_fh_to_parent,
>  	.get_parent =3D squashfs_get_parent
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 23377c1baed9..a480810cd4e3 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -137,6 +137,7 @@ static struct dentry *ufs_get_parent(struct dentry *c=
hild)
>  }
> =20
>  static const struct export_operations ufs_export_ops =3D {
> +	.encode_fh =3D generic_encode_ino32_fh,
>  	.fh_to_dentry	=3D ufs_fh_to_dentry,
>  	.fh_to_parent	=3D ufs_fh_to_parent,
>  	.get_parent	=3D ufs_get_parent,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 5b3c9f30b422..6b6e01321405 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, =
struct fid *fid,
> =20
>  static inline bool exportfs_can_encode_fid(const struct export_operation=
s *nop)
>  {
> -	return nop;
> +	return nop && nop->encode_fh;
>  }
> =20
>  static inline bool exportfs_can_decode_fh(const struct export_operations=
 *nop)
> @@ -279,6 +279,8 @@ extern struct dentry *exportfs_decode_fh(struct vfsmo=
unt *mnt, struct fid *fid,
>  /*
>   * Generic helpers for filesystems.
>   */
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len=
,
> +			    struct inode *parent);
>  extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
>  	struct fid *fid, int fh_len, int fh_type,
>  	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));

Looks straightforward.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

