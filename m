Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390804927CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiARNz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243719AbiARNz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EfFB7ZIFfuTF6X2rzGK7cuS0BwTPAcwqtELraZQ+t4=;
        b=QTNrkAp2CPSjnJPmWYIufhsHTfqmXUZVzQ1Ikhn8B+5oPgnTaCs2yJFJ+Kdvpt+TkNZPBZ
        ARK6DospIEg2xHJosoEtrpfvmf9uTipHaeZNS9DckB+GTq6Zbc9VX6i1etntzMNPHZ1onF
        pGTsEIOZtJrDkN3T4y8GLQADt2TiY3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-iwlMYiPcMgCVAcycCsIbcQ-1; Tue, 18 Jan 2022 08:55:23 -0500
X-MC-Unique: iwlMYiPcMgCVAcycCsIbcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEE68143EA;
        Tue, 18 Jan 2022 13:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415D56E1E8;
        Tue, 18 Jan 2022 13:55:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/11] cifs: Support fscache indexing rewrite
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jan 2022 13:55:13 +0000
Message-ID: <164251411336.3435901.17077059669994001060.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the cifs filesystem to take account of the changes to fscache's
indexing rewrite and reenable caching in cifs.

The following changes have been made:

 (1) The fscache_netfs struct is no more, and there's no need to register
     the filesystem as a whole.

 (2) The session cookie is now an fscache_volume cookie, allocated with
     fscache_acquire_volume().  That takes three parameters: a string
     representing the "volume" in the index, a string naming the cache to
     use (or NULL) and a u64 that conveys coherency metadata for the
     volume.

     For cifs, I've made it render the volume name string as:

	"cifs,<ipaddress>,<sharename>"

     where the sharename has '/' characters replaced with ';'.

     This probably needs rethinking a bit as the total name could exceed
     the maximum filename component length.

     Further, the coherency data is currently just set to 0.  It needs
     something else doing with it - I wonder if it would suffice simply to
     sum the resource_id, vol_create_time and vol_serial_number or maybe
     hash them.

 (3) The fscache_cookie_def is no more and needed information is passed
     directly to fscache_acquire_cookie().  The cache no longer calls back
     into the filesystem, but rather metadata changes are indicated at
     other times.

     fscache_acquire_cookie() is passed the same keying and coherency
     information as before.

 (4) The functions to set/reset cookies are removed and
     fscache_use_cookie() and fscache_unuse_cookie() are used instead.

     fscache_use_cookie() is passed a flag to indicate if the cookie is
     opened for writing.  fscache_unuse_cookie() is passed updates for the
     metadata if we changed it (ie. if the file was opened for writing).

     These are called when the file is opened or closed.

 (5) cifs_setattr_*() are made to call fscache_resize() to change the size
     of the cache object.

 (6) The functions to read and write data are stubbed out pending a
     conversion to use netfslib.

Changes
=======
ver #7:
 - Removed the accidentally added-back call to get the super cookie in
   cifs_root_iget().
 - Fixed the right call to cifs_fscache_get_super_cookie() to take account
   of the "-o fsc" mount flag.

ver #6:
 - Moved the change of gfpflags_allow_blocking() to current_is_kswapd() for
   cifs here.
 - Fixed one of the error paths in cifs_atomic_open() to jump around the
   call to use the cookie.
 - Fixed an additional successful return in the middle of cifs_open() to
   use the cookie on the way out.
 - Only get a volume cookie (and thus inode cookies) when "-o fsc" is
   supplied to mount.

ver #5:
 - Fixed a couple of bits of cookie handling[2]:
   - The cookie should be released in cifs_evict_inode(), not
     cifsFileInfo_put_final().  The cookie needs to persist beyond file
     closure so that writepages will be able to write to it.
   - fscache_use_cookie() needs to be called in cifs_atomic_open() as it is
     for cifs_open().

ver #4:
 - Fixed the use of sizeof with memset.
 - tcon->vol_create_time is __le64 so doesn't need cpu_to_le64().

ver #3:
 - Canonicalise the cifs coherency data to make the cache portable.
 - Set volume coherency data.

ver #2:
 - Use gfpflags_allow_blocking() rather than using flag directly.
 - Upgraded to -rc4 to allow for upstream changes[1].
 - fscache_acquire_volume() now returns errors.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: Steve French <smfrench@gmail.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23b55d673d7527b093cd97b7c217c82e70cd1af0 [1]
Link: https://lore.kernel.org/r/3419813.1641592362@warthog.procyon.org.uk/ [2]
Link: https://lore.kernel.org/r/163819671009.215744.11230627184193298714.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906982979.143852.10672081929614953210.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967187187.1823006.247415138444991444.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/3462849.1641593783@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/1318953.1642024578@warthog.procyon.org.uk/ # v6
---

 fs/cifs/Kconfig    |    2 
 fs/cifs/Makefile   |    2 
 fs/cifs/cache.c    |  105 ----------------
 fs/cifs/cifsfs.c   |   19 ++-
 fs/cifs/cifsglob.h |    5 -
 fs/cifs/connect.c  |   15 --
 fs/cifs/dir.c      |    5 +
 fs/cifs/file.c     |   70 +++++++----
 fs/cifs/fscache.c  |  333 ++++++++++++----------------------------------------
 fs/cifs/fscache.h  |  126 ++++++--------------
 fs/cifs/inode.c    |   19 ++-
 11 files changed, 197 insertions(+), 504 deletions(-)
 delete mode 100644 fs/cifs/cache.c

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 346ae8716deb..3b7e3b9e4fd2 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -188,7 +188,7 @@ config CIFS_SMB_DIRECT
 
 config CIFS_FSCACHE
 	bool "Provide CIFS client caching support"
-	depends on CIFS=m && FSCACHE_OLD_API || CIFS=y && FSCACHE_OLD_API=y
+	depends on CIFS=m && FSCACHE || CIFS=y && FSCACHE=y
 	help
 	  Makes CIFS FS-Cache capable. Say Y here if you want your CIFS data
 	  to be cached locally on disk through the general filesystem cache
diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index 87fcacdf3de7..cc8fdcb35b71 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -25,7 +25,7 @@ cifs-$(CONFIG_CIFS_DFS_UPCALL) += cifs_dfs_ref.o dfs_cache.o
 
 cifs-$(CONFIG_CIFS_SWN_UPCALL) += netlink.o cifs_swn.o
 
-cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o cache.o
+cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o
 
 cifs-$(CONFIG_CIFS_SMB_DIRECT) += smbdirect.o
 
diff --git a/fs/cifs/cache.c b/fs/cifs/cache.c
deleted file mode 100644
index 8be57aaedab6..000000000000
--- a/fs/cifs/cache.c
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-/*
- *   CIFS filesystem cache index structure definitions
- *
- *   Copyright (c) 2010 Novell, Inc.
- *   Authors(s): Suresh Jayaraman (sjayaraman@suse.de>
- *
- */
-#include "fscache.h"
-#include "cifs_debug.h"
-
-/*
- * CIFS filesystem definition for FS-Cache
- */
-struct fscache_netfs cifs_fscache_netfs = {
-	.name = "cifs",
-	.version = 0,
-};
-
-/*
- * Register CIFS for caching with FS-Cache
- */
-int cifs_fscache_register(void)
-{
-	return fscache_register_netfs(&cifs_fscache_netfs);
-}
-
-/*
- * Unregister CIFS for caching
- */
-void cifs_fscache_unregister(void)
-{
-	fscache_unregister_netfs(&cifs_fscache_netfs);
-}
-
-/*
- * Server object for FS-Cache
- */
-const struct fscache_cookie_def cifs_fscache_server_index_def = {
-	.name = "CIFS.server",
-	.type = FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-static enum
-fscache_checkaux cifs_fscache_super_check_aux(void *cookie_netfs_data,
-					      const void *data,
-					      uint16_t datalen,
-					      loff_t object_size)
-{
-	struct cifs_fscache_super_auxdata auxdata;
-	const struct cifs_tcon *tcon = cookie_netfs_data;
-
-	if (datalen != sizeof(auxdata))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.resource_id = tcon->resource_id;
-	auxdata.vol_create_time = tcon->vol_create_time;
-	auxdata.vol_serial_number = tcon->vol_serial_number;
-
-	if (memcmp(data, &auxdata, datalen) != 0)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	return FSCACHE_CHECKAUX_OKAY;
-}
-
-/*
- * Superblock object for FS-Cache
- */
-const struct fscache_cookie_def cifs_fscache_super_index_def = {
-	.name = "CIFS.super",
-	.type = FSCACHE_COOKIE_TYPE_INDEX,
-	.check_aux = cifs_fscache_super_check_aux,
-};
-
-static enum
-fscache_checkaux cifs_fscache_inode_check_aux(void *cookie_netfs_data,
-					      const void *data,
-					      uint16_t datalen,
-					      loff_t object_size)
-{
-	struct cifs_fscache_inode_auxdata auxdata;
-	struct cifsInodeInfo *cifsi = cookie_netfs_data;
-
-	if (datalen != sizeof(auxdata))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (memcmp(data, &auxdata, datalen) != 0)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	return FSCACHE_CHECKAUX_OKAY;
-}
-
-const struct fscache_cookie_def cifs_fscache_inode_object_def = {
-	.name		= "CIFS.uniqueid",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= cifs_fscache_inode_check_aux,
-};
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index dca42aa87d30..26cf2193c9a2 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -396,6 +396,9 @@ static void
 cifs_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
+	if (inode->i_state & I_PINNING_FSCACHE_WB)
+		cifs_fscache_unuse_inode_cookie(inode, true);
+	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
 }
 
@@ -720,6 +723,12 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 }
 #endif
 
+static int cifs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	fscache_unpin_writeback(wbc, cifs_inode_cookie(inode));
+	return 0;
+}
+
 static int cifs_drop_inode(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -732,6 +741,7 @@ static int cifs_drop_inode(struct inode *inode)
 static const struct super_operations cifs_super_ops = {
 	.statfs = cifs_statfs,
 	.alloc_inode = cifs_alloc_inode,
+	.write_inode	= cifs_write_inode,
 	.free_inode = cifs_free_inode,
 	.drop_inode	= cifs_drop_inode,
 	.evict_inode	= cifs_evict_inode,
@@ -1624,13 +1634,9 @@ init_cifs(void)
 		goto out_destroy_cifsoplockd_wq;
 	}
 
-	rc = cifs_fscache_register();
-	if (rc)
-		goto out_destroy_deferredclose_wq;
-
 	rc = cifs_init_inodecache();
 	if (rc)
-		goto out_unreg_fscache;
+		goto out_destroy_deferredclose_wq;
 
 	rc = cifs_init_mids();
 	if (rc)
@@ -1692,8 +1698,6 @@ init_cifs(void)
 	cifs_destroy_mids();
 out_destroy_inodecache:
 	cifs_destroy_inodecache();
-out_unreg_fscache:
-	cifs_fscache_unregister();
 out_destroy_deferredclose_wq:
 	destroy_workqueue(deferredclose_wq);
 out_destroy_cifsoplockd_wq:
@@ -1729,7 +1733,6 @@ exit_cifs(void)
 	cifs_destroy_request_bufs();
 	cifs_destroy_mids();
 	cifs_destroy_inodecache();
-	cifs_fscache_unregister();
 	destroy_workqueue(deferredclose_wq);
 	destroy_workqueue(cifsoplockd_wq);
 	destroy_workqueue(decrypt_wq);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index be74606724c7..ba6fbb1ad8f3 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -659,9 +659,6 @@ struct TCP_Server_Info {
 	unsigned int total_read; /* total amount of data read in this pass */
 	atomic_t in_send; /* requests trying to send */
 	atomic_t num_waiters;   /* blocked waiting to get in sendrecv */
-#ifdef CONFIG_CIFS_FSCACHE
-	struct fscache_cookie   *fscache; /* client index cache cookie */
-#endif
 #ifdef CONFIG_CIFS_STATS2
 	atomic_t num_cmds[NUMBER_OF_SMB2_COMMANDS]; /* total requests by cmd */
 	atomic_t smb2slowcmd[NUMBER_OF_SMB2_COMMANDS]; /* count resps > 1 sec */
@@ -1117,7 +1114,7 @@ struct cifs_tcon {
 	__u32 max_bytes_copy;
 #ifdef CONFIG_CIFS_FSCACHE
 	u64 resource_id;		/* server resource id */
-	struct fscache_cookie *fscache;	/* cookie for share */
+	struct fscache_volume *fscache;	/* cookie for share */
 #endif
 	struct list_head pending_opens;	/* list of incomplete opens */
 	struct cached_fid crfid; /* Cached root fid */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1060164b984a..598be9890f2a 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1396,10 +1396,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 
 	cifs_crypto_secmech_release(server);
 
-	/* fscache server cookies are based on primary channel only */
-	if (!CIFS_SERVER_IS_CHAN(server))
-		cifs_fscache_release_client_cookie(server);
-
 	kfree(server->session_key.response);
 	server->session_key.response = NULL;
 	server->session_key.len = 0;
@@ -1559,14 +1555,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	list_add(&tcp_ses->tcp_ses_list, &cifs_tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	/* fscache server cookies are based on primary channel only */
-	if (!CIFS_SERVER_IS_CHAN(tcp_ses))
-		cifs_fscache_get_client_cookie(tcp_ses);
-#ifdef CONFIG_CIFS_FSCACHE
-	else
-		tcp_ses->fscache = tcp_ses->primary_server->fscache;
-#endif /* CONFIG_CIFS_FSCACHE */
-
 	/* queue echo request delayed work */
 	queue_delayed_work(cifsiod_wq, &tcp_ses->echo, tcp_ses->echo_interval);
 
@@ -3069,7 +3057,8 @@ static int mount_get_conns(struct mount_ctx *mnt_ctx)
 	 * Inside cifs_fscache_get_super_cookie it checks
 	 * that we do not get super cookie twice.
 	 */
-	cifs_fscache_get_super_cookie(tcon);
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_FSCACHE)
+		cifs_fscache_get_super_cookie(tcon);
 
 out:
 	mnt_ctx->server = server;
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 6e8e7cc26ae2..ce9b22aecfba 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -22,6 +22,7 @@
 #include "cifs_unicode.h"
 #include "fs_context.h"
 #include "cifs_ioctl.h"
+#include "fscache.h"
 
 static void
 renew_parental_timestamps(struct dentry *direntry)
@@ -507,8 +508,12 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 			server->ops->close(xid, tcon, &fid);
 		cifs_del_pending_open(&open);
 		rc = -ENOMEM;
+		goto out;
 	}
 
+	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
+			   file->f_mode & FMODE_WRITE);
+
 out:
 	cifs_put_tlink(tlink);
 out_free_xid:
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9fee3af83a73..fb77ca1a15d8 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -376,8 +376,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	struct cifsLockInfo *li, *tmp;
 	struct super_block *sb = inode->i_sb;
 
-	cifs_fscache_release_inode_cookie(inode);
-
 	/*
 	 * Delete any outstanding lock records. We'll lose them when the file
 	 * is closed anyway.
@@ -570,7 +568,7 @@ int cifs_open(struct inode *inode, struct file *file)
 			spin_lock(&CIFS_I(inode)->deferred_lock);
 			cifs_del_deferred_close(cfile);
 			spin_unlock(&CIFS_I(inode)->deferred_lock);
-			goto out;
+			goto use_cache;
 		} else {
 			_cifsFileInfo_put(cfile, true, false);
 		}
@@ -632,8 +630,6 @@ int cifs_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	cifs_fscache_set_inode_cookie(inode, file);
-
 	if ((oplock & CIFS_CREATE_ACTION) && !posix_open_ok && tcon->unix_ext) {
 		/*
 		 * Time to set mode which we can not set earlier due to
@@ -652,6 +648,19 @@ int cifs_open(struct inode *inode, struct file *file)
 				       cfile->pid);
 	}
 
+use_cache:
+	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
+			   file->f_mode & FMODE_WRITE);
+	if (file->f_flags & O_DIRECT &&
+	    (!((file->f_flags & O_ACCMODE) != O_RDONLY) ||
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
@@ -876,6 +885,8 @@ int cifs_close(struct inode *inode, struct file *file)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_deferred_close *dclose;
 
+	cifs_fscache_unuse_inode_cookie(inode, file->f_mode & FMODE_WRITE);
+
 	if (file->private_data != NULL) {
 		cfile = file->private_data;
 		file->private_data = NULL;
@@ -886,7 +897,6 @@ int cifs_close(struct inode *inode, struct file *file)
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
 				inode->i_ctime = inode->i_mtime = current_time(inode);
-				cifs_fscache_update_inode_cookie(inode);
 			}
 			spin_lock(&cinode->deferred_lock);
 			cifs_add_deferred_close(cfile, dclose);
@@ -4198,10 +4208,12 @@ static vm_fault_t
 cifs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct file *file = vmf->vma->vm_file;
-	struct inode *inode = file_inode(file);
 
-	cifs_fscache_wait_on_page_write(inode, page);
+#ifdef CONFIG_CIFS_FSCACHE
+	if (PageFsCache(page) &&
+	    wait_on_page_fscache_killable(page) < 0)
+		return VM_FAULT_RETRY;
+#endif
 
 	lock_page(page);
 	return VM_FAULT_LOCKED;
@@ -4275,8 +4287,6 @@ cifs_readv_complete(struct work_struct *work)
 		if (rdata->result == 0 ||
 		    (rdata->result == -EAGAIN && got_bytes))
 			cifs_readpage_to_fscache(rdata->mapping->host, page);
-		else
-			cifs_fscache_uncache_page(rdata->mapping->host, page);
 
 		got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
 
@@ -4593,11 +4603,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		kref_put(&rdata->refcount, cifs_readdata_release);
 	}
 
-	/* Any pages that have been shown to fscache but didn't get added to
-	 * the pagecache must be uncached before they get returned to the
-	 * allocator.
-	 */
-	cifs_fscache_readpages_cancel(mapping->host, page_list);
 	free_xid(xid);
 	return rc;
 }
@@ -4801,17 +4806,19 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
 {
 	if (PagePrivate(page))
 		return 0;
-
-	return cifs_fscache_release_page(page, gfp);
+	if (PageFsCache(page)) {
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+	fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
+	return true;
 }
 
 static void cifs_invalidate_page(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
-	struct cifsInodeInfo *cifsi = CIFS_I(page->mapping->host);
-
-	if (offset == 0 && length == PAGE_SIZE)
-		cifs_fscache_invalidate_page(page, &cifsi->vfs_inode);
+	wait_on_page_fscache(page);
 }
 
 static int cifs_launder_page(struct page *page)
@@ -4831,7 +4838,7 @@ static int cifs_launder_page(struct page *page)
 	if (clear_page_dirty_for_io(page))
 		rc = cifs_writepage_locked(page, &wbc);
 
-	cifs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
 	return rc;
 }
 
@@ -4988,6 +4995,19 @@ static void cifs_swap_deactivate(struct file *file)
 	/* do we need to unpin (or unlock) the file */
 }
 
+/*
+ * Mark a page as having been made dirty and thus needing writeback.  We also
+ * need to pin the cache object to write back to.
+ */
+#ifdef CONFIG_CIFS_FSCACHE
+static int cifs_set_page_dirty(struct page *page)
+{
+	return fscache_set_page_dirty(page, cifs_inode_cookie(page->mapping->host));
+}
+#else
+#define cifs_set_page_dirty __set_page_dirty_nobuffers
+#endif
+
 const struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
 	.readpages = cifs_readpages,
@@ -4995,7 +5015,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.set_page_dirty = cifs_set_page_dirty,
 	.releasepage = cifs_release_page,
 	.direct_IO = cifs_direct_io,
 	.invalidatepage = cifs_invalidate_page,
@@ -5020,7 +5040,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.set_page_dirty = cifs_set_page_dirty,
 	.releasepage = cifs_release_page,
 	.invalidatepage = cifs_invalidate_page,
 	.launder_page = cifs_launder_page,
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 003c5f1f4dfb..efaac4d5ff55 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -12,250 +12,136 @@
 #include "cifs_fs_sb.h"
 #include "cifsproto.h"
 
-/*
- * Key layout of CIFS server cache index object
- */
-struct cifs_server_key {
-	__u64 conn_id;
-} __packed;
-
-/*
- * Get a cookie for a server object keyed by {IPaddress,port,family} tuple
- */
-void cifs_fscache_get_client_cookie(struct TCP_Server_Info *server)
-{
-	struct cifs_server_key key;
-
-	/*
-	 * Check if cookie was already initialized so don't reinitialize it.
-	 * In the future, as we integrate with newer fscache features,
-	 * we may want to instead add a check if cookie has changed
-	 */
-	if (server->fscache)
-		return;
-
-	memset(&key, 0, sizeof(key));
-	key.conn_id = server->conn_id;
-
-	server->fscache =
-		fscache_acquire_cookie(cifs_fscache_netfs.primary_index,
-				       &cifs_fscache_server_index_def,
-				       &key, sizeof(key),
-				       NULL, 0,
-				       server, 0, true);
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
-		 __func__, server, server->fscache);
-}
-
-void cifs_fscache_release_client_cookie(struct TCP_Server_Info *server)
+static void cifs_fscache_fill_volume_coherency(
+	struct cifs_tcon *tcon,
+	struct cifs_fscache_volume_coherency_data *cd)
 {
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
-		 __func__, server, server->fscache);
-	fscache_relinquish_cookie(server->fscache, NULL, false);
-	server->fscache = NULL;
+	memset(cd, 0, sizeof(*cd));
+	cd->resource_id		= cpu_to_le64(tcon->resource_id);
+	cd->vol_create_time	= tcon->vol_create_time;
+	cd->vol_serial_number	= cpu_to_le32(tcon->vol_serial_number);
 }
 
-void cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
+int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 {
+	struct cifs_fscache_volume_coherency_data cd;
 	struct TCP_Server_Info *server = tcon->ses->server;
+	struct fscache_volume *vcookie;
+	const struct sockaddr *sa = (struct sockaddr *)&server->dstaddr;
+	size_t slen, i;
 	char *sharename;
-	struct cifs_fscache_super_auxdata auxdata;
+	char *key;
+	int ret = -ENOMEM;
 
-	/*
-	 * Check if cookie was already initialized so don't reinitialize it.
-	 * In the future, as we integrate with newer fscache features,
-	 * we may want to instead add a check if cookie has changed
-	 */
-	if (tcon->fscache)
-		return;
+	tcon->fscache = NULL;
+	switch (sa->sa_family) {
+	case AF_INET:
+	case AF_INET6:
+		break;
+	default:
+		cifs_dbg(VFS, "Unknown network family '%d'\n", sa->sa_family);
+		return -EINVAL;
+	}
+
+	memset(&key, 0, sizeof(key));
 
 	sharename = extract_sharename(tcon->treeName);
 	if (IS_ERR(sharename)) {
 		cifs_dbg(FYI, "%s: couldn't extract sharename\n", __func__);
-		tcon->fscache = NULL;
-		return;
+		return -EINVAL;
 	}
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.resource_id = tcon->resource_id;
-	auxdata.vol_create_time = tcon->vol_create_time;
-	auxdata.vol_serial_number = tcon->vol_serial_number;
+	slen = strlen(sharename);
+	for (i = 0; i < slen; i++)
+		if (sharename[i] == '/')
+			sharename[i] = ';';
+
+	key = kasprintf(GFP_KERNEL, "cifs,%pISpc,%s", sa, sharename);
+	if (!key)
+		goto out;
+
+	cifs_fscache_fill_volume_coherency(tcon, &cd);
+	vcookie = fscache_acquire_volume(key,
+					 NULL, /* preferred_cache */
+					 &cd, sizeof(cd));
+	cifs_dbg(FYI, "%s: (%s/0x%p)\n", __func__, key, vcookie);
+	if (IS_ERR(vcookie)) {
+		if (vcookie != ERR_PTR(-EBUSY)) {
+			ret = PTR_ERR(vcookie);
+			goto out_2;
+		}
+		pr_err("Cache volume key already in use (%s)\n", key);
+		vcookie = NULL;
+	}
 
-	tcon->fscache =
-		fscache_acquire_cookie(server->fscache,
-				       &cifs_fscache_super_index_def,
-				       sharename, strlen(sharename),
-				       &auxdata, sizeof(auxdata),
-				       tcon, 0, true);
+	tcon->fscache = vcookie;
+	ret = 0;
+out_2:
+	kfree(key);
+out:
 	kfree(sharename);
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
-		 __func__, server->fscache, tcon->fscache);
+	return ret;
 }
 
 void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon)
 {
-	struct cifs_fscache_super_auxdata auxdata;
-
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.resource_id = tcon->resource_id;
-	auxdata.vol_create_time = tcon->vol_create_time;
-	auxdata.vol_serial_number = tcon->vol_serial_number;
+	struct cifs_fscache_volume_coherency_data cd;
 
 	cifs_dbg(FYI, "%s: (0x%p)\n", __func__, tcon->fscache);
-	fscache_relinquish_cookie(tcon->fscache, &auxdata, false);
-	tcon->fscache = NULL;
-}
-
-static void cifs_fscache_acquire_inode_cookie(struct cifsInodeInfo *cifsi,
-					      struct cifs_tcon *tcon)
-{
-	struct cifs_fscache_inode_auxdata auxdata;
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
-
-	cifsi->fscache =
-		fscache_acquire_cookie(tcon->fscache,
-				       &cifs_fscache_inode_object_def,
-				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
-				       &auxdata, sizeof(auxdata),
-				       cifsi, cifsi->vfs_inode.i_size, true);
+	cifs_fscache_fill_volume_coherency(tcon, &cd);
+	fscache_relinquish_volume(tcon->fscache, &cd, false);
+	tcon->fscache = NULL;
 }
 
-static void cifs_fscache_enable_inode_cookie(struct inode *inode)
+void cifs_fscache_get_inode_cookie(struct inode *inode)
 {
+	struct cifs_fscache_inode_coherency_data cd;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
-	if (cifsi->fscache)
-		return;
-
-	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_FSCACHE))
-		return;
-
-	cifs_fscache_acquire_inode_cookie(cifsi, tcon);
+	cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
 
-	cifs_dbg(FYI, "%s: got FH cookie (0x%p/0x%p)\n",
-		 __func__, tcon->fscache, cifsi->fscache);
+	cifsi->fscache =
+		fscache_acquire_cookie(tcon->fscache, 0,
+				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
+				       &cd, sizeof(cd),
+				       i_size_read(&cifsi->vfs_inode));
 }
 
-void cifs_fscache_release_inode_cookie(struct inode *inode)
+void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
 {
-	struct cifs_fscache_inode_auxdata auxdata;
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-
-	if (cifsi->fscache) {
-		memset(&auxdata, 0, sizeof(auxdata));
-		auxdata.eof = cifsi->server_eof;
-		auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
-		auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
-		auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
-		auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
+	if (update) {
+		struct cifs_fscache_inode_coherency_data cd;
+		loff_t i_size = i_size_read(inode);
 
-		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
-		/* fscache_relinquish_cookie does not seem to update auxdata */
-		fscache_update_cookie(cifsi->fscache, &auxdata);
-		fscache_relinquish_cookie(cifsi->fscache, &auxdata, false);
-		cifsi->fscache = NULL;
+		cifs_fscache_fill_coherency(inode, &cd);
+		fscache_unuse_cookie(cifs_inode_cookie(inode), &cd, &i_size);
+	} else {
+		fscache_unuse_cookie(cifs_inode_cookie(inode), NULL, NULL);
 	}
 }
 
-void cifs_fscache_update_inode_cookie(struct inode *inode)
+void cifs_fscache_release_inode_cookie(struct inode *inode)
 {
-	struct cifs_fscache_inode_auxdata auxdata;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 
 	if (cifsi->fscache) {
-		memset(&auxdata, 0, sizeof(auxdata));
-		auxdata.eof = cifsi->server_eof;
-		auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
-		auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
-		auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
-		auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
-
 		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
-		fscache_update_cookie(cifsi->fscache, &auxdata);
-	}
-}
-
-void cifs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
-{
-	cifs_fscache_enable_inode_cookie(inode);
-}
-
-void cifs_fscache_reset_inode_cookie(struct inode *inode)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
-	struct fscache_cookie *old = cifsi->fscache;
-
-	if (cifsi->fscache) {
-		/* retire the current fscache cache and get a new one */
-		fscache_relinquish_cookie(cifsi->fscache, NULL, true);
-
-		cifs_fscache_acquire_inode_cookie(cifsi, tcon);
-		cifs_dbg(FYI, "%s: new cookie 0x%p oldcookie 0x%p\n",
-			 __func__, cifsi->fscache, old);
+		fscache_relinquish_cookie(cifsi->fscache, false);
+		cifsi->fscache = NULL;
 	}
 }
 
-int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		struct inode *inode = page->mapping->host;
-		struct cifsInodeInfo *cifsi = CIFS_I(inode);
-
-		cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
-			 __func__, page, cifsi->fscache);
-		if (!fscache_maybe_release_page(cifsi->fscache, page, gfp))
-			return 0;
-	}
-
-	return 1;
-}
-
-static void cifs_readpage_from_fscache_complete(struct page *page, void *ctx,
-						int error)
-{
-	cifs_dbg(FYI, "%s: (0x%p/%d)\n", __func__, page, error);
-	if (!error)
-		SetPageUptodate(page);
-	unlock_page(page);
-}
-
 /*
  * Retrieve a page from FS-Cache
  */
 int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 {
-	int ret;
-
 	cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
 		 __func__, CIFS_I(inode)->fscache, page, inode);
-	ret = fscache_read_or_alloc_page(CIFS_I(inode)->fscache, page,
-					 cifs_readpage_from_fscache_complete,
-					 NULL,
-					 GFP_KERNEL);
-	switch (ret) {
-
-	case 0: /* page found in fscache, read submitted */
-		cifs_dbg(FYI, "%s: submitted\n", __func__);
-		return ret;
-	case -ENOBUFS:	/* page won't be cached */
-	case -ENODATA:	/* page not in cache */
-		cifs_dbg(FYI, "%s: %d\n", __func__, ret);
-		return 1;
-
-	default:
-		cifs_dbg(VFS, "unknown error ret = %d\n", ret);
-	}
-	return ret;
+	return -ENOBUFS; // Needs conversion to using netfslib
 }
 
 /*
@@ -266,78 +152,19 @@ int __cifs_readpages_from_fscache(struct inode *inode,
 				struct list_head *pages,
 				unsigned *nr_pages)
 {
-	int ret;
-
 	cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
 		 __func__, CIFS_I(inode)->fscache, *nr_pages, inode);
-	ret = fscache_read_or_alloc_pages(CIFS_I(inode)->fscache, mapping,
-					  pages, nr_pages,
-					  cifs_readpage_from_fscache_complete,
-					  NULL,
-					  mapping_gfp_mask(mapping));
-	switch (ret) {
-	case 0:	/* read submitted to the cache for all pages */
-		cifs_dbg(FYI, "%s: submitted\n", __func__);
-		return ret;
-
-	case -ENOBUFS:	/* some pages are not cached and can't be */
-	case -ENODATA:	/* some pages are not cached */
-		cifs_dbg(FYI, "%s: no page\n", __func__);
-		return 1;
-
-	default:
-		cifs_dbg(FYI, "unknown error ret = %d\n", ret);
-	}
-
-	return ret;
+	return -ENOBUFS; // Needs conversion to using netfslib
 }
 
 void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	int ret;
 
 	WARN_ON(!cifsi->fscache);
 
 	cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
 		 __func__, cifsi->fscache, page, inode);
-	ret = fscache_write_page(cifsi->fscache, page,
-				 cifsi->vfs_inode.i_size, GFP_KERNEL);
-	if (ret != 0)
-		fscache_uncache_page(cifsi->fscache, page);
-}
-
-void __cifs_fscache_readpages_cancel(struct inode *inode, struct list_head *pages)
-{
-	cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
-		 __func__, CIFS_I(inode)->fscache, inode);
-	fscache_readpages_cancel(CIFS_I(inode)->fscache, pages);
-}
-
-void __cifs_fscache_invalidate_page(struct page *page, struct inode *inode)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
-
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_wait_on_page_write(cookie, page);
-	fscache_uncache_page(cookie, page);
-}
-
-void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
-
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_wait_on_page_write(cookie, page);
-}
-
-void __cifs_fscache_uncache_page(struct inode *inode, struct page *page)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
 
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_uncache_page(cookie, page);
+	// Needs conversion to using netfslib
 }
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 9baa1d0f22bd..0fc3f9252c84 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -13,84 +13,62 @@
 
 #include "cifsglob.h"
 
-#ifdef CONFIG_CIFS_FSCACHE
-
 /*
- * Auxiliary data attached to CIFS superblock within the cache
+ * Coherency data attached to CIFS volume within the cache
  */
-struct cifs_fscache_super_auxdata {
-	u64	resource_id;		/* unique server resource id */
+struct cifs_fscache_volume_coherency_data {
+	__le64	resource_id;		/* unique server resource id */
 	__le64	vol_create_time;
-	u32	vol_serial_number;
+	__le32	vol_serial_number;
 } __packed;
 
 /*
- * Auxiliary data attached to CIFS inode within the cache
+ * Coherency data attached to CIFS inode within the cache.
  */
-struct cifs_fscache_inode_auxdata {
-	u64 last_write_time_sec;
-	u64 last_change_time_sec;
-	u32 last_write_time_nsec;
-	u32 last_change_time_nsec;
-	u64 eof;
+struct cifs_fscache_inode_coherency_data {
+	__le64 last_write_time_sec;
+	__le64 last_change_time_sec;
+	__le32 last_write_time_nsec;
+	__le32 last_change_time_nsec;
 };
 
-/*
- * cache.c
- */
-extern struct fscache_netfs cifs_fscache_netfs;
-extern const struct fscache_cookie_def cifs_fscache_server_index_def;
-extern const struct fscache_cookie_def cifs_fscache_super_index_def;
-extern const struct fscache_cookie_def cifs_fscache_inode_object_def;
-
-extern int cifs_fscache_register(void);
-extern void cifs_fscache_unregister(void);
+#ifdef CONFIG_CIFS_FSCACHE
 
 /*
  * fscache.c
  */
-extern void cifs_fscache_get_client_cookie(struct TCP_Server_Info *);
-extern void cifs_fscache_release_client_cookie(struct TCP_Server_Info *);
-extern void cifs_fscache_get_super_cookie(struct cifs_tcon *);
+extern int cifs_fscache_get_super_cookie(struct cifs_tcon *);
 extern void cifs_fscache_release_super_cookie(struct cifs_tcon *);
 
+extern void cifs_fscache_get_inode_cookie(struct inode *);
 extern void cifs_fscache_release_inode_cookie(struct inode *);
-extern void cifs_fscache_update_inode_cookie(struct inode *inode);
-extern void cifs_fscache_set_inode_cookie(struct inode *, struct file *);
-extern void cifs_fscache_reset_inode_cookie(struct inode *);
+extern void cifs_fscache_unuse_inode_cookie(struct inode *, bool);
+
+static inline
+void cifs_fscache_fill_coherency(struct inode *inode,
+				 struct cifs_fscache_inode_coherency_data *cd)
+{
+	struct cifsInodeInfo *cifsi = CIFS_I(inode);
+
+	memset(cd, 0, sizeof(*cd));
+	cd->last_write_time_sec   = cpu_to_le64(cifsi->vfs_inode.i_mtime.tv_sec);
+	cd->last_write_time_nsec  = cpu_to_le32(cifsi->vfs_inode.i_mtime.tv_nsec);
+	cd->last_change_time_sec  = cpu_to_le64(cifsi->vfs_inode.i_ctime.tv_sec);
+	cd->last_change_time_nsec = cpu_to_le32(cifsi->vfs_inode.i_ctime.tv_nsec);
+}
+
 
-extern void __cifs_fscache_invalidate_page(struct page *, struct inode *);
-extern void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page);
-extern void __cifs_fscache_uncache_page(struct inode *inode, struct page *page);
 extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
 extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
 extern int __cifs_readpages_from_fscache(struct inode *,
 					 struct address_space *,
 					 struct list_head *,
 					 unsigned *);
-extern void __cifs_fscache_readpages_cancel(struct inode *, struct list_head *);
-
 extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
 
-static inline void cifs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
+static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
 {
-	if (PageFsCache(page))
-		__cifs_fscache_invalidate_page(page, inode);
-}
-
-static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page)
-{
-	if (PageFsCache(page))
-		__cifs_fscache_wait_on_page_write(inode, page);
-}
-
-static inline void cifs_fscache_uncache_page(struct inode *inode,
-						   struct page *page)
-{
-	if (PageFsCache(page))
-		__cifs_fscache_uncache_page(inode, page);
+	return CIFS_I(inode)->fscache;
 }
 
 static inline int cifs_readpage_from_fscache(struct inode *inode,
@@ -120,41 +98,20 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
-static inline void cifs_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
+#else /* CONFIG_CIFS_FSCACHE */
+static inline
+void cifs_fscache_fill_coherency(struct inode *inode,
+				 struct cifs_fscache_inode_coherency_data *cd)
 {
-	if (CIFS_I(inode)->fscache)
-		return __cifs_fscache_readpages_cancel(inode, pages);
 }
 
-#else /* CONFIG_CIFS_FSCACHE */
-static inline int cifs_fscache_register(void) { return 0; }
-static inline void cifs_fscache_unregister(void) {}
-
-static inline void
-cifs_fscache_get_client_cookie(struct TCP_Server_Info *server) {}
-static inline void
-cifs_fscache_release_client_cookie(struct TCP_Server_Info *server) {}
-static inline void cifs_fscache_get_super_cookie(struct cifs_tcon *tcon) {}
-static inline void
-cifs_fscache_release_super_cookie(struct cifs_tcon *tcon) {}
+static inline int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon) { return 0; }
+static inline void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon) {}
 
+static inline void cifs_fscache_get_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
-static inline void cifs_fscache_update_inode_cookie(struct inode *inode) {}
-static inline void cifs_fscache_set_inode_cookie(struct inode *inode,
-						 struct file *filp) {}
-static inline void cifs_fscache_reset_inode_cookie(struct inode *inode) {}
-static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* May release page */
-}
-
-static inline void cifs_fscache_invalidate_page(struct page *page,
-			struct inode *inode) {}
-static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page) {}
-static inline void cifs_fscache_uncache_page(struct inode *inode,
-						   struct page *page) {}
+static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update) {}
+static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 
 static inline int
 cifs_readpage_from_fscache(struct inode *inode, struct page *page)
@@ -173,11 +130,6 @@ static inline int cifs_readpages_from_fscache(struct inode *inode,
 static inline void cifs_readpage_to_fscache(struct inode *inode,
 			struct page *page) {}
 
-static inline void cifs_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
-{
-}
-
 #endif /* CONFIG_CIFS_FSCACHE */
 
 #endif /* _CIFS_FSCACHE_H */
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 279622e4eb1c..9b93e7d3e0e1 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1298,10 +1298,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
 		if (inode->i_state & I_NEW) {
 			inode->i_ino = hash;
-#ifdef CONFIG_CIFS_FSCACHE
-			/* initialize per-inode cache cookie pointer */
-			CIFS_I(inode)->fscache = NULL;
-#endif
+			cifs_fscache_get_inode_cookie(inode);
 			unlock_new_inode(inode);
 		}
 	}
@@ -1370,6 +1367,7 @@ struct inode *cifs_root_iget(struct super_block *sb)
 		iget_failed(inode);
 		inode = ERR_PTR(rc);
 	}
+
 out:
 	kfree(path);
 	free_xid(xid);
@@ -2257,6 +2255,8 @@ cifs_dentry_needs_reval(struct dentry *dentry)
 int
 cifs_invalidate_mapping(struct inode *inode)
 {
+	struct cifs_fscache_inode_coherency_data cd;
+	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	int rc = 0;
 
 	if (inode->i_mapping && inode->i_mapping->nrpages != 0) {
@@ -2266,7 +2266,8 @@ cifs_invalidate_mapping(struct inode *inode)
 				 __func__, inode);
 	}
 
-	cifs_fscache_reset_inode_cookie(inode);
+	cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
+	fscache_invalidate(cifs_inode_cookie(inode), &cd, i_size_read(inode), 0);
 	return rc;
 }
 
@@ -2771,8 +2772,10 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		goto out;
 
 	if ((attrs->ia_valid & ATTR_SIZE) &&
-	    attrs->ia_size != i_size_read(inode))
+	    attrs->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, attrs->ia_size);
+		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
+	}
 
 	setattr_copy(&init_user_ns, inode, attrs);
 	mark_inode_dirty(inode);
@@ -2967,8 +2970,10 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		goto cifs_setattr_exit;
 
 	if ((attrs->ia_valid & ATTR_SIZE) &&
-	    attrs->ia_size != i_size_read(inode))
+	    attrs->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, attrs->ia_size);
+		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
+	}
 
 	setattr_copy(&init_user_ns, inode, attrs);
 	mark_inode_dirty(inode);


