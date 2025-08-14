Return-Path: <linux-fsdevel+bounces-57931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527FB26D83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D15E52B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518F62F99B6;
	Thu, 14 Aug 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SWkSiOtI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899422E3FA;
	Thu, 14 Aug 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192153; cv=none; b=VusFB7lRf1Rn/OKKsMMNUQ3EpjZAZADYlTxN6FJDm+PENG+xKmOryA+gM5Iv+Za4mNZWbMEcX1wanhhassZOaH9SuZlMnngkDWSyxY1jvZwAxbRUJRoy9+8CQ0nNb3nX+/v4nO3/qfF3wJReNkOr39iOOrG8GtON4psp2DCQyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192153; c=relaxed/simple;
	bh=zUMSvZZxsSce30CLiwfbI9SxOO44ZMnM2rCWzJYgU0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4tZViHaq8ecru5u3/DFosCaAqUqPxTSPcL6Tij9hSyO4V0hAYHmDfB+cg01Mu7xl+DtqhNJ7WttU9gUec6VmNrB6T922nHSWIH5oMGld5Sfq72Vuvuy7oJaXCxueVmpqI8dYN6/Kf9n0k3EslkzsQSP9GwXDFGOGZnmPyAo9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SWkSiOtI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w3pqDhEsZOm3pPQaTteNr5OMNgLblkOmLEwxUidBOwU=; b=SWkSiOtIFs16aM9jKtBHFcG2UF
	VsV7R2pqsCi0Z45ICX4LVEjF/TPWKdDYdDMi5oaNAUAm1DYf7O3kUm6bzhD3KuGk1oFdYJOI1anua
	fUlxHh3CbUIbzz3/KWrV0h241JCNIFqcD8PvgJlH53fB5NmXrEc3O8t8/ucMK2gVoqjiwVyHIELFF
	vZrz6Eu11j66U9zwQG5A3pTCzJ/u282JJeC08Yyk2omz/ZRsAw5qOR0/mZ69CID8kG5pEUwr/hj6z
	be4xezIL6gsI7I+UAiumJGscICtFyP4gNE2sbj2IZO4SznznTO7YJjrYh/4evBREA18WWo4vtwuZF
	HRrTNPuQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbei-00EDyT-65; Thu, 14 Aug 2025 19:22:24 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:12 -0300
Subject: [PATCH v5 1/9] fs: Create sb_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-1-c5b80a909cbd@igalia.com>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Filesystems that need to deal with the super block encoding need to use
a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
not declared otherwise. In order to move this if/endif guards outside of
the filesytem code and make it simpler, create a new function that
returns the s_encoding member of struct super_block if Unicode is
enabled, and return NULL otherwise.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes from v4:
- Move it to the begin of the series

Changes from v3:
- New patch
---
 include/linux/fs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d7051f23246c1a16a2d09b1ffcd2d5de..43b3a7cf6750d3db3e5350908c95bc8a729db41a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3740,15 +3740,20 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qst
 }
 #endif
 
-static inline bool sb_has_encoding(const struct super_block *sb)
+static inline struct unicode_map *sb_encoding(const struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)
-	return !!sb->s_encoding;
+	return sb->s_encoding;
 #else
-	return false;
+	return NULL;
 #endif
 }
 
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+	return !!sb_encoding(sb);
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

-- 
2.50.1


