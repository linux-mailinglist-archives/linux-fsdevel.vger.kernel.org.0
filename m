Return-Path: <linux-fsdevel+bounces-8882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC883BF6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC50294841
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A95820F;
	Thu, 25 Jan 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F71Pz9RJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC595811C;
	Thu, 25 Jan 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179433; cv=none; b=u7TvCoHXe+AMkseLQALAfJ0zspPSJ2rUEHviKJUk+EJcT0mtCS0yyCEe7fWHYOhY/tlxXHDhJtR/ghLW08L0+uPe5lITldrmOwUin25D1+46xIrpw29ro1yEK2WXWI/bY/EzX3TLTEuMcdH8wsK0M+fdvjVv8Zx2ArDCFiOYujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179433; c=relaxed/simple;
	bh=ubY3n9hN/a89LmkUDO1CrPvf9UviObZkZpYE/XnJyfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LF17dsFRvzG+9STLP/3Pcn0nx0TP/5tZ+k8FovU2GkfCIuJRmcOLln5yiC7hjDmHgd7fvJsHGb4ZCJQRk0HMG6S9GHAKIT1p+rrcYUs003u7j7aCdmWhwYZqkOz4UF3u7tT/uxbCN522DR44JsNhurOxS9u13lP227S3QM0bEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F71Pz9RJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2661C43142;
	Thu, 25 Jan 2024 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179433;
	bh=ubY3n9hN/a89LmkUDO1CrPvf9UviObZkZpYE/XnJyfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F71Pz9RJpiZ5UqyWN4oWOP1Ly+uHbe8S/Y7FvmdYcJsfZEoyr7Uuz3HuWe7MamYEy
	 iYNEeIHhGomBkrDwXnIkpQM6RavXF9pX7od1OrRRKnFrjyMbW6rcPcNea/TVByCfqV
	 BMy5SUWBktAuSlCfMyjdJCQU0gVPypSsifJfTv3QKq7hrQ8AffWPdYnZ0afscietPz
	 Ah/dwK2azpOcvBNSYIA20jueogMFS27uooo6Fx0uJRwpxn5zV9KfECbLC1Ca7bE8wL
	 bMGIbd7pM1a0N5mUccCv+NFpQBpswGGDmabjJDCeGU3xBWD2TvaTkUuelm4yVvLUXc
	 GfaPM+awVjGgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:51 -0500
Subject: [PATCH v2 10/41] filelock: split common fields into struct
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-10-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11789; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ubY3n9hN/a89LmkUDO1CrPvf9UviObZkZpYE/XnJyfk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7sJlTDxQhrtxIbkFCh7zEKGtBXMEoHSO5U
 jDHomb0WD6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FVEGD/4rA87KmcREmpuhtl9ha3piBe0MPQAn3yW2MfYIwfh7fyuq1fSXrp1ibmf5aJx0BxWRGos
 xL9Zbe3rt1x+UKkIdkMPhN4fVd7eM64uLLul/fFJ3Jp8YgBsJiU6i+8a85tf4GASv9u9DZrz2L3
 BqLGZ2nKPWClffCPTHL8pyiDaxLHIVCBl4vtMAO/x8Qrv+dvuNYbANYu+n5xDeDXzVvR9h+cifz
 pB+59j4hoVO1+662r3FfwUBWFQOEkVAkJD+88VtuNul92rIDZ/Bihanu8qVm7nRiYx86ljgYv1G
 TEQg9+sevX2pkh2AW1uxEiBZyd+eWbQVEscoAz4B8jGuAzvw5sUz5+ShjpyVTiMyRq0KFPiXwvq
 NsLWoXxhCeATlw276QAxFivWnzb03DePpVJnfwHsMYt9JO5UO3b5n7OliFdr0mNQ6XWqWLMV/kA
 8fX/+GrnXgsw709quoLOtKj4uN4wahzqlFPcB2j9+a24ETquy4hxWgevOKiwscOu7bKujv78MIv
 waLppltzK1qtzoRwJIOMGtrxJO2gGMax59Tl+/9Tz/4EOOiT03FgqaUkJ5pNgtXpPLVou/T4spX
 zzWLpolgKzRuEBQZc08Jkb8zxJd8HDBkCcXnAnOX/IfwHiKPChlJ4Vj+Qj9irCqxQZEv1hxRtBN
 VyHUKsirEL/lXUg==
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
 include/linux/filelock.h  | 47 ++++++++++++++++++++++++++++++++++-------------
 include/linux/lockd/xdr.h |  3 ++-
 23 files changed, 59 insertions(+), 18 deletions(-)

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
index e07ad29ff8b9..ccb358c398ca 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/ceph/pagelist.h>
 
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 1b66b2d2b801..b89dca1d51b0 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 992ca4effb50..9e7cd054e924 100644
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
index 87212f86eca9..cee3f183a872 100644
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
index 8577ccf621f5..3c9a8ad91540 100644
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
index bb79d3a886ae..ed837a3675cf 100644
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
index f37174e79fad..8a9970dc852e 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/fcntl.h>
 
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 9b76ee66aeb2..460c882c5384 100644
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
index 20036fb16cec..fcda4c77c649 100644
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
index 3a213432775b..dd87b2ef24dc 100644
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
index ba7a72a6a4f4..d12d11cdea29 100644
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
index a6961bfe3e13..d0686ec344f5 100644
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
index 95e868e09e29..0c0db7f20ff6 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -85,23 +85,44 @@ bool opens_in_grace(struct net *);
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
-	unsigned int fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
+	fl_owner_t flc_owner;
+	unsigned int flc_flags;
+	unsigned char flc_type;
+	unsigned int flc_pid;
+	int flc_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t flc_wait;
+	struct file *flc_file;
+};
+
+/* Temporary macros to allow building during coccinelle conversion */
+#ifdef _NEED_FILE_LOCK_FIELD_MACROS
+#define fl_list fl_core.flc_list
+#define fl_blocker fl_core.flc_blocker
+#define fl_link fl_core.flc_link
+#define fl_blocked_requests fl_core.flc_blocked_requests
+#define fl_blocked_member fl_core.flc_blocked_member
+#define fl_owner fl_core.flc_owner
+#define fl_flags fl_core.flc_flags
+#define fl_type fl_core.flc_type
+#define fl_pid fl_core.flc_pid
+#define fl_link_cpu fl_core.flc_link_cpu
+#define fl_wait fl_core.flc_wait
+#define fl_file fl_core.flc_file
+#endif
+
+struct file_lock {
+	struct file_lock_core fl_core;
 	loff_t fl_start;
 	loff_t fl_end;
 
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


