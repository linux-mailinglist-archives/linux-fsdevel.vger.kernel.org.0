Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1B7A4FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjIRQyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjIRQyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:54:04 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F4128
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:53:57 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169]) by mx-outbound9-117.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEdyA2O6QEiSuSm43eMtl3UXz9hsiXFwbjzqLLpF+9RHz/fiqT3pDutBHaFcePoBoItmhjU8BAq0jLSTahwDISnr9hSF6BrLqUeHyZabDjdJYWW2BPmkiohwB3x59CCNqfiKntCIz6nuQF1Mevmkoojkh6dWMM8UdTQe1B3tnxnvtNnsNjg7SgvZHIp9+aTeoNxuANtyiFFroRnWHxSn0eoRbU8RnrmW25OXHP6lbbUHEABhCfXH4aZjqL2HllDCCwoiunL3umCAl6/oqCODEZM6J21MNc676zVYk/GzbbfH0sRZWzRrl1kjY/WWaRhfuVd73gNjTIWYp0uWpvpRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge6XpbZjGAZ/FC54p/fIVR76iEJ73DSuwsQnMYh8XPQ=;
 b=iT+wZ0Nvj1sPtcn4ab934rP/aUPvAdwkbEgDR3rfiZcmsG/vNHklh58+l851Fnvch678N1KO9XGFd/rVL+D7AM1gG5wE5GvNSJpSvvjOd/3BodKSnnxQ2ysquPoj1r6OS3Mk+kLdbd1rBFZwmB2Cc7ZybiUF0y45qiBP0QWmH5c0rW0y1l9hbu8JTlWkC87ngSwD3jBIW8WCBDZTF9Jp5mBbl4kl/TpUeEfvriWVqK64Q9Fvz2tBKzzc1uJU1MCKFot3M4og3i+0IxJv9KaixL8yiWNmEeDC0Zp5xxORaRTYa+rUWFbfGd6kbHSdaavs2QLlvCZRlXuNpcjRXg5lBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge6XpbZjGAZ/FC54p/fIVR76iEJ73DSuwsQnMYh8XPQ=;
 b=O7hZgxpnSlnrpxnR3bcWdcL2+4gEKhIbed6Pcu7WBYTjhoXu3nb0xhOmDIQls2p3urMajiQru/1BLxnX1lWLC658g4xN0ofpUPLQUBI/NXvKUbq77NyupMvSD7y/aYsQ2ELvKpKOcbqgjncr3wi4ud0W/aPp8iEhAeVtkbVbO0k=
Received: from DS7PR03CA0163.namprd03.prod.outlook.com (2603:10b6:5:3b2::18)
 by SJ2PR19MB7559.namprd19.prod.outlook.com (2603:10b6:a03:4c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 15:03:23 +0000
Received: from DM6NAM04FT032.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::d8) by DS7PR03CA0163.outlook.office365.com
 (2603:10b6:5:3b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT032.mail.protection.outlook.com (10.13.159.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.15 via Frontend Transport; Mon, 18 Sep 2023 15:03:23 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 5464520C684C;
        Mon, 18 Sep 2023 09:04:28 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 07/10] fuse: Remove fuse_direct_write_iter code path / use IOCB_DIRECT
Date:   Mon, 18 Sep 2023 17:03:10 +0200
Message-Id: <20230918150313.3845114-8-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT032:EE_|SJ2PR19MB7559:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cacc6e19-0d79-4291-14f8-08dbb858673d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCfpSanZ8I9LmL5GJWEuil+hgvLZqSceEaEHDJ/vHyn6n3ZubronvXsl2P2+1jAQt5Bul/FDGKrZ2ihs4TMRWZXSCtgyJWjw4M93+TbG+Nxzk9aYGSidX9xjsocDbO/TMeJCtsP+GMCGVCtZqZPnHrJtwlcPxdP+KQtzhgZbyBEG9IEj9aQeYwXiZleGy73b9nKDPU3eMbYXH7I5Cgh0/VP+xL4yYgflqgX/n46XCmrsIiSOpKDQmMZ1FuRsk89FTjuZJ7kBeLGD3brEs+Nob7YwP3ylQNRcFskHh7MKIppW2HQ4H0fKbs8s7Vv4xwGCsVUDbf9OGN7mxPB6Aq3nqcV2OqNDCMchuXAPFWbK+xhRISXWo4tShVFB/veHnFOAn6pQxED+f2oNneZpHog4aeeVkkt1/wX5l5oGlfCWaeHdLPaOGosMZIpr4krZLyQX4BXPcgkQY/U/gHX5zbeGriny6oXSx8m6LW7aFuXvi/pPQKJa9BWCMdTcoOsSTmjc2LJxkrUj3lrGnb1m4HuGvbi13lP+w+JsiMORabbVkQdIg5og3STyDwVlXQJHriZskUab4Abjbrb16VzWk5h1VY6sjVhVm3eqVmVyav4ElQqHcPtF79031De48OO7yf5RtupbvMzo11V8zb+OQ9vYKJlleHP3J3Epdi225JtRNtGPORjueUIQdjv2tnVG1ICFkS3nHx5D6UGjyVZepMXjYh3cZnrTQXmjEvASqKBQRiqU3uxNbMcJmmyf4YVT4CEV
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39850400004)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(54906003)(36756003)(40480700001)(5660300002)(6266002)(2616005)(336012)(1076003)(26005)(2906002)(86362001)(4326008)(8676002)(8936002)(6916009)(41300700001)(47076005)(316002)(356005)(36860700001)(70586007)(70206006)(82740400003)(81166007)(478600001)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1tBX42Z4/DGWy16D2uVRo3YrtHzkvOvZPC5xENNNG5BizavdfnPLunefwQfVJT09tcwJhRDvWseSEyhUmZrsJLYBNgV9HIReDsdLS5l+PCaiAFlVni4XZcTdHVdNeI2fIHqcDq+go3/2YelcBZbFkh8X00RGoQVuIU4yI4ynCW1QCAf5tOcSFjipdH52Lxb6043t7GT8AAQIe2C3s3Ei/cdlt8RFcJlsZn6/UQiHjswYMVfu4ZMMYL3FC9m46h9gnrjCu+g2QQx/ouDQPOBLb16HoUGIcT30cyTdZ2TfcivdTu6IsLGCFSmgtTkOxhl9qW6GghvKqtef7kIrQG9u94D1Tw5l1HCI2UFLVnvzHblrGLhmptdhVz7qh6+7A27tVKB2jyvDK7VZmp/MhpXXsk2arQXPLuNVjC/cM9wPbJlQ8sGS0dEmgLQOoq62RWJ6xTio9zeVm78Kn5M8kjUDV3GB+qF0TEM0ZfyOjvaYjnXkEM7kpNqZ5tf99D5N8bHXmKUv2XV7LR2AuQw1nYjhr1jRrvqkCDGh1mU+fqyomeJ/FG0qwlDF5yJBpscblDdEOgmTRvFBts3wlhpQzqT9GPRph0+8ruSwRPVxbbq7yOqIJwd7fC+Ym4XTiDIq6Raitsl6a2vzakvHvZWePd9gJYOCuRAlF/rq2WuDInwPfvwfolzncBozJKWmoEEd8Xf3KEq+QVkFW03MdrM0gYrCX0NUx2NPNL1wK3XdEkvlKAmFrwuTqj8p+LRxN6YIkrWA05bMc7BX9hV6mUxS7IjixPXvOjEdCK8NFAA6khcxHtniz14FKW4e9bg7z6onYLg4inbQ6OSPikYz7/QUd0eWL2yZjqzIPd8Vl0mCIWtjocMNuPOXED3vH0IFp7xiO8z8HkpxtDQfz/VWzlOJtpjlXw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:23.0965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc6e19-0d79-4291-14f8-08dbb858673d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT032.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7559
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695056036-102421-25882-781-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.56.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibmFuZAVgZQMNXSKNEoKTnNwM
        DIxNLYwjQxLcXc3MzS0MQwxTLR0MRMqTYWAG47c/hBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan23-8.us-east-2b.ess.aws.cudaops.com]
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

fuse_direct_write_iter is basically duplicating what is already
in fuse_cache_write_iter/generic_file_direct_write. That can be
avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
and fuse_direct_write_iter can be removed.

Before it was using for FOPEN_DIRECT_IO

1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT

fuse_file_write_iter
    fuse_direct_write_iter
        fuse_direct_IO
            fuse_send_dio

2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set

fuse_file_write_iter
    fuse_direct_write_iter
        fuse_send_dio

3) FOPEN_DIRECT_IO not set

Same as the consolidates path below

The new consolidated code path is always

fuse_file_write_iter
    fuse_cache_write_iter
        generic_file_write_iter
             __generic_file_write_iter
                 generic_file_direct_write
                     mapping->a_ops->direct_IO / fuse_direct_IO
                         fuse_send_dio

So in general for FOPEN_DIRECT_IO the code path gets longer. Additionally
fuse_direct_IO does an allocation of struct fuse_io_priv - might be a bit
slower in micro benchmarks.
Also, the IOCB_DIRECT information gets lost (as we now set it outselves).
But then IOCB_DIRECT is directly related to O_DIRECT set in
struct file::f_flags.

An additional change is for condition 2 above, which might will now do
async IO on the condition ff->fm->fc->async_dio. Given that async IO for
FOPEN_DIRECT_IO was especially introduced in commit
'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
 FOPEN_DIRECT_IO")'
it should not matter. Especially as fuse_direct_IO is blocking for
is_sync_kiocb(), at worst it has another slight overhead.

Advantage is the removal of code paths and conditions and it is now also
possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
(in a later patch).

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 58 +++++++-------------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 24fa6cab836f..a5285a9e36e3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1052,6 +1052,10 @@ static void fuse_write_args_fill(struct fuse_io_args *ia, struct fuse_file *ff,
 	args->out_args[0].value = &ia->write.out;
 }
 
+/**
+ * Note: iocb->ki_flags & IOCB_DIRECT cannot be trusted here,
+ *       it might be set when FOPEN_DIRECT_IO is used.
+ */
 static unsigned int fuse_write_flags(struct kiocb *iocb)
 {
 	unsigned int flags = iocb->ki_filp->f_flags;
@@ -1631,52 +1635,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
-	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from, inode);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
-		 */
-		if (fuse_io_past_eof(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
-
-	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_send_dio(&io, from, &iocb->ki_pos,
-					    FUSE_DIO_WRITE);
-			fuse_write_update_attr(inode, iocb->ki_pos, res);
-		}
-	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
-
-	return res;
-}
-
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -1707,10 +1665,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
-		return fuse_direct_write_iter(iocb, from);
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		iocb->ki_flags |= IOCB_DIRECT;
+
+	return fuse_cache_write_iter(iocb, from);
 }
 
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
-- 
2.39.2

