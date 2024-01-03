Return-Path: <linux-fsdevel+bounces-7216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D7822DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F181C213BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856B199B3;
	Wed,  3 Jan 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Hf1lP5Nh";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="4AiBjprU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17A19471;
	Wed,  3 Jan 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 09C89C026; Wed,  3 Jan 2024 14:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704286830; bh=M9MVRJ/IOq68RjnYFcSXCjl3WBemBARgVfqAaYYq2bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hf1lP5NhCpbpjvJbYi29b7G+LHrpUL/KnvCIjHjG5Lgxvkicn25xAFIPrdESQN9w4
	 xDw0Y/OZqEfCEgETP56SNd3g7x0BqY8WnKh1JvAec6xboi82O3A263TR30rPa8eqkD
	 HQQ2w/+Vtd3xbTjSP9+fPEStUnb3ZilGW+o2ypRNbxEQghMjWVpb5HPq9PK0KmkMj+
	 sHo/rlOCspeu0ymb3Xc9eULCUjje2jx84j9ZHjZbozZ9Xkr2HWTVBGJjUAubbzld5m
	 0hYvYzZITVELx0dk9Hplrr2VXB8xZWIkmjJMG9E5UqSoBOuBUbzXB2OB/jXC0WfCX9
	 3RDT/15Wuxevw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C3C5DC009;
	Wed,  3 Jan 2024 14:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704286828; bh=M9MVRJ/IOq68RjnYFcSXCjl3WBemBARgVfqAaYYq2bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4AiBjprUNXrqU3zwYpywyL3jd+SefRgEQ0LitNyZbaCbkJABDGm+1uVTVbFh7u4Eb
	 U82ANNe4mKUhzMSta94yKyXND+fzKyvpqFdCLn9a7UjnvEjdop7jxDsasrVnP+qxgi
	 wZeEpsE4ZCdUj1/HSviuG7djlA7fGo7ODJQKtNfKXSkkSjFUf2QxuzmjQSeUhJQ58P
	 kKZ2y7CZvt1mOp6hJBUR34+jt64lDp9p2FiUPTlL/yKOslM0yOFoDXfyIdC8kMuUMs
	 1IIsLCN0iO14LaRP68hQ6P5k46JP32PsH56gy9vyr5FyEDZn2pnuxCIRYku7lF1ywb
	 6cIfPLs+CCkTw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id f04d2000;
	Wed, 3 Jan 2024 13:00:18 +0000 (UTC)
Date: Wed, 3 Jan 2024 22:00:03 +0900
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
Message-ID: <ZZVaU_vI90WcV_jl@codewreck.org>
References: <ZZULNQAZ0n0WQv7p@codewreck.org>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <355430.1704285574@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <355430.1704285574@warthog.procyon.org.uk>

David Howells wrote on Wed, Jan 03, 2024 at 12:39:34PM +0000:
> > p9_client_write return value should always be subreq->len, but I believe
> > we should use it unless err is set.
> > (It's also possible for partial writes to happen, e.g. p9_client_write
> > looped a few times and then failed, at which point the size returned
> > would be the amount that actually got through -- we probably should do
> > something with that?)
> 
> How about something like:
> 
> -	int err;
> +	int err, len;
>  
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> -	p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
> -	netfs_write_subrequest_terminated(subreq, err < 0 ? err : subreq->len,
> -					  false);
> +	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
> +	netfs_write_subrequest_terminated(subreq, len ?: err, false);

I think that'll be fine; plain write() syscall works like this when an
error happens after some data has been flushed, and I assume there'll be
some retry if this happpened on something like a flush dirty and it got
a partial write reported?

> > > +	if (file) {
> > > +		fid = file->private_data;
> > > +		BUG_ON(!fid);
> > 
> > This probably should be WARN + return EINVAL like find by inode?
> > It's certainly a huge problem, but we should avoid BUG if possible...
> 
> Sure.  The BUG_ON() was already there, but I can turn it into a WARN+error.

Thanks.

> > nit: not sure what's cleaner?
> > Since there's a message that makes for a bit awkward if...
> > 
> > if (WARN_ONCE(!fid, "folio expected an open fid inode->i_private=%p\n",
> > 	      rreq->inode->i_private))
> > 	return -EINVAL;
> > 
> > (as a side note, I'm not sure what to make of this i_private pointer
> > here, but if that'll help you figure something out sure..)
> 
> Um.  9p is using i_private.  But perhaps i_ino would be a better choice:
> 
> 	if (file) {
> 		fid = file->private_data;
> 		if (!fid)
> 			goto no_fid;
> 		p9_fid_get(fid);
> 	} else {
> 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
> 		if (!fid)
> 			goto no_fid;
> 	}
> 
> 	...
> 
> no_fid:
> 	WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
> 		  rreq->inode->i_ino);
> 	return -EINVAL;

Might be useful to track down if this came frm a file without private
data or lookup failing, but given this was a bug I guess we can deal
with that when that happens -- ack.

> > This is as follow on your netfs-lib branch:
> > -       WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
> > -                       !(fid->mode & P9_ORDWR));
> > -
> > -       p9_fid_get(fid);
> > +       WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE && !(fid->mode & P9_ORDWR));
> > 
> > So the WARN_ON has been reverted back with only indentation changed;
> > I guess there were patterns that were writing despite the fid not having
> > been open as RDWR?
> > Do you still have details about these?
> 
> The condition in the WARN_ON() here got changed.  It was:
> 
> 	WARN_ON(writing && ...
> 
> at one point, but that caused a bunch of incorrect warning to appear because
> only NETFS_READ_FOR_WRITE requires read-access as well as write-access.  All
> the others:
> 
> 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
> 			rreq->origin == NETFS_WRITEBACK ||
> 			rreq->origin == NETFS_WRITETHROUGH ||
> 			rreq->origin == NETFS_LAUNDER_WRITE ||
> 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
> 			rreq->origin == NETFS_DIO_WRITE);
> 
> only require write-access.

Thanks for clarifying

> > If a file has been open without the write bit it might not go through,
> > and it's incredibly difficult to get such users back to userspace in
> > async cases (e.g. mmap flushes), so would like to understand that.
> 
> The VFS/VM should prevent writing to files that aren't open O_WRONLY or
> O_RDWR, so I don't think we should be called in otherwise.

Historically this check was more about finding a fid that wasn't opened
properly than the VFS doing something weird (e.g. by calling mprotect
after mmap and us missing that -- would need to check if that works
actually...)

> > > +	return netfs_page_mkwrite(vmf, NULL);
> > 
> > (I guess there's no helper that could be used directly in .page_mkwrite
> > op?)
> 
> I could provide a helper that just supplies NULL as the second argument.  I
> think only 9p will use it, but that's fine.

If we're the only user I guess we shouldn't bother with it at this
point, we can come back to it if this ever becomes common.

-- 
Dominique Martinet | Asmadeus

