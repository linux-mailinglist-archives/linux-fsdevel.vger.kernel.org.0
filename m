Return-Path: <linux-fsdevel+bounces-33853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548B9BFB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D521C21E28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C1EAFA;
	Thu,  7 Nov 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G78dOpJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3238D515;
	Thu,  7 Nov 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941064; cv=none; b=Pfnh8Mqw+fw7f6hY5VvAHmU3QSt8gz6CjxeZl5cWbow/US8yrsoQFbD0IFpTvxfnIsf863RMAoKaSTvc8PXK5PE1fbBTvcQ+XLQ1VMrULHChyL8NJC5wgVrFxV44/N3Or2MRWgqpJLiz9ZddMr6dz+sgpPykJuMImEfPvz1wo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941064; c=relaxed/simple;
	bh=Wd/qbg0Eyo7dMUuoAAhNI1ZG5Rq7Hpgl5iQzNCWNzk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/vq7tY0Wp+vm+emajsbwws2mH/3eC3y/xalaRUePpI4C+6lth+AXnIi9HpSLxw0iLLtO6akCzGVcnF98h6ZKgFMQZ2ojepgnsFupotIr5CksjnLc+0RO001hxRAIIVrakQPgfJuBtA3FtSUwg1YorMFP2nxKtfB13HJUhB13lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G78dOpJK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941063; x=1762477063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wd/qbg0Eyo7dMUuoAAhNI1ZG5Rq7Hpgl5iQzNCWNzk8=;
  b=G78dOpJKfgCcKkVWWVvz7StR1fk75r5ufqBvpHtfZOYI+kTjqGjD7UlV
   X6EQaHLllV0JsV7JOl8WjMdSZFbJ3Pg1+SaxA9wj9hrLMsvgBiLjCNTMf
   WMByZRBV2BaSTLADATHdPf6jBU1NZ6ySiPsub6lsOXtO2pgnS3O9n/nmM
   AUsc2jMKwVxT3eLbbSWcRFXEFV2iBLzYSCfyuk8FBUKGJg8rTkEr7F2yy
   EVCDGkozsfjEHKey++siiH/SELbWfhUJbVVtwvtnoG4CENE+R7k3NdRSR
   /gh/iH8XwdyK+73mheMD/Cdt//IkOBun6mjTXpiKISPySLxOtHG5vkIhc
   w==;
X-CSE-ConnectionGUID: HoyvKaILTMqgC+OIYoCe6Q==
X-CSE-MsgGUID: rb/HBLl5Q0ejSpsgThwtMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41320183"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41320183"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:42 -0800
X-CSE-ConnectionGUID: BvKh602rSHG+B2y9z+RxzQ==
X-CSE-MsgGUID: 8cuCYh0pTyWFUUDOcdyiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="85193423"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:41 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v4 1/4] cred: Add a light version of override/revert_creds()
Date: Wed,  6 Nov 2024 16:57:17 -0800
Message-ID: <20241107005720.901335-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107005720.901335-1-vinicius.gomes@intel.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a light version of override/revert_creds(), this should only be
used when the credentials in question will outlive the critical
section and the critical section doesn't change the ->usage of the
credentials.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cred.h | 18 ++++++++++++++++++
 kernel/cred.c        |  6 +++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..e4a3155fe409 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -172,6 +172,24 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 					  cred->cap_inheritable));
 }
 
+/*
+ * Override creds without bumping reference count. Caller must ensure
+ * reference remains valid or has taken reference. Almost always not the
+ * interface you want. Use override_creds()/revert_creds() instead.
+ */
+static inline const struct cred *override_creds_light(const struct cred *override_cred)
+{
+	const struct cred *old = current->cred;
+
+	rcu_assign_pointer(current->cred, override_cred);
+	return old;
+}
+
+static inline void revert_creds_light(const struct cred *revert_cred)
+{
+	rcu_assign_pointer(current->cred, revert_cred);
+}
+
 /**
  * get_new_cred_many - Get references on a new set of credentials
  * @cred: The new credentials to reference
diff --git a/kernel/cred.c b/kernel/cred.c
index 075cfa7c896f..da7da250f7c8 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -485,7 +485,7 @@ EXPORT_SYMBOL(abort_creds);
  */
 const struct cred *override_creds(const struct cred *new)
 {
-	const struct cred *old = current->cred;
+	const struct cred *old;
 
 	kdebug("override_creds(%p{%ld})", new,
 	       atomic_long_read(&new->usage));
@@ -499,7 +499,7 @@ const struct cred *override_creds(const struct cred *new)
 	 * visible to other threads under RCU.
 	 */
 	get_new_cred((struct cred *)new);
-	rcu_assign_pointer(current->cred, new);
+	old = override_creds_light(new);
 
 	kdebug("override_creds() = %p{%ld}", old,
 	       atomic_long_read(&old->usage));
@@ -521,7 +521,7 @@ void revert_creds(const struct cred *old)
 	kdebug("revert_creds(%p{%ld})", old,
 	       atomic_long_read(&old->usage));
 
-	rcu_assign_pointer(current->cred, old);
+	revert_creds_light(old);
 	put_cred(override);
 }
 EXPORT_SYMBOL(revert_creds);
-- 
2.47.0


