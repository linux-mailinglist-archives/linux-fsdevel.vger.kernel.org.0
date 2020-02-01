Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB9414F647
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 04:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgBADlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 22:41:16 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4473 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgBADkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 22:40:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e34f2fe0000>; Fri, 31 Jan 2020 19:39:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jan 2020 19:40:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jan 2020 19:40:35 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 1 Feb
 2020 03:40:35 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 1 Feb 2020 03:40:35 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e34f3320002>; Fri, 31 Jan 2020 19:40:34 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 04/12] mm: introduce page_ref_sub_return()
Date:   Fri, 31 Jan 2020 19:40:21 -0800
Message-ID: <20200201034029.4063170-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201034029.4063170-1-jhubbard@nvidia.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580528382; bh=VhVwoCFqTx48m7C67hmpKfI2lp8OYGAP7BWu53hCs80=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=iDX4gxpQL2C0C9cMl4/0o9eEAC7Hffol4qeTM8bdozImGlWGXqrTALpzFzNxnt84/
         RP6GdlgNzoWj4sRyEUs8oyVGWXe+luTZElPfdyPd6vZfePeURd2Ux1fkG4/x2z70pn
         XJ2izDvgoWSUjZFwNRu1IjGXJZ+3MnE5RojJLRoNlgb+5a8aplp4kvEs3lPpb1Tg+0
         EHKeLOExY9j98deZAlBlmkzFh1D2x7PgVif+1weB34UZlIrezOItQEENKUD7tLo9Jt
         6TLR7YuU1IULbseyKPQlc2LYomTvJPzqML/kdsxGpziYRoKXXdjiZffwif2bKYuB8k
         lyJ7bq5UVNBsA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An upcoming patch requires subtracting a large chunk of refcounts from
a page, and checking what the resulting refcount is. This is a little
different than the usual "check for zero refcount" that many of the
page ref functions already do. However, it is similar to a few other
routines that (like this one) are generally useful for things such as
1-based refcounting.

Add page_ref_sub_return(), that subtracts a chunk of refcounts
atomically, and returns an atomic snapshot of the result.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/page_ref.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 14d14beb1f7f..b9cbe553d1e7 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int=
 nr)
 		__page_ref_mod(page, -nr);
 }
=20
+static inline int page_ref_sub_return(struct page *page, int nr)
+{
+	int ret =3D atomic_sub_return(nr, &page->_refcount);
+
+	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+		__page_ref_mod(page, -nr);
+
+	return ret;
+}
+
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
--=20
2.25.0

