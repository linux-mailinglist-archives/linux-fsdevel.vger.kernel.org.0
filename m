Return-Path: <linux-fsdevel+bounces-6507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BE818CF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EC01C2481C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87406241F9;
	Tue, 19 Dec 2023 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbfwgVEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6620DEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703004697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5Xe1M0Gz0LaWjI/lQS6+uzcaH3a3lGFMV4s4r+jDpI=;
	b=EbfwgVEEg8ujdiHfkXEuWwUlH7gEllPlsCWTpwBo6A92351t1nsCg+Sevo4PGN7o3JGgzA
	VljzTlMefWfPA2Cx66KT/x0pyXUROl+WvyINPULypnXFt8+at+kgpEiN2SAZiow3xQ7g4N
	qXnVUw06B8wVcI9gmx60hsXda1sDVj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-SZhKt4N1MPKXfQGXxUAb8Q-1; Tue, 19 Dec 2023 11:51:31 -0500
X-MC-Unique: SZhKt4N1MPKXfQGXxUAb8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 544C185A589;
	Tue, 19 Dec 2023 16:51:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 745142166B31;
	Tue, 19 Dec 2023 16:51:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <d1d4f3996f55cb98ab6297844a51bc905e2ce631.camel@kernel.org>
References: <d1d4f3996f55cb98ab6297844a51bc905e2ce631.camel@kernel.org> <20231213152350.431591-1-dhowells@redhat.com> <20231213152350.431591-37-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 36/39] netfs: Implement a write-through caching option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1075259.1703004686.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 16:51:26 +0000
Message-ID: <1075260.1703004686@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Jeff Layton <jlayton@kernel.org> wrote:

> > This can't be used with content encryption as that may require expansi=
on of
> > the write RPC beyond the write being made.
> > =

> > This doesn't affect writes via mmap - those are written back in the no=
rmal
> > way; similarly failed writethrough writes are marked dirty and left to
> > writeback to retry.  Another option would be to simply invalidate them=
, but
> > the contents can be simultaneously accessed by read() and through mmap=
.
> > =

> =

> I do wish Linux were less of a mess in this regard. Different
> filesystems behave differently when writeback fails.

Cifs is particularly, um, entertaining in this regard as it allows the wri=
te
to fail on the server due to a checksum failure if the source data changes
during the write and then just retries it later.

> That said, the modern consensus with local filesystems is to just leave
> the pages clean when buffered writeback fails, but set a writeback error
> on the inode. That at least keeps dirty pages from stacking up in the
> cache. In the case of something like a netfs, we usually invalidate the
> inode and the pages -- netfs's usually have to spontaneously deal with
> that anyway, so we might as well.
> =

> Marking the pages dirty here should mean that they'll effectively get a
> second try at writeback, which is a change in behavior from most
> filesystems. I'm not sure it's a bad one, but writeback can take a long
> time if you have a laggy network.

I'm not sure what the best thing to do is.  If everything is doing
O_DSYNC/writethrough I/O on an inode and there is no mmap, then invalidati=
ng
the pages is probably not a bad way to deal with failure here.

> When a write has already failed once, why do you think it'll succeed on
> a second attempt (and probably with page-aligned I/O, I guess)?

See above with cifs.  I wonder if the pages being written to should be mad=
e RO
and page_mkwrite() forced to lock against DSYNC writethrough.

> Another question: when the writeback is (re)attempted, will it end up
> just doing page-aligned I/O, or is the byte range still going to be
> limited to the written range?

At the moment, it then happens exactly as it would if it wasn't doing
writethrough - so it will write partial folios if it's doing a streaming w=
rite
and will do full folios otherwise.

> The more I consider it, I think it might be a lot simpler to just "fail
> fast" here rather than remarking the write dirty.

You may be right - but, again, mmap:-/

David


