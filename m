Return-Path: <linux-fsdevel+bounces-68304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9554BC58F59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824BB426929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07906361DDD;
	Thu, 13 Nov 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohwSYJJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD9361DCD;
	Thu, 13 Nov 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051870; cv=none; b=OMF2iCQpAr4zEmS1c9WpmvHgqvgwNg+9aByb1aVYWHETomUgpCmVxFTnas1upOqxoLuRZlMQn++s0hOsQYMd7Wrc/QJUmqsfdwS/yaDVyXQVipnwsWv9wv8PtM1KDzTNCbJIRXLVQsOubvmGPVlsh94JZHZhK9TpCMhwH3SVhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051870; c=relaxed/simple;
	bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlesPuWSe/1sggJGG+CgXoaVId+zgjaAvKQnXpX6N8pF3ld+wNYScUvNb72/7kbR7nF8SDUZkj073Ijr8M4lw4NlawdXWCXUuxDQMI3rbcPzCQi7zSD1l/R8cC+G65ItutyXMSXBbmoBOuQJp4rya+DJlxQjB9k6NQl5He867Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohwSYJJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E04C4CEF1;
	Thu, 13 Nov 2025 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051870;
	bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ohwSYJJHnPGvbl//HR1NgM1wu8Wjv858wvyFrrkeXWWrCG9CC4ZvzW349ag5Ya5Y5
	 oJ0DUR/PXx+W/HwbaNswuxwgyTt4/crZi/NXrUBaGXAva5s3KG3BWWo5foX4BRhrK/
	 xFTOfrbrfm+0kZtPYoxd94Q6lyiW86Lgs6zWbH0UVf4wn6PFZqKFHl+8cnp8Erubpi
	 qQTmM08vcznJUokoZ/AcXPZsNNX1FVe73rgTM5aYi3cKrTRVzpxQ/Be6TMZZIH4jAp
	 r9m60mSrooS6fYBc3lk2Tydz1CVfsn/I8/QxKjLLL4oQqceVp33x+gfPjqtK6+raNJ
	 wf5EuqHwhW/cw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:16 +0100
Subject: [PATCH v2 11/42] ovl: port ovl_fadvise() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-11-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RFnDeF0MEob4qpugIedwhge3My+mr5DGS8UurPlba4E=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkWCUag56Vmlse2v2LZPnqjyxLbUITbW3o6sx6v1NaKvJzSs
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkWCUYACgkQkcYbwGV43KK1GgD/bOYx
 vKVPHD6By+MlpDe3Pd2qIgOy99PdAzpr3oFaOiIBAKPfZ2JYbEyYHSBuHBOYuBfi9b/OqDWZ/Iv
 eO+LWExIF
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 28263ad00dee..f562f908f48a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -510,18 +510,13 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
 	struct file *realfile;
-	const struct cred *old_cred;
-	int ret;
 
 	realfile = ovl_real_file(file);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(realfile, offset, len, advice);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fadvise(realfile, offset, len, advice);
 }
 
 enum ovl_copyop {

-- 
2.47.3


