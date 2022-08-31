Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC35A74DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiHaET6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiHaETa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:19:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20BB7755;
        Tue, 30 Aug 2022 21:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMR/rCPldybrX/hf6dkxWwSUImNvNmBTN/w4W2uwkIDNukosK3JrwtynebtJKHzRasQun2nZynyIDfJuhxwgmq5ZTum0X2RM6XTCyvkJhR71Kqo5ZP9Fd/+EqYm85xHoduW+WtZOeiTZ0Od5ZVhSzKXQSJEplHu0TIkj0KuK54+lCgBhqnzIkzsGTtNuJD5MyX1K7fFuwJ03jf7dwVusvUuCo92ZJc8Jp6bSbmOGx4MA6XuxAWOKBI5FBrEG4XxYIyBqzbiQRGnMJaVR3mI6Iu5HPNrcrLgvePDqJOQKBq75r3SlssneilMrG5NbCPFRM3xQptW9G0A6McGvSgPwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAu/h0sUVw6tD3CUItXDkxlRPxdYIPja298n2n76n1w=;
 b=Q1xdos6AyvvvKYlsuaA9q1ovCfA6T83cffpaeH3+yPp9cXZbkybeRiWLiUQ0v6h39tzpUIZaTVawJcWc9E5lG6lm+obMU0Z1dlrVUVkL3U6Rm6wiwooJ8YIhi+2vie5KW3gvNCPhLdols6kbXueuQD8okF/1OyIRcmM5JbQi+dS9uvY8FFQCgQewZX4MAeek+yMKJ9jfN80twCQzmsswz1tv5zRubQgeutZUfc5ksJD9O1kagbpn32cQ8N7YF8FqoFaty8Quc/qH6ixXh6RaSJOEaXFCAlQauYJikV5KyKJ/APfai39cHNnYbz694DRrJAGoglxzQKRFpJWsncwF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAu/h0sUVw6tD3CUItXDkxlRPxdYIPja298n2n76n1w=;
 b=HRGP9kaHuNmnvEaWIQ/Iz7OmlBEsvKOzirblc+rsILS1krZdCjjqEGRt4TIMUugAzSNG48IMLPmHaogkz/KVO1yVPTuIuNJbEYvj3XOYBMOTw4JzTb1oxtrjoZeenBQDEagbx7kc5Ne8JEBFuoxBBe35ItnwK7oksMOcXCy93KhivUXGbA5oiNKqg1t/r52afLSEwOJQBbX3RTrfmtSPpD6Bl8TjIBWgz+EdqstBpFKGB9Y9iKe0i5C1tUTtFDW/n8CW/aqCYgBCU/LOvXc/oyt7M0KBvGKMksJK8E/QHA5+EfAwm+i+VuFzF/0UWrCvNVyd0BhvUFh1npDxPoPB/A==
Received: from DM6PR02CA0058.namprd02.prod.outlook.com (2603:10b6:5:177::35)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 04:19:04 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::7c) by DM6PR02CA0058.outlook.office365.com
 (2603:10b6:5:177::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:19:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:47 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:46 -0700
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
Subject: [PATCH v2 1/7] mm: change release_pages() to use unsigned long for npages
Date:   Tue, 30 Aug 2022 21:18:37 -0700
Message-ID: <20220831041843.973026-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a88de84-39ce-421e-ac28-08da8b07f049
X-MS-TrafficTypeDiagnostic: CH2PR12MB4263:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4e2dweLHYfEt2/xQ+xdU1gmcauZKRdyfVBBCaL/l5qLYw8uso0ndfAuJ7DsG5YEJjyDAwNLcdgEbsaksaANMtp+ZxbW8DrK0ApEo9sSwUzsGqtaM4YPrunSgT1EE4G/LorJ/nWCXNFG44xVMSDyYEW7nwQfW9WAsjOcFOSY8ti0XAsFzoskP+Gr8k48uizGNTKkx+IFtj1XJSewlpS3sJ23MdlwOsXX5FuaFmtqJ+iIpGkfXiIwP2BRdKcczn980YiuwCZW4Zo8NEaBzH14Ghu6qEbaV571nzN3CRzwZoRUKUesS27WYwoUzrg3iVNqWZ/5udscFyCYoXe/eTjoi64G/IGFjpNZ6nB1z5tn/J+M7JQXxILtYPZ/fBprXhJALwVbBxTH9SxF9pyW5S6s+fJBnumWhDc/g8EyAg60Ewvt2zURmmp1QAaZpM6+IC5v7Z9Dl9LFzhj38ABeN1PqhbXrJNzDcTLvz4dLp9/mQEl1vfQWWgl3CZdrRrddDA/3Pu4WgJwsgHltpgdlsCTGCPT2xWx8wO7VAzDlRj80hGtNQPujGXFi9/YzzBX6aRQZCqV2Vu3NbODkpc+BfzMZkjwI0yrV7jzan+qM35Ja7ZulxrlIYyxyuNWUiwSIexf4XJWnslXkjpz+u96KgfAQ0eMPTbGDCEZ9RRYivhki9ViAeHpIjdeSWN98Ea4unTDhTuBc2sqLb4/pNes9LSNvBMTykSTGfwAFIVJVGBcM+J8zYZNqPIMi8sYsZunaEBT3BZ9ItDTEajwAjeFQwPOg5WZI9Q2072dWawTEsPp47jOF704q8PwHbB48Asi3BqJc3
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(40470700004)(70206006)(2616005)(336012)(47076005)(1076003)(186003)(316002)(26005)(426003)(6916009)(86362001)(36756003)(2906002)(6666004)(83380400001)(107886003)(82740400003)(356005)(40460700003)(40480700001)(36860700001)(478600001)(82310400005)(7416002)(41300700001)(8936002)(5660300002)(54906003)(81166007)(8676002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:19:03.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a88de84-39ce-421e-ac28-08da8b07f049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The various callers of release_pages() are passing in either various
types (signed or unsigned) and lengths (int or long) of integers, for
the second argument (number of pages). To make this conversion accurate
and to avoid having to check for overflow (or deal with type conversion
warnings), let's just change release_pages() to accept an unsigned long
for the number of pages.

Also change the name of the argument, from "nr" to "npages", for
clarity, as long as that line is being changed anyway.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 2 +-
 mm/swap.c          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..61c5dc37370e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1145,7 +1145,7 @@ static inline void folio_put_refs(struct folio *folio, int refs)
 		__folio_put(folio);
 }
 
-void release_pages(struct page **pages, int nr);
+void release_pages(struct page **pages, unsigned long npages);
 
 /**
  * folios_put - Decrement the reference count on an array of folios.
diff --git a/mm/swap.c b/mm/swap.c
index 9cee7f6a3809..ac6482d86187 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -931,15 +931,15 @@ void lru_cache_disable(void)
  * Decrement the reference count on all the pages in @pages.  If it
  * fell to zero, remove the page from the LRU and free it.
  */
-void release_pages(struct page **pages, int nr)
+void release_pages(struct page **pages, unsigned long npages)
 {
-	int i;
+	unsigned long i;
 	LIST_HEAD(pages_to_free);
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 	unsigned int lock_batch;
 
-	for (i = 0; i < nr; i++) {
+	for (i = 0; i < npages; i++) {
 		struct folio *folio = page_folio(pages[i]);
 
 		/*
-- 
2.37.2

