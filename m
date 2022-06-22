Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54702554161
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbiFVEQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356697AbiFVEP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854060E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uRY2CcDaI7j2Qa7squjvpnb9XeTEMfUPt3NGdMa0Dmo=; b=hiUAldtQ8O9ijynsdZsiY3JhLU
        W0mTz2ReZeFzHKmznesp0JytEaobOsaGeS4prFW64MGq46k85T16otaTTMs9YYYJoE4+bmO6en7Vg
        PLqZWIPqFihhxgor5wEdYV7pTBBMUtKFV/P5Ux9Ba3HY3wsVTA3I2MssYXHPXmltQ4droozOUBim0
        2/Go1MwVpvpUZOqTrwUH9Sem94p6TD9tMdgwH14mNGwnFPn7uDofgXdq3WaPJiD/0A6jilx1AoPFB
        qmBsfjCCU5vlwZetyasxl7Rwl5R85W3n+sjE9H9aBQflC1owPhaTUXWGytzKOPtfIwmGNz4yF+KzP
        dWPWoNPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmT-0035vj-IO;
        Wed, 22 Jun 2022 04:15:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 07/44] keep iocb_flags() result cached in struct file
Date:   Wed, 22 Jun 2022 05:15:15 +0100
Message-Id: <20220622041552.737754-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* calculate at the time we set FMODE_OPENED (do_dentry_open() for normal
opens, alloc_file() for pipe()/socket()/etc.)
* update when handling F_SETFL
* keep in a new field - file->f_iocb_flags; since that thing is needed only
before the refcount reaches zero, we can put it into the same anon union
where ->f_rcuhead and ->f_llist live - those are used only after refcount
reaches zero.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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
index f3d58abf11e0..64b47e2a4633 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -112,7 +112,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
+	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
 	return call_iter(iocb, &iter);
 }
diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..2bdd444d408b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1475,7 +1475,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = req->ki_filp->f_iocb_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 34a3faa4886d..146c9ab0cd4b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -78,6 +78,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 	}
 	spin_lock(&filp->f_lock);
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
+	filp->f_iocb_flags = iocb_flags(filp);
 	spin_unlock(&filp->f_lock);
 
  out:
diff --git a/fs/file_table.c b/fs/file_table.c
index b989e33aacda..905792b0521c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -241,6 +241,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 	if ((file->f_mode & FMODE_WRITE) &&
 	     likely(fop->write || fop->write_iter))
 		file->f_mode |= FMODE_CAN_WRITE;
+	file->f_iocb_flags = iocb_flags(file);
 	file->f_mode |= FMODE_OPENED;
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3aab4182fd89..53424b1f019f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4330,7 +4330,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!io_req_ffs_set(req))
 		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
 
-	kiocb->ki_flags = iocb_flags(file);
+	kiocb->ki_flags = file->f_iocb_flags;
 	ret = kiocb_set_rw_flags(kiocb, req->rw.flags);
 	if (unlikely(ret))
 		return ret;
diff --git a/fs/open.c b/fs/open.c
index 1d57fbde2feb..d80441a0bf17 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -862,6 +862,7 @@ static int do_dentry_open(struct file *f,
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+	f->f_iocb_flags = iocb_flags(f);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 380a1292f4f9..c82b9d442f56 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -926,6 +926,7 @@ struct file {
 	union {
 		struct llist_node	f_llist;
 		struct rcu_head 	f_rcuhead;
+		unsigned int 		f_iocb_flags;
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
+		.ki_flags = filp->f_iocb_flags,
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
-- 
2.30.2

