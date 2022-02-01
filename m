Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7908B4A5A63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiBAKoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 05:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235502AbiBAKoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643712255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/n5cQ10kX6yUM4KJqsTSlZEk3f8XfCq+Cr4yb+yBvQ0=;
        b=gjjh/adw+m81yEeOfCQUTMH5xB2EYwWTOxAzNtd/MRxtWy3lV1nLIJvEOy463ybRpOoqN8
        xGZuC+aGd46fcyQUD3UFv4FZHlxFF/AWM8+HC2MRwztN3cneZM7+DD11Yifgyg7do3y67L
        QgEccQWNRDvTbDlUlzgYFlOUlIchEOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-dPZ66ZSgPqm9uQMVeCnm8A-1; Tue, 01 Feb 2022 05:44:12 -0500
X-MC-Unique: dPZ66ZSgPqm9uQMVeCnm8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C938519E3;
        Tue,  1 Feb 2022 10:44:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 629534F840;
        Tue,  1 Feb 2022 10:44:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164364202369.1476539.452557132083658522.stgit@warthog.procyon.org.uk>
References: <164364202369.1476539.452557132083658522.stgit@warthog.procyon.org.uk> <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-cachefs@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] vfs: Add tracepoints for inode_excl_inuse_trylock/unlock
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <738170.1643712246.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 01 Feb 2022 10:44:06 +0000
Message-ID: <738171.1643712246@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I forgot to add the tracepoint header to the commit.

David
---
commit c8cefa2ac359254ecebfb20dcd0676bf9a167277
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jan 31 11:52:44 2022 +0000

    vfs: Add tracepoints for inode_excl_inuse_trylock/unlock
    =

    Add tracepoints for inode_excl_inuse_trylock/unlock() to record succes=
sful
    and lock, failed lock, successful unlock and unlock when it wasn't loc=
ked.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Amir Goldstein <amir73il@gmail.com>
    cc: Miklos Szeredi <miklos@szeredi.hu>
    cc: linux-unionfs@vger.kernel.org
    cc: linux-cachefs@redhat.com

diff --git a/fs/inode.c b/fs/inode.c
index 954719f66113..61b93a89853f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,8 @@
 #include <linux/iversion.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/vfs.h>
 =

 /*
  * Inode locking rules:
@@ -2409,11 +2411,14 @@ EXPORT_SYMBOL(current_time);
 /**
  * inode_excl_inuse_trylock - Try to exclusively lock an inode for kernel=
 access
  * @dentry: Reference to the inode to be locked
+ * @o: Private reference for the kernel service
+ * @who: Which kernel service is trying to gain the lock
  *
  * Try to gain exclusive access to an inode for a kernel service, returni=
ng
  * true if successful.
  */
-bool inode_excl_inuse_trylock(struct dentry *dentry)
+bool inode_excl_inuse_trylock(struct dentry *dentry, unsigned int o,
+			      enum inode_excl_inuse_by who)
 {
 	struct inode *inode =3D d_inode(dentry);
 	bool locked =3D false;
@@ -2421,7 +2426,10 @@ bool inode_excl_inuse_trylock(struct dentry *dentry=
)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & I_EXCL_INUSE)) {
 		inode->i_state |=3D I_EXCL_INUSE;
+		trace_inode_excl_inuse_lock(inode, o, who);
 		locked =3D true;
+	} else {
+		trace_inode_excl_inuse_lock_failed(inode, o, who);
 	}
 	spin_unlock(&inode->i_lock);
 =

@@ -2432,18 +2440,23 @@ EXPORT_SYMBOL(inode_excl_inuse_trylock);
 /**
  * inode_excl_inuse_unlock - Unlock exclusive kernel access to an inode
  * @dentry: Reference to the inode to be unlocked
+ * @o: Private reference for the kernel service
  *
  * Drop exclusive access to an inode for a kernel service.  A warning is =
given
  * if the inode was not marked for exclusive access.
  */
-void inode_excl_inuse_unlock(struct dentry *dentry)
+void inode_excl_inuse_unlock(struct dentry *dentry, unsigned int o)
 {
 	if (dentry) {
 		struct inode *inode =3D d_inode(dentry);
 =

 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_EXCL_INUSE));
-		inode->i_state &=3D ~I_EXCL_INUSE;
+		if (WARN_ON(!(inode->i_state & I_EXCL_INUSE))) {
+			trace_inode_excl_inuse_unlock_bad(inode, o);
+		} else {
+			inode->i_state &=3D ~I_EXCL_INUSE;
+			trace_inode_excl_inuse_unlock(inode, o);
+		}
 		spin_unlock(&inode->i_lock);
 	}
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5c3361a2dc7c..6434ae11496d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -224,10 +224,10 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	dput(ofs->indexdir);
 	dput(ofs->workdir);
 	if (ofs->workdir_locked)
-		inode_excl_inuse_unlock(ofs->workbasedir);
+		inode_excl_inuse_unlock(ofs->workbasedir, 0);
 	dput(ofs->workbasedir);
 	if (ofs->upperdir_locked)
-		inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
+		inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root, 0);
 =

 	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
 	mounts =3D (struct vfsmount **) ofs->layers;
@@ -1239,7 +1239,8 @@ static int ovl_get_upper(struct super_block *sb, str=
uct ovl_fs *ofs,
 	if (upper_mnt->mnt_sb->s_flags & SB_NOSEC)
 		sb->s_flags |=3D SB_NOSEC;
 =

-	if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root)) {
+	if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root, 0,
+				     inode_excl_inuse_by_overlayfs)) {
 		ofs->upperdir_locked =3D true;
 	} else {
 		err =3D ovl_report_in_use(ofs, "upperdir");
@@ -1499,7 +1500,8 @@ static int ovl_get_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
 =

 	ofs->workbasedir =3D dget(workpath.dentry);
 =

-	if (inode_excl_inuse_trylock(ofs->workbasedir)) {
+	if (inode_excl_inuse_trylock(ofs->workbasedir, 0,
+				     inode_excl_inuse_by_overlayfs)) {
 		ofs->workdir_locked =3D true;
 	} else {
 		err =3D ovl_report_in_use(ofs, "workdir");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4c15e270f1ac..f461883d66a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2389,8 +2389,13 @@ static inline bool inode_is_dirtytime_only(struct i=
node *inode)
 				  I_FREEING | I_WILL_FREE)) =3D=3D I_DIRTY_TIME;
 }
 =

-bool inode_excl_inuse_trylock(struct dentry *dentry);
-void inode_excl_inuse_unlock(struct dentry *dentry);
+enum inode_excl_inuse_by {
+	inode_excl_inuse_by_overlayfs,
+};
+
+bool inode_excl_inuse_trylock(struct dentry *dentry, unsigned int o,
+			      enum inode_excl_inuse_by who);
+void inode_excl_inuse_unlock(struct dentry *dentry, unsigned int o);
 =

 static inline bool inode_is_excl_inuse(struct dentry *dentry)
 {
diff --git a/include/trace/events/vfs.h b/include/trace/events/vfs.h
new file mode 100644
index 000000000000..f053752109dd
--- /dev/null
+++ b/include/trace/events/vfs.h
@@ -0,0 +1,134 @@
+/* VFS tracepoints
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vfs
+
+#if !defined(_TRACE_VFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VFS_H
+
+#include <linux/tracepoint.h>
+#include <linux/fs.h>
+
+/*
+ * Define enum -> string mappings for display.
+ */
+#define inode_excl_inuse_by_traces				\
+	EM(inode_excl_inuse_by_cachefiles,	"cachefiles")	\
+	E_(inode_excl_inuse_by_overlayfs,	"overlayfs")
+
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+inode_excl_inuse_by_traces;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings =
that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+
+TRACE_EVENT(inode_excl_inuse_lock,
+	    TP_PROTO(struct inode *inode, unsigned int o,
+		     enum inode_excl_inuse_by who),
+
+	    TP_ARGS(inode, o, who),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			inode		)
+		    __field(unsigned int,		o		)
+		    __field(enum inode_excl_inuse_by,	who		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->inode	=3D inode->i_ino;
+		    __entry->o		=3D o;
+		    __entry->who	=3D who;
+			   ),
+
+	    TP_printk("B=3D%lx %s o=3D%08x",
+		      __entry->inode,
+		      __print_symbolic(__entry->who, inode_excl_inuse_by_traces),
+		      __entry->o)
+	    );
+
+TRACE_EVENT(inode_excl_inuse_lock_failed,
+	    TP_PROTO(struct inode *inode, unsigned int o,
+		     enum inode_excl_inuse_by who),
+
+	    TP_ARGS(inode, o, who),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			inode		)
+		    __field(unsigned int,		o		)
+		    __field(enum inode_excl_inuse_by,	who		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->inode	=3D inode->i_ino;
+		    __entry->o		=3D o;
+		    __entry->who	=3D who;
+			   ),
+
+	    TP_printk("B=3D%lx %s o=3D%08x",
+		      __entry->inode,
+		      __print_symbolic(__entry->who, inode_excl_inuse_by_traces),
+		      __entry->o)
+	    );
+
+TRACE_EVENT(inode_excl_inuse_unlock,
+	    TP_PROTO(struct inode *inode, unsigned int o),
+
+	    TP_ARGS(inode, o),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			inode		)
+		    __field(unsigned int,		o		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->inode	=3D inode->i_ino;
+		    __entry->o		=3D o;
+			   ),
+
+	    TP_printk("B=3D%lx o=3D%08x",
+		      __entry->inode,
+		      __entry->o)
+	    );
+
+TRACE_EVENT(inode_excl_inuse_unlock_bad,
+	    TP_PROTO(struct inode *inode, unsigned int o),
+
+	    TP_ARGS(inode, o),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			inode		)
+		    __field(unsigned int,		o		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->inode	=3D inode->i_ino;
+		    __entry->o		=3D o;
+			   ),
+
+	    TP_printk("B=3D%lx o=3D%08x",
+		      __entry->inode,
+		      __entry->o)
+	    );
+
+#endif /* _TRACE_VFS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

