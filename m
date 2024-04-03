Return-Path: <linux-fsdevel+bounces-15958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D9896264
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D151C221E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655710957;
	Wed,  3 Apr 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS11qlHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0F17729;
	Wed,  3 Apr 2024 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110700; cv=none; b=lnS2uzv3JBLad5SNq2Q32kL8rYIljYPAVx5ZCd0yVkiR8shwCAF5Yj8UvtYoH0sRlb7GW344lzUq10bJDOLzO2LG6iv2vOFT7J4t9rMzIKiAUE8EqKBFi76uZ1GDU1tacelNiRKhDMSQNEmdB4WRO1DIdvjnBTFR+cJ9c7vGzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110700; c=relaxed/simple;
	bh=LfA8lJ/FXjiJM7DYCf6oASjjWQLu6w7WC/cu6Vexpso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gat43AgAtmkaVVgEkoTFWqiDtPosinF8Hewu8nZ3dHCCO/SL9v9w4fiae/FqoKAUnJqxrXen67xMKo+TfWcUgaw3YRDXcVV4SihBB+KKEBeSWCGLMSFc0n/UaSc8UuOPWAlvxqDk7M/AfHVjFwLY7Wzf2BlzKRz4Zu/hqAlYYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS11qlHy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712110699; x=1743646699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LfA8lJ/FXjiJM7DYCf6oASjjWQLu6w7WC/cu6Vexpso=;
  b=lS11qlHyZigDckWgH/Rkgwmzfsem7YdXJrfrDpEo/izMbo0GHOMdFBNP
   aporuaCGEP8DzWxYBxC4//kTlBzydslY4Hp9h3X/gICdF3NSDCFahPWGN
   W4cu+QymS5DO4RE48GRpF2t2BpHBQXios1gJLJCBUGkL92atz1Zi4lari
   RHeaS6bGyaY28jzNuLsb9u7YNZpQlK7CSC6QQZYkDVExf2jDM5MzAEXKg
   emPqIwLpl4O+I+A+TXNskyNQwwtKUtbUX7O5KxiXQufYwPKH3B+QbR3FD
   fprSwkWkEi2qwpOJuJLcRWzQF3gAynCXqVmn4MwWPwVmxGF9W50TS9chN
   g==;
X-CSE-ConnectionGUID: N7H5K3JLSBCa8Sqx3UUcog==
X-CSE-MsgGUID: dS6JJyKPTDyf6uZWSC56Gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7164925"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7164925"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:17 -0700
X-CSE-ConnectionGUID: EklwzNT3TsGCwZqYxOQMNQ==
X-CSE-MsgGUID: zT7qdFF0R5aDb5uqNrfpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55718001"
Received: from unknown (HELO vcostago-mobl3.intel.com) ([10.124.222.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:17 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v1 1/3] cred: Add a light version of override/revert_creds()
Date: Tue,  2 Apr 2024 19:18:06 -0700
Message-ID: <20240403021808.309900-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
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

To make their usage less error prone, introduce cleanup guards to be
used like this:

     cred_guard(credentials_to_override_and_restore);

or this:

     cred_scoped_guard(credentials_to_override_and_restore) {
             /* with credentials overridden */
     }

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cred.h | 25 +++++++++++++++++++++++++
 kernel/cred.c        |  6 +++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..f4f3d55cd6a2 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -172,6 +172,31 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
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
+DEFINE_LOCK_GUARD_1(__cred, struct cred,
+		    _T->lock = (struct cred *)override_creds_light(_T->lock),
+		    revert_creds_light(_T->lock));
+
+#define cred_guard(_cred) guard(__cred)(((struct cred *)_cred))
+#define cred_scoped_guard(_cred) scoped_guard(__cred, ((struct cred *)_cred))
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
2.44.0


