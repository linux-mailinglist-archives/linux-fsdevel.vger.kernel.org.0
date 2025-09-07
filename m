Return-Path: <linux-fsdevel+bounces-60456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C99AB47869
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 03:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64331B212BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1C1E86E;
	Sun,  7 Sep 2025 01:10:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AD315D4E
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757207415; cv=none; b=UlBb8x8FBF/4JBgI1/TXUAb2wSbavVkKkSCz6hsNSQAGw5znRoGFfl9v9Hkc4OXtZgoXGBti3SpnVSUaGKlYUkHUoC6H9V0I4/fqzkW9pziqH5qKRLtyD+u4uq9XDfUEi6xhQo3bGYTTBDnhXdwV/fyhptuK36LS1EBHLHcdW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757207415; c=relaxed/simple;
	bh=3Sab/iVZVD4cjlstY0giMmGHPJWcSSlbZfVHFX8fmCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgdS3P+kG3wtc//v3d6A14rdg8miBOhHQuyUZnruOK6Ldwfx6QsGppYrRMJxJ1o6szREmV6PeAaooUBE8md7Zt8SHT4V44NM47JYrvWe1P03QBzX3CZJoPNQqszKJiJB8Fw+6M2tdjgS+V2Ls+En/G+zpYAys0k8iTkYXJ49Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpip4t1757207324t9a02a4e6
X-QQ-Originating-IP: 4U+XYzl+57OdhLM81bdfFZIyNbj5G57Pai+x9mv7gVI=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 07 Sep 2025 09:08:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1840866798938098571
EX-QQ-RecipientCnt: 8
From: "k.chen" <k.chen@smail.nju.edu.cn>
To: security@kernel.org
Cc: slava@dubeyko.com,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	wenzhi.wang@uwaterloo.ca,
	liushixin2@huawei.com,
	"k.chen" <k.chen@smail.nju.edu.cn>
Subject: [SECURITY] [PATCH V2] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Sun,  7 Sep 2025 09:08:26 +0800
Message-Id: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MSyoPQEuxKCu7ICUlQwfLiUaz+gRHhIcTp7q4L1+zmMNCplK9iSruwrj
	+ziVBLCz5rMjGvDPgicy23q0jdbS65LSYY9q1SVHzE7FQtMCLX9UPpknHWMLTFvBYg4+/wd
	/bIboqn1jGPcpi2SyRZG/I9MVtczj4847MY24glq2fmqwstDme2nuRTbNI5zTszyD5MnKhp
	RIfwsr/qWGYm3M2NN3ImWzqnYu/e4leIpf6YQ6lSLQ3qrOkkPU8O3BK/7muHPXcHFva6XvU
	HCU8aCfrDib8AERzSMuxBg0XDZxQZk6RSOwbAYwAZvnUFP2jhpo7P4GJJttQ06DcrnDNCWJ
	sSGQ4jThlkO4OgNWYn1iJiY6tJU/FDobiit7V6g6R4HmKnT5290FbH3FjqZv5jauryn1hLl
	No5ej6dHENg42GfBfxxI6lij+wFkpvuhulnCVHpQLjc5kZTue+1gPda2nlyOtidl7hLFLWX
	OZJXKHCFbj9gzoUXYsujzGJvnzVTAuX9XWVOwQWG+PTD2pln/PQkY975JaBzDyWDJyZ0qnx
	gxwEfW1G/afGgGi7i5Ti5xiEFWXv2jWsVK1iKa1w+KwPsgFN/laQSXFfS/JkRx7pu1kvuF0
	Et+xBaWgFEImXdB1XRZFy/IlDFqknCCmkTRZgCywcxqewktIvTmKC0ifoFLNIAZE+lT30ko
	x2BfzU8aRWFTaPNII5RKIVQ7tKCBL7y8Pe5fk3ZdXy4bbvIRLWkDzzhIfV4ZuMv8Rm5+5B6
	xL4z/SgxDDWFJO4JoNLfPsGx3+MhjWSiqur7hACmOpk3PcB/SGb8FQlwmLrfh1TBU4Hm3zL
	+P+QXGOIwVyYO4QRKh86qrdUJvhTd8zB4GPda4ZoDYvw8hZ8fMzM3b9Rwj62yori9qJMaYm
	CHGxX0cPpYVR+MQyTF7llPuR6HqQxsgD5nKA7Cy0fZochReYCtEq9sDBEhEmf6BTk8m7OlP
	3Kbhzmzd6exF2+9YDNtQHyMQs1ANsmtOE8PkMeeO5TmB2XIOREqcnRwcm
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The previous fix (94458781aee6) was insufficient,
as it did not consider that
sizeof(struct hfsplus_attr_unistr) != sizeof(struct hfsplus_unistr).

Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()")
Signed-off-by: k.chen <k.chen@smail.nju.edu.cn>
---
V2 -> V1: change struct pointer type to pass compiler

 fs/hfsplus/dir.c        | 3 ++-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 fs/hfsplus/unicode.c    | 9 ++++-----
 fs/hfsplus/xattr.c      | 6 ++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 876bbb80fb4d..765627fc5ebe 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -204,7 +204,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			fd.entrylength);
 		type = be16_to_cpu(entry.type);
 		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
-		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
+		err = hfsplus_uni2asc(sb, &fd.key->cat.name, HFSPLUS_MAX_STRLEN,
+				      strbuf, &len);
 		if (err)
 			goto out;
 		if (type == HFSPLUS_FOLDER) {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 96a5c24813dd..49d97c46fd0a 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -522,7 +522,7 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 		   const struct hfsplus_unistr *s2);
 int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
-		    char *astr, int *len_p);
+		    int max_unistr_len, char *astr, int *len_p);
 int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 		    int max_unistr_len, const char *astr, int len);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..b4303785ba1e 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -119,9 +119,8 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
 	return NULL;
 }
 
-int hfsplus_uni2asc(struct super_block *sb,
-		const struct hfsplus_unistr *ustr,
-		char *astr, int *len_p)
+int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
+		    int max_unistr_len, char *astr, int *len_p)
 {
 	const hfsplus_unichr *ip;
 	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
@@ -134,8 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 	ip = ustr->unicode;
 
 	ustrlen = be16_to_cpu(ustr->length);
-	if (ustrlen > HFSPLUS_MAX_STRLEN) {
-		ustrlen = HFSPLUS_MAX_STRLEN;
+	if (ustrlen > max_unistr_len) {
+		ustrlen = max_unistr_len;
 		pr_err("invalid length %u has been corrected to %d\n",
 			be16_to_cpu(ustr->length), ustrlen);
 	}
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 18dc3d254d21..456c7d6b2356 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -736,8 +736,10 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
 		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+				    (const struct hfsplus_unistr *)&fd.key->attr
+					    .key_name,
+				    HFSPLUS_ATTR_MAX_STRLEN, strbuf,
+				    &xattr_name_len)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
-- 
2.34.1


