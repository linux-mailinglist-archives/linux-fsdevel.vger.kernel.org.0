Return-Path: <linux-fsdevel+bounces-69299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41482C76849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5121D29E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FD361DB4;
	Thu, 20 Nov 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU8YI8mt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15430E83F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677976; cv=none; b=FRTCyaKf1Ck6KrPG3dbtFncxD3nd43qJwVH5qw8DjcmaMJ9vd3k0k/v0Ep7FFtZ2GlWPcr9HGm6xCXJ4nyIwnFWWjaz1YJ53yrZixifymfc3SttTKYNnDmlHXztNGn6KxSeJNtCgnzjDqKLkeGDpwaqNf0NX4OOqaCeInesydSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677976; c=relaxed/simple;
	bh=uPUqCOgvo9AumJa47j5H7S8FIkq+Au8OABZVQ3wuuoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShAJ26ViwRgm7U1OzBH5IMIPhzigMsEjXBSjHo67XwrVc/f4yN7aLtcHi9kJvdrlck0pyddLCFi3VuDq1/eLQvEsIU8reyHEoaShebRhrAfX59Apw6gwR8q7COnbhCSJlK2LU/CXUy84Ch1QEDrcAyEzesz367mgaeWx5d02H28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU8YI8mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E7C113D0;
	Thu, 20 Nov 2025 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677976;
	bh=uPUqCOgvo9AumJa47j5H7S8FIkq+Au8OABZVQ3wuuoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kU8YI8mtw5F6y/iqadRkVpDzlShHl0PVE0ZFBiBchBAr4HdDlIzZm2mPBHVErIb8z
	 p+id3ojotaSyQMr4kmI4WTxaGeJm/zZUZ5151yHfpOx6VgZa0OtCXwC9w06BcmBtfz
	 J0/6Gx2A8KB3zpF64Z/Ox8I4NUADH6WhX55fKY182WAfDX0l9i1/QaDZN1JGXcypeo
	 n2kOgDIknAkGDJMsgSo5bsYh/i2MJcfbEEMgit0v63G2sU3DequekxJdt8EYZFAJwc
	 ioxhXl6Dmjv0LahvlQrYLi3YRv9z/sMwuPEu+Amcx4dIOghg0hvzVCzBQlFLf0HxP5
	 g9bBCNfpaOPRA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:16 +0100
Subject: [PATCH RFC v2 19/48] dma: convert dma_buf_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-19-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uPUqCOgvo9AumJa47j5H7S8FIkq+Au8OABZVQ3wuuoQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3sr9+3nmS+Ld/HlNJ+bf1o+T8T40LGjvZe9lyvnL
 JG+8Su6taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiSj8Z/mkqvD9/M3j9l6Vs
 rBvfmv2JL+1/zNJQunKisO+qLTuaYlwY/oek33/MeT7v3J0UxuJi8egbeR5BrMEyda4Fm+QCza2
 vsAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/dma-buf/dma-buf.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..800c2255df06 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -768,18 +768,15 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_export, "DMA_BUF");
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
+	FD_PREPARE(fdf, flags, dmabuf->file) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd_install(fd, dmabuf->file);
-
-	return fd;
+		return fd_publish(fdf);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 

-- 
2.47.3


