Return-Path: <linux-fsdevel+bounces-31629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C88A9992CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6AB286523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC11E909F;
	Thu, 10 Oct 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DAwZ5BTr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC761E906F;
	Thu, 10 Oct 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589281; cv=none; b=IODYEGXpOQg9kAE5+paOZX/JLrR6vdA1UnueFVwibFC0Vl431SII339kOtkh333QT6n7NwSce04dGEntE9hDw1TUGyQPjzg38SuPDfXD7sixHG8F7JtQOAxuaCJ1DLdYNjQmOsdM4hjEXaee5fCosQat9uae9SJL0jA78CIZ4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589281; c=relaxed/simple;
	bh=vl3JoB/DwEm8nWzjX2Krc1IOE1I7PuBEAMF2rU+Lsac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DctDsdl6Ol89XjXpfOa3p6aCHYxA1sJKgvvytaOw9PyRJnQZPmOWZ480llLpDslNOYsRT7genIg5Q2ubBjPKqlwkZOYg6eS9jK7xDAmzgpGlgcNZHXKXNzicXHHrlqo3xaY12TqcpZozRd/qrQrb0JxeyUWgd32fVKWmLQYiDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DAwZ5BTr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xvtpXgeaP5+3Qey4SeTiBPWN2JmcKdnKWOsB+lrnGJo=; b=DAwZ5BTrIxiW5InqyottPfBJ6H
	GOXT5VcX3s+KAchFmfi/4sOsDev0Nd6Wjml60PP2IP+OqHdXhJsk3obIdbu9VBk5Uo0ud+8+MVW4O
	qQecqteTmktYmhDBsFkHZqESd8rZ3wofZeMJTkXdN4AFjU95K4g3H7rz3YGMqRFj3W8PTPGMtkKHP
	N3Sr7D900/vDB9fM/xwTYhr32dyJiEBcmxx//4MIPAkAN2Dm5A1sT9lL4o0+NDjmbNT62tfUSJVvq
	kaj1lZQkAIhaY2L2XYTzy3A4uck3TW56R9Lu1Rpw+bmoUBUTy032CVfBydcIb0tO2eTES/dkAeyf/
	VGG7orQQ==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2C-007SHz-CH; Thu, 10 Oct 2024 21:41:16 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:39 -0300
Subject: [PATCH v6 04/10] unicode: Recreate utf8_parse_version()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-4-79f0ae02e4c8@igalia.com>
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
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

All filesystems that currently support UTF-8 casefold can fetch the
UTF-8 version from the filesystem metadata stored on disk. They can get
the data stored and directly match it to a integer, so they can skip the
string parsing step, which motivated the removal of this function in the
first place.

However, for tmpfs, the only way to tell the kernel which UTF-8 version
we are about to use is via mount options, using a string. Re-introduce
utf8_parse_version() to be used by tmpfs.

This version differs from the original by skipping the intermediate step
of copying the version string to an auxiliary string before calling
match_token(). This versions calls match_token() in the argument string.
The paramenters are simpler now as well.

utf8_parse_version() was created by 9d53690f0d4 ("unicode: implement
higher level API for string handling") and later removed by 49bd03cc7e9
("unicode: pass a UNICODE_AGE() tripple to utf8_load").

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
Changes from v3:
- Return version on the return value, instead of returning version at
  function args.
---
 fs/unicode/utf8-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/unicode.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 8395066341a437d0c20d6ab49b0a022eac7eec5c..7f7cb14e01ce8aa87d14dffdd767f63a90cf11f7 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -214,3 +214,29 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
+/**
+ * utf8_parse_version - Parse a UTF-8 version number from a string
+ *
+ * @version: input string
+ *
+ * Returns the parsed version on success, negative code on error
+ */
+int utf8_parse_version(char *version)
+{
+	substring_t args[3];
+	unsigned int maj, min, rev;
+	static const struct match_token token[] = {
+		{1, "%d.%d.%d"},
+		{0, NULL}
+	};
+
+	if (match_token(version, token, args) != 1)
+		return -EINVAL;
+
+	if (match_int(&args[0], &maj) || match_int(&args[1], &min) ||
+	    match_int(&args[2], &rev))
+		return -EINVAL;
+
+	return UNICODE_AGE(maj, min, rev);
+}
+EXPORT_SYMBOL(utf8_parse_version);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 0c0ab04e84ee80227f9390ad0498f21a7ab7d34b..5e6b212a2aedab7ebf4363083339f4c5e9b82f8f 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -78,4 +78,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
+int utf8_parse_version(char *version);
+
 #endif /* _LINUX_UNICODE_H */

-- 
2.47.0


