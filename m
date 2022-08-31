Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D016A5A74E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHaEUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiHaETe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:19:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE4FB7763;
        Tue, 30 Aug 2022 21:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYinaZuGih8oHR1FDQjWX60Hlqf9lLXdsLkXtbHFQB5tThgYdMHJOog+X60aPiI85pl6UjH0hVjRLPEjoF0X1E4zXDOZZceVHUQC7oezVSmBjlge1xjPdVyMFb09HPgN4vkK0Gm8gr6T8jtKXqmju6gvKTGl4JMtZ9M/rnHF57UzrQ79dFr/yR0SpF4Hw7mtDLD35475HD3xkGq9tMT+NnzwiIgXmaHOWixKga7zFGJzW0ccZWHY8Pr6W21GBxzTr2Tkc/IdTDHlAy/ERCa+wyCdTdp/28l1sxWiIS/jlsYHFngWPwmo2jS/2K0n8IAqymNjReTB7/G4OHyyVgSLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhzEKD6XzVqcKpciBei7NKL/0bYb8BFurKTQDrfYJWg=;
 b=XgQR27T45eyFoKqM2ndJ7oLbY4ZvIRy0oVBT2LUA45oSnOBjTblgm01EMKpnVZZnBdpX3uTeDrLUKX3IK4WWx8vHIBWZ2D8KHRoSETAfnWFYnt4i9NlpNuhPbXcRCU3DEKRoeJ3bKJ7497+K4G2UjF7Dj7q40S0GGev4Ar6MMPkjKbREWbA0LAjV3U6xCPIKcss/ieHDXBd3WYk2hFovUDKZ05xi8bfxHtj//lsdJgSED/YucJzjnERpezjVHLL9aqTZ9iyoUfcQlkr4Has2QSOZAU4GySvTIZDdyh+bPlB3wRZFoxus20pDPQL+l5o96zkdYFLEXjvnuZGu9XpmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhzEKD6XzVqcKpciBei7NKL/0bYb8BFurKTQDrfYJWg=;
 b=JqT08abPFL8rlg+NDrO9y44a5Us5dLOWl4ObUbXQscf2X/Qi9qlcZLAITfAyKnZx9X4Ce1ypuUFCeFwCfq6cNYzgfEs9RK1UDZxq0ia0wMxpAhZ2m1IwCHE8GT5t6A/O2yQRu0IhJYNwub+d8oD9tEXwWVPm+ZfOmk5XaXycK8OA4tigWbHW4opfYhBaIg2k+G04+whEYZU+AocoCP38QxyWivQOv/Q4x9G0jLsaevC5rCuaVRAxmkzZ3XtzbFstN6sLyNj6ZiaJGgFuMnLXkQ8AF0728G6VuGdEe2ViRQZvVhjNfwDjJibRiEfbyq5muU2onUtL2MViy3CIHzUH7w==
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 04:19:06 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::dc) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Wed, 31 Aug 2022 04:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:19:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:55 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:54 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 7/7] fuse: convert direct IO paths to use FOLL_PIN
Date:   Tue, 30 Aug 2022 21:18:43 -0700
Message-ID: <20220831041843.973026-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4177b4fa-919c-4dfa-0ee4-08da8b07f176
X-MS-TrafficTypeDiagnostic: MN2PR12MB4583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWsdieSEkCNlw6X9Yi+FSt7oZEGAYsVVqxfcBmQDoF7X4xVBaVnfM6x4LTVpKAT/sJ/hjJwfynmp1NI8LyCJgk1GQ/8k/PMPItApg87SMODymjeNJ/SbZEleEG2by09acv1Egw2LJ4WaEzAvVw8YQgriyRfeYN1/P2vEgFYjYmQEvZPmHfYevJD8a5DmZ2QKp6cl2lZD1gMiKHc2ZQycP6kFHpV3lkWUTD+xZmyc5ac03D84EvtGU820xyJQRr8wmwR7hdnGRFZinBjsAf8Hng8SnAUa8CnQ3twlFv4Qmyjv34oQEnl5pZ5HrkuexjWZOwPX1STOjC/hDxLePj1mTZeHYv2DjoMggd5LPg3AxMzpeVTGku3McbvIqNaBqnr5XsolcOXI8pspGzb3LrfhLVi80W4yfHFJcvXPjVUo6NGmhgZrx4pQA+2e31+/pUQwdNF+g1ry97gbi2kEQEtnNspjqonHO+Sk+vs4r6ixiW4GfYuJQZx35Phw5ITLxXYrgMIdjN0L7ik7dxXajNKj+jd2NzvKBHSwD399Phhw0yIbUQ8xXRaAut3o11Vky282BtlJ4hKQ2vScAf1Xn7MKF5pMvKEPEOzVaxOW46s4b/u6hJUYl4tGprVBOTHABlU4nPzz3dDz2P6rMr4kdh1/2XneqX7pvnGs7M2Hujz7xZYOtQjtLXlRk2j+Oru+3+xEPHbgXlVPqOKn58g7ky5sdYn7/AOTxTKZq032Eb1FPxYmx8mbRd4SaIgxrzIPQeJSt5s82U+qDPQtEJuOnd9VuYG82BqctoZKdzvCaT97hks=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(107886003)(6666004)(82310400005)(36756003)(2906002)(4326008)(8676002)(26005)(316002)(6916009)(54906003)(478600001)(40480700001)(82740400003)(356005)(81166007)(426003)(336012)(47076005)(186003)(2616005)(86362001)(70586007)(36860700001)(8936002)(1076003)(5660300002)(7416002)(83380400001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:19:05.7018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4177b4fa-919c-4dfa-0ee4-08da8b07f176
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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

The user of pin_user_pages_fast() depends upon:

1) CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and

2) User-space-backed pages or ITER_BVEC pages.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/fuse/dev.c    | 11 +++++++++--
 fs/fuse/file.c   | 32 +++++++++++++++++++++-----------
 fs/fuse/fuse_i.h |  1 +
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51897427a534..5de98a7a45b1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -675,7 +675,12 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
-		put_page(cs->pg);
+		if (!cs->pipebufs &&
+		    (user_backed_iter(cs->iter) || iov_iter_is_bvec(cs->iter)))
+			dio_w_unpin_user_page(cs->pg);
+
+		else
+			put_page(cs->pg);
 	}
 	cs->pg = NULL;
 }
@@ -730,7 +735,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		}
 	} else {
 		size_t off;
-		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
+
+		err = dio_w_iov_iter_pin_pages(cs->iter, &page, PAGE_SIZE, 1,
+					       &off);
 		if (err < 0)
 			return err;
 		BUG_ON(!err);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..01da38928d0b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -625,14 +625,19 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 }
 
 static void fuse_release_user_pages(struct fuse_args_pages *ap,
-				    bool should_dirty)
+				    bool should_dirty, bool is_user_or_bvec)
 {
 	unsigned int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
-		if (should_dirty)
-			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
+	if (is_user_or_bvec) {
+		dio_w_unpin_user_pages_dirty_lock(ap->pages, ap->num_pages,
+						  should_dirty);
+	} else {
+		for (i = 0; i < ap->num_pages; i++) {
+			if (should_dirty)
+				set_page_dirty_lock(ap->pages[i]);
+			put_page(ap->pages[i]);
+		}
 	}
 }
 
@@ -733,7 +738,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_io_priv *io = ia->io;
 	ssize_t pos = -1;
 
-	fuse_release_user_pages(&ia->ap, io->should_dirty);
+	fuse_release_user_pages(&ia->ap, io->should_dirty, io->is_user_or_bvec);
 
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
 
@@ -1483,6 +1488,10 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		fl_owner_t owner = current->files;
 		size_t nbytes = min(count, nmax);
 
+		/* For use in fuse_release_user_pages(): */
+		io->is_user_or_bvec = user_backed_iter(iter) ||
+				      iov_iter_is_bvec(iter);
+
 		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
 					  max_pages);
 		if (err && !nbytes)
@@ -1498,7 +1507,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		}
 
 		if (!io->async || nres < 0) {
-			fuse_release_user_pages(&ia->ap, io->should_dirty);
+			fuse_release_user_pages(&ia->ap, io->should_dirty,
+						io->is_user_or_bvec);
 			fuse_io_free(ia);
 		}
 		ia = NULL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..6ee7f72e29eb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -290,6 +290,7 @@ struct fuse_io_priv {
 	struct kiocb *iocb;
 	struct completion *done;
 	bool blocking;
+	bool is_user_or_bvec;
 };
 
 #define FUSE_IO_PRIV_SYNC(i) \
-- 
2.37.2

