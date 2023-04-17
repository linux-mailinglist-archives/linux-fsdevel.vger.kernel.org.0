Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9C6E47E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDQMg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDQMg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DFF1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 05:36:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230417123622euoutp01b64fd1e36a43147f7736e095aadeb4b9~WuQ57rpFw3228632286euoutp01Y
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:36:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230417123622euoutp01b64fd1e36a43147f7736e095aadeb4b9~WuQ57rpFw3228632286euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681734982;
        bh=bGcZjkjJ2aM3lpU75XSeXq9MOtiINBQOzSIq1D3EodY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvAkyhrBZx+BRyji3Fz1+rlU5UKvoOzrB1jpobWMk2lRQV0B+xd85fqqFDCpOl6rj
         LRq6vk7nN+KBvu9CMNTPscVgMtSOIteoPFQsJUsAAt1HeaiQl2LM0nQMmQJPm4x6i2
         k+Evgb/fWcY/42FyHTTQha4YkgzxEEAnvJRLkeVQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230417123621eucas1p139372fab40849df20985f6a1e2899c8d~WuQ5BP4dA1535115351eucas1p1V;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 90.B5.10014.54D3D346; Mon, 17
        Apr 2023 13:36:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48~WuQ4tsdj51535615356eucas1p1V;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417123621eusmtrp10c912ff1810f75113d98d5e84f637179~WuQ4s-jJ82401524015eusmtrp15;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-97-643d3d452f22
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.57.22108.54D3D346; Mon, 17
        Apr 2023 13:36:21 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230417123621eusmtip2e5020cca319222f9f2ec463a15392570~WuQ4ewl9d0520705207eusmtip2u;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/4] buffer: add folio_alloc_buffers() helper
Date:   Mon, 17 Apr 2023 14:36:16 +0200
Message-Id: <20230417123618.22094-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417123618.22094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7qutrYpBr1tmhZz1q9hs3h9+BOj
        xc0DO5ks9iyaBCT2nmSxuLxrDpvFjQlPGS0+L21htzj/9zirxe8fc9gcuDw2r9Dy2LSqk83j
        xIzfLB59W1Yxemw+Xe3xeZOcx6Ynb5kC2KO4bFJSczLLUov07RK4Mvbt6GQteCpV0bbqDlMD
        42vRLkYODgkBE4k/B+K7GLk4hARWMEr8nruDDcL5wihxcNEURgjnM6PElce/WLsYOcE6tszs
        g0osZ5RYsmYdO4TzklHiQV8fE8hcNgEticZOdpAGEYFEicV7usEamAUWMEo8+bOGGSQhLGAr
        0blpJhOIzSKgKvF8yUawDbwClhILfy5jhtgmL7H/4Fkwm1PASmLF5h5miBpBiZMzn7CA2MxA
        Nc1bZzODLJAQeMAh0TdrHhNEs4vEw7U7oc4Wlnh1fAs7hC0jcXpyDwuEXS3x9MZvqOYWRon+
        nevZICFjLdF3JgfEZBbQlFi/Sx+i3FFieu9dVogKPokbbwUhTuCTmLRtOjNEmFeio00IolpJ
        YufPJ1BLJSQuN82BWuohsWPnfqYJjIqzkDwzC8kzsxD2LmBkXsUonlpanJueWmycl1quV5yY
        W1yal66XnJ+7iRGYlk7/O/51B+OKVx/1DjEycTAeYpTgYFYS4T3japUixJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgWlTlN1cCXdlbZ8t+3ZOVnh3wMzq
        xXPegPJz6Ws7+iV6I3fx9HfvqI2/LOCpZTD55tzvL613Ou06NbXlJB+ba8Xat30adzmrcp8t
        YTs25/YU33qTNYem729hWfTv63tB8QJ/S6+Qp20PV/R/LZOQ/Smlzm/tb2aZvGN5VduvLV/S
        jMOlVxww3DU1c11QvsnyfQcERBb479vg0WshWd82x/LDTfd7EqLvjeSiXpecn+9T4dC5NPCb
        s87sev21/dZJ0aGxrF/8k/ryO2w6vU4XbM79450YEb/u8BruAs98b54DLZfnJFp9adzi8br0
        8qXVM/kblMW/zJy504s/ytH5tYfyrY4YOblVyorLg1bqKLEUZyQaajEXFScCABpiAdi6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7qutrYpBjP3CljMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy9i3o5O14KlURduqO0wNjK9Fuxg5OSQETCS2zOxj7GLk
        4hASWMoosX/zLDaIhITE7YVNjBC2sMSfa11gcSGB54wSZ7oFuhg5ONgEtCQaO9lBwiICqRIr
        /txhA5nDLLCMUeLw97vMIAlhAVuJzk0zmUBsFgFViedLNrKC2LwClhILfy5jhpgvL7H/4Fkw
        m1PASmLF5h5miF2WEvcvbWOGqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECIygbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4z7hapQjxpiRW
        VqUW5ccXleakFh9iNAW6eyKzlGhyPjCG80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1Kz
        U1MLUotg+pg4OKUamLhzjL7wrDfTu5Ylm9M/t26flt3CjukXV+zauHOyyoa3X3ZmxTfyXZgW
        +G6Pp3Onybafaw7/unRos/aTj/buJQpCpmvncH67/tD6foRU7/SnVnL9hxUb6+wTSvIZ1QNW
        V+baywmkLC1j3/ykUUn+b9bN4Jh6+fCiaw5sekIOTjNvzZNunq5xSGL7pPrVFYu5pv65fbej
        T+TKZp3qtJ6NVrp6LQXHVsYt27M3Lrzl4Nsrm3w+ywatLGz3cPwS/ExS9OvJyfsCIrzueeot
        Ozkr7t+x2C+dG44ct5O+ntIx2/Hk+zOb7vv8XJiSrMLZ3PjhZCQjA9t+SWUeTTmhhYUTnBZ9
        npj6etX5jBcaMxdOylZiKc5INNRiLipOBAC6C1IPKQMAAA==
X-CMS-MailID: 20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48
References: <20230417123618.22094-1-p.raghav@samsung.com>
        <CGME20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Folio version of alloc_page_buffers() helper. This is required to convert
create_page_buffers() to folio_create_buffers() later in the series.

alloc_page_buffers() has been modified to call folio_alloc_buffers()
which adds one call to compound_head() but folio_alloc_buffers() removes
one call to compound_head() compared to the existing alloc_page_buffers()
implementation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 23 +++++++++++++++--------
 include/linux/buffer_head.h |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7e74bd77a81b..75415170e286 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -842,7 +842,7 @@ int remove_inode_buffers(struct inode *inode)
 }
 
 /*
- * Create the appropriate buffers when given a page for data area and
+ * Create the appropriate buffers when given a folio for data area and
  * the size of each buffer.. Use the bh->b_this_page linked list to
  * follow the buffers created.  Return NULL if unable to create more
  * buffers.
@@ -850,8 +850,8 @@ int remove_inode_buffers(struct inode *inode)
  * The retry flag is used to differentiate async IO (paging, swapping)
  * which may not fail from ordinary buffer allocations.
  */
-struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
-		bool retry)
+struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
+					bool retry)
 {
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
@@ -861,12 +861,12 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
-	/* The page lock pins the memcg */
-	memcg = page_memcg(page);
+	/* The folio lock pins the memcg */
+	memcg = folio_memcg(folio);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
-	offset = PAGE_SIZE;
+	offset = folio_size(folio);
 	while ((offset -= size) >= 0) {
 		bh = alloc_buffer_head(gfp);
 		if (!bh)
@@ -878,8 +878,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 
 		bh->b_size = size;
 
-		/* Link the buffer to its page */
-		set_bh_page(bh, page, offset);
+		/* Link the buffer to its folio */
+		folio_set_bh(bh, folio, offset);
 	}
 out:
 	set_active_memcg(old_memcg);
@@ -898,6 +898,13 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 
 	goto out;
 }
+EXPORT_SYMBOL_GPL(folio_alloc_buffers);
+
+struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
+				       bool retry)
+{
+	return folio_alloc_buffers(page_folio(page), size, retry);
+}
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
 static inline void
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7e92d23f4782..0b14eab41bd1 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -199,6 +199,8 @@ void set_bh_page(struct buffer_head *bh,
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset);
 bool try_to_free_buffers(struct folio *);
+struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
+					bool retry);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
-- 
2.34.1

