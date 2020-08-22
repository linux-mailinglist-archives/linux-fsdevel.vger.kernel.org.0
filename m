Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF2124E51A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 06:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHVEVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 00:21:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7900 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgHVEVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:21:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f409d240002>; Fri, 21 Aug 2020 21:20:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 21:21:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 21:21:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Aug
 2020 04:21:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 22 Aug 2020 04:21:05 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.94.162]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f409d310005>; Fri, 21 Aug 2020 21:21:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/5] mm/gup: introduce pin_user_page()
Date:   Fri, 21 Aug 2020 21:20:56 -0700
Message-ID: <20200822042059.1805541-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822042059.1805541-1-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598070052; bh=AWm7U3a8aov4PNZrSYviqR5QtvQW/uLd0HXBmgxRGZY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=ClifxiVuABBkqvc/rqX6402hmxTySQe6DZT+CO3/xTn9dndqsYA1/DERMczpJhmKX
         w/8FUE9ErK/3jA+GCZ1sqGBiLhg1zK1miQSti1fNYmBrsGzfSIRJRNWrpn+/ZeDWfK
         TDoAVUzZ0qPKq3O6BsfpzF+8d1pZMxybo8DE7gmn+fs1bAuvDstlmdsNbUGYPknySA
         /BbmcP7B/8lyEAKIYiK2UytD7Seeb5X4Lehc9g9Zl7nD3ix63Pbzf3Zm082f3faLgm
         IEDZaKiUXd/f8B1uccRquX40ku0FMN1PIKsVxxzJTPfSIIFO6Q14lYldC9vvpPg89F
         JlFf893Gw976g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pin_user_page() is the FOLL_PIN equivalent of get_page().

This was always a missing piece of the pin/unpin API calls (early
reviewers of pin_user_pages() asked about it, in fact), but until now,
it just wasn't needed. Finally though, now that the Direct IO pieces in
block/bio are about to be converted to use FOLL_PIN, it turns out that
there are some cases in which get_page() and get_user_pages_fast() were
both used. Converting those sites requires a drop-in replacement for
get_page(), which this patch supplies.

[1] and [2] provide some background about pin_user_pages() in general.

[1] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

[2] Documentation/core-api/pin_user_pages.rst

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1983e08f5906..bee26614f430 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1149,6 +1149,8 @@ static inline void get_page(struct page *page)
 	page_ref_inc(page);
 }
=20
+void pin_user_page(struct page *page);
+
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
=20
 static inline __must_check bool try_get_page(struct page *page)
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..2cae5bbbc862 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,6 +123,36 @@ static __maybe_unused struct page *try_grab_compound_h=
ead(struct page *page,
 	return NULL;
 }
=20
+/*
+ * pin_user_page() - elevate the page refcount, and mark as FOLL_PIN
+ *
+ * This the FOLL_PIN equivalent of get_page(). It is intended for use when=
 the
+ * page will be released via unpin_user_page().
+ */
+void pin_user_page(struct page *page)
+{
+	int refs =3D 1;
+
+	page =3D compound_head(page);
+
+	VM_BUG_ON_PAGE(page_ref_count(page) <=3D 0, page);
+
+	if (hpage_pincount_available(page))
+		hpage_pincount_add(page, 1);
+	else
+		refs =3D GUP_PIN_COUNTING_BIAS;
+
+	/*
+	 * Similar to try_grab_compound_head(): even if using the
+	 * hpage_pincount_add/_sub() routines, be sure to
+	 * *also* increment the normal page refcount field at least
+	 * once, so that the page really is pinned.
+	 */
+	page_ref_add(page, refs);
+
+	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
+}
+
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  *
--=20
2.28.0

