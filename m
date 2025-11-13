Return-Path: <linux-fsdevel+bounces-68302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8921CC5922A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0AAB505556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE4361DCA;
	Thu, 13 Nov 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXmQojxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1E35BDAE;
	Thu, 13 Nov 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051866; cv=none; b=qq4mfliwVJ5DyXaQ20I1F5M38Me7U/1yVb6Xw6cZRuYaoz5R/VkVnDEopNkcK3Hs6SBznNjqzBmpgPoWWuBwAWt0Ee83U23xDi9tHfnEkGTVbDZBjtfmu8uvleS3/vLOnvZdS0xlgML/gL6Nsd9h0i1svV/n1kp1RIlucgAknU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051866; c=relaxed/simple;
	bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dh51NQ8gKeMzAT0Xo/uaG0i/N4C966ekN4tSEbTAl+vRe8J2/texkcKNgn9XN5CS8RwyxqpQ44FE0q5+nLJUPkvKH1FUsoHn0nftgKxLj3s5oEijAOX+5u8u74jHK4m6ry0EOg9ixJwqXuy7KVq7ead8BGGOifW+LnU9qMwq2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXmQojxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B8CC4CEF5;
	Thu, 13 Nov 2025 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051866;
	bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XXmQojxF7ypd8K/y+qU/UZXkCiqiADk1OMus8STuyLT/4oNoL5RREkFlVGTfQqIbf
	 UbZgk0r6XqulN2SRKmSbnwBm/q8lH8t/CBQeACQM+oxJ1fh/hB49zNvwZx9bXtTJ9l
	 uni3fQHMg1eARjzr98P2oPmQMdHeRSJnTATuahD9S6GuL4fJU80aPXjF0YzI+iaDhu
	 zLPti59V/e9UiWhgjtMF1XxAlGOF6QKDDvzaRWZNnfnw3f9S0o1zc4205xOlkMBRd3
	 D12gmgPLW4La+DRd96lXqcLsGj9loBoxzaz19yPBsOM3ofAwQEps90rlkqR46LVLpm
	 FxDJQUnY8EtuA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:14 +0100
Subject: [PATCH v2 09/42] ovl: port ovl_fsync() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-9-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpO26h350HbpCV7j/SVT5NgiHoVteTO4vsTVFRv8
 n0/7LHlfUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE1rxk+MNtKPbdsZGJPbXY
 82pxQe7XdcoKEzXkUic/WtcnWnpS6wwjQ8uavo0K/7+E5r9fylw8N1rWvfTtgi8Gh/Rzm3m/nnq
 cyAgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e713f27d70aa..6c5aa74f63ec 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -446,7 +446,6 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	enum ovl_path_type type;
 	struct path upperpath;
 	struct file *upperfile;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -463,11 +462,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (IS_ERR(upperfile))
 		return PTR_ERR(upperfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fsync_range(upperfile, start, end, datasync);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fsync_range(upperfile, start, end, datasync);
 }
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)

-- 
2.47.3


