Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD57487E91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 22:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiAGVxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 16:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbiAGVxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641592382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE+COevnknBiqtTCdliOhVLkvJM1YbFotdDrkwCoLZg=;
        b=TYEqYXqVK1O4JVpuD7sQy0yTxtsUsEJszY5Bg54G2gy372KKPKauVGfWCwoFUB23OH5Caa
        EM3b+FqdDPSXmKJFqEXjdOYMJnSxYJernNiQIlb4c62juTkyOH9OTOrVCJwB3yXLNva2sg
        qlFTsAizmNz/lfaXwsqFTEHlErdc0f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-cVBOfAqEOUKkdaO58wPH6g-1; Fri, 07 Jan 2022 16:52:57 -0500
X-MC-Unique: cVBOfAqEOUKkdaO58wPH6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1332801AAB;
        Fri,  7 Jan 2022 21:52:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD776519D5;
        Fri,  7 Jan 2022 21:52:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk>
References: <164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
To:     linux-cachefs@redhat.com, Steve French <sfrench@samba.org>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 63/68] cifs: Support fscache indexing rewrite (untested)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3419812.1641592362.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 07 Jan 2022 21:52:42 +0000
Message-ID: <3419813.1641592362@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch isn't quite right and needs a fix.  The attached patch fixes it=
.
I'll fold that in and post a v5 of this patch.

David
---
cifs: Fix the fscache cookie management

Fix the fscache cookie management in cifs in the following ways:

 (1) The cookie should be released in cifs_evict_inode() after it has been
     unused from being pinned by cifs_set_page_dirty().

 (2) The cookie shouldn't be released in cifsFileInfo_put_final().  That's
     dealing with closing a file, not getting rid of an inode.  The cookie
     needs to persist beyond the last file close because writepages may
     happen after closure.

 (3) The cookie needs to be used in cifs_atomic_open() to match
     cifs_open().  As yet unknown files being opened for writing seem to g=
o
     by the former route rather than the latter.

This can be triggered by something like:

        # systemctl start cachefilesd
        # mount //carina/test /xfstest.test -o user=3Dshares,pass=3Dxxxx.f=
sc
        # bash 5</xfstest.test/bar
        # echo hello >/xfstest.test/bar

The key is to open the file R/O and then open it R/W and write to it whils=
t
it's still open for R/O.  A cookie isn't acquired if it's just opened R/W
as it goes through the atomic_open method rather than the open method.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/cifs/cifsfs.c |    8 ++++++++
 fs/cifs/dir.c    |    4 ++++
 fs/cifs/file.c   |    2 --
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index d3f3acf340f1..26cf2193c9a2 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -398,6 +398,7 @@ cifs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_FSCACHE_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
+	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
 }
 =

@@ -722,6 +723,12 @@ static int cifs_show_stats(struct seq_file *s, struct=
 dentry *root)
 }
 #endif
 =

+static int cifs_write_inode(struct inode *inode, struct writeback_control=
 *wbc)
+{
+	fscache_unpin_writeback(wbc, cifs_inode_cookie(inode));
+	return 0;
+}
+
 static int cifs_drop_inode(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
@@ -734,6 +741,7 @@ static int cifs_drop_inode(struct inode *inode)
 static const struct super_operations cifs_super_ops =3D {
 	.statfs =3D cifs_statfs,
 	.alloc_inode =3D cifs_alloc_inode,
+	.write_inode	=3D cifs_write_inode,
 	.free_inode =3D cifs_free_inode,
 	.drop_inode	=3D cifs_drop_inode,
 	.evict_inode	=3D cifs_evict_inode,
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 6e8e7cc26ae2..6186824b366e 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -22,6 +22,7 @@
 #include "cifs_unicode.h"
 #include "fs_context.h"
 #include "cifs_ioctl.h"
+#include "fscache.h"
 =

 static void
 renew_parental_timestamps(struct dentry *direntry)
@@ -509,6 +510,9 @@ cifs_atomic_open(struct inode *inode, struct dentry *d=
irentry,
 		rc =3D -ENOMEM;
 	}
 =

+	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
+			   file->f_mode & FMODE_WRITE);
+
 out:
 	cifs_put_tlink(tlink);
 out_free_xid:
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d872f6fe8e7d..44da7646f789 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -376,8 +376,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo=
 *cifs_file)
 	struct cifsLockInfo *li, *tmp;
 	struct super_block *sb =3D inode->i_sb;
 =

-	cifs_fscache_release_inode_cookie(inode);
-
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
 	 * is closed anyway.

