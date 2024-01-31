Return-Path: <linux-fsdevel+bounces-9781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBF844D3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907351C230BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257103C465;
	Wed, 31 Jan 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Vy0LFGZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1F3A8C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744556; cv=fail; b=k8KOmv0hjn4EBs0sekR6WfneT2VDAiYb2iPOVuA9DgTKtcfmJ6791Hc3xnQyeW62WeNLaeT8+ysKCmg8+r2mznT7FGvFhWhUH88Oq9cvVwvRigsuzgVPGKDCjmhiXbIepEUPO/kgPNlB8uAKhaeiwMlNM/mQeHA7jEMAy6A4KD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744556; c=relaxed/simple;
	bh=Skwtf1LwuDirieqOOjqTfwrJX+i7JNPO7ZoCmIflvG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRctbLo7LmEI21myaPloetK/GLj3lDofEBnpvXUnTnHovhLzlRuvDhpFn0Xyir5VKkRFwChmv3OqHV0coqEIqLGWg/ynkXkm6/wmDpnPoNWMgONkeCZHHtCzKksJuRXeGSF/hPgQ9Ng8rGkeOiVjM6KiVZjjf9RTZXyubfu7qOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Vy0LFGZV; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound-ea17-82.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 31 Jan 2024 23:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ7M0oGcp7fniyn5XDY+F3v0imobA6xv7CLoLe0ulq/u8utBjpe0dQ3iCwn8TVLWP5nhJ9mn6mZBL9NAhAoYeLbNkcls1QcAlawNfTsWrOgaTCoNnIzv1Bkf5S6M8O5Sbo8mAj6EiUU1AfhfBHHoxOLAo0oBdVZOe2qh7nwvLwIJnE7VgGAQWy+X10JT/Gf6OQ0w6MdHRhqgz+wnLG8zHrV/NT1ZKq9PR94Dn27Bgclt4EANILm1vC2/1Z0W6/6GSUi+h8JP8B+yc1C5VIu0aSj/v6bgv4QlJpJyTKxxsap08rni+te1/9PxGuLyi65z43UpwiQJ2vL4Jxrbzeciog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3JAsM2e0eb+N55RRiFXReAc/QgCODbEHDEh1Yf7CgY=;
 b=HITNFJ6D33ykzujsmoK+15WFEDLbpI7igu3UQ8yFmt0PZCEsa+jfg9MVVvzxd+lWvXtnBK+XALhF3B+StgPwFFsqbnh4AvHYU8IT2s8lH57k/i5JBfpMrgAjx3qHldDunvS3OyFcQZHlPFB+Tl3aOFVMqEJCVVC/FpghjDsUK6uH/FeOv3Eh/eOg90M4LH3bEwX4/3T4Mo8Xa6cizgX9yJo2xgWiLjDWCy6ZlhihFijoyK7dTuUvLWJwmy/9zuPUjYOnShsMy2798g4AnK59/31m7A8SvWjkIp43+QqhOrqUhFjAxMXHleRgacXL4nH/l0HabZf3Sx8TFs4KWwl2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3JAsM2e0eb+N55RRiFXReAc/QgCODbEHDEh1Yf7CgY=;
 b=Vy0LFGZVRbIxteLqIo19oPGop5Q5sLSa1JFGGDuNsgZ1lp5/pZolbTUNhK2xtvW7nJHb9xhA2kVNyY0kr3vX4Nfs1zChz0PCjufLL7ew8U6PBaf2RD7XAQfbvt7+Fg9ebjn6jWZ4YlQvRBSoSLwBZ6oCwrHvsLh7udUACV0ue7s=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by DS0PR19MB7958.namprd19.prod.outlook.com (2603:10b6:8:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:08:58 +0000
Received: from MW2NAM04FT024.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::46) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 23:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT024.mail.protection.outlook.com (10.13.30.177) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.24 via
 Frontend Transport; Wed, 31 Jan 2024 23:08:58 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 50D7E20C684B;
	Wed, 31 Jan 2024 16:09:59 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/5] fuse: Create helper function if DIO write needs exclusive lock
Date: Thu,  1 Feb 2024 00:08:24 +0100
Message-Id: <20240131230827.207552-3-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: MW2NAM04FT024:EE_|DS0PR19MB7958:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15bbfae9-bb9a-4c28-fadc-08dc22b19ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqafroAcZjq2AQFFntISKmZIuMrRG2K1snz9xpK1i3dFYTGu9uNugd3IQiOaTulJfIQ2skKkHyePQn//6PDY56bS2HSvOnnwYavgiNzoe9JVjInUz91zi22YNkwaJPhtllFrqtX/ESFpv/RiqXcn7QS+/UEpo1J3GZPyuLz7uN7qwJeeP9kSWS+llVaPedgtOVzcPUAeda7pObvbcykGyqHBmuQtHWUfGvka99JZJAOG0U+BReVhFmOI4EemcxI84rgX4zNCJLBTb+th24xFHlJVqNaO8Gtp9arQnee4MMMKPk2E9+5wObLBIIF4lwmBemC444TJml6oBcn26gNCg8XCjcW1hZNKKtRYSohg2Vf8n60IxzZ9ReQksdvmJ8svvIdjW0rlL5RAd+73x1zS4V2ZWayfskGgbX57osjSX2/G2FCacgFdg1PMRt13RzY6LHxYy0yDIpmHvtRaQhpEHoJuCAOqxqSM8+IUYa6g2aFIDSWvNrGdYloBucOx0e+TOU5rNhJqz2aiZf17j6ad0PlichsvlgU5ffEzs5Nna0wScmmlfI1FsOqLNChbYGCfaTJGGp6QI0LLgERYPzB37gcQhdh3RthvWEeJ+MIh+YG3/ps2aUD1YEs/t4RjbIL7wuZTjnY62NGNzHgzsKE04+NnwN+Om92aDKTN3pKJPDW79Ohsq8zl+PV2cVlPDOdYtgnpgO1DV5JVuG9QnUTbDu9Cc3iV3M2k3vRVthuUTs4t2LjC5GvwvH2m/k7KqA3c
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(46966006)(40480700001)(6266002)(336012)(83380400001)(26005)(47076005)(6666004)(1076003)(82740400003)(2616005)(356005)(36860700001)(81166007)(36756003)(478600001)(6916009)(316002)(54906003)(70206006)(8676002)(70586007)(4326008)(8936002)(41300700001)(2906002)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/b5gMVerKfGGpNokjqNQ+7OVzIkUf2iXqrnZPvJ0yqV5kuvj6bEW0CjBN5TNry3jQlHvhOntycYlE9PJiEfki9karq5nx8HrRyHlu8P42YX4LX2rnd593XFvbCwL/GniPcPC54JkMrRS8olZVb44exdUDzUKC3rm96pIPYckr0Wy3v4kB/c0VT8zXHj7xOfBGU7ZTmiTWnUFfV6lmJuTA4FVB6onU2fGvgn250rm9/DvDro+xW15RsgEuDErDllFugd6T+kk3u661f5uxVej2AL6S1zpp40jKL5J+zwR1yegGmdEbmlQ/wG0xdBa15h/LkCgZhpT3mjAORNKe+6A3bu+QLNjeOWPWDM2CNIXM13A77yPtG2Ds1S07ZHn+YkpXUIpwedTOv1sCBGATEKCt8zaY2u0WfrmbEdfMpBu+u12/dB6fhkdltSFE3mryN/H8TJOONT8APT44GZzmMikd0fMz3+thdTHeZM4lUzrGqhMZk4qO5M0wsZ8WHW376fc9tEYTtrwyRrOok2HuwhZn/xc6mbXnhQ/yAgLZPEVauEPhKKcOPsZCbItEPySsQT01U6yugrJ8MbsuKituPhuhpkgxD57k+8PtkrtBXI3r16C0xjIJVtXjywcIikGW3L9Laiw1D+qutGGtBi1FQYWQQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:08:58.0773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bbfae9-bb9a-4c28-fadc-08dc22b19ad0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2NAM04FT024.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7958
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706744553-104434-2504-42069-1
X-BESS-VER: 2019.3_20240130.1849
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbmJmZAVgZQ0NLYzDzF1DItKT
	UtydLCJDHZ0sI40djS0CLFLMnQwshAqTYWABF+CNtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253897 [from 
	cloudscan10-213.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This makes the code a bit easier to read and allows to more
easily add more conditions when an exclusive lock is needed.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 64 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 243f469cac07..0c4d93293eac 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1299,6 +1299,45 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
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
@@ -1558,26 +1597,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2468,7 +2493,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
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


