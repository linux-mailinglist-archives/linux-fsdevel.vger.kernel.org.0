Return-Path: <linux-fsdevel+bounces-35801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCED9D8825
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5BB3B79F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C01B393C;
	Mon, 25 Nov 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE7pou1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC61B3920;
	Mon, 25 Nov 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543830; cv=none; b=U43QBdMdqKhhA0zJsSIWS7oiFjTLSqiv0nMoNDkeQFyjpDpot2ZBdgUfbd2PmSKj0YEepxl0LHXPc/b19Dqs+eZ2r8JpNhA/FpXg8aRVHZkAwg/fAAH9GJ+dEf3lX2t0B1iOKRtaoddMAlqmMqB0O3sEuqn2pTCtoXlOx7VuS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543830; c=relaxed/simple;
	bh=UPw9aWgrIHIPegnUJkzvYBHKcE4XQB+Pw79Qimn96uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdglYPu2RJR3r2spIinUblRYVv8i9UrBfzhU4sS3dDmKgPGucUHZgJSVN71WdgNLR/O2z7ewUUkf8gfXw1y7xYamOTJ8S3NauRN0iOXGnd2oECbFENpx2yqBloyohS0BdY1FcVumCzx99BRpxp6CyHbAxAS/NMlJm9mk9ua42Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE7pou1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9641EC4CECF;
	Mon, 25 Nov 2024 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543830;
	bh=UPw9aWgrIHIPegnUJkzvYBHKcE4XQB+Pw79Qimn96uA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eE7pou1TJvRZwglU9X1raZEgxJ4N8eYrIRAWx8haxEXfGCFJ7nit/HTxn2UdNQHyK
	 FziPqKUwyTn1LEhyZQQvjKkGzhDDhGxCesnasjLCpoF4sIDEE9RVHbq5BmjqqFHTce
	 4a3aX2hCD6PSnE9/513ImmFQLpVYgFt2+j5ZVTghzVfPU1WLK3J8hjyPk64TssdhTc
	 cwhLgGUnb3Ar2fz3FehcqAkoGZeCIy/6qwxIA9+6xOySh9aNo5gLMXJvSi0VBujhwa
	 pF29uzCpNa2beIzwgyC2EG1KUJnaUBaWAyzZ8UyceMXWtVSsY5KHlrpZlXlwPPeWQo
	 WgOPHwJKWJzTg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:00 +0100
Subject: [PATCH v2 04/29] cred: remove old {override,revert}_creds()
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-4-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UPw9aWgrIHIPegnUJkzvYBHKcE4XQB+Pw79Qimn96uA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrMs2PjFK7Z/un73V3OXdsid26Tr9Ca9ebZ9Q92k
 TPzVjAzdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykoZrhf+i82tQn3EUeVSeC
 T7G7uJ1wLnoXMT95JbvjvygjM5cGA4a/0kHRTza9eTDrpBPrZg4Rv63lcRa3k76Vf2a9+SvFNuI
 MMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They are now unused.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h |  7 -------
 kernel/cred.c        | 50 --------------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 57cf0256ea292b6c981238573658094649c4757a..80dcc18ef6e402a3a30e2dc965e6c85eb9f27ee3 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -155,8 +155,6 @@ extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
-extern const struct cred *override_creds(const struct cred *);
-extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int set_security_override(struct cred *, u32);
 extern int set_security_override_from_ctx(struct cred *, const char *);
@@ -172,11 +170,6 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 					  cred->cap_inheritable));
 }
 
-/*
- * Override creds without bumping reference count. Caller must ensure
- * reference remains valid or has taken reference. Almost always not the
- * interface you want. Use override_creds()/revert_creds() instead.
- */
 static inline const struct cred *override_creds_light(const struct cred *override_cred)
 {
 	const struct cred *old = current->cred;
diff --git a/kernel/cred.c b/kernel/cred.c
index da7da250f7c8b5ad91feb938f1e949c5ccb4914b..9676965c0981a01121757b2d904785c1a59e885f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -476,56 +476,6 @@ void abort_creds(struct cred *new)
 }
 EXPORT_SYMBOL(abort_creds);
 
-/**
- * override_creds - Override the current process's subjective credentials
- * @new: The credentials to be assigned
- *
- * Install a set of temporary override subjective credentials on the current
- * process, returning the old set for later reversion.
- */
-const struct cred *override_creds(const struct cred *new)
-{
-	const struct cred *old;
-
-	kdebug("override_creds(%p{%ld})", new,
-	       atomic_long_read(&new->usage));
-
-	/*
-	 * NOTE! This uses 'get_new_cred()' rather than 'get_cred()'.
-	 *
-	 * That means that we do not clear the 'non_rcu' flag, since
-	 * we are only installing the cred into the thread-synchronous
-	 * '->cred' pointer, not the '->real_cred' pointer that is
-	 * visible to other threads under RCU.
-	 */
-	get_new_cred((struct cred *)new);
-	old = override_creds_light(new);
-
-	kdebug("override_creds() = %p{%ld}", old,
-	       atomic_long_read(&old->usage));
-	return old;
-}
-EXPORT_SYMBOL(override_creds);
-
-/**
- * revert_creds - Revert a temporary subjective credentials override
- * @old: The credentials to be restored
- *
- * Revert a temporary set of override subjective credentials to an old set,
- * discarding the override set.
- */
-void revert_creds(const struct cred *old)
-{
-	const struct cred *override = current->cred;
-
-	kdebug("revert_creds(%p{%ld})", old,
-	       atomic_long_read(&old->usage));
-
-	revert_creds_light(old);
-	put_cred(override);
-}
-EXPORT_SYMBOL(revert_creds);
-
 /**
  * cred_fscmp - Compare two credentials with respect to filesystem access.
  * @a: The first credential

-- 
2.45.2


