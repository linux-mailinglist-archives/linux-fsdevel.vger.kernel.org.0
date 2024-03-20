Return-Path: <linux-fsdevel+bounces-14866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01286880D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AA81F20FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386F38DD7;
	Wed, 20 Mar 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F0cOw+RD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB739AEB;
	Wed, 20 Mar 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924396; cv=none; b=gQ8ZJanOJ8AUgmGziySHQIBzpmofEO7WjOkGljeZwHaJUvZQaMRwmZfFqZ0w23zuuDRLu2q8wTOmC0Pzocc9zyrWbivXU3pxN8a2jW1dCPGI3SyoLYANEm8nwZhInj1xt1sXnWYizzuagzv1OMQ90lc9vRgMgCcsVGAE/VwCWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924396; c=relaxed/simple;
	bh=sSDn7Wfq2OSR5HgXKxsXhUQl5lGRaJDd9ojoG3UQPDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8BNajEXDRMeZWNUw0uPyrKqFtDsHHJmaKHhINrnzpRh+Ps+J/tPUVLuw6fcRFJHBXIsFNvOuZmSyMYAE4Y3R55oHNmG+IkIR62xyDcQKdYbqFuQLwx8Iya56jGlrWzhcvAd2GMuGRMpBDPebU8IIUlIP/Wn6m9RrEOecS/S8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F0cOw+RD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710924392;
	bh=sSDn7Wfq2OSR5HgXKxsXhUQl5lGRaJDd9ojoG3UQPDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0cOw+RDNpHzFlrAomGhWGeSE/cMmKNV2x+hCNGs2lPaez/i0SIqmyq3nlb/6L8w8
	 0K2lKVz8WVDddt72oI+mj5pjgOBpWpPLA1Za9VvBcFUVh5Srvv4DYrO26YrIVpcY0+
	 IYWKRqMtbkMA7WL6rd37V4sOUFmDEUuD0dbB4NGsbBrkadpi3HHEHidkaKK9Ps1nqq
	 vJIg4E8n6mVz4AgvV02YOsq3GGD3QVs46HmtOjKIFH1g3vopsW3BIiLqgHlTecj92d
	 tFlhVlAQmX1ixKatIO2ZImiGD+5f1iUwSAW7jJSQC7S2p+wa0D6OdyUEBVKxwBAYoz
	 fi+iktceTvSFw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1766F37813C4;
	Wed, 20 Mar 2024 08:46:29 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v14 1/9] ext4: Simplify the handling of cached insensitive names
Date: Wed, 20 Mar 2024 10:46:14 +0200
Message-Id: <20240320084622.46643-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320084622.46643-1-eugen.hristev@collabora.com>
References: <20240320084622.46643-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.8-rc3]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..4061d11b9763 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2506,7 +2506,7 @@ struct ext4_filename {
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5e4f65c14dfb..b96983a4c185 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1445,7 +1445,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1455,18 +1456,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return 0;
 	}
 
-	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
-	if (!cf_name->name)
+	buf = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
+	if (!buf)
 		return -ENOMEM;
 
-	len = utf8_casefold(dir->i_sb->s_encoding,
-			    iname, cf_name->name,
-			    EXT4_NAME_LEN);
+	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
 	if (len <= 0) {
-		kfree(cf_name->name);
-		cf_name->name = NULL;
+		kfree(buf);
+		buf = NULL;
 	}
+	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
+
 	if (!IS_ENCRYPTED(dir))
 		return 0;
 
@@ -1503,8 +1504,6 @@ static bool ext4_match(struct inode *parent,
 	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1513,8 +1512,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			return !ext4_ci_compare(parent, &cf, de->name,
-							de->name_len, true);
+			return !ext4_ci_compare(parent, &fname->cf_name,
+						de->name, de->name_len, true);
 		}
 		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
 						de->name_len, false);
-- 
2.34.1


