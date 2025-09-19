Return-Path: <linux-fsdevel+bounces-62207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFEB88612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1748552298B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461972EBDC0;
	Fri, 19 Sep 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVNlfhTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B02EA721
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269931; cv=none; b=qnnjSyG2ERZ/JmCSVYdvk+CMHe1GN8stoRVPCE3p67acY9Z5X40ckOANhvCMcJSHXP9miYpYIooqWjfQfY62qY1mUo8I2jhC2hUUdgjm0UyCzGxwGyPpxob9jmXlPXrIQU5P6JU91xJOAsTa9L1XfAHsTA5iCF6QgtBd9T2U9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269931; c=relaxed/simple;
	bh=X+3XJWCt+/X+/GsL/QQ4CnwAGQi5LQGe3Nzag8rioxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4AEW3DVwy4ktSVJm+Ltry+JhqiQWMTROXdgl5P/c1ENoyjXq+0oVF0d0Q53kkymSSxlIl4CRU2UFJqvgDulZmnCS8s8Bp9tk0ghpvGBZ2P+k8Sfwl3nUptrQ8NcNfiVdTUw8b08vIqhXxo7ztitYS8NntYz2LE4Bs1B89FChpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVNlfhTT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758269928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IqNzJSsOKkhkymaclFhPqtNoGU65fgdz9oRnxFcark4=;
	b=RVNlfhTTq1TqV3igT/vzaLaLJ0+G5mnJqjXOc+K7j/afC8nHyLfWFAbAclGUP4QE5L0XKL
	PWMtlAP2By/5aE3A+xfi/C+bM1Jdt43tgxFjxyQo720D81UXFBGVwSeci8Fi+2lwq66BtE
	JapZ/QPXh8r+R/v5LrM+tkYGpo8Z8fY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-gC5TcsKHNDeO1uc-NtbTMg-1; Fri, 19 Sep 2025 04:18:47 -0400
X-MC-Unique: gC5TcsKHNDeO1uc-NtbTMg-1
X-Mimecast-MFC-AGG-ID: gC5TcsKHNDeO1uc-NtbTMg_1758269926
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e037fd142so19169165e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 01:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269926; x=1758874726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqNzJSsOKkhkymaclFhPqtNoGU65fgdz9oRnxFcark4=;
        b=WWwaNW8eMe6cfi9v6osjF+0f8YFGavPZs+5TzHcgauWh2agYB9h4eimCrrF34+Apxl
         RK618E9KMyg+h3G7TQASMywbD5QXxaybOvAcAr7cRnWqpAoDuk7zLZs+xSWAniK/bNjY
         qGJpWkuiB4+XYGryUDlpAHGJ/gVm+YbrXP/lzmhdveKPpMcnC2F6w4x4/uPqiOv6LhRp
         MSrH4JJHzCcch4CKzzYY7m+WXCkybsCRupgz6mkPaQCyhFBUb4catbgbKPwkte6t0jea
         9jRgNCV9Mxv+x/NfQYrjm8n+8upyjOat9FKFo96S1Zyk6ccvf714UcWGb7SusEJBqkUB
         4teg==
X-Gm-Message-State: AOJu0YwBlFdai/g8N7vc87c7OGQ07EYMt5xkgAX6BGVWTgQb50bgwrhg
	gFNh5vvTtjtxLRyBF+FgufdbwxqCIPT7XhIhNP/mygIHwnchTHzivrvWWkDWkpmLt9tTCtnDcg4
	H2x+vpOWjqhedEdMylzlku3u9sau6MtoByPs+Z+L6AI5H4nj4SVtNFZlV1TEXP5rhwYnLwrcq2Z
	X4IIkOxzwpVntuXvKlrIcrWq9YtBa1bGZVsfO6MU9Bq8sXHEJOsv+2pQ==
X-Gm-Gg: ASbGnct8M8WW8bqLN8jy6EtV1rhEaRX+3OuCZs4Yht8MifTRkau56/pehFVE7Wu4smZ
	OlHTP+M3QBFugiWKWB92gRv3NZmAU9KwVNJx51dpIRfS3vXYQdCIh4Uld1k3bpaPStEWVuX4C8h
	cXPdG7YnkZkIDEXNMfISiw3JD1OIh6+ecuKNj10Q018DToEYhUKnixSjajXLTMhuN3h3Km1kNpg
	h60N0YKLu1gmLqstZJzK9Y9BaMgl4XzxpOcD5flfXrbB2m3kx4GP8DvsA1nl+OdMY0VLF47jRiS
	MH1UxBUWorEnVFHpnelbii6Y2Oh2JvuVnAVcIize5wPij/0YdPhYmr1G7Z1Omaslm9s1E0rIbBx
	0q3FXioYWkITck/Oe/9M=
X-Received: by 2002:a05:6000:40da:b0:3ec:8c8:7b69 with SMTP id ffacd0b85a97d-3ee861f8341mr1328032f8f.41.1758269925552;
        Fri, 19 Sep 2025 01:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4xddGrGo1Mn5iLG1b5So7/ggP5rKWgZV1wGrfS4Jcddj5pIg8vpcZ98gBaKOyuWUelPmTcg==
X-Received: by 2002:a05:6000:40da:b0:3ec:8c8:7b69 with SMTP id ffacd0b85a97d-3ee861f8341mr1328008f8f.41.1758269924994;
        Fri, 19 Sep 2025 01:18:44 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-250.pool.digikabel.hu. [85.67.172.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm6730209f8f.8.2025.09.19.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:18:44 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH] namei: fix revalidate vs. rename race
Date: Fri, 19 Sep 2025 10:18:41 +0200
Message-ID: <20250919081843.522786-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a path component is revalidated while a rename is in progress the
filesystem might find the already exchanged files, while the kernel still
has the old ones in dcache (d_revalidate may be called without any locks).
This mismatch will cause the dentry to be invalidated (unhashed), resulting
in "(deleted)" being appended to proc paths and submounts unmounted.

Another race introduced by commit 5be1fa8abd7b ("Pass parent directory
inode and expected name to ->d_revalidate()") is that the name passed to
revalidate can be stale (rename succeeded after the dentry was looked up in
the dcache).

Solve this by

 a) samping dentry->d_seq when the dentry is looked up from the cache

 b) setting a DCACHE_RENAMING flag on the dentry during rename

 c) verifying in d_invalidate() that the sequence number is unchanged and
    no rename is happening

This should also fix race with d_splice_alias() moving the dentry.

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/dcache.c            | 81 +++++++++++++++++++++++++++++++++++-------
 fs/internal.h          |  3 +-
 fs/namei.c             | 41 +++++++++++++++++----
 include/linux/dcache.h |  5 +++
 4 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..60beeccf6bff 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1636,14 +1636,10 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 	return D_WALK_CONTINUE;
 }
 
-/**
- * d_invalidate - detach submounts, prune dcache, and drop
- * @dentry: dentry to invalidate (aka detach, prune and drop)
- */
-void d_invalidate(struct dentry *dentry)
+static void d_invalidate_locked(struct dentry *dentry)
 {
 	bool had_submounts = false;
-	spin_lock(&dentry->d_lock);
+
 	if (d_unhashed(dentry)) {
 		spin_unlock(&dentry->d_lock);
 		return;
@@ -1669,8 +1665,47 @@ void d_invalidate(struct dentry *dentry)
 		dput(victim);
 	}
 }
+
+/**
+ * d_invalidate - detach submounts, prune dcache, and drop
+ * @dentry: dentry to invalidate (aka detach, prune and drop)
+ */
+void d_invalidate(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	d_invalidate_locked(dentry);
+}
 EXPORT_SYMBOL(d_invalidate);
 
+/**
+ * d_invalidate_reval - conditionally invalidate a dentry for revalidation
+ * @dentry: dentry to conditionally invalidate
+ * @seq: sequence number sampled during dentry lookup
+ *
+ * Check if the dentry has been renamed since the sequence number was sampled
+ * or if it's currently being renamed. If either condition is true, skip the
+ * invalidation to avoid the race between dentry revalidation and renames.
+ */
+void d_invalidate_reval(struct dentry *dentry, unsigned int seq)
+{
+	spin_lock(&dentry->d_lock);
+
+	/* Check if dentry is currently being renamed */
+	if (dentry->d_flags & DCACHE_RENAMING) {
+		spin_unlock(&dentry->d_lock);
+		return;
+	}
+
+	/* Check if dentry sequence has changed since sampling */
+	if (read_seqcount_retry(&dentry->d_seq, seq)) {
+		spin_unlock(&dentry->d_lock);
+		return;
+	}
+
+	/* Safe to invalidate - no rename race detected */
+	d_invalidate_locked(dentry);
+}
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -2329,19 +2364,24 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
  * dentry is returned. The caller must use dput to free the entry when it has
  * finished using it. %NULL is returned if the dentry does not exist.
  */
-struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
+struct dentry *d_lookup_seq(const struct dentry *parent, const struct qstr *name, unsigned int *d_seq)
 {
 	struct dentry *dentry;
 	unsigned seq;
 
 	do {
 		seq = read_seqbegin(&rename_lock);
-		dentry = __d_lookup(parent, name);
+		dentry = __d_lookup(parent, name, d_seq);
 		if (dentry)
 			break;
 	} while (read_seqretry(&rename_lock, seq));
 	return dentry;
 }
+
+struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
+{
+	return d_lookup_seq(parent, name, NULL);
+}
 EXPORT_SYMBOL(d_lookup);
 
 /**
@@ -2359,7 +2399,8 @@ EXPORT_SYMBOL(d_lookup);
  *
  * __d_lookup callers must be commented.
  */
-struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
+struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name,
+			  unsigned int *seq)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = d_hash(hash);
@@ -2404,6 +2445,8 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 			goto next;
 
 		dentry->d_lockref.count++;
+		if (seq)
+			*seq = raw_seqcount_begin(&dentry->d_seq);
 		found = dentry;
 		spin_unlock(&dentry->d_lock);
 		break;
@@ -2539,9 +2582,10 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  wait_queue_head_t *wq,
+				  unsigned int *seqp)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2575,6 +2619,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			goto retry;
 		}
 		rcu_read_unlock();
+		if (seqp)
+			*seqp = d_seq;
 		dput(new);
 		return dentry;
 	}
@@ -2637,6 +2683,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		if (unlikely(!d_same_name(dentry, parent, name)))
 			goto mismatch;
 		/* OK, it *is* a hashed match; return it */
+		if (seqp)
+			*seqp = read_seqcount_begin(&dentry->d_seq);
 		spin_unlock(&dentry->d_lock);
 		dput(new);
 		return dentry;
@@ -2645,12 +2693,21 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
+	if (seqp)
+		*seqp = read_seqcount_begin(&new->d_seq);
 	return new;
 mismatch:
 	spin_unlock(&dentry->d_lock);
 	dput(dentry);
 	goto retry;
 }
+
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name,
+				wait_queue_head_t *wq)
+{
+	return __d_alloc_parallel(parent, name, wq, NULL);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..99743525a24a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -224,7 +224,8 @@ extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 extern void shrink_dcache_for_umount(struct super_block *);
-extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
+extern struct dentry *__d_lookup(const struct dentry *parent,
+				const struct qstr *name, unsigned int *seq);
 extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
 extern void d_genocide(struct dentry *);
diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..e6fcdc60f075 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1652,12 +1652,15 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 				    struct dentry *dir,
 				    unsigned int flags)
 {
-	struct dentry *dentry = d_lookup(dir, name);
+	struct dentry *dentry;
+	unsigned int seq;
+
+	dentry = d_lookup_seq(dir, name, &seq);
 	if (dentry) {
 		int error = d_revalidate(dir->d_inode, name, dentry, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
-				d_invalidate(dentry);
+				d_invalidate_reval(dentry, seq);
 			dput(dentry);
 			return ERR_PTR(error);
 		}
@@ -1763,14 +1766,14 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 			status = d_revalidate(nd->inode, &nd->last,
 					      dentry, nd->flags);
 	} else {
-		dentry = __d_lookup(parent, &nd->last);
+		dentry = __d_lookup(parent, &nd->last, &nd->next_seq);
 		if (unlikely(!dentry))
 			return NULL;
 		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
-			d_invalidate(dentry);
+			d_invalidate_reval(dentry, nd->next_seq);
 		dput(dentry);
 		return ERR_PTR(status);
 	}
@@ -1784,20 +1787,21 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
+	unsigned int seq;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry = d_alloc_parallel(dir, name, &wq);
+	dentry = __d_alloc_parallel(dir, name, &wq, &seq);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
 		int error = d_revalidate(inode, name, dentry, flags);
 		if (unlikely(error <= 0)) {
 			if (!error) {
-				d_invalidate(dentry);
+				d_invalidate_reval(dentry, seq);
 				dput(dentry);
 				goto again;
 			}
@@ -4958,6 +4962,20 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 	return do_linkat(AT_FDCWD, getname(oldname), AT_FDCWD, getname(newname), 0);
 }
 
+static void dentry_set_renaming(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_RENAMING;
+	spin_unlock(&dentry->d_lock);
+}
+
+static void dentry_clear_renaming(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags &= ~DCACHE_RENAMING;
+	spin_unlock(&dentry->d_lock);
+}
+
 /**
  * vfs_rename - rename a filesystem object
  * @rd:		pointer to &struct renamedata info
@@ -5126,10 +5144,15 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
+
+	dentry_set_renaming(old_dentry);
+	if (flags & RENAME_EXCHANGE)
+		dentry_set_renaming(new_dentry);
+
 	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
-		goto out;
+		goto out_clear_renaming;
 
 	if (!(flags & RENAME_EXCHANGE) && target) {
 		if (is_dir) {
@@ -5145,6 +5168,10 @@ int vfs_rename(struct renamedata *rd)
 		else
 			d_exchange(old_dentry, new_dentry);
 	}
+out_clear_renaming:
+	dentry_clear_renaming(old_dentry);
+	if (flags & RENAME_EXCHANGE)
+		dentry_clear_renaming(new_dentry);
 out:
 	if (!is_dir || lock_old_subdir)
 		inode_unlock(source);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..c9f415db243b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -222,6 +222,7 @@ enum dentry_flags {
 	DCACHE_PAR_LOOKUP		= BIT(24),	/* being looked up (with parent locked shared) */
 	DCACHE_DENTRY_CURSOR		= BIT(25),
 	DCACHE_NORCU			= BIT(26),	/* No RCU delay for freeing */
+	DCACHE_RENAMING			= BIT(27),	/* dentry is being renamed */
 };
 
 #define DCACHE_MANAGED_DENTRY \
@@ -243,6 +244,8 @@ extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
+extern struct dentry * __d_alloc_parallel(struct dentry *, const struct qstr *,
+					wait_queue_head_t *, unsigned int *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
@@ -256,6 +259,7 @@ extern struct dentry * d_obtain_root(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
 extern void d_invalidate(struct dentry *);
+extern void d_invalidate_reval(struct dentry *, unsigned int);
 
 /* only used at mount-time */
 extern struct dentry * d_make_root(struct inode *);
@@ -284,6 +288,7 @@ extern void d_exchange(struct dentry *, struct dentry *);
 extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
 
 extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
+extern struct dentry *d_lookup_seq(const struct dentry *parent, const struct qstr *name, unsigned int *d_seq);
 
 static inline unsigned d_count(const struct dentry *dentry)
 {
-- 
2.51.0


