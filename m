Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8E78C960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjH2QLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbjH2QLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:11:40 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8B1A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:11:31 -0700 (PDT)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40]) by mx-outbound9-87.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfP9u7/fUWSuyvaRIskGLgO3C0jW2K5d9akU74G4UnEEAsCs5ydsXRkqyR5T6qLWs4DAETi/oWkJ/f8Z56LykFYlSa3WnO6cP9LlScMV65fBqgwrLrE+Uy5HJuIc2+7AIBJavcgp517NryJTqvLvGZm9SNXCk2aZJ4mrbRDyRmlt+oMHl0WPqH+53BlCo7O3GVLJcgvRaBQoLuTH55RjrjNWv2+n2e8ZFqjPDhb52fFQwJWYNhJUYI4VNiaF41+/pPkEdC6Yu0u4iUXJEzBhfML/euLWASPW9P9oUaRrstPgyVkroGkuzwqf6wGoNBwSpPuZVj4HLXDMqPqkxhJ5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N73J14S6iVjrMo69kd8oOZfM3yutZXQ05yQBAuFv9Vg=;
 b=Qz0AQqQQJfe+yoNKv2ZGlzyu8Jzw2lZgS3uCZL/w8nT1BhWXE2DmJpOPAKMQ44thExrO6WjjvyYkIcAg7bV2I9ezRj6oVy1ULdmvSpeH7p56i8iz1wMh3NVaxPttV3urJ1JqesTTA5PvFiLRR/NwzYkRUjZjddTLNlHm3uVQ5RspEi7C7YI24wMTHnQQ5tBrcje9/a86lqNLmYcaphwlkt3nVBPrOAYWw8nqckiiM2nTmePGIMldrbDh7qNVRAsdPUM9pVNW7BKFG4S3/HvMWBlvD+jFUjyqEhJS1JRIbazec0eHfOi4CmFcdFaeOAVJN0xevbrh1U54k6wRmD0toQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N73J14S6iVjrMo69kd8oOZfM3yutZXQ05yQBAuFv9Vg=;
 b=pcH+uk2QLcS07REu00w6u9sZNvEcsDN8eboV4LqewoO0AQsoZ3jqF2ACD/VFzIQWZ60EfDcJDnyxquDay/khcbBZpmnZE9AW4AKffxkXqKkoW3i3HBo36Lmr9paBhNkXKPKi1yMW+dFPWpmfV9djnU2tffdHC6mYNwTnmvsBSUE=
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 MW4PR19MB6823.namprd19.prod.outlook.com (2603:10b6:303:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:11:23 +0000
Received: from DM6NAM04FT019.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::49) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT019.mail.protection.outlook.com (10.13.158.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:23 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 583ED20C684B;
        Tue, 29 Aug 2023 10:12:29 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 2/6] fuse: Create helper function if DIO write needs exclusive lock
Date:   Tue, 29 Aug 2023 18:11:12 +0200
Message-Id: <20230829161116.2914040-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT019:EE_|MW4PR19MB6823:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 290ffa24-bb5d-4572-db0f-08dba8aa971d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxzVWZpldVWO9Z4C+7yVKB5czX2DJTw8FDA+g9vWvndJZkm1Qmc6t/GTDe0TDtrAFqcBNitgjBeOoGECbLAOyjOTmIc1rgMzJlGcFWNdJU60KQ3tiK3tRfP9VEtizxr7ub6vUIz93A5SgxlPdPsw/rlQay2imOWrV1qEgqAYR+TN+9v3zKzXZf/UF/+G8z0iX3QH8wlimLjiXbV6Q9ljgW25sBozhq9npX/mG13GfxZoxnRe+gcOW79AL9PqtoREdZ9+zidv05Tk8sygECgNR6rzan3COkfJPneEMTxWNdYDsQu45FAm9gVnSgdyG0D85L7/GCMN712Glq2fodxUZ5NK9VsfB6Hq/vcjt340L+x5L8HY/BztNA2i1SrSFuKlYjY629iAgbgaGb2HlSi/nnQuImbDtpeX1azK6JBZhahQ4BJHINAk+Low4Yj6FzJUgHwoiFSEFy+dv/aivTxdM9Pe69Gme4rba1WmM+4D6EoFHtJrjK9tobJ9GsHe/djpE0mMAiTOmLnoYyIVGOAhEGh1XJ24kpmROLIlyOLDRV0+pt+TCFktat8ODMPW772gDCcTbEfy9dJ7SIDgq3PaSMhpGJF3V+T/eY9Wknp9QFOKOioZNmWJynowVRjvUCet0yWJrawfb8mz3r+w3oi0UgH0qNjLYbn0LfWjsPCC/uXyvrY/5D0RiSZKS7iISQrCSwU5tUiFV7pVpVDv4jyjyGaHdnJ4xxxKGZ6e5nFUKQ8tMY4ikQ7lwqbB4Njyp2MT
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39850400004)(136003)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(6666004)(40480700001)(82740400003)(86362001)(6266002)(36756003)(1076003)(26005)(2616005)(336012)(83380400001)(316002)(6916009)(36860700001)(5660300002)(70586007)(70206006)(54906003)(41300700001)(47076005)(81166007)(2906002)(478600001)(356005)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JKOE2Mszv4hdnRt825bidQxSB5JtJz5UOzA+DlZHmllpT+rFp284OXHihM0H4U4Qq+tA2MajDH/zaJ7iomPNQJCss6uUI0M6J45LDeUglc+n9rnZRgOOdW2XcDbJQPHfTI1gYJf79yLBDp5Nd9fxNPw/ArSLJJ4T5Yt+yy/4E0C7APy5QwABm3iwAC+ncLVsAK5tKJcWEfL+/nnCrCLyKqvh3PeAC7OiC0Gb8QGXOKOdOujcBvCNii1z6VM6V4vxVieN0+om0QMCduzQGqz5KMhOC68+jPBo4VJErJoBrABvDv3vQvA2WfAOmNHl+sxE9D/v0Uen/kUXkyi7a2J01OB/2hQHcXLWet9/1CPtB/xQ3Vi4mgkcbumM/4AJOrCK4lLwMzpm+mu7byI/R/rjQ+CVAUh9ho9rrypLTQWwXtf4OwiF75is4gplJYRz38P7B03JxlImgVz9I1ufrNIA9msIyd9Z7G4bME7hvikhU2kyvbt9v2Hb2nbu1OmKLtUGn6z5PeUSmoNEa9HMHQ+xuD+0BrTrpUjpmY58YOg9mzKguxw9s/8oDyUxPWS4hBnCp7y9gUpTyeWVhUxpfAlmDtiRvkHsgC+Viu4U5VDLK5L0+qYew9XMDkUdr0J0Z3plz02KDqrPlS8L5SdfZapa8Cycw3g69jKzF14PbAasS1WMRHloB8+0Y7Id184SoZ3oFkoPjCmNYjyrKmB8ULHAaY9BdbdIRkjsNrYBl/e0EQJUfe1snWZ/CwOJbWwCem8GxJG1XN9Nqr2pOtpE6at2Je32EM0fbAaMQ5JtVGAPuNa+JlervyPObnYOzTzs9qhBZ9XiULaukHSpct4XZjJMzDVSzvNIi9USib08JdyS/NxGfn8trM2vJLj2mPzRJakvA8p953dLJMN+fNUKJif26w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:23.5498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290ffa24-bb5d-4572-db0f-08dba8aa971d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT019.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6823
X-BESS-ID: 1693325487-102391-23029-27-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.56.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWxsZAVgZQMMXQxMg82czA0M
        LANNXAxCI1ydjYNNUwKSnZLDXZKMVSqTYWAO9Jj8BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan22-221.us-east-2b.ess.aws.cudaops.com]
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

This is just a preparation to avoid code duplication in the next
commit.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b1b9f2b9a37d..6b8b9512c336 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1298,6 +1298,37 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 	return res;
 }
 
+static bool fuse_io_past_eof(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+/*
+ * @return true if an exclusive lock direct IO writes is needed
+ */
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	/* server side has to advise that it supports parallel dio writes */
+	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
+		return false;
+
+	/* append will need to know the eventual eof - always needs a lock */
+	if (iocb->ki_flags & IOCB_APPEND)
+		return false;
+
+	/* parallel dio beyond eof is at least for now not supported */
+	if (fuse_io_past_eof(iocb, from))
+		return false;
+
+	return true;
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1557,25 +1588,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
-					       struct iov_iter *iter)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
-}
-
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct file *file = iocb->ki_filp;
-	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock =
-		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
-		iocb->ki_flags & IOCB_APPEND ||
-		fuse_direct_write_extending_i_size(iocb, from);
+	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	/*
 	 * Take exclusive lock if
@@ -1591,7 +1609,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		/* A race with truncate might have come up as the decision for
 		 * the lock type was done without holding the lock, check again.
 		 */
-		if (fuse_direct_write_extending_i_size(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from)) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			exclusive_lock = true;
-- 
2.39.2

