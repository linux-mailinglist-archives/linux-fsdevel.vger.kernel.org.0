Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225776F07C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbjD0PAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0PAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBD2D4A;
        Thu, 27 Apr 2023 08:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E5263925;
        Thu, 27 Apr 2023 15:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05955C433EF;
        Thu, 27 Apr 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682607630;
        bh=XXP+z3UyWGI1qgqsAozaeSSVzIprZmLNdP3zak0bBJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tYq2w2l5oCoXHvtivjbBO96mFI+A2IfR4ESQ/klc3GZeS3VQL2PEhQNsXfVGsBJbh
         GdAXf4MwpTfkvcvyQdsyiq4aqmjzUviPdu81+RtbXcnyRsvR8EMtCjmIp+TxOGyZSS
         ol0rZ1xvVdsdfJKWmQdlTbCdmCm6KN0dJFtPkNd6Cb6obUNUC0TGtTfy4T4JvsdeXL
         FYLtnoRbP954IdPo2fpzKdyZd7CeslM1drzhTyksKbCv33ELl2GJX0LSd66rL3gC9g
         BxpLQkGPfJEi8YBjj+Shz+Lj/9kQ+5qGzf65vRw3quOQcW1XBF+52sEgKdMZjCY/eh
         yVlC8eaRSfOOg==
Message-ID: <9118c0e6b03357942d38b9f2badb5be2708bdb5b.camel@kernel.org>
Subject: Re: [RFC][PATCH 2/4] exportfs: add explicit flag to request
 non-decodeable file handles
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Thu, 27 Apr 2023 11:00:28 -0400
In-Reply-To: <20230425130105.2606684-3-amir73il@gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
         <20230425130105.2606684-3-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> So far, all callers of exportfs_encode_inode_fh(), except for fsnotify's
> show_mark_fhandle(), check that filesystem can decode file handles, but
> we would like to add more callers that do not require a file handle that
> can be decoded.
>=20
> Introduce a flag to explicitly request a file handle that may not to be
> decoded later and a wrapper exportfs_encode_fid() that sets this flag
> and convert show_mark_fhandle() to use the new wrapper.
>=20
> This will be used to allow adding fanotify support to filesystems that
> do not support NFS export.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  4 ++--
>  fs/exportfs/expfs.c                         | 18 ++++++++++++++++--
>  fs/notify/fanotify/fanotify.c               |  4 ++--
>  fs/notify/fdinfo.c                          |  2 +-
>  include/linux/exportfs.h                    | 12 +++++++++++-
>  5 files changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index 0e98edd353b5..3d97b8d8f735 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -122,8 +122,8 @@ are exportable by setting the s_export_op field in th=
e struct
>  super_block.  This field must point to a "struct export_operations"
>  struct which has the following members:
> =20
> - encode_fh  (optional)
> -    Takes a dentry and creates a filehandle fragment which can later be =
used
> +  encode_fh (optional)
> +    Takes a dentry and creates a filehandle fragment which may later be =
used
>      to find or create a dentry for the same object.  The default
>      implementation creates a filehandle fragment that encodes a 32bit in=
ode
>      and generation number for the inode encoded, and if necessary the
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index bf1b4925fedd..1b35dda5bdda 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -381,11 +381,25 @@ static int export_encode_fh(struct inode *inode, st=
ruct fid *fid,
>  	return type;
>  }
> =20
> +/**
> + * exportfs_encode_inode_fh - encode a file handle from inode
> + * @inode:   the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there
> + * @flags:   properties of the requrested file handle
> + */
>  int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> -			     int *max_len, struct inode *parent)
> +			     int *max_len, struct inode *parent, int flags)
>  {
>  	const struct export_operations *nop =3D inode->i_sb->s_export_op;
> =20
> +	/*
> +	 * If a decodeable file handle was requested, we need to make sure that
> +	 * filesystem can decode file handles.
> +	 */
> +	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
> +		return -EOPNOTSUPP;
> +

If you're moving this check into this function, then it might be good to
remove the same check from the callers that are doing this check now.

>  	if (nop && nop->encode_fh)
>  		return nop->encode_fh(inode, fid->raw, max_len, parent);
> =20
> @@ -416,7 +430,7 @@ int exportfs_encode_fh(struct dentry *dentry, struct =
fid *fid, int *max_len,
>  		parent =3D p->d_inode;
>  	}
> =20
> -	error =3D exportfs_encode_inode_fh(inode, fid, max_len, parent);
> +	error =3D exportfs_encode_inode_fh(inode, fid, max_len, parent, flags);
>  	dput(p);
> =20
>  	return error;
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 29bdd99b29fa..d1a49f5b6e6d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *inode=
)
>  	if (!inode)
>  		return 0;
> =20
> -	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> +	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
>  	fh_len =3D dwords << 2;
> =20
>  	/*
> @@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh,=
 struct inode *inode,
>  	}
> =20
>  	dwords =3D fh_len >> 2;
> -	type =3D exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> +	type =3D exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
>  	err =3D -EINVAL;
>  	if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << 2)
>  		goto out_err;
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 55081ae3a6ec..5c430736ec12 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struc=
t inode *inode)
>  	f.handle.handle_bytes =3D sizeof(f.pad);
>  	size =3D f.handle.handle_bytes >> 2;
> =20
> -	ret =3D exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle=
, &size, NULL);
> +	ret =3D exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &si=
ze);
>  	if ((ret =3D=3D FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 2b1048238170..635e89e1dae7 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -136,6 +136,7 @@ struct fid {
>  };
> =20
>  #define EXPORT_FH_CONNECTABLE	0x1
> +#define EXPORT_FH_FID		0x2

Please add comments about what these flags are intended to indicate.

> =20
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
> @@ -226,9 +227,18 @@ struct export_operations {
>  };
> =20
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid=
,
> -				    int *max_len, struct inode *parent);
> +				    int *max_len, struct inode *parent,
> +				    int flags);
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  			      int *max_len, int flags);
> +
> +static inline int exportfs_encode_fid(struct inode *inode, struct fid *f=
id,
> +				      int *max_len)
> +{
> +	return exportfs_encode_inode_fh(inode, fid, max_len, NULL,
> +					EXPORT_FH_FID);
> +}
> +
>  extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
>  					     struct fid *fid, int fh_len,
>  					     int fileid_type,

--=20
Jeff Layton <jlayton@kernel.org>
