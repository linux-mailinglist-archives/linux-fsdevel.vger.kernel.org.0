Return-Path: <linux-fsdevel+bounces-9747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C9844C08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE41C27A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA012AAFD;
	Wed, 31 Jan 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFVHhQAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306878695;
	Wed, 31 Jan 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742204; cv=none; b=Um4FvRvOoKIGfZ8QdSdOer8FMJK8R334DS6uUZv8sRcOyDQJs+6jAIUZ8Sel60YssIA27rrj88FHJkZKEX3fekE9NAEwtvAX5ixuUXpeN6L0+0Lx88qsABRFZlerbxz0qH9xV2sXNspy5oBkjoTRyy41fBFvgOsPZmpVKHiHvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742204; c=relaxed/simple;
	bh=6L8EcbBv6B0cN5spnt+0guliBl2yrDRM4j61WcDfxBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ql0FeNUZ3eARbKO6xDlEu0AJqkO2QN/4erRcyPd/PNtNLjwbCMon6Gjs42gBAwgAPNpnxbI7DxD+aIQWPWsHB1OcX760uFvJHfOrCvIpBJ5BKA6ad8veZQK8OcSnV2/LIFmPmYvydVJhbqzRxSaycUbVFjVRPGdYf7xjgkXmSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFVHhQAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3DDC43601;
	Wed, 31 Jan 2024 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742203;
	bh=6L8EcbBv6B0cN5spnt+0guliBl2yrDRM4j61WcDfxBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VFVHhQAeTlCgAbz5kauL0f2JsmKUHlY0oFyyHJ3qwZD5yLeyZ+yeadxdlDEBfkz3B
	 ngTsJSeGVODwNjz9d379qDrOyg2kmApzNaei5lW1IWJ0qtFI4gsKHHSGk3awM34W9m
	 7nedaZoKMWazSNhHqiYZ7vHuvDAmR9razYW809IkJNelYn3/cfpto2aosIrlxnpSHV
	 VEr+Flk/WcysdGmfm02n2lYX+qKu/LE2sEdAcvzP99b54o9vchPrs0u6dsY7prMKuT
	 TnGqjAJLfr0dgDuD3ojgCh+hwcN32x/hOKnuq3Tr+3gaGCHlpHcDjgI+QfhsMnEe0n
	 zYZiOyqQeMCRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:58 -0500
Subject: [PATCH v3 17/47] filelock: split common fields into struct
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-17-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13128; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6L8EcbBv6B0cN5spnt+0guliBl2yrDRM4j61WcDfxBE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwlgR/0FoXVmNWqLa6qlt2Cl4pBDWh3zxIO
 rQbPP4/hlyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 Fb/nD/9I9S1pFLM+zfs7jqMDIenvzBfsbvk7Ny8IPno0OlEkIUnzCnntgiQHH5RPAmKoKdOl8Ej
 WMz6yNReikW/qIZjWwsadYvG2TIzkmj3eyCv/yULTXTA97Kz55+NXnZ6qLaFQaHTwIQeNFSOugW
 RkqvLK8cBeWdvWdmQ7SB5hvL2LeKxBJc/235bSFAhWupFhCl9mMfzYlOtouObOIm5EtbCgp4HHi
 G3QR/dQTbWbhSjqkMsCDRoUnBTjBiYCWLD8AWwLZJtTTWG4LHC8g5Z+0HJqcTuP+0G2lSHuSlwK
 4McXhmF7DCB7jOwIW5y0djBqOK2k+z1B3RNFreNpQ7bqiM/G3b5nmxfdGr1BAS1mxjlSIrF9xhH
 pJrKXvIGcSUSexn1+hejLhMFDjzC0szXYKlJgnnOuLe5BiAQbAK4PLEQHEynBLn4Xg0ZYzbuD89
 KjSzzAi5R9qPi8DrMKSIv3/egplnkeKTIh85eC7aSDDmmi+K0p8hyQXd2m8cfqpIK1gzI3adUad
 XVVrifLL7bdRySqF1/DorKQA+wdycr/h3vocuV10ErBz6EF/DzNBowb82hSMixwh7JXSDjOZIxh
 essGw/PLVWC4HSKQ0M01+xZcK/F7j7Re9szKgCXL9dCqG9l6JdESSGV3cFo9wOXVEGwl5SUinCN
 9EtntFgs9tDcLgQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a future patch, we're going to split file leases into their own
structure. Since a lot of the underlying machinery uses the same fields
move those into a new file_lock_core, and embed that inside struct
file_lock.

For now, add some macros to ensure that we can continue to build while
the conversion is in progress.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c          |  1 +
 fs/afs/internal.h         |  1 +
 fs/ceph/locks.c           |  1 +
 fs/dlm/plock.c            |  1 +
 fs/fuse/file.c            |  1 +
 fs/gfs2/file.c            |  1 +
 fs/lockd/clntproc.c       |  1 +
 fs/locks.c                |  1 +
 fs/nfs/file.c             |  1 +
 fs/nfs/nfs4_fs.h          |  1 +
 fs/nfs/write.c            |  1 +
 fs/nfsd/netns.h           |  1 +
 fs/ocfs2/locks.c          |  1 +
 fs/ocfs2/stack_user.c     |  1 +
 fs/open.c                 |  2 +-
 fs/posix_acl.c            |  4 ++--
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifssmb.c   |  1 +
 fs/smb/client/file.c      |  3 ++-
 fs/smb/client/smb2file.c  |  1 +
 fs/smb/server/smb2pdu.c   |  1 +
 fs/smb/server/vfs.c       |  1 +
 include/linux/filelock.h  | 57 ++++++++++++++++++++++++++++++++---------------
 include/linux/lockd/xdr.h |  3 ++-
 24 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 3df8aa1b5996..a1dabcf73380 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/sched.h>
 #include <linux/file.h>
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9c03fcf7ffaa..f5dd428e40f4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 80ebe1d6c67d..ce773e9c0b79 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/ceph/pagelist.h>
 
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 42c596b900d4..fdcddbb96d40 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..2757870ee6ac 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/splice.h>
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 6c25aea30f1b..d06488de1b3b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/falloc.h>
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index cc596748e359..1f71260603b7 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
diff --git a/fs/locks.c b/fs/locks.c
index d685c3fdbea5..097254ab35d3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -48,6 +48,7 @@
  * children.
  *
  */
+#define _NEED_FILE_LOCK_FIELD_MACROS
 
 #include <linux/capability.h>
 #include <linux/file.h>
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1a7a76d6055b..0b6691e64d27 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -31,6 +31,7 @@
 #include <linux/swap.h>
 
 #include <linux/uaccess.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "delegation.h"
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 581698f1b7b2..752224a48f1c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -23,6 +23,7 @@
 #define NFS4_MAX_LOOP_ON_RECOVER (10)
 
 #include <linux/seqlock.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 struct idmap;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d16f2b9d1765..13f2e10167ac 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/wait.h>
 #include <linux/iversion.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include <linux/uaccess.h>
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 74b4360779a1..fd91125208be 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index ef4fd91b586e..84ad403b5998 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/fcntl.h>
 
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index c11406cd87a8..39b7e47a8618 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
diff --git a/fs/open.c b/fs/open.c
index a84d21e55c39..0a73afe04d34 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1364,7 +1364,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 {
 	struct filename *name = getname_kernel(filename);
 	struct file *file = ERR_CAST(name);
-	
+
 	if (!IS_ERR(name)) {
 		file = file_open_name(name, flags, mode);
 		putname(name);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index e1af20893ebe..6bf587d1a9b8 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -786,12 +786,12 @@ struct posix_acl *posix_acl_from_xattr(struct user_namespace *userns,
 		return ERR_PTR(count);
 	if (count == 0)
 		return NULL;
-	
+
 	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	acl_e = acl->a_entries;
-	
+
 	for (end = entry + count; entry != end; acl_e++, entry++) {
 		acl_e->e_tag  = le16_to_cpu(entry->e_tag);
 		acl_e->e_perm = le16_to_cpu(entry->e_perm);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 16befff4cbb4..78a994caadaf 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -26,6 +26,7 @@
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../common/smb2pdu.h"
 #include "smb2pdu.h"
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #define SMB_PATH_MAX 260
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01e89070df5a..e19ecf692c20 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -15,6 +15,7 @@
  /* want to reuse a stale file handle and only the caller knows the file info */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/kernel.h>
 #include <linux/vfs.h>
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 27f9ef4e69a8..32d3a27236fc 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
@@ -2951,7 +2952,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 			continue;
 		}
 
-		folio_batch_release(&fbatch);		
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index e0ee96d69d49..cd225d15a7c5 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -7,6 +7,7 @@
  *
  */
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e170b96d5ac0..11cc28719582 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
 #include <linux/mount.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "glob.h"
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 449cfa9ed31c..5dc87649400b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index a814664b1053..4dab73bb34b9 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -85,23 +85,28 @@ bool opens_in_grace(struct net *);
  *
  * Obviously, the last two criteria only matter for POSIX locks.
  */
-struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
-	struct list_head fl_list;	/* link into file_lock_context */
-	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_blocked_requests;	/* list of requests with
+
+struct file_lock_core {
+	struct file_lock *flc_blocker;	/* The lock that is blocking us */
+	struct list_head flc_list;	/* link into file_lock_context */
+	struct hlist_node flc_link;	/* node in global lists */
+	struct list_head flc_blocked_requests;	/* list of requests with
 						 * ->fl_blocker pointing here
 						 */
-	struct list_head fl_blocked_member;	/* node in
+	struct list_head flc_blocked_member;	/* node in
 						 * ->fl_blocker->fl_blocked_requests
 						 */
-	fl_owner_t fl_owner;
-	unsigned int fl_flags;
-	unsigned char fl_type;
-	pid_t fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
+	fl_owner_t flc_owner;
+	unsigned int flc_flags;
+	unsigned char flc_type;
+	pid_t flc_pid;
+	int flc_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t flc_wait;
+	struct file *flc_file;
+};
+
+struct file_lock {
+	struct file_lock_core c;
 	loff_t fl_start;
 	loff_t fl_end;
 
@@ -126,6 +131,22 @@ struct file_lock {
 	} fl_u;
 } __randomize_layout;
 
+/* Temporary macros to allow building during coccinelle conversion */
+#ifdef _NEED_FILE_LOCK_FIELD_MACROS
+#define fl_list c.flc_list
+#define fl_blocker c.flc_blocker
+#define fl_link c.flc_link
+#define fl_blocked_requests c.flc_blocked_requests
+#define fl_blocked_member c.flc_blocked_member
+#define fl_owner c.flc_owner
+#define fl_flags c.flc_flags
+#define fl_type c.flc_type
+#define fl_pid c.flc_pid
+#define fl_link_cpu c.flc_link_cpu
+#define fl_wait c.flc_wait
+#define fl_file c.flc_file
+#endif
+
 struct file_lock_context {
 	spinlock_t		flc_lock;
 	struct list_head	flc_flock;
@@ -149,26 +170,26 @@ int fcntl_getlease(struct file *filp);
 
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
-	return fl->fl_type == F_UNLCK;
+	return fl->c.flc_type == F_UNLCK;
 }
 
 static inline bool lock_is_read(struct file_lock *fl)
 {
-	return fl->fl_type == F_RDLCK;
+	return fl->c.flc_type == F_RDLCK;
 }
 
 static inline bool lock_is_write(struct file_lock *fl)
 {
-	return fl->fl_type == F_WRLCK;
+	return fl->c.flc_type == F_WRLCK;
 }
 
 static inline void locks_wake_up(struct file_lock *fl)
 {
-	wake_up(&fl->fl_wait);
+	wake_up(&fl->c.flc_wait);
 }
 
 /* for walking lists of file_locks linked by fl_list */
-#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, fl_list)
+#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, c.flc_list)
 
 /* fs/locks.c */
 void locks_free_lock_context(struct inode *inode);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index b60fbcd8cdfa..a3f068b0ca86 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -11,6 +11,7 @@
 #define LOCKD_XDR_H
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>
@@ -52,7 +53,7 @@ struct nlm_lock {
  *	FreeBSD uses 16, Apple Mac OS X 10.3 uses 20. Therefore we set it to
  *	32 bytes.
  */
- 
+
 struct nlm_cookie
 {
 	unsigned char data[NLM_MAXCOOKIELEN];

-- 
2.43.0


