Return-Path: <linux-fsdevel+bounces-44354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87062A67D42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C33BED13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60189211A15;
	Tue, 18 Mar 2025 19:45:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5E1684A4;
	Tue, 18 Mar 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327158; cv=none; b=W3UYCFsrcMhnhIW/WLGA8XFy1qQn9XfHbY2xcD1aaRrE7cYnaLE+Zc1ICpvClSCmwz12l2mLVKtiK3ezFWDIWnNdCfTkhE6Ohn7fdgJiFus705Xuh64WbZqGyuk7F3FS5kZPZHyd3SEycnmDWg45Yq2LmpHT80tXdxEiilenQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327158; c=relaxed/simple;
	bh=PbsM4F3AQtYmg7+7YvqmfgEnNlaqSZw+r4NRK5QJdvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhMhSxO4d0P2Vykf51OGjwho7AyfWDv+vRAMgYlCh7SDDzIIjK9am2QmGHY5ncTn8UoOjJj99LUxpLhyysOPkypto2K3xHdSorStzADIAMTuFgsuk7ADdmJIQOq3mS2B28ky+15wiyeQs57QgiNgM7Qv0eto/l86z/HHGitTmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id B02AE1C00FB;
	Tue, 18 Mar 2025 15:45:51 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 2/3] libfs: add simple directory iteration function with callback
Date: Tue, 18 Mar 2025 15:41:10 -0400
Message-ID: <20250318194111.19419-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current iterate_dir() infrastructure is somewhat cumbersome to use
from within the kernel.  Introduce a lighter weight
simple_iterate_dir() function that directly iterates the directory and
executes a callback for each positive dentry.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/libfs.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 816bfe6c0430..37da5fe25242 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -214,6 +214,39 @@ static void internal_readdir(struct dentry *dentry, struct dentry *cursor,
 	dput(next);
 }
 
+/**
+ * generic_iterate_call - iterate all entries executing @callback
+ *
+ * @dir: directory to iterate over
+ * @data: data passed to callback
+ * @callback: callback to call
+ *
+ * Iterates over all positive dentries that are direct children of
+ * @dir (so doesn't include . and ..) and executes the callback for
+ * each of them.  Note that because there's no struct *mnt, the caller
+ * is responsible for pinning the filesystem.
+ *
+ * If the @callback returns true, the iteration will continue and if
+ * it returns @false, it will stop (note that since the cursor is
+ * destroyed the next invocation will go back to the beginning again).
+ *
+ */
+int simple_iterate_call(struct dentry *dir, void *data,
+			bool (*callback)(void *, struct dentry *))
+{
+	struct dentry *cursor = d_alloc_cursor(dir);
+
+	if (!cursor)
+		return -ENOMEM;
+
+	internal_readdir(dir, cursor, data, true, callback);
+
+	dput(cursor);
+
+	return 0;
+}
+EXPORT_SYMBOL(simple_iterate_call);
+
 static bool dcache_readdir_callback(void *data, struct dentry *entry)
 {
 	struct dir_context *ctx = data;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2788df98080f..a84896f0b2d1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3531,6 +3531,8 @@ extern int simple_rename(struct mnt_idmap *, struct inode *,
 			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
+extern int simple_iterate_call(struct dentry *dir, void *data,
+			       bool (*callback)(void *, struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
-- 
2.43.0


