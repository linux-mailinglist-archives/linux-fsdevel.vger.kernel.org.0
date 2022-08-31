Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA835A74D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHaETN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHaES4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:18:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2877EAB40F;
        Tue, 30 Aug 2022 21:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2bVPqSWletShz42MXF3jiunLlg2Z/23IhC6QM1o5Va/Nczd37j7IFYyNHZd1Iaz+Eyn9Rz9prWuSTYPhcr70g6UyaJJYZZMaAjwkUhrkC8ewnIZ6sjQZcCEZt12SoM6XizV4yb69gTZKfkFg8Z+rzwnfsrKba+VWXZOn90hP75SELr852MMaSy9VNCatvlgUGpmNpS8G6mo2MzZbQkodbUjYUQlVZmowtafjGZgRtOIdgeR12f3sDX/kM/e3+yUh2dKCdtVhEVw21C7o7bKiUQhA7z1Turmspa7TQ45KNjx9JiCZkl1MU4JBYQKerMp8b1C3S5ikJ/eCX3WDOgQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBugDiWZB7x/F4ljUpJEaRgWrMgNVOp/VewbCcAd91I=;
 b=M+WszXdZU/KqCUCHcqGkjAPPXst88H2o0uaCYDJ1IDkCCRE+cejzHXy28iK/o0Umq3BUtlHQCbjkyWoPswmCTNk0NR2jciKq6hOEUhgOHEXFPvECIjWcjjvsImZv7N8wTqG9yhTHuIGzYWXPkX17lqpERmkNY9SpChTQqws1aGgkE58DDbz/Vb8I/Yzta47HJtz4NThL9t6OJd9d7is5vepchz/2+lgSbftf5j01iCTqaNPIZ2K5dgpYn38L7iloeB5GS//mk8q4saTb8S3piBIG/DFZS+anpFZwkTty404rZ/jykrAAMiVdjRfzAP/CBTzKU3ItNNJqj+7bIp2AbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBugDiWZB7x/F4ljUpJEaRgWrMgNVOp/VewbCcAd91I=;
 b=kiMv7OT6sa48i3zWVQLYJZfNYbgJKH+zwo41k7D0FAXCKQIgPOTaozLGyxF5FwtvGe21oYmoNReC3FE0kFIIH/QJp+QF6xU1Gd4SCfPYT6O8UirueYQMJSjv0DepIgsUItos6ZQ5glWBvL6JKisrlvwXitDLu+1fmVIW9DVXrAt6UrEgnuSLD2jQq+U3Yg01cGnheaN1EfcL+tatvItqobWS0fHiLdJA3qT33AA0ZS70i/QHS2LT43xGSAIsFxfzPwIbHHzfjCKH4OZSIKuTcQUn4AMrTK6R7vZS6GyubXxX2muQvFhN9kC3CDOpwLMqjhkxMiCxBd68ca2VlHWjRQ==
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 04:18:53 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::a5) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:18:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:51 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:50 -0700
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
Subject: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Date:   Tue, 30 Aug 2022 21:18:40 -0700
Message-ID: <20220831041843.973026-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7e8e07b-7016-4b6f-1204-08da8b07e9af
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQ9eRZ8247NBf6rCDxetAkOxqaO7Ik6fWFvdkRQGZUr7MIIHeGgLahmBmHn1rYQyjCMyxETprh3C/Hccx1FmonNOfcwvZjb+8V8qtwvUsHc7uldq2VRNRrkMW4IqMFtMKvth4peQQ1Ezr2ht8s7I1cHBYocmNj0G6jgUpoM+Cbif/tdh+iKdb6GvGywi1RisEGOU22QZA5eKI4FZLjOPT1BDNs1c47veyL46i02iomjRJ9VDFDZ0OkQaY0jPDUiJUu1BByHVqVfICAhtLyGGRgHJtDo9H+BTso9ffE7mJ+SHVlI4SvrrJ+zbg4PAdpyibEc0G4TZZCpqLhRY+pTcIqSGYMD6xGBksac/yPsBHtx0tECPKq2WNE7WBJFqSxcY0A4G5j6Qt0dUEstcGLpMBD7rz9gjHz5Qwv/krDveyeXx8+ksS5R3ZlfzqOi8796pcF4qhHru2zAfnDbaazGTA00riPoHZ2HCf9qCdKcFCVuLnElFVerNoqMXmD9DAbNwTDeL6GduIdolumiQsJVVdTF2ypw+djWNIMqdLyEuMFTnXY9qSzx17mUuXESpJd8dqaTtsq+diA2FWNVLHkHEh2seUgtFCZrcIUtLkZFZxgsq2LcrjEy97MnCTfGVREmGAHGVMz5pJtZI0UvNh5ZZA8Ab0CIC2a9s/G+7vS2UvkAXhPbRPSoh7Asj6jvJJZfM27+7C0+0rmmBJLahridfppF/JBGOYmfVxGFIG2OUGqWD154ysShE6ckG82Q2yDWrLy1KQ1aIxDrCwj1qi+WrBaVQHsuLITexx/hARbjs9vBK97qx8lxtT8DdJS+2QKIj
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82740400003)(41300700001)(36860700001)(107886003)(426003)(1076003)(47076005)(26005)(336012)(2616005)(6666004)(186003)(6916009)(54906003)(40480700001)(82310400005)(70586007)(4326008)(83380400001)(8676002)(316002)(478600001)(7416002)(81166007)(70206006)(40460700003)(356005)(2906002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:18:52.6693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e8e07b-7016-4b6f-1204-08da8b07e9af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide two new wrapper routines that are intended for user space pages
only:

    iov_iter_pin_pages()
    iov_iter_pin_pages_alloc()

Internally, these routines call pin_user_pages_fast(), instead of
get_user_pages_fast(), for user_backed_iter(i) and iov_iter_bvec(i)
cases.

As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
variant, to release the pages, if they actually were acquired via
pin_user_pages_fast().

This is a prerequisite to converting bio/block layers over to use
pin_user_pages_fast().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |  4 +++
 lib/iov_iter.c      | 86 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5896af36199c..e26908e443d1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -251,6 +251,10 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
+ssize_t iov_iter_pin_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned int maxpages, size_t *start);
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4b7fce72e3e5..c63ce0eadfcb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1425,9 +1425,31 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
+enum pages_alloc_internal_flags {
+	USE_FOLL_GET,
+	MAYBE_USE_FOLL_PIN
+};
+
+/*
+ * Pins pages, either via get_page(), or via pin_user_page*(). The caller is
+ * responsible for tracking which pinning mechanism was used here, and releasing
+ * pages via the appropriate call: put_page() or unpin_user_page().
+ *
+ * The way to figure that out is:
+ *
+ *     a) If how_to_pin == FOLL_GET, then this routine will always pin via
+ *        get_page().
+ *
+ *     b) If how_to_pin == MAYBE_USE_FOLL_PIN, then this routine will pin via
+ *          pin_user_page*() for either user_backed_iter(i) cases, or
+ *          iov_iter_is_bvec(i) cases. However, for the other cases (pipe,
+ *          xarray), pages will be pinned via get_page().
+ */
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start)
+		   unsigned int maxpages, size_t *start,
+		   enum pages_alloc_internal_flags how_to_pin)
+
 {
 	unsigned int n;
 
@@ -1454,7 +1476,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		n = want_pages_array(pages, maxsize, *start, maxpages);
 		if (!n)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, gup_flags, *pages);
+
+		if (how_to_pin == MAYBE_USE_FOLL_PIN)
+			res = pin_user_pages_fast(addr, n, gup_flags, *pages);
+		else
+			res = get_user_pages_fast(addr, n, gup_flags, *pages);
+
 		if (unlikely(res <= 0))
 			return res;
 		maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - *start);
@@ -1470,8 +1497,13 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (!n)
 			return -ENOMEM;
 		p = *pages;
-		for (int k = 0; k < n; k++)
-			get_page(p[k] = page + k);
+		for (int k = 0; k < n; k++) {
+			p[k] = page + k;
+			if (how_to_pin == MAYBE_USE_FOLL_PIN)
+				pin_user_page(p[k]);
+			else
+				get_page(p[k]);
+		}
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 		i->count -= maxsize;
 		i->iov_offset += maxsize;
@@ -1497,10 +1529,29 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start,
+					  USE_FOLL_GET);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
+/*
+ * A FOLL_PIN variant that calls pin_user_pages_fast() instead of
+ * get_user_pages_fast().
+ */
+ssize_t iov_iter_pin_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned int maxpages,
+		   size_t *start)
+{
+	if (!maxpages)
+		return 0;
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start,
+					  MAYBE_USE_FOLL_PIN);
+}
+EXPORT_SYMBOL(iov_iter_pin_pages);
+
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1509,7 +1560,8 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 USE_FOLL_GET);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
@@ -1518,6 +1570,28 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
+/*
+ * A FOLL_PIN variant that calls pin_user_pages_fast() instead of
+ * get_user_pages_fast().
+ */
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	ssize_t len;
+
+	*pages = NULL;
+
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 MAYBE_USE_FOLL_PIN);
+	if (len <= 0) {
+		kvfree(*pages);
+		*pages = NULL;
+	}
+	return len;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages_alloc);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-- 
2.37.2

