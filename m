Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28985A74CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiHaETO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiHaES5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:18:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A90AB4CE;
        Tue, 30 Aug 2022 21:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guPiIGM3y8NJTpPXxTQvuVowl4Ke5zWQIP9ryEDot+Ufk6rMGI2xiTK0a1c9Lvzd0AX98QDqRPiBpVJk2Wz2/qfXMgimZ5A7OVjGTMwnpZlQG8XqnMPDf48Ic+dFD/iWIYe3dTxjsT009HN5Rk04xU1RpcQjv8Bf9BCcTSpxbLuzZelOdO5KGZziZQO6cgmuW7Su2ySt3UUOdgqDlA45l/moKJs3/vtEly22bwe+OFD1DMaS88cfIx7ihVTRyo2b9oBFbScc6obNo7oYOKygQjKs6nJE/EUhS53MF6EUbj437HNvoYErE44ng46Oxo/S3F57dbD+J2e0Y5+dH48fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxDgq14BPL52n/7cjhue2PT6ARIQiBfUGFJisDO/ekY=;
 b=cYBLDGTsqvAmCphdRhQqI8d0rYZDvsOtb4rkBN0JSFm/iuDc+JZUy2mTnsaEGlmuDtwzFU3peyRrUJXk/oTCqPi/wUV9EK3GD2Hncq7QGKOowutBheU+zQa97y7chKDelFei7GrcHpMlaKxvb5Ks992D0577l6/Pp2L13u6Re2JZBiVio2KkOrDrwMdsYvpXXeJ6gHYvQovIQRjVe38WPmF3wEm3pTjLl4HnIFnOPbBj1tfI5kMcU7Ez7NQrPrTKey+fESnI4xwTO716Aazn6mAopRwPrOTTcvJ3sij438Xy9Nuz3GPJc9jU3lspMessdL8vJkgnJaCjdhOVjEO2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxDgq14BPL52n/7cjhue2PT6ARIQiBfUGFJisDO/ekY=;
 b=lkHgtiGj08Bud1xzpqU8q/+5Lm16BDjjvLUJ87hulnZzJPRpqaraxsihaEgSw/msBR0oTUi4Xv9dqoG8Ws5DvoqLr+5WjZuIeowI4lJ8wk6mcHl/WMtQwA9OWxbDJu1d4WTJBJohD7D7gCUjzIgpSI8xTLRiVIXdmz07pDdBXGFUbq9N9QAzX3qkRymmqNAg1RWSWQaAA2xpb0j5FZ/Ufs85HxMQEni0aDLMOKWMTPlVBsdI/t8Av5jjtklRVUtdOPoKMOkm2jBgVS/VEfHn45SsoeEIX2z5jnUUcqCLqVReFoO6cuRNFNQxotsZJXVVRoBXvMTPXLes5Bjdc+GOQA==
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 04:18:53 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7f) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:18:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:48 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:47 -0700
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
Subject: [PATCH v2 2/7] mm/gup: introduce pin_user_page()
Date:   Tue, 30 Aug 2022 21:18:38 -0700
Message-ID: <20220831041843.973026-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d05557-4ac9-4362-9877-08da8b07ea09
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO9AWp+3mG7wrlLkjtdgvEVEjAPRhnNI96EXlv1zVTmDhbuic6JP2Wf1V7oS4MsW8KbXrJ7Iaxcg8d392ZAKu3UwUpD/Pi/NnHZGM9Ubc66eN9MYROD6GVjMC99Naiba924lWruJc9aMEs3b+C3+WGOtI4JNwsYg5nbGJJ7zzuGguUJJM1D2YRoOtIcZbH9E7lh3d9VUO8DI9LKf1IJ/joMUPvz/tF0yqllLpTm4Yq5tGHAiLHr5O51hmb8Sa0axBL0r4p1Rj0aE74SfZbAezID3wmGbMu6clCTXWfn3tMaXRoYVSKu6UI23Uate+HKUlEW/1sM5QNOJArJvRWX2SvS8msjbHh7Pksd2PLm5YfRvoWC50L36TV/xV6rPi/aQVqSceaz501xNdwsICjyFgR1aEhdGhYn/oobTUh01tsjfy5PxBbTtH9EXa5bzfVlziIPzIrGPbdeGCAEbCvc8ycvBkT6ai+6u0WA3587xRRRujR+Em6Le4P8G+TacrvFG8odnKrW9DD5d1x5UkRlSoM/cQxJw8HR2D2VT9PRCjhc0FdSoJI0xYArQ1+TWUpMzZmXslw04gGdsOiLbV1rFFQlCZy2Ypom2EFrWhrjFiDYU4ZUUf2rb3q06nyMXm/JYcZ8TV9zCszs3ObsUXMEcl622nNFIx7YB/E6jwDwv0SK642xpGkPNkL4a0EIzosaiCt27XYp15g05AaXrGIW9vOFug6TrtS/1hSL5M69Wpe4haSbNlhoQEcImvMYwAMeQoxgkbogOuzxQmWd5Tkz+PehrjogVuuZSRoQTUGzCEu/2hHoTn9Kx8fak9S/W0pWg
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(70206006)(86362001)(82310400005)(6666004)(478600001)(107886003)(41300700001)(81166007)(26005)(336012)(82740400003)(40460700003)(40480700001)(186003)(356005)(83380400001)(47076005)(1076003)(426003)(5660300002)(2616005)(36860700001)(4326008)(8936002)(7416002)(8676002)(54906003)(2906002)(316002)(6916009)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:18:53.2625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d05557-4ac9-4362-9877-08da8b07ea09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pin_user_page() is an externally-usable version of try_grab_page(), but
with semantics that match get_page(), so that it can act as a drop-in
replacement for get_page(). Specifically, pin_user_page() has a void
return type.

pin_user_page() elevates a page's refcount using FOLL_PIN rules. This
means that the caller must release the page via unpin_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61c5dc37370e..c6c98d9c38ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1876,6 +1876,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
+void pin_user_page(struct page *page);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..2c231dca39dd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3213,6 +3213,56 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages);
 
+/**
+ * pin_user_page() - apply a FOLL_PIN reference to a file-backed page that the
+ * caller already owns.
+ *
+ * @page: the page to be pinned.
+ *
+ * pin_user_page() elevates a page's refcount using FOLL_PIN rules. This means
+ * that the caller must release the page via unpin_user_page().
+ *
+ * pin_user_page() is intended as a drop-in replacement for get_page(). This
+ * provides a way for callers to do a subsequent unpin_user_page() on the
+ * affected page. However, it is only intended for use by callers (file systems,
+ * block/bio) that have a file-backed page. Anonymous pages are not expected nor
+ * supported, and will generate a warning.
+ *
+ * pin_user_page() may also be thought of as an externally-usable version of
+ * try_grab_page(), but with semantics that match get_page(), so that it can act
+ * as a drop-in replacement for get_page().
+ *
+ * IMPORTANT: The caller must release the page via unpin_user_page().
+ *
+ */
+void pin_user_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
+
+	/*
+	 * This function is only intended for file-backed callers, who already
+	 * have a page reference.
+	 */
+	WARN_ON_ONCE(PageAnon(page));
+
+	/*
+	 * Similar to try_grab_page(): be sure to *also*
+	 * increment the normal page refcount field at least once,
+	 * so that the page really is pinned.
+	 */
+	if (folio_test_large(folio)) {
+		folio_ref_add(folio, 1);
+		atomic_add(1, folio_pincount_ptr(folio));
+	} else {
+		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+	}
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+}
+EXPORT_SYMBOL(pin_user_page);
+
 /*
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
-- 
2.37.2

