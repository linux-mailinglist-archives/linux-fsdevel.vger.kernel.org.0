Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769D65F597
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 22:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjAEVTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 16:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjAEVTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:19:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B362B1C;
        Thu,  5 Jan 2023 13:19:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F8AACE1BC8;
        Thu,  5 Jan 2023 21:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC7C433D2;
        Thu,  5 Jan 2023 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672953583;
        bh=+6UQmIoUGiWM65DY/eqziyR1W5HdUMoYcvdaFWKk3N4=;
        h=From:To:Cc:Subject:Date:From;
        b=SYYmkIcTHB21pOu0kcIbiMYK1JxAB/n07X3N1fYlyvcgBFKQSwSRrkRYsZ1oHFg8l
         jInB3gvu9KKqkMpWaTptSPmpeivdEiQJj0dTJNNpr8fxWy68mwue/xJopbFS7k2ThM
         oRsMoHA+dAoPGBjYZ9Q+7NFO6WhiqQXWQnGUmlvMtUvMPqMIbVX9o29DazSf8i0b3o
         T/avGyTzwKSgc+wI8KeQPrp/rqNGQCUSom7bsmGk0kn7iKu9NzThABv4C+yxS6ZgLf
         N8WGIyKOqNIxLd/WnU+9Sbe0eyAt5at8TE4DeDiJ5Uj1UPUv0Iw9V8yVww5eAaMC4x
         fl/T57GEJ1Aww==
From:   Jeff Layton <jlayton@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2] filelock: move file locking definitions to separate header file
Date:   Thu,  5 Jan 2023 16:19:29 -0500
Message-Id: <20230105211937.1572384-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file locking definitions have lived in fs.h since the dawn of time,
but they are only used by a small subset of the source files that
include it.

Move the file locking definitions to a new header file, and add the
appropriate #include directives to the source files that need them. By
doing this we trim down fs.h a bit and limit the amount of rebuilding
that has to be done when we make changes to the file locking APIs.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Acked-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 arch/arm/kernel/sys_oabi-compat.c |   1 +
 fs/9p/vfs_file.c                  |   1 +
 fs/afs/internal.h                 |   1 +
 fs/attr.c                         |   1 +
 fs/ceph/locks.c                   |   1 +
 fs/cifs/cifsfs.c                  |   1 +
 fs/cifs/cifsglob.h                |   1 +
 fs/cifs/cifssmb.c                 |   1 +
 fs/cifs/file.c                    |   1 +
 fs/cifs/smb2file.c                |   1 +
 fs/dlm/plock.c                    |   1 +
 fs/fcntl.c                        |   1 +
 fs/file_table.c                   |   1 +
 fs/fuse/file.c                    |   1 +
 fs/gfs2/file.c                    |   1 +
 fs/inode.c                        |   1 +
 fs/ksmbd/smb2pdu.c                |   1 +
 fs/ksmbd/vfs.c                    |   1 +
 fs/ksmbd/vfs_cache.c              |   1 +
 fs/lockd/clntproc.c               |   1 +
 fs/lockd/netns.h                  |   1 +
 fs/locks.c                        |   1 +
 fs/namei.c                        |   1 +
 fs/nfs/file.c                     |   1 +
 fs/nfs/nfs4_fs.h                  |   1 +
 fs/nfs/pagelist.c                 |   1 +
 fs/nfs/write.c                    |   1 +
 fs/nfs_common/grace.c             |   1 +
 fs/nfsd/netns.h                   |   1 +
 fs/ocfs2/locks.c                  |   1 +
 fs/ocfs2/stack_user.c             |   1 +
 fs/open.c                         |   1 +
 fs/orangefs/file.c                |   1 +
 fs/posix_acl.c                    |   1 +
 fs/proc/fd.c                      |   1 +
 fs/utimes.c                       |   1 +
 fs/xattr.c                        |   1 +
 fs/xfs/xfs_linux.h                |   1 +
 include/linux/filelock.h          | 438 ++++++++++++++++++++++++++++++
 include/linux/fs.h                | 426 -----------------------------
 include/linux/lockd/xdr.h         |   1 +
 41 files changed, 477 insertions(+), 426 deletions(-)
 create mode 100644 include/linux/filelock.h

v2:
- drop pointless externs from the new filelock.h
- move include into xfs_linux.h instead of xfs_buf.h
- have filelock.h #include fs.h. Any file including filelock.h will
  almost certainly need fs.h anyway.

I've left some of Al's comments unaddressed for now, as I'd like to keep
this move mostly mechanical, and no go changing function prototypes
until the dust settles.

I'll plan to drop this into linux-next within the next few days, with an
eye toward merging this for v6.3.

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 68112c172025..006163195d67 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -73,6 +73,7 @@
 #include <linux/syscalls.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/cred.h>
 #include <linux/fcntl.h>
 #include <linux/eventpoll.h>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b740017634ef..b6ba22975781 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/sched.h>
 #include <linux/file.h>
 #include <linux/stat.h>
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index fd8567b98e2b..2d6d7dae225a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
 #include <linux/key.h>
diff --git a/fs/attr.c b/fs/attr.c
index b45f30e516fa..f3eb8e57b451 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -14,6 +14,7 @@
 #include <linux/capability.h>
 #include <linux/fsnotify.h>
 #include <linux/fcntl.h>
+#include <linux/filelock.h>
 #include <linux/security.h>
 #include <linux/evm.h>
 #include <linux/ima.h>
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index f3b461c708a8..476f25bba263 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include <linux/filelock.h>
 #include <linux/ceph/pagelist.h>
 
 static u64 lock_secret;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..f052f190b2e8 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index cfdd5bf701a1..cd8171a1c9a0 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -26,6 +26,7 @@
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../smbfs_common/smb2pdu.h"
 #include "smb2pdu.h"
+#include <linux/filelock.h>
 
 #define SMB_PATH_MAX 260
 #define CIFS_PORT 445
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 23f10e0d6e7e..60dd4e37030a 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -15,6 +15,7 @@
  /* want to reuse a stale file handle and only the caller knows the file info */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/kernel.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22dfc1f8b4f1..1d9cc59d8259 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index ba6cc50af390..9f1dd04b555a 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -7,6 +7,7 @@
  *
  */
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 737f185aad8d..ed4357e62f35 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
 #include <linux/dlm.h>
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 146c9ab0cd4b..7852e946fdf4 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/sched/task.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/capability.h>
diff --git a/fs/file_table.c b/fs/file_table.c
index dd88701e54a9..372653b92617 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/eventpoll.h>
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 875314ee6f59..1458412f2492 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index eea5be4fbf0e..e8e20a716004 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/falloc.h>
 #include <linux/swap.h>
diff --git a/fs/inode.c b/fs/inode.c
index f453eb58fd03..d02dd8f1e967 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -5,6 +5,7 @@
  */
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
 #include <linux/hash.h>
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 14d7f3599c63..000a6648f122 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
 #include <linux/mount.h>
+#include <linux/filelock.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index ff0e7a4fcd4d..5851934dc85b 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index da9163b00350..552c3882a8f4 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 99fffc9cb958..e875a3571c41 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
 #include <linux/freezer.h>
diff --git a/fs/lockd/netns.h b/fs/lockd/netns.h
index 5bec78c8e431..17432c445fe6 100644
--- a/fs/lockd/netns.h
+++ b/fs/lockd/netns.h
@@ -3,6 +3,7 @@
 #define __LOCKD_NETNS_H__
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <net/netns/generic.h>
 
 struct lockd_net {
diff --git a/fs/locks.c b/fs/locks.c
index 8f01bee17715..a5cc90c958c9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -52,6 +52,7 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
+#include <linux/filelock.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/security.h>
diff --git a/fs/namei.c b/fs/namei.c
index 309ae6fc8c99..60a9d3ac941f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d8ec889a4b3f..b0f3c9339e70 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -31,6 +31,7 @@
 #include <linux/swap.h>
 
 #include <linux/uaccess.h>
+#include <linux/filelock.h>
 
 #include "delegation.h"
 #include "internal.h"
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 5edd1704f735..4c9f8bd866ab 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -23,6 +23,7 @@
 #define NFS4_MAX_LOOP_ON_RECOVER (10)
 
 #include <linux/seqlock.h>
+#include <linux/filelock.h>
 
 struct idmap;
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 16be6dae524f..779bfc37233c 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -21,6 +21,7 @@
 #include <linux/nfs_page.h>
 #include <linux/nfs_mount.h>
 #include <linux/export.h>
+#include <linux/filelock.h>
 
 #include "internal.h"
 #include "pnfs.h"
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 80c240e50952..1a80d548253a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/wait.h>
 #include <linux/iversion.h>
+#include <linux/filelock.h>
 
 #include <linux/uaccess.h>
 #include <linux/sched/mm.h>
diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index 0a9b72685f98..1479583fbb62 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -9,6 +9,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 
 static unsigned int grace_net_id;
 static DEFINE_SPINLOCK(grace_lock);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8c854ba3285b..bc139401927d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/filelock.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
 
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index 73a3854b2afb..f37174e79fad 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/fcntl.h>
 
 #include <cluster/masklog.h>
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 64e6ddcfe329..05d4414d0c33 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..9b1c08298a07 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -33,6 +33,7 @@
 #include <linux/dnotify.h>
 #include <linux/compat.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/filelock.h>
 
 #include "internal.h"
 
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 167fa43b24f9..4ecb91a9bbeb 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -14,6 +14,7 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 
 static int flush_racache(struct inode *inode)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..d2271431f344 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/evm.h>
 #include <linux/fsnotify.h>
+#include <linux/filelock.h>
 
 #include "internal.h"
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index fc46d6fe080c..53e4919ef860 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -12,6 +12,7 @@
 #include <linux/file.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 
 #include <linux/proc_fs.h>
 
diff --git a/fs/utimes.c b/fs/utimes.c
index 39f356017635..00499e4ba955 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -7,6 +7,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include <asm/unistd.h>
+#include <linux/filelock.h>
 
 static bool nsec_valid(long nsec)
 {
diff --git a/fs/xattr.c b/fs/xattr.c
index adab9a70b536..3fead374901b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -9,6 +9,7 @@
   Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  */
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/xattr.h>
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index f9878021e7d0..e88f18f85e4b 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -34,6 +34,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/swap.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
new file mode 100644
index 000000000000..deee04385127
--- /dev/null
+++ b/include/linux/filelock.h
@@ -0,0 +1,438 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FILELOCK_H
+#define _LINUX_FILELOCK_H
+
+#include <linux/fs.h>
+
+#define FL_POSIX	1
+#define FL_FLOCK	2
+#define FL_DELEG	4	/* NFSv4 delegation */
+#define FL_ACCESS	8	/* not trying to lock, just looking */
+#define FL_EXISTS	16	/* when unlocking, test for existence */
+#define FL_LEASE	32	/* lease held on this file */
+#define FL_CLOSE	64	/* unlock on close */
+#define FL_SLEEP	128	/* A blocking lock */
+#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
+#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
+#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
+#define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+
+#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
+
+/*
+ * Special return value from posix_lock_file() and vfs_lock_file() for
+ * asynchronous locking.
+ */
+#define FILE_LOCK_DEFERRED 1
+
+struct file_lock;
+
+struct file_lock_operations {
+	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
+	void (*fl_release_private)(struct file_lock *);
+};
+
+struct lock_manager_operations {
+	void *lm_mod_owner;
+	fl_owner_t (*lm_get_owner)(fl_owner_t);
+	void (*lm_put_owner)(fl_owner_t);
+	void (*lm_notify)(struct file_lock *);	/* unblock callback */
+	int (*lm_grant)(struct file_lock *, int);
+	bool (*lm_break)(struct file_lock *);
+	int (*lm_change)(struct file_lock *, int, struct list_head *);
+	void (*lm_setup)(struct file_lock *, void **);
+	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_lock_expirable)(struct file_lock *cfl);
+	void (*lm_expire_lock)(void);
+};
+
+struct lock_manager {
+	struct list_head list;
+	/*
+	 * NFSv4 and up also want opens blocked during the grace period;
+	 * NLM doesn't care:
+	 */
+	bool block_opens;
+};
+
+struct net;
+void locks_start_grace(struct net *, struct lock_manager *);
+void locks_end_grace(struct lock_manager *);
+bool locks_in_grace(struct net *);
+bool opens_in_grace(struct net *);
+
+/*
+ * struct file_lock has a union that some filesystems use to track
+ * their own private info. The NFS side of things is defined here:
+ */
+#include <linux/nfs_fs_i.h>
+
+/*
+ * struct file_lock represents a generic "file lock". It's used to represent
+ * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
+ * note that the same struct is used to represent both a request for a lock and
+ * the lock itself, but the same object is never used for both.
+ *
+ * FIXME: should we create a separate "struct lock_request" to help distinguish
+ * these two uses?
+ *
+ * The varous i_flctx lists are ordered by:
+ *
+ * 1) lock owner
+ * 2) lock range start
+ * 3) lock range end
+ *
+ * Obviously, the last two criteria only matter for POSIX locks.
+ */
+struct file_lock {
+	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
+	struct list_head fl_list;	/* link into file_lock_context */
+	struct hlist_node fl_link;	/* node in global lists */
+	struct list_head fl_blocked_requests;	/* list of requests with
+						 * ->fl_blocker pointing here
+						 */
+	struct list_head fl_blocked_member;	/* node in
+						 * ->fl_blocker->fl_blocked_requests
+						 */
+	fl_owner_t fl_owner;
+	unsigned int fl_flags;
+	unsigned char fl_type;
+	unsigned int fl_pid;
+	int fl_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t fl_wait;
+	struct file *fl_file;
+	loff_t fl_start;
+	loff_t fl_end;
+
+	struct fasync_struct *	fl_fasync; /* for lease break notifications */
+	/* for lease breaks: */
+	unsigned long fl_break_time;
+	unsigned long fl_downgrade_time;
+
+	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
+	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
+	union {
+		struct nfs_lock_info	nfs_fl;
+		struct nfs4_lock_info	nfs4_fl;
+		struct {
+			struct list_head link;	/* link in AFS vnode's pending_locks list */
+			int state;		/* state of grant or error if -ve */
+			unsigned int	debug_id;
+		} afs;
+	} fl_u;
+} __randomize_layout;
+
+struct file_lock_context {
+	spinlock_t		flc_lock;
+	struct list_head	flc_flock;
+	struct list_head	flc_posix;
+	struct list_head	flc_lease;
+};
+
+#define locks_inode(f) file_inode(f)
+
+#ifdef CONFIG_FILE_LOCKING
+int fcntl_getlk(struct file *, unsigned int, struct flock *);
+int fcntl_setlk(unsigned int, struct file *, unsigned int,
+			struct flock *);
+
+#if BITS_PER_LONG == 32
+int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
+int fcntl_setlk64(unsigned int, struct file *, unsigned int,
+			struct flock64 *);
+#endif
+
+int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
+int fcntl_getlease(struct file *filp);
+
+/* fs/locks.c */
+void locks_free_lock_context(struct inode *inode);
+void locks_free_lock(struct file_lock *fl);
+void locks_init_lock(struct file_lock *);
+struct file_lock * locks_alloc_lock(void);
+void locks_copy_lock(struct file_lock *, struct file_lock *);
+void locks_copy_conflock(struct file_lock *, struct file_lock *);
+void locks_remove_posix(struct file *, fl_owner_t);
+void locks_remove_file(struct file *);
+void locks_release_private(struct file_lock *);
+void posix_test_lock(struct file *, struct file_lock *);
+int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
+int locks_delete_block(struct file_lock *);
+int vfs_test_lock(struct file *, struct file_lock *);
+int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
+int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
+bool vfs_inode_has_locks(struct inode *inode);
+int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
+int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
+void lease_get_mtime(struct inode *, struct timespec64 *time);
+int generic_setlease(struct file *, long, struct file_lock **, void **priv);
+int vfs_setlease(struct file *, long, struct file_lock **, void **);
+int lease_modify(struct file_lock *, int, struct list_head *);
+
+struct notifier_block;
+int lease_register_notifier(struct notifier_block *);
+void lease_unregister_notifier(struct notifier_block *);
+
+struct files_struct;
+void show_fd_locks(struct seq_file *f,
+			 struct file *filp, struct files_struct *files);
+bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner);
+
+static inline struct file_lock_context *
+locks_inode_context(const struct inode *inode)
+{
+	return smp_load_acquire(&inode->i_flctx);
+}
+
+#else /* !CONFIG_FILE_LOCKING */
+static inline int fcntl_getlk(struct file *file, unsigned int cmd,
+			      struct flock __user *user)
+{
+	return -EINVAL;
+}
+
+static inline int fcntl_setlk(unsigned int fd, struct file *file,
+			      unsigned int cmd, struct flock __user *user)
+{
+	return -EACCES;
+}
+
+#if BITS_PER_LONG == 32
+static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
+				struct flock64 *user)
+{
+	return -EINVAL;
+}
+
+static inline int fcntl_setlk64(unsigned int fd, struct file *file,
+				unsigned int cmd, struct flock64 *user)
+{
+	return -EACCES;
+}
+#endif
+static inline int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
+{
+	return -EINVAL;
+}
+
+static inline int fcntl_getlease(struct file *filp)
+{
+	return F_UNLCK;
+}
+
+static inline void
+locks_free_lock_context(struct inode *inode)
+{
+}
+
+static inline void locks_init_lock(struct file_lock *fl)
+{
+	return;
+}
+
+static inline void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
+{
+	return;
+}
+
+static inline void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
+{
+	return;
+}
+
+static inline void locks_remove_posix(struct file *filp, fl_owner_t owner)
+{
+	return;
+}
+
+static inline void locks_remove_file(struct file *filp)
+{
+	return;
+}
+
+static inline void posix_test_lock(struct file *filp, struct file_lock *fl)
+{
+	return;
+}
+
+static inline int posix_lock_file(struct file *filp, struct file_lock *fl,
+				  struct file_lock *conflock)
+{
+	return -ENOLCK;
+}
+
+static inline int locks_delete_block(struct file_lock *waiter)
+{
+	return -ENOENT;
+}
+
+static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
+{
+	return 0;
+}
+
+static inline int vfs_lock_file(struct file *filp, unsigned int cmd,
+				struct file_lock *fl, struct file_lock *conf)
+{
+	return -ENOLCK;
+}
+
+static inline int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
+{
+	return 0;
+}
+
+static inline bool vfs_inode_has_locks(struct inode *inode)
+{
+	return false;
+}
+
+static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl)
+{
+	return -ENOLCK;
+}
+
+static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
+{
+	return 0;
+}
+
+static inline void lease_get_mtime(struct inode *inode,
+				   struct timespec64 *time)
+{
+	return;
+}
+
+static inline int generic_setlease(struct file *filp, long arg,
+				    struct file_lock **flp, void **priv)
+{
+	return -EINVAL;
+}
+
+static inline int vfs_setlease(struct file *filp, long arg,
+			       struct file_lock **lease, void **priv)
+{
+	return -EINVAL;
+}
+
+static inline int lease_modify(struct file_lock *fl, int arg,
+			       struct list_head *dispose)
+{
+	return -EINVAL;
+}
+
+struct files_struct;
+static inline void show_fd_locks(struct seq_file *f,
+			struct file *filp, struct files_struct *files) {}
+static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
+			fl_owner_t owner)
+{
+	return false;
+}
+
+static inline struct file_lock_context *
+locks_inode_context(const struct inode *inode)
+{
+	return NULL;
+}
+
+#endif /* !CONFIG_FILE_LOCKING */
+
+static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
+{
+	return locks_lock_inode_wait(locks_inode(filp), fl);
+}
+
+#ifdef CONFIG_FILE_LOCKING
+static inline int break_lease(struct inode *inode, unsigned int mode)
+{
+	/*
+	 * Since this check is lockless, we must ensure that any refcounts
+	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
+	 * could end up racing with tasks trying to set a new lease on this
+	 * file.
+	 */
+	smp_mb();
+	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+		return __break_lease(inode, mode, FL_LEASE);
+	return 0;
+}
+
+static inline int break_deleg(struct inode *inode, unsigned int mode)
+{
+	/*
+	 * Since this check is lockless, we must ensure that any refcounts
+	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
+	 * could end up racing with tasks trying to set a new lease on this
+	 * file.
+	 */
+	smp_mb();
+	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+		return __break_lease(inode, mode, FL_DELEG);
+	return 0;
+}
+
+static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+{
+	int ret;
+
+	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
+	if (ret == -EWOULDBLOCK && delegated_inode) {
+		*delegated_inode = inode;
+		ihold(inode);
+	}
+	return ret;
+}
+
+static inline int break_deleg_wait(struct inode **delegated_inode)
+{
+	int ret;
+
+	ret = break_deleg(*delegated_inode, O_WRONLY);
+	iput(*delegated_inode);
+	*delegated_inode = NULL;
+	return ret;
+}
+
+static inline int break_layout(struct inode *inode, bool wait)
+{
+	smp_mb();
+	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+		return __break_lease(inode,
+				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
+				FL_LAYOUT);
+	return 0;
+}
+
+#else /* !CONFIG_FILE_LOCKING */
+static inline int break_lease(struct inode *inode, unsigned int mode)
+{
+	return 0;
+}
+
+static inline int break_deleg(struct inode *inode, unsigned int mode)
+{
+	return 0;
+}
+
+static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+{
+	return 0;
+}
+
+static inline int break_deleg_wait(struct inode **delegated_inode)
+{
+	BUG();
+	return 0;
+}
+
+static inline int break_layout(struct inode *inode, bool wait)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FILE_LOCKING */
+
+#endif /* _LINUX_FILELOCK_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..006278d84d2f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1003,132 +1003,11 @@ static inline struct file *get_file(struct file *f)
 #define MAX_LFS_FILESIZE 	((loff_t)LLONG_MAX)
 #endif
 
-#define FL_POSIX	1
-#define FL_FLOCK	2
-#define FL_DELEG	4	/* NFSv4 delegation */
-#define FL_ACCESS	8	/* not trying to lock, just looking */
-#define FL_EXISTS	16	/* when unlocking, test for existence */
-#define FL_LEASE	32	/* lease held on this file */
-#define FL_CLOSE	64	/* unlock on close */
-#define FL_SLEEP	128	/* A blocking lock */
-#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
-#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
-#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
-#define FL_LAYOUT	2048	/* outstanding pNFS layout */
-#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
-
-#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
-
-/*
- * Special return value from posix_lock_file() and vfs_lock_file() for
- * asynchronous locking.
- */
-#define FILE_LOCK_DEFERRED 1
-
 /* legacy typedef, should eventually be removed */
 typedef void *fl_owner_t;
 
 struct file_lock;
 
-struct file_lock_operations {
-	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
-	void (*fl_release_private)(struct file_lock *);
-};
-
-struct lock_manager_operations {
-	void *lm_mod_owner;
-	fl_owner_t (*lm_get_owner)(fl_owner_t);
-	void (*lm_put_owner)(fl_owner_t);
-	void (*lm_notify)(struct file_lock *);	/* unblock callback */
-	int (*lm_grant)(struct file_lock *, int);
-	bool (*lm_break)(struct file_lock *);
-	int (*lm_change)(struct file_lock *, int, struct list_head *);
-	void (*lm_setup)(struct file_lock *, void **);
-	bool (*lm_breaker_owns_lease)(struct file_lock *);
-	bool (*lm_lock_expirable)(struct file_lock *cfl);
-	void (*lm_expire_lock)(void);
-};
-
-struct lock_manager {
-	struct list_head list;
-	/*
-	 * NFSv4 and up also want opens blocked during the grace period;
-	 * NLM doesn't care:
-	 */
-	bool block_opens;
-};
-
-struct net;
-void locks_start_grace(struct net *, struct lock_manager *);
-void locks_end_grace(struct lock_manager *);
-bool locks_in_grace(struct net *);
-bool opens_in_grace(struct net *);
-
-/* that will die - we need it for nfs_lock_info */
-#include <linux/nfs_fs_i.h>
-
-/*
- * struct file_lock represents a generic "file lock". It's used to represent
- * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
- * note that the same struct is used to represent both a request for a lock and
- * the lock itself, but the same object is never used for both.
- *
- * FIXME: should we create a separate "struct lock_request" to help distinguish
- * these two uses?
- *
- * The varous i_flctx lists are ordered by:
- *
- * 1) lock owner
- * 2) lock range start
- * 3) lock range end
- *
- * Obviously, the last two criteria only matter for POSIX locks.
- */
-struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
-	struct list_head fl_list;	/* link into file_lock_context */
-	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_blocked_requests;	/* list of requests with
-						 * ->fl_blocker pointing here
-						 */
-	struct list_head fl_blocked_member;	/* node in
-						 * ->fl_blocker->fl_blocked_requests
-						 */
-	fl_owner_t fl_owner;
-	unsigned int fl_flags;
-	unsigned char fl_type;
-	unsigned int fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
-	loff_t fl_start;
-	loff_t fl_end;
-
-	struct fasync_struct *	fl_fasync; /* for lease break notifications */
-	/* for lease breaks: */
-	unsigned long fl_break_time;
-	unsigned long fl_downgrade_time;
-
-	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
-	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
-	union {
-		struct nfs_lock_info	nfs_fl;
-		struct nfs4_lock_info	nfs4_fl;
-		struct {
-			struct list_head link;	/* link in AFS vnode's pending_locks list */
-			int state;		/* state of grant or error if -ve */
-			unsigned int	debug_id;
-		} afs;
-	} fl_u;
-} __randomize_layout;
-
-struct file_lock_context {
-	spinlock_t		flc_lock;
-	struct list_head	flc_flock;
-	struct list_head	flc_posix;
-	struct list_head	flc_lease;
-};
-
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
 #define OFFSET_MAX	type_max(loff_t)
@@ -1137,216 +1016,6 @@ struct file_lock_context {
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
-#define locks_inode(f) file_inode(f)
-
-#ifdef CONFIG_FILE_LOCKING
-extern int fcntl_getlk(struct file *, unsigned int, struct flock *);
-extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
-			struct flock *);
-
-#if BITS_PER_LONG == 32
-extern int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
-extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
-			struct flock64 *);
-#endif
-
-extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
-extern int fcntl_getlease(struct file *filp);
-
-/* fs/locks.c */
-void locks_free_lock_context(struct inode *inode);
-void locks_free_lock(struct file_lock *fl);
-extern void locks_init_lock(struct file_lock *);
-extern struct file_lock * locks_alloc_lock(void);
-extern void locks_copy_lock(struct file_lock *, struct file_lock *);
-extern void locks_copy_conflock(struct file_lock *, struct file_lock *);
-extern void locks_remove_posix(struct file *, fl_owner_t);
-extern void locks_remove_file(struct file *);
-extern void locks_release_private(struct file_lock *);
-extern void posix_test_lock(struct file *, struct file_lock *);
-extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
-extern int locks_delete_block(struct file_lock *);
-extern int vfs_test_lock(struct file *, struct file_lock *);
-extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
-extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
-bool vfs_inode_has_locks(struct inode *inode);
-extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
-extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
-extern void lease_get_mtime(struct inode *, struct timespec64 *time);
-extern int generic_setlease(struct file *, long, struct file_lock **, void **priv);
-extern int vfs_setlease(struct file *, long, struct file_lock **, void **);
-extern int lease_modify(struct file_lock *, int, struct list_head *);
-
-struct notifier_block;
-extern int lease_register_notifier(struct notifier_block *);
-extern void lease_unregister_notifier(struct notifier_block *);
-
-struct files_struct;
-extern void show_fd_locks(struct seq_file *f,
-			 struct file *filp, struct files_struct *files);
-extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
-			fl_owner_t owner);
-
-static inline struct file_lock_context *
-locks_inode_context(const struct inode *inode)
-{
-	return smp_load_acquire(&inode->i_flctx);
-}
-
-#else /* !CONFIG_FILE_LOCKING */
-static inline int fcntl_getlk(struct file *file, unsigned int cmd,
-			      struct flock __user *user)
-{
-	return -EINVAL;
-}
-
-static inline int fcntl_setlk(unsigned int fd, struct file *file,
-			      unsigned int cmd, struct flock __user *user)
-{
-	return -EACCES;
-}
-
-#if BITS_PER_LONG == 32
-static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
-				struct flock64 *user)
-{
-	return -EINVAL;
-}
-
-static inline int fcntl_setlk64(unsigned int fd, struct file *file,
-				unsigned int cmd, struct flock64 *user)
-{
-	return -EACCES;
-}
-#endif
-static inline int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
-{
-	return -EINVAL;
-}
-
-static inline int fcntl_getlease(struct file *filp)
-{
-	return F_UNLCK;
-}
-
-static inline void
-locks_free_lock_context(struct inode *inode)
-{
-}
-
-static inline void locks_init_lock(struct file_lock *fl)
-{
-	return;
-}
-
-static inline void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
-{
-	return;
-}
-
-static inline void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
-{
-	return;
-}
-
-static inline void locks_remove_posix(struct file *filp, fl_owner_t owner)
-{
-	return;
-}
-
-static inline void locks_remove_file(struct file *filp)
-{
-	return;
-}
-
-static inline void posix_test_lock(struct file *filp, struct file_lock *fl)
-{
-	return;
-}
-
-static inline int posix_lock_file(struct file *filp, struct file_lock *fl,
-				  struct file_lock *conflock)
-{
-	return -ENOLCK;
-}
-
-static inline int locks_delete_block(struct file_lock *waiter)
-{
-	return -ENOENT;
-}
-
-static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
-{
-	return 0;
-}
-
-static inline int vfs_lock_file(struct file *filp, unsigned int cmd,
-				struct file_lock *fl, struct file_lock *conf)
-{
-	return -ENOLCK;
-}
-
-static inline int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
-{
-	return 0;
-}
-
-static inline bool vfs_inode_has_locks(struct inode *inode)
-{
-	return false;
-}
-
-static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl)
-{
-	return -ENOLCK;
-}
-
-static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
-{
-	return 0;
-}
-
-static inline void lease_get_mtime(struct inode *inode,
-				   struct timespec64 *time)
-{
-	return;
-}
-
-static inline int generic_setlease(struct file *filp, long arg,
-				    struct file_lock **flp, void **priv)
-{
-	return -EINVAL;
-}
-
-static inline int vfs_setlease(struct file *filp, long arg,
-			       struct file_lock **lease, void **priv)
-{
-	return -EINVAL;
-}
-
-static inline int lease_modify(struct file_lock *fl, int arg,
-			       struct list_head *dispose)
-{
-	return -EINVAL;
-}
-
-struct files_struct;
-static inline void show_fd_locks(struct seq_file *f,
-			struct file *filp, struct files_struct *files) {}
-static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
-			fl_owner_t owner)
-{
-	return false;
-}
-
-static inline struct file_lock_context *
-locks_inode_context(const struct inode *inode)
-{
-	return NULL;
-}
-
-#endif /* !CONFIG_FILE_LOCKING */
-
 static inline struct inode *file_inode(const struct file *f)
 {
 	return f->f_inode;
@@ -1357,11 +1026,6 @@ static inline struct dentry *file_dentry(const struct file *file)
 	return d_real(file->f_path.dentry, file_inode(file));
 }
 
-static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
-{
-	return locks_lock_inode_wait(locks_inode(filp), fl);
-}
-
 struct fasync_struct {
 	rwlock_t		fa_lock;
 	int			magic;
@@ -2621,96 +2285,6 @@ extern struct kobject *fs_kobj;
 
 #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)
 
-#ifdef CONFIG_FILE_LOCKING
-static inline int break_lease(struct inode *inode, unsigned int mode)
-{
-	/*
-	 * Since this check is lockless, we must ensure that any refcounts
-	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
-	 * could end up racing with tasks trying to set a new lease on this
-	 * file.
-	 */
-	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
-		return __break_lease(inode, mode, FL_LEASE);
-	return 0;
-}
-
-static inline int break_deleg(struct inode *inode, unsigned int mode)
-{
-	/*
-	 * Since this check is lockless, we must ensure that any refcounts
-	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
-	 * could end up racing with tasks trying to set a new lease on this
-	 * file.
-	 */
-	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
-		return __break_lease(inode, mode, FL_DELEG);
-	return 0;
-}
-
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
-{
-	int ret;
-
-	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
-	if (ret == -EWOULDBLOCK && delegated_inode) {
-		*delegated_inode = inode;
-		ihold(inode);
-	}
-	return ret;
-}
-
-static inline int break_deleg_wait(struct inode **delegated_inode)
-{
-	int ret;
-
-	ret = break_deleg(*delegated_inode, O_WRONLY);
-	iput(*delegated_inode);
-	*delegated_inode = NULL;
-	return ret;
-}
-
-static inline int break_layout(struct inode *inode, bool wait)
-{
-	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
-		return __break_lease(inode,
-				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
-				FL_LAYOUT);
-	return 0;
-}
-
-#else /* !CONFIG_FILE_LOCKING */
-static inline int break_lease(struct inode *inode, unsigned int mode)
-{
-	return 0;
-}
-
-static inline int break_deleg(struct inode *inode, unsigned int mode)
-{
-	return 0;
-}
-
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
-{
-	return 0;
-}
-
-static inline int break_deleg_wait(struct inode **delegated_inode)
-{
-	BUG();
-	return 0;
-}
-
-static inline int break_layout(struct inode *inode, bool wait)
-{
-	return 0;
-}
-
-#endif /* CONFIG_FILE_LOCKING */
-
 /* fs/open.c */
 struct audit_names;
 struct filename {
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 67e4a2c5500b..b60fbcd8cdfa 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -11,6 +11,7 @@
 #define LOCKD_XDR_H
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>
 
-- 
2.39.0

