Return-Path: <linux-fsdevel+bounces-7133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFFD82202B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EC51F244B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D115AC2;
	Tue,  2 Jan 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4DJR3SU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23173156D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704215486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4UcCxfloG77cC/pfD32WuEtxWkG2YAQtUa4GDcGdRQ=;
	b=b4DJR3SUPbwp5AwD1V28o76xGnJYvDnVEk7UFRtTS33IgNGM6NZb5M4fSQcd5C4jaY/xVk
	A+6jdAEtIHWKtCV4wHsCV/gLteQes/Fl0LKoRN3cCYkS9wuaCWJT3ioix8OMZJLR5vOBmy
	h19vMdn7oc8PgkR2FCbAjI7jmkoPHc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-DPwMbcfePQyaxNssfUs5vA-1; Tue, 02 Jan 2024 12:11:21 -0500
X-MC-Unique: DPwMbcfePQyaxNssfUs5vA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AA2085CBA2;
	Tue,  2 Jan 2024 17:11:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6A1940C6EBA;
	Tue,  2 Jan 2024 17:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <750e8251-ba30-4f53-a17b-73c79e3739ce@linux.alibaba.com>
References: <750e8251-ba30-4f53-a17b-73c79e3739ce@linux.alibaba.com> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-34-dhowells@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
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
    linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v5 33/40] netfs, cachefiles: Pass upper bound length to allow expansion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <198743.1704215477.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2024 17:11:17 +0000
Message-ID: <198744.1704215477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> >   	down =3D start - round_down(start, PAGE_SIZE);
> >   	*_start =3D start - down;
> >   	*_len =3D round_up(down + len, PAGE_SIZE);
> > +	if (down < start || *_len > upper_len)
> > +		return -ENOBUFS;
> =

> Sorry for bothering. We just found some strange when testing
> today-next EROFS over fscache.
> =

> I'm not sure the meaning of
>     if (down < start
> =

> For example, if start is page-aligned, down =3D=3D 0.
> =

> so as long as start > 0 and page-aligned, it will return
> -ENOBUFS.  Does it an intended behavior?

Yeah, I think that's wrong.

Does the attached help?

David
---

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index bffffedce4a9..7529b40bc95a 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_obj=
ect *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache =3D object->volume->cache;
-	loff_t start =3D *_start, pos;
-	size_t len =3D *_len, down;
+	unsigned long long start =3D *_start, pos;
+	size_t len =3D *_len;
 	int ret;
 =

 	/* Round to DIO size */
-	down =3D start - round_down(start, PAGE_SIZE);
-	*_start =3D start - down;
-	*_len =3D round_up(down + len, PAGE_SIZE);
-	if (down < start || *_len > upper_len)
+	start =3D round_down(*_start, PAGE_SIZE);
+	if (start !=3D *_start) {
+		kleave(" =3D -ENOBUFS [down]");
+		return -ENOBUFS;
+	}
+	if (*_len > upper_len) {
+		kleave(" =3D -ENOBUFS [up]");
 		return -ENOBUFS;
+	}
+
+	*_len =3D round_up(len, PAGE_SIZE);
 =

 	/* We need to work out whether there's sufficient disk space to perform
 	 * the write - but we can skip that check if we have space already
@@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 =

 	pos =3D cachefiles_inject_read_error();
 	if (pos =3D=3D 0)
-		pos =3D vfs_llseek(file, *_start, SEEK_DATA);
+		pos =3D vfs_llseek(file, start, SEEK_DATA);
 	if (pos < 0 && pos >=3D (loff_t)-MAX_ERRNO) {
 		if (pos =3D=3D -ENXIO)
 			goto check_space; /* Unallocated tail */
@@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if ((u64)pos >=3D (u64)*_start + *_len)
+	if (pos >=3D start + *_len)
 		goto check_space; /* Unallocated region */
 =

 	/* We have a block that's at least partially filled - if we're low on
@@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_obj=
ect *object,
 =

 	pos =3D cachefiles_inject_read_error();
 	if (pos =3D=3D 0)
-		pos =3D vfs_llseek(file, *_start, SEEK_HOLE);
+		pos =3D vfs_llseek(file, start, SEEK_HOLE);
 	if (pos < 0 && pos >=3D (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), pos,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if ((u64)pos >=3D (u64)*_start + *_len)
+	if (pos >=3D start + *_len)
 		return 0; /* Fully allocated */
 =

 	/* Partially allocated, but insufficient space: cull. */
@@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 	ret =3D cachefiles_inject_remove_error();
 	if (ret =3D=3D 0)
 		ret =3D vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				    *_start, *_len);
+				    start, *_len);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_fallocate_error);


