Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8247782FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjHURsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjHURsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:48:39 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67110E
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:48:38 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175]) by mx-outbound42-169.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 21 Aug 2023 17:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE9jZ519pYIMIPgf4km8lH3cDLElRRpnDqkmExgaW67LoGPMbxxOin3LEkgQs3T/pmX1pP2vFlXXR2EFvxHnCdUrYfwHaU5f/NL4ayaMJqWJAuWqZMd2/TEJiR525DEU/tkGCKMjJVtL5zHKxdrWu+YcnQI/QMZ6twQXPd6ZZ8O46PbSYQq/Bsq4DRWOqVrlCJSzAHv9S8CrVts6uAu6/McFs8zKc1XWGepu6iFqzRWHcNGabmLChjLHCMWlv0lRRbW8/Mq2HUXLrS3dPa63hhGPkLtVPZ2t5oObovmVKwKt6FtnmYpJfmBqm1gpil+fp+P7iCvd/6EZI4SHDeRKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wCocT0Ef3APrspJqxezdx96zYst6WlnGf5jJBzIIR4=;
 b=bu8Bz357XT7cjlPO96BAfxU+r3oAmmgRCMAHUNqvclCyk1ZROwCJZ19qIc4Qg1CTlZbJusVaOddTSivBnJh19lGg7XlBc2z7Kk9EjNnGTRV+9xiKqAp95VDDsd2M7Qf2SA0jNjLlrat6Oyfhtk1KsQ9Qf0TXqtxBLG53aIm2y3VcMPefafCj3ga+/DYhAAThSiVaaMqeE0dLWAbZFhz5U1JMsmMKwxKc/XV2XxTDyy2M1lmxRnOH1lJxK9hlHH/iXHkiGlBCL5HNo/R6LxR96/LfEmu8xCJKuo+kjGuK5K0Al6edWuePs5miR20TX99ZVL5flgCeCRwI+UATXrApUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wCocT0Ef3APrspJqxezdx96zYst6WlnGf5jJBzIIR4=;
 b=0ZnVv6d4SG4kwP8lDZIvvZ9/PP/t8QkmXQEzqXtBvg1KnU33Z8U4v6Q3rYzV0aZz+K1AjQYIHBRvuOuGA4eL1DDBP5crMIS7HCgRbW+tcrybfWRFPXjX80ZT/2GtxCMANclZMuRPDCwaRSYJmfZ/7FiNJGXJp19Fodq9RDejH4w=
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by DS7PR19MB6021.namprd19.prod.outlook.com (2603:10b6:8:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:48:00 +0000
Received: from BN8NAM04FT012.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::91) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 17:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT012.mail.protection.outlook.com (10.13.160.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.15 via Frontend Transport; Mon, 21 Aug 2023 17:47:59 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7324020C684B;
        Mon, 21 Aug 2023 11:49:04 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes always use the same code path
Date:   Mon, 21 Aug 2023 19:47:52 +0200
Message-Id: <20230821174753.2736850-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821174753.2736850-1-bschubert@ddn.com>
References: <20230821174753.2736850-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT012:EE_|DS7PR19MB6021:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59bd48c7-cc8d-48ea-05f7-08dba26ec2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mW7SM6EiHpsAIUc8ayVWmgDJdfKyutcqYuZGOS+ODeAXVWuJST6U0BLUE5av9p2FMEx3SHmRKOyyNxIT37c/nDKOe/iWup+mWAnvbj1tQAim/wib5IUDKwkAxetfS2Mw6sZuhPKv32qF0opnsIBLljLIcEMaTMzJDqBExMgA8FleE1pet09JzdjZpsWE+jWzuiDDeSnkoGRPp8xfvxk2+2znJNVk5g77e2wQdsvaizmE1jwF05d4thXoKJpOh7FleESGHZCg/vxhxG45feTP0si3BBgZ8juzpbS4qhY19IZZ8VyG0T+wesNYnWfJaKw7AB+F+Z2p5XWqpgSHrnrgYjfbgkthSBfrdWAxzCZhoSwfzd5KUdYAalg4M9FhshnF4JLG1gnQsW30dm4tBTUPnYcxKQbq4BYVKL48hUAfas5ogJ9hVTZ7LuO/o8xjtiyyS9GrXBVDzAlxlc7WSL55W4E0nMBRyyJ8GNSTotWV69NmSu/eu8PXHvMuPGpp2L2qYurBV733K/EQmRg4NOHoKC1bLer//MiMiQCnoKbc6tUR/5d8z1ZlF5xqkfHeC73eOuNiF3/nBjdjq07dbUBhfW5uevH9zGX9x0b5B8KepTNfdUOygulZpOUjWMNc8nl2iUJcLZdaXizapd96fQntreIhefpvyU77r1mFvdA+8zSDfyUjefDb8TuvHRKLUQQVmqH2wSnieX2oZoFCP288KGf3PKakyQUasQItlA49tBg2XNOq41KAA7NnQTbnAIrZ
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39850400004)(396003)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(336012)(6266002)(26005)(86362001)(36860700001)(47076005)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(81166007)(6666004)(36756003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?33yYUmHvAwwp7gL/nXzGwv/muRRNZLMl01bn8jMPiE/GfEtaxqLyaT1QVtsD?=
 =?us-ascii?Q?fS2QUQEfdWPYqMiy7JIhFq1dXXMlBH57kHO9+UFQtg71ZyubMEnFpTmOglft?=
 =?us-ascii?Q?sJ+blg8vM6slSuhwvigwd5Jfx6AUqr1EgC2hxuzCJPXCAgARhplzleyukOHy?=
 =?us-ascii?Q?+zVC/X+vJ+OX1DtlkgacZcbBQIPmBJ2FUzoHPITWTmHwmB5I7yycwSckl5VU?=
 =?us-ascii?Q?oDe4ZcybCttRmT00uq4AFbk8bO0TVm4VYIFZGZiu514T3yl2Zw8womwNMr+2?=
 =?us-ascii?Q?aAk9O/kDITUiUPXsVsF8Ez3MBqLNH2XNXYvFhPBQ2ipLKd2Y/hP6P5981SUt?=
 =?us-ascii?Q?9i7IBWMDmdIAwfnyOOBJfCrNA0xfGphAs7wrzz3XJDfpOzpeIK0ygjhN3yY2?=
 =?us-ascii?Q?xweSO7I+kMZ386d0QQi2rwKsRkl0TpiGSc9JtbgK9IzLPUodF0kwVswdyK+X?=
 =?us-ascii?Q?ATHrewCNS7AfPaEHKvBhET8ds62uuEFv8PVINS1b9/84AMTLnC48Bv7V5Fwv?=
 =?us-ascii?Q?vzqLZGMprv7ypWRk9jXUPDBfAk2dkHc4vKOpOSpXmLKkNsq/wO4S0RHVm0aP?=
 =?us-ascii?Q?QfMqOb/M2zSzJ4RNVbVO/2juKSwxfWJK7FAhg8WbiYZX024EycfZkeMf3tC7?=
 =?us-ascii?Q?eotX8P0JYd4Epwghj982sIzcdrrR+bWeHVcs0q6R6BbacOalG+zGoX5zNH9C?=
 =?us-ascii?Q?FEcx53WG6EkQrN4nP1G6LmLs5L0ouipE9b3E1Ekxd0oKLX+TDbm5h/XOkokg?=
 =?us-ascii?Q?yrRD2jAO/FpTQYnyfN6xZOJO7LlLcQBXTFi3mTw2NIAbSZghozu7+BXMqrcK?=
 =?us-ascii?Q?yrXcwhAaqTQTojKSYyyYsdLvULBm/Pvc5Jy7BxBhzXwPxSnFgHqh6jLkqiK+?=
 =?us-ascii?Q?5ATW1ljNHK5GIX46ZdYCnBpOSpGpT7RE57t4LkKT6WMK6ORSYAK1gDn93Iyr?=
 =?us-ascii?Q?UbwKkGEdS618X8z6RHBz6T8Dte1yKfL6hv71hLETxOw=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:47:59.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bd48c7-cc8d-48ea-05f7-08dba26ec2ab
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT012.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6021
X-BESS-ID: 1692640084-110921-17962-17798-1
X-BESS-VER: 2019.1_20230821.1520
X-BESS-Apparent-Source-IP: 104.47.56.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGpmZAVgZQ0NjYJM3AwNzE2C
        zVLMnC0jItLdnExNQoxdLYzCTFwMJAqTYWAKBhKrZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250295 [from 
        cloudscan21-133.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There were two code paths direct-io writes could
take. When daemon/server side did not set FOPEN_DIRECT_IO
    fuse_cache_write_iter -> direct_write_fallback
and with FOPEN_DIRECT_IO being set
    fuse_direct_write_iter

Advantage of fuse_direct_write_iter is that it has optimizations
for parallel DIO writes - it might only take a shared inode lock,
instead of the exclusive lock.

With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
path also handles concurrent page IO (dirty flush and page release),
just the condition on fc->direct_io_relax had to be removed.

Performance wise this basically gives the same improvements as
commit 153524053bbb, just O_DIRECT is sufficient, without the need
that server side sets FOPEN_DIRECT_IO
(it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/file.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..a5414f46d254 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1338,15 +1338,8 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		written = generic_file_direct_write(iocb, from);
-		if (written < 0 || !iov_iter_count(from))
-			goto out;
-		written = direct_write_fallback(iocb, from, written,
-				fuse_perform_write(iocb, from));
-	} else {
-		written = fuse_perform_write(iocb, from);
-	}
+	written = fuse_perform_write(iocb, from);
+
 out:
 	inode_unlock(inode);
 	if (written > 0)
@@ -1441,19 +1434,16 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
-	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
 
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_relax) {
-		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
+	res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
+	if (res) {
+		fuse_io_free(ia);
+		return res;
 	}
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
@@ -1463,7 +1453,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
-	if (fopen_direct_io && write) {
+	if (write) {
 		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
 		if (res) {
 			fuse_io_free(ia);
@@ -1646,7 +1636,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
+	    !(iocb->ki_flags & IOCB_DIRECT))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
-- 
2.39.2

