Return-Path: <linux-fsdevel+bounces-28298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF70E969034
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 00:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53CF1C20E66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410918FDBB;
	Mon,  2 Sep 2024 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rvUoE5U/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBA18BBB1;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317752; cv=none; b=ZvViBL2iq0oXF6cOrXKiBTP5xPzEMKGgVDwJV1Spp4oDG0Tf9QsNP2+OyOn0nSW9H4tFAQUGhUYKhO4Gy7KvkZpd6acdSaOTqc5DHJcRYkcRlU0FUv2sgS2ABKVkrQE6jj6q42A2FkxBkK3xCvxz5JihkgedY6gQdltjMDULsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317752; c=relaxed/simple;
	bh=HfmMmzlhxvVvv6xDunJi0FmdjjrCMlwRTGPRHHn+JXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihObTNEEz1880Q2SH1ckhTGNtALpMG4P2O6ldwYxMSljDpWLdWrT/6SRWtNHBdp8z2lfOMCpDVgof46ZE6/gGnTY7KGIxwUfi59Y4eTWdzHzJi1KWLe8Hsb+hpgAfjDg6DFIRtnARAs6XqNzhv2bIDAfHe+ElhAYedADiaYe30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rvUoE5U/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=f1lkFnBhu2A4rfcTTwgMOmoFrMOxofOkPfLVQlrRaOA=; b=rvUoE5U/5H5F4Qjp3s3lJnTsn/
	gzTbW9mJkx6r+0MShBqi3wVhPGdxQrANKTSmWFvZKfVKg9xssWGHCAXlZBGtKQJV1wQJCHk8LbE6+
	NIxBpTIsFfFkg1v3+V/a2uuCXZcl5duORJE3e91+Dz5/fhljpmco9eZJPP7e+pYT+hKekoPCebAH1
	BBiwH+/wuuWQGGDusD2FC70/3WQE2UDEZCbF1f3wGwiS+XRCDJF+IbLjC3fdJhzTOW5889k2ZEN7D
	RAWlAK+yPhDtNhxnXakQ/bI3iM39s0C8slryFhW4nP4TXYhH5RNPPb0b5AWlS2DkGbDQynrzO5CV7
	iWIVDPaQ==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxQ-008VrL-EL; Tue, 03 Sep 2024 00:55:36 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 4/8] unicode: Recreate utf8_parse_version()
Date: Mon,  2 Sep 2024 19:55:06 -0300
Message-ID: <20240902225511.757831-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
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
---
 fs/unicode/utf8-core.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/unicode.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 4966e175ed71..3e8afd637b28 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -240,3 +240,33 @@ bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name)
 	       utf8_validate(dir->i_sb->s_encoding, d_name));
 }
 EXPORT_SYMBOL(utf8_check_strict_name);
+
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
index fb56fb5e686c..724db2cd709d 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -78,4 +78,7 @@ void utf8_unload(struct unicode_map *um);
 
 bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name);
 
+int utf8_parse_version(char *version, unsigned int *maj, unsigned int *min,
+		       unsigned int *rev);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.46.0


