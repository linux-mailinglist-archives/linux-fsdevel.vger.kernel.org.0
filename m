Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585337A8AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjITRfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjITRfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:19 -0400
Received: from outbound-ip160b.ess.barracuda.com (outbound-ip160b.ess.barracuda.com [209.222.82.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D6DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:09 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171]) by mx-outbound23-131.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2+5/3aopIn9pNbu88lCmgG13s/LWL4F6wHghDeyFju9n/G++n8bNPFL8NQnXaeSZo+eVqZX7BaNovNvF6JRTuwX8z/7xcSCRYRNKZI5XfULAn7nqqLqxiTadThBcibhPU35NBPbLPMoEOB/GRMKunPTZVJFupzXTIXyN8lS3Nehpc48QxFva9P8ep2+o1Br4Iwp6SBWz6BUkn1fDrv2JxGQPR5HPayYsL3epfhUx5fZ6lrQXpRNSAfrA+VFU7PYLWy8ZcHMYG/anjjW+Hz69ZTTUQDOz01WA+77aXTcpw48p21cQuAnvt9awX90LA2jLZy9uMdzoBD6twgrogWAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAO/exSgvbNugQQ4efSMFeaXx6l02kTihT9DlJKrY+Q=;
 b=k1afFF5U0gUPQEqHRB/ayERosSqZVpa/PwwChpNFpgmHuJEmrThzKsNX34iPRX7zOAecGJn6Q613VQ37Wihu23VkXicuUptcYlNLs10EoizfAYI4mLyKz9r2BT9acuJjrjKmIO7bg1vXQyqc8aULrNaBItwfAx7lTN2IcXFg/OLgZtLHjf6YPi/Jj6d9UL8OZIoSbgFAn4wX66pdFX2qqDWZcKRq1+DoXvld/oeYea5ZsseTpSvbV5dA8gg8nlt2rqkk5HOV99N7qljS8TuLAV38AHXTK+LufHyPNqz133da0v/f+fVlgRbRvqXHcYmeJYci8YJtmLywgAM+cGRs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAO/exSgvbNugQQ4efSMFeaXx6l02kTihT9DlJKrY+Q=;
 b=Ltpm+l+Pl6thxapeD8CcMT+EBQhGn566cL+Xd8RBkobHfA8B9zv4OEgBVswFe9vwC8K1d+nY0NOgewxEkdiSKubcJDLDeXJ0qkWqm5RCCrgnx+k6kKrwAkiK5+NWERJnAydwCbv6UZRERGzvzON7GGSrIumuSohPAtICRKAxLis=
Received: from MWH0EPF00056D18.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:19) by PH0PR19MB4792.namprd19.prod.outlook.com
 (2603:10b6:510:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:34:53 +0000
Received: from MW2NAM04FT061.eop-NAM04.prod.protection.outlook.com
 (2a01:111:f400:7e8c::208) by MWH0EPF00056D18.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.12 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT061.mail.protection.outlook.com (10.13.31.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:53 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 466CA20C684B;
        Wed, 20 Sep 2023 11:35:58 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
Date:   Wed, 20 Sep 2023 19:34:42 +0200
Message-Id: <20230920173445.3943581-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT061:EE_|PH0PR19MB4792:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3769eed4-da46-4fb3-0346-08dbb9ffe621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vA4rdjpNzowaPcZTOdzuhuoSuwF78bHLje7f0/k/hlERkVObyTGrnUiJlfZxZs5vncjumnVwwq4ijzEBlv2Hv/BMueZpV22n47MFMVAcdCcsaIGmObDutZu9hoXX3bHZ7j/YWTtUSB66ZqJ5EyFCJ/c+UtS7Oq03BCeSj+Lew1FhvWvN9t9eEdwcwwldQCoGzdDYus2pqzfjmVq/iY46gGhY53dvDk30LliO/jUm7Z3GDuphoHHNZwWrFk3kQH5YAp4rifhElvczZrt9PnP8xyLek/NFI7ob4jThhfnSa3PBtWEgrjAcRByrRQmC6UmWgLx7DzBHJFlvsM45maBhvbvwrMfoz+DmG5YuOTuSGRPqyG7LRL0j12//iodwoV4AXwsJnKpUELGgzcnJWYcacG95W06d6a0hN8Z3y5Zz007LLUb6Y2mkEBXL+otiWfPFAxVnVQUsDOpV9WPuE42t1+hYPMwog7bCpuGwScn340fha2Ai8/jNAMgktIG4CTxBO2RtoAMlhfRUuxn6FxzvWSdp6t7ma6BhL6FDlAt5FX/UbHy/26Kesu5XbZdJpKXDfXyIFMAhSkyzQBn/lUGtZSj3JJJXvaHexNXTNkiOfUNrmg1avTMhVWDkXou/gbJeF58QmyPiyY13baDg2eODFfCEeBCS4DtTQjVSiLBMrCNbTeULZgxeQhjknVsNIDwbR1hxPU72gcePnM5ZcO6gA/3v7r/1jCeIlygU3waDKStII2nj7eu1M38ePyfB2Dr6
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39850400004)(376002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(6266002)(6916009)(54906003)(8676002)(8936002)(4326008)(41300700001)(1076003)(40480700001)(2616005)(83380400001)(26005)(36860700001)(336012)(6666004)(478600001)(36756003)(356005)(86362001)(81166007)(47076005)(82740400003)(316002)(70586007)(70206006)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nbp5tk4m+csWBNERXRM+AkCq7EFlqzaVtkE3cUtTZwAA+q6MXlNrzZXFrjKI?=
 =?us-ascii?Q?6WYET9WT8Yp37qPqyW+mkBl278WyNc9VY/RGePJySa5jeDGypjh+64KCA1yl?=
 =?us-ascii?Q?QaZW+LCyAkDy2dpNsiXz3a6uy3FTALNBwmplabW0g6BkCulxyy0ch18gxcvp?=
 =?us-ascii?Q?6YN9HwF4d2+X4LaLtcjLu7yEUAaOC1D0gEEeLK61/6Ga3/mBDJ9Whf1MvGM1?=
 =?us-ascii?Q?eZDlrlxtncKJaWYF1gRpKhairETp8J+/DlUb7EpTbT3zqqilM6nkzXAAdweH?=
 =?us-ascii?Q?hCNvYwMnnYt92UGt+jpXCiOS5WcMPiYTchim2CKzy9WqjrNSbOCSaBWWVy1a?=
 =?us-ascii?Q?VRGqPEeuvol4Lb/JgrusrCkpiTlo5hgLVGBhiiIU1yPqHGJHx2hZ45Q8tSxB?=
 =?us-ascii?Q?9rF46OFhksAS+4tAAZvOupCT2hy2dnNEuLvX8Btl9PG5hbfY0EdE/xcHeYNA?=
 =?us-ascii?Q?HhlnvhjjTGMmYGJtpUxGNoj3qnyhVurSXjJ+CgCiuIFKeGDIXMhH2bJKZ1ne?=
 =?us-ascii?Q?8uaQgYfThA8L3ajo+S9Ko72bDtiYExlIGBFYWOPy8J5zJ2vBO/AtPq3t/MTB?=
 =?us-ascii?Q?O/tWHinF5GPisRO51HXc32aQUxNOcrn2VywgxiPHkN6FCzrok3dVs0wC7wc+?=
 =?us-ascii?Q?2G7zMcomzq1hdvFtMHDeVan92v6mu1MgC/JeXbo1djzQg1a1/g0ocJELE4pz?=
 =?us-ascii?Q?rEqbh0k7zJUREPDO1G1976H900540KoEDiPnAGWSaUw2bwCdcAGDcrR8qIRK?=
 =?us-ascii?Q?z2ReIzM3FZjNc1SwEUNrDmdUXcVBOQTs5+rGkqBp4bVKW3A34oUoVkihQFgU?=
 =?us-ascii?Q?Cw+vuNTSQDva43wMnd0Rab5X5sFMPDS3LoTa2ihStQgigdSn9fwdNn0VxrHX?=
 =?us-ascii?Q?T8DftP988csx0Etxey3nRpIC4g8UHuNVnYP8Jtx5UlZ+l+q2+QOBdJn34Kqd?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:53.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3769eed4-da46-4fb3-0346-08dbb9ffe621
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT061.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4792
X-BESS-ID: 1695231296-106019-20111-6391-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.55.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmFuZAVgZQMDk5zdzUOM3SwM
        Iy0Sgl1TjNyMg8JSUlLS3F3Dgp2chCqTYWAOlRWE9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan13-15.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This was suggested by Miklos based on review from the previous
patch that introduced atomic open for positive dentries.
In open_last_lookups() the dentry was not used anymore when atomic
revalidate was available, which required to release the dentry,
then code fall through to lookup_open was done, which resulted
in another d_lookup and also d_revalidate. All of that can
be avoided by the new atomic_revalidate_open() function.

Another included change is the introduction of an enum as
d_revalidate return code.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f01b278ac0ef..8ad7a0dfa596 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3388,6 +3388,44 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	return dentry;
 }
 
+static struct dentry *atomic_revalidate_open(struct dentry *dentry,
+					     struct nameidata *nd,
+					     struct file *file,
+					     const struct open_flags *op,
+					     bool *got_write)
+{
+	struct mnt_idmap *idmap;
+	struct dentry *dir = nd->path.dentry;
+	struct inode *dir_inode = dir->d_inode;
+	int open_flag = op->open_flag;
+	umode_t mode = op->mode;
+
+	if (unlikely(IS_DEADDIR(dir_inode)))
+		return ERR_PTR(-ENOENT);
+
+	file->f_mode &= ~FMODE_CREATED;
+
+	if (unlikely(open_flag & O_CREAT)) {
+		WARN_ON(1);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
+		*got_write = !mnt_want_write(nd->path.mnt);
+	else
+		*got_write = false;
+
+	if (!got_write)
+		open_flag &= ~O_TRUNC;
+
+	inode_lock_shared(dir->d_inode);
+	dentry = atomic_open(nd, dentry, file, open_flag, mode);
+	inode_unlock_shared(dir->d_inode);
+
+	return dentry;
+
+}
+
 /*
  * Look up and maybe create and open the last component.
  *
@@ -3541,8 +3579,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 		if (dentry && unlikely(atomic_revalidate)) {
-			dput(dentry);
-			dentry = NULL;
+			BUG_ON(nd->flags & LOOKUP_RCU);
+			dentry = atomic_revalidate_open(dentry, nd, file, op,
+							&got_write);
+			goto drop_write;
 		}
 		if (likely(dentry))
 			goto finish_lookup;
@@ -3580,6 +3620,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
+drop_write:
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
-- 
2.39.2

