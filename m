Return-Path: <linux-fsdevel+bounces-419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251EB7CAE31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966F31F22476
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B72E637;
	Mon, 16 Oct 2023 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2t0uQf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4882C87E;
	Mon, 16 Oct 2023 15:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E701C433C8;
	Mon, 16 Oct 2023 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697471452;
	bh=8Z3jrNAij+Fk5+s3c9fGMpm3Llf0bqvYwxb17CmvIj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a2t0uQf/DvBBY36/YSVGHmEbDVIJss6218VIOQFaRNy8JmQ0oer3kf5Do4B/XVenG
	 33gyHHvUp34cAPyShV8hXUknOC/FDMNGdNjTPZJIcqDJUhBRCBvvVC16qC3yq7Sc0K
	 6I7K8HlxTttf8VEYSL/9nhJiLXbO97xByEonHK91iC09/ZE70rl6GZxNnpxTwr5E5V
	 q5Pqgk3a6b2L7xZJwBVEiGuUDDd7tXyymGf5isDXPBkRuGcR3Q9MlwE/DlbvXcKCcL
	 QDOSHkHAxS6J/twjTAZ2McHQ4XR/fhs1WSS1NGUGj/jDf09dQOLLUlJEXb+HyrMikw
	 OssnuHYl7WxWQ==
Message-ID: <01b4b502db610db7e100a6a1371acd8633a5dbb7.camel@kernel.org>
Subject: Re: [RFC PATCH 07/53] netfs: Provide invalidate_folio and
 release_folio calls
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>,  linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Date: Mon, 16 Oct 2023 11:50:49 -0400
In-Reply-To: <20231013160423.2218093-8-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
	 <20231013160423.2218093-8-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-13 at 17:03 +0100, David Howells wrote:
> Provide default invalidate_folio and release_folio calls.  These will nee=
d
> to interact with invalidation correctly at some point.  They will be need=
ed
> if netfslib is to make use of folio->private for its own purposes.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/9p/vfs_addr.c      | 33 ++-------------------------
>  fs/afs/file.c         | 53 ++++---------------------------------------
>  fs/ceph/addr.c        | 24 ++------------------
>  fs/netfs/Makefile     |  1 +
>  fs/netfs/misc.c       | 51 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |  6 +++--
>  6 files changed, 64 insertions(+), 104 deletions(-)
>  create mode 100644 fs/netfs/misc.c
>=20
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 8a635999a7d6..18a666c43e4a 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -104,35 +104,6 @@ const struct netfs_request_ops v9fs_req_ops =3D {
>  	.issue_read		=3D v9fs_issue_read,
>  };
> =20
> -/**
> - * v9fs_release_folio - release the private state associated with a foli=
o
> - * @folio: The folio to be released
> - * @gfp: The caller's allocation restrictions
> - *
> - * Returns true if the page can be released, false otherwise.
> - */
> -
> -static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
> -{
> -	if (folio_test_private(folio))
> -		return false;
> -#ifdef CONFIG_9P_FSCACHE
> -	if (folio_test_fscache(folio)) {
> -		if (current_is_kswapd() || !(gfp & __GFP_FS))
> -			return false;
> -		folio_wait_fscache(folio);
> -	}
> -	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(folio_inode(folio)))=
);
> -#endif
> -	return true;
> -}
> -
> -static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
> -				 size_t length)
> -{
> -	folio_wait_fscache(folio);
> -}
> -
>  #ifdef CONFIG_9P_FSCACHE
>  static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_=
error,
>  				     bool was_async)
> @@ -355,8 +326,8 @@ const struct address_space_operations v9fs_addr_opera=
tions =3D {
>  	.writepage =3D v9fs_vfs_writepage,
>  	.write_begin =3D v9fs_write_begin,
>  	.write_end =3D v9fs_write_end,
> -	.release_folio =3D v9fs_release_folio,
> -	.invalidate_folio =3D v9fs_invalidate_folio,
> +	.release_folio =3D netfs_release_folio,
> +	.invalidate_folio =3D netfs_invalidate_folio,
>  	.launder_folio =3D v9fs_launder_folio,
>  	.direct_IO =3D v9fs_direct_IO,
>  };
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 0c49b3b6f214..3fea5cd8ef13 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -20,9 +20,6 @@
> =20
>  static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
>  static int afs_symlink_read_folio(struct file *file, struct folio *folio=
);
> -static void afs_invalidate_folio(struct folio *folio, size_t offset,
> -			       size_t length);
> -static bool afs_release_folio(struct folio *folio, gfp_t gfp_flags);
> =20
>  static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *i=
ter);
>  static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
> @@ -57,8 +54,8 @@ const struct address_space_operations afs_file_aops =3D=
 {
>  	.readahead	=3D netfs_readahead,
>  	.dirty_folio	=3D afs_dirty_folio,
>  	.launder_folio	=3D afs_launder_folio,
> -	.release_folio	=3D afs_release_folio,
> -	.invalidate_folio =3D afs_invalidate_folio,
> +	.release_folio	=3D netfs_release_folio,
> +	.invalidate_folio =3D netfs_invalidate_folio,
>  	.write_begin	=3D afs_write_begin,
>  	.write_end	=3D afs_write_end,
>  	.writepages	=3D afs_writepages,
> @@ -67,8 +64,8 @@ const struct address_space_operations afs_file_aops =3D=
 {
> =20
>  const struct address_space_operations afs_symlink_aops =3D {
>  	.read_folio	=3D afs_symlink_read_folio,
> -	.release_folio	=3D afs_release_folio,
> -	.invalidate_folio =3D afs_invalidate_folio,
> +	.release_folio	=3D netfs_release_folio,
> +	.invalidate_folio =3D netfs_invalidate_folio,
>  	.migrate_folio	=3D filemap_migrate_folio,
>  };
> =20
> @@ -405,48 +402,6 @@ int afs_write_inode(struct inode *inode, struct writ=
eback_control *wbc)
>  	return 0;
>  }
> =20
> -/*
> - * invalidate part or all of a page
> - * - release a page and clean up its private data if offset is 0 (indica=
ting
> - *   the entire page)
> - */
> -static void afs_invalidate_folio(struct folio *folio, size_t offset,
> -			       size_t length)
> -{
> -	_enter("{%lu},%zu,%zu", folio->index, offset, length);
> -
> -	folio_wait_fscache(folio);
> -	_leave("");
> -}
> -
> -/*
> - * release a page and clean up its private state if it's not busy
> - * - return true if the page can now be released, false if not
> - */
> -static bool afs_release_folio(struct folio *folio, gfp_t gfp)
> -{
> -	struct afs_vnode *vnode =3D AFS_FS_I(folio_inode(folio));
> -
> -	_enter("{{%llx:%llu}[%lu],%lx},%x",
> -	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio), folio->fla=
gs,
> -	       gfp);
> -
> -	/* deny if folio is being written to the cache and the caller hasn't
> -	 * elected to wait */
> -#ifdef CONFIG_AFS_FSCACHE
> -	if (folio_test_fscache(folio)) {
> -		if (current_is_kswapd() || !(gfp & __GFP_FS))
> -			return false;
> -		folio_wait_fscache(folio);
> -	}
> -	fscache_note_page_release(afs_vnode_cache(vnode));
> -#endif
> -
> -	/* Indicate that the folio can be released */
> -	_leave(" =3D T");
> -	return true;
> -}
> -
>  static void afs_add_open_mmap(struct afs_vnode *vnode)
>  {
>  	if (atomic_inc_return(&vnode->cb_nr_mmap) =3D=3D 1) {
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f4863078f7fe..ced19ff08988 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -160,27 +160,7 @@ static void ceph_invalidate_folio(struct folio *foli=
o, size_t offset,
>  		ceph_put_snap_context(snapc);
>  	}
> =20
> -	folio_wait_fscache(folio);
> -}
> -
> -static bool ceph_release_folio(struct folio *folio, gfp_t gfp)
> -{
> -	struct inode *inode =3D folio->mapping->host;
> -
> -	dout("%llx:%llx release_folio idx %lu (%sdirty)\n",
> -	     ceph_vinop(inode),
> -	     folio->index, folio_test_dirty(folio) ? "" : "not ");
> -
> -	if (folio_test_private(folio))
> -		return false;
> -
> -	if (folio_test_fscache(folio)) {
> -		if (current_is_kswapd() || !(gfp & __GFP_FS))
> -			return false;
> -		folio_wait_fscache(folio);
> -	}
> -	ceph_fscache_note_page_release(inode);
> -	return true;
> +	netfs_invalidate_folio(folio, offset, length);
>  }
> =20
>  static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
> @@ -1563,7 +1543,7 @@ const struct address_space_operations ceph_aops =3D=
 {
>  	.write_end =3D ceph_write_end,
>  	.dirty_folio =3D ceph_dirty_folio,
>  	.invalidate_folio =3D ceph_invalidate_folio,
> -	.release_folio =3D ceph_release_folio,
> +	.release_folio =3D netfs_release_folio,
>  	.direct_IO =3D noop_direct_IO,
>  };
> =20
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index 386d6fb92793..cd22554d9048 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -5,6 +5,7 @@ netfs-y :=3D \
>  	io.o \
>  	iterator.o \
>  	main.o \
> +	misc.o \
>  	objects.o
> =20
>  netfs-$(CONFIG_NETFS_STATS) +=3D stats.o
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> new file mode 100644
> index 000000000000..c3baf2b247d9
> --- /dev/null
> +++ b/fs/netfs/misc.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Miscellaneous routines.
> + *
> + * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/swap.h>
> +#include "internal.h"
> +
> +/**
> + * netfs_invalidate_folio - Invalidate or partially invalidate a folio
> + * @folio: Folio proposed for release
> + * @offset: Offset of the invalidated region
> + * @length: Length of the invalidated region
> + *
> + * Invalidate part or all of a folio for a network filesystem.  The foli=
o will
> + * be removed afterwards if the invalidated region covers the entire fol=
io.
> + */
> +void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t l=
ength)
> +{
> +	_enter("{%lx},%zx,%zx", folio_index(folio), offset, length);
> +
> +	folio_wait_fscache(folio);
> +}
> +EXPORT_SYMBOL(netfs_invalidate_folio);
> +
> +/**
> + * netfs_release_folio - Try to release a folio
> + * @folio: Folio proposed for release
> + * @gfp: Flags qualifying the release
> + *
> + * Request release of a folio and clean up its private state if it's not=
 busy.
> + * Returns true if the folio can now be released, false if not
> + */
> +bool netfs_release_folio(struct folio *folio, gfp_t gfp)
> +{
> +	struct netfs_inode *ctx =3D netfs_inode(folio_inode(folio));
> +
> +	if (folio_test_private(folio))
> +		return false;
> +	if (folio_test_fscache(folio)) {
> +		if (current_is_kswapd() || !(gfp & __GFP_FS))
> +			return false;
> +		folio_wait_fscache(folio);
> +	}
> +
> +	fscache_note_page_release(netfs_i_cookie(ctx));
> +	return true;
> +}
> +EXPORT_SYMBOL(netfs_release_folio);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index ed64d1034afa..daa431c4148d 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -299,8 +299,10 @@ struct readahead_control;
>  void netfs_readahead(struct readahead_control *);
>  int netfs_read_folio(struct file *, struct folio *);
>  int netfs_write_begin(struct netfs_inode *, struct file *,
> -		struct address_space *, loff_t pos, unsigned int len,
> -		struct folio **, void **fsdata);
> +		      struct address_space *, loff_t pos, unsigned int len,
> +		      struct folio **, void **fsdata);
> +void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t l=
ength);
> +bool netfs_release_folio(struct folio *folio, gfp_t gfp);
> =20
>  void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool=
);
>  void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
>=20

Nice cleanup. Might can merge this in advance of the rest of the series.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

