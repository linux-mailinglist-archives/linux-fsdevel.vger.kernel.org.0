Return-Path: <linux-fsdevel+bounces-55572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EAB0BF5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD04D1894225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A628AAF9;
	Mon, 21 Jul 2025 08:45:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C91798F;
	Mon, 21 Jul 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087541; cv=none; b=RV0nplzQ5z2+Yjd2MaEe+zyGCnP3qvJsAI24nJ3CQMYtoewY/bq9AktUU4nEe+K3AAOgB7wzyPwQOX34MPfdJzRooRVDblRVSiG6gyy0avjFGkN78PUJ5rarXdo2T5VFIH1thqAd9FDguhKfFNvUeQFPljOBGdqvwT6QaVDmk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087541; c=relaxed/simple;
	bh=tIuRYlykPAGszyzVHK9YDzKE+Xx+7unKoWAz9AwPBnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEb++dc3eXEmf0eypI5UdrXYkXqbnwl/lYP+x+jXzMmtbqTWS6OA0N+P5vrGCCSayxH4QDP6VAQum2ATHox1NMxUQA9X9Y6ScsSI3dGTqp9JRHrz4VUREKYm/OlYQJkf4FKo0JfoBF11YtMxfofa/lXaZ3SaNsWMCz3Xe1RLPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9H-002pg7-UG;
	Mon, 21 Jul 2025 08:45:29 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] VFS: add dentry_lookup_killable()
Date: Mon, 21 Jul 2025 18:00:01 +1000
Message-ID: <20250721084412.370258-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs/ioctl.c uses a "killable" lock on the directory when creating an
destroying subvols.  overlayfs also does this.

This patch adds dentry_lookup_killable() for these users.

Possibly all dentry_lookup should be killable as there is no down-side,
but that can come in a later patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index f292df61565a..46657736c7a0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1799,6 +1799,43 @@ struct dentry *dentry_lookup(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(dentry_lookup);
 
+/**
+ * dentry_lookup_killable - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode node lock on @base.
+ * If a fatal signal arrives or is already pending the operation is aborted.
+ * The name @last is NOT expected to already have the hash calculated.
+ * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
+				      struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	int err;
+
+	err = lookup_one_common(idmap, last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	err = down_write_killable_nested(&base->d_inode->i_rwsem, I_MUTEX_PARENT);
+	if (err)
+		return ERR_PTR(err);
+
+	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(dentry_lookup_killable);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 6d2cf4af5f16..8eade32623d8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 struct dentry *dentry_lookup(struct mnt_idmap *idmap,
 			       struct qstr *last, struct dentry *base,
 			       unsigned int lookup_flags);
+struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
+				      struct qstr *last, struct dentry *base,
+				      unsigned int lookup_flags);
 struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
 struct dentry *dentry_lookup_hashed(struct qstr *last, struct dentry *base,
-- 
2.49.0


