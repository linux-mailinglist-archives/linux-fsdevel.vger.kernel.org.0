Return-Path: <linux-fsdevel+bounces-69558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB8C7E414
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A41A0343330
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E432D6E61;
	Sun, 23 Nov 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+yT6mTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22202DA762
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915693; cv=none; b=Ew5bIBmoLpA4G95TTsvrNEV/UflrvsOyAqcG3WzLITAKbBQHfi17EB2LNb5XPtVE2eGw4Cdsz/VqjnVkPfQbzGpGItqjBUyeR9DpXAFJ36ZDrq1jw21HRYB7E40apG0RZDOn8K7dqm0p7iyBLaSkROYy+ONMErHdeiAqh+xgF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915693; c=relaxed/simple;
	bh=Lm0/VoqhpKg5P99CK3QrnIqXk0iTyM4nIVBO351dSuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9rpjQdPY7OOWZvnEtYgv+6PPfMEcq2OZS1TUYVTQWhkinygJ1a0vtaTRWnAyUmjRk4cYFsRGkLAQMOxNzKSN+YxYMdyOoDbaIzMo3GONqFOMlnhCD3SgIAcdtKNE2Nk2A0JItub/9fP4Sq2QEh2w9ZAPIZfgojmK8JZBfW+lnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+yT6mTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CB8C19421;
	Sun, 23 Nov 2025 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915693;
	bh=Lm0/VoqhpKg5P99CK3QrnIqXk0iTyM4nIVBO351dSuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+yT6mTLgoWxBr8GKBgBxay7y9AzObFT0CsEzTe6xmJP4mKTrBBiHNnym3mtM3QK7
	 0LUXGmLN4kUC8oHeEqElZIhEXPJ/a659blgc6rpRwdXDpZpz2PHkhrXip4ug0JsQqz
	 FMI+0fYk9FiXrz0+Joc6by7aGDp1KCaSK809fHO5LqYh9yh5iTa2ux0zk8acrf1Vl4
	 4mDFnOq43rKJ0fK4o7Izzolz0eXGasJDWxaIVWL6N1qcwKkCRZ/g9+cvI0TD304uHv
	 YNeP5gle7EkH51rBmG1bbQz1g4PAExPy3STpRIaD1CoK7Dizs/f4YqxL+cmsSzJ3KG
	 6ojuAzHc2omng==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:54 +0100
Subject: [PATCH v4 36/47] pseries: port papr_rtas_setup_file_interface() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-36-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lm0/VoqhpKg5P99CK3QrnIqXk0iTyM4nIVBO351dSuE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0e93uj/zyX/gJbp+rAZ5+Xat2S5Poj+KLs8K+MqN
 4/LmRWrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyL5rhr0TlEQPhuoUT1+XH
 esWr3o4S9StmuibxbsGtcLa0d1NDCxj+ewp2Xvvyw+lfQ41v+1W+P9rL0sPitftvi5Qr35JR27O
 DHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-rtas-common.c | 27 +++++------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-rtas-common.c b/arch/powerpc/platforms/pseries/papr-rtas-common.c
index 33c606e3378a..1630e0cd210c 100644
--- a/arch/powerpc/platforms/pseries/papr-rtas-common.c
+++ b/arch/powerpc/platforms/pseries/papr-rtas-common.c
@@ -205,35 +205,18 @@ long papr_rtas_setup_file_interface(struct papr_rtas_sequence *seq,
 				char *name)
 {
 	const struct papr_rtas_blob *blob;
-	struct file *file;
-	long ret;
 	int fd;
 
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
-	}
-
-	fd_install(fd, file);
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile_fmode(name, fops, (void *)blob, O_RDONLY,
+					    FMODE_LSEEK | FMODE_PREAD));
+	if (fd < 0)
+		papr_rtas_blob_free(blob);
 	return fd;
-
-put_fd:
-	put_unused_fd(fd);
-free_blob:
-	papr_rtas_blob_free(blob);
-	return ret;
 }
 
 /*

-- 
2.47.3


