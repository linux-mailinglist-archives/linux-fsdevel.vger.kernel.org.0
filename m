Return-Path: <linux-fsdevel+bounces-28779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227496E2A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE1BB26A08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8961A724F;
	Thu,  5 Sep 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZJghaA+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A81A42CF;
	Thu,  5 Sep 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563020; cv=none; b=I5GtCV4hoox0vitauPgMy6V9OV/ol8FZGhgCdpsYbf3+pxC96S7KgRkNPzJDbKeyDHfG1Qu/DhMJK/KdIVc/aJ+QmxvQ8I2fDPtTVUNs8CuPWK1f0CeRJoFR71c9pIP/76pVG7262YQP3R6neLJung5hITtDIbMp3u6WRXh2woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563020; c=relaxed/simple;
	bh=NYPZXgW6W7ny5HpwNbFP+O9dac2B0P2JjYmVcM4MlQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um6fG9t56tpE3E5kM1CuW+xs+OPGfj5FQReL/jU3+7S+1bW6PPLwKFo5juiseS5XCaoboEFhzbyONt9o3W6TJt8cZlA+8hjxfRl5GgqEo27ZBA1q2yOJtM3TNVFE7Qn6FYiJXVCYDJHip5lJnmLfTT6KBJ8EF/yftI4JCmHhdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZJghaA+j; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=09RjlXQlRYkuU224DyyX5hGaeh4dLRLLtcX5SDFSDN0=; b=ZJghaA+jVI7xvLO2YziWNskShX
	87LUA2XkYooq3bZPKGSoYD5tloKq2MclVlntxHJslHNDeKX/iD/K2kgu3XG7t2uqpuHvYQ0ucO82U
	LliHgq6agb62p0rfBYgMSPxhhwOTW6v/7KOkaSsEmJFamtab29QMCgkORcdXuppFWpcbUr3ki8Faq
	MblpxRe1NSTRhC6GFxx9xyELWpjdG16psWeoWC4JtoP6doz7bx64aS4/xnZ9/DEz2FHllQXWu0jO1
	9WobnQ1AolJBMzYeNRqaF0n5lurCWqveZ7dkrpjdjG93mPG8t6rhDDb+6oDgo6UY8LOENg1igrvzP
	y+ybT0cw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlS-00A6Ho-0W; Thu, 05 Sep 2024 21:03:29 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 5/9] libfs: Create the helper struct generic_ci_always_del_dentry_ops
Date: Thu,  5 Sep 2024 16:02:48 -0300
Message-ID: <20240905190252.461639-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a helper to assign dentry_operations with the generic case
insensitive functions plus setting .d_delete as always_delete_dentry.
This is useful to in-memory casefold filesystems like tmpfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v3: New patch
---
 fs/libfs.c         | 15 +++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 99fb36b48708..58b39640b686 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1855,6 +1855,21 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 #endif
 };
 
+/*
+ * Same as generic_ci_dentry_ops, but also set d_delete. Useful for in-memory
+ * casefold filesystems.
+ */
+const struct dentry_operations generic_ci_always_del_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+#ifdef CONFIG_FS_ENCRYPTION
+	.d_revalidate = fscrypt_d_revalidate,
+#endif
+	.d_delete = always_delete_dentry,
+};
+EXPORT_SYMBOL(generic_ci_always_del_dentry_ops);
+
+
 /**
  * generic_ci_match() - Match a name (case-insensitively) with a dirent.
  * This is a filesystem helper for comparison with directory entries.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 937142950dfe..254a1dcf987b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3337,6 +3337,7 @@ extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
+extern const struct dentry_operations generic_ci_always_del_dentry_ops;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
-- 
2.46.0


