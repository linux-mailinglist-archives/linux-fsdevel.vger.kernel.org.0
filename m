Return-Path: <linux-fsdevel+bounces-13855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C97874C87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969531C20AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30AEAEB;
	Thu,  7 Mar 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc3hwyt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBE85643
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807801; cv=none; b=FR4XW3iG9uNKokYI31yQtdd0jwEM4Lmm/rIBfW0aZx548Zh58/SCev/gLvNvYHlur99bJDxJBAy/Rh602NG9fU0WntlBNx6j2DdQ3Hqy+47HeXOVFRejbWk9c3gaKjEdffDRSA1qWOSXADpCxR1ceJ1wEBU5/KMV5KWdlY+60KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807801; c=relaxed/simple;
	bh=oSvpQF78OH2SIBcN2hrMJ6J8dbzBxbdEOqWa3QXaon8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kGWdUfCiswNP437kd/s3sshhTIz5a25OIOdYjN4LNsdec7c2GiDRZI//qTLcHPKJDOR/SeOgvDoNZ1v96UjFb+2BRKNHw04fD8xFkIktlwd9zxodZwvju0RbDb18wbyzZt/kUm3q2ONVBzGlC8AvBJeykU7UhLfzngFolhkgoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc3hwyt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709807798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rD9pKOLlJMagBhvvso8urKdJzEY4DWr9MOofjPhNFFA=;
	b=hc3hwyt/QTylf3hpvd3TTzXew43syZ1P97SqgOVLLqOfjLOunMwHMto10SQw3qw863vGFJ
	sRHbfnv/cjtpzhV9Xv7ovltd9uEIwpDkVXUiRzMu/UMBusbinuSLy1lsDkr/iJzgNvXtyK
	8kzGgqi6uJgVgxbfM1l+C6QS+FtMsyY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-zJKFNu4oMJWt0JTIEUyesQ-1; Thu,
 07 Mar 2024 05:36:33 -0500
X-MC-Unique: zJKFNu4oMJWt0JTIEUyesQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F4E329AC020;
	Thu,  7 Mar 2024 10:36:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23538C01600;
	Thu,  7 Mar 2024 10:36:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZelGX3vVlGfEZm8H@casper.infradead.org>
References: <ZelGX3vVlGfEZm8H@casper.infradead.org> <1668172.1709764777@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1831808.1709807788.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 10:36:28 +0000
Message-ID: <1831809.1709807788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Mar 06, 2024 at 10:39:37PM +0000, David Howells wrote:
> > Here's a patch to have a go at getting rid of ->launder_folio().  Sinc=
e it's
> > failable and cannot guarantee that pages in the range are removed, I'v=
e tried
> > to replace laundering with just flush-and-wait, dropping the folio loc=
k around
> > the I/O.
> =

> My sense is that ->launder_folio doesn't actually need to be replaced.
> =

> commit e3db7691e9f3dff3289f64e3d98583e28afe03db
> Author: Trond Myklebust <Trond.Myklebust@netapp.com>
> Date:   Wed Jan 10 23:15:39 2007 -0800
> =

>     [PATCH] NFS: Fix race in nfs_release_page()
> =

>         NFS: Fix race in nfs_release_page()
> =

>         invalidate_inode_pages2() may find the dirty bit has been set on=
 a page
>         owing to the fact that the page may still be mapped after it was=
 locked.
>         Only after the call to unmap_mapping_range() are we sure that th=
e page
>         can no longer be dirtied.
>         In order to fix this, NFS has hooked the releasepage() method an=
d tries
>         to write the page out between the call to unmap_mapping_range() =
and the
>         call to remove_mapping(). This, however leads to deadlocks in th=
e page
>         reclaim code, where the page may be locked without holding a ref=
erence
>         to the inode or dentry.
> =

>         Fix is to add a new address_space_operation, launder_page(), whi=
ch will
>         attempt to write out a dirty page without releasing the page loc=
k.
> =

>     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> =

> I don't understand why this couldn't've been solved by page_mkwrite.
> NFS did later add nfs_vm_page_mkwrite in July 2007, and maybe it's just
> not needed any more?  I haven't looked into it enough to make sure,
> but my belief is that we should be able to get rid of it.

Okay, it's slightly more complex than I thought - and I'm not sure all cal=
lers
are actually using it correctly.  There are some additional interesting ca=
ses
I've found, beyond the pre-/post-DIO case:

 (1) NFS relies on it to retry the write before stripping the pages in the
     case where a writeback error occurs.  I think this can probably be de=
alt
     with by sticking a filemap_fdatawrite() call before the invalidation.
     I'm not sure if this would incur the deadlock with the page reclaim c=
ode
     of which Trond speaks.

 (2) invalidate_inode_pages2() is used in some places to effect invalidati=
on
     of the pagecache in the case where the server tells us that a third p=
arty
     modified the server copy of a file.  What the right behaviour should =
be
     here, I'm not sure, but at the moment, any dirty data will get launde=
red
     back to the server.  Possibly it should be simply invalidated locally=
 or
     the user asked how they want to handle the divergence.

     Some filesystems use invalidate_remote_inode() instead which seems to
     leave the dirty pages in place locally.

     If it is desirous to save the dirty data, then filemap_fdatawrite()
     could be deployed before invalidating the pages.

 (3) Fuse uses invalidate_inode_pages2() in fuse_do_setattr() to strip all=
 the
     pages from an inode that has had its size changed, laundering any pag=
e
     that's still dirty.  This would seem to be excessive, but maybe Miklo=
s
     had a reason for doing it that way.

There are some places that should perhaps be using kiocb_invalidate_pages(=
)
and kiocb_invalidate_post_direct_write() instead - assuming Christoph has =
no
objection to the latter function being exported.

David


