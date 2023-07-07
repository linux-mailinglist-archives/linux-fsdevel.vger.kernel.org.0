Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27574B275
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGGODS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjGGODE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:03:04 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E32680
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 07:02:57 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound20-31.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Jul 2023 14:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqidZSd9ewbpgeBhSDl4AuYUKwIEz95JO5KOrfjQGogViX8YhM2gHmeQUfdtQhwY3lRr0wrCPtjgMTdmxnAcXXgKCYykwX+SHJgw1x/PDHa4HyYzMzGblT1s1jaVpHwaESVSxc+LtHqAHdrD6lcQf/y3FBQFXLEsyBQl09/TtN6ecIRtgjO1t0QQMiA1BOOSxfHj8jyxfokbWYqPCFCMgdwo7/SRKvQ3oTGCfSJHi4a9bjEqWiYs2ldqP5NFIs3tKxVvkEUqs4ELwqta9Fc6K67K5uWX4peXVbvJlbkP5lRvg0PB7ZlBInzK2yy9cszAm38/OZg9m7k7F1oAZwSx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk5zJlbisod+Gyn2WyWd9x2lZl4v6BuXTqNyw7BJJts=;
 b=f85hCdia5rHjAOosmVQUiai0Koao9hImsw+hrnfOa1E+y3TqbLAYPejG9gluieTbLJzPtDKc5+uAJHlVYg+poyEM0jOfuM2QqNmCZDJS6hGbd5iWmthB8zqONI9ooFrAx12ojtTuujUIcGSzM+n5ETo1Rgoq+PlCyFZH1NSgxPsU165eWnjG0Mi+QZht7NbVL5btqDbZ7Qpf5Ppg7wyNRGarsjC7fJgWx9K9ICjwv1fHg2DuOz/wcepVBlbyfS+8APjZrWTGS+y2tLxqdP6LGxHF9+bfXUb35njzkMWzjVWkb39xuHL0yE9vOi+cEqXi9FUFQoSTOYSfbxaRNK6XaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk5zJlbisod+Gyn2WyWd9x2lZl4v6BuXTqNyw7BJJts=;
 b=xKkpk72rqpZGnJGI6iJuoqUu4WB+0nD2eIZXo902w25fnlegDIGILt5Yjo3WNKOh0pyg9nn+QunWJAGlLcwRBgp4Mppl1OZAwK/6Azj79qg6SSgSMzP1lEFweAQWERxW7nNDGu/5lU4NW8qTqLiK5cxpq5ZKVZ9qm3WFuoJ83jQ=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by CY5PR19MB6469.namprd19.prod.outlook.com (2603:10b6:930:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 13:28:19 +0000
Received: from BN8NAM04FT062.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::8) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 13:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT062.mail.protection.outlook.com (10.13.160.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25 via Frontend Transport; Fri, 7 Jul 2023 13:28:19 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 224E720C684C;
        Fri,  7 Jul 2023 07:29:25 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu,
        fuse-devel@lists.sourceforge.net, vgoyal@redhat.com,
        dsingh@ddn.com, Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 1/2] fuse: rename fuse_create_open
Date:   Fri,  7 Jul 2023 15:27:45 +0200
Message-Id: <20230707132746.1892211-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707132746.1892211-1-bschubert@ddn.com>
References: <20230707132746.1892211-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT062:EE_|CY5PR19MB6469:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f11133b-14dd-4b35-fe30-08db7eee0748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbzz+ubjhtMpB3DPAraFvNoK2h5FPh3DD2VMGbZFBUFa/Z+CcunhBfH+2tMjotYvCtXjcZ0KPoPo6BMqqpxZCKOP5yuYGBOt6bASmO/u6tiP+tfwb2wX6vWZJojppsSCNzUhItQ/uyJYsMLPYgX0AAoyK7G+Uw5RHoggej76eo3HecAio5ROl33Oxq+dYHmSN0Ds/nr6sWno4Ftug5mAXs2Si7C5xuSxdB7ZEgleHZK5tMEBEBrqUNRNjMPaOtaCM0mWXynoKzxqdyzs6IfmgjahTcNp2vntAkDDiJgZv8ypv2riJnwKutLdQuPis2sTICVKyq+Q66MrTYDyy2RQO3mEsGTdZmPkVExCvnnBZ87y7a0ZifbfYHgTy5BFr3Hv4Tki0SLz8UJINCALS58vvrDAAABdd1M3RU3VPLKIa78b/mGql6GaV1qGJl4W6ztnnNNvslf8wtkTCIG2l6Tk9ozI8KvdlhAKbpxFc4uHnm8KC8sF0dP+2fYUiidEEVsgsyuRW31Jfnl1jETpmuMUxHmrrEFxs556OxuQEN31DzOb+5Rh4EILI/KOXtEQsbS+aOMADYB7ollX1Fja4cX0nINu7Odd5iIN6CQPKzf7mPpbxOH+Ie6zBITRhOuD/rg+LAtSFnyPot46EFaT7BIoFREAvkA1wT5siYJnsmucKLY9RVWCD0Oeg7rjgkXym8wY0RXweGe3ZFwp1JjoHxxQnHMeiA0kWZzFaA4GWQ+SHexIv3y1x+7w6a2yLMui+k8v
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(82740400003)(356005)(478600001)(6666004)(36860700001)(47076005)(2616005)(336012)(83380400001)(86362001)(36756003)(40480700001)(2906002)(82310400005)(26005)(6266002)(1076003)(70586007)(186003)(6916009)(81166007)(316002)(70206006)(4326008)(5660300002)(41300700001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yl65ravPt+q6BxraXBsfm865pFb31qKGXSUAXjiQG4LK/W8cJUoNwlj/A/41?=
 =?us-ascii?Q?VNyjkk9OCE3fgN7GVBhSQDqK2L7Ss4lmsjZXKcjHEzKu8mRWKJd7AT84/zIL?=
 =?us-ascii?Q?E9ItVAwdTE8EF7IUwyxHrX8tHYmLOmB85IcbBnYONr1CXfpE+rC5c7x15Lba?=
 =?us-ascii?Q?8J7YDHLLnlc5DS58LwjroEehofSy2ibBqYqvCmGgY8rV+OaGiK6YHgCgL1BG?=
 =?us-ascii?Q?fjf5SV1gnloiVXDcBQsZ4vBBY6HPipV83QTE8ZgBKJvziyHOwAXFEWMA++LS?=
 =?us-ascii?Q?1NHMS9jYpkztdv2Ykt7JZYM/ItJVYwKEmogvSlMew0xf4bauBgTQSrFSZeKS?=
 =?us-ascii?Q?7UVlFXqR3aqv8ktB1O1Elr5533CdONFbfxXKXWSIM+8j2ltnDOTzKd2WrAF+?=
 =?us-ascii?Q?A8KYR5ASjnm0YAcN9zBaOEpi5Bwl3ePHqJj7Qrhov/Vtj+NSSuvda3pyi+0I?=
 =?us-ascii?Q?lCueevmd2I2mYe58KjPlkktwH+e2NI0OT7qy0MEaXpZnYIz9ED8VmjK/88gM?=
 =?us-ascii?Q?URg5z505b1IlDGjsLJbWqpC3uF69SqwJnxICQliAhsQggJr2fmg2huISShZs?=
 =?us-ascii?Q?SuApLABOV8CdIrWtqsrVnhuE7f7lvrAegHLYP848Po930+UmbbV0G2MaIQuh?=
 =?us-ascii?Q?a9K5Em+vXUIHZ76NW+Y3bgTSuEOEOXYngDxChqt/kf1//oMVRuJ2Ukky3B9/?=
 =?us-ascii?Q?sTOTuzBBR+9WekOtQ81vKFCeq8WcKaptbD35CK/kT4a6bRDnNKExzj9X02uN?=
 =?us-ascii?Q?djVsk3j6ax4Aifx2bwZ04Bv4YaRBsz+ld7LdkuduBnd99YC86UNTwNomvDmN?=
 =?us-ascii?Q?6WtppOVBdMV/qPMGjNfN9FwPKicFr2e0oPjAzKe2vmeKy381HC40jIZj7bMn?=
 =?us-ascii?Q?jv2EzPNVnBElURqwMbBQva+w2lXJkAWHqE7ozWDYnNHa83xalFAcZk/z8mM1?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:28:19.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f11133b-14dd-4b35-fe30-08db7eee0748
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT062.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6469
X-BESS-ID: 1688738539-105151-5518-8259-1
X-BESS-VER: 2019.1_20230706.1616
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRhZAVgZQ0NI4xSLFyNjIMj
        ElzcDcJNk40cLMLNEs0dzULC3JyMRCqTYWAIR61WxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249330 [from 
        cloudscan13-45.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just preparation work for atomic open.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..6ffc573de470 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -613,7 +613,7 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
+static int _fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
 			    umode_t mode, u32 opcode)
 {
@@ -753,7 +753,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = _fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -879,7 +879,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = _fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
-- 
2.37.2

