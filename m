Return-Path: <linux-fsdevel+bounces-28027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D596628A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C69A1C24359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3751B1D7F;
	Fri, 30 Aug 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezuQJQxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE21AF4D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023150; cv=none; b=a5IMYICfzGbSwAOhMNFHt9krFidpRzcW4iF7LRAvdr7q1avIHUUCSCOAzKzr0gF1Y87o5vOU2TOYSGKCkb9nzLvaJC05AzpT8HQIWZ3HdcriYi3wPj/iyLA1sScaERBt3drviakjd7zThLtMMtZtdmHwVeNVCwITdr9v6aEU0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023150; c=relaxed/simple;
	bh=pZf6+t/viyHgiwzusJ9PMI1aFRzOx2txikjpQentD+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T50gQfRvRQjHhxVqmPqUPSh14WGFHgzMslGS2p2afPCoDTYFlQYsQRDE9xlen4Jl3a4YDMMO+4hbZ5YOh8/w/tIKYbygGfb6ylaxSwnesfj8BpNKmhetJqTAfRT2ZniJTlGU/6C2xAJ+AzphaFnNzlGzfN1dIF9w4NxYDAAAzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezuQJQxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C174C4CEC8;
	Fri, 30 Aug 2024 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023149;
	bh=pZf6+t/viyHgiwzusJ9PMI1aFRzOx2txikjpQentD+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ezuQJQxuY7H0u4OlCwMqi0dheDdx8O1RbcMqUFNb+saCl9CaZNlmi1FMFH5LWIpWx
	 hDlQpPteGlL3BWg/8Id+ErxWXoeqKXQFh0YM8Gsv6zxt6JXuGeI0d0fih1PX1dKgfK
	 sfLlVVDlqf/nL12VQhegsHEjBrqShG3lCB+O4mMnQihqDQQDbzHdqXdGiWvgolRF8o
	 TXMw8pOc17VLujFXY2T0g9xth/1JAoxv067gg0wzuXI7uBfBsDPR+27yTZ4niVysMx
	 Iq/3JSHv7NtQnTTcROa30sNXLRECMTf4qWtA2M6SaOvhQ5LtIwfhe0iB8hZ91snnqT
	 iFGB1HMFtx/rQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:46 +0200
Subject: [PATCH RFC 05/20] fs: add vfs_setpos_cookie()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-5-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pZf6+t/viyHgiwzusJ9PMI1aFRzOx2txikjpQentD+A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDyHs8lp5e6m4m2KFjYqxcv3b+96mGN8O0LyINPFd
 tVoxs+OHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNp2cLwTzH2SaKI7P+vX3ii
 XMOPHUgI2uRnxhc9yUxOoIQxM+qQO8M/+7Tghs18XnVTj7z28dCSnnP7lAnH5j89Ex8665Z9XTC
 XFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a new helper and make vfs_setpos() call it. We will use it in
follow-up patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..66ff52860496 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -40,18 +40,20 @@ static inline bool unsigned_offsets(struct file *file)
 }
 
 /**
- * vfs_setpos - update the file offset for lseek
+ * vfs_setpos_cookie - update the file offset for lseek and reset cookie
  * @file:	file structure in question
  * @offset:	file offset to seek to
  * @maxsize:	maximum file size
+ * @cookie:	cookie to reset
  *
- * This is a low-level filesystem helper for updating the file offset to
- * the value specified by @offset if the given offset is valid and it is
- * not equal to the current file offset.
+ * Update the file offset to the value specified by @offset if the given
+ * offset is valid and it is not equal to the current file offset and
+ * reset the specified cookie to indicate that a seek happened.
  *
  * Return the specified offset on success and -EINVAL on invalid offset.
  */
-loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
+static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
+				loff_t maxsize, u64 *cookie)
 {
 	if (offset < 0 && !unsigned_offsets(file))
 		return -EINVAL;
@@ -60,10 +62,27 @@ loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
 
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
-		file->f_version = 0;
+		*cookie = 0;
 	}
 	return offset;
 }
+
+/**
+ * vfs_setpos - update the file offset for lseek
+ * @file:	file structure in question
+ * @offset:	file offset to seek to
+ * @maxsize:	maximum file size
+ *
+ * This is a low-level filesystem helper for updating the file offset to
+ * the value specified by @offset if the given offset is valid and it is
+ * not equal to the current file offset.
+ *
+ * Return the specified offset on success and -EINVAL on invalid offset.
+ */
+loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
+{
+	return vfs_setpos_cookie(file, offset, maxsize, &file->f_version);
+}
 EXPORT_SYMBOL(vfs_setpos);
 
 /**

-- 
2.45.2


