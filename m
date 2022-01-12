Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5348BEED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 08:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351180AbiALHU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 02:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351172AbiALHUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641972054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtIbmDuJfaFcyPVq4lejO1YQT8JqBoet7CpPdE4P+Vs=;
        b=IXafCJIzO5ETuapzspmbW7eCTFLED2jMHQYLrrL5fVUTSD3b0+OuR+HQD1cKWLU1MrVjQc
        re6Qcz7KnTqx2dmaiyO19a0hM/73gYAwzOzWK29725Dqvad799ZkgGZvtXdWcCIrP3JGAY
        doKF6sxwm+baPmA5cuGQNgSpJRVaCq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-iG6Fe2TPNT6yCUhnGs8TxA-1; Wed, 12 Jan 2022 02:20:50 -0500
X-MC-Unique: iG6Fe2TPNT6yCUhnGs8TxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158141023F50;
        Wed, 12 Jan 2022 07:20:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 914407B9D2;
        Wed, 12 Jan 2022 07:20:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3462849.1641593783@warthog.procyon.org.uk>
References: <3462849.1641593783@warthog.procyon.org.uk> <164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
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
Subject: Re: [PATCH v5 63/68] cifs: Support fscache indexing rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <534839.1641972040.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 12 Jan 2022 07:20:40 +0000
Message-ID: <534840.1641972040@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

I think this needs the further changes below, which I will fold in.  The
issues are:

 (1) One of the error paths in cifs_atomic_open() uses the cookie when it
     should jump around that.

 (2) There's an additional successful return from the middle of cifs_open(=
)
     that I mistook for an error path, but does need to use the cookie on
     the way out.

David
---
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 6186824b366e..bf3b4c9901b9 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -508,6 +508,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *d=
irentry,
 			server->ops->close(xid, tcon, &fid);
 		cifs_del_pending_open(&open);
 		rc =3D -ENOMEM;
+		goto out;
 	}
 =

 	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 44da7646f789..47333730c963 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -568,7 +568,7 @@ int cifs_open(struct inode *inode, struct file *file)
 			spin_lock(&CIFS_I(inode)->deferred_lock);
 			cifs_del_deferred_close(cfile);
 			spin_unlock(&CIFS_I(inode)->deferred_lock);
-			goto out;
+			goto use_cache;
 		} else {
 			_cifsFileInfo_put(cfile, true, false);
 		}
@@ -630,19 +630,6 @@ int cifs_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 =

-
-	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
-			   file->f_mode & FMODE_WRITE);
-	if (file->f_flags & O_DIRECT &&
-	    (!((file->f_flags & O_ACCMODE) !=3D O_RDONLY) ||
-	     file->f_flags & O_APPEND)) {
-		struct cifs_fscache_inode_coherency_data cd;
-		cifs_fscache_fill_coherency(file_inode(file), &cd);
-		fscache_invalidate(cifs_inode_cookie(file_inode(file)),
-				   &cd, i_size_read(file_inode(file)),
-				   FSCACHE_INVAL_DIO_WRITE);
-	}
-
 	if ((oplock & CIFS_CREATE_ACTION) && !posix_open_ok && tcon->unix_ext) {
 		/*
 		 * Time to set mode which we can not set earlier due to
@@ -661,6 +648,19 @@ int cifs_open(struct inode *inode, struct file *file)
 				       cfile->pid);
 	}
 =

+use_cache:
+	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
+			   file->f_mode & FMODE_WRITE);
+	if (file->f_flags & O_DIRECT &&
+	    (!((file->f_flags & O_ACCMODE) !=3D O_RDONLY) ||
+	     file->f_flags & O_APPEND)) {
+		struct cifs_fscache_inode_coherency_data cd;
+		cifs_fscache_fill_coherency(file_inode(file), &cd);
+		fscache_invalidate(cifs_inode_cookie(file_inode(file)),
+				   &cd, i_size_read(file_inode(file)),
+				   FSCACHE_INVAL_DIO_WRITE);
+	}
+
 out:
 	free_dentry_path(page);
 	free_xid(xid);

