Return-Path: <linux-fsdevel+bounces-32270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBD9A2F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E5D2857FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAEE1EE03D;
	Thu, 17 Oct 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kxKSNa9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6801EE020;
	Thu, 17 Oct 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199693; cv=none; b=g1U7emRoOUx5kOVLFdKtMBNYAas1T8E3ZPH4mfAlfKwJLLYCY0vNUxUdxnO7oURDuDh2yTQd2za0SNo0eaRS6k2MzPu4vdD0WpaNxFflfbg8MPrLlab7tQgBsPUPirsuI0Iu7uPppGP3evB/RCOHNFVJ5+/RfRQVQadxA+F3URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199693; c=relaxed/simple;
	bh=84cSCRSgBLxOKFp9MGnsefKREdR9l96jowDjaXAXuM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UX7PHvLczGalUVze3c5aTsv3cYAyAk1aM15FpfRTgTWO6ekMWGRY/s7zwpA9zrheSlnRzefkVQJP9jUhykzYnZV5sDFHWKa6gJrVk/deBN8o5XiztNeIYYOJMJfjqvV7Wg6Y9UmWZxt19QQTsbrZN2NcbmPyKS1w9fWKq9Y08mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kxKSNa9s; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8dI7Vp/FrIA/hgTEdP08qCKbl15yNUWf7v4zv+kdBu4=; b=kxKSNa9s+2zS7JilNTuBJKTUIo
	vqm9cP3VwpRLKFNNiR6MWrQhE0x+mSO83pzF6h6ysRxOcjHNi7tt3uKXUtMWNFOk39CGBhe7Mgz5U
	7NJQVPC/3ji8Es8CM1a1v0DBIrk7QNpITYFz3LhtuxeA49L3FoeVwg0zpzt5UHbSDMoQ75pGW9Rjd
	h7GWU4yYl/22lulvtIoRF4te3vFgzUvEadAPGUmzOzhAvYwe2SzKNs3gAuXbG6eYGyKRFPKqrhqRO
	B3v2F0X5bEIkjE+lIeh67RsnhggJP5ldnf2fJwbdtKzf8eQY7FbzrrSdAbEEh9jvJ5cWX/bXbbZcV
	KYnRyO6A==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1XpV-00Bnlc-Bl; Thu, 17 Oct 2024 23:14:45 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:11 -0300
Subject: [PATCH v7 1/9] libfs: Create the helper function
 generic_ci_validate_strict_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-1-a9c056f8391f@igalia.com>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
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
Changes from v6:
- Correctly negate utf8_validate() return

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
index 3559446279c152c70b7f1f3e0154f6e66a5aba33..403ee5d54c60a0a97e2eba9ef80d8fb4bbd2288f 100644
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
+	return !utf8_validate(dir->i_sb->s_encoding, name);
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


