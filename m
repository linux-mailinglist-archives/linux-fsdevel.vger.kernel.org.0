Return-Path: <linux-fsdevel+bounces-69545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 559DAC7E3E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C4E2349AAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2C2D94B8;
	Sun, 23 Nov 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d76M0hpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEF2D3EDF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915665; cv=none; b=BI5cbWZUHDkd3Zv5DYBc7wU7VfYo8YEo4xQDHZAwB2XdIRaSTj2vGR8Q22EevQeKoYKb9P7ydpzC3AJ+fVcAO6pqcDjHAX+Fsri6oiIq5aBg7jPOmeAI326vKFHrSnoC4wy7Iclh8ptnryOK70oEZaFkc01bgeOHfPUGoib4lO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915665; c=relaxed/simple;
	bh=3an5OR28DdzkReX/mfGU0thGl6FtUDULUrzcfYvqB80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA2ILJD692/49FHAuMo+ifpi/SKWPf6K7ll+XllTeGm4pxVHoyZ7ohM6xFqVtLsbbSdw2z9ZnTAdz/BlaSa1yvY9+V+d8fNR1crNV4/sEVvXd1dTRw1MC6iNc8Mi5Kj4r0w6rhL4NF7StgqMOyvvjURO/ZJR3Z9wPUJtIEsMc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d76M0hpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C0C16AAE;
	Sun, 23 Nov 2025 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915664;
	bh=3an5OR28DdzkReX/mfGU0thGl6FtUDULUrzcfYvqB80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d76M0hpCbluhmrqPb/Cd3cFEduXs7H053nZEotlS0lhulryRwz8r7MeU1mJSi0ohs
	 50JDUrxmfrOw6c6KGp/U97PoFvwtsgF+UIAzfSdIS4bHdYSP1nIdu26XA9K0pW2MfY
	 vu1qKx3Ha2kTICnR2fLDZ/ew1Cr5YTYngS2E+Q5EYzkrN1ZiWPEt+BWBD+hApk8xjg
	 XcPFqurWYSm1yg23SuPlL1F4/hAjzk2QMytCSJHL8jdVX0W3IGtzLqG1jJ7DUrIJJ1
	 wLxswrTX4sppI/ha+/D7jaqhvmCh6Tjrx3X/vDUhdL5JwmR8bQzamNkodquxRK9bfp
	 k1cRIfwUwwNUA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:41 +0100
Subject: [PATCH v4 23/47] bpf: convert bpf_iter_new_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-23-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3an5OR28DdzkReX/mfGU0thGl6FtUDULUrzcfYvqB80=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cFJC/KfP59vV32H9by1Qt0s83EZI5f4X/FGnIyr
 91t8fcNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNx2cHIsDnp26ynEu0/ox8s
 3vBan7+j48TFtYVmvL+XbNovnL5TeDEjw/SM3/Ob5+XvT+L/P+ea/V7n5UIh20R0D38/zpnAtu1
 /GAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/bpf_iter.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 6ac35430c573..eec60b57bd3d 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -634,37 +634,24 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link)
 int bpf_iter_new_fd(struct bpf_link *link)
 {
 	struct bpf_iter_link *iter_link;
-	struct file *file;
 	unsigned int flags;
-	int err, fd;
+	int err;
 
 	if (link->ops != &bpf_iter_link_lops)
 		return -EINVAL;
 
 	flags = O_RDONLY | O_CLOEXEC;
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto free_fd;
-	}
+
+	FD_PREPARE(fdf, flags, anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags));
+	if (fdf.err)
+		return fdf.err;
 
 	iter_link = container_of(link, struct bpf_iter_link, link);
-	err = prepare_seq_file(file, iter_link);
+	err = prepare_seq_file(fd_prepare_file(fdf), iter_link);
 	if (err)
-		goto free_file;
+		return err; /* Automatic cleanup handles fput */
 
-	fd_install(fd, file);
-	return fd;
-
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdf);
 }
 
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop)

-- 
2.47.3


