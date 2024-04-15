Return-Path: <linux-fsdevel+bounces-16921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB038A4ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BE31C21186
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FA6BFDD;
	Mon, 15 Apr 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ9aSaT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3969D27;
	Mon, 15 Apr 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183646; cv=none; b=GSHVvSyhMlBdDEXjDPh5P5CTkUBJxxdxkjOM7Rvl593e4k+dtEjryRHuBi5Jaz4VHcX3/EK44znPz3ju7a2WKPuK514yo/NH8twf6VMn/GyKnO6JgzbjuLH1MyUOipEqvzaee+V4sULn5wlsMFGgr2vaOYHGEiS+oB996csKK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183646; c=relaxed/simple;
	bh=Hrk7l/zVgWfu5mbhj+M4bPYPiaa2pSVVbK5jt/hnYYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jcsdpw4G8C1U7XN7dFp3aUCsTHtgGbDpMKwfS14NzSRRqM9Ig9R9yfrJsI0xhR88zaOiFYHWFyZOlL9HutXedrIFop9+7v6E+dl9b32zvRN4cswOaxGJ4m4NwNcTlYxH4uPIetYTfFUB/sV4vYnEgMIWF/TKn0g33uEGmKB1oQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ9aSaT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2720C113CC;
	Mon, 15 Apr 2024 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183646;
	bh=Hrk7l/zVgWfu5mbhj+M4bPYPiaa2pSVVbK5jt/hnYYk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QQ9aSaT/ok0VUaJwUQ/4yNDH+Tg1FFTq5KxsfIt5nKX+MLwRVbpTvC/UPbucDLBVv
	 Z96WUFQcoMARQrOKYYCoCUufwQmYOTaTwZikJ87K77SRqXlzB0Y/nxplDiiqfImqAa
	 2YTomgw9j/GjGn6b0tXa7/lzMY7nEjw6oa3HEJr6WXPb1VMYGQkfDtmBPNcMgL3BXx
	 981n3RCWGQdaEUF0glRJWJHVnxRqN/N5dgAA+7olXpk5mUF2x+Z2/3fsn+X+pjx8Hf
	 tqyWWAWujQf71Kh1TXVz5LZZ42RBNU5u1FSk0n/OKDPK/rsJ7SXWY4BcMoEfmzA4j3
	 RIgszLDT5hGfQ==
Message-ID: <87d451ff8cd030a380b522b4dfc56ca42c9de444.camel@kernel.org>
Subject: Re: [PATCH 24/26] netfs: Remove the old writeback code
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
	 <christian@brauner.io>, Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique
	Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>,
  Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara
 <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey
 <tom@talpey.com>, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov
 <idryomov@gmail.com>, netfs@lists.linux.dev,  linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
Date: Mon, 15 Apr 2024 08:20:42 -0400
In-Reply-To: <20240328163424.2781320-25-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
	 <20240328163424.2781320-25-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 16:34 +0000, David Howells wrote:
> Remove the old writeback code.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/9p/vfs_addr.c          |  34 ---
>  fs/afs/write.c            |  40 ---
>  fs/netfs/buffered_write.c | 629 --------------------------------------
>  fs/netfs/direct_write.c   |   2 +-
>  fs/netfs/output.c         | 477 -----------------------------
>  5 files changed, 1 insertion(+), 1181 deletions(-)
>  delete mode 100644 fs/netfs/output.c
>=20
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 4845e655bc39..a97ceb105cd8 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -60,40 +60,6 @@ static void v9fs_issue_write(struct netfs_io_subreques=
t *subreq)
>  	netfs_write_subrequest_terminated(subreq, len ?: err, false);
>  }
> =20
> -#if 0 // TODO: Remove

#23 and #24 should probably be merged. I don't see any reason to do the
two-step of ifdef'ing out the code and then removing it. Just go for it
at this point in the series.

> -static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
> -{
> -	struct p9_fid *fid =3D subreq->rreq->netfs_priv;
> -	int err, len;
> -
> -	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> -	len =3D p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
> -	netfs_write_subrequest_terminated(subreq, len ?: err, false);
> -}
> -
> -static void v9fs_upload_to_server_worker(struct work_struct *work)
> -{
> -	struct netfs_io_subrequest *subreq =3D
> -		container_of(work, struct netfs_io_subrequest, work);
> -
> -	v9fs_upload_to_server(subreq);
> -}
> -
> -/*
> - * Set up write requests for a writeback slice.  We need to add a write =
request
> - * for each write we want to make.
> - */
> -static void v9fs_create_write_requests(struct netfs_io_request *wreq, lo=
ff_t start, size_t len)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	subreq =3D netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
> -					    start, len, v9fs_upload_to_server_worker);
> -	if (subreq)
> -		netfs_queue_write_request(subreq);
> -}
> -#endif
> -
>  /**
>   * v9fs_issue_read - Issue a read from 9P
>   * @subreq: The read to make
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 0ead204c84cb..6ef7d4cbc008 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -156,46 +156,6 @@ static int afs_store_data(struct afs_vnode *vnode, s=
truct iov_iter *iter, loff_t
>  	return afs_put_operation(op);
>  }
> =20
> -#if 0 // TODO: Remove
> -static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
> -{
> -	struct afs_vnode *vnode =3D AFS_FS_I(subreq->rreq->inode);
> -	ssize_t ret;
> -
> -	_enter("%x[%x],%zx",
> -	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.cou=
nt);
> -
> -	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> -	ret =3D afs_store_data(vnode, &subreq->io_iter, subreq->start);
> -	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
> -					  false);
> -}
> -
> -static void afs_upload_to_server_worker(struct work_struct *work)
> -{
> -	struct netfs_io_subrequest *subreq =3D
> -		container_of(work, struct netfs_io_subrequest, work);
> -
> -	afs_upload_to_server(subreq);
> -}
> -
> -/*
> - * Set up write requests for a writeback slice.  We need to add a write =
request
> - * for each write we want to make.
> - */
> -void afs_create_write_requests(struct netfs_io_request *wreq, loff_t sta=
rt, size_t len)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	_enter("%x,%llx-%llx", wreq->debug_id, start, start + len);
> -
> -	subreq =3D netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
> -					    start, len, afs_upload_to_server_worker);
> -	if (subreq)
> -		netfs_queue_write_request(subreq);
> -}
> -#endif
> -
>  /*
>   * Writeback calls this when it finds a folio that needs uploading.  Thi=
s isn't
>   * called if writeback only has copy-to-cache to deal with.
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 945e646cd2db..2da9905abec9 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -575,632 +575,3 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf,=
 struct netfs_group *netfs_gr
>  	return ret;
>  }
>  EXPORT_SYMBOL(netfs_page_mkwrite);
> -
> -#if 0 // TODO: Remove
> -/*
> - * Kill all the pages in the given range
> - */
> -static void netfs_kill_pages(struct address_space *mapping,
> -			     loff_t start, loff_t len)
> -{
> -	struct folio *folio;
> -	pgoff_t index =3D start / PAGE_SIZE;
> -	pgoff_t last =3D (start + len - 1) / PAGE_SIZE, next;
> -
> -	_enter("%llx-%llx", start, start + len - 1);
> -
> -	do {
> -		_debug("kill %lx (to %lx)", index, last);
> -
> -		folio =3D filemap_get_folio(mapping, index);
> -		if (IS_ERR(folio)) {
> -			next =3D index + 1;
> -			continue;
> -		}
> -
> -		next =3D folio_next_index(folio);
> -
> -		trace_netfs_folio(folio, netfs_folio_trace_kill);
> -		folio_clear_uptodate(folio);
> -		folio_end_writeback(folio);
> -		folio_lock(folio);
> -		generic_error_remove_folio(mapping, folio);
> -		folio_unlock(folio);
> -		folio_put(folio);
> -
> -	} while (index =3D next, index <=3D last);
> -
> -	_leave("");
> -}
> -
> -/*
> - * Redirty all the pages in a given range.
> - */
> -static void netfs_redirty_pages(struct address_space *mapping,
> -				loff_t start, loff_t len)
> -{
> -	struct folio *folio;
> -	pgoff_t index =3D start / PAGE_SIZE;
> -	pgoff_t last =3D (start + len - 1) / PAGE_SIZE, next;
> -
> -	_enter("%llx-%llx", start, start + len - 1);
> -
> -	do {
> -		_debug("redirty %llx @%llx", len, start);
> -
> -		folio =3D filemap_get_folio(mapping, index);
> -		if (IS_ERR(folio)) {
> -			next =3D index + 1;
> -			continue;
> -		}
> -
> -		next =3D folio_next_index(folio);
> -		trace_netfs_folio(folio, netfs_folio_trace_redirty);
> -		filemap_dirty_folio(mapping, folio);
> -		folio_end_writeback(folio);
> -		folio_put(folio);
> -	} while (index =3D next, index <=3D last);
> -
> -	balance_dirty_pages_ratelimited(mapping);
> -
> -	_leave("");
> -}
> -
> -/*
> - * Completion of write to server
> - */
> -static void netfs_pages_written_back(struct netfs_io_request *wreq)
> -{
> -	struct address_space *mapping =3D wreq->mapping;
> -	struct netfs_folio *finfo;
> -	struct netfs_group *group =3D NULL;
> -	struct folio *folio;
> -	pgoff_t last;
> -	int gcount =3D 0;
> -
> -	XA_STATE(xas, &mapping->i_pages, wreq->start / PAGE_SIZE);
> -
> -	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
> -
> -	rcu_read_lock();
> -
> -	last =3D (wreq->start + wreq->len - 1) / PAGE_SIZE;
> -	xas_for_each(&xas, folio, last) {
> -		WARN(!folio_test_writeback(folio),
> -		     "bad %llx @%llx page %lx %lx\n",
> -		     wreq->len, wreq->start, folio->index, last);
> -
> -		if ((finfo =3D netfs_folio_info(folio))) {
> -			/* Streaming writes cannot be redirtied whilst under
> -			 * writeback, so discard the streaming record.
> -			 */
> -			folio_detach_private(folio);
> -			group =3D finfo->netfs_group;
> -			gcount++;
> -			trace_netfs_folio(folio, netfs_folio_trace_clear_s);
> -			kfree(finfo);
> -		} else if ((group =3D netfs_folio_group(folio))) {
> -			/* Need to detach the group pointer if the page didn't
> -			 * get redirtied.  If it has been redirtied, then it
> -			 * must be within the same group.
> -			 */
> -			if (folio_test_dirty(folio)) {
> -				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
> -				goto end_wb;
> -			}
> -			if (folio_trylock(folio)) {
> -				if (!folio_test_dirty(folio)) {
> -					folio_detach_private(folio);
> -					gcount++;
> -					if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE)
> -						trace_netfs_folio(folio,
> -								  netfs_folio_trace_end_copy);
> -					else
> -						trace_netfs_folio(folio, netfs_folio_trace_clear_g);
> -				} else {
> -					trace_netfs_folio(folio, netfs_folio_trace_redirtied);
> -				}
> -				folio_unlock(folio);
> -				goto end_wb;
> -			}
> -
> -			xas_pause(&xas);
> -			rcu_read_unlock();
> -			folio_lock(folio);
> -			if (!folio_test_dirty(folio)) {
> -				folio_detach_private(folio);
> -				gcount++;
> -				trace_netfs_folio(folio, netfs_folio_trace_clear_g);
> -			} else {
> -				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
> -			}
> -			folio_unlock(folio);
> -			rcu_read_lock();
> -		} else {
> -			trace_netfs_folio(folio, netfs_folio_trace_clear);
> -		}
> -	end_wb:
> -		xas_advance(&xas, folio_next_index(folio) - 1);
> -		folio_end_writeback(folio);
> -	}
> -
> -	rcu_read_unlock();
> -	netfs_put_group_many(group, gcount);
> -	_leave("");
> -}
> -
> -/*
> - * Deal with the disposition of the folios that are under writeback to c=
lose
> - * out the operation.
> - */
> -static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq)
> -{
> -	struct address_space *mapping =3D wreq->mapping;
> -
> -	_enter("");
> -
> -	switch (wreq->error) {
> -	case 0:
> -		netfs_pages_written_back(wreq);
> -		break;
> -
> -	default:
> -		pr_notice("R=3D%08x Unexpected error %d\n", wreq->debug_id, wreq->erro=
r);
> -		fallthrough;
> -	case -EACCES:
> -	case -EPERM:
> -	case -ENOKEY:
> -	case -EKEYEXPIRED:
> -	case -EKEYREJECTED:
> -	case -EKEYREVOKED:
> -	case -ENETRESET:
> -	case -EDQUOT:
> -	case -ENOSPC:
> -		netfs_redirty_pages(mapping, wreq->start, wreq->len);
> -		break;
> -
> -	case -EROFS:
> -	case -EIO:
> -	case -EREMOTEIO:
> -	case -EFBIG:
> -	case -ENOENT:
> -	case -ENOMEDIUM:
> -	case -ENXIO:
> -		netfs_kill_pages(mapping, wreq->start, wreq->len);
> -		break;
> -	}
> -
> -	if (wreq->error)
> -		mapping_set_error(mapping, wreq->error);
> -	if (wreq->netfs_ops->done)
> -		wreq->netfs_ops->done(wreq);
> -}
> -
> -/*
> - * Extend the region to be written back to include subsequent contiguous=
ly
> - * dirty pages if possible, but don't sleep while doing so.
> - *
> - * If this page holds new content, then we can include filler zeros in t=
he
> - * writeback.
> - */
> -static void netfs_extend_writeback(struct address_space *mapping,
> -				   struct netfs_group *group,
> -				   struct xa_state *xas,
> -				   long *_count,
> -				   loff_t start,
> -				   loff_t max_len,
> -				   size_t *_len,
> -				   size_t *_top)
> -{
> -	struct netfs_folio *finfo;
> -	struct folio_batch fbatch;
> -	struct folio *folio;
> -	unsigned int i;
> -	pgoff_t index =3D (start + *_len) / PAGE_SIZE;
> -	size_t len;
> -	void *priv;
> -	bool stop =3D true;
> -
> -	folio_batch_init(&fbatch);
> -
> -	do {
> -		/* Firstly, we gather up a batch of contiguous dirty pages
> -		 * under the RCU read lock - but we can't clear the dirty flags
> -		 * there if any of those pages are mapped.
> -		 */
> -		rcu_read_lock();
> -
> -		xas_for_each(xas, folio, ULONG_MAX) {
> -			stop =3D true;
> -			if (xas_retry(xas, folio))
> -				continue;
> -			if (xa_is_value(folio))
> -				break;
> -			if (folio->index !=3D index) {
> -				xas_reset(xas);
> -				break;
> -			}
> -
> -			if (!folio_try_get_rcu(folio)) {
> -				xas_reset(xas);
> -				continue;
> -			}
> -
> -			/* Has the folio moved or been split? */
> -			if (unlikely(folio !=3D xas_reload(xas))) {
> -				folio_put(folio);
> -				xas_reset(xas);
> -				break;
> -			}
> -
> -			if (!folio_trylock(folio)) {
> -				folio_put(folio);
> -				xas_reset(xas);
> -				break;
> -			}
> -			if (!folio_test_dirty(folio) ||
> -			    folio_test_writeback(folio)) {
> -				folio_unlock(folio);
> -				folio_put(folio);
> -				xas_reset(xas);
> -				break;
> -			}
> -
> -			stop =3D false;
> -			len =3D folio_size(folio);
> -			priv =3D folio_get_private(folio);
> -			if ((const struct netfs_group *)priv !=3D group) {
> -				stop =3D true;
> -				finfo =3D netfs_folio_info(folio);
> -				if (!finfo ||
> -				    finfo->netfs_group !=3D group ||
> -				    finfo->dirty_offset > 0) {
> -					folio_unlock(folio);
> -					folio_put(folio);
> -					xas_reset(xas);
> -					break;
> -				}
> -				len =3D finfo->dirty_len;
> -			}
> -
> -			*_top +=3D folio_size(folio);
> -			index +=3D folio_nr_pages(folio);
> -			*_count -=3D folio_nr_pages(folio);
> -			*_len +=3D len;
> -			if (*_len >=3D max_len || *_count <=3D 0)
> -				stop =3D true;
> -
> -			if (!folio_batch_add(&fbatch, folio))
> -				break;
> -			if (stop)
> -				break;
> -		}
> -
> -		xas_pause(xas);
> -		rcu_read_unlock();
> -
> -		/* Now, if we obtained any folios, we can shift them to being
> -		 * writable and mark them for caching.
> -		 */
> -		if (!folio_batch_count(&fbatch))
> -			break;
> -
> -		for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
> -			folio =3D fbatch.folios[i];
> -			if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE)
> -				trace_netfs_folio(folio, netfs_folio_trace_copy_plus);
> -			else
> -				trace_netfs_folio(folio, netfs_folio_trace_store_plus);
> -
> -			if (!folio_clear_dirty_for_io(folio))
> -				BUG();
> -			folio_start_writeback(folio);
> -			folio_unlock(folio);
> -		}
> -
> -		folio_batch_release(&fbatch);
> -		cond_resched();
> -	} while (!stop);
> -}
> -
> -/*
> - * Synchronously write back the locked page and any subsequent non-locke=
d dirty
> - * pages.
> - */
> -static ssize_t netfs_write_back_from_locked_folio(struct address_space *=
mapping,
> -						  struct writeback_control *wbc,
> -						  struct netfs_group *group,
> -						  struct xa_state *xas,
> -						  struct folio *folio,
> -						  unsigned long long start,
> -						  unsigned long long end)
> -{
> -	struct netfs_io_request *wreq;
> -	struct netfs_folio *finfo;
> -	struct netfs_inode *ctx =3D netfs_inode(mapping->host);
> -	unsigned long long i_size =3D i_size_read(&ctx->inode);
> -	size_t len, max_len;
> -	long count =3D wbc->nr_to_write;
> -	int ret;
> -
> -	_enter(",%lx,%llx-%llx", folio->index, start, end);
> -
> -	wreq =3D netfs_alloc_request(mapping, NULL, start, folio_size(folio),
> -				   group =3D=3D NETFS_FOLIO_COPY_TO_CACHE ?
> -				   NETFS_COPY_TO_CACHE : NETFS_WRITEBACK);
> -	if (IS_ERR(wreq)) {
> -		folio_unlock(folio);
> -		return PTR_ERR(wreq);
> -	}
> -
> -	if (!folio_clear_dirty_for_io(folio))
> -		BUG();
> -	folio_start_writeback(folio);
> -
> -	count -=3D folio_nr_pages(folio);
> -
> -	/* Find all consecutive lockable dirty pages that have contiguous
> -	 * written regions, stopping when we find a page that is not
> -	 * immediately lockable, is not dirty or is missing, or we reach the
> -	 * end of the range.
> -	 */
> -	if (group =3D=3D NETFS_FOLIO_COPY_TO_CACHE)
> -		trace_netfs_folio(folio, netfs_folio_trace_copy);
> -	else
> -		trace_netfs_folio(folio, netfs_folio_trace_store);
> -
> -	len =3D wreq->len;
> -	finfo =3D netfs_folio_info(folio);
> -	if (finfo) {
> -		start +=3D finfo->dirty_offset;
> -		if (finfo->dirty_offset + finfo->dirty_len !=3D len) {
> -			len =3D finfo->dirty_len;
> -			goto cant_expand;
> -		}
> -		len =3D finfo->dirty_len;
> -	}
> -
> -	if (start < i_size) {
> -		/* Trim the write to the EOF; the extra data is ignored.  Also
> -		 * put an upper limit on the size of a single storedata op.
> -		 */
> -		max_len =3D 65536 * 4096;
> -		max_len =3D min_t(unsigned long long, max_len, end - start + 1);
> -		max_len =3D min_t(unsigned long long, max_len, i_size - start);
> -
> -		if (len < max_len)
> -			netfs_extend_writeback(mapping, group, xas, &count, start,
> -					       max_len, &len, &wreq->upper_len);
> -	}
> -
> -cant_expand:
> -	len =3D min_t(unsigned long long, len, i_size - start);
> -
> -	/* We now have a contiguous set of dirty pages, each with writeback
> -	 * set; the first page is still locked at this point, but all the rest
> -	 * have been unlocked.
> -	 */
> -	folio_unlock(folio);
> -	wreq->start =3D start;
> -	wreq->len =3D len;
> -
> -	if (start < i_size) {
> -		_debug("write back %zx @%llx [%llx]", len, start, i_size);
> -
> -		/* Speculatively write to the cache.  We have to fix this up
> -		 * later if the store fails.
> -		 */
> -		wreq->cleanup =3D netfs_cleanup_buffered_write;
> -
> -		iov_iter_xarray(&wreq->iter, ITER_SOURCE, &mapping->i_pages, start,
> -				wreq->upper_len);
> -		if (group !=3D NETFS_FOLIO_COPY_TO_CACHE) {
> -			__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
> -			ret =3D netfs_begin_write(wreq, true, netfs_write_trace_writeback);
> -		} else {
> -			ret =3D netfs_begin_write(wreq, true, netfs_write_trace_copy_to_cache=
);
> -		}
> -		if (ret =3D=3D 0 || ret =3D=3D -EIOCBQUEUED)
> -			wbc->nr_to_write -=3D len / PAGE_SIZE;
> -	} else {
> -		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
> -
> -		/* The dirty region was entirely beyond the EOF. */
> -		netfs_pages_written_back(wreq);
> -		ret =3D 0;
> -	}
> -
> -	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
> -	_leave(" =3D 1");
> -	return 1;
> -}
> -
> -/*
> - * Write a region of pages back to the server
> - */
> -static ssize_t netfs_writepages_begin(struct address_space *mapping,
> -				      struct writeback_control *wbc,
> -				      struct netfs_group *group,
> -				      struct xa_state *xas,
> -				      unsigned long long *_start,
> -				      unsigned long long end)
> -{
> -	const struct netfs_folio *finfo;
> -	struct folio *folio;
> -	unsigned long long start =3D *_start;
> -	ssize_t ret;
> -	void *priv;
> -	int skips =3D 0;
> -
> -	_enter("%llx,%llx,", start, end);
> -
> -search_again:
> -	/* Find the first dirty page in the group. */
> -	rcu_read_lock();
> -
> -	for (;;) {
> -		folio =3D xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
> -		if (xas_retry(xas, folio) || xa_is_value(folio))
> -			continue;
> -		if (!folio)
> -			break;
> -
> -		if (!folio_try_get_rcu(folio)) {
> -			xas_reset(xas);
> -			continue;
> -		}
> -
> -		if (unlikely(folio !=3D xas_reload(xas))) {
> -			folio_put(folio);
> -			xas_reset(xas);
> -			continue;
> -		}
> -
> -		/* Skip any dirty folio that's not in the group of interest. */
> -		priv =3D folio_get_private(folio);
> -		if ((const struct netfs_group *)priv =3D=3D NETFS_FOLIO_COPY_TO_CACHE)=
 {
> -			group =3D NETFS_FOLIO_COPY_TO_CACHE;
> -		} else if ((const struct netfs_group *)priv !=3D group) {
> -			finfo =3D __netfs_folio_info(priv);
> -			if (!finfo || finfo->netfs_group !=3D group) {
> -				folio_put(folio);
> -				continue;
> -			}
> -		}
> -
> -		xas_pause(xas);
> -		break;
> -	}
> -	rcu_read_unlock();
> -	if (!folio)
> -		return 0;
> -
> -	start =3D folio_pos(folio); /* May regress with THPs */
> -
> -	_debug("wback %lx", folio->index);
> -
> -	/* At this point we hold neither the i_pages lock nor the page lock:
> -	 * the page may be truncated or invalidated (changing page->mapping to
> -	 * NULL), or even swizzled back from swapper_space to tmpfs file
> -	 * mapping
> -	 */
> -lock_again:
> -	if (wbc->sync_mode !=3D WB_SYNC_NONE) {
> -		ret =3D folio_lock_killable(folio);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		if (!folio_trylock(folio))
> -			goto search_again;
> -	}
> -
> -	if (folio->mapping !=3D mapping ||
> -	    !folio_test_dirty(folio)) {
> -		start +=3D folio_size(folio);
> -		folio_unlock(folio);
> -		goto search_again;
> -	}
> -
> -	if (folio_test_writeback(folio)) {
> -		folio_unlock(folio);
> -		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
> -			folio_wait_writeback(folio);
> -			goto lock_again;
> -		}
> -
> -		start +=3D folio_size(folio);
> -		if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
> -			if (skips >=3D 5 || need_resched()) {
> -				ret =3D 0;
> -				goto out;
> -			}
> -			skips++;
> -		}
> -		goto search_again;
> -	}
> -
> -	ret =3D netfs_write_back_from_locked_folio(mapping, wbc, group, xas,
> -						 folio, start, end);
> -out:
> -	if (ret > 0)
> -		*_start =3D start + ret;
> -	_leave(" =3D %zd [%llx]", ret, *_start);
> -	return ret;
> -}
> -
> -/*
> - * Write a region of pages back to the server
> - */
> -static int netfs_writepages_region(struct address_space *mapping,
> -				   struct writeback_control *wbc,
> -				   struct netfs_group *group,
> -				   unsigned long long *_start,
> -				   unsigned long long end)
> -{
> -	ssize_t ret;
> -
> -	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
> -
> -	do {
> -		ret =3D netfs_writepages_begin(mapping, wbc, group, &xas,
> -					     _start, end);
> -		if (ret > 0 && wbc->nr_to_write > 0)
> -			cond_resched();
> -	} while (ret > 0 && wbc->nr_to_write > 0);
> -
> -	return ret > 0 ? 0 : ret;
> -}
> -
> -/*
> - * write some of the pending data back to the server
> - */
> -int netfs_writepages(struct address_space *mapping,
> -		     struct writeback_control *wbc)
> -{
> -	struct netfs_group *group =3D NULL;
> -	loff_t start, end;
> -	int ret;
> -
> -	_enter("");
> -
> -	/* We have to be careful as we can end up racing with setattr()
> -	 * truncating the pagecache since the caller doesn't take a lock here
> -	 * to prevent it.
> -	 */
> -
> -	if (wbc->range_cyclic && mapping->writeback_index) {
> -		start =3D mapping->writeback_index * PAGE_SIZE;
> -		ret =3D netfs_writepages_region(mapping, wbc, group,
> -					      &start, LLONG_MAX);
> -		if (ret < 0)
> -			goto out;
> -
> -		if (wbc->nr_to_write <=3D 0) {
> -			mapping->writeback_index =3D start / PAGE_SIZE;
> -			goto out;
> -		}
> -
> -		start =3D 0;
> -		end =3D mapping->writeback_index * PAGE_SIZE;
> -		mapping->writeback_index =3D 0;
> -		ret =3D netfs_writepages_region(mapping, wbc, group, &start, end);
> -		if (ret =3D=3D 0)
> -			mapping->writeback_index =3D start / PAGE_SIZE;
> -	} else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLONG_MAX=
) {
> -		start =3D 0;
> -		ret =3D netfs_writepages_region(mapping, wbc, group,
> -					      &start, LLONG_MAX);
> -		if (wbc->nr_to_write > 0 && ret =3D=3D 0)
> -			mapping->writeback_index =3D start / PAGE_SIZE;
> -	} else {
> -		start =3D wbc->range_start;
> -		ret =3D netfs_writepages_region(mapping, wbc, group,
> -					      &start, wbc->range_end);
> -	}
> -
> -out:
> -	_leave(" =3D %d", ret);
> -	return ret;
> -}
> -EXPORT_SYMBOL(netfs_writepages);
> -#endif
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 330ba7cb3f10..e4a9cf7cd234 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -37,7 +37,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struc=
t kiocb *iocb, struct iov
>  	size_t len =3D iov_iter_count(iter);
>  	bool async =3D !is_sync_kiocb(iocb);
> =20
> -	_enter("");
> +	_enter("%lx", iov_iter_count(iter));
> =20
>  	/* We're going to need a bounce buffer if what we transmit is going to
>  	 * be different in some way to the source buffer, e.g. because it gets
> diff --git a/fs/netfs/output.c b/fs/netfs/output.c
> deleted file mode 100644
> index 85374322f10f..000000000000
> --- a/fs/netfs/output.c
> +++ /dev/null
> @@ -1,477 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Network filesystem high-level write support.
> - *
> - * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
> - * Written by David Howells (dhowells@redhat.com)
> - */
> -
> -#include <linux/fs.h>
> -#include <linux/mm.h>
> -#include <linux/pagemap.h>
> -#include <linux/slab.h>
> -#include <linux/writeback.h>
> -#include <linux/pagevec.h>
> -#include "internal.h"
> -
> -/**
> - * netfs_create_write_request - Create a write operation.
> - * @wreq: The write request this is storing from.
> - * @dest: The destination type
> - * @start: Start of the region this write will modify
> - * @len: Length of the modification
> - * @worker: The worker function to handle the write(s)
> - *
> - * Allocate a write operation, set it up and add it to the list on a wri=
te
> - * request.
> - */
> -struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_r=
equest *wreq,
> -						       enum netfs_io_source dest,
> -						       loff_t start, size_t len,
> -						       work_func_t worker)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	subreq =3D netfs_alloc_subrequest(wreq);
> -	if (subreq) {
> -		INIT_WORK(&subreq->work, worker);
> -		subreq->source	=3D dest;
> -		subreq->start	=3D start;
> -		subreq->len	=3D len;
> -
> -		switch (subreq->source) {
> -		case NETFS_UPLOAD_TO_SERVER:
> -			netfs_stat(&netfs_n_wh_upload);
> -			break;
> -		case NETFS_WRITE_TO_CACHE:
> -			netfs_stat(&netfs_n_wh_write);
> -			break;
> -		default:
> -			BUG();
> -		}
> -
> -		subreq->io_iter =3D wreq->io_iter;
> -		iov_iter_advance(&subreq->io_iter, subreq->start - wreq->start);
> -		iov_iter_truncate(&subreq->io_iter, subreq->len);
> -
> -		trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
> -				     refcount_read(&subreq->ref),
> -				     netfs_sreq_trace_new);
> -		atomic_inc(&wreq->nr_outstanding);
> -		list_add_tail(&subreq->rreq_link, &wreq->subrequests);
> -		trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
> -	}
> -
> -	return subreq;
> -}
> -EXPORT_SYMBOL(netfs_create_write_request);
> -
> -/*
> - * Process a completed write request once all the component operations h=
ave
> - * been completed.
> - */
> -static void netfs_write_terminated(struct netfs_io_request *wreq, bool w=
as_async)
> -{
> -	struct netfs_io_subrequest *subreq;
> -	struct netfs_inode *ctx =3D netfs_inode(wreq->inode);
> -	size_t transferred =3D 0;
> -
> -	_enter("R=3D%x[]", wreq->debug_id);
> -
> -	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
> -
> -	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
> -		if (subreq->error || subreq->transferred =3D=3D 0)
> -			break;
> -		transferred +=3D subreq->transferred;
> -		if (subreq->transferred < subreq->len)
> -			break;
> -	}
> -	wreq->transferred =3D transferred;
> -
> -	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
> -		if (!subreq->error)
> -			continue;
> -		switch (subreq->source) {
> -		case NETFS_UPLOAD_TO_SERVER:
> -			/* Depending on the type of failure, this may prevent
> -			 * writeback completion unless we're in disconnected
> -			 * mode.
> -			 */
> -			if (!wreq->error)
> -				wreq->error =3D subreq->error;
> -			break;
> -
> -		case NETFS_WRITE_TO_CACHE:
> -			/* Failure doesn't prevent writeback completion unless
> -			 * we're in disconnected mode.
> -			 */
> -			if (subreq->error !=3D -ENOBUFS)
> -				ctx->ops->invalidate_cache(wreq);
> -			break;
> -
> -		default:
> -			WARN_ON_ONCE(1);
> -			if (!wreq->error)
> -				wreq->error =3D -EIO;
> -			return;
> -		}
> -	}
> -
> -	wreq->cleanup(wreq);
> -
> -	if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
> -	    wreq->mapping->nrpages) {
> -		pgoff_t first =3D wreq->start >> PAGE_SHIFT;
> -		pgoff_t last =3D (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
> -		invalidate_inode_pages2_range(wreq->mapping, first, last);
> -	}
> -
> -	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
> -		inode_dio_end(wreq->inode);
> -
> -	_debug("finished");
> -	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
> -	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
> -	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
> -
> -	if (wreq->iocb) {
> -		wreq->iocb->ki_pos +=3D transferred;
> -		if (wreq->iocb->ki_complete)
> -			wreq->iocb->ki_complete(
> -				wreq->iocb, wreq->error ? wreq->error : transferred);
> -	}
> -
> -	netfs_clear_subrequests(wreq, was_async);
> -	netfs_put_request(wreq, was_async, netfs_rreq_trace_put_complete);
> -}
> -
> -/*
> - * Deal with the completion of writing the data to the cache.
> - */
> -void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or=
_error,
> -				       bool was_async)
> -{
> -	struct netfs_io_subrequest *subreq =3D _op;
> -	struct netfs_io_request *wreq =3D subreq->rreq;
> -	unsigned int u;
> -
> -	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_o=
r_error);
> -
> -	switch (subreq->source) {
> -	case NETFS_UPLOAD_TO_SERVER:
> -		netfs_stat(&netfs_n_wh_upload_done);
> -		break;
> -	case NETFS_WRITE_TO_CACHE:
> -		netfs_stat(&netfs_n_wh_write_done);
> -		break;
> -	case NETFS_INVALID_WRITE:
> -		break;
> -	default:
> -		BUG();
> -	}
> -
> -	if (IS_ERR_VALUE(transferred_or_error)) {
> -		subreq->error =3D transferred_or_error;
> -		trace_netfs_failure(wreq, subreq, transferred_or_error,
> -				    netfs_fail_write);
> -		goto failed;
> -	}
> -
> -	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
> -		 "Subreq excess write: R%x[%x] %zd > %zu - %zu",
> -		 wreq->debug_id, subreq->debug_index,
> -		 transferred_or_error, subreq->len, subreq->transferred))
> -		transferred_or_error =3D subreq->len - subreq->transferred;
> -
> -	subreq->error =3D 0;
> -	subreq->transferred +=3D transferred_or_error;
> -
> -	if (iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->transfe=
rred)
> -		pr_warn("R=3D%08x[%u] ITER POST-MISMATCH %zx !=3D %zx-%zx %x\n",
> -			wreq->debug_id, subreq->debug_index,
> -			iov_iter_count(&subreq->io_iter), subreq->len,
> -			subreq->transferred, subreq->io_iter.iter_type);
> -
> -	if (subreq->transferred < subreq->len)
> -		goto incomplete;
> -
> -	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> -out:
> -	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
> -
> -	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
> -	u =3D atomic_dec_return(&wreq->nr_outstanding);
> -	if (u =3D=3D 0)
> -		netfs_write_terminated(wreq, was_async);
> -	else if (u =3D=3D 1)
> -		wake_up_var(&wreq->nr_outstanding);
> -
> -	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated=
);
> -	return;
> -
> -incomplete:
> -	if (transferred_or_error =3D=3D 0) {
> -		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
> -			subreq->error =3D -ENODATA;
> -			goto failed;
> -		}
> -	} else {
> -		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> -	}
> -
> -	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
> -	set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
> -	goto out;
> -
> -failed:
> -	switch (subreq->source) {
> -	case NETFS_WRITE_TO_CACHE:
> -		netfs_stat(&netfs_n_wh_write_failed);
> -		set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
> -		break;
> -	case NETFS_UPLOAD_TO_SERVER:
> -		netfs_stat(&netfs_n_wh_upload_failed);
> -		set_bit(NETFS_RREQ_FAILED, &wreq->flags);
> -		wreq->error =3D subreq->error;
> -		break;
> -	default:
> -		break;
> -	}
> -	goto out;
> -}
> -EXPORT_SYMBOL(netfs_write_subrequest_terminated);
> -
> -static void netfs_write_to_cache_op(struct netfs_io_subrequest *subreq)
> -{
> -	struct netfs_io_request *wreq =3D subreq->rreq;
> -	struct netfs_cache_resources *cres =3D &wreq->cache_resources;
> -
> -	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> -
> -	cres->ops->write(cres, subreq->start, &subreq->io_iter,
> -			 netfs_write_subrequest_terminated, subreq);
> -}
> -
> -static void netfs_write_to_cache_op_worker(struct work_struct *work)
> -{
> -	struct netfs_io_subrequest *subreq =3D
> -		container_of(work, struct netfs_io_subrequest, work);
> -
> -	netfs_write_to_cache_op(subreq);
> -}
> -
> -/**
> - * netfs_queue_write_request - Queue a write request for attention
> - * @subreq: The write request to be queued
> - *
> - * Queue the specified write request for processing by a worker thread. =
 We
> - * pass the caller's ref on the request to the worker thread.
> - */
> -void netfs_queue_write_request(struct netfs_io_subrequest *subreq)
> -{
> -	if (!queue_work(system_unbound_wq, &subreq->work))
> -		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_wip);
> -}
> -EXPORT_SYMBOL(netfs_queue_write_request);
> -
> -/*
> - * Set up a op for writing to the cache.
> - */
> -static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
> -{
> -	struct netfs_cache_resources *cres =3D &wreq->cache_resources;
> -	struct netfs_io_subrequest *subreq;
> -	struct netfs_inode *ctx =3D netfs_inode(wreq->inode);
> -	struct fscache_cookie *cookie =3D netfs_i_cookie(ctx);
> -	loff_t start =3D wreq->start;
> -	size_t len =3D wreq->len;
> -	int ret;
> -
> -	if (!fscache_cookie_enabled(cookie)) {
> -		clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags);
> -		return;
> -	}
> -
> -	_debug("write to cache");
> -	ret =3D fscache_begin_write_operation(cres, cookie);
> -	if (ret < 0)
> -		return;
> -
> -	ret =3D cres->ops->prepare_write(cres, &start, &len, wreq->upper_len,
> -				       i_size_read(wreq->inode), true);
> -	if (ret < 0)
> -		return;
> -
> -	subreq =3D netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start=
, len,
> -					    netfs_write_to_cache_op_worker);
> -	if (!subreq)
> -		return;
> -
> -	netfs_write_to_cache_op(subreq);
> -}
> -
> -/*
> - * Begin the process of writing out a chunk of data.
> - *
> - * We are given a write request that holds a series of dirty regions and
> - * (partially) covers a sequence of folios, all of which are present.  T=
he
> - * pages must have been marked as writeback as appropriate.
> - *
> - * We need to perform the following steps:
> - *
> - * (1) If encrypting, create an output buffer and encrypt each block of =
the
> - *     data into it, otherwise the output buffer will point to the origi=
nal
> - *     folios.
> - *
> - * (2) If the data is to be cached, set up a write op for the entire out=
put
> - *     buffer to the cache, if the cache wants to accept it.
> - *
> - * (3) If the data is to be uploaded (ie. not merely cached):
> - *
> - *     (a) If the data is to be compressed, create a compression buffer =
and
> - *         compress the data into it.
> - *
> - *     (b) For each destination we want to upload to, set up write ops t=
o write
> - *         to that destination.  We may need multiple writes if the data=
 is not
> - *         contiguous or the span exceeds wsize for a server.
> - */
> -int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
> -		      enum netfs_write_trace what)
> -{
> -	struct netfs_inode *ctx =3D netfs_inode(wreq->inode);
> -
> -	_enter("R=3D%x %llx-%llx f=3D%lx",
> -	       wreq->debug_id, wreq->start, wreq->start + wreq->len - 1,
> -	       wreq->flags);
> -
> -	trace_netfs_write(wreq, what);
> -	if (wreq->len =3D=3D 0 || wreq->iter.count =3D=3D 0) {
> -		pr_err("Zero-sized write [R=3D%x]\n", wreq->debug_id);
> -		return -EIO;
> -	}
> -
> -	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
> -		inode_dio_begin(wreq->inode);
> -
> -	wreq->io_iter =3D wreq->iter;
> -
> -	/* ->outstanding > 0 carries a ref */
> -	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
> -	atomic_set(&wreq->nr_outstanding, 1);
> -
> -	/* Start the encryption/compression going.  We can do that in the
> -	 * background whilst we generate a list of write ops that we want to
> -	 * perform.
> -	 */
> -	// TODO: Encrypt or compress the region as appropriate
> -
> -	/* We need to write all of the region to the cache */
> -	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
> -		netfs_set_up_write_to_cache(wreq);
> -
> -	/* However, we don't necessarily write all of the region to the server.
> -	 * Caching of reads is being managed this way also.
> -	 */
> -	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
> -		ctx->ops->create_write_requests(wreq, wreq->start, wreq->len);
> -
> -	if (atomic_dec_and_test(&wreq->nr_outstanding))
> -		netfs_write_terminated(wreq, false);
> -
> -	if (!may_wait)
> -		return -EIOCBQUEUED;
> -
> -	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> -		    TASK_UNINTERRUPTIBLE);
> -	return wreq->error;
> -}
> -
> -/*
> - * Begin a write operation for writing through the pagecache.
> - */
> -struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, si=
ze_t len)
> -{
> -	struct netfs_io_request *wreq;
> -	struct file *file =3D iocb->ki_filp;
> -
> -	wreq =3D netfs_alloc_request(file->f_mapping, file, iocb->ki_pos, len,
> -				   NETFS_WRITETHROUGH);
> -	if (IS_ERR(wreq))
> -		return wreq;
> -
> -	trace_netfs_write(wreq, netfs_write_trace_writethrough);
> -
> -	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
> -	iov_iter_xarray(&wreq->iter, ITER_SOURCE, &wreq->mapping->i_pages, wreq=
->start, 0);
> -	wreq->io_iter =3D wreq->iter;
> -
> -	/* ->outstanding > 0 carries a ref */
> -	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
> -	atomic_set(&wreq->nr_outstanding, 1);
> -	return wreq;
> -}
> -
> -static void netfs_submit_writethrough(struct netfs_io_request *wreq, boo=
l final)
> -{
> -	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
> -	unsigned long long start;
> -	size_t len;
> -
> -	if (!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
> -		return;
> -
> -	start =3D wreq->start + wreq->submitted;
> -	len =3D wreq->iter.count - wreq->submitted;
> -	if (!final) {
> -		len /=3D wreq->wsize; /* Round to number of maximum packets */
> -		len *=3D wreq->wsize;
> -	}
> -
> -	ictx->ops->create_write_requests(wreq, start, len);
> -	wreq->submitted +=3D len;
> -}
> -
> -/*
> - * Advance the state of the write operation used when writing through th=
e
> - * pagecache.  Data has been copied into the pagecache that we need to a=
ppend
> - * to the request.  If we've added more than wsize then we need to creat=
e a new
> - * subrequest.
> - */
> -int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t cop=
ied, bool to_page_end)
> -{
> -	_enter("ic=3D%zu sb=3D%llu ws=3D%u cp=3D%zu tp=3D%u",
> -	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_=
end);
> -
> -	wreq->iter.count +=3D copied;
> -	wreq->io_iter.count +=3D copied;
> -	if (to_page_end && wreq->io_iter.count - wreq->submitted >=3D wreq->wsi=
ze)
> -		netfs_submit_writethrough(wreq, false);
> -
> -	return wreq->error;
> -}
> -
> -/*
> - * End a write operation used when writing through the pagecache.
> - */
> -int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *=
iocb)
> -{
> -	int ret =3D -EIOCBQUEUED;
> -
> -	_enter("ic=3D%zu sb=3D%llu ws=3D%u",
> -	       wreq->iter.count, wreq->submitted, wreq->wsize);
> -
> -	if (wreq->submitted < wreq->io_iter.count)
> -		netfs_submit_writethrough(wreq, true);
> -
> -	if (atomic_dec_and_test(&wreq->nr_outstanding))
> -		netfs_write_terminated(wreq, false);
> -
> -	if (is_sync_kiocb(iocb)) {
> -		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> -			    TASK_UNINTERRUPTIBLE);
> -		ret =3D wreq->error;
> -	}
> -
> -	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
> -	return ret;
> -}
>=20

--=20
Jeff Layton <jlayton@kernel.org>

