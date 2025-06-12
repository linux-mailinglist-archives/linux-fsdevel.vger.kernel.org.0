Return-Path: <linux-fsdevel+bounces-51390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29903AD660B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3218E3ACCD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF091FBCB1;
	Thu, 12 Jun 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aRm2msyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1ED1DDC1B;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697920; cv=none; b=RYaa2ByoFfy1ytfsKkwEf2flt/nyeSHD2ZEAWcLXqU2L90f5kQ9hjZ+xOvwnP3vwvJIBsRIDultBb50C03YsKDsurMU28VEpgdOCQr6oSj7p2jGBN76+EC4nNek8sqNipoaLRosHvGgXNUrfJEDRxLXnF7EoTy/QBf2+MbYO1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697920; c=relaxed/simple;
	bh=RpBt7G8UMT8cBL1bpUy64BEQSdksoaRYKd4Dis2oXVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkoL63kG+v0v36RCu6OBZy1HeAFJOvL8D9Vx+iKXFctoTreluU4NrD2PWdLYueiMzpvMXH7/XPN03O2UiXJZxcB+lsFJhcWT16BchoB+1RZ45RFTUYe8+GatvAd+8e19k8P9pn5rbXm2TrMXCQBrP38bxOsUSpF0ztHI/TwT2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aRm2msyw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4LvPHOEpM+pAb08p/VgZZBblKknsXF/euiji+ptj9wc=; b=aRm2msywatEwP5NAsFER+/3GrW
	WhUNrBcfcq9TfprWp/UfKZ0lb+UR4ejQ359V2CtWyrLHy6gXlx/17NAR30o7m4kzQmlBOMthSG7Lm
	COWfJ/INa1y/AO5ywQ6CF7ed8uBa7dIYgo4vUnpbxVeTLKdHp1jvAW+dOpPxjvI6GksLkSWCs/y7s
	YenQHcIFice7Qah5Bp59XVHkIXBsfHCbezhGciWkvntimbEPsp7kT8sTobn5vb4XAu5ZkDoW6LmGk
	2aNjtiZsADsyMEYUWTSMIkBgJ8GuFykbFmRRTTcLyxQLlKdyAt9uYlUQilLOhy/gg6H2hVqFVuNCk
	rHMaEQ2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gen-0EyR;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 02/10] securityfs: pin filesystem only for objects directly in root
Date: Thu, 12 Jun 2025 04:11:46 +0100
Message-ID: <20250612031154.2308915-2-viro@zeniv.linux.org.uk>
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

Nothing on securityfs ever changes parents, so we don't need
to pin the internal mount if it's already pinned for parent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 93460eab8216..1ecb8859c272 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -112,18 +112,20 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
+	bool pinned = false;
 
 	if (!(mode & S_IFMT))
 		mode = (mode & S_IALLUGO) | S_IFREG;
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
-
-	if (!parent)
+	if (!parent) {
+		error = simple_pin_fs(&fs_type, &mount, &mount_count);
+		if (error)
+			return ERR_PTR(error);
+		pinned = true;
 		parent = mount->mnt_root;
+	}
 
 	dir = d_inode(parent);
 
@@ -167,7 +169,8 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (pinned)
+		simple_release_fs(&mount, &mount_count);
 	return dentry;
 }
 
@@ -307,13 +310,15 @@ void securityfs_remove(struct dentry *dentry)
 			simple_unlink(dir, dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (dir == dir->i_sb->s_root->d_inode)
+		simple_release_fs(&mount, &mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 static void remove_one(struct dentry *victim)
 {
-	simple_release_fs(&mount, &mount_count);
+	if (victim->d_parent == victim->d_sb->s_root)
+		simple_release_fs(&mount, &mount_count);
 }
 
 /**
-- 
2.39.5


