Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5440F77E3AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjHPOd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbjHPOdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:33:52 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080F2715
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:49 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170]) by mx-outbound23-26.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2fQlHdZ3o8r7UMXpaHyQdwfTl64Zl0u5C4GJZTs8by9fIwej+s09YUXVPtyHM2hDsNW0qWHHHkd3JJnSqxUdcjxLklmzWv8AO3w+o9ukF+oaZtWsqAW9P0H9aG1oGU+2aycPCRcmZ60OF+Ghyur7TTuZjg64irsr3amom9Q8QXJBLXyYVP1aYL1RpzzpF76dtyrQx6qn95qAPH9l8BaxFhaoGHnqlFkwroMFANqMX6qv2MznOisTKtxEzLMcglHxsT11UcVbochPSivt4/r7l4U6KrLgufGGi/7GFhZo04oS2P89H9XedbUOnFnczs8I6kA0o9WhKf6kcd4IuRJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8d7QWZ9q4hFSPtKrPBOE8C/BNLm9ePBJPg4vd5q698=;
 b=j6pJLPrr/BvMap+NkkchonINLqr8mCqSn1LcDO+3ROOJ+RjMZR0z78V+kdQ9Q+Fy/joL5aoJ6hhL9kfOBxzjaVF3jVmqcOBKKUnGg6agaBk5VpD73Km7dA8SrLAy07BzFVXUm9OKi4WqgOLqtHAiPhS/3aVUopjcCKpeKuXwTI0IzX7GKBpPKCsY5WwrBVTXmzKhmvIOwa0hpvSFktm2ovveOZmgleUvEUQyXOXlYYI0YUp5wu3BxL4BYwFlOx88TjBj6x6fHfSYnrOpQH3QfZP/LUr9+HWwM0blPwrjQYdu3OfULVLjxfC7Yv3luqwpXJxRixWBcUlwCR6xMJicpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8d7QWZ9q4hFSPtKrPBOE8C/BNLm9ePBJPg4vd5q698=;
 b=Q2MWUqMnRzOhgk3IUWJu8rnTfwdDpC/F1ko4/9bW+6MaKChnrHJqcD/46KyuI8mdnlk6dBbUmnS9TwyC7fVyT0EwExhqwz31OvcjWt7x3trSxIAX65xBYRramX1X+pMF7g99te2sxlXEwjv07NpnT+z91QjnMMyL4WiVyG8/Hho=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by MN2PR19MB4078.namprd19.prod.outlook.com (2603:10b6:208:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:33:33 +0000
Received: from MW2NAM04FT050.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::cd) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT050.mail.protection.outlook.com (10.13.30.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 14:33:33 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 3747120C684B;
        Wed, 16 Aug 2023 08:34:39 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH 5/6] fuse: revalidate Set DCACHE_ATOMIC_OPEN for cached dentries
Date:   Wed, 16 Aug 2023 16:33:12 +0200
Message-Id: <20230816143313.2591328-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT050:EE_|MN2PR19MB4078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7ecebe9a-3bb5-4d7c-70c8-08db9e65c4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKJMAYsxnkGsiNLNyWjS50ticD7SLuGJZnJxVignB/0OtODZPmt5VLtADOfaYe3+fbFpJUKroEfLAfTRiCD0wsTnOLLdTE3eFHWVzAD8KmJjI9JziFdxLGEdq5IRHmrRZ4cG2jW/k05POJQqL7MPADtovCd0YCQG5gycldpyQyS5RHoC8USBbKSMVN7NURQ5qFLK374oQ18/jiJtUiavIU5L6ueKOsP4k2knNmHxcS7g6TbJ8CNRGhvEW5lsX6j9zevfLhOYxDS8xw0vVTk2EresgijzwsK8cSFTrqomjfUFnHfIjTfNk01I7g8MjN5Bx2uSIC2JyJwQbhxNCQddZDLBbQAVQKVsQJGSAl0k9Gi9BnM2+rvtuo52AYNmU3RrKFWiAEZW7ewZEhRw+UOlekkwn+GUeF5kLgiHecTJS3FJASfxcI6GQl5u1atTArpOLYSuRn66QnjZX0Txg2Pno8v0zlWBJsCgmbzTmzjyr+Wmq9CW8hGYr2v6DqXqodN7KSbkPrj9AAW+1KvlSH7pr39xVqwsAug7VCgntsBJGfWeNhPBITox1leCMIIKokw8yWWj8dSLNJq98ZfSdaBc3ZExesCf+9lY+Ub8y71uEybIjhdfxSYZWKuQvaMrbJpehaUFFKRCL1h0P5S1Iz0QlqbpzPgB3lRldOPdoM8959uZw626BheeGwQ3GQXR/UyznYkXw+XNrHlx8r41MQTbcMgDNQ14s0O2ZJYAg7O7808=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DIedd2or4aJSDArRks6GfPzy+0H6ewriFLDm9nzdFU/DkarLFegQeKhZPijfdg2Gmba//vXNZbTSOwiFdDQXvJt/xKtqi+CLxdDgYlVXFBSLK7nDZWffeg6ya/2bQhKsMIZyyQAXOIiAscbuuTRi6E3juMF9U0vpNR4iPHEDvp7A4XwcV6pL26/j+NoBFrzIVMJMo6aKyNeNW8nKfdxeVrEgH4yNFN5t3UZy6cFItt0bbYpfkV5ng1/J5foOjz40He5wzGNXadxslSUZKyyhBL4OWkR7IasGRjaJBxcNs90j0RR9wXh1FcVar79iKsM3ZPC/qMaE7SyRSgWgJA2oPV69u/qE4kKvlYOdsDLF7e9QK6Ir9MXSThbNyeas3mWn3N7AFnZ8ykEYelBf+v1hqyQ7j7qbHJxxI+bLflePL2MN/iaoOp8oDLO3pQLUW8O1tDinvjrOfdP3yIr4a+i5K3YCzOwpzCpwwWJu5OGy7EFVXcQHIVtWIp7qg8Sj0CrDuUCr01zJk96xiSyv15DQX5wQ79DMDtn9BI0LQ7bd7LtBBQyZHGBN9RAaE8Iyjw7m3dzyoCVTYCa1Pb2R9nSo6uluCBe02XcAvQkK2qSA0QxWbJTLdbY5XbNKMVIBiHJwrY28aLouAIDJY5kC3t4KuQ+QxPDxUC5Fq41M+7ehfPUix+ttVKoaFDA0vToXh5Wl9RqBfaLzpBNSeiHuD8HWe/8Ad8CIN6ymVhnCulc2IfgoUoNxoAFoFsl0h+OgFbnMO6Lg/x30RAGhJW7/bO7k8cz95ADfOQSVckDpZiRn+HuCfbLcrj0d/arcn8HwMuQzpfdYq15nGK4+JAIKwZlvrtH3NYkhBT4Nx56bZigCBYyC8WA2uu5bkRcArfQYuiAcyj1MmrP09GNn4heMAzYult94UWBuzzhQPy0YwRgz1dw=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:33.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecebe9a-3bb5-4d7c-70c8-08db9e65c4d1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT050.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4078
X-BESS-ID: 1692196417-105914-26282-1155-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.59.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmBmZAVgZQ0NTA1MLQzMjUOM
        nSwsgyMckgxdjSLMXY2NjUNNky2cxEqTYWAEuluThBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan22-15.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cached dentries do not get revalidate, but open will result in
open + getattr, but we want one call only.

libfuse logs (passthrough_hp):

Unpatched:
----------
unique: 22, opcode: OPEN (14), nodeid: 140698229673544, insize: 48, pid: 3434
   unique: 22, success, outsize: 32
unique: 24, opcode: GETATTR (3), nodeid: 140698229673544, insize: 56, pid: 3434
   unique: 24, success, outsize: 120
unique: 26, opcode: FLUSH (25), nodeid: 140698229673544, insize: 64, pid: 3434
   unique: 26, success, outsize: 16
unique: 28, opcode: RELEASE (18), nodeid: 140698229673544, insize: 64, pid: 0
   unique: 28, success, outsize: 16

Patched:
----------
unique: 20, opcode: OPEN_ATOMIC (52), nodeid: 1, insize: 63, pid: 3397
   unique: 20, success, outsize: 160
unique: 22, opcode: FLUSH (25), nodeid: 140024188243528, insize: 64, pid: 3397
   unique: 22, success, outsize: 16
unique: 24, opcode: RELEASE (18), nodeid: 140024188243528, insize: 64, pid: 0
   unique: 24, success, outsize: 16

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 52 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 701f9c51cdb1..1e5e2d46df8a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -193,6 +193,22 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+/*
+ * If open atomic is supported by FUSE then use this opportunity
+ * to avoid this lookup and combine lookup + open into a single call.
+ */
+static int fuse_dentry_do_atomic_revalidate(struct dentry *entry,
+					     unsigned int flags,
+					     struct fuse_conn *fc)
+{
+	int ret = 0;
+
+	if (flags & LOOKUP_OPEN && fc->has_open_atomic)
+		ret = D_REVALIDATE_ATOMIC;
+
+	return ret;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -230,19 +246,10 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		/* If open atomic is supported by FUSE then use this opportunity
-		 * to avoid this lookup and combine lookup + open into a single call.
-		 *
-		 * Note: Fuse detects open atomic implementation automatically.
-		 * Therefore first few call would go into open atomic code path
-		 * , detects that open atomic is implemented or not by setting
-		 * fc->no_open_atomic. In case open atomic is not implemented,
-		 * calls fall back to non-atomic open.
-		 */
-		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN) {
-			ret = D_REVALIDATE_ATOMIC;
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
 			goto out;
-		}
+
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -285,6 +292,16 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
+			fm = get_fuse_mount(inode);
+			if (fm->fc->has_open_atomic) {
+				/* Atomic open is preferred, as it does entry
+				 * revalidate and attribute refresh, but
+				 * DCACHE_ATOMIC_OPEN cannot be set in RCU mode
+				 */
+				if (flags & LOOKUP_OPEN)
+					return -ECHILD;
+			}
+
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
@@ -292,6 +309,14 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			fuse_advise_use_readdirplus(d_inode(parent));
 			dput(parent);
 		}
+
+		/* revalidate is skipped, but we still want atomic open to
+		 * update attributes during open
+		 */
+		fm = get_fuse_mount(inode);
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
+			goto out;
 	}
 	ret = D_REVALIDATE_VALID;
 out:
@@ -935,11 +960,10 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			 * return -ENOSYS for OPEN_ATOMIC after it was
 			 * aready working
 			 */
-			if (unlikely(fc->has_open_atomic == 1)) {
+			if (unlikely(fc->has_open_atomic == 1))
 				pr_info("fuse server/daemon bug, atomic open "
 					"got -ENOSYS although it was already "
 					"succeeding before.");
-			}
 
 			/* This should better never happen, revalidate
 			 * is missing for this entry*/
-- 
2.37.2

