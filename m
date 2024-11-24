Return-Path: <linux-fsdevel+bounces-35679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4D9D761E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BC1B2351F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893720605E;
	Sun, 24 Nov 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIyRePe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B6206045;
	Sun, 24 Nov 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455864; cv=none; b=ncVTPk8m2OdBGGMi9+xdZq2bcGKg/NnX44ae+nma3wfqOlGRw4nTD9Qpk5wbnPHNI2K3ilDSjZC22mKtCupv919waxQusguhly7v3z7gDl4mOrlRZhtDyY0wPjIhUTaM3Hn95etZasWsLtVOf6P1lt3zCB8LZnH/CC2wv8Vin7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455864; c=relaxed/simple;
	bh=SXsN7bKGTvPOcfeUJI9xF57hG44uKIH/DtpNG27lH2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3ckXtCDxuejfzES7i0/hY1M2EbJlrdLl28BrSMq8Wqk0IKBSTbCgZkRfgzeScZuWJQK8Up0ei6ZinGg9ZtDqBMyKykO59JVyZQF7hNPEzcwgC/FSMtZoh/m33a8uhaAOZzHAm2m42Ke9l1JxufLYd/YedycmTMBEDXzT2+bHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIyRePe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CA7C4CED1;
	Sun, 24 Nov 2024 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455864;
	bh=SXsN7bKGTvPOcfeUJI9xF57hG44uKIH/DtpNG27lH2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIyRePe51i3Xetqe60+y439UzXDYXiTtNtX02I8giK2eUHnzHzMQ0FXb7E1dkpOl7
	 bgDTPnSfUqn6wDULPU+71y/3aFzjYYS+A1KjMLlyskzu25zNqmcrblzutOtX9mMLvg
	 Ax2GKEjL149Wlly9bJLfUb3c9BdY2SwD5jfBJJhyGW/m2m5V+DJ74gz1Z8uYTRXs3P
	 2QkoVfN9vh71p/58G9X7T8HcZV665MfdNhMShFb9wOqok6JkFslTzEXdzakXicEWPz
	 dNlXdoH58ax43XZ058wfLrNhfdMaU0RaAbDhlAVh6izjm91T8YBkJwXaUkzl2nLcaW
	 TmECBXE1R+3dA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/26] cred: remove old {override,revert}_creds() helpers
Date: Sun, 24 Nov 2024 14:43:50 +0100
Message-ID: <20241124-work-cred-v1-4-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=brauner@kernel.org; h=from:subject:message-id; bh=SXsN7bKGTvPOcfeUJI9xF57hG44uKIH/DtpNG27lH2g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76858tm3x6hlM9+M8z7XkBnSoVxUtiXve8ZjhvovQ7 1NKjyytO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbin8jwT/l+97YoXqfkW3ft Z784+Ne+aNVZu02P3X/MLUrmcH731Jrhf8a7/aF3Dl3b/rvJ3m1TleYfdrlwh6DfOjETVaxnLTZ 0ZQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

They are now unused.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h |  7 -------
 kernel/cred.c        | 50 --------------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 382768a9707b5c3e6cbd3e8183769e1227a73107..439d7a1840e7ccbc94d814728698a4b383bc39b3 100644
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


