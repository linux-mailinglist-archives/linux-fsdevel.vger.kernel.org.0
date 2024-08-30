Return-Path: <linux-fsdevel+bounces-28042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53D96629B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BAC1C239B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B621B530A;
	Fri, 30 Aug 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQJb2tQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F31AE056
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023189; cv=none; b=j+NAr7eppqHvrmo6Tvm+9zrUjdejJV4/dwTL/njv7MUwZ/XWVvBM0ZgYRbb3yCtAcw7B1Q67IvYuAi036zl5sk1EGgA0datKNh0msCmfz4qgo3dX8WC/7CoBV9HfsHRbNxlc/VtUP+nCadi8lV2YV1A2EG5TqzuzwYc2jWJ9NKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023189; c=relaxed/simple;
	bh=3woYN5gWU2ZxDLzsw5HkcAJ38mFoKEtN6YbTejqApNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oG104G5Ngvk6yonEo2R6bXSdllP1yB88bqOx8O4sjRChCobGMIyVqNddjnqE8LvrkYQNznfMEFEfGYgSI8xJQqrX/Cd+FJRw7Ux5MntKXk5kHSeYeHOxNZeSJXrnuHW8Jw0gySWT/W5rzsb2HRCjZiw7BiPZX7nCdrgdJ17TBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQJb2tQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F794C4CEC2;
	Fri, 30 Aug 2024 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023189;
	bh=3woYN5gWU2ZxDLzsw5HkcAJ38mFoKEtN6YbTejqApNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nQJb2tQSevZ38AR9LiZroCs39xOoE5faSvjTZ4aOcokUnSHmH3om9i058KPyw+qnR
	 l/g4MPjV/NsYFDZY00gHPyJx4LMFjETr4xTUSHlnwPKVAXm26oCFW1gVJvjUnrLJqx
	 rouvFP/md1KQgW3tus43QojV2h5Pbal02ZTTYRgehEfXYffFeTVRzXBKbA/CMpHCVB
	 9KUeXomfx2NylzxzH7WSHbyMJ6v+81/l3xmn49BUn5WaQV/Irpg3nJQ51E98+V8MW0
	 ex2+hjDWHg6BSYkHwK6r4nQbsxNB1K8LxxZoVUyxABqr3ErcGTX3hEW6MnuRZX21Ed
	 Y8wAGuEvH2AMA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:05:01 +0200
Subject: [PATCH RFC 20/20] fs: remove f_version
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-20-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3woYN5gWU2ZxDLzsw5HkcAJ38mFoKEtN6YbTejqApNY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDx3fdhqu2knbJnnmIc+WsTdeH9SZL/K9jcFrw4Gz
 yy7d8BhX0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEBJ8z/OH93VJRsJuru22y
 juXCdPbNsg8eGLmrOPwTdi44JOsh1sDwz5pP+XFn652M5TOW/2Nfavx+7pEL8WrlzouV3lTN5+V
 dzwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that detecting concurrent seeks is done by the filesystems that
require it we can remove f_version and free up 8 bytes for future
extensions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c    | 9 ++++-----
 include/linux/fs.h | 4 +---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 47f7b4e32a53..981146f50568 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -62,7 +62,8 @@ static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
 
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
-		*cookie = 0;
+		if (cookie)
+			*cookie = 0;
 	}
 	return offset;
 }
@@ -81,7 +82,7 @@ static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
  */
 loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
 {
-	return vfs_setpos_cookie(file, offset, maxsize, &file->f_version);
+	return vfs_setpos_cookie(file, offset, maxsize, NULL);
 }
 EXPORT_SYMBOL(vfs_setpos);
 
@@ -362,10 +363,8 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 	}
 	retval = -EINVAL;
 	if (offset >= 0 || unsigned_offsets(file)) {
-		if (offset != file->f_pos) {
+		if (offset != file->f_pos)
 			file->f_pos = offset;
-			file->f_version = 0;
-		}
 		retval = offset;
 	}
 out:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca4925008244..7e11ce172140 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1003,7 +1003,6 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_pos_lock: lock protecting file position
  * @f_pipe: specific to pipes
  * @f_pos: file position
- * @f_version: file version
  * @f_security: LSM security context of this file
  * @f_owner: file owner
  * @f_wb_err: writeback error
@@ -1034,11 +1033,10 @@ struct file {
 		u64			f_pipe;
 	};
 	loff_t				f_pos;
-	u64				f_version;
-	/* --- cacheline 2 boundary (128 bytes) --- */
 #ifdef CONFIG_SECURITY
 	void				*f_security;
 #endif
+	/* --- cacheline 2 boundary (128 bytes) --- */
 	struct fown_struct		*f_owner;
 	errseq_t			f_wb_err;
 	errseq_t			f_sb_err;

-- 
2.45.2


