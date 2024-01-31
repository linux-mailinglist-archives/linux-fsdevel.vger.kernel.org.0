Return-Path: <linux-fsdevel+bounces-9787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BC844E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63ABAB2AE49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99F20E4;
	Thu,  1 Feb 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="uyaDx33S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30621FD7
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748228; cv=fail; b=OsKczcJSyumW8TGyr9l8kGzPk3xmy9QZgIMuAH1mS1p5+9hjn3e/1CgTx0v+QKx1hHTVpndihvkRatWMXmH9RPyZhcNSiL1hCT208B937PQYABudFuE6VP1+Ui4bdBOJgtqUPutyJ/0cQrZG19XAaBW0IRKANWSi+rYfriSIA70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748228; c=relaxed/simple;
	bh=0VzdJ28emMTLPg6aPRsXx32/cWFNUsPOgJrCCbnlg1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDTPstMb6bT2sJpjwsAokUqHHTjdxtqwhbDBxVc6D3sWRbDTl2Vx5FXRf1Wq65Vuv91t/JNmtNdwoMbJbv8fNXUrDt5uV82G4muAtAbxRmXd8cuZH1K4B0NBpg6SdQWZN7gP1NukKKjM2ogc6YOOtKPS1/8uPYEx0Go9TSkvYi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=uyaDx33S; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169]) by mx-outbound44-50.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Feb 2024 00:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCPpv/pWhokTm71ViXtmMyfltIWldV1wW34OuARgL0fwH9mmg2aYYltZLMnR8Maz2mVgvFCFNBonqts5rCWGPYzEGp5z36f9p0p/bvZ10eLDHV4Q8gcrYaUSRrleaTzXN9cDGs89hYpqCUbzJwWL/0epjieqPjxf1JDjG/S3P9TP7A3GE5cYVH//wKzPu6rI/HLvD4MjOKOUl2Tw26ctIWK2R8eXm1QU/DHcUqIn0RsgEEpQ/Koq7nUqR641pYaHC39k3DbkDMdhla8AZIxgO3uS8D7zwn8XEGV2Rr/0DUC3fdqWaX01BxCGYPR3bhzIcejJXMkt2M3BLL1O5e9kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6n85FmdIula6gJNHdcp3TFqjNS7XqJaYqQaxgVNY/w=;
 b=Vxo+EMwA7/UIwkInjQkl4NBNzJ8XgrMH+KonQoweiXEe5LmS2B/BFt5Zr5sMVyEBls8jevWQ9yjfs4NnavI3589lppD55UOOzyvaz2K8T+iGSqF6frHM2EMlA9xYB+3oii/uwQ8q690Nl4zQwhV+WIsuMwy0UK85Ek+6ZS7ATOToIgjqwaTKjgE/zhOwbUZnAGB/dsD8pbH3OmrlyKNKTZxc3MNpfKcHzHi0m4HHnOFU/03ObsbzJOQt7HTKKgM7Lf8zVPplbhXbKBzN60a1lqDgN4UtMUKR31PjTVdHhxyr38MJObo24Bcz3kFFofTLW7+3+n0kQEdsHyQr1rVppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6n85FmdIula6gJNHdcp3TFqjNS7XqJaYqQaxgVNY/w=;
 b=uyaDx33SIOgimA+Trb6OLSXbNxOnGQwxnbbH53A5OQBnVDMAWd3thfh6Mmf5oI65/VxrVOV4JDiPON3eYkd1EfzYSpLsIwRkZrwZt8uZQlQXscphT91ySlpkd31OILTleKNCCrryqWgwML4+pnaKgx9FeuVeOieLu+E/X/mrCt0=
Received: from DS0PR17CA0014.namprd17.prod.outlook.com (2603:10b6:8:191::10)
 by BLAPR19MB4481.namprd19.prod.outlook.com (2603:10b6:208:292::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 23:09:05 +0000
Received: from DM6NAM04FT039.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::84) by DS0PR17CA0014.outlook.office365.com
 (2603:10b6:8:191::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Wed, 31 Jan 2024 23:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT039.mail.protection.outlook.com (10.13.159.54) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.26 via
 Frontend Transport; Wed, 31 Jan 2024 23:09:05 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 837C820C684B;
	Wed, 31 Jan 2024 16:10:05 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 5/5] fuse: introduce inode io modes
Date: Thu,  1 Feb 2024 00:08:27 +0100
Message-Id: <20240131230827.207552-6-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM04FT039:EE_|BLAPR19MB4481:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11be8d44-8086-40a5-bc53-08dc22b19f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3DdCX9YTDOV8/UIkN0vZAPBclquss2hQw6TbBfvok8BeYzdnNfsrhrozjXNEXSA6hGrLlOs4ZA4/dAOv5OnOpH6m2mmX4WBdvnMtu0LavsWJ0XlUqgszL32FBClZQj32bZ+iKU3IiuduD/BlLzvUmSSF+26Ht8Y+vwtKnHIesJfDO5ZilrLaCeWiaVbeSsoQRB4hr519V+3fkjmDRZndVm7tWJLD46gxWuZRHs5jqvQ73JgKUeWOZOChwGFyEwNVyYWOqFVZYaNuqK+KpPU2zwb6bVoNJGQ6D/H/aW7CtHYKUKa64GlHQvfI/PdlU+bUeQCyq9q4wWtBBOk9DYdl4vPbMBte+XZHSe85H7nosG+Wm1J1Grl8NCAc9pbT/tNdsTJyDfb7utKPes7WcToJBXvUZ/ST0IjRQJdqCiJf7k4vglTljCImzgsYYFmffpfxRJ+KdGM/+UhqoWbPJSfsYE9r9Lt06rj2MpUILkDqlILSDg9v3ApasZZEGDyJjQ3korqPcLik8r8sqBu+4MuoXg+onCHIk3GIFENpk2CJeaBx4E25cJNjoZ4YJuEss739rLtW1i254Nn2VJzsOazEh2ajyaNptmv3ATccGfDxoxwtRxUyeOft3OHnRDpMs8TG8Le70/9C2IL4FAN52y0oie8B5+6AA9l+zi+T4eovuPrcJEe7BSlo7JnampCCaSYYd7WJX47hq6Zpu4WK3HEzQvnndF5brTbDhbYTjLDL/WqyLxtQs39vAi/lqtY7hIY8
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39850400004)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(46966006)(41300700001)(30864003)(4326008)(8936002)(2906002)(8676002)(5660300002)(86362001)(70586007)(70206006)(54906003)(316002)(47076005)(36756003)(6916009)(36860700001)(82740400003)(81166007)(356005)(83380400001)(478600001)(6666004)(26005)(2616005)(1076003)(6266002)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TR71tRY3IoDw9EZJCZ31BE5N/ZvEF2Hu4M5wwwMKML1BCrwDpFhtjc7R9wmdqCx/rRyuOuw0XEQNI7ulg0g6avLzHM5kldhjBhsmsnthko7/pFUXRwnhulRnA03Iy1Xhcl4Cea/phINuT/o4Xf4wn7s/t3dj3ODb/omaUvZTDfaWlW+VYbAajoVfV3PNPbmWbu7MWWMSf3zdG81jVwopc7KB8AKQ5hNnpEiTYxLJ6kSVvfyvf9staBFUHgCBLCKZq3x9WJwB+hEcGixvuWuHnIi9Jcx2KynSOgBqiWz8FE6ZLnRQGjlTIP9fzcdgKt/nXedqkEhQXN8XHgibk/GhWn8yZhtA183pXI3HoPssqLYZL0qq5P3Ujtjz28TVqiNEcaLN0LPs42dsf7d0MEoG2kaaOH00HOOroo1x3YcZRdRUv25Oijbn3apDInra6WU+ixFI1WqrFQLrTSD12oIBI3Q5aCAJRd0vgOHX3GG9hXPyBd7jVVv+twV/DtZEn+VMLXB+CO/+1YOzID6TDkqn2v1RqZwbK21MwtQBMpOuJOkBzPYapRnwzuBslNNCyC/81v9aC4VwCf2zZ8yjfJ4dN61B9l0kb0zEtrIEsTbJE4aAcLAUSXixGehGcwn7zN1iU0KqWBipUbubRtjjFJYKNA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:09:05.1757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be8d44-8086-40a5-bc53-08dc22b19f09
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM04FT039.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4481
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706748224-111314-15996-12552-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.55.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmxiaGQGYGUNTC3MLINNHQ1C
	jVMskw0cgs2dzcMNHQINXCwDQpMTU5Rak2FgB7Ze49QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253898 [from 
	cloudscan15-103.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Amir Goldstein <amir73il@gmail.com>

The fuse inode io mode is determined by the mode of its open files/mmaps
and parallel dio.

- caching io mode - files open in caching mode or mmap on direct_io file
- direct io mode - no files open in caching mode and no files mmaped
- parallel dio mode - direct io mode with parallel dio in progress

We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was open
in caching mode.

direct_io mmap uses page cache, so first mmap will mark the file as
FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
the caching io mode.

If the server opens the file with flags FOPEN_DIRECT_IO|FOPEN_CACHE_IO,
the inode enters caching io mode already on open.

This allows executing parallel dio when inode is not in caching mode
even if shared mmap is allowed, but no mmaps have been performed on
the inode in question.

An open in caching mode and mmap on direct_io file now waits for all
in-progress parallel dio writes to complete, so paralle dio writes
together with FUSE_DIRECT_IO_ALLOW_MMAP is enabled by this commit.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c            | 215 ++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |  79 +++++++++++++-
 include/uapi/linux/fuse.h |   2 +
 3 files changed, 286 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d2f4b0eb36a..eb9929ff9f60 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -105,10 +105,177 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
+static bool fuse_file_is_direct_io(struct file *file)
+{
+	struct fuse_file *ff = file->private_data;
+
+	return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DIRECT;
+}
+
+/*
+ * Wait for cached io to be allowed -
+ * Blocks new parallel dio writes and waits for the in-progress parallel dio
+ * writes to complete.
+ */
+static int fuse_inode_wait_for_cached_io(struct fuse_inode *fi)
+{
+	int err = 0;
+
+	assert_spin_locked(&fi->lock);
+
+	while (!err && !fuse_inode_get_io_cache(fi)) {
+		/*
+		 * Setting the bit advises new direct-io writes
+		 * to use an exclusive lock - without it the wait below
+		 * might be forever.
+		 */
+		set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+		spin_unlock(&fi->lock);
+		err = wait_event_killable(fi->direct_io_waitq,
+					  fuse_is_io_cache_allowed(fi));
+		spin_lock(&fi->lock);
+	}
+	/* Clear FUSE_I_CACHE_IO_MODE flag if failed to enter caching mode */
+	if (err && fi->iocachectr <= 0)
+		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+
+	return err;
+}
+
+/* Start cached io mode where parallel dio writes are not allowed */
+static int fuse_file_cached_io_start(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err;
+
+	spin_lock(&fi->lock);
+	err = fuse_inode_wait_for_cached_io(fi);
+	spin_unlock(&fi->lock);
+	return err;
+}
+
+static void fuse_file_cached_io_end(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	spin_lock(&fi->lock);
+	fuse_inode_put_io_cache(get_fuse_inode(inode));
+	spin_unlock(&fi->lock);
+}
+
+/* Start strictly uncached io mode where cache access is not allowed */
+static int fuse_file_uncached_io_start(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool ok;
+
+	spin_lock(&fi->lock);
+	ok = fuse_inode_deny_io_cache(fi);
+	spin_unlock(&fi->lock);
+	return ok ? 0 : -ETXTBSY;
+}
+
+static void fuse_file_uncached_io_end(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool allow_cached_io;
+
+	spin_lock(&fi->lock);
+	allow_cached_io = fuse_inode_allow_io_cache(fi);
+	spin_unlock(&fi->lock);
+	if (allow_cached_io)
+		wake_up(&fi->direct_io_waitq);
+}
+
+/* Open flags to determine regular file io mode */
+#define FOPEN_IO_MODE_MASK \
+	(FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
+
+/* Request access to submit new io to inode via open file */
+static int fuse_file_io_open(struct file *file, struct inode *inode)
+{
+	struct fuse_file *ff = file->private_data;
+	int iomode_flags = ff->open_flags & FOPEN_IO_MODE_MASK;
+	int err;
+
+	err = -EBUSY;
+	if (WARN_ON(ff->io_opened))
+		goto fail;
+
+	if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)) {
+		err = -EINVAL;
+		if (iomode_flags)
+			goto fail;
+		return 0;
+	}
+
+	/* Set explicit FOPEN_CACHE_IO flag for file open in caching mode */
+	if (!fuse_file_is_direct_io(file))
+		ff->open_flags |= FOPEN_CACHE_IO;
+
+	/* First caching file open enters caching inode io mode */
+	if (ff->open_flags & FOPEN_CACHE_IO) {
+		err = fuse_file_cached_io_start(inode);
+		if (err)
+			goto fail;
+	}
+
+	ff->io_opened = true;
+	return 0;
+
+fail:
+	pr_debug("failed to open file in requested io mode (open_flags=0x%x, err=%i).\n",
+		 ff->open_flags, err);
+	/*
+	 * The file open mode determines the inode io mode.
+	 * Using incorrect open mode is a server mistake, which results in
+	 * user visible failure of open() with EIO error.
+	 */
+	return -EIO;
+}
+
+/* Request access to submit new io to inode via mmap */
+static int fuse_file_io_mmap(struct fuse_file *ff, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err = 0;
+
+	if (WARN_ON(!ff->io_opened))
+		return -ENODEV;
+
+	spin_lock(&fi->lock);
+	/* First mmap of direct_io file enters caching inode io mode */
+	if (!(ff->open_flags & FOPEN_CACHE_IO)) {
+		err = fuse_inode_wait_for_cached_io(fi);
+		if (!err)
+			ff->open_flags |= FOPEN_CACHE_IO;
+	}
+	spin_unlock(&fi->lock);
+
+	return err;
+}
+
+/* No more pending io and no new io possible to inode via open/mmapped file */
+static void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
+{
+	if (!ff->io_opened)
+		return;
+
+	/* Last caching file close exits caching inode io mode */
+	if (ff->open_flags & FOPEN_CACHE_IO)
+		fuse_file_cached_io_end(inode);
+
+	ff->io_opened = false;
+}
+
 static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;
+		struct inode *inode = ff->release_args->inode;
+
+		if (inode)
+			fuse_file_io_release(ff, inode);
 
 		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
 			/* Do nothing when client does not implement 'open' */
@@ -161,7 +328,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	}
 
 	if (isdir)
-		ff->open_flags &= ~FOPEN_DIRECT_IO;
+		ff->open_flags &= ~(FOPEN_DIRECT_IO | FOPEN_CACHE_IO);
 
 	ff->nodeid = nodeid;
 
@@ -199,6 +366,11 @@ int fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	err = fuse_file_io_open(file, inode);
+	if (err)
+		return err;
 
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
@@ -1320,6 +1492,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* server side has to advise that it supports parallel dio writes */
 	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
@@ -1331,11 +1504,9 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	if (iocb->ki_flags & IOCB_APPEND)
 		return true;
 
-	/* combination opf page access and direct-io difficult, shared
-	 * locks actually introduce a conflict.
-	 */
-	if (get_fuse_conn(inode)->direct_io_allow_mmap)
-		return true;
+	/* shared locks are not allowed with parallel page cache IO */
+	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
+		return false;
 
 	/* parallel dio beyond eof is at least for now not supported */
 	if (fuse_io_past_eof(iocb, from))
@@ -1355,10 +1526,14 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 	} else {
 		inode_lock_shared(inode);
 		/*
-		 * Previous check was without inode lock and might have raced,
-		 * check again.
+		 * New parallal dio allowed only if inode is not in caching
+		 * mode and denies new opens in caching mode. This check
+		 * should be performed only after taking shared inode lock.
+		 * Previous past eof check was without inode lock and might
+		 * have raced, so check it again.
 		 */
-		if (fuse_io_past_eof(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from) ||
+		    fuse_file_uncached_io_start(inode) != 0) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
@@ -1371,6 +1546,8 @@ static void fuse_dio_unlock(struct inode *inode, bool exclusive)
 	if (exclusive) {
 		inode_unlock(inode);
 	} else {
+		/* Allow opens in caching mode after last parallel dio end */
+		fuse_file_uncached_io_end(inode);
 		inode_unlock_shared(inode);
 	}
 }
@@ -2500,11 +2677,16 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
+	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	/*
+	 * FOPEN_DIRECT_IO handling is special compared to O_DIRECT,
+	 * as does not allow MAP_SHARED mmap without FUSE_DIRECT_IO_ALLOW_MMAP.
+	 */
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/*
 		 * Can't provide the coherency needed for MAP_SHARED
@@ -2515,10 +2697,23 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
+		/*
+		 * First mmap of direct_io file enters caching inode io mode.
+		 * Also waits for parallel dio writers to go into serial mode
+		 * (exclusive instead of shared lock).
+		 */
+		rc = fuse_file_io_mmap(ff, file_inode(file));
+		if (rc)
+			return rc;
+
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
 			/* MAP_PRIVATE */
 			return generic_file_mmap(file, vma);
 		}
+	} else if (file->f_flags & O_DIRECT) {
+		rc = fuse_file_io_mmap(ff, file_inode(file));
+		if (rc)
+			return rc;
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
@@ -3287,7 +3482,9 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
+	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
+	init_waitqueue_head(&fi->direct_io_waitq);
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1c0cde4022f0..cb961f9a13c3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -111,7 +111,7 @@ struct fuse_inode {
 	u64 attr_version;
 
 	union {
-		/* Write related fields (regular file only) */
+		/* read/write io cache (regular file only) */
 		struct {
 			/* Files usable in writepage.  Protected by fi->lock */
 			struct list_head write_files;
@@ -123,9 +123,15 @@ struct fuse_inode {
 			 * (FUSE_NOWRITE) means more writes are blocked */
 			int writectr;
 
+			/** Number of files/maps using page cache */
+			int iocachectr;
+
 			/* Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
 
+			/* waitq for direct-io completion */
+			wait_queue_head_t direct_io_waitq;
+
 			/* List of writepage requestst (pending or sent) */
 			struct rb_root writepages;
 		};
@@ -187,6 +193,8 @@ enum {
 	FUSE_I_BAD,
 	/* Has btime */
 	FUSE_I_BTIME,
+	/* Wants or already has page cache IO */
+	FUSE_I_CACHE_IO_MODE,
 };
 
 struct fuse_conn;
@@ -246,6 +254,9 @@ struct fuse_file {
 
 	/** Has flock been performed on this file? */
 	bool flock:1;
+
+	/** Was file opened for io? */
+	bool io_opened:1;
 };
 
 /** One input argument of a request */
@@ -1349,6 +1360,72 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 
 /* file.c */
+/*
+ * Request an open in caching mode.
+ * Return true if in caching mode.
+ */
+static inline bool fuse_inode_get_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr < 0)
+		return false;
+	fi->iocachectr++;
+	if (fi->iocachectr == 1)
+		set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+
+	return true;
+}
+
+/*
+ * Release an open in caching mode.
+ * Return true if no more files open in caching mode.
+ */
+static inline bool fuse_inode_put_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr <= 0))
+		return false;
+
+	if (--fi->iocachectr == 0) {
+		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Requets to deny new opens in caching mode.
+ * Return true if denying new opens in caching mode.
+ */
+static inline bool fuse_inode_deny_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr > 0)
+		return false;
+	fi->iocachectr--;
+	return true;
+}
+
+/*
+ * Release a request to deny open in caching mode.
+ * Return true if allowing new opens in caching mode.
+ */
+static inline bool fuse_inode_allow_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr >= 0))
+		return false;
+	return ++(fi->iocachectr) == 0;
+}
+
+/*
+ * Return true if allowing new opens in caching mode.
+ */
+static inline bool fuse_is_io_cache_allowed(struct fuse_inode *fi)
+{
+	return READ_ONCE(fi->iocachectr) >= 0;
+}
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..66a4bd8d767d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -353,6 +353,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_CACHE_IO: using cache for this open file (incl. mmap on direct_io)
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -361,6 +362,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_CACHE_IO		(1 << 7)
 
 /**
  * INIT request/reply flags
-- 
2.40.1


