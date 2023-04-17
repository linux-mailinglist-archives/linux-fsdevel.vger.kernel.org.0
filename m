Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF06E47E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQMgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQMg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:28 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF110D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 05:36:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230417123623euoutp01d34499be020ba52fb55cc393a42957c1~WuQ63wr-v3118431184euoutp01J
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230417123623euoutp01d34499be020ba52fb55cc393a42957c1~WuQ63wr-v3118431184euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681734983;
        bh=aUa3E5V08ZikWfn868iXTDHcwcBH+bVBiRBvQzjddAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhbMnT/ME5sVdzudD7sKG5E6dvawpJVe//57oKg10ZZe0TMoFXy9NN1tejzmht/Ce
         wAIVy5bOSinapicc0O+nPH1CN2JOWk2h5h/bRfDuEyRFZTnvaKW/ILpAVSy9sjSHBz
         fiPBlolNP3Kg7q+LPLvrRWMJ3/4Jnet2zRJxARf8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230417123622eucas1p144b3a52f4b71560de8d65487f85afb8f~WuQ55FflM1948519485eucas1p1E;
        Mon, 17 Apr 2023 12:36:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 40.F7.09966.64D3D346; Mon, 17
        Apr 2023 13:36:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78~WuQ5N1jHM2018020180eucas1p2Z;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417123621eusmtrp14d69488370c6e0b7f10b8b2f0b6a4f79~WuQ5NSxvr2401824018eusmtrp12;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-f8-643d3d468f24
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.38.34412.54D3D346; Mon, 17
        Apr 2023 13:36:21 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230417123621eusmtip295431b3fac9b584894e59afb3bd20519~WuQ490egw0739407394eusmtip2N;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/4] fs/buffer: add folio_create_empty_buffers helper
Date:   Mon, 17 Apr 2023 14:36:17 +0200
Message-Id: <20230417123618.22094-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417123618.22094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7putrYpBud2qFnMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgyng9+xtTQY9kxastE1ga
        GBtEuxg5OSQETCTetC9g62Lk4hASWMEosWj/EiYI5wujxPudG1ggnM+MElPf7gByOMBajjSo
        QMSXM0o0bN3JDuG8ZJT48/UEWBGbgJZEYyc7yAoRgUSJxXu6GUFqmAUWMEo8+bOGGSQhLOAq
        0Xh9PZjNIqAqMWfnDDaQXl4BS4mWc2oQ58lL7D94FqyEU8BKYsXmHjCbV0BQ4uTMJywgNjNQ
        TfPW2cwg8yUE7nBI3D79iRGi2UVi+zWQmSC2sMSr41vYIWwZidOTe1gg7GqJpzd+QzW3MEr0
        71zPBvGltUTfmRwQk1lAU2L9Ln2IckeJC3dA/gWp4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKqV
        JHb+fAK1VELictMcqKUeEpeaP7BNYFScheSZWUiemYWwdwEj8ypG8dTS4tz01GKjvNRyveLE
        3OLSvHS95PzcTYzApHT63/EvOxiXv/qod4iRiYPxEKMEB7OSCO8ZV6sUId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUwhj1yzHpQfMvyaZ2tWU73pbknR
        vbfH9u9T9pD6/P9ElXZq47auGjf+KFkZ/+aPR44cu/lwZ/628lO30xbO9nHpTjw8/c0sDvbs
        7d0xVgztnWpXLqxQl5momDslf2uY9TSFByfMMo6wyBbb2vtHvTzy7dp1sdhHdkxcj3/rHw0q
        7Lwuzf0n1zxtiZeb79LPwbseM6b83Wiyds4UccsdTxqX/XJj2h7gdlbJamGGYMLuRUcdJM7w
        HIpmde81L7Lqa5tw63mKs+QBMdt/Zupvq14zLV6hJl13YqHIPS7veQpKStwzjnMZ1ErMmKGh
        8Ur6PfuC3zrnpp2Pb7sym7UzOeFJtOxOr+amI55zhB7cXKLEUpyRaKjFXFScCAC/JmjfuQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7qutrYpBtd7zCzmrF/DZvH68CdG
        i5sHdjJZ7Fk0CUjsPclicXnXHDaLGxOeMlp8XtrCbnH+73FWi98/5rA5cHlsXqHlsWlVJ5vH
        iRm/WTz6tqxi9Nh8utrj8yY5j01P3jIFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZ
        GpvHWhmZKunb2aSk5mSWpRbp2yXoZbye/Y2poEey4tWWCSwNjA2iXYwcHBICJhJHGlS6GDk5
        hASWMkqcXqoFYksISEjcXtjECGELS/y51sXWxcgFVPOcUeLr+nvsIL1sAloSjZ3sIDUiAqkS
        K/7cAathFljGKHH4+11mkISwgKtE4/X1YDaLgKrEnJ0z2EB6eQUsJVrOqUHMl5fYf/AsWAmn
        gJXEis09zBD3WErcv7QNzOYVEJQ4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5N
        zy020itOzC0uzUvXS87P3cQIjJ5tx35u2cG48tVHvUOMTByMhxglOJiVRHjPuFqlCPGmJFZW
        pRblxxeV5qQWH2I0BTp7IrOUaHI+MH7zSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNT
        UwtSi2D6mDg4pRqYeP490HK5IX6Sp+5L0JVpKVfm9D84+2fypNVr9CwFcjzuap83K3pU5fFJ
        r3QFz80oEZOv8U3LpiximxRc/LQyn/9pbqWGhNbTWSGfdtd+kjN5u7Tvc7dQSs4N368RYVpr
        3+kXrruvbqGyr/lL2Af3zCszCzZ9qvhyzD9re/CRlwVT7eQf3rl66713np7CxOc7ly9LWyj6
        xfFj5ySbrI8/vc4dV53R8WmfWZlgz7vH3zI1Lnz4Jjtdgc/OJPS+/+RgNkkJl9i4jY4mHDVa
        ynMfd0y83f+dd/LPUAb5zNCYxvjMFb2pbcv2K9y8xpv4JOaQ1t5pmqHTVUwyll98aH9b54m0
        V+TC077LPz2+LXz2pRJLcUaioRZzUXEiAOnjU6wnAwAA
X-CMS-MailID: 20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78
References: <20230417123618.22094-1-p.raghav@samsung.com>
        <CGME20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Folio version of create_empty_buffers(). This is required to convert
create_page_buffers() to folio_create_buffers() later in the series.

It removes several calls to compound_head() as it works directly on folio
compared to create_empty_buffers(). Hence, create_empty_buffers() has
been modified to call folio_create_empty_buffers().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 28 +++++++++++++++++-----------
 include/linux/buffer_head.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 75415170e286..13724ef7eec7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1593,18 +1593,17 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 }
 EXPORT_SYMBOL(block_invalidate_folio);
 
-
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * block_dirty_folio() via private_lock.  try_to_free_buffers
- * is already excluded via the page lock.
+ * is already excluded via the folio lock.
  */
-void create_empty_buffers(struct page *page,
-			unsigned long blocksize, unsigned long b_state)
+void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
+				unsigned long b_state)
 {
 	struct buffer_head *bh, *head, *tail;
 
-	head = alloc_page_buffers(page, blocksize, true);
+	head = folio_alloc_buffers(folio, blocksize, true);
 	bh = head;
 	do {
 		bh->b_state |= b_state;
@@ -1613,19 +1612,26 @@ void create_empty_buffers(struct page *page,
 	} while (bh);
 	tail->b_this_page = head;
 
-	spin_lock(&page->mapping->private_lock);
-	if (PageUptodate(page) || PageDirty(page)) {
+	spin_lock(&folio->mapping->private_lock);
+	if (folio_test_uptodate(folio) || folio_test_dirty(folio)) {
 		bh = head;
 		do {
-			if (PageDirty(page))
+			if (folio_test_dirty(folio))
 				set_buffer_dirty(bh);
-			if (PageUptodate(page))
+			if (folio_test_uptodate(folio))
 				set_buffer_uptodate(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_private(page, head);
-	spin_unlock(&page->mapping->private_lock);
+	folio_attach_private(folio, head);
+	spin_unlock(&folio->mapping->private_lock);
+}
+EXPORT_SYMBOL(folio_create_empty_buffers);
+
+void create_empty_buffers(struct page *page,
+			unsigned long blocksize, unsigned long b_state)
+{
+	folio_create_empty_buffers(page_folio(page), blocksize, b_state);
 }
 EXPORT_SYMBOL(create_empty_buffers);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0b14eab41bd1..1520793c72da 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -205,6 +205,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
+void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
+				unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
-- 
2.34.1

