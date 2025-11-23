Return-Path: <linux-fsdevel+bounces-69540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F266C7E3CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A8D4E37BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF54423184F;
	Sun, 23 Nov 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV3uzAHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E172D879A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915654; cv=none; b=Op5rslB+QjFm9pqZe+0q4++nkOnlR1/bKr1Sje+CZONfJRMXRjPQ4pbhKX1LDS5FRPk6GAT8TsGAFRcFnxIoV+uN4IJzhaDEVMD4imuoMETyzBbK2kgqJZsZzuwzl9YNA0KKLQZa8iLtIqTeSQgHP7Wvc2pI/jm5OlwuNb8llco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915654; c=relaxed/simple;
	bh=WiVwY9zHHtohEhlA4d7MKwn6Mzt1gywM3ur52wR5s1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnkgCBu4nX5HlVODmrVN/hOaUI9QzVYRVoT3oYodqFyxPnHca4spjVTYhsT0mwUQZnBsbEc6naYrTEzbLCK2YTbGkloNwP5s1vKOUNnhKi7JqtbEWucAPrbe/ysZgtilvOxO5UQGuC9FYdAw+142TwKoMM5vETHo2t0diBOH4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV3uzAHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D18C113D0;
	Sun, 23 Nov 2025 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915653;
	bh=WiVwY9zHHtohEhlA4d7MKwn6Mzt1gywM3ur52wR5s1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hV3uzAHPyl7Y9IsDIKMK7+JhCWClviCnAiuZrQwq0Jl1zrS3eMMllh4vPAg72+rQd
	 a8Vee3FPLH2B8sFpmfPSWvpKuoohQ16Ny5OBhXPyoUJpPh2JD4CJtcZ7Je5jiMObxT
	 jmJMKhUF2pzizW2VAOt7byhH8kirb2TWbC3k4pEIlOS96cWgmkhqNK9UZu83JxrL12
	 MqtKmzvWI801zgPZb6gJCY7nYI5BHDiBG6soTNTtZVP9kqUFQlNRtQOHYfmmbV4Foi
	 ylwQHYUHF/knpNnff2r/KXnxtDPZy4F8G6lBjao6L5u9mzXYfek7affcPiPU0KgekE
	 xbdPpBKF2bLSA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:36 +0100
Subject: [PATCH v4 18/47] dma: convert dma_buf_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-18-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WiVwY9zHHtohEhlA4d7MKwn6Mzt1gywM3ur52wR5s1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0emr37w8+qFUM456R9urZl4wv3tqzK/Twmrdhfx+
 ypYdejzd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykWZThf8FllbkyJc2XD7zm
 WpbNvpiLnfUly7zpakI8EYHJJwqjzzEyPIkV+ZIlrvvc8Z/tqtpWL4vm5pmbtn4LLmspjnx0440
 5LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/dma-buf.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..edaa9e4ee4ae 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -768,18 +768,10 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_export, "DMA_BUF");
  */
 int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 {
-	int fd;
-
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, dmabuf->file);
-
-	return fd;
+	return FD_ADD(flags, dmabuf->file);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 

-- 
2.47.3


