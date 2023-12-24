Return-Path: <linux-fsdevel+bounces-6867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520981D8D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8482A1C209AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7613C26;
	Sun, 24 Dec 2023 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ePAQgytH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EA2565
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound8-113.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 24 Dec 2023 11:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF64B82m6VyJvTw7675vKeHPKa0vw5C/3vL/0e05X2WSjRM/Xz57F6L/XWoLKk4wyw52ynUQN/eWRfe9YKlj4whOqkKtOUcwVUUHTifvUF8UpgMvauS9Hqk5WMRoiT0lYp7Svz8RtcXn6joZ1ivFCIIYQ5+ArStTnT9604oFGQpwhz966qdHvnAuGMP60gIUll42/fFN8D+yHJJxAO2kMchRuKy4mMt3NlKrVokHT8U/P3ILAt/SjCv7mWjFyMBwh/jAjouIDTP7CNHhA7EMdQX/3SqJe2eQujN7Z1M51Fi9yNuzPg8XJ31l8hGl8XDW9JIUljOxT/IcL0frubxHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtUsS3++EPdQQ3bmPIiTTKoLjxFW6sQ8iIUw5Wezmr8=;
 b=ItD4JhnlCanfe4/Hw2G/IL+0CkJ/FkoC1QAgB1iJPWNMYkiwdJ3DFgzWpzwrd3yyqWQSsTrfgeMaO/+lN1JvYTQpMPzVLLZZLhtQvRVU2r0mS4j4gZU6lUl7Xn03Y7dPlzeNavp5idjpD3mXdQoZA7+r+jqWEzRJ7iNkfbzvW8raayT+VEtIlPJ+pXtcJXun46SFHwLheliJCmVTis7dSd9q2fwBGLTmmpfgKdRCJ2lxr1hTtOV+2qsRxJVW91q0dPLZL8H8n5uhrytmMmNI7+5XG8AiKfwcgAgl4tMqSefDfP9i/NfW/d2XXunBXtmepfmCfMbijKtnKjFfhs9Irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtUsS3++EPdQQ3bmPIiTTKoLjxFW6sQ8iIUw5Wezmr8=;
 b=ePAQgytHDBaB8zbEQXHe2Uz1X8XPyzKWH73StmN8MmL+miyU4yjlG/ucGnC5A5kmYneMLbaEdpyku65VKdHRaR4tvJXiGGNEJzjg4McKApq7cIwcEar2Dm2MNYqxDiz5MholB7f+pXEtVF/st1bs2B4LZuyYCIEQqcfnguY05rA=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by LV8PR19MB8371.namprd19.prod.outlook.com (2603:10b6:408:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 10:49:46 +0000
Received: from DM6NAM04FT059.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:1e0:cafe::21) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24 via Frontend
 Transport; Sun, 24 Dec 2023 10:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT059.mail.protection.outlook.com (10.13.158.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.16 via Frontend Transport; Sun, 24 Dec 2023 10:49:45 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7608320C684E;
	Sun, 24 Dec 2023 03:50:47 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	amir73il@gmail.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 2/4] fuse: Create helper function if DIO write needs exclusive lock
Date: Sun, 24 Dec 2023 11:49:12 +0100
Message-Id: <20231224104914.49316-3-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM04FT059:EE_|LV8PR19MB8371:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b08b90ce-f5f1-4371-adfb-08dc046e0ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HJmx0s6VhGeju7siwMIeGv+qcmcA0jpdZM6BpQyaOFNeVYGFdZquKzmstPK+wV3Qg5eWUaA3YOjo9FwPrq2PdNQqG44MVugyLygX4AbtwNBqeOH+8FslsChXGDXoH+3scll5wv6KcD6Pg0QDPY2Rj1/1dIFoCixOjbm685HeiUsjtldGnmJ0NdwtWqVQLfijDaCG3Pr8CadpizXKSN21l7q3d0cg7BS7kLuH7fUQjM4kW2H2xi9LzJ1JFVMJMn39NDZbppFgCgAsGdvpEl6KbryflMwdU/GiWwGrAjD8KPuYehW/lD3OlJ+UtmQZuH6VQ6eIL35buAwDN1+x1kKGQRLkDm1ehzMWNBE7a2WkKmTZRFuGWIiBlld223X/IcVZFTVLKkpRaKMTZLcS8g/VKv8gamWl+8hVBrpia/rs3usEu8lh8AmDh43Nw+bW+7474Y4tkTc5RygBGDpIYp+rma2H0VYG5f1Pcs4KEaKqMCLG2kZ6x+MnGQhyuBOD3mYU+5hbHlMcUN+LWsU6/IROdshIqr145+aLhF4EBmpoFl4Gk1U4mI9pl7ZffHwYlw+t6bJEGe2p0I+W9mGdDOB9yt4LsZKQeCkzjsi9woyysLfiBiOZfzCgJ/lmyBOswjW2Ph3lxOb3p69SH2AsUKIDdBzrnHU5ujGlAKs7WY09I4oUagq4m3bgQud1fbxDEoVb+5CGLVRd56isww54tsqu1fnml9mkJOFHpwT8vKbPww9xz8SuxWtFr7R3cHmxOxrQ
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39840400004)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(336012)(2616005)(1076003)(26005)(6266002)(6666004)(6916009)(47076005)(36860700001)(5660300002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(70206006)(70586007)(36756003)(86362001)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jEd4kv5kk+4gKQo1bGUJVVT1IaTUoDy/vuYQD+I22+1qj/I9Mz2fowgyK7v8VbwRXYktVULeiEAc3OogzKTE/sZv1zZgbWAzUxH0QuEtwDTiasZgOHimJKjU7yhzJgDU26DMQHAeKseBs1VUFc2oaw7O7ikXtjNEDaYLvdJ3v62gsUmfDKQxXG+cKhj8+jGLa803mXqBKh8/ES7w1zhVO3n2OecJ5rfMIdeIIwM1cfjhfF51E4SbXHKRzFyC+7nKv7KfmtJ7dNKOs3iscVG8S3YMVU27ldRu583ZexYJWDq2xS6TWijUJcBGbcDskIXm86tYKdVJtivkQN9JAqs9HOvQctVeaIe75ZByfHnHm3IKVaC520D8wNNouFIDkC1sRBnhGjwHoGUg97MX8dcXaApvQntOC3qDxl23tfnimNW2G6zc1gAKYrEJCBNSzGQhJe/FZkRSUuud+XXLpoBtJ9OWLpDNLENyjVwq5HtqY3ia14CTpqIQFNtrS9TeH6meA2a2zsR7x+v08MbA33Ur/1DS2NO6eFBpJWnZEUvMMc2jUEcnoV+ewwYa+Xh6NHgoGYcMiXscljqBtC2IcCfqUsP4uvUZhqErgZ5CwZSGk6cBdY7+Hr1xcQDWNsUEr4DMCCRtaJCNR3rmLqdXWUpbmQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 10:49:45.3348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08b90ce-f5f1-4371-adfb-08dc046e0ad0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT059.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8371
X-OriginatorOrg: ddn.com
X-BESS-ID: 1703416983-102161-26459-3586-1
X-BESS-VER: 2019.1_20231221.2126
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZmlpZAVgZQMNXE1CDFIsXSxD
	jFJM3CINXUMtXMIi3FPNE8zcDIxNxQqTYWAI3wnmFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253034 [from 
	cloudscan16-212.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This makes the code a bit easier to read and allows to more
easily add more conditions when an exclusive lock is needed.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 64 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 174aa16407c4b..546254aaab19f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1298,6 +1298,45 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 	return res;
 }
 
+static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+/*
+ * @return true if an exclusive lock for direct IO writes is needed
+ */
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/* server side has to advise that it supports parallel dio writes */
+	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
+		return true;
+
+	/* append will need to know the eventual eof - always needs an
+	 * exclusive lock
+	 */
+	if (iocb->ki_flags & IOCB_APPEND)
+		return true;
+
+	/* combination opf page access and direct-io difficult, shared
+	 * locks actually introduce a conflict.
+	 */
+	if (get_fuse_conn(inode)->direct_io_allow_mmap)
+		return true;
+
+	/* parallel dio beyond eof is at least for now not supported */
+	if (fuse_io_past_eof(iocb, from))
+		return true;
+
+	return false;
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1557,26 +1596,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
-		get_fuse_conn(inode)->direct_io_allow_mmap ||
-		iocb->ki_flags & IOCB_APPEND ||
-		fuse_direct_write_extending_i_size(iocb, from);
+	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	/*
 	 * Take exclusive lock if
@@ -1590,10 +1615,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	else {
 		inode_lock_shared(inode);
 
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
+		/*
+		 * Previous check was without any lock and might have raced.
 		 */
-		if (fuse_direct_write_extending_i_size(iocb, from)) {
+		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			exclusive_lock = true;
@@ -2467,7 +2492,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return fuse_dax_mmap(file, vma);
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
-		/* Can't provide the coherency needed for MAP_SHARED
+		/*
+		 * Can't provide the coherency needed for MAP_SHARED
 		 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
 		 */
 		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)
-- 
2.40.1


