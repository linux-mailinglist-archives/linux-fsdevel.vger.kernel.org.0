Return-Path: <linux-fsdevel+bounces-19221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC038C187F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 23:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051CB1F242B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9958595A;
	Thu,  9 May 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdOnYxdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AB7FBD1
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290653; cv=none; b=C/NKM60dIGi2zdGThToQPmtGB5DslOeZFABqx82J2BcKoDEdZRL51zCm2XEC18CvbBTGg3/ss4ZI1oSvabiOTbje40eWbEfhAfIz5q8JIP9HLnTjmX+3oa9MjC8aNqQqL3UzJeH1QGfc+XHDdC6NITWfWN4/G3Q6E9XBdt+Fdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290653; c=relaxed/simple;
	bh=7Qd7kioQIn6Ug3QVYIeKDHVOfBDjLq7+QwL5mOTHriA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QUK0Ema5xwivU9APJrR2v8THS6G+e7gAbS1r9sLDBlEfiVy/3asQkPQebzc0W8WNcricWkpcPWajFjc+WYhRb/rPuuhd5JW+wOAOtJegD1bbFO3rkwZuQGsPuiDHwctkfxmcsCF0+kZAMOVxxSaTmDMh0DvR175aSD6/UYZgLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdOnYxdC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715290651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcaQVOny0rQHUK0pL7eF7lEuZY7XrpmUt/qtfJiKS4s=;
	b=EdOnYxdCiRkVKJw3wgYMzsY7AIwHV11lN/1uggF5ccoFEsvbZAjg3TQ2Ysb+1BtLDcvT9Y
	HMr+2ANYdq0DpBTqujr9RMIALQgSJRd/C2fz3ukaDZ3t/CdUsRs1Dh6nINC4dK2d9oEXWa
	hc0CgM5ifsJ4mXyfYje8RyEyeFywdiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-SXXJHLiOO2OSZBwSwPH1GA-1; Thu, 09 May 2024 17:33:43 -0400
X-MC-Unique: SXXJHLiOO2OSZBwSwPH1GA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 046A38030A4;
	Thu,  9 May 2024 21:33:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 12FA0116F842;
	Thu,  9 May 2024 21:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zj0ErxVBE3DYT2Ea@gpd>
References: <Zj0ErxVBE3DYT2Ea@gpd> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-41-dhowells@redhat.com>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
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
Content-ID: <1567251.1715290417.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2024 22:33:37 +0100
Message-ID: <1567252.1715290417@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Andrea Righi <andrea.righi@canonical.com> wrote:

> On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> > Use netfslib's read and write iteration helpers, allowing netfslib to =
take
> > over the management of the page cache for 9p files and to manage local=
 disk
> > caching.  In particular, this eliminates write_begin, write_end, write=
page
> > and all mentions of struct page and struct folio from 9p.
> > =

> > Note that netfslib now offers the possibility of write-through caching=
 if
> > that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> > v9inode->netfs.flags in v9fs_set_netfs_context().
> > =

> > Note also this is untested as I can't get ganesha.nfsd to correctly pa=
rse
> > the config to turn on 9p support.
> =

> It looks like this patch has introduced a regression with autopkgtest,
> see: https://bugs.launchpad.net/bugs/2056461
> =

> I haven't looked at the details yet, I just did some bisecting and
> apparently reverting this one seems to fix the problem.
> =

> Let me know if you want me to test something in particular or if you
> already have a potential fix. Otherwise I'll take a look.

Do you have a reproducer?

I'll be at LSF next week, so if I can't fix it tomorrow, I won't be able t=
o
poke at it until after that.

David


