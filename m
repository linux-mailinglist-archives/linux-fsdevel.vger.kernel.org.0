Return-Path: <linux-fsdevel+bounces-78834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKR5JRxPo2nW/AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:25:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7AF1C852F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D41F3210ACD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27483B234C;
	Sat, 28 Feb 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrNxX96F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C03B2349
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303297; cv=none; b=rVhAP4EAv7fLjmVMr0ww9Pd05+/c+19l4NjSpIBBkYob4Fo4kHOnQ4Vr7UhpQOBbYURAIhC+9eN6IisWrAucZldGasZnRGNGEx4bx4riG0MMNhv4jEn4Qwdrm1UbciEUo1qz/XbzdqT+DQ1bnj81f+KtBBMFc2Jk+V/tsByUG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303297; c=relaxed/simple;
	bh=JK0WuN2W9e9vtsZTDx1aUaSC3joEllv3YfQdmUK5FOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0MfYkHou+iZq3s5swh27BOcsU4thC3k1I63TC9otVd9s7nRQA1sCEJOo3IbbcQKSb3gS0tMPaQiCSt0AKg8UNENn+sgYcesFtQMa1UnXLLvT9pjq+Vb0fxtZ68N233pC2y8nRAL9jNi2qDfCBxvlyBeuZ4EpzWnNrszQXRlFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrNxX96F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772303295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdUUSuhz4rUHhjIdCOjmR2mCL+qfpF5oQsqY8Qu1sxc=;
	b=FrNxX96F9Hw9PSioBls3GZvoGDs1vZuwR1Biqm7uoJH+pS0hEh1BigrnOcINMh5HUZNCvX
	Pi63KRZFMUL9crOGrLFTlcnIhZfUEz+TmIYoU6CzKlInRVSqEYW/JCa8G5FzbSP+3Rn7h8
	erVex49KLIieiuiZhtcMtzrxjJnZdd0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-TMnmMC0uNmeNydVTSkWD-w-1; Sat,
 28 Feb 2026 13:28:11 -0500
X-MC-Unique: TMnmMC0uNmeNydVTSkWD-w-1
X-Mimecast-MFC-AGG-ID: TMnmMC0uNmeNydVTSkWD-w_1772303290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43C7B1956095;
	Sat, 28 Feb 2026 18:28:10 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 942CF1800351;
	Sat, 28 Feb 2026 18:28:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/2] fs: Add a pool of extra fs->pwd references to fs_struct
Date: Sat, 28 Feb 2026 13:27:56 -0500
Message-ID: <20260228182757.90528-2-longman@redhat.com>
In-Reply-To: <20260228182757.90528-1-longman@redhat.com>
References: <20260228182757.90528-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78834-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D7AF1C852F
X-Rspamd-Action: no action

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

A simple and elegant solution to avoid this kind of performance
regression is to add a common pool of extra fs->pwd references inside
the fs_struct. When a caller needs a pwd reference, it can borrow one
from pool, if available, to avoid an explicit path_get(). When it is
time to release the reference, it can put it back into the common pool
if fs->pwd isn't changed before without doing a path_put(). We still
need to acquire the fs's spinlock, but fs_struct is more distributed
and it is less common to have many tasks sharing a single fs_struct.

A new set of get_fs_pwd_pool/put_fs_pwd_pool() APIs are introduced
with this patch to enable other subsystems to acquire and release
a pwd reference from the common pool without doing unnecessary
path_get/path_put().

Besides fs/fs_struct.c, the copy_mnt_ns() function of fs/namespace.c is
also modified to properly handle the extra pwd references, if available.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/fs_struct.c            | 26 +++++++++++++++++++++-----
 fs/namespace.c            |  8 ++++++++
 include/linux/fs_struct.h | 28 +++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..43af98e0a10c 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -33,15 +33,19 @@ void set_fs_root(struct fs_struct *fs, const struct path *path)
 void set_fs_pwd(struct fs_struct *fs, const struct path *path)
 {
 	struct path old_pwd;
+	int count;
 
 	path_get(path);
 	write_seqlock(&fs->seq);
 	old_pwd = fs->pwd;
 	fs->pwd = *path;
+	count = fs->pwd_refs + 1;
+	fs->pwd_refs = 0;
 	write_sequnlock(&fs->seq);
 
 	if (old_pwd.dentry)
-		path_put(&old_pwd);
+		while (count--)
+			path_put(&old_pwd);
 }
 
 static inline int replace_path(struct path *p, const struct path *old, const struct path *new)
@@ -63,10 +67,15 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 		task_lock(p);
 		fs = p->fs;
 		if (fs) {
-			int hits = 0;
+			int hits;
+
 			write_seqlock(&fs->seq);
+			hits = replace_path(&fs->pwd, old_root, new_root);
+			if (hits && fs->pwd_refs) {
+				count += fs->pwd_refs;
+				fs->pwd_refs = 0;
+			}
 			hits += replace_path(&fs->root, old_root, new_root);
-			hits += replace_path(&fs->pwd, old_root, new_root);
 			while (hits--) {
 				count++;
 				path_get(new_root);
@@ -82,8 +91,11 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 void free_fs_struct(struct fs_struct *fs)
 {
+	int count = fs->pwd_refs + 1;
+
 	path_put(&fs->root);
-	path_put(&fs->pwd);
+	while (count--)
+		path_put(&fs->pwd);
 	kmem_cache_free(fs_cachep, fs);
 }
 
@@ -111,6 +123,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	if (fs) {
 		fs->users = 1;
 		fs->in_exec = 0;
+		fs->pwd_refs = 0;
 		seqlock_init(&fs->seq);
 		fs->umask = old->umask;
 
@@ -118,7 +131,10 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		fs->root = old->root;
 		path_get(&fs->root);
 		fs->pwd = old->pwd;
-		path_get(&fs->pwd);
+		if (old->pwd_refs)
+			old->pwd_refs--;
+		else
+			path_get(&fs->pwd);
 		read_sequnlock_excl(&old->seq);
 	}
 	return fs;
diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..96d41f00add6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4272,6 +4272,14 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	 * as belonging to new namespace.  We have already acquired a private
 	 * fs_struct, so tsk->fs->lock is not needed.
 	 */
+	if (new_fs)
+		WARN_ON_ONCE(new_fs->users != 1);
+
+	/* Release the extra pwd references of new_fs, if present. */
+	while (new_fs && new_fs->pwd_refs) {
+		path_put(&new_fs->pwd);
+		new_fs->pwd_refs--;
+	}
 	p = old;
 	q = new;
 	while (p) {
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..f8cf3b280398 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -8,10 +8,11 @@
 #include <linux/seqlock.h>
 
 struct fs_struct {
-	int users;
 	seqlock_t seq;
+	int users;
 	int umask;
 	int in_exec;
+	int pwd_refs;	/* A pool of extra pwd references */
 	struct path root, pwd;
 } __randomize_layout;
 
@@ -40,6 +41,31 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+/* Acquire a pwd reference from the pwd_refs pool, if available */
+static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
+{
+	read_seqlock_excl(&fs->seq);
+	*pwd = fs->pwd;
+	if (fs->pwd_refs)
+		fs->pwd_refs--;
+	else
+		path_get(pwd);
+	read_sequnlock_excl(&fs->seq);
+}
+
+/* Release a pwd reference back to the pwd_refs pool, if appropriate */
+static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
+{
+	read_seqlock_excl(&fs->seq);
+	if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt)) {
+		fs->pwd_refs++;
+		pwd = NULL;
+	}
+	read_sequnlock_excl(&fs->seq);
+	if (pwd)
+		path_put(pwd);
+}
+
 extern bool current_chrooted(void);
 
 static inline int current_umask(void)
-- 
2.53.0


