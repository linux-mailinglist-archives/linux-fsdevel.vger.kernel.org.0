Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B7A19FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfH2MZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbfH2MZv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:25:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79A33B021;
        Thu, 29 Aug 2019 12:25:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52EA61E2F9E; Thu, 29 Aug 2019 14:25:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Steve Magnani <steve.magnani@digidescorp.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] udf: Verify domain identifier fields
Date:   Thu, 29 Aug 2019 14:25:42 +0200
Message-Id: <20190829122543.22805-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190829122543.22805-1-jack@suse.cz>
References: <20190829122543.22805-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OSTA UDF standard defines that domain identifier in logical volume
descriptor and file set descriptor should contain a particular string
and the identifier suffix contains flags possibly making media
write-protected. Verify these constraints and allow only read-only mount
if they are not met.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/ecma_167.h | 14 +++++++++
 fs/udf/super.c    | 91 ++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 9f24bd1a9f44..fb7f2c7bec9c 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -88,6 +88,20 @@ struct regid {
 #define ENTITYID_FLAGS_DIRTY		0x00
 #define ENTITYID_FLAGS_PROTECTED	0x01
 
+/* OSTA UDF 2.1.5.2 */
+#define UDF_ID_COMPLIANT "*OSTA UDF Compliant"
+
+/* OSTA UDF 2.1.5.3 */
+struct domainEntityIDSuffix {
+	uint16_t	revision;
+	uint8_t		flags;
+	uint8_t		reserved[5];
+};
+
+/* OSTA UDF 2.1.5.3 */
+#define ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT 0
+#define ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT 1
+
 /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
 #define VSD_STD_ID_LEN			5
 struct volStructDesc {
diff --git a/fs/udf/super.c b/fs/udf/super.c
index a14346137361..42db3dd51dfc 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -94,8 +94,8 @@ static int udf_remount_fs(struct super_block *, int *, char *);
 static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
 static int udf_find_fileset(struct super_block *, struct kernel_lb_addr *,
 			    struct kernel_lb_addr *);
-static void udf_load_fileset(struct super_block *, struct buffer_head *,
-			     struct kernel_lb_addr *);
+static int udf_load_fileset(struct super_block *, struct fileSetDesc *,
+			    struct kernel_lb_addr *);
 static void udf_open_lvid(struct super_block *);
 static void udf_close_lvid(struct super_block *);
 static unsigned int udf_count_free(struct super_block *);
@@ -757,28 +757,27 @@ static int udf_find_fileset(struct super_block *sb,
 {
 	struct buffer_head *bh = NULL;
 	uint16_t ident;
+	int ret;
 
-	if (fileset->logicalBlockNum != 0xFFFFFFFF ||
-	    fileset->partitionReferenceNum != 0xFFFF) {
-		bh = udf_read_ptagged(sb, fileset, 0, &ident);
-
-		if (!bh) {
-			return 1;
-		} else if (ident != TAG_IDENT_FSD) {
-			brelse(bh);
-			return 1;
-		}
-
-		udf_debug("Fileset at block=%u, partition=%u\n",
-			  fileset->logicalBlockNum,
-			  fileset->partitionReferenceNum);
+	if (fileset->logicalBlockNum == 0xFFFFFFFF &&
+	    fileset->partitionReferenceNum == 0xFFFF)
+		return -EINVAL;
 
-		UDF_SB(sb)->s_partition = fileset->partitionReferenceNum;
-		udf_load_fileset(sb, bh, root);
+	bh = udf_read_ptagged(sb, fileset, 0, &ident);
+	if (!bh)
+		return -EIO;
+	if (ident != TAG_IDENT_FSD) {
 		brelse(bh);
-		return 0;
+		return -EINVAL;
 	}
-	return 1;
+
+	udf_debug("Fileset at block=%u, partition=%u\n",
+		  fileset->logicalBlockNum, fileset->partitionReferenceNum);
+
+	UDF_SB(sb)->s_partition = fileset->partitionReferenceNum;
+	ret = udf_load_fileset(sb, (struct fileSetDesc *)bh->b_data, root);
+	brelse(bh);
+	return ret;
 }
 
 /*
@@ -939,19 +938,53 @@ static int udf_load_metadata_files(struct super_block *sb, int partition,
 	return 0;
 }
 
-static void udf_load_fileset(struct super_block *sb, struct buffer_head *bh,
-			     struct kernel_lb_addr *root)
+static int udf_verify_domain_identifier(struct super_block *sb,
+					struct regid *ident, char *dname)
 {
-	struct fileSetDesc *fset;
+	struct domainEntityIDSuffix *suffix;
 
-	fset = (struct fileSetDesc *)bh->b_data;
+	if (memcmp(ident->ident, UDF_ID_COMPLIANT, strlen(UDF_ID_COMPLIANT))) {
+		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
+		goto force_ro;
+	}
+	if (ident->flags & (1 << ENTITYID_FLAGS_DIRTY)) {
+		udf_warn(sb, "Possibly not OSTA UDF compliant %s descriptor.\n",
+			 dname);
+		goto force_ro;
+	}
+	suffix = (struct domainEntityIDSuffix *)ident->identSuffix;
+	if (suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT) ||
+	    suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT)) {
+		if (!sb_rdonly(sb)) {
+			udf_warn(sb, "Descriptor for %s marked write protected."
+				 " Forcing read only mount.\n", dname);
+		}
+		goto force_ro;
+	}
+	return 0;
 
-	*root = lelb_to_cpu(fset->rootDirectoryICB.extLocation);
+force_ro:
+	if (!sb_rdonly(sb))
+		return -EACCES;
+	UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+	return 0;
+}
 
+static int udf_load_fileset(struct super_block *sb, struct fileSetDesc *fset,
+			    struct kernel_lb_addr *root)
+{
+	int ret;
+
+	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set");
+	if (ret < 0)
+		return ret;
+
+	*root = lelb_to_cpu(fset->rootDirectoryICB.extLocation);
 	UDF_SB(sb)->s_serial_number = le16_to_cpu(fset->descTag.tagSerialNum);
 
 	udf_debug("Rootdir at block=%u, partition=%u\n",
 		  root->logicalBlockNum, root->partitionReferenceNum);
+	return 0;
 }
 
 int udf_compute_nr_groups(struct super_block *sb, u32 partition)
@@ -1364,6 +1397,10 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 		goto out_bh;
 	}
 
+	ret = udf_verify_domain_identifier(sb, &lvd->domainIdent,
+					   "logical volume");
+	if (ret)
+		goto out_bh;
 	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
 	if (ret)
 		goto out_bh;
@@ -2216,9 +2253,9 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 	}
 
-	if (udf_find_fileset(sb, &fileset, &rootdir)) {
+	ret = udf_find_fileset(sb, &fileset, &rootdir);
+	if (ret < 0) {
 		udf_warn(sb, "No fileset found\n");
-		ret = -EINVAL;
 		goto error_out;
 	}
 
-- 
2.16.4

