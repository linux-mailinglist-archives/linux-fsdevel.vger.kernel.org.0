Return-Path: <linux-fsdevel+bounces-33694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0B9BD5F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772B61C21019
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BC212637;
	Tue,  5 Nov 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSeZ58OX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91420D50E;
	Tue,  5 Nov 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835339; cv=none; b=Q3lR3d5qCs9TyDlHLB2T0dXdMYvZDdkuUuJGxC5nf6R4LqVg1//MYOREmk20X4LkuoXDKpznlyvJMpvaG/z2T2fgOt2/oRIsYRXeRANuMuPAyRFYTsotpZvuruSakRv1RvaCY+wqAMQQd2ZmGWkUm8QOnFL2BRJvHBNZawRbsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835339; c=relaxed/simple;
	bh=Wd/qbg0Eyo7dMUuoAAhNI1ZG5Rq7Hpgl5iQzNCWNzk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taWumDKlMfHaak+mfV6wTmg0keApdpPDeQj8pAdevopQqJ23fZyEV0rtxrNQAcrGBTUTRnRJP4cmqYNtluvLaGu1r/NSGWmgyzEnD0wyfCadTQiWJnjad7e4i+R02TAppm7oAcpUJiWMvqi1coo0MceHcqNJS1FhGxelEGRZoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSeZ58OX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730835338; x=1762371338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wd/qbg0Eyo7dMUuoAAhNI1ZG5Rq7Hpgl5iQzNCWNzk8=;
  b=DSeZ58OX52vcXqR6PeOsA0Bzxqom8aZiT61Lpl1hMupEE08J2CR0L1Z+
   S64+Uk5Jwv6BZ4fQZ1/DDA4AVj35nU/jS2uYfzjlBymZFQcaAOIcutlLa
   8v2FqXRSp8oyOWfwmCSk34BKQqjDXbxcwVUS3TxwzFliVH5UWdiuRR0Hu
   r2vzPA/5i2/RGi8JXQPtkASWy4Q04G1OPwxZSnSoOguvD3eq4G54AbHlf
   YR9bDtr/9MDdC9NUPRBB2Y5p/b2TWMbkqGBRdNFyYXdExbNmV6nsf3QEW
   QUDbEu5bqBbdTqkTZIUvkj9C+nmUMNPfDh8cGcKL/oSsl8X9ndAW/WePO
   g==;
X-CSE-ConnectionGUID: VfJ6v/uHRLOoEzUJbJTEtA==
X-CSE-MsgGUID: CGliTk4sS+meZaDecjGw5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34297816"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34297816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:36 -0800
X-CSE-ConnectionGUID: QUA0b7r4TAWT/jobsa+zoA==
X-CSE-MsgGUID: fCwZRBx3S9Sl16xNj9nH3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="114939394"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.124.221.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:35 -0800
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
Subject: [PATCH overlayfs-next v3 1/4] cred: Add a light version of override/revert_creds()
Date: Tue,  5 Nov 2024 11:35:11 -0800
Message-ID: <20241105193514.828616-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105193514.828616-1-vinicius.gomes@intel.com>
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
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


