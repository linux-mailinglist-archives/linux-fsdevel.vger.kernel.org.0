Return-Path: <linux-fsdevel+bounces-6869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF881DAB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 13:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292691C2084B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9463CB;
	Sun, 24 Dec 2023 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Ol5R+qVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7D63A6
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by mx-outbound45-33.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 24 Dec 2023 12:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuDLisyot9oPPcKmY71GHlmrgVTfDeAlRauxYJH4MdSF0wYUImQxbwzDfRwgRoevY9gROI8bEHZM/nnCr40SGrcfJAPkWtsRtMo7Rq2+EpT0W/g0R24Nssp5Bg2bSOMu3F+/N5Az8I0hKWEgAdvR0Li+OuMgoVSY01aZnpoaw0CYV49MVnmbKd9e6xrLHmPWr/RZgmqydImPyWg2GNVx4/nQ2Wzj2Bkdxz81Dgd3+HL/sqkWnhiB7IB8OAM3FGFvY9z2zl97T3Y8mPgARs0g4ms/iaulDayYG1ZGfbQp4y55BTB9+JRMSCinYaxnPcGxAuQ8Cpo4aulnRv1KUfwA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqev4BKDzXIKjXcBnqvBj4Bw1+YgK0I7XfDRge+9fpY=;
 b=dY5Joba6tQXDz/5eDbfrcSnb3BBk1imciqS+7qaIVch3Ha69JNv3slK4oSUPW2g5ixWtRoXgKeilb920A0X3DbOLCBeSO2q2vZ5s8mumkBW8jIbnZoBsxYHGd8N7bVwAsjZ2xC2YTsvnMAsLHKWopW1/I/qjB9keoe7tmNYx+tkwYMlUdVWCj9jPxihv+mGj6qWadQFXj+fS2Rg0vt6m/43/XI5xG5aeSW5Ld+IHVXwjWLhaCGq6QyZJCVzckCjnilqMuBn4YEeKiJ+vSWx2qaZdtrcFO8n4bey4oLRS6/XpjGiVsbCGWSRWgGVRgZQoM5RbF5PsUfkEe2arb/WbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqev4BKDzXIKjXcBnqvBj4Bw1+YgK0I7XfDRge+9fpY=;
 b=Ol5R+qVGWTFQG/oH0X+1uME6FpW/AUZh2F220dEAYxjW3RAJxFytoqNY7lHvwIQIiaRabHkN3r+cK9Sg35XR0uehL5eZK8FMZxsBIzJ/2d6xgwZmto9r3JrO1BAfveIIpAURGgHR0KzHVedijEWWRItJcwpatyPrU0f/KuaByzE=
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by LV2PR19MB5984.namprd19.prod.outlook.com (2603:10b6:408:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 10:49:47 +0000
Received: from DM6NAM04FT023.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::fa) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24 via Frontend
 Transport; Sun, 24 Dec 2023 10:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT023.mail.protection.outlook.com (10.13.158.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.16 via Frontend Transport; Sun, 24 Dec 2023 10:49:46 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7014420C684D;
	Sun, 24 Dec 2023 03:50:48 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	amir73il@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 3/4] fuse: Add fuse_dio_lock/unlock helper functions
Date: Sun, 24 Dec 2023 11:49:13 +0100
Message-Id: <20231224104914.49316-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224104914.49316-1-bschubert@ddn.com>
References: <20231224104914.49316-1-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT023:EE_|LV2PR19MB5984:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 298936c4-9107-4d9a-fee8-08dc046e0b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THIZ/rohXpJWrjPzGHglp1mlfFZJvKXCx8XDaFiuADazXWVa7fg38gXoyBxGmf9Uxczrk6NrgplPTf/CW6PoXwTUX2RVenCYUGG9DKnoi1nY3OMqjHfTRfuFqm0eZCpfo7HBs5v5W0lIIRdvgXOx9KtmPRyQdMReOz2Sxk+14AGL8hh6RiIw4oZR8Im7J2Ogj3+dx7wP9jANXU7YasHBNYJWg2O5LFVb0GEXc5FGfNbqVdAG/1hYuq/kdpEychlMi0enRtdhm6gD4VfldpBki+b8eCfjx0To4ZKl/vqbAAuP1eJ8V4aleCK/22IKfoFIC2HpbCXR+1N+zk7i4V04lkMIIeucDRZcUcoWA9hJqICSqZfjRV/r7D/pNvkX7WLhlfyGJIrIkPB6bYLOTtAJ14P5DTeToomp4Ko4EZ5q7N65WF55luDoleHIJHnXM56VSFJsbAHmEGx/6Y044eHxc25VzxBdoOKvo3KWC1jQklKRZ4xppc4lFq6zWIFNT8PxVXDa0ZAu59vbwX8b29er2nUxYb+Gt6faGx3KDGJz3x9StfHpLmQa07p3uAKGh7qH1CTvztc5isk0Jv09nNNZHi5/rllVDCwFdOgfw3GXjIbXbdm6y5tfP1Hs2mmPDE01gWHAVvfBxO9C551DabEB0R9xXb6t98Szg1RNh3e05pnCDJA553N4YToYmENiI1pmi5l8o0RK8zmcrt6c/e2/NxxfeFcOo/6vlLSgwMK+P/ciwkR7wtIhC3dqUkhCFsSV
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(336012)(83380400001)(47076005)(2616005)(1076003)(6266002)(26005)(36860700001)(8676002)(316002)(6916009)(70586007)(70206006)(5660300002)(4326008)(8936002)(6666004)(478600001)(2906002)(41300700001)(81166007)(356005)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q127Ls6MfMNBAQPssM0fQ8ofKbMKZDtko9267WVoC5vK6RsKgOdp5cRqhsPNHTvjNl4VBzRot4KBtiF4SujC5AumjyA+7K2t+rKrhmwyxRZj766HXr6VNOuf49c7wCTu87VghhmJsKoqUHvh9ABVjX7eqvYqgr+v7ITQ6599R/DEOTH2GR4mfbdnc0+P5nCS86anrRBnhpfIdymjXH3/25oRz3wCqQK3R3l5SIKMCpGgGTGwE76NxajpDkvGto7T5CUwnEFmSbyUDBcuiiY7SdZmquJ/jEIvMVnKNPKWikdxjcdATF9NEQ9o8+Z2PpwZYDCTXrXzWTwEaCPBvrWrDXt/7gpY2s4PK3dZL37FJ7O8X33XvbF3NyhdnBhBNolczIFtIUuJtRPXB19D6SRH939uj1/B65REPn+SSO/PLcUuy0RvUZ9EiIkJ/a3FNPPmxmCqvanUM2ahmXtbhzEyXXPCffFcFr2xM4gcJ7O/8eeBD41IWdkhevfKsqUvQA7WBt2LUc56xRUHbJCR9zkMUxNGHEfsZcj2F8uKPYF/IoeUj0c1nbJLhBGsqx046NjMzNdy2NMERLu6sz8SDsvKn0blgNGFTUL9Fuc22FNol4jAnnzUhXgaHgbvHfZJQwQ1KV5ICONqBZqrJdEcj+n+8Q==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 10:49:46.2544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298936c4-9107-4d9a-fee8-08dc046e0b5c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT023.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5984
X-OriginatorOrg: ddn.com
X-BESS-ID: 1703420586-111553-7266-1775-1
X-BESS-VER: 2019.1_20231221.2126
X-BESS-Apparent-Source-IP: 104.47.55.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYW5pZAVgZQ0CjJwMDY3Dg1xd
	DIMtEsydDQMDkpJdHM2DTFNC3R2MRSqTYWABAC9HVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253035 [from 
	cloudscan19-8.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

So far this is just a helper to remove complex locking
logic out of fuse_direct_write_iter. Especially needed
by the next patch in the series to that adds the fuse inode
cache IO mode and adds in even more locking complexity.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 61 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 546254aaab19f..abc93415ec7e3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1337,6 +1337,37 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
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
@@ -1601,30 +1632,9 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1635,10 +1645,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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


