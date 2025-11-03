Return-Path: <linux-fsdevel+bounces-66740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A512C2B611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F49B1892A48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C03090C2;
	Mon,  3 Nov 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/7pepPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC9308F00;
	Mon,  3 Nov 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169247; cv=none; b=aM80Oj38KT1xe61dHYav1xs4MKrJ95XlFjwJ68Gu328J+wbDF9T7fw5MkO4HejkzqZC6qdZTAjO5uc/hSvWZnwX16VUf6BN5jknd+WXPRucGbZ4Uo9Ckhm3+YOa9P5sqbhAZFa4SjUJRuMyfhmwpN36GrM+jpJgRDfcfxcEQXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169247; c=relaxed/simple;
	bh=xUgfCnEjAJd8zsIOSMA0urqHXlAuN0jLc7ICsbqbewI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XiF8df5ilFM8sOYKFNeGQnknhbBga6Hq8zbNzol8oKIaD3uGk7Ypsn3AGiy1T8r4MmmTarPOjhOhpHAk/cH3WJRZQim9qPmbtr1hCX4uc891xjm51UEEtsJzJb5isMtjy6Sryu768PuEQMzz1m2t6h2APDELlvMkHlZ23x0LdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/7pepPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F83C4CEF8;
	Mon,  3 Nov 2025 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169247;
	bh=xUgfCnEjAJd8zsIOSMA0urqHXlAuN0jLc7ICsbqbewI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t/7pepPe+E2EpzUMqDzgHBspZi4YmYJq/8kyKPd8F4ea0WwzTWUKxbhr9BQn21g5p
	 4vUpHCHemXB6WCn+RWve8MTpNaOMgVq+V0G5Yt9dQGt0TYSSpSuF+1vBLHm6cV79V4
	 /Ef3Br+/I9RsZpUSXomjNPfGTamKACdaOSk0aWyoYYbif609YCwiJSx2Jh98aQ0Ofq
	 CUodanmAKxk14DxR2ZdZsqfrSW1kzhfNI30558rjyOaZaOOTPVDEixp7GSLHnmdi6W
	 X5H+Gu6tSKRCbmMwJz3DH/sLJXc1koIR94pNFloTG1GIny0GDGT2y0+626ZCaEyXMX
	 Gic7qzrFm9jUA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:55 +0100
Subject: [PATCH 07/16] backing-file: use credential guards for mmap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-7-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xUgfCnEjAJd8zsIOSMA0urqHXlAuN0jLc7ICsbqbewI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGx/tYdp5/3NnxKWxT267pvpVHLYZbnKu5ednnuOs
 ptrr97xpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiB3oYGf7bPVoYHBDtkvTm
 j0NBZrlhXOds+5m3OFIvVuu+nu7zMJ6RYXlZ6M8HAc6f/y7vskkP+syb1GXX780bzNOpyb/ifMp
 edgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 9c63a3368b66..5cc4b59aa460 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -331,7 +331,6 @@ EXPORT_SYMBOL_GPL(backing_file_splice_write);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	struct file *user_file = vma->vm_file;
 	int ret;
 
@@ -343,9 +342,8 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
-	ret = vfs_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		ret = vfs_mmap(vma->vm_file, vma);
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);

-- 
2.47.3


