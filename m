Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642C046EBD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhLIPl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42572 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbhLIPkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6B50CE2686;
        Thu,  9 Dec 2021 15:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CC8C341CB;
        Thu,  9 Dec 2021 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064234;
        bh=IZh7sC+wV4H0h89t2oGHa0fMHgaRBEKJfu2O1gu4cdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/bM9v/rgolgZj2LvDTk0mwWgzLuygCF/3K9k95D0oPec8OdUApAYilnNKzzV32HB
         k73GONlw4fLd7es5OZQ9FWFwXWnaNE9eyowCMxeo9yI/R0C54hbyu1JCsLJe4020Ot
         aj1AW0D8dB3NHuxNDMHBVznk+iwvFXnOmXzi5WTeblybVM0e8r/4+0HpWCTdDXOYnz
         pYJdq99i4A9JkCp82PVF3N9Ly6qpB3QnaRMK6uTi01TcRhix7nbCOjEr1H/hwbN3FH
         RlQtg//wRK9SP/MdkW8qbQwA60d2pn1KCXAr2XUC+d+NsP2jCvOa2s5TpEx+b48sDp
         7/FKpDY2/KNvA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 35/36] ceph: add object version support for sync read
Date:   Thu,  9 Dec 2021 10:36:46 -0500
Message-Id: <20211209153647.58953-36-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Always return the last object's version.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c  | 11 +++++++++--
 fs/ceph/super.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b42158c9aa16..cb72362cb46f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -883,7 +883,8 @@ enum {
  * only return a short read to the caller if we hit EOF.
  */
 ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
-			 struct iov_iter *to, int *retry_op)
+			 struct iov_iter *to, int *retry_op,
+			 u64 *last_objver)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -892,6 +893,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	u64 off = *ki_pos;
 	u64 len = iov_iter_count(to);
 	u64 i_size = i_size_read(inode);
+	u64 objver = 0;
 
 	dout("sync_read on inode %p %llu~%u\n", inode, *ki_pos, (unsigned)len);
 
@@ -950,6 +952,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 					 req->r_end_latency,
 					 len, ret);
 
+		if (ret > 0)
+			objver = req->r_version;
 		ceph_osdc_put_request(req);
 
 		i_size = i_size_read(inode);
@@ -1006,6 +1010,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		}
 	}
 
+	if (last_objver && ret > 0)
+		*last_objver = objver;
+
 	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
 	return ret;
 }
@@ -1020,7 +1027,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	     (unsigned)iov_iter_count(to),
 	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
 
-	return __ceph_sync_read(inode, &iocb->ki_pos, to, retry_op);
+	return __ceph_sync_read(inode, &iocb->ki_pos, to, retry_op, NULL);
 }
 
 struct ceph_aio_request {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d8f768495a17..b3393406e84f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1259,7 +1259,8 @@ extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode);
 extern ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
-				struct iov_iter *to, int *retry_op);
+				struct iov_iter *to, int *retry_op,
+				u64 *last_objver);
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
-- 
2.33.1

