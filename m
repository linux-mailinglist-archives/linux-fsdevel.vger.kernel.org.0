Return-Path: <linux-fsdevel+bounces-60881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA46B527F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7351A6878C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0BD2417C6;
	Thu, 11 Sep 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="njs3UAn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20748145A05;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567137; cv=none; b=iN2g8cZdiLNIL/1DJeUx9ueZKwwvLAIrfT8oPpb3d02YU/8x6m/pC2GR86v8XewjF7nO391DRZ2llf5nijhP/CJcrhSTT9veNzvV2EIXzxudNDDwzpnBlbTFzrwgIpB1d9m233OQeswevfV8CvTTIgi/BTxGS9GViRd6N/9sAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567137; c=relaxed/simple;
	bh=7NGqP4+RUKmreQjOxp24zR6XrvYzXzjZ1wLFODE+hWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoDmVcojN1coGSE8qhUOXZ6X8CML3+l8dY1JkdaUHdI5Jbr9NB1+aXLgRMUFy2rRy1Se6Pgwma34w9plEbOs1VV+H2TaiKqQ+iXjDETqeNSmi5DBdU6K4LNf3VHDjqvrhY7DLa1OzTmXjOX2/bCl2pSw4Yg5kXzEuTBCJdBawmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=njs3UAn8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fXPkdoI0IIiDiSA5DW81mcVIRUHTu8B54NYp6DbPQRw=; b=njs3UAn8PtYWLVhrJM1jvarKGM
	0WfS32IxaGYXSqK6A5YQeWgsporMavKFbuA+HdWaPqK14V5/5y3IYovMhsG6rsaeqAn5PUcZehMcb
	CElPCkhT2QMEY3TE0KS789JpXC7AqWz9+bapf+lsN9QfdINjaeUzSTOfJUmydeYp9qwVs3b8vKs+y
	m7PJpGcLShW9ZlA+Wd8ysyt7hDRTLpki+9eE1Un0uH9SfRyA3WsGMaLxPoKhaqoWY+oeN5ChXHGNm
	5N7/2eujneeSki7BncvtEjq7EvRFwqmJu2yfYb3mUeIY9Lw6z7ufPFwF2SCfKoWWVa89+H3sy0Oe9
	+OFcEQ+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV0-0000000D4k8-2amc;
	Thu, 11 Sep 2025 05:05:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 1/6] security_dentry_init_security(): constify qstr argument
Date: Thu, 11 Sep 2025 06:05:29 +0100
Message-ID: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050149.GW31600@ZenIV>
References: <20250911050149.GW31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Nothing outside of fs/dcache.c has any business modifying
dentry names; passing &dentry->d_name as an argument should
have that argument declared as a const pointer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 security/smack/smack_lsm.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fd11fffdd3c3..aa4d6ec9c98b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -85,7 +85,7 @@ LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
 	 int mode, const struct qstr *name, const char **xattr_name,
 	 struct lsm_context *cp)
 LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
-	 struct qstr *name, const struct cred *old, struct cred *new)
+	 const struct qstr *name, const struct cred *old, struct cred *new)
 
 #ifdef CONFIG_SECURITY_PATH
 LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index 521bcb5b9717..3f694d3ebd70 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -391,7 +391,7 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const char **xattr_name,
 				  struct lsm_context *lsmcxt);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
-					struct qstr *name,
+					const struct qstr *name,
 					const struct cred *old,
 					struct cred *new);
 int security_path_notify(const struct path *path, u64 mask,
@@ -871,7 +871,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
 }
 
 static inline int security_dentry_create_files_as(struct dentry *dentry,
-						  int mode, struct qstr *name,
+						  int mode, const struct qstr *name,
 						  const struct cred *old,
 						  struct cred *new)
 {
diff --git a/security/security.c b/security/security.c
index ad163f06bf7a..db2d75be87cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(security_dentry_init_security);
  * Return: Returns 0 on success, error on failure.
  */
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
-				    struct qstr *name,
+				    const struct qstr *name,
 				    const struct cred *old, struct cred *new)
 {
 	return call_int_hook(dentry_create_files_as, dentry, mode,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..58ce49954206 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2901,7 +2901,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-					  struct qstr *name,
+					  const struct qstr *name,
 					  const struct cred *old,
 					  struct cred *new)
 {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..5caa372ffbf3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4908,7 +4908,7 @@ static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
 }
 
 static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
-					struct qstr *name,
+					const struct qstr *name,
 					const struct cred *old,
 					struct cred *new)
 {
-- 
2.47.2


