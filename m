Return-Path: <linux-fsdevel+bounces-11817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D741185758C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AEA1C225D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C50175BE;
	Fri, 16 Feb 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adjvefP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A114276;
	Fri, 16 Feb 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060622; cv=none; b=jnsSLUovCjm3LA+IxuD0y7gUrZ5+EDraGdHXOSIEOtLr16ijTLvPi0H4s4KeDkk2SP5G9SSCvtEny5X5e98mC4Ndf66IGK/0N355ed1gSBJPwQ1gIuxTyVxXNAno1T3O48pUs8xSfdtY/iTVJIpLK13NLlmddrFbvozav50QO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060622; c=relaxed/simple;
	bh=izgbkU5WdhT8+FcVteMKfJv0K0u6H5vFImXt8AMGQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvP8tPew0zdATAuL0UbTfzElKD03hCPmuiQbrFOpHbrEu6Kvo9lumoxBeedQ9JhB2uvCio3S01UxdPkHpYtK5m2PpNTqHMGw2X0M79sUU5hn20IkOyIeaVXGVmE5BTMiIDNeYoff1DqOP4mGHQFqaksu/vNwuiMEI7mxtMJMpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adjvefP6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708060620; x=1739596620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=izgbkU5WdhT8+FcVteMKfJv0K0u6H5vFImXt8AMGQD8=;
  b=adjvefP6lH7XrJX9ugWiRhGUVAZmldsCkXpanFvPVkMHs4SDenntszkT
   OU14lLyCiHt5owZa/XvpKta2xk3yZ/UHS5tSSsbV/26aD7aikMxo5IOyk
   qI+A50Z6ElMeUJmUrHc2/R9j81WfXrKUOKZ8/J7sMk8e4uP1FUaGHYGLE
   UkqUYBfxXz3aC0O6AV237dO+5T0x9L2T/SVHn0Rq7DDz280BQKPyNExTI
   a4IyzwZ0T60BzSSetm/Sab0L6n0cC2+DVpdDwQzPlqW1DGhkFF9/kqOB4
   ve7S7sfUtCy7hg94SSNLBIq4//KxEsPhYqGY37Q/LVaTJ0h1xy1eix9SA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5149349"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5149349"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4063891"
Received: from lvngo-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.17.186])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
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
Subject: [RFC v3 3/5] cred: Add a light version of override/revert_creds()
Date: Thu, 15 Feb 2024 21:16:38 -0800
Message-ID: <20240216051640.197378-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216051640.197378-1-vinicius.gomes@intel.com>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
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

     guard(cred)(credentials_to_override_and_restore);

or this:

     scoped_guard(cred, credentials_to_override_and_restore) {
             /* with credentials overridden */
     }

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/cred.h | 21 +++++++++++++++++++++
 kernel/cred.c        |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..be1e211d82e0 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -172,6 +172,27 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
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
+DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
+	     revert_creds_light(_T->lock));
+
 /**
  * get_new_cred_many - Get references on a new set of credentials
  * @cred: The new credentials to reference
diff --git a/kernel/cred.c b/kernel/cred.c
index c033a201c808..f95f71e3ac1d 100644
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
2.43.1


