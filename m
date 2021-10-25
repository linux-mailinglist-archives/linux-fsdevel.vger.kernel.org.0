Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0529439A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhJYPf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhJYPf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:35:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FFC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 08:33:04 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s9so16087535oiw.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cEyCzuuS0cdcR0az2uvWKDPA6dR7zElh2AWoTXWWZ94=;
        b=GGsAyjHJSn5NZpnBgyje/CuxLw1kPKd6ipEOvXzfy9kyI0nvQginpuQVqMkEjjo4Qt
         y83w8UaOTwymxkmYjd639gFq8S+qCfMBdYXbtBj0SS8/gJjy+go+hwnAgMQf1IuH9F+p
         7mEAWQiRNzaLGJfyxMr+FDFfSxy91MN63XxyLYhdwq79eV/PSa/QayLFJoDurxdEnKO7
         KNKuu6nzrsBWsUMpYnj0hTk9wyzu21MVkreQrHFJrQgOhGkz3IaxFErhFKfmMUH4qyGw
         XjA9/exYd6VBKI/7EqbqCPvqmIikjm2nvfUDaepNz518bEMc+MRM0hia/7oufP/+0wi7
         1HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cEyCzuuS0cdcR0az2uvWKDPA6dR7zElh2AWoTXWWZ94=;
        b=TW4N1k/uhw3zcXfWnTVFSwGy40b72tAz9myTbyu0SRaxJS3qpO+CMyM2t/GcGpY0vi
         eHR3pVs+D0lZdsq/8T4xdpYiIfw39NTYZjj8vOwZr7GHnQK4OlUHA18Z3DestQyEJp6l
         Wl9e8Kqr96IP2GFQXQ9RdX07CgVBCdO80c6GwJkfOZnmtPSwlSqF09BWLR5K5HdheSTe
         ujTn8Q8zkiBhGzI8UT8t6GlVyZz2wKavC8ab6i67b/nAtnMk6G2Yb3jfFXw1FHpaXFJE
         x92ef7ahq4ssbwnCkG8VcoC09JZc3HzKm/03Y/pePr+cP9IvqLGb0FBB2gwBeZ6oV9u2
         MeOA==
X-Gm-Message-State: AOAM533h6kUl1+5GWRhrqI+VSlLGy0HbS7BHazWhF0HZPVf+GrM0+X49
        +Tf1zGXEj7sf+q+Tr/9ruVgjonQ8/9/fZA==
X-Google-Smtp-Source: ABdhPJwQthK4NFvYQBImtmE512LM3Tc9X6Cj6I3XHDQrfPg8MLixV5R9ZuW1puzGhTC+rABHXP2p9Q==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr23757245oia.120.1635175983486;
        Mon, 25 Oct 2021 08:33:03 -0700 (PDT)
Received: from ?IPv6:2600:380:602d:d087:5bee:e9ee:c67d:4ccf? ([2600:380:602d:d087:5bee:e9ee:c67d:4ccf])
        by smtp.gmail.com with ESMTPSA id e32sm3118826oow.30.2021.10.25.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:33:03 -0700 (PDT)
To:     linux-aio@kvack.org
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PTACH] fs: get rid of the res2 iocb->ki_complete argument
Message-ID: <4e54bfd2-3097-ab52-381b-4f2bf3a1d782@kernel.dk>
Date:   Mon, 25 Oct 2021 09:33:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The second argument was only used by the USB gadget code, yet everyone
pays the overhead of passing a zero to be passed into aio, where it
ends up being part of the aio res2 value.

Now that everybody is passing in zero, kill off the extra argument.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since the USB side got acked, this is the followup that just removes the
argument that is now always zero.

diff --git a/block/fops.c b/block/fops.c
index 396537598e3e..d86ebda73e8c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -164,7 +164,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 				ret = blk_status_to_errno(dio->bio.bi_status);
 			}
 
-			dio->iocb->ki_complete(iocb, ret, 0);
+			dio->iocb->ki_complete(iocb, ret);
 			if (dio->flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 8bd288d2b089..3dd5a773c320 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1076,7 +1076,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	af_alg_free_resources(areq);
 	sock_put(sk);
 
-	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
+	iocb->ki_complete(iocb, err ? err : (int)resultlen);
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..469d87e24fd4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -554,7 +554,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
@@ -627,7 +627,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	lo_rw_aio_do_completion(cmd);
 
 	if (ret != -EIOCBQUEUED)
-		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 1dd1a0fe2e81..6aa30f30b572 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -125,7 +125,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
@@ -222,7 +222,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 complete:
-	nvmet_file_io_done(&req->f.iocb, ret, 0);
+	nvmet_file_io_done(&req->f.iocb, ret);
 	return true;
 }
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 02f64453b4c5..8190b840065f 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -245,7 +245,7 @@ struct target_core_file_cmd {
 	struct bio_vec	bvecs[];
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct target_core_file_cmd *cmd;
 
@@ -303,7 +303,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
 
 	if (ret != -EIOCBQUEUED)
-		cmd_rw_aio_complete(&aio_cmd->iocb, ret, 0);
+		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 7bd22398d52f..e20c19a0f106 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, 0);
+	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 28d3d4e71182..78be94750232 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -469,7 +469,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret, 0);
+	iocb->ki_complete(iocb, ret);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -497,8 +497,7 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		kfree(priv);
 		iocb->private = NULL;
 		iocb->ki_complete(iocb,
-				req->actual ? req->actual : (long)req->status,
-				0);
+				req->actual ? req->actual : (long)req->status);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..836dc7e48db7 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1417,7 +1417,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void aio_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
@@ -1437,7 +1437,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	}
 
 	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
+	iocb->ki_res.res2 = 0;
 	iocb_put(iocb);
 }
 
@@ -1508,7 +1508,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		req->ki_complete(req, ret, 0);
+		req->ki_complete(req, ret);
 	}
 }
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index fac2e8e7b533..effe37ef8629 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -37,11 +37,11 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 /*
  * Handle completion of a read from the cache.
  */
-static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_read_complete(struct kiocb *iocb, long ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%ld", ret);
 
 	if (ki->term_func) {
 		if (ret >= 0)
@@ -139,7 +139,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_read_complete(&ki->iocb, ret, 0);
+		cachefiles_read_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
@@ -159,12 +159,12 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 /*
  * Handle completion of a write to the cache.
  */
-static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%ld", ret);
 
 	/* Tell lockdep we inherited freeze protection from submission thread */
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
@@ -244,7 +244,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_write_complete(&ki->iocb, ret, 0);
+		cachefiles_write_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d16fd2d5fd42..e10a80c1b581 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1023,7 +1023,7 @@ static void ceph_aio_complete(struct inode *inode,
 	ceph_put_cap_refs(ci, (aio_req->write ? CEPH_CAP_FILE_WR :
 						CEPH_CAP_FILE_RD));
 
-	aio_req->iocb->ki_complete(aio_req->iocb, ret, 0);
+	aio_req->iocb->ki_complete(aio_req->iocb, ret);
 
 	ceph_free_cap_flush(aio_req->prealloc_cf);
 	kfree(aio_req);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 13f3182cf796..1b855fcb179e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3184,7 +3184,7 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
@@ -3917,7 +3917,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 453dcff0e7f5..654443558047 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -307,7 +307,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 
 		if (ret > 0 && dio->op == REQ_OP_WRITE)
 			ret = generic_write_sync(dio->iocb, ret);
-		dio->iocb->ki_complete(dio->iocb, ret, 0);
+		dio->iocb->ki_complete(dio->iocb, ret);
 	}
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..e6039f22311b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -687,7 +687,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			spin_unlock(&fi->lock);
 		}
 
-		io->iocb->ki_complete(io->iocb, res, 0);
+		io->iocb->ki_complete(io->iocb, res);
 	}
 
 	kref_put(&io->refcnt, fuse_io_release);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d4631a55a692..edf29406ba8b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2689,7 +2689,7 @@ static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
 	__io_req_complete(req, issue_flags, req->result, io_put_rw_kbuf(req));
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2700,7 +2700,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_req_task_work_add(req);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2913,7 +2913,7 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		kiocb->ki_complete(kiocb, ret, 0);
+		kiocb->ki_complete(kiocb, ret);
 	}
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 83ecfba53abe..811c898125a5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -125,7 +125,7 @@ static void iomap_dio_complete_work(struct work_struct *work)
 	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
 	struct kiocb *iocb = dio->iocb;
 
-	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
+	iocb->ki_complete(iocb, iomap_dio_complete(dio));
 }
 
 /*
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..7a5f287c5391 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -275,7 +275,7 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 			res = (long) dreq->count;
 			WARN_ON_ONCE(dreq->count < 0);
 		}
-		dreq->iocb->ki_complete(dreq->iocb, res, 0);
+		dreq->iocb->ki_complete(dreq->iocb, res);
 	}
 
 	complete(&dreq->completion);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c88ac571593d..ac461a499882 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -272,14 +272,14 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	kmem_cache_free(ovl_aio_request_cachep, aio_req);
 }
 
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
 {
 	struct ovl_aio_req *aio_req = container_of(iocb,
 						   struct ovl_aio_req, iocb);
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
 	ovl_aio_cleanup_handler(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res, res2);
+	orig_iocb->ki_complete(orig_iocb, res);
 }
 
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 31029a91f440..0dcb9020a7b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -330,7 +330,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;

-- 
Jens Axboe

