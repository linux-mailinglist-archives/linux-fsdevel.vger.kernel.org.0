Return-Path: <linux-fsdevel+bounces-69434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77996C7B34C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7D7E38067E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE6352FB3;
	Fri, 21 Nov 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2fIhWQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3534EF1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748127; cv=none; b=TKTFPp1fXyPJKg8/6cqhMNOr0YBMGlnRqjuwkVUpduGVXDbIGqUu7S0KpoEtbGaSO1qmUEroK0xFjT1YrrGvvy30ss1y3N9da12LVlEIZz3TZotoVsBAyK5/FN3x460nhdZvlyhX0OKDudPnQmy5e3bvR3d+8JXiTSgNqz7zCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748127; c=relaxed/simple;
	bh=TxcuNYHKuV8kDpxJFULGnftToeOdZ3Oqc68QSMVFB8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW50poC1Kf74QvQMWXrMRiA8QV/2JZ65dVoocbjHkBJ/IAsl5CZ3Fbg3u+gfl5HUHsBjhNogejBZTLlOjtxnVb+0NZZVfG5ncRTHgzmwN2zzfQPPbEx9jrLkN/0jsWI5Mrr8pIOLqmsS2qJ8BB8k4p1JDVMiyQIwlLxd8dH8SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2fIhWQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F81C116D0;
	Fri, 21 Nov 2025 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748127;
	bh=TxcuNYHKuV8kDpxJFULGnftToeOdZ3Oqc68QSMVFB8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u2fIhWQln77da0ZeFgxJy/TCe8iwRaUjH88orXQO8IXQ0tr+p0CFeLVtkNayZXklS
	 aJFd78XeCuplK+Sk6Cz3EX6I4u0355d/LdISlU2Sq9xpV0nJXqx4vOoc0hNYjmk1Jq
	 tMyax49IxIRvZMIAX4J8eMlwz8jEQ+v7k+ixJDCV8UhphYeachJLQv/Y7P7d5prw1e
	 C+F3KrsSdiC0yYpwz6FiKlZyWYZeQsqAJKg1f7U4fkq2Hb6w6OgigefXVup/UJutNL
	 M6QFnwcK32RbZ+pNfgnMs8REuIIJ4OnLBKTHfCEmar43dykhEtWfQP7i9Ffn3FRGum
	 toeaoDd2UZZUA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:15 +0100
Subject: [PATCH RFC v3 36/47] pseries: port
 papr_rtas_setup_file_interface() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-36-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TxcuNYHKuV8kDpxJFULGnftToeOdZ3Oqc68QSMVFB8Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLgYdGHHnyWThCKXravaL36Rrbhsz1XXtj37XtTvY
 4lO/fnxakcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEHP0YGRb9YCm7VWMwO36F
 qfTRA5wh55WlL9kJzL75gb3FyUR4oRvDH87P/8q1jDjnMfG+tm92utyjvCIxaxn78svSNRYcF2Q
 KeQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-rtas-common.c | 32 +++++++----------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-rtas-common.c b/arch/powerpc/platforms/pseries/papr-rtas-common.c
index 33c606e3378a..ebe628c69d46 100644
--- a/arch/powerpc/platforms/pseries/papr-rtas-common.c
+++ b/arch/powerpc/platforms/pseries/papr-rtas-common.c
@@ -205,35 +205,21 @@ long papr_rtas_setup_file_interface(struct papr_rtas_sequence *seq,
 				char *name)
 {
 	const struct papr_rtas_blob *blob;
-	struct file *file;
-	long ret;
-	int fd;
+	int ret;
 
 	blob = papr_rtas_retrieve(seq);
 	if (IS_ERR(blob))
 		return PTR_ERR(blob);
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto free_blob;
-	}
-
-	file = anon_inode_getfile_fmode(name, fops, (void *)blob,
-			O_RDONLY, FMODE_LSEEK | FMODE_PREAD);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_fd;
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile_fmode(name, fops, (void *)blob, O_RDONLY,
+					    FMODE_LSEEK | FMODE_PREAD));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret) {
+		papr_rtas_blob_free(blob);
+		return ret;
 	}
-
-	fd_install(fd, file);
-	return fd;
-
-put_fd:
-	put_unused_fd(fd);
-free_blob:
-	papr_rtas_blob_free(blob);
-	return ret;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


