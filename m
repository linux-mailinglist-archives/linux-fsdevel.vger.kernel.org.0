Return-Path: <linux-fsdevel+bounces-6075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB035813281
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 15:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF611F22076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B359E25;
	Thu, 14 Dec 2023 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuU+Ti7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB83E462;
	Thu, 14 Dec 2023 14:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFCDC433C7;
	Thu, 14 Dec 2023 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702562851;
	bh=9BLM+8qwcvl/5vM2uEaRxfm58T5UnEeUHi1BK0de4ak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IuU+Ti7Ig9BEHGWxIBw1DJbtactT68k/HlsJToI2vUeWq9EJ1U2mT0k1T5D2xujoM
	 B1rYB5j5idW2FL5RHh8SVSgwbWkEua6byHbIh5zCcVmxRmMP51w2PBl2derU/6yO0z
	 ssQwz8+KBEPWwMTGOW4dPXut1/X1lToKBU5F8OXTR9SELjzy/VkeavIZv8OnJNh4o8
	 0rK+lP6rYfi+n5z+t0sJRKcdQ43Ia0R/QlaHc3UTt1U6oOH4rkiZpMFkoxHO7yHVXo
	 /rR4D5gZfcBIl3UiwfXtNkJX80NncEVj3Np/wvQqP70YyjSMV2p9IQgN/h4TangZEz
	 Shx7/M6nv64Qg==
Message-ID: <8b9413cc37a231a97059c7d028d404ab35363764.camel@kernel.org>
Subject: Re: [PATCH v4 37/39] netfs: Optimise away reads above the point at
 which there can be no data
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Christian Brauner
 <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2023 09:07:28 -0500
In-Reply-To: <20231213152350.431591-38-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-38-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 15:23 +0000, David Howells wrote:
> Track the file position above which the server is not expected to have an=
y
> data (the "zero point") and preemptively assume that we can satisfy
> requests by filling them with zeroes locally rather than attempting to
> download them if they're over that line - even if we've written data back
> to the server.  Assume that any data that was written back above that
> position is held in the local cache.  Note that we have to split requests
> that straddle the line.
>=20
> Make use of this to optimise away some reads from the server.  We need to
> set the zero point in the following circumstances:
>=20
>  (1) When we see an extant remote inode and have no cache for it, we set
>      the zero_point to i_size.
>=20
>  (2) On local inode creation, we set zero_point to 0.
>=20
>  (3) On local truncation down, we reduce zero_point to the new i_size if
>      the new i_size is lower.
>=20
>  (4) On local truncation up, we don't change zero_point.
>=20

The above seems odd, but I guess the assumption is that if there are any
writes by a 3rd party above the old zero point, that that would cause an
invalidation?

>  (5) On local modification, we don't change zero_point.
>=20
>  (6) On remote invalidation, we set zero_point to the new i_size.
>=20
>  (7) If stored data is discarded from the pagecache or culled from fscach=
e,
>      we must set zero_point above that if the data also got written to th=
e
>      server.
>=20
>  (8) If dirty data is written back to the server, but not fscache, we mus=
t
>      set zero_point above that.
>=20
>  (9) If a direct I/O write is made, set zero_point above that.
>=20
> Assuming the above, any read from the server at or above the zero_point
> position will return all zeroes.
>=20
> The zero_point value can be stored in the cache, provided the above rules
> are applied to it by any code that culls part of the local cache.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/afs/inode.c            | 22 +++++++++++++---------
>  fs/netfs/buffered_write.c |  2 +-
>  fs/netfs/direct_write.c   |  4 ++++
>  fs/netfs/io.c             | 10 ++++++++++
>  fs/netfs/misc.c           |  5 +++++
>  fs/smb/client/cifsfs.c    |  4 ++--
>  include/linux/netfs.h     | 14 ++++++++++++--
>  7 files changed, 47 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index c43112dcbbbb..dfd940a64e0f 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -166,6 +166,7 @@ static void afs_apply_status(struct afs_operation *op=
,
>  	struct inode *inode =3D &vnode->netfs.inode;
>  	struct timespec64 t;
>  	umode_t mode;
> +	bool unexpected_jump =3D false;
>  	bool data_changed =3D false;
>  	bool change_size =3D vp->set_size;
> =20
> @@ -230,6 +231,7 @@ static void afs_apply_status(struct afs_operation *op=
,
>  		}
>  		change_size =3D true;
>  		data_changed =3D true;
> +		unexpected_jump =3D true;
>  	} else if (vnode->status.type =3D=3D AFS_FTYPE_DIR) {
>  		/* Expected directory change is handled elsewhere so
>  		 * that we can locally edit the directory and save on a
> @@ -251,6 +253,8 @@ static void afs_apply_status(struct afs_operation *op=
,
>  		vnode->netfs.remote_i_size =3D status->size;
>  		if (change_size || status->size > i_size_read(inode)) {
>  			afs_set_i_size(vnode, status->size);
> +			if (unexpected_jump)
> +				vnode->netfs.zero_point =3D status->size;
>  			inode_set_ctime_to_ts(inode, t);
>  			inode_set_atime_to_ts(inode, t);
>  		}
> @@ -689,17 +693,17 @@ static void afs_setattr_success(struct afs_operatio=
n *op)
>  static void afs_setattr_edit_file(struct afs_operation *op)
>  {
>  	struct afs_vnode_param *vp =3D &op->file[0];
> -	struct inode *inode =3D &vp->vnode->netfs.inode;
> +	struct afs_vnode *vnode =3D vp->vnode;
> =20
>  	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
>  		loff_t size =3D op->setattr.attr->ia_size;
>  		loff_t i_size =3D op->setattr.old_i_size;
> =20
> -		if (size < i_size)
> -			truncate_pagecache(inode, size);
> -		if (size !=3D i_size)
> -			fscache_resize_cookie(afs_vnode_cache(vp->vnode),
> -					      vp->scb.status.size);
> +		if (size !=3D i_size) {
> +			truncate_setsize(&vnode->netfs.inode, size);
> +			netfs_resize_file(&vnode->netfs, size, true);
> +			fscache_resize_cookie(afs_vnode_cache(vnode), size);
> +		}
>  	}
>  }
> =20
> @@ -767,11 +771,11 @@ int afs_setattr(struct mnt_idmap *idmap, struct den=
try *dentry,
>  		 */
>  		if (!(attr->ia_valid & (supported & ~ATTR_SIZE & ~ATTR_MTIME)) &&
>  		    attr->ia_size < i_size &&
> -		    attr->ia_size > vnode->status.size) {
> -			truncate_pagecache(inode, attr->ia_size);
> +		    attr->ia_size > vnode->netfs.remote_i_size) {
> +			truncate_setsize(inode, attr->ia_size);
> +			netfs_resize_file(&vnode->netfs, size, false);
>  			fscache_resize_cookie(afs_vnode_cache(vnode),
>  					      attr->ia_size);
> -			i_size_write(inode, attr->ia_size);
>  			ret =3D 0;
>  			goto out_unlock;
>  		}
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index dce6995fb644..d7ce424b9188 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -73,7 +73,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(str=
uct netfs_inode *ctx,
>  	if (folio_test_uptodate(folio))
>  		return NETFS_FOLIO_IS_UPTODATE;
> =20
> -	if (pos >=3D ctx->remote_i_size)
> +	if (pos >=3D ctx->zero_point)
>  		return NETFS_MODIFY_AND_CLEAR;
> =20
>  	if (!maybe_trouble && offset =3D=3D 0 && len >=3D flen)
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index bb0c2718f57b..aad05f2349a4 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -134,6 +134,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
>  	struct file *file =3D iocb->ki_filp;
>  	struct inode *inode =3D file->f_mapping->host;
>  	struct netfs_inode *ictx =3D netfs_inode(inode);
> +	unsigned long long end;
>  	ssize_t ret;
> =20
>  	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read=
(inode));
> @@ -155,6 +156,9 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
>  	ret =3D kiocb_invalidate_pages(iocb, iov_iter_count(from));
>  	if (ret < 0)
>  		goto out;
> +	end =3D iocb->ki_pos + iov_iter_count(from);
> +	if (end > ictx->zero_point)
> +		ictx->zero_point =3D end;
> =20
>  	fscache_invalidate(netfs_i_cookie(ictx), NULL, i_size_read(inode),
>  			   FSCACHE_INVAL_DIO_WRITE);
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 5d9098db815a..41a6113aa7fa 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -569,6 +569,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq=
,
>  			struct iov_iter *io_iter)
>  {
>  	enum netfs_io_source source =3D NETFS_DOWNLOAD_FROM_SERVER;
> +	struct netfs_inode *ictx =3D netfs_inode(rreq->inode);
>  	size_t lsize;
> =20
>  	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rr=
eq->i_size);
> @@ -586,6 +587,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *rre=
q,
>  		 * to make serial calls, it can indicate a short read and then
>  		 * we will call it again.
>  		 */
> +		if (rreq->origin !=3D NETFS_DIO_READ) {
> +			if (subreq->start >=3D ictx->zero_point) {
> +				source =3D NETFS_FILL_WITH_ZEROES;
> +				goto set;
> +			}
> +			if (subreq->len > ictx->zero_point - subreq->start)
> +				subreq->len =3D ictx->zero_point - subreq->start;
> +		}
>  		if (subreq->len > rreq->i_size - subreq->start)
>  			subreq->len =3D rreq->i_size - subreq->start;
>  		if (rreq->rsize && subreq->len > rreq->rsize)
> @@ -607,6 +616,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq=
,
>  		}
>  	}
> =20
> +set:
>  	if (subreq->len > rreq->len)
>  		pr_warn("R=3D%08x[%u] SREQ>RREQ %zx > %zx\n",
>  			rreq->debug_id, subreq->debug_index,
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 40421ced4cd3..31e45dfad5b0 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -240,6 +240,11 @@ EXPORT_SYMBOL(netfs_invalidate_folio);
>  bool netfs_release_folio(struct folio *folio, gfp_t gfp)
>  {
>  	struct netfs_inode *ctx =3D netfs_inode(folio_inode(folio));
> +	unsigned long long end;
> +
> +	end =3D folio_pos(folio) + folio_size(folio);
> +	if (end > ctx->zero_point)
> +		ctx->zero_point =3D end;
> =20
>  	if (folio_test_private(folio))
>  		return false;
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 96a65cf9b5ec..07cd88897c33 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1220,7 +1220,7 @@ static int cifs_precopy_set_eof(struct inode *src_i=
node, struct cifsInodeInfo *s
>  	if (rc < 0)
>  		goto set_failed;
> =20
> -	netfs_resize_file(&src_cifsi->netfs, src_end);
> +	netfs_resize_file(&src_cifsi->netfs, src_end, true);
>  	fscache_resize_cookie(cifs_inode_cookie(src_inode), src_end);
>  	return 0;
> =20
> @@ -1351,7 +1351,7 @@ static loff_t cifs_remap_file_range(struct file *sr=
c_file, loff_t off,
>  			smb_file_src, smb_file_target, off, len, destoff);
>  		if (rc =3D=3D 0 && new_size > i_size_read(target_inode)) {
>  			truncate_setsize(target_inode, new_size);
> -			netfs_resize_file(&target_cifsi->netfs, new_size);
> +			netfs_resize_file(&target_cifsi->netfs, new_size, true);
>  			fscache_resize_cookie(cifs_inode_cookie(target_inode),
>  					      new_size);
>  		}
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index fc77f7be220a..2005ad3b0e25 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -136,6 +136,8 @@ struct netfs_inode {
>  	struct fscache_cookie	*cache;
>  #endif
>  	loff_t			remote_i_size;	/* Size of the remote file */
> +	loff_t			zero_point;	/* Size after which we assume there's no data
> +						 * on the server */
>  	unsigned long		flags;
>  #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
> @@ -465,22 +467,30 @@ static inline void netfs_inode_init(struct netfs_in=
ode *ctx,
>  {
>  	ctx->ops =3D ops;
>  	ctx->remote_i_size =3D i_size_read(&ctx->inode);
> +	ctx->zero_point =3D ctx->remote_i_size;
>  	ctx->flags =3D 0;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache =3D NULL;
>  #endif
> +	/* ->releasepage() drives zero_point */
> +	mapping_set_release_always(ctx->inode.i_mapping);
>  }
> =20
>  /**
>   * netfs_resize_file - Note that a file got resized
>   * @ctx: The netfs inode being resized
>   * @new_i_size: The new file size
> + * @changed_on_server: The change was applied to the server
>   *
>   * Inform the netfs lib that a file got resized so that it can adjust it=
s state.
>   */
> -static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new=
_i_size)
> +static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new=
_i_size,
> +				     bool changed_on_server)
>  {
> -	ctx->remote_i_size =3D new_i_size;
> +	if (changed_on_server)
> +		ctx->remote_i_size =3D new_i_size;
> +	if (new_i_size < ctx->zero_point)
> +		ctx->zero_point =3D new_i_size;
>  }
> =20
>  /**
>=20

--=20
Jeff Layton <jlayton@kernel.org>

