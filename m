Return-Path: <linux-fsdevel+bounces-5974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69A8118BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493551C211FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F733071;
	Wed, 13 Dec 2023 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hluffg79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B282D602;
	Wed, 13 Dec 2023 16:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1DC433C7;
	Wed, 13 Dec 2023 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702483706;
	bh=ZgKgrMyUDTKnLgSuVk7ImB5iN6ZDHT1xsphFEbZaGGM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Hluffg798xq5HjCEKfIZ5RxRYBJ50KicgBk7cImKVUVDSGXgrpHuDaYemXP5xFKSc
	 PImB6uuK8l+FinssSt3GAcC+5yjt5LK8lcIfIyrtyHYdswIOqGfeGkdkeS9k+y1Rfw
	 j9XNRKtrjkojTDZ0sn0QUVzmZ8Gh7hRVP2sgzlCBMAS6KnilvKm1jwhYxIwRP8deMQ
	 OHsWIIzUF4Gh7eHxtIjswKd4f6DcKby3YBXar2PoUeUPZIFqMb7xPLTxLamChS060I
	 mdEHlepsaTuIUfirZWq3+E1X5gr4G+rntAaTZZ7BZNua0PGb3aeoqlbMCanXoVaDpZ
	 GhH1MbgdrmENg==
Message-ID: <debede02dbf2701043c2a2b8b9fc05665bc59030.camel@kernel.org>
Subject: Re: [PATCH v4 11/39] netfs: Implement unbuffered/DIO vs buffered
 I/O locking
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
Date: Wed, 13 Dec 2023 11:08:23 -0500
In-Reply-To: <20231213152350.431591-12-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-12-dhowells@redhat.com>
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
> Borrow NFS's direct-vs-buffered I/O locking into netfslib.  Similar code =
is
> also used in ceph.
>=20
> Modify it to have the correct checker annotations for i_rwsem lock
> acquisition/release and to return -ERESTARTSYS if waits are interrupted.
>=20

This is just adding new infrastructure. It'd be nice to go ahead and
convert a filesystem to use this at the same time. Ceph would be a good
candidate. Otherwise, I'm not sure how this shakes out as far as
cleanliness in the callers.


> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/Makefile     |   1 +
>  fs/netfs/locking.c    | 215 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |  10 ++
>  3 files changed, 226 insertions(+)
>  create mode 100644 fs/netfs/locking.c
>=20
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index a84fe9bbd3c4..cf3fc847b8ac 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -4,6 +4,7 @@ netfs-y :=3D \
>  	buffered_read.o \
>  	io.o \
>  	iterator.o \
> +	locking.o \
>  	main.o \
>  	misc.o \
>  	objects.o
> diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
> new file mode 100644
> index 000000000000..58e0f48394c5
> --- /dev/null
> +++ b/fs/netfs/locking.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I/O and data path helper functionality.
> + *
> + * Borrowed from NFS Copyright (c) 2016 Trond Myklebust
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/netfs.h>
> +
> +/*
> + * inode_dio_wait_interruptible - wait for outstanding DIO requests to f=
inish
> + * @inode: inode to wait for
> + *
> + * Waits for all pending direct I/O requests to finish so that we can
> + * proceed with a truncate or equivalent operation.
> + *
> + * Must be called under a lock that serializes taking new references
> + * to i_dio_count, usually by inode->i_mutex.
> + */
> +static int inode_dio_wait_interruptible(struct inode *inode)
> +{
> +	if (!atomic_read(&inode->i_dio_count))
> +		return 0;
> +
> +	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP=
);
> +	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> +
> +	for (;;) {
> +		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
> +		if (!atomic_read(&inode->i_dio_count))
> +			break;
> +		if (signal_pending(current))
> +			break;
> +		schedule();
> +	}
> +	finish_wait(wq, &q.wq_entry);
> +
> +	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> +}
> +
> +/* Call with exclusively locked inode->i_rwsem */
> +static int netfs_block_o_direct(struct netfs_inode *ictx)
> +{
> +	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags))
> +		return 0;
> +	clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +	return inode_dio_wait_interruptible(&ictx->inode);
> +}
> +
> +/**
> + * netfs_start_io_read - declare the file is being used for buffered rea=
ds
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is about to start, and ensure
> + * that we block all direct I/O.
> + * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is uns=
et,
> + * and holds a shared lock on inode->i_rwsem to ensure that the flag
> + * cannot be changed.
> + * In practice, this means that buffered read operations are allowed to
> + * execute in parallel, thanks to the shared lock, whereas direct I/O
> + * operations need to wait to grab an exclusive lock in order to set
> + * NETFS_ICTX_ODIRECT.
> + * Note that buffered writes and truncates both take a write lock on
> + * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
> + */
> +int netfs_start_io_read(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +
> +	/* Be an optimist! */
> +	if (down_read_interruptible(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) =3D=3D 0)
> +		return 0;
> +	up_read(&inode->i_rwsem);
> +
> +	/* Slow path.... */
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (netfs_block_o_direct(ictx) < 0) {
> +		up_write(&inode->i_rwsem);
> +		return -ERESTARTSYS;
> +	}
> +	downgrade_write(&inode->i_rwsem);
> +	return 0;
> +}
> +EXPORT_SYMBOL(netfs_start_io_read);
> +
> +/**
> + * netfs_end_io_read - declare that the buffered read operation is done
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is done, and release the share=
d
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_read(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_read(&inode->i_rwsem);
> +}
> +EXPORT_SYMBOL(netfs_end_io_read);
> +
> +/**
> + * netfs_start_io_write - declare the file is being used for buffered wr=
ites
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is about to start, and ensure
> + * that we block all direct I/O.
> + */
> +int netfs_start_io_write(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (netfs_block_o_direct(ictx) < 0) {
> +		up_write(&inode->i_rwsem);
> +		return -ERESTARTSYS;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(netfs_start_io_write);
> +
> +/**
> + * netfs_end_io_write - declare that the buffered write operation is don=
e
> + * @inode: file inode
> + *
> + * Declare that a buffered write operation is done, and release the
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_write(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_write(&inode->i_rwsem);
> +}
> +EXPORT_SYMBOL(netfs_end_io_write);
> +
> +/* Call with exclusively locked inode->i_rwsem */
> +static int netfs_block_buffered(struct inode *inode)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +	int ret;
> +
> +	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags)) {
> +		set_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +		if (inode->i_mapping->nrpages !=3D 0) {
> +			unmap_mapping_range(inode->i_mapping, 0, 0, 0);
> +			ret =3D filemap_fdatawait(inode->i_mapping);
> +			if (ret < 0) {
> +				clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +				return ret;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * netfs_start_io_direct - declare the file is being used for direct i/o
> + * @inode: file inode
> + *
> + * Declare that a direct I/O operation is about to start, and ensure
> + * that we block all buffered I/O.
> + * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is set=
,
> + * and holds a shared lock on inode->i_rwsem to ensure that the flag
> + * cannot be changed.
> + * In practice, this means that direct I/O operations are allowed to
> + * execute in parallel, thanks to the shared lock, whereas buffered I/O
> + * operations need to wait to grab an exclusive lock in order to clear
> + * NETFS_ICTX_ODIRECT.
> + * Note that buffered writes and truncates both take a write lock on
> + * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
> + */
> +int netfs_start_io_direct(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +	int ret;
> +
> +	/* Be an optimist! */
> +	if (down_read_interruptible(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) !=3D 0)
> +		return 0;
> +	up_read(&inode->i_rwsem);
> +
> +	/* Slow path.... */
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	ret =3D netfs_block_buffered(inode);
> +	if (ret < 0) {
> +		up_write(&inode->i_rwsem);
> +		return ret;
> +	}
> +	downgrade_write(&inode->i_rwsem);
> +	return 0;
> +}
> +EXPORT_SYMBOL(netfs_start_io_direct);
> +
> +/**
> + * netfs_end_io_direct - declare that the direct i/o operation is done
> + * @inode: file inode
> + *
> + * Declare that a direct I/O operation is done, and release the shared
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_direct(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_read(&inode->i_rwsem);
> +}
> +EXPORT_SYMBOL(netfs_end_io_direct);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 8efbfd3b2820..fc6d9756a029 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -129,6 +129,8 @@ struct netfs_inode {
>  	struct fscache_cookie	*cache;
>  #endif
>  	loff_t			remote_i_size;	/* Size of the remote file */
> +	unsigned long		flags;
> +#define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  };
> =20
>  /*
> @@ -310,6 +312,13 @@ ssize_t netfs_extract_user_iter(struct iov_iter *ori=
g, size_t orig_len,
>  				struct iov_iter *new,
>  				iov_iter_extraction_t extraction_flags);
> =20
> +int netfs_start_io_read(struct inode *inode);
> +void netfs_end_io_read(struct inode *inode);
> +int netfs_start_io_write(struct inode *inode);
> +void netfs_end_io_write(struct inode *inode);
> +int netfs_start_io_direct(struct inode *inode);
> +void netfs_end_io_direct(struct inode *inode);
> +
>  /**
>   * netfs_inode - Get the netfs inode context from the inode
>   * @inode: The inode to query
> @@ -335,6 +344,7 @@ static inline void netfs_inode_init(struct netfs_inod=
e *ctx,
>  {
>  	ctx->ops =3D ops;
>  	ctx->remote_i_size =3D i_size_read(&ctx->inode);
> +	ctx->flags =3D 0;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache =3D NULL;
>  #endif
>=20
--=20
Jeff Layton <jlayton@kernel.org>

