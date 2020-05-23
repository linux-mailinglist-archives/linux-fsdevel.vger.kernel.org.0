Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7411DF474
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 05:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgEWD7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 23:59:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14781 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbgEWD7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 23:59:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec89efd0000>; Fri, 22 May 2020 20:56:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 20:59:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 20:59:11 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 May
 2020 03:59:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 23 May 2020 03:59:11 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.52.1]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec89f8f0000>; Fri, 22 May 2020 20:59:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        <devel@lists.orangefs.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] orangefs: convert get_user_pages() --> pin_user_pages()
Date:   Fri, 22 May 2020 20:59:09 -0700
Message-ID: <20200523035909.418683-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590206205; bh=IUi0GpOpORIfa8wCBq2zBkJfP/EEDe3USpDV5HpfHqc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=FaPlam/S9EqBdtcSpbgQ+XxTdqJLQQznCtA49glUta2sbL6t/offvbJPDLT436xPN
         5H6NB6RA74NGNEVbDuUozp+1XD29LzgK1RkXieQsCpR4jETKKhIWEEB5o9F7Nbx/qS
         2nqPrOtYZxWq2cmcVj1sKwEudIBbQXU/s4dYHBmRZRXFZnfW56GYiOhfs5AcXRIE5N
         8mGmX/CosJ9w1jeDqO8TxkzwFzjfwAVGm70WJQwaLUW6oC2s6Xzy/vR7Pr1TxCM+z7
         IkaCrdF6bX5bD21RThH0czCqw5VeHmZ8yAn0BMlt9fCT+qUaV44R2u9NGBzQ5DjW2f
         L1FbLm2dNS9/w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code was using get_user_pages*(), in a "Case 1" scenario
(Direct IO), using the categorization from [1]. That means that it's
time to convert the get_user_pages*() + put_page() calls to
pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Note that I have only compile-tested this patch, although that does
also include cross-compiling for a few other arches.

Changes since v1 [3]: correct the commit description, so that
it refers to "Case 1" instead of "Case 2".


[3] https://lore.kernel.org/r/20200518060139.2828423-1-jhubbard@nvidia.com

thanks,
John Hubbard
NVIDIA

 fs/orangefs/orangefs-bufmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 2bb916d68576..538e839590ef 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
 static void
 orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
 {
-	int i;
-
-	for (i =3D 0; i < bufmap->page_count; i++)
-		put_page(bufmap->page_array[i]);
+	unpin_user_pages(bufmap->page_array, bufmap->page_count);
 }
=20
 static void
@@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 	int offset =3D 0, ret, i;
=20
 	/* map the pages */
-	ret =3D get_user_pages_fast((unsigned long)user_desc->ptr,
+	ret =3D pin_user_pages_fast((unsigned long)user_desc->ptr,
 			     bufmap->page_count, FOLL_WRITE, bufmap->page_array);
=20
 	if (ret < 0)
@@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
=20
 		for (i =3D 0; i < ret; i++) {
 			SetPageError(bufmap->page_array[i]);
-			put_page(bufmap->page_array[i]);
+			unpin_user_page(bufmap->page_array[i]);
 		}
 		return -ENOMEM;
 	}
--=20
2.26.2

