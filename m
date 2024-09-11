Return-Path: <linux-fsdevel+bounces-29103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5479755E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740181C22840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A41AC448;
	Wed, 11 Sep 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mL80uITq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291791AB536;
	Wed, 11 Sep 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065942; cv=none; b=gxRhGu2NpWkRIOmo7sBi/uKRw1kYCcsNuCzDnqGRs9hUL3WbFPVl+76rQF5gAf51iMFGQ3DvsSp2vG1lxzWwtkbuHYmNBgBwqEfXmaTZodYJc8jtrYPG1JuWM4KjjWd9WqGQ8FL4GRY7OEFTvl8cOmKuQ5JJE6OxsGeY5PNh4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065942; c=relaxed/simple;
	bh=xj4gbEvuGuSc9wGpnsVfvK1OkBraHXynbeiYyQAAspI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgdT0Y2D7IiE2z7HKY/hhowp7eJF07mJrJ0InfWBg2k7Vkld3RrWj6oWE1l0EXRKvd+AD8wtazQPR5TqjUO2V4WAs0I9F3iYFvMZvCWBUcav63ZCxueaiTJ9oar1FZDoS+W6w0IGWOr/VGqXKEhgN1FG26QxIQcTTWRhTIu3XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mL80uITq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WN3J9Ey5243Buto3KVkQAnNnAuXnNzeuNPoBKu1Uxzk=; b=mL80uITqrstdF/YOk+k9aSonku
	pXo5DDt06puEPHzWWm9fxQlUUhbeyg1ua0cn56u0HI5O0R2+eVN3TMcCfmpONscPwSMntpWPX+52K
	jT+CxL9RyLFn4NI0o3CNt/2y9revtz7hXPKfb7sD54PF/d2PJOcjE/oUxmbFbuirS1uxn5vrHN8gU
	tLXxQ8L/rc57Kf+IpTunNBFBtWr3rp88g10exMPPRHM0bYkPLh3DhC6NgDEeefO3LdsDZT7uw1tbp
	31DW/eEiPk1KLMosg20VA+XJpE3X598rr/3orHXs0/woYyja/KIVxOQ3dPtyVOlXtTh185I5y92tx
	f2LiS5cA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soOay-00CTwi-8f; Wed, 11 Sep 2024 16:45:24 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 03/10] unicode: Recreate utf8_parse_version()
Date: Wed, 11 Sep 2024 11:44:55 -0300
Message-ID: <20240911144502.115260-4-andrealmeid@igalia.com>
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
---
Changes from v3:
- Return version on the return value, instead of returning version at
  function args.
---
 fs/unicode/utf8-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/unicode.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 0400824ef493..6fc9ab8667e6 100644
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
index 4d39e6e11a95..12face04c763 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -76,4 +76,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
+int utf8_parse_version(char *version);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.46.0


