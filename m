Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3BE21D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfEQShE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:04 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57578 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000o3-Ii; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 05/22] coda: potential buffer overflow in coda_psdev_write()
Date:   Fri, 17 May 2019 14:36:43 -0400
Message-Id: <894fb6b250add09e4e3935f14649f21284a5cb18.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add checks to make sure the downcall message we got from the Coda cache
manager is large enough to contain the data it is supposed to have.
i.e. when we get a CODA_ZAPDIR we can access &out->coda_zapdir.CodaFid.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c            |  8 ++++++--
 fs/coda/upcall.c           | 34 +++++++++++++++++++++++++++++++++-
 include/linux/coda_psdev.h |  3 ++-
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 12cec325384c..0cd646a5d0c2 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -104,8 +104,12 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 	ssize_t retval = 0, count = 0;
 	int error;
 
+	/* make sure there is enough to copy out the (opcode, unique) values */
+	if (nbytes < (2 * sizeof(u_int32_t)))
+		return -EINVAL;
+
         /* Peek at the opcode, uniquefier */
-	if (copy_from_user(&hdr, buf, 2 * sizeof(u_long)))
+	if (copy_from_user(&hdr, buf, 2 * sizeof(u_int32_t)))
 	        return -EFAULT;
 
         if (DOWNCALL(hdr.opcode)) {
@@ -131,7 +135,7 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		}
 
 		/* what downcall errors does Venus handle ? */
-		error = coda_downcall(vcp, hdr.opcode, dcbuf);
+		error = coda_downcall(vcp, hdr.opcode, dcbuf, nbytes);
 
 		CODA_FREE(dcbuf, nbytes);
 		if (error) {
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1175a1722411..cf1e662681a5 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -804,12 +804,44 @@ static int coda_upcall(struct venus_comm *vcp,
  *
  * CODA_REPLACE -- replace one CodaFid with another throughout the name cache */
 
-int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out)
+int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out,
+		  size_t nbytes)
 {
 	struct inode *inode = NULL;
 	struct CodaFid *fid = NULL, *newfid;
 	struct super_block *sb;
 
+	/*
+	 * Make sure we have received enough data from the cache
+	 * manager to populate the necessary fields in the buffer
+	 */
+	switch (opcode) {
+	case CODA_PURGEUSER:
+		if (nbytes < sizeof(struct coda_purgeuser_out))
+			return -EINVAL;
+		break;
+
+	case CODA_ZAPDIR:
+		if (nbytes < sizeof(struct coda_zapdir_out))
+			return -EINVAL;
+		break;
+
+	case CODA_ZAPFILE:
+		if (nbytes < sizeof(struct coda_zapfile_out))
+			return -EINVAL;
+		break;
+
+	case CODA_PURGEFID:
+		if (nbytes < sizeof(struct coda_purgefid_out))
+			return -EINVAL;
+		break;
+
+	case CODA_REPLACE:
+		if (nbytes < sizeof(struct coda_replace_out))
+			return -EINVAL;
+		break;
+	}
+
 	/* Handle invalidation requests. */
 	mutex_lock(&vcp->vc_mutex);
 	sb = vcp->vc_sb;
diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 57d2b2faf6a3..d1672fd5e638 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -71,7 +71,8 @@ int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 int venus_access(struct super_block *sb, struct CodaFid *fid, int mask);
 int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 		 unsigned int cmd, struct PioctlData *data);
-int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out);
+int coda_downcall(struct venus_comm *vcp, int opcode, union outputArgs *out,
+		  size_t nbytes);
 int venus_fsync(struct super_block *sb, struct CodaFid *fid);
 int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
 
-- 
2.20.1

