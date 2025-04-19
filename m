Return-Path: <linux-fsdevel+bounces-46706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704DA94088
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 02:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AAE7AFE2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 00:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B418136E;
	Sat, 19 Apr 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPWMVV6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56617E
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745021194; cv=none; b=sA9Pa+TV4/VufK8yUEGb0oKvEVdOaLy15+wdcfoR2tN6R/k24T03l18VJ4wxi2c6EsbNhFqVc7WVrrZxJsG11Zfj+x7F6ZT0XJdi9S7DNNk1mlZ3Mp9fRj9InvbFd1LNXPA9MqAyZw0fLXa/C3OPpc3Xsr+xQ1aApFQjpm2c2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745021194; c=relaxed/simple;
	bh=hyglXFKupUWquDaSxzSi96uIAaf1HOnAHX9kzLVhQBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dV+UkP5TVEHO0ILoGZzi1l/BIkt6B2f5euCgNN97FAqk59sC791qPnvO0HE5YCfkv100Ct1phmvsk5ll6cM8wmKbCRF6Jfo6cQpQrgSEQQ8KD8RPKFF0MsxqbrP/TbvvBRB+4YZbRURuBdfIKI6ZsK5VBDkEH+GKY0RjlLMkji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPWMVV6J; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736b98acaadso2280095b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745021192; x=1745625992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCexlhTtbRqDf6b/DaU8rIKPtYtg6/LrUxkKlaRoPtY=;
        b=SPWMVV6JtuUUa+jr7byvovmelbvYrvd+Vkn4q2e6g2j54FEhWkr6Yhk2cqvfciNwxu
         hF81dH5k8WqToFfDMtPi4O9P9U30CsAibWNAQSPLymY0aZTof/KjCv0YYkhDz9YzbuA/
         GqtIO9g8nwfpIi3uyK10y95xsecNrNVWohVmK/QjgKy7Sv3k5TEBLDXgevOMnk6n20DZ
         Nq01ZJWCmum30mq9jrSG+2J6mI9XVCpp/z2t5usBJ4hmqK6T23y++16P1i5HR0szRxH1
         l2JG2t26/C8XSMmUSxur+/adYGWLcOkn5OJlZX6RAxr1C0D6qnuS1G5aPD43kKtVCXfa
         WRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745021192; x=1745625992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCexlhTtbRqDf6b/DaU8rIKPtYtg6/LrUxkKlaRoPtY=;
        b=pygdyENObi8ZfZOkW3ErU0nMDhIJfzDzv2r35nRNtGHej8HKBGUmDd785EJG4zUNP6
         hLoWhDwBG7iQDCv483qfclsqzykTu7V1auRZbtYl0gGnZv4MuCRcF4K/UYplueR8e5iU
         JBb0TELJf0UKOljZNYj8Zn+ND3Jwn7D8z8xVW/nppIONT9FGYZDUc+Pg5JwS4TAdhGq6
         F4BKMuNKnm2J1osiggc/Bt6ksA0cW12cLfdeff9EMp+AJODpCMANs7rV6PdSo27NNeBV
         ljTbCFPOsQ0vblXeGAzjv0ZAQOxs/2CVKcC8umYr0t57wSMTKiUoKOuAHYEr2OcmnEgy
         t+UA==
X-Gm-Message-State: AOJu0YyuNqZmKQwAO0TZ3I0Tm8tIjPH15nJIn+lHHqGv3EN3VgEGTPUZ
	nHzXnvyVFF9QMcAvmF4B4zdiB56pD1lxm2kbmetHfwqlaLYdZdsX
X-Gm-Gg: ASbGncs+qkDbE3ou9KuQ5hdF56fL+cQIpXjddKGdsPkR+etLxHnUOoWtLZxdE5ow6yu
	OpktbQdRs2i7IoKb0j941uiQF+DL60fasaFTZgCMyIXVkl+Hzhan5ilLDrwFxOLG68gks+lXtqf
	wvjBrJbBQe+ZBuSzdYqw5Qldqz0OvWqP52bc7cAt/334b75ieT1BTZWviyrQUSK83Y3vpwTAW9t
	eo7Z/tqMTWYHQE6n6WofSk3F4QrOWQsSZo92p/+qQ79jdPLzvcfGVGxtcw1f1y0vvMiq/8jwg/L
	db0UPEhtte8zZ51t5pcj2jc7pXSuuJeK9XU=
X-Google-Smtp-Source: AGHT+IE9bI3NJgGv+yY9pQWAtiHOjrXeRcy3mEKNfL3EEQetMjbLGYHPGLrKmWsDSjH1A/nP3zliDA==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:86f2:a674 with SMTP id adf61e73a8af0-203cbc5045emr6738899637.12.1745021192031;
        Fri, 18 Apr 2025 17:06:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfae9a4csm2182443b3a.161.2025.04.18.17.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 17:06:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1] fuse: use splice for reading user pages on servers that enable it
Date: Fri, 18 Apr 2025 17:06:14 -0700
Message-ID: <20250419000614.3795331-1-joannelkoong@gmail.com>
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

Allow servers to enable zero-copy splice for servicing client direct io
writes. By enabling this, the server understands that they should not
continue accessing the pipe buffer after completing the request or may
face incorrect data if they do so.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c             | 18 ++++++++++--------
 fs/fuse/dev_uring.c       |  4 ++--
 fs/fuse/fuse_dev_i.h      |  5 +++--
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  5 ++++-
 include/uapi/linux/fuse.h |  8 ++++++++
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 67d07b4c778a..1b0ea8593f74 100644
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
+			 * copy user pages if server does not support splice
+			 * for reading user pages.
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
index 43b6643635ee..e82e96800fde 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if (flags & FUSE_SPLICE_READ_USER_PAGES)
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
index 122d6586e8d4..b35f6bbcb322 100644
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
@@ -443,6 +446,10 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_SPLICE_READ_USER_PAGES: kernel supports splice on the device for reading
+ *				user pages. If the server enables this, then the
+ *				server should not access the pipe buffer after
+ *				completing the request.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -490,6 +497,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_SPLICE_READ_USER_PAGES (1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.47.1


