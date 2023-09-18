Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94497A4F91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjIRQqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjIRQqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:46:10 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4901700
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:37:35 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103]) by mx-outbound44-224.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMZRhSK4Ouo2g7Cqd8u+WCgJiBS3N+CqyAAgi87lT1ikqpbHBs8H/jv3Kuw6SLoxsETrRR5sqOrPS4BhgmhXy8LyK99hca4IidtH/1tvMfbaoRtn9UY33WOZywXEqSTowUGVf+6fS6MWw2YySLxWVRX8Nqs5lUmPfpuvtIZ7uCvFE/LeYcNlfrrQGA6E4ubiiLIPDkkOFTeYG9zxem7zIYxurO2zKFgOeaQ+Rz9I2Wx8z6bA2MrDnhp6hVVF9jfQuyZ89oYRMY3aCgRtHjH+mzrz3bsSmEGpbPPi8sCFHkImhVLGX+9HnzXgYrlT8psjSw2A74BnEE2DlEn0gqm3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCjih8zmLU1iFGL3c+pkvvttp3d7Zz1XoHjg4ZylUkM=;
 b=DlW3bmy54gAXCNLvX2MedRSv7pwaWB/ea3sq08XU49iWSmG7gy+xxlZPfZQGRnosfq3Izw5fThA93YKyXqwjVtoAtZyv5GzGhwnzprL8tOrxROYmrJmp/9vSNzArS9l6Ixl0a73oYJ744at/Kc8KAsEuwUfBtej20hlBG8zOxmPrGU4vHYSPVUPGVYGx8AJdVsITky0wZMvUwRbtogQB7ZA4zd7xhqja/R4mzuh1CsNsJgPi0pNYq1xVPK+nFw1KFjHTrrQkoU/xeSYPQcpFoGWuLN5LGvqGCN7/Jif7D1zU+3JnX+ww7IMWrVGxFnmubMvGJ/nhFvi0Jotw/1Q/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCjih8zmLU1iFGL3c+pkvvttp3d7Zz1XoHjg4ZylUkM=;
 b=PSjEyIjNJ6Hr1YIlfCwjGZSN8V2uZlsCcyxarhP8BBI5GkC5WJdr7ACII1tRWfyIpvU1abBUQB4WO7YsVvLkwMZTV9VymxspTkX1ZrkU+wnFyAYva04xmvv21uYbF+UJwvnWUo9RLKRsovYSYqv3Hg/awMSLe+MMQV6A/PCM1bk=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by BLAPR19MB4388.namprd19.prod.outlook.com (2603:10b6:208:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 15:03:22 +0000
Received: from MW2NAM04FT020.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::9) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT020.mail.protection.outlook.com (10.13.31.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:22 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 5922120C684B;
        Mon, 18 Sep 2023 09:04:27 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 06/10] fuse: Rename fuse_direct_io
Date:   Mon, 18 Sep 2023 17:03:09 +0200
Message-Id: <20230918150313.3845114-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT020:EE_|BLAPR19MB4388:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c12c24ba-6371-4fa1-fdc1-08dbb85866aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAXeoIkJnIN8JtHIlwW04yLWiHZqrPgmwNywWg/io91aJgMH/Ox4v3qqPbs/xcH0Sxl17x73XgD3+IG9XY/pyR1fh+ecwY+Y4CBNVl5cUMefxFScNB0cnGN124lOk6jMQ6yCsTaKcnDsigAxnoxeeiGaYhVOyb9mk6V1TU7FtLtgzVpN2QV/c/+0j8xxrSsVDns617ZQSJmwcw/Z7Gb5MkFvMPjYF6nYK/hqSUvMtQ6I5LSzaP4I5w00tf4cR+x8uVtbmKRtM+kWgTes4NbrfghgCVpzLzgRJf5OgyXjCajRrQm5FHiTkFTgZamN/CJZh0ybbnVKC1rGAztH+sc2/cYHoKB9W3MB1BCA3avVz855xbHXUuL4FiDjZP1zUm4GHXzGWwwCF8YR6HXFv2vOZLyf0jYdMBvsf6DVQRDaRQXonlK08VWJcZIR0HBqI7/lcqb9CIuLD70iv0SDFUERCXPgN7kvUFHzdMAn3t1w0eDT4EPPX6g/k7J7POWhNKJjuaT9FdX6G3xIu4fzQgQ90yPjh8tpUTzQ+M1QJeh7rBB4rjW6rjunI6hjNovtblq6vrF9LVNlmO5evk1/w3plaTEFqSqVAXgrHwLqFupBt/bD+sgctDBbdE2ybPYGisgO+5UISfB5FQgWL8UcItjkk0VARam/K5mIXiy7cQSr2ypJCoy2+j4m+ITbFKKrWcPGFt3r027baaA5qEf2DuRntpv9DP/pT+7JxRjvtPZQxWE=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39850400004)(376002)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(6666004)(478600001)(81166007)(356005)(8936002)(4326008)(82740400003)(8676002)(6266002)(336012)(86362001)(26005)(1076003)(5660300002)(70206006)(70586007)(54906003)(6916009)(47076005)(83380400001)(41300700001)(36860700001)(316002)(2616005)(2906002)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OJB8D/sfrNZypE9UV5ldKNduf9MV127WOejzJXbSh0szaI4YGHpcMIH1tkw0AvWEPRSEULvnGQ2ejvjW4ZtLtXRbF8tKGR5tjf9+lSpNKH/GQeyeNar5bMKoF74vJg79nx2eo0lcbLwXyUGN2V0Mrn10kSIv73aZERCwvcMo/tHngAv12xeFUxviy6whzbXFD0GE1/EMVXWI4vH6lqtE8AqIOQqXBqG6M3V2iWFe70F+9FQrPZ8lQ/nIgd5dG/fnWosF8WEvU8fqMgKkUQCZSkrzs78OG2Ji86jI8XW/4yY1gzrH8BsgMFz543QFuUI+M1b5LY0pczKKAjwktNZQw8TSLPckc0kqbjh1zonXg7wwY/R5CnuNn3sV+n17SM1Dv4v3paEGEhTgtVOB61GtmDQEQOXccZyF9nz6QzicusnX5cAPIocyRsvaPPws0SjArk/0VZGmWDyVXRL8c3LY7HStWlTC/jl+cO4kOnaXoLjAuMvAsQ02VGJalXEmvQUz9xXaBuM5ZVwfZIne24JvucphCuIapt1pWQZ6Hzsq9DsD4fz4gEgHGvihTNjEhpSwW27G402BKIFtNwYsTj44gd0jctNy7vLlmClCCKGyUUuLnjaY+G2KEjRj4jed/9cd2ysK02KkheXX4wqd+kdaBnFtYmvA515pB8XKFSd+fYDoTjUSvelKeAnk/kmr0QJtcWol/1FYk3cXHJfJsYneY8jmM9qx/uE/NcDbt77oVbgcGQCH0StIxhWjoHhD6/w8MVc9N07Sg8YALrlToVhGR82f9E9tDKlnGawXBJa0k38DL/1SHNNkY4gOx7YjNQzuVfqLQY5TgOcGlez/k7qRRjVKHzJinslAU+ZGzTsWStY3NN7CbM1Ix7zZIR+nIWJg4c64ys6kXbwtnqscuP4ZhQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:22.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c24ba-6371-4fa1-fdc1-08dbb85866aa
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT020.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4388
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055054-111488-12353-3941-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.70.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibmBsZAVgZQ0MjYMinV3CzVND
        nJwjTZLDXJIDnVOM3cNCXRMik50dhcqTYWAFkQDYhBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan16-7.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Just to avoid confusion with fuse_direct_IO.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/cuse.c   |  5 ++---
 fs/fuse/dax.c    |  2 +-
 fs/fuse/file.c   | 14 +++++++-------
 fs/fuse/fuse_i.h |  8 ++++----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..c267ae9dcba6 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -96,7 +96,7 @@ static ssize_t cuse_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(kiocb);
 	loff_t pos = 0;
 
-	return fuse_direct_io(&io, to, &pos, FUSE_DIO_CUSE);
+	return fuse_send_dio(&io, to, &pos, FUSE_DIO_CUSE);
 }
 
 static ssize_t cuse_write_iter(struct kiocb *kiocb, struct iov_iter *from)
@@ -107,8 +107,7 @@ static ssize_t cuse_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	 * No locking or generic_write_checks(), the server is
 	 * responsible for locking and sanity checks.
 	 */
-	return fuse_direct_io(&io, from, &pos,
-			      FUSE_DIO_WRITE | FUSE_DIO_CUSE);
+	return fuse_send_dio(&io, from, &pos, FUSE_DIO_WRITE | FUSE_DIO_CUSE);
 }
 
 static int cuse_open(struct inode *inode, struct file *file)
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..423e40ab3e31 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -731,7 +731,7 @@ static ssize_t fuse_dax_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t ret;
 
-	ret = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	ret = fuse_send_dio(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
 
 	fuse_write_update_attr(inode, iocb->ki_pos, ret);
 	return ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index feafab9b467f..24fa6cab836f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1496,8 +1496,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	return ret < 0 ? ret : 0;
 }
 
-ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
-		       loff_t *ppos, int flags)
+ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
+		      loff_t *ppos, int flags)
 {
 	int write = flags & FUSE_DIO_WRITE;
 	int cuse = flags & FUSE_DIO_CUSE;
@@ -1598,7 +1598,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 
 	return res > 0 ? res : err;
 }
-EXPORT_SYMBOL_GPL(fuse_direct_io);
+EXPORT_SYMBOL_GPL(fuse_send_dio);
 
 static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 				  struct iov_iter *iter,
@@ -1607,7 +1607,7 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	ssize_t res;
 	struct inode *inode = file_inode(io->iocb->ki_filp);
 
-	res = fuse_direct_io(io, iter, ppos, 0);
+	res = fuse_send_dio(io, iter, ppos, 0);
 
 	fuse_invalidate_atime(inode);
 
@@ -1664,8 +1664,8 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-			res = fuse_direct_io(&io, from, &iocb->ki_pos,
-					     FUSE_DIO_WRITE);
+			res = fuse_send_dio(&io, from, &iocb->ki_pos,
+					    FUSE_DIO_WRITE);
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
@@ -3001,7 +3001,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	if (iov_iter_rw(iter) == WRITE) {
-		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
+		ret = fuse_send_dio(io, iter, &pos, FUSE_DIO_WRITE);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else {
 		ret = __fuse_direct_read(io, iter, &pos);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..05c5cae59bad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1247,17 +1247,17 @@ int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir);
 
 /**
- * fuse_direct_io() flags
+ * fuse_send_dio() flags
  */
 
 /** If set, it is WRITE; otherwise - READ */
 #define FUSE_DIO_WRITE (1 << 0)
 
-/** CUSE pass fuse_direct_io() a file which f_mapping->host is not from FUSE */
+/** CUSE pass fuse_send_dio() a file which f_mapping->host is not from FUSE */
 #define FUSE_DIO_CUSE  (1 << 1)
 
-ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
-		       loff_t *ppos, int flags);
+ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
+		      loff_t *ppos, int flags);
 long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		   unsigned int flags);
 long fuse_ioctl_common(struct file *file, unsigned int cmd,
-- 
2.39.2

