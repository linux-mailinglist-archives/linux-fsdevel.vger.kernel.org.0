Return-Path: <linux-fsdevel+bounces-10739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A484DA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17D01F229B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5369E1F;
	Thu,  8 Feb 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3nAZAaTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC269E11;
	Thu,  8 Feb 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374718; cv=none; b=oO5rgmcxu5AAcmoQAcPPfzTsxNKt6at+6axSfhd8HQZ6HcjXnIls/TYDvs66zu03fT0V/MpVXEU/oEjtEoBKbRNZoAu49qSCRP4zNQ7M3thK+k8H+EKAEH6P/LxlJwjkw06PVRy1y90Xno1Y4jKJUnC7WntCLBxOOUUfWugzvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374718; c=relaxed/simple;
	bh=Hp90mLjR44WCv/VB4t8dflfSiAXrxxn0/qF/zsP/e4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nl3L5gp7FauihUkDWy/FIPLCMbEy3goowSYfJnwlARezsYT9LpZnLdOnjfmluH+2+Xd5hCrnYGhRH0XXlrf5DJFW81KfeAg1Ikc78PIMPH7qvMZIXFogarNRrvfKfAOuMQr4FD8PK7LfX65Z67vKqzYQ0ffY/uRr3eWBxLXIZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3nAZAaTw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707374715;
	bh=Hp90mLjR44WCv/VB4t8dflfSiAXrxxn0/qF/zsP/e4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3nAZAaTwuFf2q5gXCNHeCNCGTmxQ3C/coSm+Lcy/qdtQj0ylbb4TZx4r23V6rJk7g
	 GhKRj7k6zfHnPUTAVVGXboIjVn7QH60EaqnGmZgK6SfH4RV8oSSPqKwUP7HDBSTtIM
	 xm7SIFBppiQV/gBe8VDbHy5DLwlivR5P5763D5Ogy7Hnh63zeTmRFteABDwRcWW/QP
	 /tt8Ah4m3/QQFbNBt9976OmfoExk1efCCHCxb+Jq51cTqy7b5XXAArKm8/TvrqSGgd
	 IVl2iDwDXThXyw7RcAr4mvPPPmZucHd93lGWLP9OcZXVelpAEa2ddbWj8hmzMfA8lJ
	 xbspGvXB+KRrg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E600D3782099;
	Thu,  8 Feb 2024 06:45:10 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [RESEND PATCH v9 2/3] ext4: Reuse generic_ci_match for ci comparisons
Date: Thu,  8 Feb 2024 08:43:33 +0200
Message-Id: <20240208064334.268216-3-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208064334.268216-1-eugen.hristev@collabora.com>
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of reimplementing ext4_match_ci, use the new libfs helper.

It also adds a comment explaining why fname->cf_name.name must be
checked prior to the encryption hash optimization, because that tripped
me before.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 64 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e554c5a62ba9..6e7af8dc4dde 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1390,58 +1390,6 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Test whether a case-insensitive directory entry matches the filename
- * being searched for.  If quick is set, assume the name being looked up
- * is already in the casefolded form.
- *
- * Returns: 0 if the directory entry matches, more than 0 if it
- * doesn't match or less than zero on error.
- */
-static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-			   u8 *de_name, size_t de_name_len, bool quick)
-{
-	const struct super_block *sb = parent->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int ret;
-
-	if (IS_ENCRYPTED(parent)) {
-		const struct fscrypt_str encrypted_name =
-				FSTR_INIT(de_name, de_name_len);
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (ret < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, &entry);
-	else
-		ret = utf8_strncasecmp(um, name, &entry);
-	if (ret < 0) {
-		/* Handle invalid character sequence as either an error
-		 * or as an opaque byte sequence.
-		 */
-		if (sb_has_strict_encoding(sb))
-			ret = -EINVAL;
-		else if (name->len != entry.len)
-			ret = 1;
-		else
-			ret = !!memcmp(name->name, entry.name, entry.len);
-	}
-out:
-	kfree(decrypted_name.name);
-	return ret;
-}
-
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
@@ -1503,20 +1451,35 @@ static bool ext4_match(struct inode *parent,
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
-		if (fname->cf_name.name) {
-			if (IS_ENCRYPTED(parent)) {
-				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
-					fname->hinfo.minor_hash !=
-						EXT4_DIRENT_MINOR_HASH(de)) {
+		int ret;
 
-					return false;
-				}
-			}
-			return !ext4_ci_compare(parent, &fname->cf_name,
-						de->name, de->name_len, true);
+		/*
+		 * Just checking IS_ENCRYPTED(parent) below is not
+		 * sufficient to decide whether one can use the hash for
+		 * skipping the string comparison, because the key might
+		 * have been added right after
+		 * ext4_fname_setup_ci_filename().  In this case, a hash
+		 * mismatch will be a false negative.  Therefore, make
+		 * sure cf_name was properly initialized before
+		 * considering the calculated hash.
+		 */
+		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
+		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
+			return false;
+
+		ret = generic_ci_match(parent, fname->usr_fname,
+				       &fname->cf_name, de->name,
+				       de->name_len);
+		if (ret < 0) {
+			/*
+			 * Treat comparison errors as not a match.  The
+			 * only case where it happens is on a disk
+			 * corruption or ENOMEM.
+			 */
+			return false;
 		}
-		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
-						de->name_len, false);
+		return ret;
 	}
 #endif
 
-- 
2.34.1


