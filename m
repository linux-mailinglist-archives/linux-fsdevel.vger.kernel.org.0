Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35CA19F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2MZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfH2MZv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:25:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79B93B023;
        Thu, 29 Aug 2019 12:25:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 56E221E43A8; Thu, 29 Aug 2019 14:25:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Steve Magnani <steve.magnani@digidescorp.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] udf: Drop forward function declarations
Date:   Thu, 29 Aug 2019 14:25:43 +0200
Message-Id: <20190829122543.22805-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190829122543.22805-1-jack@suse.cz>
References: <20190829122543.22805-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move some functions to make forward declarations unnecessary.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 102 +++++++++++++++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 53 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 42db3dd51dfc..fa0f1d947526 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -92,10 +92,6 @@ static void udf_put_super(struct super_block *);
 static int udf_sync_fs(struct super_block *, int);
 static int udf_remount_fs(struct super_block *, int *, char *);
 static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
-static int udf_find_fileset(struct super_block *, struct kernel_lb_addr *,
-			    struct kernel_lb_addr *);
-static int udf_load_fileset(struct super_block *, struct fileSetDesc *,
-			    struct kernel_lb_addr *);
 static void udf_open_lvid(struct super_block *);
 static void udf_close_lvid(struct super_block *);
 static unsigned int udf_count_free(struct super_block *);
@@ -751,6 +747,55 @@ static loff_t udf_check_vsd(struct super_block *sb)
 		return 0;
 }
 
+static int udf_verify_domain_identifier(struct super_block *sb,
+					struct regid *ident, char *dname)
+{
+	struct domainEntityIDSuffix *suffix;
+
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
+
+force_ro:
+	if (!sb_rdonly(sb))
+		return -EACCES;
+	UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+	return 0;
+}
+
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
+	UDF_SB(sb)->s_serial_number = le16_to_cpu(fset->descTag.tagSerialNum);
+
+	udf_debug("Rootdir at block=%u, partition=%u\n",
+		  root->logicalBlockNum, root->partitionReferenceNum);
+	return 0;
+}
+
 static int udf_find_fileset(struct super_block *sb,
 			    struct kernel_lb_addr *fileset,
 			    struct kernel_lb_addr *root)
@@ -938,55 +983,6 @@ static int udf_load_metadata_files(struct super_block *sb, int partition,
 	return 0;
 }
 
-static int udf_verify_domain_identifier(struct super_block *sb,
-					struct regid *ident, char *dname)
-{
-	struct domainEntityIDSuffix *suffix;
-
-	if (memcmp(ident->ident, UDF_ID_COMPLIANT, strlen(UDF_ID_COMPLIANT))) {
-		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
-		goto force_ro;
-	}
-	if (ident->flags & (1 << ENTITYID_FLAGS_DIRTY)) {
-		udf_warn(sb, "Possibly not OSTA UDF compliant %s descriptor.\n",
-			 dname);
-		goto force_ro;
-	}
-	suffix = (struct domainEntityIDSuffix *)ident->identSuffix;
-	if (suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT) ||
-	    suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT)) {
-		if (!sb_rdonly(sb)) {
-			udf_warn(sb, "Descriptor for %s marked write protected."
-				 " Forcing read only mount.\n", dname);
-		}
-		goto force_ro;
-	}
-	return 0;
-
-force_ro:
-	if (!sb_rdonly(sb))
-		return -EACCES;
-	UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
-	return 0;
-}
-
-static int udf_load_fileset(struct super_block *sb, struct fileSetDesc *fset,
-			    struct kernel_lb_addr *root)
-{
-	int ret;
-
-	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set");
-	if (ret < 0)
-		return ret;
-
-	*root = lelb_to_cpu(fset->rootDirectoryICB.extLocation);
-	UDF_SB(sb)->s_serial_number = le16_to_cpu(fset->descTag.tagSerialNum);
-
-	udf_debug("Rootdir at block=%u, partition=%u\n",
-		  root->logicalBlockNum, root->partitionReferenceNum);
-	return 0;
-}
-
 int udf_compute_nr_groups(struct super_block *sb, u32 partition)
 {
 	struct udf_part_map *map = &UDF_SB(sb)->s_partmaps[partition];
-- 
2.16.4

