Return-Path: <linux-fsdevel+bounces-57596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B665B23C7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B551A2731E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A002E2DD7;
	Tue, 12 Aug 2025 23:53:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE162D4B6D;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042784; cv=none; b=iV05z4v0d3gnUvprKJzocxpd0r2v/x7bR9Mh9jt0ryGYbLmOdoHJov/5avMIRmdJVJHHPhrhQSOA+DAWbLBugJ6pahtgJ0P7xSSUUMKfBOnWaWNiLMqkN+jbUW2QuJ/SJK6jB1zYwt4BFy+KzAZZJb825e4kNy7uL4wEoVmkOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042784; c=relaxed/simple;
	bh=wY0rj6H9uNX526KJkK3oQKoJg0U9wk/QJcI6qW2yVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcoyDzD/BnJxPRfGx/DD2XPnTaNox/xWGCU137RLX0x7YyI6s/OxVQCkjLycdkjRTW9GfijiVUVyyYMCanZa6tM0qlyrnsdgftyGc3ra0dmSdbGBiE0b6XEdLZe/4NzfWnmQh/XmvybfrPFUXdDY7O8w3ERFsOTluHYDgAUeWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynK-005Y1y-Ic;
	Tue, 12 Aug 2025 23:52:44 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] VFS: add dentry_lookup_killable()
Date: Tue, 12 Aug 2025 12:25:06 +1000
Message-ID: <20250812235228.3072318-4-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
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
index 85b981248a90..7af9b464886a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1837,6 +1837,43 @@ struct dentry *dentry_lookup(struct mnt_idmap *idmap,
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
+ * The "necessary locks" are currently the inode lock on @base.
+ * If a fatal signal arrives, or is already pending, the operation is aborted.
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
index 932cb94c3538..facb5852afa9 100644
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
 void done_dentry_lookup(struct dentry *dentry);
-- 
2.50.0.107.gf914562f5916.dirty


