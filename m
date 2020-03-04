Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3100817962E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgCDQ7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45466 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729749AbgCDQ7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXMOYhh28M9MIiOvKM7hHDjTfKiVup//8weNBz18dPA=;
        b=Y0kjj3HKZvKJRf+CGjtPY30I90ia4xtW0uww0VN/HOxs6BCdEmE6FVZPLcwQHOFIIqJWlF
        5Is0RX9qF7qQzibvx/WJfOYsnFOJCnDnCJU38wjldxHDIR1Qh3LMin9wEkxuSIkjH1L9YM
        iW1zT8Rb1jkmmuLN/fU0iB9N6VTF2PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7nTI_chPNUaLeyHa9cM3Cw-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: 7nTI_chPNUaLeyHa9cM3Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2252E18C35A0;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1EBF48;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 65DA7225811; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 11/20] fuse: implement FUSE_INIT map_alignment field
Date:   Wed,  4 Mar 2020 11:58:36 -0500
Message-Id: <20200304165845.3081-12-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
constraints via the FUST_INIT map_alignment field.  Parse this field and
ensure our DAX mappings meet the alignment constraints.

We don't actually align anything differently since our mappings are
already 2MB aligned.  Just check the value when the connection is
established.  If it becomes necessary to honor arbitrary alignments in
the future we'll have to adjust how mappings are sized.

The upshot of this commit is that we can be confident that mappings will
work even when emulating x86 on Power and similar combinations where the
host page sizes are different.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           | 19 +++++++++++++++++--
 include/uapi/linux/fuse.h |  4 +++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index edd3136c11f7..b41275f73e4c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,7 +47,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
=20
-/* Default memory range size, 2MB */
+/*
+ * Default memory range size.  A power of 2 so it agrees with common FUS=
E_INIT
+ * map_alignment values 4KB and 64KB.
+ */
 #define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
 #define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
=20
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0ba092bf0b6d..36cb9c00bbe5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -961,9 +961,10 @@ static void process_init_reply(struct fuse_conn *fc,=
 struct fuse_args *args,
 {
 	struct fuse_init_args *ia =3D container_of(args, typeof(*ia), args);
 	struct fuse_init_out *arg =3D &ia->out;
+	bool ok =3D true;
=20
 	if (error || arg->major !=3D FUSE_KERNEL_VERSION)
-		fc->conn_error =3D 1;
+		ok =3D false;
 	else {
 		unsigned long ra_pages;
=20
@@ -1026,6 +1027,14 @@ static void process_init_reply(struct fuse_conn *f=
c, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
+			    (FUSE_DAX_MEM_RANGE_SZ % (1ul << arg->map_alignment))) {
+				printk(KERN_ERR "FUSE: map_alignment %u"
+				       " incompatible with dax mem range size"
+				       " %u\n", arg->map_alignment,
+				       FUSE_DAX_MEM_RANGE_SZ);
+				ok =3D false;
+			}
 		} else {
 			ra_pages =3D fc->max_read / PAGE_SIZE;
 			fc->no_lock =3D 1;
@@ -1041,6 +1050,11 @@ static void process_init_reply(struct fuse_conn *f=
c, struct fuse_args *args,
 	}
 	kfree(ia);
=20
+	if (!ok) {
+		fc->conn_init =3D 0;
+		fc->conn_error =3D 1;
+	}
+
 	fuse_set_initialized(fc);
 	wake_up_all(&fc->blocked_waitq);
 }
@@ -1063,7 +1077,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_MAP_ALIGNMENT;
 	ia->args.opcode =3D FUSE_INIT;
 	ia->args.in_numargs =3D 1;
 	ia->args.in_args[0].size =3D sizeof(ia->in);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..5b85819e045f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -313,7 +313,9 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit re=
quest
- * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignme=
nt) for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
--=20
2.20.1

