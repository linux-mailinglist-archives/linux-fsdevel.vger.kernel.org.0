Return-Path: <linux-fsdevel+bounces-7178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11903822D49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A55B234D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840AB199A9;
	Wed,  3 Jan 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx4Vrxgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6319452
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704285585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZR17Gbrs13ExF6OSOpjmM51Duz7iMNUsTARfX2CwGI=;
	b=cx4Vrxgvss9DCt3MPWoz25SxgUyNkWqo9i0r1yEqCVvT33YYJYzK6s13ZaCH5u3NKmV33x
	5gU0OxPAy4msW20P9ec2D1vlpa79cq41l1IO/awH1JzIB3ntvPM8lIvuLLtPGmN4BjmesP
	jY609++47428mm8HRE+5hEF36v53paE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-cl6KkG5aMue3xdfdLO_cMA-1; Wed,
 03 Jan 2024 07:39:39 -0500
X-MC-Unique: cl6KkG5aMue3xdfdLO_cMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C13F3813BD1;
	Wed,  3 Jan 2024 12:39:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3D15C15A0C;
	Wed,  3 Jan 2024 12:39:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZULNQAZ0n0WQv7p@codewreck.org>
References: <ZZULNQAZ0n0WQv7p@codewreck.org> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-41-dhowells@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <355429.1704285574.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jan 2024 12:39:34 +0000
Message-ID: <355430.1704285574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Dominique Martinet <asmadeus@codewreck.org> wrote:

> > +static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
> > +{
> > +	struct inode *inode =3D subreq->rreq->inode;
> > +	struct v9fs_inode __maybe_unused *v9inode =3D V9FS_I(inode);
> =

> Any reason to have this variable assignment at all?

I'll just remove it.  The __maybe_unused suppressed the warning, otherwise=
 I'd
have removed it already.

> p9_client_write return value should always be subreq->len, but I believe
> we should use it unless err is set.
> (It's also possible for partial writes to happen, e.g. p9_client_write
> looped a few times and then failed, at which point the size returned
> would be the amount that actually got through -- we probably should do
> something with that?)

How about something like:

-	int err;
+	int err, len;
 =

 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-	netfs_write_subrequest_terminated(subreq, err < 0 ? err : subreq->len,
-					  false);
+	len =3D p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, len ?: err, false);

> > +	total =3D p9_client_read(fid, subreq->start + subreq->transferred,
> > +			       &subreq->io_iter, &err);
> =

> Just to clarify: subreq->io_iter didn't exist (or some conditions to use
> it weren't cleared) before?

Correct.  It's added in the netfs-lib patches.  I've provided a way to
separate the user-side iterator from the I/O-side iterator to allow the us=
e of
a bounce buffer for the purpose of content crypto, compression or just hav=
ing
to deal with RMW cycles to a larger block size on the server.

> > +	if (file) {
> > +		fid =3D file->private_data;
> > +		BUG_ON(!fid);
> =

> This probably should be WARN + return EINVAL like find by inode?
> It's certainly a huge problem, but we should avoid BUG if possible...

Sure.  The BUG_ON() was already there, but I can turn it into a WARN+error=
.

> nit: not sure what's cleaner?
> Since there's a message that makes for a bit awkward if...
> =

> if (WARN_ONCE(!fid, "folio expected an open fid inode->i_private=3D%p\n"=
,
> 	      rreq->inode->i_private))
> 	return -EINVAL;
> =

> (as a side note, I'm not sure what to make of this i_private pointer
> here, but if that'll help you figure something out sure..)

Um.  9p is using i_private.  But perhaps i_ino would be a better choice:

	if (file) {
		fid =3D file->private_data;
		if (!fid)
			goto no_fid;
		p9_fid_get(fid);
	} else {
		fid =3D v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
		if (!fid)
			goto no_fid;
	}

	...

no_fid:
	WARN_ONCE(1, "folio expected an open fid inode->i_ino=3D%lx\n",
		  rreq->inode->i_ino);
	return -EINVAL;

> This is as follow on your netfs-lib branch:
> -       WARN_ON(rreq->origin =3D=3D NETFS_READ_FOR_WRITE &&
> -                       !(fid->mode & P9_ORDWR));
> -
> -       p9_fid_get(fid);
> +       WARN_ON(rreq->origin =3D=3D NETFS_READ_FOR_WRITE && !(fid->mode =
& P9_ORDWR));
> =

> So the WARN_ON has been reverted back with only indentation changed;
> I guess there were patterns that were writing despite the fid not having
> been open as RDWR?
> Do you still have details about these?

The condition in the WARN_ON() here got changed.  It was:

	WARN_ON(writing && ...

at one point, but that caused a bunch of incorrect warning to appear becau=
se
only NETFS_READ_FOR_WRITE requires read-access as well as write-access.  A=
ll
the others:

	bool writing =3D (rreq->origin =3D=3D NETFS_READ_FOR_WRITE ||
			rreq->origin =3D=3D NETFS_WRITEBACK ||
			rreq->origin =3D=3D NETFS_WRITETHROUGH ||
			rreq->origin =3D=3D NETFS_LAUNDER_WRITE ||
			rreq->origin =3D=3D NETFS_UNBUFFERED_WRITE ||
			rreq->origin =3D=3D NETFS_DIO_WRITE);

only require write-access.

There will be an additional one if we roll out content crypto to 9p as we =
may
need to do RMW cycles occasionally - but that's off to one side just for t=
he
moment.

> If a file has been open without the write bit it might not go through,
> and it's incredibly difficult to get such users back to userspace in
> async cases (e.g. mmap flushes), so would like to understand that.

The VFS/VM should prevent writing to files that aren't open O_WRONLY or
O_RDWR, so I don't think we should be called in otherwise.

Note that I'm intending to change the way fscache is driven when we fetch
cacheable data from the server so that I can free up the PG_fscache bit an=
d
return it to the MM folks.  Instead of marking the page PG_fscache, I mark=
 it
PG_dirty and set page->private with a special value to indicate it should =
only
be written to the cache - then the writepages sees that and just writes th=
ese
pages to the cache.  I have a patch to do this and it seems to work, but I
need to make ceph and cifs use netfslib before I can apply it.

> > +	p9_debug(P9_DEBUG_VFS, "(cached)\n");
> =

> (Not a new problem so no need to address here, but having just
> "(cached)" on a split line is a bit weird.. We first compute cached or
> not as a bool and make it %s + cached ? " (cached)" : "" or
> something... I'll send a patch after this gets in to avoid conflicts)

Okay.

> > +	return netfs_page_mkwrite(vmf, NULL);
> =

> (I guess there's no helper that could be used directly in .page_mkwrite
> op?)

I could provide a helper that just supplies NULL as the second argument.  =
I
think only 9p will use it, but that's fine.

David


