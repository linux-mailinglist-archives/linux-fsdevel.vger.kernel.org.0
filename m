Return-Path: <linux-fsdevel+bounces-30817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148798E74B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D521C2544E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87B1BFDFC;
	Wed,  2 Oct 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rEN9q944"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FA1A4F1C;
	Wed,  2 Oct 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912727; cv=none; b=rG9Z339uIt5WRayvv7ZOLUJCdrxDevgz3njp5xprdQ7DU8KxnGTbrRa+MKeCZjb8IFQEJLkeclETuYGfMU5km1GZEmX+aC/oNv1mUixwqB6d3l7KPAOSB8DPDLIv1NRhgwp8y68rGVXep0BS7Eax0vJQwcAursCGu21aA8NCkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912727; c=relaxed/simple;
	bh=+kkwFwJnq0dJkV7YDtzBnVifdVhZtRPynXmCviDLHIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsNpg+O8J+Ep1qmQW87rHEzkZ6/posq0lcJmPqCKpykcrwglletrZXjOo2Ghx7xP+FK5YX3uUw+sEvVyg1sn9sBNJEL4G4+Dr1Ef2ALNU+Zgzkqc5sb1e1NNvgmG3cw2ru2IIN0K8cc5BbI5Oj/AZbtXMZCBTRxloZXdVY/GZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rEN9q944; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HCbVqueHUmSSCcT+A2gsLYEdLj0anlbi7vfWbqjQz7g=; b=rEN9q9445fHCa6+Cu5k/ZNfA6l
	rUVf5HN05YiPW6LBeSVDHVW4yadCX1//v6PcFQTA/Mu90qZhR7Kx2QsPMNbrNzyHSUt4N8NcoKeY7
	WDaRV9YyJxmiKIQKzgH4Tqf6xY2PfLxyrL1xu+3E+lHnOktCjoFwrwW0u+T+Dm6IIp3tyD2xekUbA
	ppP90YeCpxXhbXEgPg7bO0JT0sxAzzCV9SfZH9N9JKBfMt7feJ+oUh9ehxpd5ETYEhNy9ULePV+4s
	oCrLHrmwF0ZREkJLY1US/OZkYXFek93sSO42K+dxBJIzW+OHd0L33CVG8dyiqCs0qBtz3j5HTqmPQ
	O0FJJMEQ==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw91w-0045tc-Bz; Thu, 03 Oct 2024 01:45:16 +0200
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
Subject: [PATCH v5 04/10] unicode: Recreate utf8_parse_version()
Date: Wed,  2 Oct 2024 20:44:38 -0300
Message-ID: <20241002234444.398367-5-andrealmeid@igalia.com>
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
index 0c0ab04e84ee..5e6b212a2aed 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -78,4 +78,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
+int utf8_parse_version(char *version);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.46.0


