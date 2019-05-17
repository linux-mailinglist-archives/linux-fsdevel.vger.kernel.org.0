Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87A821D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfEQShL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:11 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57612 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729369AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000oo-1Y; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 13/22] coda: get rid of CODA_FREE()
Date:   Fri, 17 May 2019 14:36:51 -0400
Message-Id: <4950a94fd30ec5f84835dd4ca0bb67c0448672f5.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The CODA_FREE() macro just calls kvfree().  We can call that directly
instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/coda_linux.h |  2 --
 fs/coda/psdev.c      |  8 ++++----
 fs/coda/upcall.c     | 36 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 1ea9521e79d7..517a363245c9 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -63,8 +63,6 @@ unsigned short coda_flags_to_cflags(unsigned short);
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
 
-#define CODA_FREE(ptr, size) kvfree((ptr))
-
 /* inode to cnode access functions */
 
 static inline struct coda_inode_info *ITOC(struct inode *inode)
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index e90ac440fa29..4c8d968031bb 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -133,7 +133,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 		if (copy_from_user(dcbuf, buf, nbytes)) {
-			CODA_FREE(dcbuf, nbytes);
+			kvfree(dcbuf);
 			retval = -EFAULT;
 			goto out;
 		}
@@ -141,7 +141,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		/* what downcall errors does Venus handle ? */
 		error = coda_downcall(vcp, hdr.opcode, dcbuf, nbytes);
 
-		CODA_FREE(dcbuf, nbytes);
+		kvfree(dcbuf);
 		if (error) {
 			pr_warn("%s: coda_downcall error: %d\n",
 				__func__, error);
@@ -267,7 +267,7 @@ static ssize_t coda_psdev_read(struct file * file, char __user * buf,
 		goto out;
 	}
 
-	CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+	kvfree(req->uc_data);
 	kfree(req);
 out:
 	mutex_unlock(&vcp->vc_mutex);
@@ -329,7 +329,7 @@ static int coda_psdev_release(struct inode * inode, struct file * file)
 
 		/* Async requests need to be freed here */
 		if (req->uc_flags & CODA_REQ_ASYNC) {
-			CODA_FREE(req->uc_data, sizeof(struct coda_in_hdr));
+			kvfree(req->uc_data);
 			kfree(req);
 			continue;
 		}
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index b6ac5fc98189..1e2f50722107 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -85,7 +85,7 @@ int venus_rootfid(struct super_block *sb, struct CodaFid *fidp)
 	if (!error)
 		*fidp = outp->coda_root.VFid;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -104,7 +104,7 @@ int venus_getattr(struct super_block *sb, struct CodaFid *fid,
 	if (!error)
 		*attr = outp->coda_getattr.attr;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -123,7 +123,7 @@ int venus_setattr(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -153,7 +153,7 @@ int venus_lookup(struct super_block *sb, struct CodaFid *fid,
 		*type = outp->coda_lookup.vtype;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -173,7 +173,7 @@ int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -194,7 +194,7 @@ int venus_open(struct super_block *sb, struct CodaFid *fid,
 	if (!error)
 		*fh = outp->coda_open_by_fd.fh;
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }	
 
@@ -224,7 +224,7 @@ int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid,
 		*newfid = outp->coda_mkdir.VFid;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;        
 }
 
@@ -262,7 +262,7 @@ int venus_rename(struct super_block *sb, struct CodaFid *old_fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -295,7 +295,7 @@ int venus_create(struct super_block *sb, struct CodaFid *dirfid,
 		*newfid = outp->coda_create.VFid;
 	}
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;        
 }
 
@@ -318,7 +318,7 @@ int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -340,7 +340,7 @@ int venus_remove(struct super_block *sb, struct CodaFid *dirfid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -370,7 +370,7 @@ int venus_readlink(struct super_block *sb, struct CodaFid *fid,
 		*(buffer + retlen) = '\0';
 	}
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -398,7 +398,7 @@ int venus_link(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -433,7 +433,7 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
@@ -449,7 +449,7 @@ int venus_fsync(struct super_block *sb, struct CodaFid *fid)
 	inp->coda_fsync.VFid = *fid;
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -467,7 +467,7 @@ int venus_access(struct super_block *sb, struct CodaFid *fid, int mask)
 
 	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -543,7 +543,7 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 	}
 
  exit:
-	CODA_FREE(inp, insize);
+	kvfree(inp);
 	return error;
 }
 
@@ -565,7 +565,7 @@ int venus_statfs(struct dentry *dentry, struct kstatfs *sfs)
 		sfs->f_ffree  = outp->coda_statfs.stat.f_ffree;
 	}
 
-        CODA_FREE(inp, insize);
+	kvfree(inp);
         return error;
 }
 
-- 
2.20.1

