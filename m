Return-Path: <linux-fsdevel+bounces-31625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DF9992BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944FE282153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EB1E4113;
	Thu, 10 Oct 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X8S1N0Lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6231990C1;
	Thu, 10 Oct 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589270; cv=none; b=obKeoEvydOFxS5QPVJ9SqxXU+U8sf5lc/pn5nMX1Jx5cLKLI3URYS8z5kKmL+bUuA3mKlZ6cKGKEual7AUMBRoKFEBdqwenHI9vWx3COw/mH/jxk/bvLu0XFeJgYVEmCH8YLdfAAMDeIJW0yTtu4bmJWBG3J07EKZ+TYF7LY4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589270; c=relaxed/simple;
	bh=YtR4arEv93bAfUU5w6UvpS+A36oozAQtinGMoam9bT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ter62YkgH65DeQqKooC9DRDH5mDxDr+aGqwJT7FvShAtCtc/aRtADtXoPkCz/4bUkgXhQME1k70IEnIBpDH8qZ/Jswm38dido8ft2cR+p0XD/haeW3r0ZxxtWST6IMJkMuKoVhhGwVY/S3A/sKoyadgzp3w1t4KIfZulV8BMrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X8S1N0Lp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NLs7GtCp2W3Q9BJj11jchN0o8DALdgxfm9oDq7oy5Jo=; b=X8S1N0LpSdVrFfoMMTr4JRID9A
	usIaeMrHVxAVjFJBb2AK4GNiyTBV4x5SRhvlw9IFWSL4BXL20ibxP0wBPGsDMx8ZxbzWLLYawSzXl
	n865ySfXiZWFn5xpx0Ar4u6LKyEPTfxffuXC2tCDBUxJTBbNa9ejWANGB3DcMMT6zZDC1R/V1GkzY
	Yhf26hMFiDfuFRbx8qwJYVmOne6p7Fv3cf0Xd8m2C2mbdcIG+OUAJzxmupZco1LmN09TUemRbtxA3
	s+efEWDmAHQISCeBmfL8AXqAgA6lCU0vtAJNAYwyQaQfyTibZKAXpE2UHnops8Ep0fxDa0w93804g
	ne7zyLFA==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz1y-007SHz-LR; Thu, 10 Oct 2024 21:41:02 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:36 -0300
Subject: [PATCH v6 01/10] libfs: Create the helper function
 generic_ci_validate_strict_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-1-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Create a helper function for filesystems do the checks required for
casefold directories and strict encoding.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Inline this function

Changes from v2:
- Moved function to libfs and adpated its name
- Wrapped at 72 chars column
- Decomposed the big if (...) to be more clear
---
 include/linux/fs.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c152c70b7f1f3e0154f6e66a5aba33..9b232aee4cd6ad8dce64370db0111bd25d3fedfa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/unicode.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3456,6 +3457,50 @@ extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *folded_name,
 			    const u8 *de_name, u32 de_name_len);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+/**
+ * generic_ci_validate_strict_name - Check if a given name is suitable
+ * for a directory
+ *
+ * This functions checks if the proposed filename is valid for the
+ * parent directory. That means that only valid UTF-8 filenames will be
+ * accepted for casefold directories from filesystems created with the
+ * strict encoding flag.  That also means that any name will be
+ * accepted for directories that doesn't have casefold enabled, or
+ * aren't being strict with the encoding.
+ *
+ * @dir: inode of the directory where the new file will be created
+ * @name: name of the new file
+ *
+ * Return:
+ * * True if the filename is suitable for this directory. It can be
+ * true if a given name is not suitable for a strict encoding
+ * directory, but the directory being used isn't strict
+ * * False if the filename isn't suitable for this directory. This only
+ * happens when a directory is casefolded and the filesystem is strict
+ * about its encoding.
+ */
+static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+{
+	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
+		return true;
+
+	/*
+	 * A casefold dir must have a encoding set, unless the filesystem
+	 * is corrupted
+	 */
+	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
+		return true;
+
+	return utf8_validate(dir->i_sb->s_encoding, name);
+}
+#else
+static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
+{
+	return true;
+}
+#endif
+
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)

-- 
2.47.0


