Return-Path: <linux-fsdevel+bounces-46083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB5A82640
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110FA8A62E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1325F960;
	Wed,  9 Apr 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZnPtZRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A025DD13
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205076; cv=none; b=uFapT++gy7AtfYF08SmHubGCaYezPAy6y8hvqy1ZlCU6MYKsncAQn5lyTMcwq0NkH18uCE012oI7ROBehcdk9bHjIuonq3pHRdJ3MXGwF2NRI7MnamcOa1Gf2284jUDsENAp5EVPriw5lFQOpO9T++tLKEBGyS9TaoDX+QU3LCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205076; c=relaxed/simple;
	bh=lR6HbIW46Lo1luKRc0aisq12HHbyplNXNMAdbjw83Qw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=s0F2KwpVtos8hdQpd+/QYX5zkeneiGg6wgPc2priTYCcCDU8klDFE8qJ3OhtT5MlRQoZAPtyhxHoEnKgMT3s9qLtYvyENoTqzeaELZCqI2JDI/lnzm+E4n44D4pXaIPB0NDN31YsAuhMalmVdAM3o4JmoUVcFrhw5ABOZNEfNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZnPtZRl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744205073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfwYYsGrLuBzhEjko8XOF3Kr8lKmO5hpl5xF++WtSAA=;
	b=fZnPtZRl73M0z+lcx/Y9yccDrAEhDIB79CytU0CVUOQSy357iSRuVmSG+nGCKp5eOyKLP+
	AUkdk/GjlAJGrI5af3EPsw2PB4ySeqPtndQmcpVlBY5fNxbuA1TvLBoyBo0Yu/U4mxkasG
	A59yrhL67rAcwrOJhBXX9/jQL9gu19Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-0sGq1VTdOK6CsMIJAsgGDg-1; Wed,
 09 Apr 2025 09:24:30 -0400
X-MC-Unique: 0sGq1VTdOK6CsMIJAsgGDg-1
X-Mimecast-MFC-AGG-ID: 0sGq1VTdOK6CsMIJAsgGDg_1744205068
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F214195606A;
	Wed,  9 Apr 2025 13:24:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9ECE19560AD;
	Wed,  9 Apr 2025 13:24:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z_ZHoCgi2BY5lVjN@archie.me>
References: <Z_ZHoCgi2BY5lVjN@archie.me> <Z_XOr4Ak4S0EOdrw@archie.me> <1565252.1744124997@warthog.procyon.org.uk> <1657441.1744189529@warthog.procyon.org.uk>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>, Timothy Day <timday@amazon.com>,
    Jonathan Corbet <corbet@lwn.net>, netfs@lists.linux.dev,
    linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Update main API document
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1676059.1744205063.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Apr 2025 14:24:23 +0100
Message-ID: <1676060.1744205063@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> > > > +Further, if a read from the cache fails, the library will ask the=
 filesystem to
> > > > +do the read instead, renegotiating and retiling the subrequests a=
s necessary.
> > > Read from the filesystem itself or direct read?
> > =

> > I'm not sure what you mean.  Here, I'm talking about read subrequests =
- i.e. a
> > subrequest that corresponds to a BIO issued to the cache or a single R=
PC
> > issued to the server.  Things like DIO and pagecache are at a higher l=
evel and
> > not directly exposed to the filesystem.
> > =

> > Maybe I should amend the text to read:
> > =

> > 	Further, if one or more subrequests issued to read from the cache
> > 	fail, the library will issue them to the filesystem instead,
> > 	renegotiating and retiling the subrequests as necessary.
> =

> That one sounds better to me.

I think I like this better:

	Further, if one or more contiguous cache-read subrequests fail, the
	library will pass them to the filesystem to perform instead,
	renegotiating and retiling them as necessary to fit with the
	filesystem's parameters rather than those of the cache.

> > > > +Netfslib will pin resources on an inode for future writeback (suc=
h as pinning
> > > > +use of an fscache cookie) when an inode is dirtied.  However, thi=
s needs
> > > > +managing.  Firstly, a function is provided to unpin the writeback=
 in
> > > inode management?
> > > > +``->write_inode()``::
> > =

> > Is "inode management" meant to be a suggested insertion or an alternat=
ive for
> > the subsection title?
> =

> I mean "However, this needs managing the inode (inode management)". Is i=
t
> correct to you?

Um.  "However, this needs managing the inode (inode management)" isn't val=
id
English and "(inode management)" is superfluous with "managing the inode" =
also
in the sentence.

How about:

	Netfslib will pin resources on an inode for future writeback (such as pin=
ning
	use of an fscache cookie) when an inode is dirtied.  However, this pinnin=
g
	needs careful management.  To manage the pinning, the following sequence
	occurs:

	 1) An inode state flag ``I_PINNING_NETFS_WB`` is set by netfslib when th=
e
	    pinning begins (when a folio is dirtied, for example) if the cache is
	    active to stop the cache structures from being discarded and the cach=
e
	    space from being culled.  This also prevents re-getting of cache reso=
urces
	    if the flag is already set.

	 2) This flag then cleared inside the inode lock during inode writeback i=
n the
	    VM - and the fact that it was set is transferred to ``->unpinned_netf=
s_wb``
	    in ``struct writeback_control``.

	 3) If ``->unpinned_netfs_wb`` is now set, the write_inode procedure is f=
orced.

	 4) The filesystem's ``->write_inode()`` function is invoked to do the cl=
eanup.

	 5) The filesystem invokes netfs to do its cleanup.

	To do the cleanup, netfslib provides a function to do the resource unpinn=
ing::

		int netfs_unpin_writeback(struct inode *inode, struct writeback_control =
*wbc);

	If the filesystem doesn't need to do anything else, this may be set as a =
its
	``.write_inode`` method.

	Further, if an inode is deleted, the filesystem's write_inode method may =
not
	get called, so::

		void netfs_clear_inode_writeback(struct inode *inode, const void *aux);

	must be called from ``->evict_inode()`` *before* ``clear_inode()`` is cal=
led.


instead?

Thanks,
David


