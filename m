Return-Path: <linux-fsdevel+bounces-20420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C838D3158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7E1C23BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62517BB0A;
	Wed, 29 May 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="23b4AKpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2016EBFD;
	Wed, 29 May 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971215; cv=none; b=ceLdFN7A9eJsPzecfdy8YJxJXvQV+epzYCxRbGcDeQoUl5beNk4BdrZGUlbZpadhLG6jRavhruK83D79sENBGJznYdyAuPRk1ZUJ8Zj7k/edUV3D5uNq5yNwE+cs0e5WgK+nprZqzUgs47yeJ+z+jEdiZD78qa9q6h2IBlOfOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971215; c=relaxed/simple;
	bh=RaApyMUGWRaAMpiSoFeoKzdLOeZPjYqhNYx85qIghjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmaaaeG8c2WckmOpyDAkW219M+nqzcRWnyHV1n/iYfEQl95ld0T6sxsjanfkLF4ihStJy73Cmm2BGe4B5B0WJblnlxPvqAxZdEXT9z6O3nGmgpTSzPxKaDUSlmsIM6mhOgmG5Qb+RTHvOEqacylqVXmfE8VMrhYcPhdnePBDxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=23b4AKpM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716971212;
	bh=RaApyMUGWRaAMpiSoFeoKzdLOeZPjYqhNYx85qIghjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=23b4AKpMfUa4MKq2wIrIxP6qx/75ESo8YvHmjUrjc8eQY6NZ31OyWpfjyZAis4i2K
	 tVZSB8Z5jfCLGfw9GutWzbZGvbooD5F6gssciVRj1xpbuFI96g3+VttMTnc6lfiTCM
	 KR/wALJsv1B0c8oV+aH+iDd7ZlPe5BjDI5NhgAxiqPVnWy0FRPUReN0/uA6iZLOr86
	 cAePhkHO6GLWVUvD2MzQrZT2UTyY9tgX2LNxpIURqFwbiiAxCRXvQjcbeqRYsp0nXL
	 e/HHVUf5+oaJIT1QUC8nxOcIY+0+xk3HxzFg9rfEze+654m6ADFb2nNHtrPUheyDg3
	 a3t+RZLhwpu1A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E0013782175;
	Wed, 29 May 2024 08:26:51 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiggers@google.com,
	krisman@suse.de,
	kernel@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v17 5/7] f2fs: Reuse generic_ci_match for ci comparisons
Date: Wed, 29 May 2024 11:26:32 +0300
Message-Id: <20240529082634.141286-6-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082634.141286-1-eugen.hristev@collabora.com>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Now that ci_match is part of libfs, make f2fs reuse it instead of having
a different implementation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c | 58 ++++-----------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bdf980e25adb..cbd7a5e96a37 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -185,58 +185,6 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	return f2fs_find_target_dentry(&d, fname, max_slots);
 }
 
-#if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Test whether a case-insensitive directory entry matches the filename
- * being searched for.
- *
- * Returns 1 for a match, 0 for no match, and -errno on an error.
- */
-static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
-			       const u8 *de_name, u32 de_name_len)
-{
-	const struct super_block *sb = dir->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int res;
-
-	if (IS_ENCRYPTED(dir)) {
-		const struct fscrypt_str encrypted_name =
-			FSTR_INIT((u8 *)de_name, de_name_len);
-
-		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
-			return -EINVAL;
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (res < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	res = utf8_strncasecmp_folded(um, name, &entry);
-	/*
-	 * In strict mode, ignore invalid names.  In non-strict mode,
-	 * fall back to treating them as opaque byte sequences.
-	 */
-	if (res < 0 && !sb_has_strict_encoding(sb)) {
-		res = name->len == entry.len &&
-				memcmp(name->name, entry.name, name->len) == 0;
-	} else {
-		/* utf8_strncasecmp_folded returns 0 on match */
-		res = (res == 0);
-	}
-out:
-	kfree(decrypted_name.name);
-	return res;
-}
-#endif /* CONFIG_UNICODE */
-
 static inline int f2fs_match_name(const struct inode *dir,
 				   const struct f2fs_filename *fname,
 				   const u8 *de_name, u32 de_name_len)
@@ -245,8 +193,10 @@ static inline int f2fs_match_name(const struct inode *dir,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (fname->cf_name.name)
-		return f2fs_match_ci_name(dir, &fname->cf_name,
-					  de_name, de_name_len);
+		return generic_ci_match(dir, fname->usr_fname,
+					&fname->cf_name,
+					de_name, de_name_len);
+
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1


