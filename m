Return-Path: <linux-fsdevel+bounces-51382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FAAD65FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795367AD08E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA31EDA2F;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nWJXW5dJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391EE1DE4FF;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697918; cv=none; b=EWfBfWAJIhyOFVK2HzeZaOqYABFHHmnY5ta34Vk7CqN6zFPTBhajKH0Raqh0AUS4pZ02ioUyfexayXuaMI3RnncYQ00Ss3FdeRJRY//hDWeaCIxxqDl/+Afn8oHGvO8IZo6GDy2dhx2wtyegZgKqF5QEb/s+u1JdfvX3rkJmGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697918; c=relaxed/simple;
	bh=7PPfBlt9WSr2+ZLOhap13gGwXjbj/n8Llxz1mp3DDPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FssxdsAGGLn7ZWiODMdqWjY2ut5qGTWSsBfiKVZScGvK5Yd0FyTG4dFLoRvAF2+IPSiKgF+4QpJFzL7MNq/orW/sillVMhEJEtNQxBYl05HnIyWutMLxlW9rBoNYa4Ap8g25qzi2TPnQvzh62e5JT/ISRXz1yDtqE1bR7QH5rwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nWJXW5dJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l4xg5vbprvPIXYbOxYMiBz+VvreXlUCo+J6ein8ylwA=; b=nWJXW5dJz+uPBZumLTN21WcAp2
	KIAVClKOCHt59y6ieb0eR1PIodSLlv0L4iR5kSnFwGqAag75j9/mUxLEF9tcj0nHEKlST4Exo6Qco
	6knT1nVtiIYR70NFWVS9+pjVbWKRvxf99a7e+8lxEB0yXXngevedvkBO73fIhWaPwTUqxqg68gsWV
	/L1j+FiTvcBbDH4f2pZdcEjjBamcBh4TC/BfOiG7ySnWZ9eBgL6t1SsZacMiB5dee+9/x0PeUhCu8
	Ymrmn+aFQSx4u9AWft1uB5G61enfzcLO73svOtKjhSfYsRE6y78jaQl1GXOAoQ6kYFknMkAxrdi+x
	fJ2wJ2aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gf8-2QVr;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 08/10] evm_secfs: clear securityfs interactions
Date: Thu, 12 Jun 2025 04:11:52 +0100
Message-ID: <20250612031154.2308915-8-viro@zeniv.linux.org.uk>
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

1) creation never returns NULL; error is reported as ERR_PTR()
2) no need to remove file before removing its parent

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/evm/evm_secfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 9b907c2fee60..b0d2aad27850 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -17,7 +17,6 @@
 #include "evm.h"
 
 static struct dentry *evm_dir;
-static struct dentry *evm_init_tpm;
 static struct dentry *evm_symlink;
 
 #ifdef CONFIG_EVM_ADD_XATTRS
@@ -286,7 +285,7 @@ static int evm_init_xattrs(void)
 {
 	evm_xattrs = securityfs_create_file("evm_xattrs", 0660, evm_dir, NULL,
 					    &evm_xattr_ops);
-	if (!evm_xattrs || IS_ERR(evm_xattrs))
+	if (IS_ERR(evm_xattrs))
 		return -EFAULT;
 
 	return 0;
@@ -301,21 +300,22 @@ static int evm_init_xattrs(void)
 int __init evm_init_secfs(void)
 {
 	int error = 0;
+	struct dentry *dentry;
 
 	evm_dir = securityfs_create_dir("evm", integrity_dir);
-	if (!evm_dir || IS_ERR(evm_dir))
+	if (IS_ERR(evm_dir))
 		return -EFAULT;
 
-	evm_init_tpm = securityfs_create_file("evm", 0660,
-					      evm_dir, NULL, &evm_key_ops);
-	if (!evm_init_tpm || IS_ERR(evm_init_tpm)) {
+	dentry = securityfs_create_file("evm", 0660,
+				      evm_dir, NULL, &evm_key_ops);
+	if (IS_ERR(dentry)) {
 		error = -EFAULT;
 		goto out;
 	}
 
 	evm_symlink = securityfs_create_symlink("evm", NULL,
 						"integrity/evm/evm", NULL);
-	if (!evm_symlink || IS_ERR(evm_symlink)) {
+	if (IS_ERR(evm_symlink)) {
 		error = -EFAULT;
 		goto out;
 	}
@@ -328,7 +328,6 @@ int __init evm_init_secfs(void)
 	return 0;
 out:
 	securityfs_remove(evm_symlink);
-	securityfs_remove(evm_init_tpm);
 	securityfs_remove(evm_dir);
 	return error;
 }
-- 
2.39.5


