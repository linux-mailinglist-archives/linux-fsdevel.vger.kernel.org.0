Return-Path: <linux-fsdevel+bounces-10740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44D84DA51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 07:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33391B23743
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34786A02D;
	Thu,  8 Feb 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YLefnevk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B86A02C;
	Thu,  8 Feb 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374724; cv=none; b=bon3uv5CL4Yu22eBoKAXMVtnTn9rDDUJpfhJcLtLjLTI/rZ9WH5bnUbI7GDoGqQbx7+FrALkPdxTINOyInnl6yMs5FqbTzYdGekBAsCGBG6qewfVcksUZU3U5U+qrMvXVu7wLJlNhI/TmIg9nC9MjXl2Di9NEwgNtpfbLMF4aqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374724; c=relaxed/simple;
	bh=dzKZXblpWESFyKaff5lcUS9bN5Ok7BHsB49SOtV2pf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpIDQez3e0MyV2qQxaSK97Fo7TcCI9oJ6+1/envbr11r+5K5Zqi6rSzDDqn2KeM2Nx6LSluMB8rYJNtARElna5kP0RjnOqnRFTKjhAdTKa9MmKXOKTPvTrqfJlHt3IgbyNQW/3lskIMMVaJSTQa6FuTwvN1Bt+uYoDcELftL/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YLefnevk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707374720;
	bh=dzKZXblpWESFyKaff5lcUS9bN5Ok7BHsB49SOtV2pf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLefnevkX12McBubm6n8iAgtkkqHcuSUHXRwwCg4xv5p+x3/OA76gR/Sy9izDrlwA
	 eQCfcsm/M2L1fey/OZ4V3jbXIFyyHuRd5a5rkxfClZ2HKILxe8Ms5j7bblCr/R00BR
	 lNnsG4ywbanfvoCLURrmjz+TRTnXvJ9OSOGlo/b5pDVftSrhYxeK4txDnikr5viC7f
	 O7vgvvJ5UP1DV+wP+pTtr3LWGZZarcAB6MCUbyS4hiTWA6xHEW6BNGhB/lTdXhJZ+Y
	 YtOkANP22Fnv/0fwTvwP+Vuhej0K8oTTuJYjiQvuid6iXi2vdQ+3M6o8LbSJKxAJk6
	 lqYeaoM7gfrWQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8564378045F;
	Thu,  8 Feb 2024 06:45:15 +0000 (UTC)
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
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [RESEND PATCH v9 3/3] f2fs: Reuse generic_ci_match for ci comparisons
Date: Thu,  8 Feb 2024 08:43:34 +0200
Message-Id: <20240208064334.268216-4-eugen.hristev@collabora.com>
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

Now that ci_match is part of libfs, make f2fs reuse it instead of having
a different implementation.

Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c | 58 ++++-----------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f5b65cf36393..7953322b9b9e 100644
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


