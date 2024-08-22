Return-Path: <linux-fsdevel+bounces-26640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37A95AA41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2651F21486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDBE1EB27;
	Thu, 22 Aug 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af5on3lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD1BC46;
	Thu, 22 Aug 2024 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289935; cv=none; b=O2lVTabkDxsLjgF0SV+jlDGDFVMGcXmQNCIS2QDbpsRMRpfXFy7k6vfgAiXby36Ejn80RhUWw/WbdHBoAFgQe4QYEAgeEaQ/2MOuIWmOrGJxPpC+dVLFVLJmOh9BZ99eZikvki6TIMn919/lA7Jj3MFhAjZEn8bkgxKwXipb2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289935; c=relaxed/simple;
	bh=UfnD/vwYhJAG5eeyMGChyi/Mvp0W7sWbhsiXsNf8YOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVtgrkkrnxdH+9VFViKybccF0UoBeGqNifdBX5YMQ4Wn+tpmeW1Nzc502i6ec2+DidR1nHrhVPZPURhgCDw+Iq6xMm6qltdMxLFvwm2M6YzbE8/P3GLq7ei+kOx/yEWuF8krcBFMiNPfM7Pdjk6sZlMq0YYPMTx7x5D6w6b6H7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af5on3lb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289934; x=1755825934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfnD/vwYhJAG5eeyMGChyi/Mvp0W7sWbhsiXsNf8YOk=;
  b=af5on3lb6h1eRWVP86qYOEpSwPqEfRU8ewU3fob7Ur060RB3k7a6esZb
   88BiEIIR3xdGiA7GTdQTULoLLh901gHMgssiWLzpjR+Id1EbH6b11OR8n
   yXvSvTVsxIkVRP1P3jlweQnd/JNIikbSCFxCoK1iktXrTOpOdNTNJjfNy
   iRR20SDPK19Y5iOJixvIHlNFcOsVYwz/qEzQiRAYuTo6YQ7jRv4MZYMCu
   BD+nfvKMfZJl0I6ElKVG3WB4cmOqNRxn22ki1/WOD1ukdatDAbJu3yTc9
   6pLihuefb0YcCqqcyp/a+Wl+wat0ND/nsM91ZtUG8cI3evdQ9D45ZLe/r
   w==;
X-CSE-ConnectionGUID: zTTbIjFDThS8pk8k2dZs+g==
X-CSE-MsgGUID: jma/l9S8Rq6oYkXvFTXhog==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574722"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574722"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: U/zxtZH3Sxawzi2S62cYuQ==
X-CSE-MsgGUID: Cw+QmJQoSQuaebyuzQT6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811017"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
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
Subject: [PATCH v2 01/16] cred: Add a light version of override/revert_creds()
Date: Wed, 21 Aug 2024 18:25:08 -0700
Message-ID: <20240822012523.141846-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
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
2.46.0


