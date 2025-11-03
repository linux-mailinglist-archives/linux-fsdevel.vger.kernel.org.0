Return-Path: <linux-fsdevel+bounces-66736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72021C2B5C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531593AFE0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197C305062;
	Mon,  3 Nov 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGzomzn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B53054DB;
	Mon,  3 Nov 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169236; cv=none; b=dwS7E1NIpD8FQwmoIRjU23z12LVEDxx5yQXl67Z4lCRymRhA09AH0k6KWrR5easbwIAMDVYrjea/C3ZoCWaGwH7iNiC/9ioYNNFg7puV2ewTtiImXMD9PTFDtzYwkxoSPy3FjGFEhF9g7jGvhYtAohmxsh5mUS+hEf1fuMIUrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169236; c=relaxed/simple;
	bh=Te6t6WBv6LcIE3Mz3jIDSKVou5veHZxj8ddg+uVgoIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovZKQQ2kCXvnk69xPwjn5oZpfmRaEKbYkSzmCIavlo9YWY59FnNQkgWqzIrbsOFRlhHBeFzFcV2vbYT0YDNGiQyt8I1a0rpOce4urOq0CLSm8bHIAb5S3YHkk/7wtuHa7t7flAVwquDGR9mI7BaxRm+ujLh/fCgXQvEKclAyEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGzomzn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED62C116B1;
	Mon,  3 Nov 2025 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169236;
	bh=Te6t6WBv6LcIE3Mz3jIDSKVou5veHZxj8ddg+uVgoIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sGzomzn+PGDjvCwVJp7q7eb+dM1qxws72K6VH6xrXYmiGMTqrkYKH5g+ub4EUHZjN
	 jAnATZTZMkKxvekdh/YRrdgGycnz6CGT3CDuRJR2YY0e1Zr4UyVqpldjAjR+bNT1u7
	 iiMA1FmOiSALrUAa+gellLW9ZhHuuud6bFbDlSAT77tgEqHbbjHusLuF2KHjkqvsvX
	 VOetbNFCU0wnAJPhI53xqUam9lcXUp1hwNSpnKscop8OqOs6+t0/RoZDPoC30RwPkB
	 OFF9MtFrUp0bTHvXUuLg9O5p9VvocMC31CLCjvY2a7BtHOKWiZL8k6PtoNchqYTvOd
	 S3jdiMZckWqtw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:51 +0100
Subject: [PATCH 03/16] backing-file: use credential guards for reads
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-3-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Te6t6WBv6LcIE3Mz3jIDSKVou5veHZxj8ddg+uVgoIk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz38X4ce1HzVa/FXFUmtYYbMyeKTlf3c6gz+HNeT
 UZ2t6dqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETmNzIyrAgrqVBzevihy0q+
 cEaCUKh4gH265rKLiUmZ3/MdWiJFGX4xPcraW37lS0tS87Zpued+eQrIv7x3fl4Qi0yXyfXruRy
 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 15a7f8031084..4cb7276e7ead 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -157,13 +157,37 @@ static int backing_aio_init_wq(struct kiocb *iocb)
 	return sb_init_dio_done_wq(sb);
 }
 
+static int do_backing_file_read_iter(struct file *file, struct iov_iter *iter,
+				     struct kiocb *iocb, int flags)
+{
+	struct backing_aio *aio = NULL;
+	int ret;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		return vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+	}
+
+	aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+	if (!aio)
+		return -ENOMEM;
+
+	aio->orig_iocb = iocb;
+	kiocb_clone(&aio->iocb, iocb, get_file(file));
+	aio->iocb.ki_complete = backing_aio_rw_complete;
+	refcount_set(&aio->ref, 2);
+	ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
+	backing_aio_put(aio);
+	if (ret != -EIOCBQUEUED)
+		backing_aio_cleanup(aio, ret);
+	return ret;
+}
 
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx)
 {
-	struct backing_aio *aio = NULL;
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -176,28 +200,8 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
-
-		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
-	} else {
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
-
-		aio->orig_iocb = iocb;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_complete = backing_aio_rw_complete;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
-	}
-out:
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		do_backing_file_read_iter(file, iter, iocb, flags);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);

-- 
2.47.3


