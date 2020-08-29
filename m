Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8832565D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgH2IJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 04:09:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6667 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgH2II4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:08:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4a0c9b0000>; Sat, 29 Aug 2020 01:06:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 01:08:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 29 Aug 2020 01:08:55 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 08:08:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 29 Aug 2020 08:08:54 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.252]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4a0d160001>; Sat, 29 Aug 2020 01:08:54 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/3] mm/gup: introduce pin_user_page()
Date:   Sat, 29 Aug 2020 01:08:51 -0700
Message-ID: <20200829080853.20337-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829080853.20337-1-jhubbard@nvidia.com>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598688411; bh=nt0PtF6oHhEk4Ehi11ZCG1lTaPX813pQeWdo2szO18M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=GeCR42p0vG1Y/mcPDPfFg8Jr+t+lxTu2SPIfM2gbW6ioXBlHyDFBEpuWKpukI54u+
         wsuDo2DHLHKzyLlIOzIMY4I1LBumbthJEXfQmWXbbOStiZGBDqfFygVpB3cAvHtCxJ
         O7vNWk/2AOqUKjPA6p+gj8ZomZWK4+T5oteaJhEgJEmZcyDIMb4EFnfTlOEIici30Q
         IBgbsi1Eg0hhZ4Jobh5b6/CjdUvus97FqFJ/WqgEUtSAFqIA33aVOm1GONjDKd6GC3
         ODte/dvdN6LsXZp/2yOMJiuHmDsUiIwW+lNAgUdH40w5HufWhROtZDg4IwW21uTptn
         FfBYqJQiWcdAg==
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
index 97c83773b6f0..51c6ae4b63f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1152,6 +1152,8 @@ static inline void get_page(struct page *page)
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

