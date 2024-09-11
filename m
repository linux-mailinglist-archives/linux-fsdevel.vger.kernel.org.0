Return-Path: <linux-fsdevel+bounces-29100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045B97565A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EEBB2CF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08A1AB6C5;
	Wed, 11 Sep 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TvzCw0sR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBA1AAE3E;
	Wed, 11 Sep 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065939; cv=none; b=Qda27tGyVcmmAr1t1boCm9VHRd7v6r9r8/3inItXvs8DfgxM/KbWR8Nhthq036+6ExqH2okjHyGFM3oZ7iVkdlw9b5iC6hEVJITBc+u1I3xhpne3T/jjS+js6cLrQo5zOEvM1WrQa/UKIf9u4F0sdATQ+MPqlKovKIhrx6Vwzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065939; c=relaxed/simple;
	bh=JDDkfI5C/SzSPFtrnIr+Hv41Z4nJqWVVuGXk4VwNw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLqJdU0Ojv0ecLHwd232s7xvoCwjwrT8bpHLQ9lf4779OJGFtfNkXobHZ2xpzn9vro1FlGCllOJzqc+LBJfU+GA/0pPEvi72tUyoZHvC6T6UrqeRuoG4E4mY4o6JLmb9UEKAOBt14yZ022RkzBV56m+oRXLmbo1cGTWNKmER+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TvzCw0sR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h3G2XLqID4r09rjc35sdSginc1+HQQOMXWwkAOpIqMQ=; b=TvzCw0sR6HZM4aA4GH3FuRWYVI
	Px1BmzDY56FJAszk+GMHqk6MfhKr9AEhgBV6FEg9nSClLKdbWiQL8W1gw2pGA0XM0I2cafcQTMa2a
	mQImN7F+fHAec/ZSZtxFLaf8Wwxk6UxtKbGW1nWSQb59kGyGHtUL0cDVy7ISICVNfg63Ul2RkokT/
	N4wTFu2Cw67udkHhRhTtzMmsu0D1cV7XEPHq9WhsvDx+fQ9Rk6CGeWlPhh17D7Ca9aXtNgQQZRDn7
	Di0uygBcmjjmwtUXmwrtrGH9LguZ1wuQ6mutHL0QktiGfRSTDSL/LddnC/W4PrlubNkwUJWZ3hW2V
	j8C6emTg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soOap-00CTwi-PH; Wed, 11 Sep 2024 16:45:16 +0200
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
Subject: [PATCH v4 01/10] libfs: Create the helper function generic_ci_validate_strict_name()
Date: Wed, 11 Sep 2024 11:44:53 -0300
Message-ID: <20240911144502.115260-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
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


