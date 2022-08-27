Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719285A35EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiH0Igd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D75B2DB2;
        Sat, 27 Aug 2022 01:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJwnyuIDOEK+ZWlRAqsUfMuse45AwM0Ps2KDl3VXuAmoiiTLFLOHYEEgmiSmpDO8i/vc6n8B2n1/uvTfRjthk4/ghVplVoVBP30sTFBj0qPNU9+cs5roSVpPo5uE2RXaAT76QmvbZkrkfTJyUwuvDmH5bj9cdKjLRxvw3mZG+sHdfVendJavA/OJuXJOuHLB9e2ug1CtsUwLLRZoTrtWQ8hlhcVGGKveXNLAgd5fgsEi0uV0QTpSP3AibVJRDnknEaNf94qwil5YimEmjNysj0v/1aTA+7hUWY4ZXLEvtu1M/ajrf9ybKEL/j9DitVSVam4f8oMBKGsSysnCifWkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huPDqMjn3txLV0ohJIHpJLOiJMrfH0byrZT2L7g4oV0=;
 b=CkK3hhzCQy26Q8CeOfUMMfO6rxZCUMDA1vliHysDxn+zOLVqrkpOdxBvI0f+pl1dGQdzbr23vepUoyFcVb3ZTJi6E7pRld7euwB9gvWqAtxZdA3Lk9RCq39yo6S4jUQbN3w21YT6P88QybSkorgaZY0jisnZGRpKwcdk5vHS/6183TwEyMlh5WnqPRuSwwi5TITObED1aKZ/SWPOiV4bCWQgdUFgqe7ILYrl4eslR8ZehbhBQLZPCM9Myr6FE1QMh0oJdkInd78SPcG2CTW/0OGgcyy+bdlPqOegdGC2C88HwJXQKJZ1pDdk/BRxrx46uelZMaJ4K5yqDQlpypA8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huPDqMjn3txLV0ohJIHpJLOiJMrfH0byrZT2L7g4oV0=;
 b=TXqEdwaj+YC0sEWqbU6BBTmrh1IxSfXdjpxGmaiOCqgRhpSqy7IARL0edzcZl0wi/fLkiAYyQRzYHvxlcjFFiBJqY3J+OR7KmsnA2c0VZm3ylNBfXgeAKA20Ql2k5Ai7P7PrKZhrWjFYp/jAXq1woTzYZlkp5yB2E8YeuhdPUdVkpyqRUhA38Dw6rE98JrvueRh7tNDmWhYYUoZ1J/qFS5HgYjLQRZu8lMyq5Spm+m6LM/Yf9dk4lx/I/vrXup8t0D3xf8N+js+jXMIAjOiOR69BS2QZHm0b9zz7KaWPmgKRH9Qj3FDUyu5t/+iLk03SVC28NoCgkZdGaNeEc9Oa9w==
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by BN6PR12MB1380.namprd12.prod.outlook.com (2603:10b6:404:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 08:36:15 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::3f) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:14 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:14 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
Date:   Sat, 27 Aug 2022 01:36:07 -0700
Message-ID: <20220827083607.2345453-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dd39851-16d0-40a3-9b9e-08da880734a0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMKwUJFBqc5KWe8/0tClb0xMLOIU4eMcZKSJLudZXvm2XJtLI+5IhangcMQSaT31z8byiTJwSz/4T1QuHFVnNPpGbPfzzggHE1U1ukJVGC7rrwbMH/PRMlyMOh4br5DFd4oInSVAEuuQ7B13QhdMJR6sZrUCHtBtVw0iQgjXlxZaK7Ql61IF7YDwpnJQhYisZ/fppWPyjCi6Ti4aMfxz1Vhm5bL/xDcz9KKNH0ef/QeR1t9hs9bYLT16pvCFp7b96co9aC7kkt7iazKfiRMwL7m78PNJRF8Pmdd0p5/RllyJPGeqAYVjczeyFLPCvmAomkevbQkLKiy84VhEnjY1u5bKxKzCybpwPiiQqUj342CcG5aLtyXtTEbMtHoERhacL5Di3tly3c1Gw+Dzgj2ZGxDL5UIHJrUFwdKsFvlY22wc5UI6zQ0fMUspwy01vNmTQI3Xd3+UxIBxDy/vbwzJ/iYVmV4JRNswzHCLeP+uZUdMId5ETxEKJA4gaMsMXxLaBUwS5AADGfJQTSb+/+8GfJCJMIHnxQbMRF8LR8WPI6zGpL46AhuKQyKjf+oUA10mbTYzO1TtpKzsJXvsYaHnIebvG8+HAd40JvzP0gZ0MI6W2V370ApdROJunoqZ/Knleh1adkc8doRWo/DWCCRIOAIcUi8Kjp5iDUplx9Nf0Wkutat6X/JqmoanU8jMs08RbI8+RZ0H2Lo1iquqgnZyAjw3C3KD4J+YRy2p1wDcT7TdbIk/kSkHxrL22OQALIN0vynF42tsuIOCTpIGE7ZZRMHbQXctihTYVwk+7UKxo2Q=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(478600001)(47076005)(426003)(83380400001)(8676002)(4326008)(70586007)(70206006)(40460700003)(2906002)(5660300002)(8936002)(107886003)(6666004)(7416002)(41300700001)(2616005)(1076003)(86362001)(186003)(336012)(82740400003)(316002)(36756003)(81166007)(54906003)(36860700001)(6916009)(40480700001)(82310400005)(26005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:15.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd39851-16d0-40a3-9b9e-08da880734a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1380
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the fuse filesystem to use pin_user_pages_fast() and
unpin_user_page(), instead of get_user_pages_fast() and put_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/fuse/dev.c    |  8 ++++++--
 fs/fuse/file.c   | 31 ++++++++++++++++++++-----------
 fs/fuse/fuse_i.h |  1 +
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51897427a534..eb841fc82bb9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -675,7 +675,10 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
-		put_page(cs->pg);
+		if (cs->pipebufs)
+			put_page(cs->pg);
+		else
+			dio_w_unpin_user_page(cs->pg);
 	}
 	cs->pg = NULL;
 }
@@ -730,7 +733,8 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		}
 	} else {
 		size_t off;
-		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
+		err = dio_w_iov_iter_pin_pages(cs->iter, &page, PAGE_SIZE, 1,
+					       &off);
 		if (err < 0)
 			return err;
 		BUG_ON(!err);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..a79aa4fea937 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -625,14 +625,19 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 }
 
 static void fuse_release_user_pages(struct fuse_args_pages *ap,
-				    bool should_dirty)
+				    bool should_dirty, bool is_kvec)
 {
 	unsigned int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
-		if (should_dirty)
-			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
+	if (is_kvec) {
+		for (i = 0; i < ap->num_pages; i++) {
+			if (should_dirty)
+				set_page_dirty_lock(ap->pages[i]);
+			put_page(ap->pages[i]);
+		}
+	} else {
+		dio_w_unpin_user_pages_dirty_lock(ap->pages, ap->num_pages,
+						  should_dirty);
 	}
 }
 
@@ -733,7 +738,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_io_priv *io = ia->io;
 	ssize_t pos = -1;
 
-	fuse_release_user_pages(&ia->ap, io->should_dirty);
+	fuse_release_user_pages(&ia->ap, io->should_dirty, io->is_kvec);
 
 	if (err) {
 		/* Nothing */
@@ -1414,10 +1419,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
 		unsigned npages;
 		size_t start;
-		ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
-					*nbytesp - nbytes,
-					max_pages - ap->num_pages,
-					&start);
+		ret = dio_w_iov_iter_pin_pages(ii, &ap->pages[ap->num_pages],
+					       *nbytesp - nbytes,
+					       max_pages - ap->num_pages,
+					       &start);
 		if (ret < 0)
 			break;
 
@@ -1483,6 +1488,9 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		fl_owner_t owner = current->files;
 		size_t nbytes = min(count, nmax);
 
+		/* For use in fuse_release_user_pages(): */
+		io->is_kvec = iov_iter_is_kvec(iter);
+
 		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
 					  max_pages);
 		if (err && !nbytes)
@@ -1498,7 +1506,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		}
 
 		if (!io->async || nres < 0) {
-			fuse_release_user_pages(&ia->ap, io->should_dirty);
+			fuse_release_user_pages(&ia->ap, io->should_dirty,
+						io->is_kvec);
 			fuse_io_free(ia);
 		}
 		ia = NULL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..1d927e499395 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -290,6 +290,7 @@ struct fuse_io_priv {
 	struct kiocb *iocb;
 	struct completion *done;
 	bool blocking;
+	bool is_kvec;
 };
 
 #define FUSE_IO_PRIV_SYNC(i) \
-- 
2.37.2

