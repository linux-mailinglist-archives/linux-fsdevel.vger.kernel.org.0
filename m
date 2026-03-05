Return-Path: <linux-fsdevel+bounces-79523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDbBar5qWncIwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 22:46:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82681218942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 22:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C960C303E77E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F133987E;
	Thu,  5 Mar 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvvGOzef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770A7260D;
	Thu,  5 Mar 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747168; cv=none; b=eskUHmNMd0/1jHxmb8s9e7WLImGoZ5r3Uv+BFAgg2+H/F79nHYL2POPajSwwP8HCP9oqnq0gfavnhNdsGqgbgmCNTgSeJSAn1KVRIxkilo7G2m837SZlAk8OhxgYYHP0vKHptxwsq8xzrw8528P5w0F7biFWONupOne4TJEPjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747168; c=relaxed/simple;
	bh=lwhTLkgORobjR1QcySXuZgt4h6Hake4B7KH7LJ5lPNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4ZpU16j+nNh0pGhCQRNdZbaJTklX8mYvmuthSuRo8FBea1GAgRrM0PmVSVL5u+JY/me+Wgd2TB/e/6le6tRMox6jNBl1B++sIZTEw/3y/Pz5ubS0tWr6M+BHi+N3Ekny9HtyjdvXG9AJIgo9QTlVR8gOHCK28WX2cjBwX1zv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvvGOzef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB7AC116C6;
	Thu,  5 Mar 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772747167;
	bh=lwhTLkgORobjR1QcySXuZgt4h6Hake4B7KH7LJ5lPNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvvGOzefQPWhROLEGhQqV9BQACpUKc5g7i1Z2xFEJkNXNgLV4Pk4pJUvBUhgXJ1yF
	 6m6mvoFo0/4C+07Q49CIMJLQUFqYpSIfaOGY+PoL4K4ejd0o4dy8YssJqHT1SHzoCG
	 CaL5vRd0IsyX9d2VhJX2bheIRpBtSzO+exPXeeM5bwJ6pkTUBEgba1vIl6ORSEFECb
	 SXZYkB9/j8EdS6NtMZQiWFiFDZKe+CboN4O0yHrgzAVjOIJ8e/6MsFSf1ItljaJqlC
	 jgLTiG1G1cMldDBGtdO/bDdOeOZhsDU65U88ouu4QYfX93rCsrs9/1lU193WuEQ+Rt
	 Zd7uQgNhCkKfQ==
Date: Thu, 5 Mar 2026 22:46:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, 
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v4 0/2] fs, audit: Avoid excessive dput/dget in
 audit_context setup and reset paths
Message-ID: <20260305-vorlieben-gefesselt-1673d7845270@brauner>
References: <20260228182757.90528-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jqlkhartfnby3ev3"
Content-Disposition: inline
In-Reply-To: <20260228182757.90528-1-longman@redhat.com>
X-Rspamd-Queue-Id: 82681218942
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79523-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+,5:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--jqlkhartfnby3ev3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 28, 2026 at 01:27:55PM -0500, Waiman Long wrote:
>  v4:
>   - Add ack and review tags
>   - Simplify put_fs_pwd_pool() in patch 1 as suggested by Paul Moore
> 
>  v3:
>   - https://lore.kernel.org/lkml/20260206201918.1988344-1-longman@redhat.com/
> 
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
> 
> This patch series aim to avoid this type of performance regression caused
> by audit by adding a new set of fs_struct helpers to reduce unncessary
> path_get() and path_put() calls and the audit code is modified to use
> these new helpers.

Tbh, the open-coding everywhere is really not very tasteful and makes me
not want to do this at all. Ideally we'd have a better mechanism that
avoids all this new spaghetti in various codepaths.

In it's current form I don't find it palatable. I added a few cleanups
on top that make it at least somewhat ok.

--jqlkhartfnby3ev3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-use-path_equal-in-fs_struct-helpers.patch"

From df813ea26394f5d1d1dac0eb49b18d029c73906a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Mar 2026 22:06:18 +0100
Subject: [PATCH 1/4] fs: use path_equal() in fs_struct helpers

Replace the open-coded dentry/mnt pointer comparison in
put_fs_pwd_pool() with the existing path_equal() helper.

No functional change.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 2 +-
 include/linux/fs_struct.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 43af98e0a10c..ce814b76bde7 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -50,7 +50,7 @@ void set_fs_pwd(struct fs_struct *fs, const struct path *path)
 
 static inline int replace_path(struct path *p, const struct path *old, const struct path *new)
 {
-	if (likely(p->dentry != old->dentry || p->mnt != old->mnt))
+	if (likely(!path_equal(p, old)))
 		return 0;
 	*p = *new;
 	return 1;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index f8cf3b280398..9414a572d8f2 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -57,7 +57,7 @@ static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 {
 	read_seqlock_excl(&fs->seq);
-	if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt)) {
+	if (path_equal(&fs->pwd, pwd)) {
 		fs->pwd_refs++;
 		pwd = NULL;
 	}
-- 
2.47.3


--jqlkhartfnby3ev3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-fs-document-seqlock-usage-in-pwd-pool-APIs.patch"

From cd1f838cec0303780025906dee3c789a4680e402 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Mar 2026 22:06:39 +0100
Subject: [PATCH 2/4] fs: document seqlock usage in pwd pool APIs

Document why get_fs_pwd_pool() and put_fs_pwd_pool() use
read_seqlock_excl() rather than write_seqlock() to modify pwd_refs.

read_seqlock_excl() acquires the writer spinlock without bumping the
sequence counter. This is correct because pwd_refs changes don't affect
the path values that lockless seq readers care about. Using
write_seqlock() would needlessly force retries in concurrent
get_fs_pwd()/get_fs_root() callers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs_struct.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 9414a572d8f2..b88437f04672 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -41,7 +41,15 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
-/* Acquire a pwd reference from the pwd_refs pool, if available */
+/*
+ * Acquire a pwd reference from the pwd_refs pool, if available.
+ *
+ * Uses read_seqlock_excl() (writer spinlock without sequence bump) rather
+ * than write_seqlock() because modifying pwd_refs does not change the path
+ * values that lockless seq readers care about. Bumping the sequence counter
+ * would force unnecessary retries in concurrent get_fs_pwd()/get_fs_root()
+ * callers.
+ */
 static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 {
 	read_seqlock_excl(&fs->seq);
@@ -53,7 +61,7 @@ static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
-/* Release a pwd reference back to the pwd_refs pool, if appropriate */
+/* Release a pwd reference back to the pwd_refs pool, if appropriate. */
 static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 {
 	read_seqlock_excl(&fs->seq);
-- 
2.47.3


--jqlkhartfnby3ev3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-fs-add-drain_fs_pwd_pool-helper.patch"

From 367cb14a4623f0ae35dd13d586eb224cffee7a11 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Mar 2026 22:07:07 +0100
Subject: [PATCH 3/4] fs: add drain_fs_pwd_pool() helper

Add a drain_fs_pwd_pool() function in to encapsulate draining the pwd
reference pool. This keeps the pool implementation details private to
fs_struct code.

Use it in free_fs_struct() and copy_mnt_ns(). The latter previously
manipulated fs->pwd_refs directly from namespace code.

The caller must ensure exclusive access to the fs_struct, either
because fs->users == 1 or the write side of the seqlock is held.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 18 ++++++++++++++----
 fs/namespace.c            | 12 +++++++-----
 include/linux/fs_struct.h |  1 +
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index ce814b76bde7..0a72fb3ea427 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -89,13 +89,23 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 		path_put(old_root);
 }
 
-void free_fs_struct(struct fs_struct *fs)
+/*
+ * Drain extra pwd references from the pool. The caller must ensure
+ * exclusive access to @fs (e.g., fs->users == 1 or under write_seqlock).
+ */
+void drain_fs_pwd_pool(struct fs_struct *fs)
 {
-	int count = fs->pwd_refs + 1;
+	while (fs->pwd_refs) {
+		path_put(&fs->pwd);
+		fs->pwd_refs--;
+	}
+}
 
+void free_fs_struct(struct fs_struct *fs)
+{
 	path_put(&fs->root);
-	while (count--)
-		path_put(&fs->pwd);
+	drain_fs_pwd_pool(fs);
+	path_put(&fs->pwd);
 	kmem_cache_free(fs_cachep, fs);
 }
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 89aef4e81f23..06b856410a01 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4262,11 +4262,13 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	if (new_fs)
 		WARN_ON_ONCE(new_fs->users != 1);
 
-	/* Release the extra pwd references of new_fs, if present. */
-	while (new_fs && new_fs->pwd_refs) {
-		path_put(&new_fs->pwd);
-		new_fs->pwd_refs--;
-	}
+	/*
+	 * Drain the pwd reference pool. The pool must be empty before we
+	 * update new_fs->pwd.mnt below since the pooled references belong
+	 * to the old mount. Safe to access without locking: new_fs->users == 1.
+	 */
+	if (new_fs)
+		drain_fs_pwd_pool(new_fs);
 	p = old;
 	q = new;
 	while (p) {
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index b88437f04672..e67d92f88605 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -23,6 +23,7 @@ extern void set_fs_root(struct fs_struct *, const struct path *);
 extern void set_fs_pwd(struct fs_struct *, const struct path *);
 extern struct fs_struct *copy_fs_struct(struct fs_struct *);
 extern void free_fs_struct(struct fs_struct *);
+extern void drain_fs_pwd_pool(struct fs_struct *);
 extern int unshare_fs_struct(void);
 
 static inline void get_fs_root(struct fs_struct *fs, struct path *root)
-- 
2.47.3


--jqlkhartfnby3ev3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0004-fs-factor-out-get_fs_pwd_pool_locked-for-lock-held-c.patch"

From 8d0fcb0fdde5e29ed01d04d6123df32bc5e325c3 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Mar 2026 22:13:23 +0100
Subject: [PATCH 4/4] fs: factor out get_fs_pwd_pool_locked() for lock-held
 callers

Extract the inner pool borrow logic from get_fs_pwd_pool() into
get_fs_pwd_pool_locked() for callers that already hold fs->seq.

Use it in copy_fs_struct() which open-coded the same pool borrow
pattern under an existing lock hold.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            |  6 +-----
 include/linux/fs_struct.h | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 0a72fb3ea427..e1487ca6256d 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -140,11 +140,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		read_seqlock_excl(&old->seq);
 		fs->root = old->root;
 		path_get(&fs->root);
-		fs->pwd = old->pwd;
-		if (old->pwd_refs)
-			old->pwd_refs--;
-		else
-			path_get(&fs->pwd);
+		get_fs_pwd_pool_locked(old, &fs->pwd);
 		read_sequnlock_excl(&old->seq);
 	}
 	return fs;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index e67d92f88605..b63003cec25f 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -42,6 +42,16 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+/* Borrow a pwd reference from the pool. Caller must hold fs->seq. */
+static inline void get_fs_pwd_pool_locked(struct fs_struct *fs, struct path *pwd)
+{
+	*pwd = fs->pwd;
+	if (fs->pwd_refs)
+		fs->pwd_refs--;
+	else
+		path_get(pwd);
+}
+
 /*
  * Acquire a pwd reference from the pwd_refs pool, if available.
  *
@@ -54,11 +64,7 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pwd)
 {
 	read_seqlock_excl(&fs->seq);
-	*pwd = fs->pwd;
-	if (fs->pwd_refs)
-		fs->pwd_refs--;
-	else
-		path_get(pwd);
+	get_fs_pwd_pool_locked(fs, pwd);
 	read_sequnlock_excl(&fs->seq);
 }
 
-- 
2.47.3


--jqlkhartfnby3ev3--

