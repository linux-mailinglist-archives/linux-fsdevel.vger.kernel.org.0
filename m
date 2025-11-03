Return-Path: <linux-fsdevel+bounces-66737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C77C2B5E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002341896AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044AB3064B9;
	Mon,  3 Nov 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2H84mnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F52302752;
	Mon,  3 Nov 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169239; cv=none; b=eCr8EAUzQoAXm2g8Sfu0/O3G8FPkFhQ/z/u6DqlCylIa4GeFXs9Fi0mOMRjXhbFG9b4K0QeVQTZwZSTLKlwuWFvo5DxzaqRHy5p6n6vCeze+pzSIRfH8xoot0QhdHpoe9fh3rEZUD5hJutuunohDYPncjAiBd0aeWDGKdqaIeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169239; c=relaxed/simple;
	bh=nM6vUvQd4AMD+xtcLBWx9Qk09b196BZxjzjS13mYIcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxuszvqR1lrKFnRBIv6+3D/pKD1Rz+OEmKI5oeMIWTrtVWTTHo5pEZ5esUqJT720AeepBMw772xU5i8+xnhSX01mg+DHXh7k+S095D+skTT5rkk96l7aJ8LWD0RU1ovwexfIuyZHXIien6rrZeOy1MhnO67Txv2ZUBgizahrl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2H84mnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D419C4CEFD;
	Mon,  3 Nov 2025 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169238;
	bh=nM6vUvQd4AMD+xtcLBWx9Qk09b196BZxjzjS13mYIcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2H84mnVSjhuIGEO5aLRQorevyb8zjgiiHeJZlPPmhXri/0/4PMO+OYDGVDt50NKB
	 t0kn67GHFwA3X/jWuiYZuKDHgD+g1gfQrcbGiNZwci38VGJ07IFFvQozVUJs/dGnV7
	 nJHrrn/pV9R7ErJ65CuBBGwYTj7bJhGRaUo4JKPKQLV43ib/wO415hgFNLv/frAmAs
	 hfp+Ykng5R99V6EcXlMks/+KbMSfMZHWO27TPXbywi+fYqp/PsHhqqHGmjW4AHNNkt
	 SLDK+VhWs+5h/66bqjmnvlcuVtCVf1CXZfdTPwJZG8V4GX4N4ddhJ5/LMW6Jutesb7
	 2Mmj5DXtPgLVw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:52 +0100
Subject: [PATCH 04/16] backing-file: use credential guards for writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nM6vUvQd4AMD+xtcLBWx9Qk09b196BZxjzjS13mYIcc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGzfO2uy4qzbchqXxHO5jrbyGT776n08N2zn67qjv
 IH3X6d87ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIeDXD/3DflS25m8pkl4uc
 /rlhwwKZR8KTu1oVjt2fl6HIqaf5Zx7D/9TpR5O508w/XTv+5owO47I/vx/cZDwjZ374u2TULvF
 ni5kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 74 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 4cb7276e7ead..9bea737d5bef 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -210,11 +210,47 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(backing_file_read_iter);
 
+static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				      struct kiocb *iocb, int flags,
+				      void (*end_write)(struct kiocb *, ssize_t))
+{
+	struct backing_aio *aio;
+	int ret;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+		if (end_write)
+			end_write(iocb, ret);
+		return ret;
+	}
+
+	ret = backing_aio_init_wq(iocb);
+	if (ret)
+		return ret;
+
+	aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+	if (!aio)
+		return -ENOMEM;
+
+	aio->orig_iocb = iocb;
+	aio->end_write = end_write;
+	kiocb_clone(&aio->iocb, iocb, get_file(file));
+	aio->iocb.ki_flags = flags;
+	aio->iocb.ki_complete = backing_aio_queue_completion;
+	refcount_set(&aio->ref, 2);
+	ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
+	backing_aio_put(aio);
+	if (ret != -EIOCBQUEUED)
+		backing_aio_cleanup(aio, ret);
+	return ret;
+}
+
 ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -237,40 +273,8 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
-
-		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
-		if (ctx->end_write)
-			ctx->end_write(iocb, ret);
-	} else {
-		struct backing_aio *aio;
-
-		ret = backing_aio_init_wq(iocb);
-		if (ret)
-			goto out;
-
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
-
-		aio->orig_iocb = iocb;
-		aio->end_write = ctx->end_write;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_flags = flags;
-		aio->iocb.ki_complete = backing_aio_queue_completion;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
-	}
-out:
-	revert_creds(old_cred);
-
-	return ret;
+	with_creds(ctx->cred);
+	return do_backing_file_write_iter(file, iter, iocb, flags, ctx->end_write);
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
 

-- 
2.47.3


