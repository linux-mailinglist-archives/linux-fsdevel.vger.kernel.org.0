Return-Path: <linux-fsdevel+bounces-37755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4E9F6E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7899C7A2CF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E81FAC57;
	Wed, 18 Dec 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YM+6l9j+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D9157A55
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550628; cv=none; b=IVYn6DcHp/4pb5Gu0h1KHWPQ51uv1bv9ZeuARWVBOZvHhvTg/TiDuZxKDY5RDyaSIvWFK9i4o/xlRCMEKJsmYQxxX5xaj8Px3eqQAQf5hqmbnAMbqvosVEM5YU7gJ5mfkhOULfmkqHlgaryvs3CJtpdDs8Q4YPMwvW6/7nX9jRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550628; c=relaxed/simple;
	bh=2GvUp1ccTaDh+iV8Xazl5vmZEimq0a8geQrG91c5OQ4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dJgXdrZmWvH8xkwLKi+OLbyBEaBGR2aUjhJ1yvPxzw/36MXoP3Lm0KXXk6ec8q3ra+7wCj23CJx5t/dXULh4npnZO2a9FnpUd3YEW9lmezfWikSaxUBGwJuFHOZqxu9FW3jeEH0GZ+BxQlL+xHLlNYbZy/2z4lbk9M9Rzpz826M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YM+6l9j+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734550625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0HzvNsNEfuUE6agFeZIrpp/Ez/6g/FrfqxvH4mB9io=;
	b=YM+6l9j+IiDtubfZgZCfD+ENmXJJSeq5JPTNctOSyEZWNuphiJCq5UVLh04oZgVIHRWkP4
	ANxMPSDRSvLdNWJUY9zE4WXvUbu6yWJ9Ml9JCnKY452m0bNneDFHlY5dBwvvzY+bBL9aNy
	jDCw1b9tfIYRKJJ9V+g2n0Hrs6cndB8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-9iDbmLxcP3Cv6t7prWuO5g-1; Wed,
 18 Dec 2024 14:37:02 -0500
X-MC-Unique: 9iDbmLxcP3Cv6t7prWuO5g-1
X-Mimecast-MFC-AGG-ID: 9iDbmLxcP3Cv6t7prWuO5g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAC5419560A2;
	Wed, 18 Dec 2024 19:36:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76C3B30044C1;
	Wed, 18 Dec 2024 19:36:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+2bHPbSWHEkJso18Ua=k+OccZq4HzuOLAmZYTD1d5auDxQ9Vw@mail.gmail.com>
References: <CA+2bHPbSWHEkJso18Ua=k+OccZq4HzuOLAmZYTD1d5auDxQ9Vw@mail.gmail.com> <3989572.1734546794@warthog.procyon.org.uk>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2024 19:36:56 +0000
Message-ID: <3991743.1734550616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Patrick Donnelly <pdonnell@redhat.com> wrote:

> On Wed, Dec 18, 2024 at 1:33=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> > Also, that would include doing things like content encryption, since th=
at
> > is generally useful in filesystems and I have plans to support it in bo=
th
> > AFS and CIFS as well.
>=20
> Would this be done with fscrypt? Can you expand on this part?

Since ceph already uses fscrypt, I would need to maintain that.

If you look here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dnetfs-crypt

I have patches to provide content crypto for netfslib (not upstream yet).  =
If
you look at the afs patch at the top, you can see my hacked up AFS testing
implementation - though it isn't a complete solution as I don't currently h=
ave
a way to store the actual EOF there[*].

I add two new methods, encrypt_block and decrypt_block, for netfslib to call
out to the filesystem to actually do the encryption.

On the write/encryption side, netfslib creates one or more subrequests to do
the encryption, allowing it to be done asynchronously (I have it offloading=
 to
my Intel QAT card), collecting the completed encryption subreqs as they're
done and dispatching the write I/O subrequests to the server and/or the loc=
al
cache as the ciphertext becomes available.

[Note: one reason I'm doing this in netfslib is so that the same
content-encrypted data is written to both the server and the local cache]

Currently, I create one subreq per fscrypt block to be encrypted (e.g. 4KiB=
),
but that feels a bit on the heavy side and some throttling is probably
necessary.

Netfslib takes care of encrypting multipage folios that are spanned by
multiple crypto blocks, calling out to the filesystem for each.

How and where the filesystem does the crypto is up to the filesystem - it c=
an
offload it to fscrypt.  It may be possible to have the filesystem load what=
 it
needs into netfs_io_request for fscrypt to pick up and then make the method
pointers point directly to fscrypt.  I don't really want to make the netfsl=
ib
module directly dependent on fscrypt, though this could be done to improve
performance.


On the read/decryption side, netfslib currently expects the filesystem to
synchronously decrypt the data, though I should also look at making that
asynchronous now that I have patches to do move read collection for a single
request to working in a single work item instead of a bunch of work items a=
ll
competing with each other.  One thing I want to avoid is scheduling async
decryption out of order just because the RPC ops finish out of order.

David

[*] Actually, I may have thought of a way to store the EOF in AFS today.  T=
he
problem is that I have to round up the EOF to a full crypto block (e.g. 16 =
or
32 bytes for AES) but don't have anywhere to store the real EOF (no xattrs =
for
example).

So what I'm thinking is that I can just store a trailer of the crypto block
size of all zeros and then encrypt whatever of it that I need.  The trailer
will always be there (unless a zero-length file), always be right after the
EOF and always be the same length, so the AFS fs can trivially calculate the
real EOF size if it knows the algorithm used.

Further, AFS has a StoreData op that "atomically" does a truncate and write,
so maintaining a trailer is pretty straightforward.


