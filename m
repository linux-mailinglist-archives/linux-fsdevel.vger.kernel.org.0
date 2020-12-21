Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56F2DFDF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgLUQPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 11:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgLUQPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608567264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pz/yAs5rX0sVHD5Y48U+8lnqGDDBqT9wqveBThIuwbQ=;
        b=fNDXf4PB84WsRo9eh3IIqyvCusc6r7baLV1B4MRr3UbrU997QgWahAsBZ00pTPGZ8bmsi2
        RI0I3h7RnzlcO1Jty9BnjoHTmLR944RFQ7DEqViR+KGTsUz+BBKgudEJQPlQ2u3v/2xsi7
        6MGzOhdAIgS7RhdiW+YKBgvriVqt1WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-QR4QazMqNPKTYYl5wlkCrQ-1; Mon, 21 Dec 2020 11:14:18 -0500
X-MC-Unique: QR4QazMqNPKTYYl5wlkCrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EAC18C8C00;
        Mon, 21 Dec 2020 16:14:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-204.rdu2.redhat.com [10.10.112.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 189E560C61;
        Mon, 21 Dec 2020 16:14:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Daniel Axtens <dja@axtens.net>
cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <365030.1608567254.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Dec 2020 16:14:14 +0000
Message-ID: <365031.1608567254@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc'ing mailing lists]

Hi Daniel,

CONFIG_FORTIFIED_SOURCE=3Dy now causes an oops in strnlen() from afs (see
attached patch for an explanation).  Is replacing the use with memchr() th=
e
right approach?  Or should I be calling __real_strnlen() or whatever it's
called?

David
---
From: David Howells <dhowells@redhat.com>

afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=3Dy

AFS has a structured layout in its directory contents (AFS dirs are
downloaded as files and parsed locally by the client for lookup/readdir).
The slots in the directory are defined by union afs_xdr_dirent.  This,
however, only directly allows a name of a length that will fit into that
union.  To support a longer name, the next 1-8 contiguous entries are
annexed to the first one and the name flows across these.

afs_dir_iterate_block() uses strnlen(), limited to the space to the end of
the page, to find out how long the name is.  This worked fine until
6a39e62abbaf.  With that commit, the compiler determines the size of the
array and asserts that the string fits inside that array.  This is a
problem for AFS because we *expect* it to overflow one or more arrays.

A similar problem also occurs in afs_dir_scan_block() when a directory fil=
e
is being locally edited to avoid the need to redownload it.  There strlen(=
)
was being used safely because each page has the last byte set to 0 when th=
e
file is downloaded and validated (in afs_dir_check_page()).

Fix this by using memchr() instead and hoping no one changes that to check
the object size.

The issue can be triggered by something like:

        touch /afs/example.com/thisisaveryveryverylongname

and it generates a report that looks like:

        detected buffer overflow in strnlen
        ------------[ cut here ]------------
        kernel BUG at lib/string.c:1149!
        ...
        RIP: 0010:fortify_panic+0xf/0x11
        ...
        Call Trace:
         afs_dir_iterate_block+0x12b/0x35b
         afs_dir_iterate+0x14e/0x1ce
         afs_do_lookup+0x131/0x417
         afs_lookup+0x24f/0x344
         lookup_open.isra.0+0x1bb/0x27d
         open_last_lookups+0x166/0x237
         path_openat+0xe0/0x159
         do_filp_open+0x48/0xa4
         ? kmem_cache_alloc+0xf5/0x16e
         ? __clear_close_on_exec+0x13/0x22
         ? _raw_spin_unlock+0xa/0xb
         do_sys_openat2+0x72/0xde
         do_sys_open+0x3b/0x58
         do_syscall_64+0x2d/0x3a
         entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in forti=
fied string functions")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Daniel Axtens <dja@axtens.net>

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9068d5578a26..4fafb4e4d0df 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -350,6 +350,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvn=
ode,
 				 unsigned blkoff)
 {
 	union afs_xdr_dirent *dire;
+	const u8 *p;
 	unsigned offset, next, curr;
 	size_t nlen;
 	int tmp;
@@ -378,9 +379,15 @@ static int afs_dir_iterate_block(struct afs_vnode *dv=
node,
 =

 		/* got a valid entry */
 		dire =3D &block->dirents[offset];
-		nlen =3D strnlen(dire->u.name,
-			       sizeof(*block) -
-			       offset * sizeof(union afs_xdr_dirent));
+		p =3D memchr(dire->u.name, 0,
+			   sizeof(*block) - offset * sizeof(union afs_xdr_dirent));
+		if (!p) {
+			_debug("ENT[%zu.%u]: %u unterminated dirent name",
+			       blkoff / sizeof(union afs_xdr_dir_block),
+			       offset, next);
+			return afs_bad(dvnode, afs_file_error_dir_over_end);
+		}
+		nlen =3D p - dire->u.name;
 =

 		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
 		       blkoff / sizeof(union afs_xdr_dir_block), offset,
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 2ffe09abae7f..5ee4e992ed8f 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -111,6 +111,8 @@ static int afs_dir_scan_block(union afs_xdr_dir_block =
*block, struct qstr *name,
 			      unsigned int blocknum)
 {
 	union afs_xdr_dirent *de;
+	const u8 *p;
+	unsigned long offset;
 	u64 bitmap;
 	int d, len, n;
 =

@@ -135,7 +137,11 @@ static int afs_dir_scan_block(union afs_xdr_dir_block=
 *block, struct qstr *name,
 			continue;
 =

 		/* The block was NUL-terminated by afs_dir_check_page(). */
-		len =3D strlen(de->u.name);
+		offset =3D (unsigned long)de->u.name & (PAGE_SIZE - 1);
+		p =3D memchr(de->u.name, 0, PAGE_SIZE - offset);
+		if (!p)
+			return -1;
+		len =3D p - de->u.name;
 		if (len =3D=3D name->len &&
 		    memcmp(de->u.name, name->name, name->len) =3D=3D 0)
 			return d;

