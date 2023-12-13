Return-Path: <linux-fsdevel+bounces-5973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72E8118AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866E72829F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E8433081;
	Wed, 13 Dec 2023 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK9rbljk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C41D6B8;
	Wed, 13 Dec 2023 16:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF9C433C8;
	Wed, 13 Dec 2023 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702483557;
	bh=kELEnVlcoDolhSWet6c+R6d2i2N//H1HAVNrhARH3fI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dK9rbljkcrgkshS77/YHsB8LELPQQvNPvJ8AiCpghYOCci9IcTg+MFm4E5Igim/86
	 xgHDV07N2j1miWILt99OlTmyUJkKzgcWfQykud9oF6ps9ndk6GPzI9ktazsuaJlP49
	 2XwYF5Bm6lCn9kF16srYYUamxfnrixSR4id+sbF520p12BqAMqR0SD1rE8zm85XeLt
	 9ofogqLsxnLWD6MpiO8UeyBUAPxOg8pUqBH2wW++/xydOfAVc2JnJLZB1iT/ASVH9v
	 lkZzlxCrmTChXIjD12+yIgO5gjb0eFcgra5F10hw/Zn/pBanP/oN+UF2WsEtqvgguB
	 AvfYSw9+x328Q==
Message-ID: <987d3f0ac5cafc9706f5d532e60f9cc0379b3153.camel@kernel.org>
Subject: Re: [PATCH v4 10/39] netfs: Provide invalidate_folio and
 release_folio calls
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
Date: Wed, 13 Dec 2023 11:05:54 -0500
In-Reply-To: <20231213152350.431591-11-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-11-dhowells@redhat.com>
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
> Provide default invalidate_folio and release_folio calls.  These will nee=
d
> to interact with invalidation correctly at some point.  They will be need=
ed
> if netfslib is to make use of folio->private for its own purposes.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/9p/vfs_addr.c      | 33 ++-------------------------
>  fs/afs/file.c         | 53 ++++---------------------------------------
>  fs/ceph/addr.c        | 24 ++------------------
>  fs/netfs/misc.c       | 42 ++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |  6 +++--
>  5 files changed, 54 insertions(+), 104 deletions(-)
>=20
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 131b83c31f85..055b672a247d 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -88,35 +88,6 @@ const struct netfs_request_ops v9fs_req_ops =3D {
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
> @@ -324,8 +295,8 @@ const struct address_space_operations v9fs_addr_opera=
tions =3D {
>  	.writepage	=3D v9fs_vfs_writepage,
>  	.write_begin	=3D v9fs_write_begin,
>  	.write_end	=3D v9fs_write_end,
> -	.release_folio	=3D v9fs_release_folio,
> -	.invalidate_folio =3D v9fs_invalidate_folio,
> +	.release_folio	=3D netfs_release_folio,
> +	.invalidate_folio =3D netfs_invalidate_folio,
>  	.launder_folio	=3D v9fs_launder_folio,
>  	.direct_IO	=3D v9fs_direct_IO,
>  };
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 5e2bca3b02fd..c5013ec3c1dc 100644
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
>  	.dirty_folio	=3D netfs_dirty_folio,
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
> @@ -383,48 +380,6 @@ const struct netfs_request_ops afs_req_ops =3D {
>  	.issue_read		=3D afs_issue_read,
>  };
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
> index 654f408a0aca..500a87b68a9a 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -159,27 +159,7 @@ static void ceph_invalidate_folio(struct folio *foli=
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
> -	struct ceph_client *cl =3D ceph_inode_to_client(inode);
> -
> -	doutc(cl, "%llx.%llx idx %lu (%sdirty)\n", ceph_vinop(inode),
> -	      folio->index, folio_test_dirty(folio) ? "" : "not ");
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

I think this is the only call to ceph_fscache_note_page_release, so that
can likely be removed as well.

> -	return true;
> +	netfs_invalidate_folio(folio, offset, length);
>  }
> =20
>  static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
> @@ -1585,7 +1565,7 @@ const struct address_space_operations ceph_aops =3D=
 {
>  	.write_end =3D ceph_write_end,
>  	.dirty_folio =3D ceph_dirty_folio,
>  	.invalidate_folio =3D ceph_invalidate_folio,
> -	.release_folio =3D ceph_release_folio,
> +	.release_folio =3D netfs_release_folio,
>  	.direct_IO =3D noop_direct_IO,
>  };
> =20
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 68baf55c47a4..d946d85764de 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -84,3 +84,45 @@ void netfs_clear_inode_writeback(struct inode *inode, =
const void *aux)
>  	}
>  }
>  EXPORT_SYMBOL(netfs_clear_inode_writeback);
> +
> +/*
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
> index 06f57d9d09f6..8efbfd3b2820 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -293,11 +293,13 @@ struct readahead_control;
>  void netfs_readahead(struct readahead_control *);
>  int netfs_read_folio(struct file *, struct folio *);
>  int netfs_write_begin(struct netfs_inode *, struct file *,
> -		struct address_space *, loff_t pos, unsigned int len,
> -		struct folio **, void **fsdata);
> +		      struct address_space *, loff_t pos, unsigned int len,
> +		      struct folio **, void **fsdata);
>  bool netfs_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>  int netfs_unpin_writeback(struct inode *inode, struct writeback_control =
*wbc);
>  void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
> +void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t l=
ength);
> +bool netfs_release_folio(struct folio *folio, gfp_t gfp);
> =20
>  void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool=
);
>  void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
>=20

--=20
Jeff Layton <jlayton@kernel.org>

