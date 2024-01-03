Return-Path: <linux-fsdevel+bounces-7160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A78228F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 08:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2033E1F23C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDF18053;
	Wed,  3 Jan 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uqfYW5jk";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="iB6f9a9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4A18027;
	Wed,  3 Jan 2024 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 949DBC024; Wed,  3 Jan 2024 08:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704266578; bh=RTWy0dxEMBU7YHmS1XNmpVAiFlJnmT3Et4L/I5ab7Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqfYW5jksrvCQpt8LmJKFK1pymqZvr0fNs5ydgxd2w2N26tNteDguezFaw3LkQfED
	 Od1VIvgXutsA2AVW1awCGx02d+AvSNb4MsEKSO1LNMXRmsHTE8D41hpRiY1Bq7VWkb
	 G3fWDnF6wXkcat124kAGZSyc7CSlL+njN5wcHTn0LsJ0dyUwiu2DgCzx299JrJDPV3
	 z5cdKETVKuLEDbcIHmo/e8w4ixRV/xmfMU3NxaoDk+OinUwFQLzwBpwjpg+vp/YDpT
	 MsY3+X94WUWTIU6FQJF2s67pZbV3ILyoKWgqKSvXIUH9T2Ik2Dkmnm+ZW6sfusa3Z2
	 rc6ojAzLEkhBw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id E31CAC009;
	Wed,  3 Jan 2024 08:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704266574; bh=RTWy0dxEMBU7YHmS1XNmpVAiFlJnmT3Et4L/I5ab7Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iB6f9a9XtKFd8Mc6VqzCmgyJhSyuMHEer6dsobANqz894EpDs8i0AQIcPKF+2fVvG
	 jlyJVUQYmDp/W0iu/EQsl4XwbetIzk5mwbFBiXBlu/ggfUJcirHhYjssuvmdY4uE21
	 LtD0O2UioQdUpg5rJrQgdUE8fbHLM4fPus8A4SubgvfihFttaA1h7XEtc/TQ+wxQdz
	 U/2ehe2gJNG8zWaOv8jS1Qd5NdDwIFiasvGLB8n/7dwEmGytLmRvxs2ZklbFS59ZhZ
	 Y+dXCw+KunEC0DBMhVJnfjSd2W011G0n6+S3zqpRvtMEq9lAzk5bULE4EZQi6D9Zz+
	 osuS+JtBTxf5A==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id f52185ec;
	Wed, 3 Jan 2024 07:22:44 +0000 (UTC)
Date: Wed, 3 Jan 2024 16:22:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZZULNQAZ0n0WQv7p@codewreck.org>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-41-dhowells@redhat.com>

David Howells wrote on Thu, Dec 21, 2023 at 01:23:35PM +0000:
> Use netfslib's read and write iteration helpers, allowing netfslib to take
> over the management of the page cache for 9p files and to manage local disk
> caching.  In particular, this eliminates write_begin, write_end, writepage
> and all mentions of struct page and struct folio from 9p.
> 
> Note that netfslib now offers the possibility of write-through caching if
> that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> v9inode->netfs.flags in v9fs_set_netfs_context().
> 
> Note also this is untested as I can't get ganesha.nfsd to correctly parse
> the config to turn on 9p support.

(that's appparently no longer true and might need updating)


> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>

At quite high level, I've played with this a bit and see no obvious
regression with the extra patch

I've also manually confirmed one of the big improvements I'd been asking
for (that writes in cached modes, which used to be chunked to 4k, and
are now properly aggregated, so e.g 'dd bs=1M count=1' will properly
issue a minimal number of TWRITE calls capped by msize) -- this is
great!

I've noticed we don't cache xattrs are all, so with the default mount
options on a kernel built with 9P_FS_SECURITY we'll get a gazillion
lookups for security.capabilities... But that's another problem, and
this is still an improvement so no reason to hold back.

I've got a couple of questions below, but:

Tested-by: Dominique Martinet <asmadeus@codewreck.org>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>


(I'd still be extremly thanksful if Christian and/or Eric would have
time to check as well, but I won't push back to merging it this merge
window next week if they don't have time... I'll also keep trying to run
some more tests as time allows)

> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: v9fs@lists.linux.dev
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
> Notes:
>     Changes
>     =======
>     ver #5)
>      - Added some missing remote_i_size setting.
>      - Added missing writepages (else mmap write never written back).
> 
>  fs/9p/vfs_addr.c       | 293 ++++++++++-------------------------------
>  fs/9p/vfs_file.c       |  89 ++-----------
>  fs/9p/vfs_inode.c      |   5 +-
>  fs/9p/vfs_inode_dotl.c |   7 +-
>  4 files changed, 85 insertions(+), 309 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 055b672a247d..20f072c18ce9 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -19,12 +19,48 @@
>  #include <linux/netfs.h>
>  #include <net/9p/9p.h>
>  #include <net/9p/client.h>
> +#include <trace/events/netfs.h>
>  
>  #include "v9fs.h"
>  #include "v9fs_vfs.h"
>  #include "cache.h"
>  #include "fid.h"
>  
> +static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
> +{
> +	struct inode *inode = subreq->rreq->inode;
> +	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);

Any reason to have this variable assignment at all?
(I assume it'll get optimized away, but it looks like that's not a maybe
here so was a bit surprised -- I guess it's just been copy-pasted from
the old code getting the fscache cookie?)

> +	struct p9_fid *fid = subreq->rreq->netfs_priv;
> +	int err;
> +
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> +	p9_client_write(fid, subreq->start, &subreq->io_iter, &err);

p9_client_write return value should always be subreq->len, but I believe
we should use it unless err is set.
(It's also possible for partial writes to happen, e.g. p9_client_write
looped a few times and then failed, at which point the size returned
would be the amount that actually got through -- we probably should do
something with that?)

> +	netfs_write_subrequest_terminated(subreq, err < 0 ? err : subreq->len,
> +					  false);
> +}
> +
> +static void v9fs_upload_to_server_worker(struct work_struct *work)
> +{
> +	struct netfs_io_subrequest *subreq =
> +		container_of(work, struct netfs_io_subrequest, work);
> +
> +	v9fs_upload_to_server(subreq);
> +}
> +
> +/*
> + * Set up write requests for a writeback slice.  We need to add a write request
> + * for each write we want to make.
> + */
> +static void v9fs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
> +					    start, len, v9fs_upload_to_server_worker);
> +	if (subreq)
> +		netfs_queue_write_request(subreq);
> +}
> +
>  /**
>   * v9fs_issue_read - Issue a read from 9P
>   * @subreq: The read to make
> @@ -33,14 +69,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  {
>  	struct netfs_io_request *rreq = subreq->rreq;
>  	struct p9_fid *fid = rreq->netfs_priv;
> -	struct iov_iter to;
> -	loff_t pos = subreq->start + subreq->transferred;
> -	size_t len = subreq->len   - subreq->transferred;
>  	int total, err;
>  
> -	iov_iter_xarray(&to, ITER_DEST, &rreq->mapping->i_pages, pos, len);
> -
> -	total = p9_client_read(fid, pos, &to, &err);
> +	total = p9_client_read(fid, subreq->start + subreq->transferred,
> +			       &subreq->io_iter, &err);

Just to clarify: subreq->io_iter didn't exist (or some conditions to use
it weren't cleared) before?

>  
>  	/* if we just extended the file size, any portion not in
>  	 * cache won't be on server and is zeroes */
> @@ -50,23 +82,37 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  }
>  
>  /**
> - * v9fs_init_request - Initialise a read request
> + * v9fs_init_request - Initialise a request
>   * @rreq: The read request
>   * @file: The file being read from
>   */
>  static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
>  {
> -	struct p9_fid *fid = file->private_data;
> -
> -	BUG_ON(!fid);
> +	struct p9_fid *fid;
> +	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
> +			rreq->origin == NETFS_WRITEBACK ||
> +			rreq->origin == NETFS_WRITETHROUGH ||
> +			rreq->origin == NETFS_LAUNDER_WRITE ||
> +			rreq->origin == NETFS_UNBUFFERED_WRITE ||
> +			rreq->origin == NETFS_DIO_WRITE);
> +
> +	if (file) {
> +		fid = file->private_data;
> +		BUG_ON(!fid);

This probably should be WARN + return EINVAL like find by inode?
It's certainly a huge problem, but we should avoid BUG if possible...

> +		p9_fid_get(fid);
> +	} else {
> +		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
> +		if (!fid) {
> +			WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
> +				  rreq->inode->i_private);

nit: not sure what's cleaner?
Since there's a message that makes for a bit awkward if...

if (WARN_ONCE(!fid, "folio expected an open fid inode->i_private=%p\n",
	      rreq->inode->i_private))
	return -EINVAL;

(as a side note, I'm not sure what to make of this i_private pointer
here, but if that'll help you figure something out sure..)

> +			return -EINVAL;
> +		}
> +	}
>  
>  	/* we might need to read from a fid that was opened write-only
>  	 * for read-modify-write of page cache, use the writeback fid
>  	 * for that */
> -	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
> -			!(fid->mode & P9_ORDWR));
> -
> -	p9_fid_get(fid);
> +	WARN_ON(writing && !(fid->mode & P9_ORDWR));

This is as follow on your netfs-lib branch:
-       WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
-                       !(fid->mode & P9_ORDWR));
-
-       p9_fid_get(fid);
+       WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE && !(fid->mode & P9_ORDWR));

So the WARN_ON has been reverted back with only indentation changed;
I guess there were patterns that were writing despite the fid not having
been open as RDWR?
Do you still have details about these?

If a file has been open without the write bit it might not go through,
and it's incredibly difficult to get such users back to userspace in
async cases (e.g. mmap flushes), so would like to understand that.

>  	rreq->netfs_priv = fid;
>  	return 0;
>  }
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 11cd8d23f6f2..bae330c2f0cf 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -353,25 +353,15 @@ static ssize_t
>  v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct p9_fid *fid = iocb->ki_filp->private_data;
> -	int ret, err = 0;
>  
>  	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
>  		 fid->fid, iov_iter_count(to), iocb->ki_pos);
>  
> -	if (!(fid->mode & P9L_DIRECT)) {
> -		p9_debug(P9_DEBUG_VFS, "(cached)\n");
> -		return generic_file_read_iter(iocb, to);
> -	}
> -
> -	if (iocb->ki_filp->f_flags & O_NONBLOCK)
> -		ret = p9_client_read_once(fid, iocb->ki_pos, to, &err);
> -	else
> -		ret = p9_client_read(fid, iocb->ki_pos, to, &err);
> -	if (!ret)
> -		return err;
> +	if (fid->mode & P9L_DIRECT)
> +		return netfs_unbuffered_read_iter(iocb, to);
>  
> -	iocb->ki_pos += ret;
> -	return ret;
> +	p9_debug(P9_DEBUG_VFS, "(cached)\n");

(Not a new problem so no need to address here, but having just
"(cached)" on a split line is a bit weird.. We first compute cached or
not as a bool and make it %s + cached ? " (cached)" : "" or
something... I'll send a patch after this gets in to avoid conflicts)

> +	return netfs_file_read_iter(iocb, to);
>  }
>  
>  /*
> @@ -407,46 +397,14 @@ v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct p9_fid *fid = file->private_data;
> -	ssize_t retval;
> -	loff_t origin;
> -	int err = 0;
>  
>  	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
>  
> -	if (!(fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))) {
> -		p9_debug(P9_DEBUG_CACHE, "(cached)\n");
> -		return generic_file_write_iter(iocb, from);
> -	}
> +	if (fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))
> +		return netfs_unbuffered_write_iter(iocb, from);
>  
> -	retval = generic_write_checks(iocb, from);
> -	if (retval <= 0)
> -		return retval;
> -
> -	origin = iocb->ki_pos;
> -	retval = p9_client_write(file->private_data, iocb->ki_pos, from, &err);
> -	if (retval > 0) {
> -		struct inode *inode = file_inode(file);
> -		loff_t i_size;
> -		unsigned long pg_start, pg_end;
> -
> -		pg_start = origin >> PAGE_SHIFT;
> -		pg_end = (origin + retval - 1) >> PAGE_SHIFT;
> -		if (inode->i_mapping && inode->i_mapping->nrpages)
> -			invalidate_inode_pages2_range(inode->i_mapping,
> -						      pg_start, pg_end);
> -		iocb->ki_pos += retval;
> -		i_size = i_size_read(inode);
> -		if (iocb->ki_pos > i_size) {
> -			inode_add_bytes(inode, iocb->ki_pos - i_size);
> -			/*
> -			 * Need to serialize against i_size_write() in
> -			 * v9fs_stat2inode()
> -			 */
> -			v9fs_i_size_write(inode, iocb->ki_pos);
> -		}
> -		return retval;
> -	}
> -	return err;
> +	p9_debug(P9_DEBUG_CACHE, "(cached)\n");
> +	return netfs_file_write_iter(iocb, from);
>  }
>  
>  static int v9fs_file_fsync(struct file *filp, loff_t start, loff_t end,
> @@ -519,36 +477,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
>  static vm_fault_t
>  v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>  {
> -	struct folio *folio = page_folio(vmf->page);
> -	struct file *filp = vmf->vma->vm_file;
> -	struct inode *inode = file_inode(filp);
> -
> -
> -	p9_debug(P9_DEBUG_VFS, "folio %p fid %lx\n",
> -		 folio, (unsigned long)filp->private_data);
> -
> -	/* Wait for the page to be written to the cache before we allow it to
> -	 * be modified.  We then assume the entire page will need writing back.
> -	 */
> -#ifdef CONFIG_9P_FSCACHE
> -	if (folio_test_fscache(folio) &&
> -	    folio_wait_fscache_killable(folio) < 0)
> -		return VM_FAULT_NOPAGE;
> -#endif
> -
> -	/* Update file times before taking page lock */
> -	file_update_time(filp);
> -
> -	if (folio_lock_killable(folio) < 0)
> -		return VM_FAULT_RETRY;
> -	if (folio_mapping(folio) != inode->i_mapping)
> -		goto out_unlock;
> -	folio_wait_stable(folio);
> -
> -	return VM_FAULT_LOCKED;
> -out_unlock:
> -	folio_unlock(folio);
> -	return VM_FAULT_NOPAGE;
> +	return netfs_page_mkwrite(vmf, NULL);

(I guess there's no helper that could be used directly in .page_mkwrite
op?)

>  }
>  
>  static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 74122540e00f..55345753ae8d 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -374,10 +374,8 @@ void v9fs_evict_inode(struct inode *inode)
>  
>  	truncate_inode_pages_final(&inode->i_data);
>  
> -#ifdef CONFIG_9P_FSCACHE
>  	version = cpu_to_le32(v9inode->qid.version);
>  	netfs_clear_inode_writeback(inode, &version);
> -#endif
>  
>  	clear_inode(inode);
>  	filemap_fdatawrite(&inode->i_data);
> @@ -1112,7 +1110,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
>  	if ((iattr->ia_valid & ATTR_SIZE) &&
>  		 iattr->ia_size != i_size_read(inode)) {
>  		truncate_setsize(inode, iattr->ia_size);
> -		truncate_pagecache(inode, iattr->ia_size);
> +		netfs_resize_file(netfs_inode(inode), iattr->ia_size, true);
>  
>  #ifdef CONFIG_9P_FSCACHE
>  		if (v9ses->cache & CACHE_FSCACHE) {
> @@ -1180,6 +1178,7 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
>  	mode |= inode->i_mode & ~S_IALLUGO;
>  	inode->i_mode = mode;
>  
> +	v9inode->netfs.remote_i_size = stat->length;
>  	if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
>  		v9fs_i_size_write(inode, stat->length);
>  	/* not real number of blocks, but 512 byte ones ... */
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index c7319af2f471..e25fbc988f09 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -598,7 +598,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
>  	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=
>  		 i_size_read(inode)) {
>  		truncate_setsize(inode, iattr->ia_size);
> -		truncate_pagecache(inode, iattr->ia_size);
> +		netfs_resize_file(netfs_inode(inode), iattr->ia_size, true);
>  
>  #ifdef CONFIG_9P_FSCACHE
>  		if (v9ses->cache & CACHE_FSCACHE)
> @@ -655,6 +655,7 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
>  		mode |= inode->i_mode & ~S_IALLUGO;
>  		inode->i_mode = mode;
>  
> +		v9inode->netfs.remote_i_size = stat->st_size;
>  		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
>  			v9fs_i_size_write(inode, stat->st_size);
>  		inode->i_blocks = stat->st_blocks;
> @@ -683,8 +684,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
>  			inode->i_mode = mode;
>  		}
>  		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
> -		    stat->st_result_mask & P9_STATS_SIZE)
> +		    stat->st_result_mask & P9_STATS_SIZE) {
> +			v9inode->netfs.remote_i_size = stat->st_size;
>  			v9fs_i_size_write(inode, stat->st_size);
> +		}
>  		if (stat->st_result_mask & P9_STATS_BLOCKS)
>  			inode->i_blocks = stat->st_blocks;
>  	}
> 

-- 
Dominique Martinet | Asmadeus

