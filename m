Return-Path: <linux-fsdevel+bounces-35276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABEC9D3595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AEC2831DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98F1865E5;
	Wed, 20 Nov 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vvcIhFYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B615B115;
	Wed, 20 Nov 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091761; cv=none; b=WFZdXqEowwCHbuQNg5BGPVDZEybRT0NBBpnhk8oFO8Cc+/W+ijaNk5xu7s4IVAgAOSDBCyT6hlgG7KCXGJe5oWYpn1MeB5/WSjvqT/q68q+Ln9BJTZEqf8apl/RQv5ZXUWJqQp48JBNayH7YpybcsYzrxqSCygozjqDC/22ZkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091761; c=relaxed/simple;
	bh=kE6IhiiKo6o/6TfgJ14Z3Ldjqe/ogNLuo3X0pMDSnhg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aH9lKKvfJmlnuYrYX9ViGrV8QaTacl5aYVQJXJDZOPmRwf1QVccciwm2FR18/VkXcMCZikG1iEtuBvAHEUSXclV7ratEIIFvCpeVL/PV9B3xzrJN9SOMxxR8QBIWcl4xZR+IAxKvdErBqTLyjPCv4t3mjpq3NRzpNVHXS9McmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vvcIhFYW; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732091448; bh=1100kT0Cu7ugv7fQWYJ7fK9SOzVRMf+w+Llm8axcO0s=;
	h=From:To:Cc:Subject:Date;
	b=vvcIhFYWrGgUiveP97aqxey4oNspeZAy9knD0AaW/qm3ju6skzh+dYpncQ+2edbCJ
	 Dtp9evCrFW4Ce8dBfbOauTN6A67354muUGbyfWjMfv/gECGL//m1s47nGEXv02JAvI
	 MD87HhDoAWDiovx/f0jhLJKCRoRncuNvEFnfxvYo=
Received: from archlinux-sandisk.localdomain ([218.95.110.191])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 7AE90E8E; Wed, 20 Nov 2024 16:30:46 +0800
X-QQ-mid: xmsmtpt1732091446td8v84zyq
Message-ID: <tencent_F1DBC4D1F22658222170020AC7DB0B4CF405@qq.com>
X-QQ-XMAILINFO: M+EmadCGxmHfzpKMgwfERU/P9gwIzfS+JkcQQA9WvFFDvRwVa6KaWXu+o96woa
	 FCLf65PNOyIYgXMuDJUkD1bKHUY1uk0UiXZ99e1SeisHfRVYl09KOzGhg/fgM7wWYlXD/7Ud0Zyr
	 8cf1ORq3dHRUG5c2z6oImbCDDw3ex4AeEgGq55J471fFFr+fXy9ecGI58U86UQ8zp1bDlEg5+oXo
	 4kTMLsqpr8tLPJrfCSKgXFSPFmOOCGGuQivUrxdktUdVr4ajnhKTGEGyMmfdjp7CcQ2jIhJAbm41
	 MiWgZo9J8HTRQvM3s7iCeXPjE7NOHHEZmkxqj5JQm3cEhboxNoY+0zTiPJWEB8/y4Hu2gimmP0hi
	 UdIm2sRPpPV0sbfPXSKmXFWO07Rm2lQMO1Hio8hBSh/Rpe07KEyNJkmD+K3p5RIr/s8cnXBjqwnF
	 CIP1cpRhWqn6BTadIBQStLPGMdbZQe1lVJLavcFXanOaEmO2HIviWQBXvbiodm1z7OodITWTP3u0
	 TLJG07hSzSkgT8gm9FO0ELpksq6ZqV7NSKJZe4uMnntHa9UU+cGIpNbHBl0qC1jU5xSlG3Skg+ce
	 Yf+xWuXTLXf0cSI9O52aiNZFJFekPPWWvObiRompyh5vuetgbPEJ7NJbJDzo2LdGLKqpTqa5+81l
	 arLTq+NdnjfK3sGfPt5XXbygSM5CrDEA3UapxlrloEO/7EYC2NcNBQ2aQVXwjbPi0f7gYKaj4BJ8
	 tlg2LBLSid0PRhZ6hK9+HXceCnB+IGEXL2TzhD8hlzeuA0h0Ku6eKzz7K2RpdSt/2pOPc+QvzQ8f
	 yX8FjMGdZePs+OidxY+udMCjrKfCP0yk+07jVLd2sh/nyyVQ41xfMRTSanPePh0uZAdgJtW+9bcS
	 YSCIlKstFJttwoj2hE++zYUqv0WEMjGhPB5Cl6AqeVwLMIx8sSmTRN7iOFEjqJ0eQD8/+CCTrRWq
	 MjzmcaYvk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Jiale Yang <295107659@qq.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH 1/2] fs/fuse: Change 'unsigned's to 'unsigned int's.
Date: Wed, 20 Nov 2024 16:30:28 +0800
X-OQ-MSGID: <20241120083029.1944-1-295107659@qq.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer 'unsigned int' to bare 'unsigned', as reported by checkpatch.pl:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 fs/fuse/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81..78d049990 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -37,7 +37,7 @@ static int set_global_limit(const char *val, const struct kernel_param *kp);
 
 unsigned int fuse_max_pages_limit = 256;
 
-unsigned max_user_bgreq;
+unsigned int max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
 		  &max_user_bgreq, 0644);
 __MODULE_PARM_TYPE(max_user_bgreq, "uint");
@@ -45,7 +45,7 @@ MODULE_PARM_DESC(max_user_bgreq,
  "Global limit for the maximum number of backgrounded requests an "
  "unprivileged user can set");
 
-unsigned max_user_congthresh;
+unsigned int max_user_congthresh;
 module_param_call(max_user_congthresh, set_global_limit, param_get_uint,
 		  &max_user_congthresh, 0644);
 __MODULE_PARM_TYPE(max_user_congthresh, "uint");
@@ -1026,7 +1026,7 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_conn_get);
 
-static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
+static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mode)
 {
 	struct fuse_attr attr;
 	memset(&attr, 0, sizeof(attr));
@@ -1201,7 +1201,7 @@ static const struct super_operations fuse_super_operations = {
 	.show_options	= fuse_show_options,
 };
 
-static void sanitize_global_limit(unsigned *limit)
+static void sanitize_global_limit(unsigned int *limit)
 {
 	/*
 	 * The default maximum number of async requests is calculated to consume
@@ -1222,7 +1222,7 @@ static int set_global_limit(const char *val, const struct kernel_param *kp)
 	if (rv)
 		return rv;
 
-	sanitize_global_limit((unsigned *)kp->arg);
+	sanitize_global_limit((unsigned int *)kp->arg);
 
 	return 0;
 }
-- 
2.47.0


