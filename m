Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EE422E49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhJEQs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:48:57 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49014 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236586AbhJEQs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:48:56 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id C1B2F81FEE;
        Tue,  5 Oct 2021 19:47:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452424;
        bh=r+W8aHPlNsC5aB07S5h4ESeUSjvbGYbb4u2h6x+QVOY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Gcd9HqSzF50LSg6AJ3v11TyIHFhWEt9pfjJPJvMQDmeXY6byTRv82hOS4pXrvcVhm
         vUF0oi0PNfG1oJRga49MW1mcnb1cKsCx1FdYgQYgqxu2WcGlWy4sN++FXLY+QVnjhZ
         K8v7m6Fo9+fvb8ro+3jzcByTJfiQudx4EOdDPMyA=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:47:04 +0300
Message-ID: <5f5a0b13-90bd-b97c-aa50-c646bb243bde@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:47:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 1/5] fs/ntfs3: Rework ntfs_utf16_to_nls
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
In-Reply-To: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now ntfs_utf16_to_nls takes length as one of arguments.
If length of symlink > 255, then we tried to convert
length of symlink +- some random number.
Now 255 symbols limit was removed.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     | 19 ++++++++-----------
 fs/ntfs3/ntfs_fs.h |  2 +-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 785e72d4392e..fb438d604040 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -15,11 +15,10 @@
 #include "ntfs_fs.h"
 
 /* Convert little endian UTF-16 to NLS string. */
-int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
+int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
 		      u8 *buf, int buf_len)
 {
-	int ret, uni_len, warn;
-	const __le16 *ip;
+	int ret, warn;
 	u8 *op;
 	struct nls_table *nls = sbi->options->nls;
 
@@ -27,18 +26,16 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 
 	if (!nls) {
 		/* UTF-16 -> UTF-8 */
-		ret = utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
-				      UTF16_LITTLE_ENDIAN, buf, buf_len);
+		ret = utf16s_to_utf8s(name, len, UTF16_LITTLE_ENDIAN, buf,
+				      buf_len);
 		buf[ret] = '\0';
 		return ret;
 	}
 
-	ip = uni->name;
 	op = buf;
-	uni_len = uni->len;
 	warn = 0;
 
-	while (uni_len--) {
+	while (len--) {
 		u16 ec;
 		int charlen;
 		char dump[5];
@@ -49,7 +46,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 			break;
 		}
 
-		ec = le16_to_cpu(*ip++);
+		ec = le16_to_cpu(*name++);
 		charlen = nls->uni2char(ec, op, buf_len);
 
 		if (charlen > 0) {
@@ -304,8 +301,8 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
 		return 0;
 
-	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
-				     name, PATH_MAX);
+	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
+				     PATH_MAX);
 	if (name_len <= 0) {
 		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
 			  ino);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 38b7c1a9dc52..9277b552f257 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -475,7 +475,7 @@ bool are_bits_set(const ulong *map, size_t bit, size_t nbits);
 size_t get_set_bits_ex(const ulong *map, size_t bit, size_t nbits);
 
 /* Globals from dir.c */
-int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
+int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
 		      u8 *buf, int buf_len);
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
-- 
2.33.0


