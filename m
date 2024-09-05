Return-Path: <linux-fsdevel+bounces-28778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F029D96E29F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287061C233B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC741A38F5;
	Thu,  5 Sep 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TcaijmN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B618D650;
	Thu,  5 Sep 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563018; cv=none; b=Y/BYc/EkUuBGTw/fiRcBboVlyp5gls6yDxOm1Cl/7hk5vSYopB6zeteTI3Bh0//LDrV55gaH8P0VMbeKCyOpqFvHEPaCnzlxm4P9748DmEaiW7NHBuvoXmE2GSTCxxSOcPNUFkVWX4HPFHMTjDeCu2xMPQkfy2Mv5DSQhOEmJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563018; c=relaxed/simple;
	bh=ksiaxLkhvshrSVdbEgdTEeMtxc2jAfYrInCIWeLRs5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqVQ2I2XYP+l9pm7JIhCLjlezczSdEwUGSkYNB9QLe3fS7y6OJlefzFa35tDQ+WzUYy36/wfKmyBkbKQytsU9GssFo3iA6dt+doWoJbHRu557Du8tFlUVia8ZLfSENwdFZPB57BCDxQA4r0rN5sg39glRO/YDmaGCsOokPFszPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TcaijmN4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tVBWjPD7yJZ2Jv4Hj8dGRTMW1PUSv84Vy9Hq+Ex8cOI=; b=TcaijmN4jyzvbsdVRqO6qPj+vY
	OPY5Nf7mWWGvh5fEp3M1mdqp/qR9GBJ12dJNPwHFu4XeYq99FxVYg1TpbZcwlhAUdHcFclOQsqWRD
	HHCcoITUOXgtdWO+WY4nw+67HVcOpJ2P75SXw/yrbFKwN6xJpKmVTHwKQ4/J13LaQBOF699W3Z8ea
	N6Sne7+xlLjSgWx9A30JetvaDwJZKcSJ1KlGdQkMyuab2UpQzB9L377G4YTy/sxoNXUvZBQddlIA0
	NS06H3r8a9FEIMmAXbYaWkk6fbbnFkEZ41HJX4vodT6lpixEyfuF+KXMg7pXZQ91WxIqyzOkUZOdk
	zvTcfYNw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlJ-00A6Ho-Lf; Thu, 05 Sep 2024 21:03:21 +0200
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
Subject: [PATCH v3 3/9] unicode: Recreate utf8_parse_version()
Date: Thu,  5 Sep 2024 16:02:46 -0300
Message-ID: <20240905190252.461639-4-andrealmeid@igalia.com>
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

utf8_parse_version() was created by 9d53690f0d4 ("unicode: implement
higher level API for string handling") and later removed by 49bd03cc7e9
("unicode: pass a UNICODE_AGE() tripple to utf8_load").

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/unicode/utf8-core.c  | 29 +++++++++++++++++++++++++++++
 include/linux/unicode.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 0400824ef493..2e852075c6d8 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -214,3 +214,32 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
+/**
+ * utf8_parse_version - Parse a UTF-8 version number from a string
+ *
+ * @version: input string
+ * @maj: output major version number
+ * @min: output minor version number
+ * @rev: output minor revision number
+ *
+ * Returns 0 on success, negative code on error
+ */
+int utf8_parse_version(char *version, unsigned int *maj,
+		       unsigned int *min, unsigned int *rev)
+{
+	substring_t args[3];
+	static const struct match_token token[] = {
+		{1, "%d.%d.%d"},
+		{0, NULL}
+	};
+
+	if (match_token(version, token, args) != 1)
+		return -EINVAL;
+
+	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
+	    match_int(&args[2], rev))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(utf8_parse_version);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 4d39e6e11a95..f73a78655588 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -76,4 +76,7 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 struct unicode_map *utf8_load(unsigned int version);
 void utf8_unload(struct unicode_map *um);
 
+int utf8_parse_version(char *version, unsigned int *maj, unsigned int *min,
+		       unsigned int *rev);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.46.0


