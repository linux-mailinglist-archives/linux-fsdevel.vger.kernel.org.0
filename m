Return-Path: <linux-fsdevel+bounces-76507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPHCBt08hWlY+gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:59:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F5F8C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A731301725A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F21F4181;
	Fri,  6 Feb 2026 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="F31i4m9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB361A23A6
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770339544; cv=none; b=C0dCozCCdLfAHQxtcf1tCML/ZmXJJ6SjouAdX3374KrUiWAKRMPl3HEAsagvHiGlu96AfWd93OVeG/ya5+GBGnQ8h5HDlcKzNoE2ny+9b2mgNQGby5OFc4ReDvU29zfodDDPZ/s230pSVGAY1PmxfizzD+7lvh9AjAmDNAo18Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770339544; c=relaxed/simple;
	bh=ZDU317g5GAq9kvSjDMk+t7qlAB0oXms+LdA1thglsAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c5ntomY9vjIdplGHB/DeDSwUXefHXDYrs8fQD+DhJ5QgTVz7YRmvlAPI2GLObyfWGYdZLrXqJmhl7U0FUwCZmAwWeeKtyZbnOwlZL/9XfxoSG6WarwkBiXV9bYgbqmiAib1fUXMWrx5S9o0Ob5tXTk1ctTyGD4VgNFETBrL1VVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=F31i4m9O; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1770339543;
	bh=vJ2S4n+s94Fr7zM4B1DDMY6JoytNxiHt7LqmMoL4wI4=;
	h=From:Subject:Date:Message-Id;
	b=F31i4m9O4WTB7/uXPREDYbjrwGKxVScP/+7BrcCvjTxYmUKI9lWXW2Kqy9IO/LHRC
	 w+Fr8Am6Glc/XSkHQOm6vLRDY58hKgMkmUXXFYUL0mI1MzFU+Ivkrn3EVSeoYpNZBc
	 /4bWFIWDlcmxAH3hb2AV8/S2QYa7Dxg/bypFjGhQ=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.23) with ESMTP
	id 69853C4200004A9D; Fri, 6 Feb 2026 08:56:36 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 2469458912931
X-SMAIL-UIID: 4BF725AD640D4F4FB0FE55EF7AB45E6A-20260206-085636-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	k.chen@smail.nju.edu.cn
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	sashal@kernel.org,
	yang.chenzhi@vivo.com,
	frank.li@vivo.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	liushixin2@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5.15.y] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Date: Fri,  6 Feb 2026 08:56:33 +0800
Message-Id: <20260206005633.3165225-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-76507-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[sina.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,nju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.cn:email,sina.cn:dkim,sina.cn:mid]
X-Rspamd-Queue-Id: 6D4F5F8C6B
X-Rspamd-Action: no action

From: Kang Chen <k.chen@smail.nju.edu.cn>

[ Upstream commit bea3e1d4467bcf292c8e54f080353d556d355e26 ]

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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20250909031316.1647094-1-k.chen@smail.nju.edu.cn
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  8 ++++++--
 fs/hfsplus/unicode.c    | 24 +++++++++++++++++++-----
 fs/hfsplus/xattr.c      |  6 +++---
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 98a30ca6354c..17e651bd04ad 100644
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
index 8396964b056f..610ba01f19c3 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -516,8 +516,12 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
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
index ebd326799f35..11e08a4a18b2 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -143,9 +143,8 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
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
@@ -158,8 +157,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 	ip = ustr->unicode;
 
 	ustrlen = be16_to_cpu(ustr->length);
-	if (ustrlen > HFSPLUS_MAX_STRLEN) {
-		ustrlen = HFSPLUS_MAX_STRLEN;
+	if (ustrlen > max_len) {
+		ustrlen = max_len;
 		pr_err("invalid length %u has been corrected to %d\n",
 			be16_to_cpu(ustr->length), ustrlen);
 	}
@@ -280,6 +279,21 @@ int hfsplus_uni2asc(struct super_block *sb,
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
index 7ad3071debd6..53c8e3c0b8c1 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -737,9 +737,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
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


