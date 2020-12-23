Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0B2E1CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 14:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgLWNuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 08:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbgLWNuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608731359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZGNdOYF1GHguREb96eu7XsayWCYIY8zL6HbhxA/2Gcg=;
        b=dzlDfmlvDPOJa/2tz2cKsVqT+YkhPgNus2HP/glQquFHETgcpJo8+Opmn2o5A5JGlAieGn
        9kK0Kb+CJDYXWjaa8AJFv/jdlyy4mX9l1qT+YNXugQeiZAGUECIij+h83n1/3zHgG0A3HO
        31gNpC1kz/UWKWUlv7jEWfpbMlFHYPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-CinpDOC7NM2ZOKP0xy9grw-1; Wed, 23 Dec 2020 08:49:15 -0500
X-MC-Unique: CinpDOC7NM2ZOKP0xy9grw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3813910054FF;
        Wed, 23 Dec 2020 13:49:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-204.rdu2.redhat.com [10.10.112.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040596F7E5;
        Wed, 23 Dec 2020 13:49:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Work around strnlen() oops with
 CONFIG_FORTIFIED_SOURCE=y
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Dec 2020 13:49:10 +0000
Message-ID: <160873135094.834130.9048269997292829364.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

A similar problem also occurs in afs_dir_scan_block() when a directory file
is being locally edited to avoid the need to redownload it.  There strlen()
was being used safely because each page has the last byte set to 0 when the
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

Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: Daniel Axtens <dja@axtens.net>
---

 fs/afs/dir.c      |   13 ++++++++++---
 fs/afs/dir_edit.c |    8 +++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9068d5578a26..4fafb4e4d0df 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -350,6 +350,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 				 unsigned blkoff)
 {
 	union afs_xdr_dirent *dire;
+	const u8 *p;
 	unsigned offset, next, curr;
 	size_t nlen;
 	int tmp;
@@ -378,9 +379,15 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 
 		/* got a valid entry */
 		dire = &block->dirents[offset];
-		nlen = strnlen(dire->u.name,
-			       sizeof(*block) -
-			       offset * sizeof(union afs_xdr_dirent));
+		p = memchr(dire->u.name, 0,
+			   sizeof(*block) - offset * sizeof(union afs_xdr_dirent));
+		if (!p) {
+			_debug("ENT[%zu.%u]: %u unterminated dirent name",
+			       blkoff / sizeof(union afs_xdr_dir_block),
+			       offset, next);
+			return afs_bad(dvnode, afs_file_error_dir_over_end);
+		}
+		nlen = p - dire->u.name;
 
 		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
 		       blkoff / sizeof(union afs_xdr_dir_block), offset,
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 2ffe09abae7f..5ee4e992ed8f 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -111,6 +111,8 @@ static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
 			      unsigned int blocknum)
 {
 	union afs_xdr_dirent *de;
+	const u8 *p;
+	unsigned long offset;
 	u64 bitmap;
 	int d, len, n;
 
@@ -135,7 +137,11 @@ static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
 			continue;
 
 		/* The block was NUL-terminated by afs_dir_check_page(). */
-		len = strlen(de->u.name);
+		offset = (unsigned long)de->u.name & (PAGE_SIZE - 1);
+		p = memchr(de->u.name, 0, PAGE_SIZE - offset);
+		if (!p)
+			return -1;
+		len = p - de->u.name;
 		if (len == name->len &&
 		    memcmp(de->u.name, name->name, name->len) == 0)
 			return d;


