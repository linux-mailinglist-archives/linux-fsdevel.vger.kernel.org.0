Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45F152339
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBDXlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:41:55 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8901 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgBDXlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:41:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3a00e60003>; Tue, 04 Feb 2020 15:40:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 15:41:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 15:41:20 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 23:41:19 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 23:41:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3a011e0002>; Tue, 04 Feb 2020 15:41:18 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v4 02/12] mm/gup: split get_user_pages_remote() into two routines
Date:   Tue, 4 Feb 2020 15:41:07 -0800
Message-ID: <20200204234117.2974687-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204234117.2974687-1-jhubbard@nvidia.com>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580859623; bh=5eZvoA5nW7X3dfTYOUjuH4An39unHi+TdehpbIAk1Fs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=XeW/rqQkwXtywsSBDjYabmhQ6QiQ3rTVpSSFkJ4HkWcJ77uw0/x7p4Ek+mB+Tn/f9
         W3/SLncUw+aNRIDytW6zkUdQyqkp4YSQbRn5Hc5nrAnO2wPr+rZ4J/scNsUpHabK0+
         JQdicag4Mrz44NCDbG23aKJJXm9/tWBxOLXSIRWkFa8MO6LKUmPWGiq776PXnCGf8L
         y8h7B1fu7R6mJR/Rm2Lqycg5czHeC0Wnvr37h8WdZxv8tzdEBCTtgFDLXoEayX/ItT
         3qZYHEFJ2zcZXuNcu2AvedsRVZ0PUH1Z3q5YUFNbx8/1dvr4W/XWfwW3LfXuKdKiCG
         AZ0Lkj4eozEOg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An upcoming patch requires reusing the implementation of
get_user_pages_remote(). Split up get_user_pages_remote() into an outer
routine that checks flags, and an implementation routine that will be
reused. This makes subsequent changes much easier to understand.

There should be no change in behavior due to this patch.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 56 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..b699500da077 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1557,6 +1557,37 @@ static __always_inline long __gup_longterm_locked(st=
ruct task_struct *tsk,
 }
 #endif /* CONFIG_FS_DAX || CONFIG_CMA */
=20
+#ifdef CONFIG_MMU
+static long __get_user_pages_remote(struct task_struct *tsk,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long nr_pages,
+				    unsigned int gup_flags, struct page **pages,
+				    struct vm_area_struct **vmas, int *locked)
+{
+	/*
+	 * Parts of FOLL_LONGTERM behavior are incompatible with
+	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
+	 * vmas. However, this only comes up if locked is set, and there are
+	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
+	 * allow what we can.
+	 */
+	if (gup_flags & FOLL_LONGTERM) {
+		if (WARN_ON_ONCE(locked))
+			return -EINVAL;
+		/*
+		 * This will check the vmas (even if our vmas arg is NULL)
+		 * and return -ENOTSUPP if DAX isn't allowed in this case:
+		 */
+		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
+					     vmas, gup_flags | FOLL_TOUCH |
+					     FOLL_REMOTE);
+	}
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+				       locked,
+				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
+}
+
 /*
  * get_user_pages_remote() - pin user pages in memory
  * @tsk:	the task_struct to use for page fault accounting, or
@@ -1619,7 +1650,6 @@ static __always_inline long __gup_longterm_locked(str=
uct task_struct *tsk,
  * should use get_user_pages because it cannot pass
  * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
  */
-#ifdef CONFIG_MMU
 long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
@@ -1632,28 +1662,8 @@ long get_user_pages_remote(struct task_struct *tsk, =
struct mm_struct *mm,
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
=20
-	/*
-	 * Parts of FOLL_LONGTERM behavior are incompatible with
-	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
-	 * vmas. However, this only comes up if locked is set, and there are
-	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
-	 * allow what we can.
-	 */
-	if (gup_flags & FOLL_LONGTERM) {
-		if (WARN_ON_ONCE(locked))
-			return -EINVAL;
-		/*
-		 * This will check the vmas (even if our vmas arg is NULL)
-		 * and return -ENOTSUPP if DAX isn't allowed in this case:
-		 */
-		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
-					     vmas, gup_flags | FOLL_TOUCH |
-					     FOLL_REMOTE);
-	}
-
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
-				       locked,
-				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
+	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
+				       pages, vmas, locked);
 }
 EXPORT_SYMBOL(get_user_pages_remote);
=20
--=20
2.25.0

