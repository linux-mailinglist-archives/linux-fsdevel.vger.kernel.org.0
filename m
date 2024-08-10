Return-Path: <linux-fsdevel+bounces-25582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B773394DA56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7C71C21722
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 03:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0C13AA35;
	Sat, 10 Aug 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="WkNdRh3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2C130499;
	Sat, 10 Aug 2024 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261409; cv=none; b=sJ/ixwM9dBlUIhVFT/oGjlTXU9EUnx09rCzcMYvHpJS+OgxCZgQ63MzFQ3+wIvIo2X8lDz3SQbcr6i974WSWrW2/aiYQYyTtTL8eekNEfTbtF9NVBRG1S/xz/gBYltzXhPP2aE7MLsCbK3MGbAWqADlTqynKzrc19tdevOnfqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261409; c=relaxed/simple;
	bh=Dz5ljV4C748Y92oEca2eVRU5aSIzT2ITH61W5Nh4i/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFQ4/4KLK3S9x214cPErrkpHQgd6M1AacjecwDcGVK++Gy+zSJ0JnSA9pwmnh1KdA74OEPhuEijUMZQWkKbU/ForafzjNHWxoA7ccwI+3ErcdU36zLt/gtC2mGqSxxnNUtH5pQb/k/K53NwxKQRmYalXMYAH5AiCOncUa4p77W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=WkNdRh3F; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AFD2D14C1E1;
	Sat, 10 Aug 2024 05:36:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1723261020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXmz9TkuAk5dB9bidybN3xvJsbLPHMH9nJKkDG6YnBg=;
	b=WkNdRh3FW+h436ZD2wTCZZcior92lVbGevCb3rRz0k936m8bvJstFVmU4VZF7o9JwI9NAw
	FPctBPVQbGGS0wly8cI+p8y4LPuoeqZv+2HMro9sAZW8Nc6Od7ogMoRxhPEUkzEmpsXLeh
	ciryvAC9PLG7ZMsdIovM1qB2WNPnywMqie/hpEceQiSL3HzvXNm+3C4Y+uk3jJGpxcDj6V
	8utSUf51piAQUGusY6ERcYSrShyvksEzxMGkkybbHuEcPVxCIzosllf7i/ec6ygZcKUzma
	UYWJ8ldN6E4J2UEG9GFyHn0A08v50UG+tspHpnu3iOG2FnjUM91DKDsXe8JKbQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1dc60f99;
	Sat, 10 Aug 2024 03:36:53 +0000 (UTC)
Date: Sat, 10 Aug 2024 12:36:38 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Fix DIO read through netfs
Message-ID: <ZrbgRnXV-snNicjY@codewreck.org>
References: <1229195.1723211769@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1229195.1723211769@warthog.procyon.org.uk>

David Howells wrote on Fri, Aug 09, 2024 at 02:56:09PM +0100:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> 9p: Fix DIO read through netfs

nitpick: now sure how that ended up here but this is duplicated with the
subject (the commit message ends up with this line twice)

> If a program is watching a file on a 9p mount, it won't see any change in
> size if the file being exported by the server is changed directly in the
> source filesystem, presumably because 9p doesn't have change notifications,
> and because netfs skips the reads if the file is empty.
> 
> Fix this by attempting to read the full size specified when a DIO read is
> requested (such as when 9p is operating in unbuffered mode) and dealing
> with a short read if the EOF was less than the expected read.
> 
> To make this work, filesystems using netfslib must not set
> NETFS_SREQ_CLEAR_TAIL if performing a DIO read where that read hit the EOF.
> I don't want to mandatorily clear this flag in netfslib for DIO because,
> say, ceph might make a read from an object that is not completely filled,
> but does not reside at the end of file - and so we need to clear the
> excess.
> 
> This can be tested by watching an empty file over 9p within a VM (such as
> in the ktest framework):
> 
>         while true; do read content; if [ -n "$content" ]; then echo $content; break; fi; done < /host/tmp/foo

(This is basically the same thing but if one wants to control the read
timing for more precise/verbose debugging:
  exec 3< /host/tmp/foo
  read -u 3 content && echo $content
  (repeat as appropriate)
  exec 3>&-
)

> then writing something into the empty file.  The watcher should immediately
> display the file content and break out of the loop.  Without this fix, it
> remains in the loop indefinitely.
> 
> Fixes: 80105ed2fd27 ("9p: Use netfslib read/write_iter")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218916
> Written-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks for adding extra comments & fixing other filesystems.

I've checked this covers all cases of setting NETFS_SREQ_CLEAR_TAIL so
hopefully shouldn't have further side effects, this sounds good to me:

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: ceph-devel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/9p/vfs_addr.c     |    3 ++-
>  fs/afs/file.c        |    3 ++-
>  fs/ceph/addr.c       |    6 ++++--
>  fs/netfs/io.c        |   17 +++++++++++------
>  fs/nfs/fscache.c     |    3 ++-
>  fs/smb/client/file.c |    3 ++-
>  6 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index a97ceb105cd8..24fdc74caeba 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -75,7 +75,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  
>  	/* if we just extended the file size, any portion not in
>  	 * cache won't be on server and is zeroes */
> -	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +	if (subreq->rreq->origin != NETFS_DIO_READ)
> +		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
>  
>  	netfs_subreq_terminated(subreq, err ?: total, false);
>  }
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index c3f0c45ae9a9..ec1be0091fdb 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -242,7 +242,8 @@ static void afs_fetch_data_notify(struct afs_operation *op)
>  
>  	req->error = error;
>  	if (subreq) {
> -		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +		if (subreq->rreq->origin != NETFS_DIO_READ)
> +			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
>  		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
>  		req->subreq = NULL;
>  	} else if (req->done) {
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index cc0a2240de98..c4744a02db75 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -246,7 +246,8 @@ static void finish_netfs_read(struct ceph_osd_request *req)
>  	if (err >= 0) {
>  		if (sparse && err > 0)
>  			err = ceph_sparse_ext_map_end(op);
> -		if (err < subreq->len)
> +		if (err < subreq->len &&
> +		    subreq->rreq->origin != NETFS_DIO_READ)
>  			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
>  		if (IS_ENCRYPTED(inode) && err > 0) {
>  			err = ceph_fscrypt_decrypt_extents(inode,
> @@ -282,7 +283,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
>  	size_t len;
>  	int mode;
>  
> -	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +	if (rreq->origin != NETFS_DIO_READ)
> +		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
>  	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
>  
>  	if (subreq->start >= inode->i_size)
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index c179a1c73fa7..5367caf3fa28 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -530,7 +530,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
>  
>  	if (transferred_or_error == 0) {
>  		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
> -			subreq->error = -ENODATA;
> +			if (rreq->origin != NETFS_DIO_READ)
> +				subreq->error = -ENODATA;
>  			goto failed;
>  		}
>  	} else {
> @@ -601,9 +602,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
>  			}
>  			if (subreq->len > ictx->zero_point - subreq->start)
>  				subreq->len = ictx->zero_point - subreq->start;
> +
> +			/* We limit buffered reads to the EOF, but let the
> +			 * server deal with larger-than-EOF DIO/unbuffered
> +			 * reads.
> +			 */
> +			if (subreq->len > rreq->i_size - subreq->start)
> +				subreq->len = rreq->i_size - subreq->start;
>  		}
> -		if (subreq->len > rreq->i_size - subreq->start)
> -			subreq->len = rreq->i_size - subreq->start;
>  		if (rreq->rsize && subreq->len > rreq->rsize)
>  			subreq->len = rreq->rsize;
>  
> @@ -739,11 +745,10 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
>  	do {
>  		_debug("submit %llx + %llx >= %llx",
>  		       rreq->start, rreq->submitted, rreq->i_size);
> -		if (rreq->origin == NETFS_DIO_READ &&
> -		    rreq->start + rreq->submitted >= rreq->i_size)
> -			break;
>  		if (!netfs_rreq_submit_slice(rreq, &io_iter))
>  			break;
> +		if (test_bit(NETFS_SREQ_NO_PROGRESS, &rreq->flags))
> +			break;
>  		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
>  		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
>  			break;
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index bf29a65c5027..7a558dea75c4 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -363,7 +363,8 @@ void nfs_netfs_read_completion(struct nfs_pgio_header *hdr)
>  		return;
>  
>  	sreq = netfs->sreq;
> -	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
> +	if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
> +	    sreq->rreq->origin != NETFS_DIO_READ)
>  		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
>  
>  	if (hdr->error)
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b2405dd4d4d4..3f3842e7b44a 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -217,7 +217,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
>  			goto out;
>  	}
>  
> -	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +	if (subreq->rreq->origin != NETFS_DIO_READ)
> +		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
>  
>  	rc = rdata->server->ops->async_readv(rdata);
>  out:
> 

-- 
Dominique Martinet | Asmadeus

