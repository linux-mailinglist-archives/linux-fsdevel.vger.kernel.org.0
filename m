Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25DD542025
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiFHASA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835787AbiFGX47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:56:59 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F3FCEEB
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o5+rVrVSGB5fp+S6r4gRgbGgznNf/uBiJOd+BSn1lf8=; b=KrNIjUu46S9JlzF4hv4GgQwx38
        ZUtBp38ufb05y9jJN5uqANlqtOUF5nT6uYAh+e+tWGw5LDfGLWyTuGcv92484fnYe44Oy/TG800bZ
        itVLDTc16sffAPQuPyArhTfA5QO9QJJWYgxVGtb/VVfJ53Oii7zJauY6NOr18g8mpVEXaZGb3xj1N
        5KbG3S8V5Rzyj3HR8fxe+a8ZRbgFiy4XiO/ed4GML5ef8CzmwbEika2Uk++7xja942yGvzCrwd9NL
        NwSWy3MDM67KhH6muzJZXd1OAVwmfg+PHNLdQ76LExfFrHG88x12o39Bu/y4kEjEWNEoS4KiIqAzI
        E+mxfV0Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyifn-004ttX-V6; Tue, 07 Jun 2022 23:31:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 06/10] keep iocb_flags() result cached in struct file
Date:   Tue,  7 Jun 2022 23:31:39 +0000
Message-Id: <20220607233143.1168114-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* calculate at the time we set FMODE_OPENED (do_dentry_open() for normal
opens, alloc_file() for pipe()/socket()/etc.)
* update when handling F_SETFL
* keep in a new field - file->f_i_flags; since that thing is needed only
before the refcount reaches zero, we can put it into the same anon union
where ->f_rcuhead and ->f_llist live - those are used only after refcount
reaches zero.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 fs/aio.c                          | 2 +-
 fs/fcntl.c                        | 1 +
 fs/file_table.c                   | 1 +
 fs/io_uring.c                     | 2 +-
 fs/open.c                         | 1 +
 include/linux/fs.h                | 5 ++---
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index f3d58abf11e0..2be306fe9c13 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -112,7 +112,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
+	iocb->ki_flags = ki_flags | iocb->ki_filp->f_i_flags;
 
 	return call_iter(iocb, &iter);
 }
diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..fb84adb6dc00 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1475,7 +1475,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = req->ki_filp->f_i_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 34a3faa4886d..696faccb1726 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -78,6 +78,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 	}
 	spin_lock(&filp->f_lock);
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
+	filp->f_i_flags = iocb_flags(filp);
 	spin_unlock(&filp->f_lock);
 
  out:
diff --git a/fs/file_table.c b/fs/file_table.c
index b989e33aacda..3d1800ad3857 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -241,6 +241,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 	if ((file->f_mode & FMODE_WRITE) &&
 	     likely(fop->write || fop->write_iter))
 		file->f_mode |= FMODE_CAN_WRITE;
+	file->f_i_flags = iocb_flags(file);
 	file->f_mode |= FMODE_OPENED;
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3aab4182fd89..79d475bebf30 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4330,7 +4330,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!io_req_ffs_set(req))
 		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
 
-	kiocb->ki_flags = iocb_flags(file);
+	kiocb->ki_flags = file->f_i_flags;
 	ret = kiocb_set_rw_flags(kiocb, req->rw.flags);
 	if (unlikely(ret))
 		return ret;
diff --git a/fs/open.c b/fs/open.c
index 1d57fbde2feb..1f45c63716ee 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -862,6 +862,7 @@ static int do_dentry_open(struct file *f,
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+	f->f_i_flags = iocb_flags(f);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 380a1292f4f9..7f4530a219b6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -926,6 +926,7 @@ struct file {
 	union {
 		struct llist_node	f_llist;
 		struct rcu_head 	f_rcuhead;
+		unsigned int 		f_i_flags;
 	};
 	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
@@ -2199,13 +2200,11 @@ static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
 	       !gid_valid(i_gid_into_mnt(mnt_userns, inode));
 }
 
-static inline int iocb_flags(struct file *file);
-
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
-		.ki_flags = iocb_flags(filp),
+		.ki_flags = filp->f_i_flags,
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
-- 
2.30.2

