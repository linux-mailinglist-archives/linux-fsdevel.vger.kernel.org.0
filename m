Return-Path: <linux-fsdevel+bounces-28030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BB96628E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77571F210C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183941B2538;
	Fri, 30 Aug 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiAYgUqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DE1AF4F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023158; cv=none; b=TX90yMnEvXPgO4mWBttHbxKz9Go6eW6GSx5fT4HWFLBbzXnr61xjF+InbEhrbGo4uFPYHlOiGTcycsU+vmni6TWbwcUFXrKp7hVpwrCQzY/FiiSMGKhbAF/FsHZQBpw+5yU5T2vmLcIwUUpGBWz7js7MtHEABJBmLo5GoISiUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023158; c=relaxed/simple;
	bh=ke7sJon/SOR0neb++AsgdfoyyC78KHWq+1liodzQ8S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOY5huVGbw6x7MRas0FXUR3sVtLB7SE1mCuqDB+EOtnfTk2/2/E66NYByW9vUst4KqwnDNIe4jNe9eN9FxvFJ8vPPWlZQBrrr/du2w3APce6aw6CztgzfU+mSKHNH1feZZ94VS6E0KYy1h5W8Gx3h8/z0k0bUDtSHXgtsd+aVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiAYgUqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC127C4CEC5;
	Fri, 30 Aug 2024 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023158;
	bh=ke7sJon/SOR0neb++AsgdfoyyC78KHWq+1liodzQ8S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CiAYgUqQFpJ4E2yqp6reYh+4BW3SaHJ98IL3JI590/pXYfNmPi52Fk2ca7GoD6vTU
	 /EpLiFlIse/rCkJKKlufB6ZwuVgXQNhT8XsDTc10BD/vQCnirCJRRYZ6PAJWaEVkZI
	 qxZt92HTYJOgU41CLigN65XSd36EUOn2oJLdpSIE9ajqyVHQ/wPCFDGuIkjx5m91BA
	 BDa/Heqjo+avfZpWV/rnk44puJRusgxvVXAsFbDZP/QaEvG5yhERJpzHMUAm5Ultzy
	 9keaEL/zzBVMiQHngrkMKybs0OiCop0ch84drkVlXldhAFK+U4bND3CGHYa6dDG5ME
	 eEd1C/BCeqFrg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:49 +0200
Subject: [PATCH RFC 08/20] fs: add generic_llseek_cookie()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-8-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ke7sJon/SOR0neb++AsgdfoyyC78KHWq+1liodzQ8S0=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGbRw5ygp4r8gNC+RskQAjT62Y22pe+LxrHZOshx3s8trdxH2
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmbRw5wACgkQkcYbwGV43KLZMgEAyNP1
 kdjmDTMiB4hKioALskXm+Kvrw4+gNOkVLZfdFs0BAMbgbikvsWo6GAp0QQo3FHIYi4S5B5oYL8Q
 WAApoocgM
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is similar to generic_file_llseek() but allows the caller to
specify a cookie that will be updated to indicate that a seek happened.
Caller's requiring that information in their readdir implementations can
use that.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index ad93b72cc378..47f7b4e32a53 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -179,6 +179,50 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 }
 EXPORT_SYMBOL(generic_file_llseek_size);
 
+/**
+ * generic_llseek_cookie - versioned llseek implementation
+ * @file:	file structure to seek on
+ * @offset:	file offset to seek to
+ * @whence:	type of seek
+ * @cookie:	cookie to update
+ *
+ * See generic_file_llseek for a general description and locking assumptions.
+ *
+ * In contrast to generic_file_llseek, this function also resets a
+ * specified cookie to indicate a seek took place.
+ */
+loff_t generic_llseek_cookie(struct file *file, loff_t offset, int whence,
+			     u64 *cookie)
+{
+	struct inode *inode = file->f_mapping->host;
+	loff_t maxsize = inode->i_sb->s_maxbytes;
+	loff_t eof = i_size_read(inode);
+	int ret;
+
+	if (WARN_ON_ONCE(!cookie))
+		return -EINVAL;
+
+	ret = must_set_pos(file, &offset, whence, eof);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return offset;
+
+	if (whence == SEEK_CUR) {
+		/*
+		 * f_lock protects against read/modify/write race with
+		 * other SEEK_CURs. Note that parallel writes and reads
+		 * behave like SEEK_SET.
+		 */
+		guard(spinlock)(&file->f_lock);
+		return vfs_setpos_cookie(file, file->f_pos + offset, maxsize,
+					 cookie);
+	}
+
+	return vfs_setpos_cookie(file, offset, maxsize, cookie);
+}
+EXPORT_SYMBOL(generic_llseek_cookie);
+
 /**
  * generic_file_llseek - generic llseek implementation for regular files
  * @file:	file structure to seek on
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 58c91a52cad1..3e6b3c1afb31 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,8 @@ extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t generic_file_llseek_size(struct file *file, loff_t offset,
 		int whence, loff_t maxsize, loff_t eof);
+loff_t generic_llseek_cookie(struct file *file, loff_t offset, int whence,
+			     u64 *cookie);
 extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
 		int whence, loff_t size);
 extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);

-- 
2.45.2


