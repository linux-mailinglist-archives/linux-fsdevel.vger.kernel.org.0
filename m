Return-Path: <linux-fsdevel+bounces-60446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE6B46AC7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3981B25A42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F042D7388;
	Sat,  6 Sep 2025 10:10:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412B26CE0A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153457; cv=none; b=LCU+7O84e1ceMDWNR1wl5aytAZ7cw39PoyTZuOiOx035KJ01YAhqRUnaMSYKMqa3Spc+ddWAbkV+//sAjNUnmeEUJlE4incRl4dsOd2I4rEsKue8CklB4bNveRPumKntAj/3HlRIsBDT+SdNRI28/R7/iwFgzcsPEbnOTTF0wZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153457; c=relaxed/simple;
	bh=BNHBBJ2wuvbRikCVzJuBLF8gDoZaLVpAsc67kOm5Y8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AyKAByK4YRWizW6G0GvnkjkvmonCzXE9artGDfzS54O4H7rfbKHPsdWyn+NlqPJw2eAq4z0FI6vBtkV3w/SrCXltlcCccPS22t0hhzCUxUnh4ZaE+NNjgusDq63YaB3zeF7Scm9kWe7vLqMtalgw45mZwEKc4rURm/jPd1AaLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpip2t1757153367t72c9515a
X-QQ-Originating-IP: Kb5eA9yLv8fZSDWo33y4fouj4nthWO3ZcdOHFa+xP2c=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 06 Sep 2025 18:09:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9062404304346425670
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
Subject: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Sat,  6 Sep 2025 18:09:23 +0800
Message-Id: <20250906100923.444243-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: N3IC8um5pMyYoMvUTtJ29M3G4yUktgInCFT+pma/wbzqOBdg74AYWMYj
	dm3VrtQV8Ppg+V9xoGmfKox/Zj3Shvml3/HKsrT0MMYtP86icfAGK8wRZHEzs/NS0EMqz/0
	GBMfSbiXid/+m9kgLoWpyo42zkU8AdueUqZHG4Z3sxqgsR7JIuPBl6rAlZ5c4pkRzApzR/k
	9Bu+6FufZFEYSWOivYbUrK2PNszToxFQqJgs9zB2Klau1NSIoWodD/Zp23dnC35/dkVMWGp
	TLwnQluxehHmawM4cty3KVAWFYyOj4dcqEVCqYhP1M544G4oDSpK7Gc0cvA9TGm4PJUTMqd
	KxjOLIb1+am5Br4LxvJWZ+h/N6VNTo8CO8KoBrsEi9ZHYz6Wl41DRTOcBr/W3KYQaUflcWa
	gQug3lmZBjJk1wOfch4uaRrq/5IVRaJDCuX1j/qW6YVeBgby7WgdmRDOukG0FLHA0NlVQJn
	UKQ9VfiIz6pwog2yo8PgQwrFj+D08Fmf8WHCcZXFKWOvZM4HOC0tZl++lbO8ngpE0H+ubVl
	S8z4ZLMAGsTZGOtM4VeqRhX5Yjm2ylvSUEZvo9fISTdz7C+FIdDd2iFJRZhaODHpgpGptEv
	qo262s5CMvHpiH3hTJBXbURNq3GU3Ed27ehjpCBhC2hCLjf3ZEbyVpwSNnnga6dJPjsWMXw
	88v2vny1/gUOMYijIKDKRfF/PnlKIHAelAq9Veeyk36ossl+bwZi/KLU+a6nnowy5pd136n
	Q7xcxQ0LaynhLvH+0aTAXuQek3o39PClMEa+0+X7bNCfIqyWyvhZ+A0gtjIextotX4c9i2Z
	WQSuegTQ1rJgqg7D7ProBslgJZ7YqxIb353GFcml60/mUdSeYa4SLKoUV6s7R9PCfCyrCDX
	pMiMwdG8IhO4vJSlD/7g5fJVIHI2iMCIt+xS5umEz2kRQK166qaBHwjCo2JRXgNWPPOIUpE
	Cf4q7G5/QYh6n4NXHm8XKugQtPjzD2J1AwUfhK/ozHkLxO0riuK2igj3M
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The previous fix (94458781aee6) was insufficient,
as it did not consider that
sizeof(struct hfsplus_attr_unistr) != sizeof(struct hfsplus_unistr).

Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()")
Signed-off-by: k.chen <k.chen@smail.nju.edu.cn>
---
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
index 18dc3d254d21..9d427cef26f0 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -736,8 +736,10 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
 		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+				    (const struct hfsplus_attr_unistr *)&fd.key
+					    ->attr.key_name,
+				    HFSPLUS_ATTR_MAX_STRLEN, strbuf,
+				    &xattr_name_len)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
-- 
2.34.1


