Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEF371372
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhECKNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:13:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhECKNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEAFDB2A8
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 10:12:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA26C1F2B72; Mon,  3 May 2021 12:12:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] udf: Get rid of 0-length arrays in struct fileIdentDesc
Date:   Mon,  3 May 2021 12:12:31 +0200
Message-Id: <20210503101237.17576-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210503100931.5127-1-jack@suse.cz>
References: <20210503100931.5127-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of 0-length arrays in struct fileIdentDesc. This requires a bit
of cleaning up as the second variable length array in this structure is
often used and the code abuses the fact that the first two arrays have
the same type and offset in struct fileIdentDesc.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/dir.c      |  5 ++---
 fs/udf/ecma_167.h |  6 +++---
 fs/udf/inode.c    |  3 +--
 fs/udf/namei.c    | 13 ++++++-------
 fs/udf/udfdecl.h  |  4 ++++
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index c19dba45aa20..70abdfad2df1 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -35,7 +35,6 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-
 static int udf_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *dir = file_inode(file);
@@ -135,7 +134,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		lfi = cfi.lengthFileIdent;
 
 		if (fibh.sbh == fibh.ebh) {
-			nameptr = fi->fileIdent + liu;
+			nameptr = udf_get_fi_ident(fi);
 		} else {
 			int poffset;	/* Unpaded ending offset */
 
@@ -153,7 +152,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 					}
 				}
 				nameptr = copy_name;
-				memcpy(nameptr, fi->fileIdent + liu,
+				memcpy(nameptr, udf_get_fi_ident(fi),
 				       lfi - poffset);
 				memcpy(nameptr + lfi - poffset,
 				       fibh.ebh->b_data, poffset);
diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index c6bea5c9841a..de17a97e8667 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -471,9 +471,9 @@ struct fileIdentDesc {
 	uint8_t		lengthFileIdent;
 	struct long_ad	icb;
 	__le16		lengthOfImpUse;
-	uint8_t		impUse[0];
-	uint8_t		fileIdent[0];
-	uint8_t		padding[0];
+	uint8_t		impUse[];
+	/* uint8_t	fileIdent[]; */
+	/* uint8_t	padding[]; */
 } __packed;
 
 /* File Characteristics (ECMA 167r3 4/14.4.3) */
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 0dd2f93ac048..90e9da91b798 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -389,8 +389,7 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 		dfibh.eoffset += (sfibh.eoffset - sfibh.soffset);
 		dfi = (struct fileIdentDesc *)(dbh->b_data + dfibh.soffset);
 		if (udf_write_fi(inode, sfi, dfi, &dfibh, sfi->impUse,
-				 sfi->fileIdent +
-					le16_to_cpu(sfi->lengthOfImpUse))) {
+				 udf_get_fi_ident(sfi))) {
 			iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 			brelse(dbh);
 			return NULL;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f146b3089f3d..b60b83fa3b0a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -74,12 +74,11 @@ int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
 
 	if (fileident) {
 		if (adinicb || (offset + lfi < 0)) {
-			memcpy((uint8_t *)sfi->fileIdent + liu, fileident, lfi);
+			memcpy(udf_get_fi_ident(sfi), fileident, lfi);
 		} else if (offset >= 0) {
 			memcpy(fibh->ebh->b_data + offset, fileident, lfi);
 		} else {
-			memcpy((uint8_t *)sfi->fileIdent + liu, fileident,
-				-offset);
+			memcpy(udf_get_fi_ident(sfi), fileident, -offset);
 			memcpy(fibh->ebh->b_data, fileident - offset,
 				lfi + offset);
 		}
@@ -88,11 +87,11 @@ int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
 	offset += lfi;
 
 	if (adinicb || (offset + padlen < 0)) {
-		memset((uint8_t *)sfi->padding + liu + lfi, 0x00, padlen);
+		memset(udf_get_fi_ident(sfi) + lfi, 0x00, padlen);
 	} else if (offset >= 0) {
 		memset(fibh->ebh->b_data + offset, 0x00, padlen);
 	} else {
-		memset((uint8_t *)sfi->padding + liu + lfi, 0x00, -offset);
+		memset(udf_get_fi_ident(sfi) + lfi, 0x00, -offset);
 		memset(fibh->ebh->b_data, 0x00, padlen + offset);
 	}
 
@@ -226,7 +225,7 @@ static struct fileIdentDesc *udf_find_entry(struct inode *dir,
 		lfi = cfi->lengthFileIdent;
 
 		if (fibh->sbh == fibh->ebh) {
-			nameptr = fi->fileIdent + liu;
+			nameptr = udf_get_fi_ident(fi);
 		} else {
 			int poffset;	/* Unpaded ending offset */
 
@@ -246,7 +245,7 @@ static struct fileIdentDesc *udf_find_entry(struct inode *dir,
 					}
 				}
 				nameptr = copy_name;
-				memcpy(nameptr, fi->fileIdent + liu,
+				memcpy(nameptr, udf_get_fi_ident(fi),
 					lfi - poffset);
 				memcpy(nameptr + lfi - poffset,
 					fibh->ebh->b_data, poffset);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 9dd0814f1077..7e258f15b8ef 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -130,6 +130,10 @@ static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 		le16_to_cpu(cfi->lengthOfImpUse) + cfi->lengthFileIdent,
 		UDF_NAME_PAD);
 }
+static inline uint8_t *udf_get_fi_ident(struct fileIdentDesc *fi)
+{
+	return ((uint8_t *)(fi + 1)) + le16_to_cpu(fi->lengthOfImpUse);
+}
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
-- 
2.26.2

