Return-Path: <linux-fsdevel+bounces-61736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF68B59844
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3DA7AC1A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF632F75A;
	Tue, 16 Sep 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r9JqvVPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E831DDB6;
	Tue, 16 Sep 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030814; cv=none; b=HUdpbgtx5LUu+BKPUEfVcq+wuVpRf+PNML1w6u7Ymbu4s9nKIM6gmqh0nKOSaAYBxPGLUI4ifVTe2L49E1umPlhLBSPgqu3zCoSKQfljlYW4jxludy6rZfXI14/d2Tf46hblsT5bhMZ7jcgB0xWsW7+9ZF+DLvVKMZFORkkJZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030814; c=relaxed/simple;
	bh=SMGSmx2pqz5voqtJR3czA7f6GuqUU80n5EtyBj5q9GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueQH+TLPshvKeXNPjog6AJFuvmlHrqVl2WT95nsTKE7a0SxDTMSc/vpKp1viNktnX24aFWsS4daXwJatwNYFrw8OacDLL6sNy7xlCfuW1CXAr014JkOdDet7Gm17ExrgEzWST1luMTYR/DKR0hPUTBNI1F6RtI85oIYu3axKLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r9JqvVPe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UQ81DTt4EOw7u3fHJtPSWfenc7ZBjC0pxzgeRhwqK8s=; b=r9JqvVPelk/d/5P9WhRXm+04BY
	gJZRiyTQ7xxLDnaqW5VerHOoJmegcYCuv0dZcsBJPy1oIPozt8nUPFMbN/SI3VuZrO4+LYTgmsyU4
	8d/Rmb3JcyvK4b5ex5KJBxEaHYwSbAboR6+ai/aPvoncC2sCGCyb+hgSEN57+s7xLM38bOuUpL+OG
	39gbMmarhc7dv38RZkOxWmf+u8xDu0LzEv99laqLFtL9runillJqNg6+h075NXUz82EY/y9Pdjv86
	ZkjEU6qrtOMdMDOPe3F5oKP2E2BJ0BPs9nN+D27LzzUxkvUZ3uZvhaoXv9SXkLGiB+SaWNfVbE4HL
	l5fl0PTA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyW7S-00CH0p-59; Tue, 16 Sep 2025 15:53:18 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v6 1/4] dcache: export shrink_dentry_list() and add new helper d_dispose_if_unused()
Date: Tue, 16 Sep 2025 14:53:07 +0100
Message-ID: <20250916135310.51177-2-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
References: <20250916135310.51177-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add and export a new helper d_dispose_if_unused() which is simply a wrapper
around to_shrink_list(), to add an entry to a dispose list if it's not used
anymore.

Also export shrink_dentry_list() to kill all dentries in a dispose list.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/dcache.c            | 18 ++++++++++++------
 include/linux/dcache.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..3adefe05583c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1086,6 +1086,15 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	return de;
 }
 
+void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
+{
+	spin_lock(&dentry->d_lock);
+	if (!dentry->d_lockref.count)
+		to_shrink_list(dentry, dispose);
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL(d_dispose_if_unused);
+
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
@@ -1096,12 +1105,8 @@ void d_prune_aliases(struct inode *inode)
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
-		spin_lock(&dentry->d_lock);
-		if (!dentry->d_lockref.count)
-			to_shrink_list(dentry, &dispose);
-		spin_unlock(&dentry->d_lock);
-	}
+	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias)
+		d_dispose_if_unused(dentry, &dispose);
 	spin_unlock(&inode->i_lock);
 	shrink_dentry_list(&dispose);
 }
@@ -1141,6 +1146,7 @@ void shrink_dentry_list(struct list_head *list)
 		shrink_kill(dentry);
 	}
 }
+EXPORT_SYMBOL(shrink_dentry_list);
 
 static enum lru_status dentry_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..4ef41a5debdc 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -265,6 +265,8 @@ extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
+extern void d_dispose_if_unused(struct dentry *, struct list_head *);
+extern void shrink_dentry_list(struct list_head *);
 
 extern struct dentry *d_find_alias_rcu(struct inode *);
 

