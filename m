Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B04743EBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjF3P06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjF3P0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C22D5B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdlHa+W7u2onhke2f0yOnHTE0908QZoN85mOH5J+0KA=;
        b=NNDhMhb1Vkd/BfSGDplP3RpNOHWoKZQYgGjUWSKkv0MEoQpoZJAbQECjhX+B+CyT54J8RB
        GHgAoN7V+063lzl+0OauWP8SkjPOXJWlto/y6tmbWlRX6FgF8iG2uYkjWtfomsXRayc4Ph
        Q1EBxblxtZ58chDEmQ/tlaq0EWgvuOM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-87Ss81i6PaiGVn_k9Z4wDg-1; Fri, 30 Jun 2023 11:25:38 -0400
X-MC-Unique: 87Ss81i6PaiGVn_k9Z4wDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2096B29AA2CC;
        Fri, 30 Jun 2023 15:25:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A0B492C13;
        Fri, 30 Jun 2023 15:25:34 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 03/11] vfs: Use init_kiocb() to initialise new IOCBs
Date:   Fri, 30 Jun 2023 16:25:16 +0100
Message-ID: <20230630152524.661208-4-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A number of places that generate kiocbs didn't use init_sync_kiocb() to
initialise the new kiocb.  Fix these to always use init_kiocb().

Note that aio and io_uring pass information in through ki_filp through an
overlaid union before I can call init_kiocb(), so that gets reinitialised.
I don't think it clobbers anything else.

After this point, IOCB_WRITE is only set by init_kiocb().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/loop.c              | 11 ++++++-----
 drivers/nvme/target/io-cmd-file.c |  5 +++--
 drivers/target/target_core_file.c |  2 +-
 fs/aio.c                          |  9 ++++-----
 fs/cachefiles/io.c                | 10 ++++------
 io_uring/rw.c                     | 10 +++++-----
 6 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 37511d2b2caf..ea92235c5ba2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -439,16 +439,17 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, rw == WRITE ? ITER_SOURCE : ITER_DEST,
+		      bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
+	init_kiocb(&cmd->iocb, file, rw);
 	cmd->iocb.ki_pos = pos;
-	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == ITER_SOURCE)
+	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
@@ -490,12 +491,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
+			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
+			return lo_rw_aio(lo, cmd, pos, READ);
 		else
 			return lo_read_simple(lo, rq, pos);
 	default:
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..0b6577d51b69 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -85,17 +85,18 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
 		call_iter = req->ns->file->f_op->write_iter;
+		init_kiocb(iocb, req->ns->file, WRITE);
 		rw = ITER_SOURCE;
 	} else {
 		call_iter = req->ns->file->f_op->read_iter;
+		init_kiocb(iocb, req->ns->file, READ);
 		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
 
+	iocb->ki_flags |= ki_flags;
 	iocb->ki_pos = pos;
-	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
 	return call_iter(iocb, &iter);
 }
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index ce0e000b74fc..d70cf89959dc 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -287,11 +287,11 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	}
 
 	iov_iter_bvec(&iter, is_write, aio_cmd->bvecs, sgl_nents, len);
+	init_kiocb(&aio_cmd->iocb, file, is_write);
 
 	aio_cmd->cmd = cmd;
 	aio_cmd->len = len;
 	aio_cmd->iocb.ki_pos = cmd->t_task_lba * dev->dev_attrib.block_size;
-	aio_cmd->iocb.ki_filp = file;
 	aio_cmd->iocb.ki_complete = cmd_rw_aio_complete;
 	aio_cmd->iocb.ki_flags = IOCB_DIRECT;
 
diff --git a/fs/aio.c b/fs/aio.c
index 77e33619de40..26e173be9448 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1461,14 +1461,14 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
 	iocb_put(iocb);
 }
 
-static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
+static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb, int rw)
 {
 	int ret;
 
+	init_kiocb(req, req->ki_filp, rw);
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
@@ -1539,7 +1539,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	struct file *file;
 	int ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(req, iocb, READ);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1566,7 +1566,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	struct file *file;
 	int ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(req, iocb, WRITE);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1592,7 +1592,6 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			sb_start_write(file_inode(file)->i_sb);
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
-		req->ki_flags |= IOCB_WRITE;
 		aio_rw_done(req, call_write_iter(file, req, &iter));
 	}
 	kfree(iovec);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 175a25fcade8..2c47788f38d2 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -134,11 +134,10 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	if (!ki)
 		goto presubmission_error;
 
+	init_kiocb(&ki->iocb, file, READ);
 	refcount_set(&ki->ki_refcnt, 2);
-	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_flags	|= IOCB_DIRECT;
 	ki->iocb.ki_pos		= start_pos + skipped;
-	ki->iocb.ki_flags	= IOCB_DIRECT;
-	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
 	ki->object		= object;
 	ki->inval_counter	= cres->inval_counter;
@@ -306,10 +305,9 @@ int __cachefiles_write(struct cachefiles_object *object,
 	}
 
 	refcount_set(&ki->ki_refcnt, 2);
-	ki->iocb.ki_filp	= file;
+	init_kiocb(&ki->iocb, file, WRITE);
 	ki->iocb.ki_pos		= start_pos;
-	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
-	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->iocb.ki_flags	|= IOCB_DIRECT;
 	ki->object		= object;
 	ki->start		= start_pos;
 	ki->len			= len;
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1bce2208b65c..1cade1567162 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -655,12 +655,13 @@ static bool need_complete_io(struct io_kiocb *req)
 		S_ISBLK(file_inode(req->file)->i_mode);
 }
 
-static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
+static int io_rw_init_file(struct io_kiocb *req, unsigned int io_direction)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	struct kiocb *kiocb = &rw->kiocb;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct file *file = req->file;
+	fmode_t mode = (io_direction == WRITE) ? FMODE_WRITE : FMODE_READ;
 	int ret;
 
 	if (unlikely(!file || !(file->f_mode & mode)))
@@ -669,7 +670,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!(req->flags & REQ_F_FIXED_FILE))
 		req->flags |= io_file_get_flags(file);
 
-	kiocb->ki_flags = file->f_iocb_flags;
+	init_kiocb(kiocb, file, io_direction);
 	ret = kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
@@ -738,7 +739,7 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		iov_iter_restore(&s->iter, &s->iter_state);
 		iovec = NULL;
 	}
-	ret = io_rw_init_file(req, FMODE_READ);
+	ret = io_rw_init_file(req, READ);
 	if (unlikely(ret)) {
 		kfree(iovec);
 		return ret;
@@ -870,7 +871,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		iov_iter_restore(&s->iter, &s->iter_state);
 		iovec = NULL;
 	}
-	ret = io_rw_init_file(req, FMODE_WRITE);
+	ret = io_rw_init_file(req, WRITE);
 	if (unlikely(ret)) {
 		kfree(iovec);
 		return ret;
@@ -914,7 +915,6 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		__sb_writers_release(file_inode(req->file)->i_sb,
 					SB_FREEZE_WRITE);
 	}
-	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
 		ret2 = call_write_iter(req->file, kiocb, &s->iter);

