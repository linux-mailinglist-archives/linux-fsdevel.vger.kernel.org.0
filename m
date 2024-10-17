Return-Path: <linux-fsdevel+bounces-32274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD7B9A2F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B275E28610E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CF1F428D;
	Thu, 17 Oct 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ch/ina8f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D441EE02C;
	Thu, 17 Oct 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199706; cv=none; b=diU8FPsgUPgzOQre/rEZPJErhMn/ylqHSvWPDcFaELdFNJHnG52wB+s4wbd5yBjrPJuizDGtnurYGhB1Q6c/JviIYLFH3tCEBcmrfdGKcWix31rkxqTfikYgcUWcxiKiPFesVDZ3Vv22xwED7dxboQe3ituST5Vm2+qFGXKBAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199706; c=relaxed/simple;
	bh=vl3JoB/DwEm8nWzjX2Krc1IOE1I7PuBEAMF2rU+Lsac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0yo0z4ciccRJ9V8aXqRindD8hHoqD/fHnEMeM3tXjS38456i58rsIRsRJjgTmu7Rsp3aT7pu8W/+qOQkZnF+F5TeiIgDq+jJitbLH90zkbDlew0XOyB03TBKiJeo7ZCcmqvo72ayyNWfOnY4u6DnR36AoP3qujmwZ9vQUlJQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ch/ina8f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xvtpXgeaP5+3Qey4SeTiBPWN2JmcKdnKWOsB+lrnGJo=; b=Ch/ina8fAml8InT0NVCX2DBY8h
	pa6eegyvu0qxYudH8yTysmj3p4gd31TtL9/xp3NxbgchJT+eo+GlC9YBVP3ABWpiH+glVwMbz65Cw
	xbelbkrCShVcpQluewnb3W2K1rRHvwayLGRPJCRV+41KO7Ia8Iy+SAdastYYvqgFwPcnswfaD6owN
	7RgtrPBiqAdTnTaJQ/rAqvgXL3Yiy8W1Ym1HQJfsF8M3JpjFFrx6Lwd6e4WS9l/ydo7HHxqaErBbb
	BACW6ehubHrqCdeucIisxBtMssjQBfeHg9rNV8elevORxoa9M4yqSdFdtLyG0+11Bh7F4qP+UMK/g
	ZMN4WwbA==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Xpj-00Bnlc-Cp; Thu, 17 Oct 2024 23:14:59 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:14 -0300
Subject: [PATCH v7 4/9] unicode: Recreate utf8_parse_version()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-4-a9c056f8391f@igalia.com>
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


