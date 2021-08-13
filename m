Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C93EAF61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 06:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhHMEmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 00:42:07 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:58113
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238661AbhHMEmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaArGSSh2WgxIf/NZgayKZYGwFfluJPeE6JiZ6snT3hJAGY8MbXrmtzqik04s0X9buPLX2CFNbzW9eXzHCtEap35YnlWr48iyqnNdrXcvjBXpx09sLjHjqHl2swDfU1eLskzvUdLlrk2L9+eJasVt7eqguYuLynUFdo7fH3RQ7pkNi4X8ET8dJSj4VFQzt7m1uCUcTsJfx84TjDXc8yL5QQ29AP8/XyF5DkRMk3wYCjJvxkB+U+KspG8bSElEgrJnmFN4r/ZgipksQC2x9HUmyC8YrYkNnWOE23LrPQxtIAJzIr91Pm8LpsFmStSKOWQjng/1rq6XIzXYrHB8PC1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBxDzvWl/c/IHWxMVFXMKwj27YOd/yVk3L+q5DJEkWs=;
 b=deMOq6BkjFnKFAkoBlkBU+rH6K9NzgZAma+q8yVtDDyMEY31V/SKA/4a7HlYrS2GbN26KhE/AuCPDFY0ZLrBrhU5FuJVK2XBRNaahstIIkJJPk81ibcWes5R8mihOk4Wvto8DhQBCTRWy0hrGOTzbTIRJA0CfwQyR5e42Gig2ntLF/SHjNMcAsgZdJPRG/HJEcX4zVjTtNv/K/XUf8+TomCxqOlPUwZcmV25Ew7W2QxlRsd7+rzTqHs8V1xLSrJOozGBV3Mn3qV5WbVgbvtJQY+ztLkdVN63A3y2ommsua2QWzYLi7ZiUCXGXa6F82jhVX9YMJjZxPAQHT8Rd3ei9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBxDzvWl/c/IHWxMVFXMKwj27YOd/yVk3L+q5DJEkWs=;
 b=OzzxVNTsqF0y9CM8m749T9kUaMpKp3SZbg3g1J/yskPHUIJ1LnmtaO12BtZyUiWdDnykcNKRvS8neUu9fCZCk5KyP6W7mbxWe80NiMhePqDrWrrLBoJxRCGUIb/1QX3ZT2GQcP02ouOH5jzuRPtbChULAHdOUmc1iu+Mrd6srq2mdJspHGe6q8FucDmuCjHzdGmA+Edfly6gwkCAJjXYf0BnKd/5CCcCeXjmznWSrsfu39Jbcijeqfu4FvyWCkdsEV6pBRmmNdVz8ylLmytLjbOpr4fyfkxGYUqYoM5jU+r5UaDA2aeq3f2J1ajjqpCj2RhHtcSwAchfcWq+xua6KA==
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 04:41:36 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::eb) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 04:41:36 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 21:41:35 -0700
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:35 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 3/3] mm/gup: Remove try_get_page(), call try_get_compound_head() directly
Date:   Thu, 12 Aug 2021 21:41:33 -0700
Message-ID: <20210813044133.1536842-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813044133.1536842-1-jhubbard@nvidia.com>
References: <20210813044133.1536842-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76314af1-ad14-4db4-0d81-08d95e14a265
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50999D2DA9395E58A14E8B71A8FA9@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxwZtv+fXudGMB3gGfMvgCyAj29gbEhM+b4t3uuf8WF6NqHb++VuuJWqinNeqjjgk+NXh+lWcz9Z7DVBJ2h14dV0BDIFgHAk/XoiYtSHle7g1hNzp39WUyy3KZhTc+xv2gUhoWgEJ2qmL9SMnVLyiv5ijbLkeWwwOqtEMNpxaMqhcgVbf8UTKiPt2vSiO+7MIbaui5BdMd2xKbQZtdkf9Zgsk4WJ1zIMFaS3kxzQibtyz8LUOfVU+hsd6hBcOwiGgnjvOiu2nT++/8K9MU+QSHbE0RppnOm0Iz0gsQ+dhZBSRAIU3S1HyWwpONJ1T/pJW55DAlRxBJKSSaIdyiIDc9ig3ykbkOWxGo9lt2HugsAvVBAI0lLU+XzZSLEGtnpNwEAsJb9sjikqRL8miVoouU4s1HkcD20FuMJy5w8gGJ0DiYk2HmIy4DjlgvmUE0vf8OO/NcyyStZBJpwAAObzLdYQsW4G8tnXkgVm7oCI3OlHucoJw/MYgQwSJbmjq6rmWm4pfWF8d8SvJt0c9YLiB0xYmTSYg9ef5jbFYhRkiTVeR6qhuHe03orgslCztFSNq8zqwO1C6oumKhhBFP2lNLRjKu8X12SAW0AAc0wSAZYIMYN/mNL2wbqZUpDNqJ2Wn8GIiihnJ51RImXc0kt5MWAUSDdtc7n6KXAHeOfxVYbL6rJ5PfSPK8w41Im4alMcPKioOK/usiSqGy06VcSb8g==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(82740400003)(70586007)(7636003)(186003)(7416002)(36860700001)(70206006)(86362001)(4326008)(426003)(82310400003)(336012)(2906002)(83380400001)(356005)(54906003)(2616005)(47076005)(5660300002)(316002)(8676002)(6916009)(1076003)(36756003)(26005)(8936002)(107886003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 04:41:36.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76314af1-ad14-4db4-0d81-08d95e14a265
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

try_get_page() is very similar to try_get_compound_head(), and in fact
try_get_page() has fallen a little behind in terms of maintenance:
try_get_compound_head() handles speculative page references more
thoroughly.

There are only two try_get_page() callsites, so just call
try_get_compound_head() directly from those, and remove try_get_page()
entirely.

Also, seeing as how this changes try_get_compound_head() into a
non-static function, provide some kerneldoc documentation for it.

Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/s390/mm/fault.c |  2 +-
 fs/pipe.c            |  2 +-
 include/linux/mm.h   | 10 +---------
 mm/gup.c             | 21 +++++++++++++++++----
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 212632d57db9..a834e4672f72 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -822,7 +822,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		break;
 	case KERNEL_FAULT:
 		page = phys_to_page(addr);
-		if (unlikely(!try_get_page(page)))
+		if (unlikely(!try_get_compound_head(page, 1)))
 			break;
 		rc = arch_make_page_accessible(page);
 		put_page(page);
diff --git a/fs/pipe.c b/fs/pipe.c
index 8e6ef62aeb1c..4394b80dc84f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(generic_pipe_buf_try_steal);
  */
 bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
-	return try_get_page(buf->page);
+	return try_get_compound_head(buf->page, 1);
 }
 EXPORT_SYMBOL(generic_pipe_buf_get);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ba985eaf3f19..f5ab4fd6d48c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,15 +1207,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags);
 struct page *try_grab_compound_head(struct page *page, int refs,
 				    unsigned int flags);
 
-
-static inline __must_check bool try_get_page(struct page *page)
-{
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-		return false;
-	page_ref_inc(page);
-	return true;
-}
+struct page *try_get_compound_head(struct page *page, int refs);
 
 /**
  * folio_put - Decrement the reference count on a folio.
diff --git a/mm/gup.c b/mm/gup.c
index 886d6148d3d0..7a406d79bd2e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -62,11 +62,24 @@ static void put_page_refs(struct page *page, int refs)
 	put_page(page);
 }
 
-/*
- * Return the compound head page with ref appropriately incremented,
- * or NULL if that failed.
+/**
+ * try_get_compound_head() - return the compound head page with refcount
+ * appropriately incremented, or NULL if that failed.
+ *
+ * This handles potential refcount overflow correctly. It also works correclty
+ * for various lockless get_user_pages()-related callers, due to the use of
+ * page_cache_add_speculative().
+ *
+ * Even though the name includes "compound_head", this function is still
+ * appropriate for callers that have a non-compound @page to get.
+ *
+ * @page:  pointer to page to be gotten
+ * @refs:  the value to add to the page's refcount
+ *
+ * Return: head page (with refcount appropriately incremented) for success, or
+ * NULL upon failure.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+struct page *try_get_compound_head(struct page *page, int refs)
 {
 	struct page *head = compound_head(page);
 
-- 
2.32.0

