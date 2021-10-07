Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0874256BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbhJGPjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 11:39:52 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:33529 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241275AbhJGPjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:39:52 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 4DC59808DD;
        Thu,  7 Oct 2021 18:37:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633621076;
        bh=onWB3Za1LakJhYJnlNQYet5LYke85q/oBbAW+MzRXy4=;
        h=Date:To:CC:From:Subject;
        b=QVAc9ANQ3OamfaApzFGi8m3C5Qv/NHUUKJPV0kUaZQAybSW1K22k0M4DYiqcbb37e
         u1KfQrQLyg4w9Z0FwAG9t9/f9u0hS4Z+Y5ZmMYyZoq+61rbpbIyRLHk8YcxrfOyp3r
         EZz3qwxu2hJsdAeBWyuL+6YUortVOP+ATxPJXz8M=
Received: from [192.168.211.112] (192.168.211.112) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 7 Oct 2021 18:37:55 +0300
Message-ID: <45f2af05-9f5c-bf56-aa91-47d8b0055f5b@paragon-software.com>
Date:   Thu, 7 Oct 2021 18:37:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <mark@harmstone.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Remove bothcase variable
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.112]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bothcase == true when upcase != NULL
bothcase == false when upcase == NULL
We don't need to have second variable, that is a copy of upcase.

Suggested-by: Mark Harmstone <mark@harmstone.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrlist.c |  8 +++-----
 fs/ntfs3/frecord.c  |  3 +--
 fs/ntfs3/index.c    |  6 ++----
 fs/ntfs3/inode.c    |  2 +-
 fs/ntfs3/ntfs_fs.h  |  4 ++--
 fs/ntfs3/record.c   |  2 +-
 fs/ntfs3/upcase.c   | 18 ++++++------------
 7 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index bad6d8a849a2..1a31ef4ed92b 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -194,8 +194,7 @@ struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
 			 * Compare entry names only for entry with vcn == 0.
 			 */
 			diff = ntfs_cmp_names(le_name(le), name_len, name,
-					      name_len, ni->mi.sbi->upcase,
-					      true);
+					      name_len, ni->mi.sbi->upcase);
 			if (diff < 0)
 				continue;
 
@@ -246,8 +245,7 @@ static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,
 			 * Compare entry names only for entry with vcn == 0.
 			 */
 			diff = ntfs_cmp_names(le_name(le), le->name_len, name,
-					      name_len, ni->mi.sbi->upcase,
-					      true);
+					      name_len, ni->mi.sbi->upcase);
 			if (diff < 0)
 				continue;
 
@@ -393,7 +391,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 	if (le->name_len != name_len)
 		return false;
 	if (name_len && ntfs_cmp_names(le_name(le), name_len, name, name_len,
-				       ni->mi.sbi->upcase, true))
+				       ni->mi.sbi->upcase))
 		return false;
 	if (le64_to_cpu(le->vcn) != vcn)
 		return false;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 007602badd90..ecf982aca437 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1589,8 +1589,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 	if (uni->len != fname->name_len)
 		goto next;
 
-	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL,
-			       false))
+	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL))
 		goto next;
 
 	return fname;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..a12f6fa0537e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -38,7 +38,6 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
 	const struct ntfs_sb_info *sbi = data;
 	const struct ATTR_FILE_NAME *f1;
 	u16 fsize2;
-	bool both_case;
 
 	if (l2 <= offsetof(struct ATTR_FILE_NAME, name))
 		return -1;
@@ -47,7 +46,6 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
 	if (l2 < fsize2)
 		return -1;
 
-	both_case = f2->type != FILE_NAME_DOS /*&& !sbi->options.nocase*/;
 	if (!l1) {
 		const struct le_str *s2 = (struct le_str *)&f2->name_len;
 
@@ -55,12 +53,12 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
 		 * If names are equal (case insensitive)
 		 * try to compare it case sensitive.
 		 */
-		return ntfs_cmp_names_cpu(key1, s2, sbi->upcase, both_case);
+		return ntfs_cmp_names_cpu(key1, s2, sbi->upcase);
 	}
 
 	f1 = key1;
 	return ntfs_cmp_names(f1->name, f1->name_len, f2->name, f2->name_len,
-			      sbi->upcase, both_case);
+			      sbi->upcase);
 }
 
 /*
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7dd162f6a7e2..c7014e5f941c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -179,7 +179,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		names += 1;
 		if (name && name->len == fname->name_len &&
 		    !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
-					NULL, false))
+					NULL))
 			is_match = true;
 
 		goto next_attr;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 38b7c1a9dc52..859624d0dccb 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -830,9 +830,9 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);
 
 /* Globals from upcase.c */
 int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
-		   const u16 *upcase, bool bothcase);
+		   const u16 *upcase);
 int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
-		       const u16 *upcase, bool bothcase);
+		       const u16 *upcase);
 
 /* globals from xattr.c */
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 861e35791506..6afd3c20b0d3 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -23,7 +23,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
 
 	/* They have the same type code, so we have to compare the names. */
 	return ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
-			      upcase, true);
+			      upcase);
 }
 
 /*
diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
index b5e8256fd710..c15ae0993839 100644
--- a/fs/ntfs3/upcase.c
+++ b/fs/ntfs3/upcase.c
@@ -24,29 +24,26 @@ static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
 /*
  * ntfs_cmp_names
  *
- * Thanks Kari Argillander <kari.argillander@gmail.com> for idea and implementation 'bothcase'
+ * Thanks Kari Argillander <kari.argillander@gmail.com> for idea and implementation
  *
  * Straight way to compare names:
  * - Case insensitive
- * - If name equals and 'bothcases' then
+ * - If name equals and 'upcase' then
  * - Case sensitive
  * 'Straight way' code scans input names twice in worst case.
  * Optimized code scans input names only once.
  */
 int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
-		   const u16 *upcase, bool bothcase)
+		   const u16 *upcase)
 {
 	int diff1 = 0;
 	int diff2;
 	size_t len = min(l1, l2);
 
-	if (!bothcase && upcase)
-		goto case_insentive;
-
 	for (; len; s1++, s2++, len--) {
 		diff1 = le16_to_cpu(*s1) - le16_to_cpu(*s2);
 		if (diff1) {
-			if (bothcase && upcase)
+			if (upcase)
 				goto case_insentive;
 
 			return diff1;
@@ -67,7 +64,7 @@ int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
 }
 
 int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
-		       const u16 *upcase, bool bothcase)
+		       const u16 *upcase)
 {
 	const u16 *s1 = uni1->name;
 	const __le16 *s2 = uni2->name;
@@ -77,13 +74,10 @@ int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
 	int diff1 = 0;
 	int diff2;
 
-	if (!bothcase && upcase)
-		goto case_insentive;
-
 	for (; len; s1++, s2++, len--) {
 		diff1 = *s1 - le16_to_cpu(*s2);
 		if (diff1) {
-			if (bothcase && upcase)
+			if (upcase)
 				goto case_insentive;
 
 			return diff1;
-- 
2.33.0

