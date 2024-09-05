Return-Path: <linux-fsdevel+bounces-28775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E096E297
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171F4286406
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C91891BA;
	Thu,  5 Sep 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="llqAOrn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366417B4E5;
	Thu,  5 Sep 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563014; cv=none; b=icMjfLKwBJJKPy3a4SCSGiiBo5rcQxHRPnrsg8liaszhgRAYnPnwqkgl+vZc3CShFH1XkFrVuvr3Qg/bT8dNEHYACGx/XGvFVzpeCAv0voJWVxlcYHXx9ggy6d3hk8EbjDiNfYT4Lu6LQ16ZleJx/rFcsKs1hKogqNg0tHJH4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563014; c=relaxed/simple;
	bh=JDDkfI5C/SzSPFtrnIr+Hv41Z4nJqWVVuGXk4VwNw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kARimN80JPIczCK4CoFIzZz0DALsd0yxCjj5igdRO4bOB+FQVL2GdDOrJf0SCZYSzx+BdIjhmaCNYc8nu6xqPX93j1L7eTIEZPsL7ND2BrOKGV1VJct4LjcJgamy5b7MRmywUv/pFNmXS3XUlsWFFDD4zioJctXsroosLrF/xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=llqAOrn8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h3G2XLqID4r09rjc35sdSginc1+HQQOMXWwkAOpIqMQ=; b=llqAOrn8aL/qw69Wg5Ra8y+wWf
	JLvgMbLeG3fwUBfMqFMmxHUELEAwb/yKdLG0s7cwIM5u4hZ13DlnJ3Ne/o4dwd9YZRgmgi2JzUx0+
	mKs2y/95FRbJkp4LA8WSU3G0MbiWhpFC2f6L2xY58X8km4ymyWjgVdTf3u9W/Cq0WqxPpS3GocjmJ
	8eCWm9E5alS7ndthRRXK2xtzcPfSC3WqQKLufJAK9sr/4gOlF7irUB142rbeNm/5YK4zMYdHz1kPP
	C9UA87nr22EpbXDm1BhI1GM4C1oTQZLhwaxqOIlqOMDyLfo3ZL6DtOZeLTSzJfra76MOjXt/5CRiI
	wQid+hrQ==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlB-00A6Ho-3O; Thu, 05 Sep 2024 21:03:12 +0200
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
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: [PATCH v3 1/9] libfs: Create the helper function generic_ci_validate_strict_name()
Date: Thu,  5 Sep 2024 16:02:44 -0300
Message-ID: <20240905190252.461639-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
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

Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Moved function to libfs and adpated its name
- Wrapped at 72 chars column
- Decomposed the big if (...) to be more clear
---
 fs/libfs.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8aa34870449f..99fb36b48708 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1928,6 +1928,44 @@ int generic_ci_match(const struct inode *parent,
 	return !res;
 }
 EXPORT_SYMBOL(generic_ci_match);
+
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
+bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
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
+EXPORT_SYMBOL(generic_ci_validate_strict_name);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..937142950dfe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3385,6 +3385,7 @@ extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *name,
 			    const struct qstr *folded_name,
 			    const u8 *de_name, u32 de_name_len);
+bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.46.0


