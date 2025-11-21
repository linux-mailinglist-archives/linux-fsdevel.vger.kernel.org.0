Return-Path: <linux-fsdevel+bounces-69416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC53C7B334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AA7D3441B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE355351FDB;
	Fri, 21 Nov 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+s8of9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA1238159
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748090; cv=none; b=qy+FLKNuvkox4Bkg3iBfLSYnnyarYkH6v+vkw40B/crbU08mRBDpkJjdZxkCHmH2i9fuu0T7iuqYy/VjPw2IHpDOHJYGYx7YF6ttXW0i4J+x9GXiDwdztZ8My5k8ZXZNz4pMTh3h5nq0B6Pf3mObZQhso86zod4lK6xNq08rZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748090; c=relaxed/simple;
	bh=RYqxwxufxnpL/5YMjuhGn21FAcsUpnSepu8Pr9+QNIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNQjC1w3Cnz20hKEbGnUlYj8dPBs++gRln9QRVjD9Z0yhGyCu1RcsMXNWo4dP+oeBZvoN/VbyCBgJ0FI3hh9nk/r+A5lhUm6Htax7HOKxLSTOZcvFlCkGUVpkVQO4t1M5A9ogic/NPxZGu7IMw81m0HgvNExkNyQhUyHCEPHumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+s8of9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4FC4CEF1;
	Fri, 21 Nov 2025 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748089;
	bh=RYqxwxufxnpL/5YMjuhGn21FAcsUpnSepu8Pr9+QNIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d+s8of9mGE348cpaEJMyg4fCsB13dp8l535m+p+NlqaN7GaOrY1rfptSBZeuPvM9q
	 M7HcEQ9oj4JxbxIGiWYNTbeTJ+YRmwaB2uQT1vXjyRuY5317lD/YjJJMh0bWokaI4b
	 xfKkREa8b7N6/gVD1oWm3U9IpEqLBQ1g+5nn4+YzIxSlSdlN5Q+zz4bD4946PVyiWC
	 6th1A/4y3/GqujpSLA0JwHYWHdklPEOmIoN+2Rx2WjZATi8Vp9HacD9/uRXoqrgwhp
	 6IeirwmoZrmXnipQuWTiTXD535bJXjav5Nxd+XDrRxkx6nTA+GYs/QhK9n6v+e+EVS
	 8y1t1Os7uE5Lw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:57 +0100
Subject: [PATCH RFC v3 18/47] dma: convert dma_buf_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-18-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RYqxwxufxnpL/5YMjuhGn21FAcsUpnSepu8Pr9+QNIo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLgQtkPv8LcI9z6tLb6bZVzNDBfVdR9PfjxVjKHSw
 Fd1xYR1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZJMTI8Ir3NU/b99eFFi9W
 /eBoYjklrNU9PyvST/Ko43Ub6eubZzMy/PdcpGt568S3gjPpKl+jlHYaVVdmxLiwLt8159bB2H/
 XeQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/dma-buf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..e46d8719d61b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -768,18 +768,16 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_export, "DMA_BUF");
  */
 int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 {
-	int fd;
+	int ret;
 
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, dmabuf->file);
-
-	return fd;
+	FD_PREPARE(fdf, flags, dmabuf->file);
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
+	return fd_publish(fdf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 

-- 
2.47.3


