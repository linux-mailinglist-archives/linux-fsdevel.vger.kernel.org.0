Return-Path: <linux-fsdevel+bounces-51384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3984AD6602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E81E7ABDB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2F1F0E2E;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EakZV5ti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A21DED42;
	Thu, 12 Jun 2025 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=Rpi3MRBLAYKM4MiQm28yvWfS2XtS8rUxbAMuPGe1qo0cbOlzQ71WZJJ+kQRnVGuKrmQRWglclBf/xD5ODCMBB3ec8JCBgYfzeRdqk//2n4DYBNLfktAvp3pZLJSnloQ7XbGE1HJJHdVFBPu4tXlejL7NbWBGmw29xRroEF2Z7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=QjOHnh+Yt4PqlcAW+qCq/Kju4E4+I5d/K1Zma3tgC4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKyaOMwBbMcmKaB8mwPW2TodKFIq5B9UwP8DSMGeuwAXgQRBJlIGvnrjYKDs2npY3uu2Fac0NT9/jPbRIAZvUvVlW2rb8ZPpVkCkOFlRhnWD1M+tyrkdH94ORwWecPkFBwra7fD5lGW2SUvlN3i6tdcbd3vvt4edPmkpvJ4nejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EakZV5ti; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3djBL8HHbUGU5RogRIz9x0fhkX7yEbrlgs7bG3UIn04=; b=EakZV5tirFPH3CX27VKuA8QGM5
	aQ2OW9YtZBI1ve4eAg+oIECTCBDLtdtE97AmK4aSjKdoxboC4MCP1vj+LNwcFAp2/xgVAF4q9sffk
	NUXvNiouo5ja1su40o3qKFkI1DM2ZVFEPPyOdPIfSC9WTX4Z3LRdh9K/0q3i8Z0IXf4WfoNbtuRpg
	qFqTMWCIHRJOEVZq2NHWjc1zymBNVLp7Teng0/I9wE/1COsa9NZx6NdNmd0F1wI2LtOCIFVepa0iO
	zel3/4eOktWjy5nl/0UyEAKiupcjPyMgMU89FcRKjmSpwNyoTV21Dqj398bw2921VCf50dMwFYXm2
	jyQclRTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gfC-2th8;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 09/10] ipe: don't bother with removal of files in directory we'll be removing
Date: Thu, 12 Jun 2025 04:11:53 +0100
Message-ID: <20250612031154.2308915-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and use securityfs_remove() instead of securityfs_recursive_remove()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/ipe/fs.c        | 32 ++++++++++++--------------------
 security/ipe/policy_fs.c |  4 ++--
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index f40e50bfd2e7..0bb9468b8026 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -12,11 +12,8 @@
 #include "policy.h"
 #include "audit.h"
 
-static struct dentry *np __ro_after_init;
 static struct dentry *root __ro_after_init;
 struct dentry *policy_root __ro_after_init;
-static struct dentry *audit_node __ro_after_init;
-static struct dentry *enforce_node __ro_after_init;
 
 /**
  * setaudit() - Write handler for the securityfs node, "ipe/success_audit"
@@ -200,27 +197,26 @@ static int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
+	struct dentry *dentry;
 
 	if (!ipe_enabled)
 		return -EOPNOTSUPP;
 
 	root = securityfs_create_dir("ipe", NULL);
-	if (IS_ERR(root)) {
-		rc = PTR_ERR(root);
-		goto err;
-	}
+	if (IS_ERR(root))
+		return PTR_ERR(root);
 
-	audit_node = securityfs_create_file("success_audit", 0600, root,
+	dentry = securityfs_create_file("success_audit", 0600, root,
 					    NULL, &audit_fops);
-	if (IS_ERR(audit_node)) {
-		rc = PTR_ERR(audit_node);
+	if (IS_ERR(dentry)) {
+		rc = PTR_ERR(dentry);
 		goto err;
 	}
 
-	enforce_node = securityfs_create_file("enforce", 0600, root, NULL,
+	dentry = securityfs_create_file("enforce", 0600, root, NULL,
 					      &enforce_fops);
-	if (IS_ERR(enforce_node)) {
-		rc = PTR_ERR(enforce_node);
+	if (IS_ERR(dentry)) {
+		rc = PTR_ERR(dentry);
 		goto err;
 	}
 
@@ -237,18 +233,14 @@ static int __init ipe_init_securityfs(void)
 			goto err;
 	}
 
-	np = securityfs_create_file("new_policy", 0200, root, NULL, &np_fops);
-	if (IS_ERR(np)) {
-		rc = PTR_ERR(np);
+	dentry = securityfs_create_file("new_policy", 0200, root, NULL, &np_fops);
+	if (IS_ERR(dentry)) {
+		rc = PTR_ERR(dentry);
 		goto err;
 	}
 
 	return 0;
 err:
-	securityfs_remove(np);
-	securityfs_remove(policy_root);
-	securityfs_remove(enforce_node);
-	securityfs_remove(audit_node);
 	securityfs_remove(root);
 	return rc;
 }
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index db26032ccbe1..9d92d8a14b13 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -438,7 +438,7 @@ static const struct ipefs_file policy_subdir[] = {
  */
 void ipe_del_policyfs_node(struct ipe_policy *p)
 {
-	securityfs_recursive_remove(p->policyfs);
+	securityfs_remove(p->policyfs);
 	p->policyfs = NULL;
 }
 
@@ -485,6 +485,6 @@ int ipe_new_policyfs_node(struct ipe_policy *p)
 
 	return 0;
 err:
-	securityfs_recursive_remove(policyfs);
+	securityfs_remove(policyfs);
 	return rc;
 }
-- 
2.39.5


