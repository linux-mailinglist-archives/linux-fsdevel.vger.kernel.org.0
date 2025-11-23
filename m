Return-Path: <linux-fsdevel+bounces-69554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F50C7E3ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EF53A57EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7812DA749;
	Sun, 23 Nov 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKJT3PS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99792D8774
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915684; cv=none; b=Y8ZheC1c4xvf+0Zk0bsJ0HawLMwZGSiHyZ//CWIUk0+vIGAK5vqumYuIVxTJY8N4DaIT58BkkZ4Aq6/E4d+vdx8MNeHUtrTo1NkqcX5acUII11ddef/M47PB4RTUykJAEPdH2BBo6/Fuy3117ArzjvhrcEnLcizD8Aw9qdJyTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915684; c=relaxed/simple;
	bh=uzZkktkhzfu1/aw8G4NT6xhoV1UNX+ZHhulG8Pj3/r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS27tINJnjBow2En8DLZNdXR2zJuzb/nTRErqnXli3+3ekfGRdSfC7ceF9KIWD7u6qWQOXNv9bfX36PXX/b/reOQF/6HMZRa/dsZbvBZqmf1zxIB4v6uCuSalHZ0M8wrDMKPFBT40moFHeSUUF9H04HTebAigo9aT87Wq44rMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKJT3PS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7658C16AAE;
	Sun, 23 Nov 2025 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915684;
	bh=uzZkktkhzfu1/aw8G4NT6xhoV1UNX+ZHhulG8Pj3/r4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gKJT3PS6B/5GcdFxzCsTH6rfZrC7iCI7o0jVDsetIoZOLcgVBOdPFAVFX8xF6RYbR
	 bDM7XMyIQzbiR9cqHw/DR7i4uvZGiM5MbNyEva2rPc78FQR/lERjqX3VTjLXxRYWPJ
	 1m1mw3wkizkE5/tBw3cjoCCTFdmTPROWT97TrfL1AUpq+kK0bXgzWgt3qThemQTMLg
	 D2nzIqvFUaw02dSDurMWzdhF5KtZodjY9b0zhzWkklBMC6yF6zpiuq9ikdiFNJe2xn
	 VMmOWJLODdl+mLoXJSMPpHsnaJAQXTsXQuZRWlSkDeykeLMD2F5cwAMrPB04UcTDxg
	 3aRVbfYazZXMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:50 +0100
Subject: [PATCH v4 32/47] spufs: convert spufs_context_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-32-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uzZkktkhzfu1/aw8G4NT6xhoV1UNX+ZHhulG8Pj3/r4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0eteXmqNcp85+1bkRufng9asOLoIseT/CIzN5+Tf
 q49y6hGvKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/+YzMvzz2qWVZBsR33r8
 pdka9dDY2fZrvBaZPbmQ9e9nw3qPfHFGhl3bLyy7svToSxfDylmGVoLKytdUd0l7GMgqn+leqd5
 qyAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 7ec60290abe6..195322393709 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -267,22 +267,11 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 
 static int spufs_context_open(const struct path *path)
 {
-	int ret;
-	struct file *filp;
-
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
-		return ret;
-
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
-	}
-
-	filp->f_op = &spufs_context_fops;
-	fd_install(ret, filp);
-	return ret;
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
+	if (fdf.err)
+		return fdf.err;
+	fd_prepare_file(fdf)->f_op = &spufs_context_fops;
+	return fd_publish(fdf);
 }
 
 static struct spu_context *

-- 
2.47.3


