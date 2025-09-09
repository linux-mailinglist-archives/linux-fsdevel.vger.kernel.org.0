Return-Path: <linux-fsdevel+bounces-60607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E0B49FCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 05:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E503B553B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 03:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DF25A338;
	Tue,  9 Sep 2025 03:14:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94C258ED1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387659; cv=none; b=KWB6MTWQ2GuT3zNKRd2HxlmN3lco70UqFAqfXauELuqUD1fhn8mBHpcaCzO7n3KMmX4/848lMDOq2o3GGC8572q9L8xBt/RaNwkz/VKErjX4Jz7DbFptYVtbHbIUnkZ1E6b36OmJMVd3tuwQA7oze5szPwSB+IRPfkezXauOims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387659; c=relaxed/simple;
	bh=8HA/xT+GkX/KmPWaOZ7L+04e2y7IM1bCyx6xNZDT0uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xwd5uNe59QwRLAY7t1iZMakPef6STkhcHp46Ji1J2wIU7yq9PoCdsgcgiUMnkPWHCCgONLToq0l2zCJiqdcJUFRTVbcjl2mm5jdqAmbwKlNcx2keLenrQumzUmAjsyk1QYMJYaeUsspUkwlkxH1wHY9UF9wqexzEC5HMSG+HH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpip2t1757387598t7fc4a947
X-QQ-Originating-IP: c/z1xN2YGYjLJtliHbU8HcWBCKdngLZbIjLkTMYHPOg=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 11:13:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9996025316314895138
EX-QQ-RecipientCnt: 8
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: k.chen@smail.nju.edu.cn
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	liushixin2@huawei.com,
	security@kernel.org,
	slava@dubeyko.com,
	wenzhi.wang@uwaterloo.ca
Subject: [SECURITY] [PATCH V3] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Tue,  9 Sep 2025 11:13:16 +0800
Message-Id: <20250909031316.1647094-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
References: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nt+z/y60tPnU96Y59SqShXlOtYfm0acJEDJX0w8osppeWzIC7Fft6kh6
	ZPRhiFZ9MUTGQ06zuxk9H2O77E89EjWL8qwnVHCJ8KtN0f6ek6qj3U8T4qbjvvJdMmB45xe
	axMDRaTMzq9EZ1FjEpNU9UeI4eXofOeNMJ85gAE5ugHMppNrBKhSSuekx5fWGWH0roa/MAM
	s9XbuuNjhoIQmjI7qUwyF+F3oEYgrR+Vy3iCQAjZ0b9+bg0Vq74z9bP2/WYxsrYLLnTLTkx
	5C+D2Aacun+rzt8+CvT0yCAcB4bxcj79yO4rqhWnLQvwuD9G8V4/vTgQA5ZvdOG66junv2r
	QWztty5d/OIypyAiR+SsYBxVpy7E7rGZ9pFEgH4I12NjBX8u4Qr7uSapVaHP10Auk5XlChg
	2KlwtoY1Cfn6TfVQvij/PJZPXtomcPOVfYHxGqEnVFIAgCp0m9UMMMXYx0s/Rr/ZrkoKWgC
	o52KL83wY3f2Fp4tR58C+TsTJi29cWLCW54+DvI85de8r/H87DiE0I8NEUfzQho97FAsq2f
	lC7R0UMm3dvOCa8qcsvlK72VvOLO00dYTbp0ugbVEHrq6hS5lY4UW7CuQPTfTXnlpXFIHMS
	WkUh5T+Wt7y8uQbK1gwNtklFGJeOfm13XFlnASMmPWky/P1rmyaPK2bCJ4JFpUoGfRcirXy
	hLykKCsvpbJVGEPtqhhlsqTfvZbEXRbN8UYkF41T7zH8dKUqyaY5LOESlKXRzaVsYvi21mf
	ZaRlx5XlWVPjQGHBYy8tCZ9NJCNK+ObdvcElnKwWKVzMFdjz8w+fE5ampkLLw0FSQZH4QY5
	dPcJkoIkHA/LqlUceXhMvAWBLg7LZNmGEH3T9SkbExUPTIAd4ATDGI5if3WL+zf3Cz9nbCS
	4tESQ7puM7+CtQ03xRucJ0+69SKpaYtLGe8oGBQA5i19a0yCFwiRycZ3uRbrbxjaC9p3GKk
	rMbTUYjCinYNHSEkiKs+03z+2AW1Xu+vf0zdfy4PiBgdNGefw8MWtuTGqnLxDZ3xmEtozqM
	WuPUtXJw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0xa71/0xb90 fs/hfsplus/unicode.c:186
Read of size 2 at addr ffff8880289ef218 by task syz.6.248/14290

CPU: 0 UID: 0 PID: 14290 Comm: syz.6.248 Not tainted 6.16.4 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x5f0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 hfsplus_uni2asc+0xa71/0xb90 fs/hfsplus/unicode.c:186
 hfsplus_listxattr+0x5b6/0xbd0 fs/hfsplus/xattr.c:738
 vfs_listxattr+0xbe/0x140 fs/xattr.c:493
 listxattr+0xee/0x190 fs/xattr.c:924
 filename_listxattr fs/xattr.c:958 [inline]
 path_listxattrat+0x143/0x360 fs/xattr.c:988
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0e9fae16d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0eae67f98 EFLAGS: 00000246 ORIG_RAX: 00000000000000c3
RAX: ffffffffffffffda RBX: 00007fe0ea205fa0 RCX: 00007fe0e9fae16d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000000
RBP: 00007fe0ea0480f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe0ea206038 R14: 00007fe0ea205fa0 R15: 00007fe0eae48000
 </TASK>

Allocated by task 14290:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4333 [inline]
 __kmalloc_noprof+0x219/0x540 mm/slub.c:4345
 kmalloc_noprof include/linux/slab.h:909 [inline]
 hfsplus_find_init+0x95/0x1f0 fs/hfsplus/bfind.c:21
 hfsplus_listxattr+0x331/0xbd0 fs/hfsplus/xattr.c:697
 vfs_listxattr+0xbe/0x140 fs/xattr.c:493
 listxattr+0xee/0x190 fs/xattr.c:924
 filename_listxattr fs/xattr.c:958 [inline]
 path_listxattrat+0x143/0x360 fs/xattr.c:988
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

When hfsplus_uni2asc is called from hfsplus_listxattr,
it actually passes in a struct hfsplus_attr_unistr*.
The size of the corresponding structure is different from that of hfsplus_unistr,
so the previous fix (94458781aee6) is insufficient.
The pointer on the unicode buffer is still going beyond the allocated memory.

This patch introduces two warpper functions hfsplus_uni2asc_xattr_str and
hfsplus_uni2asc_str to process two unicode buffers,
struct hfsplus_attr_unistr* and struct hfsplus_unistr* respectively.
When ustrlen value is bigger than the allocated memory size,
the ustrlen value is limited to an safe size.

Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
V2 -> V1: change struct pointer type to pass compiler
V3 -> V2: complete the commit message and use two warpper functions

 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  8 ++++++--
 fs/hfsplus/unicode.c    | 24 +++++++++++++++++++-----
 fs/hfsplus/xattr.c      |  6 +++---
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 876bbb80fb4d..1b3e27a0d5e0 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -204,7 +204,7 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			fd.entrylength);
 		type = be16_to_cpu(entry.type);
 		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
-		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
+		err = hfsplus_uni2asc_str(sb, &fd.key->cat.name, strbuf, &len);
 		if (err)
 			goto out;
 		if (type == HFSPLUS_FOLDER) {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 96a5c24813dd..2311e4be4e86 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -521,8 +521,12 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 		       const struct hfsplus_unistr *s2);
 int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 		   const struct hfsplus_unistr *s2);
-int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
-		    char *astr, int *len_p);
+int hfsplus_uni2asc_str(struct super_block *sb,
+			const struct hfsplus_unistr *ustr, char *astr,
+			int *len_p);
+int hfsplus_uni2asc_xattr_str(struct super_block *sb,
+			      const struct hfsplus_attr_unistr *ustr,
+			      char *astr, int *len_p);
 int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 		    int max_unistr_len, const char *astr, int len);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..862ba27f1628 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -119,9 +119,8 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
 	return NULL;
 }
 
-int hfsplus_uni2asc(struct super_block *sb,
-		const struct hfsplus_unistr *ustr,
-		char *astr, int *len_p)
+static int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
+		    int max_len, char *astr, int *len_p)
 {
 	const hfsplus_unichr *ip;
 	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
@@ -134,8 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 	ip = ustr->unicode;
 
 	ustrlen = be16_to_cpu(ustr->length);
-	if (ustrlen > HFSPLUS_MAX_STRLEN) {
-		ustrlen = HFSPLUS_MAX_STRLEN;
+	if (ustrlen > max_len) {
+		ustrlen = max_len;
 		pr_err("invalid length %u has been corrected to %d\n",
 			be16_to_cpu(ustr->length), ustrlen);
 	}
@@ -256,6 +255,21 @@ int hfsplus_uni2asc(struct super_block *sb,
 	return res;
 }
 
+inline int hfsplus_uni2asc_str(struct super_block *sb,
+			       const struct hfsplus_unistr *ustr, char *astr,
+			       int *len_p)
+{
+	return hfsplus_uni2asc(sb, ustr, HFSPLUS_MAX_STRLEN, astr, len_p);
+}
+
+inline int hfsplus_uni2asc_xattr_str(struct super_block *sb,
+				     const struct hfsplus_attr_unistr *ustr,
+				     char *astr, int *len_p)
+{
+	return hfsplus_uni2asc(sb, (const struct hfsplus_unistr *)ustr,
+			       HFSPLUS_ATTR_MAX_STRLEN, astr, len_p);
+}
+
 /*
  * Convert one or more ASCII characters into a single unicode character.
  * Returns the number of ASCII characters corresponding to the unicode char.
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 18dc3d254d21..c951fa9835aa 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -735,9 +735,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
-		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+		if (hfsplus_uni2asc_xattr_str(inode->i_sb,
+					      &fd.key->attr.key_name, strbuf,
+					      &xattr_name_len)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
-- 
2.34.1


