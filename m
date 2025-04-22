Return-Path: <linux-fsdevel+bounces-47008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77DA97B6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4925F178EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5A21C190;
	Tue, 22 Apr 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfrRTEWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E71EDA2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366194; cv=none; b=QP75zwCjvfrXiRFw0o7n3O26Q2qZJTF3AM2gK0xzAWYItWD39Wlvr53v/fWvSlvPYZPBOroa33qjSgKV+BTgfE9K7pqFMEqx6puumOR70DAXXQYBK8FwUk2aNN/4PrFqkqjD9fHpZpaS2hE8ebSwNqGgCUOkCk7TwQq0SbE3C0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366194; c=relaxed/simple;
	bh=TQaw/mPvWTnyteFonAVWzQga87vZyFGkUkQfcvnbpHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBvQEpEMQaC7UnhXc6Tqc53UlyhL9sBJX+2dNqbIvv4hFFCO6f7XHpvFObaU65ahPckGyeWD7XZe96WnSPxPOb/IpN3ltxSgjzFXWMrqo10JwldK5cuZ1/kmvx/pePpDvgStM9F05wL4ndCc4HYVd2kvszMnr51eFZj8DjHpbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfrRTEWW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso7151439b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745366192; x=1745970992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgKXDRCQhSod4Z/K9+WU1ENRshiSLto7yyaa+YRNdV8=;
        b=IfrRTEWW7e2vCbw11D1aeuexqDQaCOmGzPt3m3u9FlWg8ZaGMMXT7fR6oiCIrSPWA1
         qSMnVmsR+fMcpKBlYK4MDThRNV3o9DUXtGhiyHMUXr6e5D//Lds1loLYAGn0x0jc8Bg8
         q8bBK+L2a7bagKhm9HQ7XQXP6HFP9b1ChuBbKcU+Fkzs3M8GFeF7xyiOPn6phSlZdMM9
         Zn3vM7cqdM6wHVooKZgGttTJlhDTJxm3YRcsHjUfg3vmLEUOuVjc7UrwdCSZcTr3uxWV
         vqZ5hLBJBkFOfcg55FbVdgsWbkCumt4AzGQpZvMGfKH2rDQE2wjrOFgpsV+FesRDR8so
         HIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745366192; x=1745970992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgKXDRCQhSod4Z/K9+WU1ENRshiSLto7yyaa+YRNdV8=;
        b=VWfHidVZVYVkD9yvqiwE2x0Fu421286Q0mJWFIB2RSX2cgkf43SgmkUM72lKoJlPGi
         0hcz6EIbrrAxCWpe9vI69URO/KuU1AN9Nqolia9Y7nSXLCmfJhf2cLb8c0D2mPTtBbkZ
         AHNH4RdSBqow3nertHA+ZVZNZkhCE/mlerpqRqNthiUDbnTBepPBxt9SA6zwsbl0BYqy
         z5x1oCk7selNYeEL9hyRHfgn0cyQF5VAey93dft1Lvi+B5zjwvDjfzX8ZXKl4Qpn0bX0
         IP9qrZgC9GYcWbGFjphAgVT7V4XdLP33GD8kqX2HNcnm+OVLguGk12Z6okbFeW/6hFb6
         D7zw==
X-Gm-Message-State: AOJu0YzPnaiDvWCVPDye92SRNzxzh/u/AQEBPfJx2CuCnSFT0tyhw4D9
	8JVYUjp7b5aHxFkVweDCZeOV0nX7bFrSBEd8GH3qRviRPgyUv4yPtwHyhw==
X-Gm-Gg: ASbGncu2WOP9me4S8lbxcdz0mY+lRhRMsyJYBpPmF8vK0AG/uvCHA2wcK/ROU0d/x3+
	x+k2JVZu0kbKKbBZ9h421aP4F4WZE90Rse/O6jLuT80fwc9I7h3LVWQdYkQQhXEIy28lKnuCBzJ
	SbjtcY++kYlavYdEWzwXZE8Oo7ajFHi7MN7g6ms6hUFyJukvOKaHQ16iRkPMfiqPPo2kHuOw6Ew
	x3R8bZEZfIjSgbF2KacOqCEkp6i2DaB/hohMY6jJOwF1uAno1Kk3dyreDusFkvL/rGCz2DpuBfA
	6sm0sugvQm7Gipmb8TpgHDDHI8ujnr4CVRA=
X-Google-Smtp-Source: AGHT+IFWncgWJ4NomGZhTJF/YhI/yxE9EaFqEsjtePF1vjMmSvLWvPZie6aDjaFwiaZd6ucnahXdjA==
X-Received: by 2002:a05:6a21:9985:b0:1f5:a98d:3d8a with SMTP id adf61e73a8af0-203cbd271cdmr30733213637.40.1745366191867;
        Tue, 22 Apr 2025 16:56:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad418sm9279040b3a.151.2025.04.22.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:56:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] fuse: use splice for reading user pages on servers that enable it
Date: Tue, 22 Apr 2025 16:56:07 -0700
Message-ID: <20250422235607.3652064-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For direct io writes, splice is disabled when forwarding pages from the
client to the server. This is because the pages in the pipe buffer are
user pages, which is controlled by the client. Thus if a server replies
to the request and then keeps accessing the pages afterwards, there is
the possibility that the client may have modified the contents of the
pages in the meantime. More context on this can be found in commit
0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").

For servers that do not need to access pages after answering the
request, splice gives a non-trivial improvement in performance.
Benchmarks show roughly a 40% speedup.

Allow servers with CAP_SYS_ADMIN privileges to enable zero-copy splice
for servicing client direct io writes. By enabling this, the server
understands that they should not continue accessing the pipe buffer
after completing the request or may face incorrect data if they do so.
Only servers with CAP_SYS_ADMIN may enable this, since having access to
the underlying user pages may allow servers to snoop or modify the
user pages after completing the request.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

---

Changes from v1 -> v2:
* Gate this behind CAP_SYS_ADMIN (Bernd)
v1: https://lore.kernel.org/linux-fsdevel/20250419000614.3795331-1-joannelkoong@gmail.com/

---
 fs/fuse/dev.c             | 18 ++++++++++--------
 fs/fuse/dev_uring.c       |  4 ++--
 fs/fuse/fuse_dev_i.h      |  5 +++--
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  5 ++++-
 include/uapi/linux/fuse.h |  9 +++++++++
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 67d07b4c778a..e4949c379eaf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *req)
 	return err;
 }
 
-void fuse_copy_init(struct fuse_copy_state *cs, bool write,
-		    struct iov_iter *iter)
+void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *fc,
+		    bool write, struct iov_iter *iter)
 {
 	memset(cs, 0, sizeof(*cs));
 	cs->write = write;
 	cs->iter = iter;
+	cs->splice_read_user_pages = fc->splice_read_user_pages;
 }
 
 /* Unmap and put previous page of userspace buffer */
@@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 		if (cs->write && cs->pipebufs && page) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
-			 * copy user pages.
+			 * copy user pages if server does not support reading
+			 * user pages through splice.
 			 */
-			if (cs->req->args->user_pages) {
+			if (cs->req->args->user_pages && !cs->splice_read_user_pages) {
 				err = fuse_copy_fill(cs);
 				if (err)
 					return err;
@@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 	if (!user_backed_iter(to))
 		return -EINVAL;
 
-	fuse_copy_init(&cs, true, to);
+	fuse_copy_init(&cs, fud->fc, true, to);
 
 	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
 }
@@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (!bufs)
 		return -ENOMEM;
 
-	fuse_copy_init(&cs, true, NULL);
+	fuse_copy_init(&cs, fud->fc, true, NULL);
 	cs.pipebufs = bufs;
 	cs.pipe = pipe;
 	ret = fuse_dev_do_read(fud, in, &cs, len);
@@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!user_backed_iter(from))
 		return -EINVAL;
 
-	fuse_copy_init(&cs, false, from);
+	fuse_copy_init(&cs, fud->fc, false, from);
 
 	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
 }
@@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	}
 	pipe_unlock(pipe);
 
-	fuse_copy_init(&cs, false, NULL);
+	fuse_copy_init(&cs, fud->fc, false, NULL);
 	cs.pipebufs = bufs;
 	cs.nr_segs = nbuf;
 	cs.pipe = pipe;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ef470c4a9261..52b883a6a79d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, false, &iter);
+	fuse_copy_init(&cs, ring->fc, false, &iter);
 	cs.is_uring = true;
 	cs.req = req;
 
@@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		return err;
 	}
 
-	fuse_copy_init(&cs, true, &iter);
+	fuse_copy_init(&cs, ring->fc, true, &iter);
 	cs.is_uring = true;
 	cs.req = req;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index db136e045925..25e593e64c67 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -32,6 +32,7 @@ struct fuse_copy_state {
 	bool write:1;
 	bool move_pages:1;
 	bool is_uring:1;
+	bool splice_read_user_pages:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
@@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
 void fuse_dev_end_requests(struct list_head *head);
 
-void fuse_copy_init(struct fuse_copy_state *cs, bool write,
-			   struct iov_iter *iter);
+void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *conn,
+		    bool write, struct iov_iter *iter);
 int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
 		   unsigned int argpages, struct fuse_arg *args,
 		   int zeroing);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3d5289cb82a5..e21875f16220 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -898,6 +898,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	bool io_uring:1;
 
+	/* Allow splice for reading user pages */
+	bool splice_read_user_pages:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 43b6643635ee..8b78dacf6c97 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if (flags & FUSE_SPLICE_READ_USER_PAGES && capable(CAP_SYS_ADMIN))
+				fc->splice_read_user_pages = true;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = true;
@@ -1489,7 +1492,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
 		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_REQUEST_TIMEOUT | FUSE_SPLICE_READ_USER_PAGES;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 122d6586e8d4..fecb06921da9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -235,6 +235,9 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.45
+ *  - add FUSE_SPLICE_READ_USER_PAGES
  */
 
 #ifndef _LINUX_FUSE_H
@@ -443,6 +446,11 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_SPLICE_READ_USER_PAGES: kernel supports splice on the device for reading
+ *				user pages. If the server enables this, then the
+ *				server should not access the pipe buffer after
+ *				completing the request. Only servers with
+ *				CAP_SYS_ADMIN privileges can enable this.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -490,6 +498,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_SPLICE_READ_USER_PAGES (1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.47.1


