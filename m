Return-Path: <linux-fsdevel+bounces-9786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F1844E06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DA91F2B219
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9920E4;
	Thu,  1 Feb 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ivWAaKn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BC1878
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748166; cv=fail; b=jMp1cPnSEz5Y28ibiUyuWSCVdsPaMYgsFl5j4AHY1zL4HlpCeomzcDQKJrbW+oy0R7+qMfVYlub+ysX7Q98qWohV2ZGte6HOdskyvRtBRy+BcIi3yCUPqwfhnmNYhs0vd7W2uJ2aKTuJts0Qrhc+XPBqr5ACB7WcTya47qtbBPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748166; c=relaxed/simple;
	bh=m/ptzPoH5yL1A/0N7KGTp4a9RJaQ9FAfnMbOGrhBTd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=madFMffOts2O/Ob1UaQEueoqZo0+uw0GOSwokhrAItCCOSP3yniXyKYBBC3ByQ0xUmQA/cuEQVpjlIjN1dV0ja715tJfgMpzH64T66mJktE7dj+l90KlOLNgngIykIK4OxPFfLxaSLzCM3PwADxFXAXwMCBS6ovOGuYcekmxQfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ivWAaKn/; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40]) by mx-outbound40-194.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Feb 2024 00:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbSLEpVnFHP+RKOm+MXqtHkA8mlfFNrBTFz7F9wvZoNLTtFXw3zz+UO0pTb2UDiVTLuPmeiSTDSwZCaWOJOIlEJcSSQRQoiMPKVHiZ13NTnQqPxo78xaCHYc9gtpJZn+C3nO08gLCkqp2FjrLHq01GUJc23O6JiKWvHArG8/tJIGKlm6poE+hR9SesB9xXlxXygUV0HzWiysPXpbbITeWQ2yES17NOQ1Q0cL+rOQxvxoW046FcW+Vf7hUoKRpHuIlFh/nDfXN+CDoKGo9UeQsJR/W7cfgTD10h5iCTC2rIwUlHGni7Dj+zGKx0NMNV1u0JNij5y8fXiJluc//a3dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm0x08FNnubnuMYiWxs7UcOljgY8p0uxUy5CVTAsBlc=;
 b=GwzwOwJ4GW6U4vPQQkINMKUPBDFfJWBMzeWh0dA2km3auRSemeYP6j8v5pWdmNjmvU3K113iKMP32wpnbqG1eHZscfOl7GvcuoxyimPg7dj80SAxSTomgl2mm/0gDubBNWOqwUM0jMuCeCvlDtEIGoRvDWFKK6aUwKfYGd/7cKcN3G2iyWuOKxFjJdRLWH1HgTxJgLYPYTcYUdstAfGnkvtwaLasj8g4k5cjF8HRAjBp4SH6DPQWijXdi1D9z36NcOB2jRR0Sf/SBUIDDDYoq/FaAGYfM+oIr6b+2SzzlfOp+I3uPZ6R7DB2pDxdozWHXYPNF1lteON0KRqMnfRlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm0x08FNnubnuMYiWxs7UcOljgY8p0uxUy5CVTAsBlc=;
 b=ivWAaKn/IVSABp9fBnv9lb98UyOcK3g4lXoyYuzDfGkzs+ino7nrjtd/HXdM/MmmbhKSOUDowy53AEJVzW55IGSSQyhF8ZZd8ZBz92KjY6ooYVDkqfRXe0Ib5BUAphwrnUcNER9FayIkPK65eKmuFGfUJpkctzEEKplcuHGTph0=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by SN7PR19MB7163.namprd19.prod.outlook.com (2603:10b6:806:29a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Wed, 31 Jan
 2024 23:09:00 +0000
Received: from MW2NAM04FT047.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::e2) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 23:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT047.mail.protection.outlook.com (10.13.31.185) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.26 via
 Frontend Transport; Wed, 31 Jan 2024 23:09:00 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8918520C684B;
	Wed, 31 Jan 2024 16:10:01 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 3/5] fuse: Add fuse_dio_lock/unlock helper functions
Date: Thu,  1 Feb 2024 00:08:25 +0100
Message-Id: <20240131230827.207552-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131230827.207552-1-bschubert@ddn.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT047:EE_|SN7PR19MB7163:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 333f4383-0189-4536-d8b7-08dc22b19c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 1qEVp6DJ3i9pomQ0toC3bgfV5Uleet3uE9b8ferQVMKuu0MYqHnS1gjwSL/Wc3SLhfjwabltfgffiAHIFrUgp305taIWzhkbSdSWdwSY0JyWS8LvECr5Z3AkRN4nurbtrnLDVU2oU+KX13hOCf9GY3MP6ayaPCayhpxsw777IR+gE/M7wX5TwGmEDJ+mVwdoSomuExsdquZHQA/BkheMtsp3FdHAYEQM6dK/ysziAjvmEh/4GE8cY6mlGm0T7ky81DghXBE3aU16O7pDoGXmDgea7gIEVKHP+qs/8oV0slfhwavY9uRDIsX1mjeeUK/yMiwzOxGghMX/c4j8dzT+DJ5RG1O85JpHgXQMVzoW0immt8xMzYzgB7qlGBQjpJxXvhV1B5dzgOe7fpjLeBUtaiYOPIGJy0dEzzdqjyngFwsDtGRxG96Gh0Ke2d7M8rZSgF8bsXofVX3CV1Zd3tcDOPdQDQQyO6FQRN17+z/tJVOmr3LcTmvG1R6RfZWIompoYxAuICoiGCipfaGDqqihYyYESLUNbMLZX0dgiXMTQe0+ohOqXAWuReDc2vapVdaxlNijnX2+3PVwJrOH6CEy/o2nlQm/nBCD4nSNXLtSxj2ZljE3NDqwBA69SafW1BSpUIJVq0sXOoluqOmJHhkwl6Z0bEI5/W4p5mxy77ADFXQ/I6mk2o7TJBuadUhBQXI/A3luKuh+U2tspNDA30wtA8eQ/0gZHLaTCln2qzCxh350XqkA+bK57rXIkfXHs8Fb
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39850400004)(376002)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40480700001)(83380400001)(36756003)(86362001)(356005)(82740400003)(81166007)(41300700001)(36860700001)(6266002)(26005)(1076003)(47076005)(2616005)(6666004)(5660300002)(336012)(70206006)(8676002)(316002)(70586007)(6916009)(54906003)(4326008)(8936002)(478600001)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 cAtWfQvT0C+5ffXjfcXrhBisTIzh5sjAijuYZ3LdqLBaJx60ktoa8LrPXl4SdmFyaIWQFC0WQ8Q9hk3E80BIprRYUFEfN/EG9iMHwEetMiaNHQt+p2OgRC8jm1CQ44yRC1m6eFLEQrcLItOJmWW91WcHxyrtTjZJjSs5rSjnwIl2iRDXdMSOobz8MgEN1psrvlx/gFgcNi/5v86sZBXcBUJiZz18LAz3Z/EcXW0zIKx2DamfQXpLYA+shuoDK+Pp9MpI00g55LWEYCvOEVWRpFby02DbaDqXX23ICGLpQcGZIBJisZNmCqGw9DCkD1XgLqb+qiL7UslZ+PsqMAHCsf0KBYVsk9mMUYDxSzJIcGRnFOP8tXzMfhqH7fv8dCzZpxuyUqMjq1Ji92gsyNMhIOMSIkzJWfNkJ1R/uLiqAPCrZX0RpH1P4lN9z7RHfrRN3FbT3/DgyNxmORTAc09xZ4XPV8TAY7CHaT6xqOn5w6k+y7aQ54s3TLQDSMQqRbLfFfdFLgQk6lx4Hkor1k7P7v+pwN6qjHveyqHL+4tHjFABSWeAiMz8rSgvUoUgP8fACqSUk88xI3XKh8zzNF2w8HexgXJdylTD+jFAlKYGCPA0GAZlDhR/scL69fampSyC3gw1e53ikBjClqCXH7TaVw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:09:00.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333f4383-0189-4536-d8b7-08dc22b19c24
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MW2NAM04FT047.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7163
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706748162-110434-19561-31556-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.66.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWRmZAVgZQ0DQxzcIgMdHc0C
	LNIs3AODHV3Mgw2cA02cjCNM3CzMJEqTYWAIytgcpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253898 [from 
	cloudscan17-181.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

So far this is just a helper to remove complex locking
logic out of fuse_direct_write_iter. Especially needed
by the next patch in the series to that adds the fuse inode
cache IO mode and adds in even more locking complexity.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 61 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0c4d93293eac..3062f4b5a34b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1338,6 +1338,37 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	return false;
 }
 
+static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
+			  bool *exclusive)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	*exclusive = fuse_dio_wr_exclusive_lock(iocb, from);
+	if (*exclusive) {
+		inode_lock(inode);
+	} else {
+		inode_lock_shared(inode);
+		/*
+		 * Previous check was without inode lock and might have raced,
+		 * check again.
+		 */
+		if (fuse_io_past_eof(iocb, from)) {
+			inode_unlock_shared(inode);
+			inode_lock(inode);
+			*exclusive = true;
+		}
+	}
+}
+
+static void fuse_dio_unlock(struct inode *inode, bool exclusive)
+{
+	if (exclusive) {
+		inode_unlock(inode);
+	} else {
+		inode_unlock_shared(inode);
+	}
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1602,30 +1633,9 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 * - Shared mmap on direct_io file is supported (FUSE_DIRECT_IO_ALLOW_MMAP).
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/*
-		 * Previous check was without any lock and might have raced.
-		 */
-		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
+	bool exclusive;
 
+	fuse_dio_lock(iocb, from, &exclusive);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1636,10 +1646,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
+	fuse_dio_unlock(inode, exclusive);
 
 	return res;
 }
-- 
2.40.1


