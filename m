Return-Path: <linux-fsdevel+bounces-9779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76304844D34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C882285DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D340BE5;
	Wed, 31 Jan 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="FnIT7Gzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3140BE4
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744478; cv=fail; b=moW0T11iqhmgC6gOJPKvOZelXbhNjJT6+8/86zrCLBJ/nG6avth2pGrKuwtXG5P5Xg5cC52hW9OYRGWrotjaBbGFT3xGUzGkSt6FK5DALe+fdKf+Yh5uNCeqyR4cVBCUSicHZ0iCeSZ7R3OgY5Za8fpU9FQjgEXtbTa3C1LxLBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744478; c=relaxed/simple;
	bh=Xe596WaC0Y89ZXYmXphs0D23GkRkF/f5sr6YirTyrgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZ1SeyjkrgVOcbdLhZarIuONnBmOLrXZTLji35Sz2QD2w/BG5QDAbyS8kDI4YE3XzAxVwI6nFLIMkkesR+d8MsKC0Ia5YksOURnpCiUHkv43xV/xOoc/RoeCjAJsdEI1yc4UlQF1JfAD8GwHOQjs6pii7cqNI2cDLsc7fs3WkJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=FnIT7Gzc; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound-ea17-82.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 31 Jan 2024 23:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFUVKkekNETcHSf4TQ/EZwSe0RGViOwxnKmVUQxDSCrKftZhaeSTuMSiHqRLiPL/Ptc370bgqI4d/sLdD76YynB1pCJhhps9NzmcEFsWtfTiF0PzfMGj5uBASEmKRWXsUt6OAdF7zZopPMJuW9DXyH23p9wiDKmpKpZiCeWhkRgyaM1Rfkd2bwevOZKyOkiH6haOlVVotzRW9ys9MujcDY1q7b6b9yn6nDXl76JZC/Q9sOXDtS/IRkDPHzhIMbCOp+aW5HXywgbPBewWD9+sDngAvxgs6fA0wmkNu3yMEDiyF7yW1xNIJ7x2UOr9pq3AuzwA7JnQ98b99NnC23QPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spf5g18EsZaMwbK19fxXqD042Cc/p366E8I6AG/76+U=;
 b=IfkwN7oC7l+sKINV/R0xYJWNpjsMe73eLICs6xBnXVOWEFY2oQiIrLRfYHZzGTYfTpcOJfK5loXM8+PDJHWzlgoTUPoJgit5CYssDAFiKAI96ZwROVce0RGJGLuhy43rqntSRHBkSu/yHdGb4McHhckQj4jYRLDWv3pgTLxrpQuhRkmbhYq+3VHC1Alh++4uOd9MuHUkRen1saHyqFKkBkuNsWMaWqIrNG3jcBoMTr3q9fLHi28+tmUvCkbr09vQZ6/ALirAVEMPGViXc4axkuJruUWKlwLI6mftxi4otCNTjdzBgQvjfs42bCF0O6FHPjWfsgjARzPTRxRpQmQAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spf5g18EsZaMwbK19fxXqD042Cc/p366E8I6AG/76+U=;
 b=FnIT7GzctarNKmd6gONeWlr80aFOyEYP1yJ7zSvleqKjQhmKCaS+ZKvjLivIprDXc+6LX3sGVrjbi+KkM6LWj35EwidrrHm1F/n3RQ+gOwfeL7Q17CHWFOI10lsnQFuufZ27/dzxz1zPxDBufg64A4+BQ9Ir6aK7z9Ld8UHCRDA=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by CYYPR19MB8104.namprd19.prod.outlook.com (2603:10b6:930:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 23:09:03 +0000
Received: from BN8NAM04FT065.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b1) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Wed, 31 Jan 2024 23:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT065.mail.protection.outlook.com (10.13.160.195) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.22 via
 Frontend Transport; Wed, 31 Jan 2024 23:09:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mx01.datadirectnet.com (Postfix) with ESMTP id B858420C684B;
	Wed, 31 Jan 2024 16:10:03 -0700 (MST)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dsingh@ddn.com,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 4/5] fuse: prepare for failing open response
Date: Thu,  1 Feb 2024 00:08:26 +0100
Message-Id: <20240131230827.207552-5-bschubert@ddn.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM04FT065:EE_|CYYPR19MB8104:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60a00612-f37d-4018-955c-08dc22b19d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/MP8tkMCmOFEP0/U7zJhqzocsVI7NWn7iV/KL2xoQl/r76ipkGBfhL+xB9Ex/2OG6zmnIqcdEGwcAIgeUVTId4Ux+TBTLiU9YfsFlhLRhi11Yy/B6ncKY0cISSAB4KH/u3UoCoa53awWcik/KO2xHbAS/l9RyaBKAXtRcUKu5ysXY15DmcjRAYcC3QlNphBth7OGMaRUyDQu9nNU/DqBNAQZOB4ydibGdpc7L0cBs2sZbuLj087wEIcv3FFr9qJmHcem9uzEVHwpxHoYvZ5tj7fL7QBuOoKjkiHQ5MQ8AFUwp+/fhbVDJ0WFuz0c/KMvGdpQKR0hugJgJUbJQPC1f0TexlBTWM7kM5BEv28K6Ks1LuWGCtUi0ROBwJqWctN+wwZE9dyQWVGG4THPS1oskZbv9U+tdB0Mk7yhdo92OWR7pkJF1mGB7ZY6RScKaLur3PQu3Fm9zfcDZTDGei/EdQAH3hsgkticW6XCKwDXedmoK8or10sbI72w8mLj6ORB6i9hiFJBKuX36/uygkrwx/EEKT0qF4rKySkRnFT4jPRUzQNuJZSSLjfcTBeK3Z47TqgqDG4swzXwbgoHCvuH3nn5H/UP3WhmKB4o1R5MJa214UzVkJ/M63ucp4BNyrzmHSzqZisIj4+of1mRfBnrkH68sM7ETOkdoapJ0tmK1V53RzHzIYrCSpDz9x3uNXR9/rGsN583Ewo65JvlA+YfZ6uKB3YTf3r0ajJeuHBtNteIzjCWNtH2bFCjDtrzSqwN
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(41300700001)(83380400001)(47076005)(2616005)(6266002)(1076003)(82740400003)(336012)(81166007)(356005)(70586007)(316002)(8936002)(4326008)(5660300002)(8676002)(478600001)(70206006)(6666004)(54906003)(2906002)(6916009)(36860700001)(26005)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4l7LfbSkOHpxILU6XqzwBDCEmTWXM5DBJOk8pTVNhSTR4I0efxIjmGid+P+lxkUsy9jH4lfkvYC/0HoENgq6ARHlYv+W+Q6DLdWIUWiC5glZknXHm/cihZ+0s5wSNo8WIFmzf/K4fCp1ZGScXzdq1bi33MG5ZxYuFB6h5gCPtENnNtnh/lHaljnov/7H/47fmQLjjlLyc5JZvH4y93i3aULA+1h4S0fp5rSNvJq7r0p54gtMc7Fvq+j1qxOh8gYVxMupl+2yUMicMAJ/TefG7AyMl07LI3RhFcvLrzzXybAg/8/gZoY7mOeaeANGsQFWXjpoOt4RGmq8feb1TTihS0sQnggy8PMYevFmn0MIjV1IqAj6wJpKCMRLdaXz7YU5UPyknapH7Inlw4gCdJ4CHUPXn+3w3BY3CXjnfnFlxUQ75ejY0yD/YZJh4WzALKJbi3J3W5PLQ6F7pfjaWR1CoBR8/ziBizRIG3+eSihcYS21Lb9GICNvp8vRnmD1WDm02f0XLmfnCxw8HZjW2l/Z0Yw3oRaxMH2IlfNWbe+3zKki8IXMwEimwgB9qD846kEjT5/dIR0L32i0ei6tZapsa81c81Qgwt0XK+ZwiQAVMZ4C5P2K4JOKTcxaPyPzICp+gkxA4a/ZlvGIYHux6FdlHQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:09:02.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a00612-f37d-4018-955c-08dc22b19d8e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM04FT065.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR19MB8104
X-OriginatorOrg: ddn.com
X-BESS-ID: 1706744469-104434-2501-41580-1
X-BESS-VER: 2019.3_20240130.1849
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGpoZAVgZQMNXM0NAgySTNxN
	LAzNLI0sLIPCXZzCTZyCDJIC3JMilRqTYWAIvn6BZBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253897 [from 
	cloudscan18-66.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Amir Goldstein <amir73il@gmail.com>

In preparation for inode io modes, a server open response could fail
due to conflicting inode io modes.

Allow returning an error from fuse_finish_open() and handle the error in
the callers. fuse_dir_open() can now call fuse_sync_release(), so handle
the isdir case correctly.

fuse_finish_open() is used as the callback of finish_open(), so that
FMODE_OPENED will not be set if fuse_finish_open() fails.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dir.c    |  8 +++++---
 fs/fuse/file.c   | 18 ++++++++++++------
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..d45d4a678351 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -692,13 +692,15 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
-	err = finish_open(file, entry, generic_file_open);
+	err = generic_file_open(inode, file);
+	if (!err) {
+		file->private_data = ff;
+		err = finish_open(file, entry, fuse_finish_open);
+	}
 	if (err) {
 		fi = get_fuse_inode(inode);
 		fuse_sync_release(fi, ff, flags);
 	} else {
-		file->private_data = ff;
-		fuse_finish_open(inode, file);
 		if (fm->fc->atomic_o_trunc && trunc)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3062f4b5a34b..7d2f4b0eb36a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -195,7 +195,7 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
-void fuse_finish_open(struct inode *inode, struct file *file)
+int fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -217,12 +217,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	}
 	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
 		fuse_link_write_file(file);
+
+	return 0;
 }
 
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = fm->fc;
+	struct fuse_file *ff;
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
@@ -251,14 +255,16 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
-	if (!err)
-		fuse_finish_open(inode, file);
+	if (!err) {
+		ff = file->private_data;
+		err = fuse_finish_open(inode, file);
+		if (err)
+			fuse_sync_release(fi, ff, file->f_flags);
+	}
 
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		struct fuse_file *ff = file->private_data;
-
 		if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
@@ -368,7 +374,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
 	 */
-	fuse_file_put(ff, true, false);
+	fuse_file_put(ff, true, fi && S_ISDIR(fi->inode.i_mode));
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..1c0cde4022f0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1038,7 +1038,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
 void fuse_file_free(struct fuse_file *ff);
-void fuse_finish_open(struct inode *inode, struct file *file);
+int fuse_finish_open(struct inode *inode, struct file *file);
 
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
-- 
2.40.1


