Return-Path: <linux-fsdevel+bounces-30814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9898E740
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A7D1F24DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EE1A01BF;
	Wed,  2 Oct 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aFc7Mb1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AF199249;
	Wed,  2 Oct 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912717; cv=none; b=rxfcnqu594pAPwkm+kwwgH+5MktbQg4+ZozZaOdZBkcI/j679j2RGqJJzkSMl/CgmNIYDXWwelxqAql7HI2bmpfHs+W4cl1aVrFdb3cMD3riFuBe1XMJE5F0HmEgbi507FSTobA0rQqgvbN89rTEA8395rj2ildn+Vv6bm0nLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912717; c=relaxed/simple;
	bh=XD0655LMXQQE3H7/vJ0Cph68fsRLWyVLDTRgK0rdatk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL1uNFwPo6E39Zsny2GJrEynbuSgSffZdwdl9eruKMlaECdOLPZLl4eVAVt2WWZTly2hN6AfhZym5NvkwLAOGUN9Rk7bUVbvSGRvEtAZ/slZVqKekkJdRg+ohnu0kAbeY2wK7cIeaoUwQj+EOkW6tsEgESYHtXmi4YVP5gpavcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aFc7Mb1H; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y8QDzI/AINMwYgFuy4R/IREoIrpywxbZXblB5AdDFcw=; b=aFc7Mb1HSQlbH0FXXlc1YsbKdF
	OZD65SM+Mo9xLxyEBrZUjzuHCCkRsZcBFJYLdQlKwdRX6nWq0w6esff57g7fqherOH8YuTk/Ost1I
	MI5DF3mAGvO4fodymwddk7xTPROZmALyoPPx4GX8GMtxBfNe6NQnqxLTUICHA3fuLjd14/LosDiAH
	an2uWrZtQFDjpoR+7iy4UR4FQ+0BmINEzIOpELXgGGsF8Pb1kAG/2mPbfUeYlwphCN9FwOpNZp2SY
	g8rT81v0k5CwfMJtLdPaFf6qxEgZIn5jEowDq9ZdmiMlRlCg4j+hhgQHvYsQ/JS8K174GH9+q36lD
	n7m+wA/w==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw91j-0045tc-71; Thu, 03 Oct 2024 01:45:03 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 01/10] libfs: Create the helper function generic_ci_validate_strict_name()
Date: Wed,  2 Oct 2024 20:44:35 -0300
Message-ID: <20241002234444.398367-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index e3c603d01337..9a5d38fc3b67 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/unicode.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3451,6 +3452,50 @@ extern int generic_ci_match(const struct inode *parent,
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
2.46.0


