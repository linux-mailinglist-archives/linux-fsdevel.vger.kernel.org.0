Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0D463FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbhK3VJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 16:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343849AbhK3VJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638306372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovfGlfFYOBiNEdFFUCvznobAjXbygpnoFNwMXB/Sg+Q=;
        b=Mojq/3f57P3vL35aj0nv84JsD8o1gdi/mvMS4s3oIAKQNqVI1DKWLUjsPCF4fEvU4+q9B0
        p59jxUNYO/y5c78ctC9Gp5RIB8W0pOINOvXsCan3498p6r8ady8nmZMKsE7RDeswDeuwRT
        AfcN6HALZ+h75ElLBwp2+1xzPZqx3/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-ojpTxzvvOhGXgffSsKK03g-1; Tue, 30 Nov 2021 16:06:08 -0500
X-MC-Unique: ojpTxzvvOhGXgffSsKK03g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 712C91853026;
        Tue, 30 Nov 2021 21:06:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BABF910013D7;
        Tue, 30 Nov 2021 21:05:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YaZOCk9zxApPattb@archlinux-ax161>
References: <YaZOCk9zxApPattb@archlinux-ax161> <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk> <163819647945.215744.17827962047487125939.stgit@warthog.procyon.org.uk>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 51/64] cachefiles: Implement the I/O routines
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <503521.1638306348.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 30 Nov 2021 21:05:48 +0000
Message-ID: <503522.1638306348@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> wrote:

> This patch as commit 0443b01eccbb ("cachefiles: Implement the I/O
> routines") in -next causes the following clang warning/error:
> =

> fs/cachefiles/io.c:489:6: error: variable 'ret' is used uninitialized wh=
enever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (pos =3D=3D 0)
>             ^~~~~~~~
> fs/cachefiles/io.c:492:6: note: uninitialized use occurs here
>         if (ret < 0) {
>             ^~~
> fs/cachefiles/io.c:489:2: note: remove the 'if' if its condition is alwa=
ys true
>         if (pos =3D=3D 0)
>         ^~~~~~~~~~~~~
> fs/cachefiles/io.c:440:9: note: initialize the variable 'ret' to silence=
 this warning
>         int ret;
>                ^
>                 =3D 0
> 1 error generated.

	pos =3D cachefiles_inject_remove_error();
	if (pos =3D=3D 0)
		ret =3D vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,

That should be:

	ret =3D cachefiles_inject_remove_error();
	if (ret =3D=3D 0)
		ret =3D vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,

David

