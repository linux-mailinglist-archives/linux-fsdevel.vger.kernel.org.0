Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267C6E47E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDQMg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDQMg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7B131
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 05:36:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230417123621euoutp02c1276ca9db610d83755473379bd9933e~WuQ5NZmuH2960829608euoutp02F
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230417123621euoutp02c1276ca9db610d83755473379bd9933e~WuQ5NZmuH2960829608euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681734981;
        bh=ToDE43tRnz0p+L+A0Gpl2BjRfNRIfbZq1R5380heax8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiT0q720f7N78z3fYHrOCC6zwrEGXRce+WcTWuSF5XrnEW5exXzM0HxujixhWqwS1
         Dvrc1EBWVj9dFinkyUld+fNc7kZOhVSmgvkgW3LM98qS5gUbeVgw08dWFN5Hkq0EPc
         gRmTZg+yvemfZaHiWMeT/DtEGfjVuzAckaGNpfAw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230417123621eucas1p2a869a48f275fbd8a8a171ab8a1f4290c~WuQ4fpo5Z0719007190eucas1p24;
        Mon, 17 Apr 2023 12:36:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.2D.09503.54D3D346; Mon, 17
        Apr 2023 13:36:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc~WuQ4MOQPw0505405054eucas1p2n;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417123620eusmtrp1b947be1384c5f0806db168e9ae7fa1c8~WuQ4LqdSR2401824018eusmtrp1z;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-40-643d3d458b9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.38.34412.44D3D346; Mon, 17
        Apr 2023 13:36:20 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230417123620eusmtip1b098fac03c10a0314c030e184a2a48be~WuQ39Emx92069820698eusmtip1T;
        Mon, 17 Apr 2023 12:36:20 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/4] fs/buffer: add folio_set_bh helper
Date:   Mon, 17 Apr 2023 14:36:15 +0200
Message-Id: <20230417123618.22094-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417123618.22094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87qutrYpBitWcFjMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgyph/fy5rwR+eivPf+RoY
        b3F1MXJySAiYSDR8fcPYxcjFISSwglHi96U2FgjnC6PEnIdr2CCcz4wSJ+9+YYRrOXGMFcQW
        EljOKLFyTiBE0UtGiWX3W4ESHBxsAloSjZ3sIDUiAokSi/d0g61gFljAKPHkzxpmkISwgLnE
        t+5XYEUsAqoSM38tZAKxeQUsJSZ9mcAEsUxeYv/Bs2D1nAJWEis29zBD1AhKnJz5hAXEZgaq
        ad46mxlkgYTAHQ6Jx/sOsoMcISHgIvFwpwXEHGGJV8e3sEPYMhKnJ/ewQNjVEk9v/IbqbWGU
        6N+5ng2i11qi70wOiMksoCmxfpc+RLmjROvsSVAVfBI33gpCXMAnMWnbdGaIMK9ER5sQRLWS
        xM6fT6CWSkhcbpoDtdRD4tP2BpYJjIqzkPwyC8kvsxD2LmBkXsUonlpanJueWmyYl1quV5yY
        W1yal66XnJ+7iRGYkk7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4T3japUixJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgSk3Zp1MZJ97xNWb8q9fqL/eXnJI
        6q6sg2SEyzFul1miTL9FzZ5d27n0QPOvwpu/g/4ctdh98OH5BOb3gZLuT2f+qLPT7RVdee1c
        tOPhk/UXIp7ezZv37+49x/NPVnAJvdJJvXjvzY5Oha7q+FM5Sx2+Lvno//GLX6fu2cMsZ/fu
        drslVKFmaaMoyBjy1nWW08SG1qPdnHK27ZeNZgb5fZkj0Wt76PTMm5WJstftJ2qI583UO3pW
        a5PBxSthNV1bOJIM2683L3WYadwdsJfx3iuTCH6+iX36U24XZfLu04xOybZ/JJLVsn/xsvKU
        DbqMrhN4uMPq/7zJs2eYqpYTPv0xi+/5sMKD1fdObbvczqvEUpyRaKjFXFScCADwXS6fuAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7outrYpBq9f6VjMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy5h/fy5rwR+eivPf+RoYb3F1MXJySAiYSDScOMYKYgsJ
        LGWUeLJMDyIuIXF7YRMjhC0s8edaF1sXIxdQzXNGicmz5zJ1MXJwsAloSTR2soPUiAikSqz4
        cweshllgGaPE4e93mUESwgLmEt+6X4EVsQioSsz8tZAJxOYVsJSY9GUCE8QCeYn9B8+C1XMK
        WEms2NzDDHGQpcT9S9uYIeoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQLjZ9uxn1t2MK589VHvECMTB+MhRgkOZiUR3jOuVilCvCmJlVWp
        RfnxRaU5qcWHGE2B7p7ILCWanA+M4LySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTU
        gtQimD4mDk6pBqb2oPRfH1xeHc1qb/t55b7PrIT1MlGtyaX+972y2Z8uT/s0Sf8vz88ZQl76
        x6pk/XSuLeE6r9IntuvPzTs2OcfPp82ySU9vV5MKMJI/21tcdn2t5BfzrK0dFn7XT2te8H8X
        p3LtmvgzbvkT28XDDb2/8qlIPVb8XflQ+5iG2Yzul7518XEecZ+Pbv11Qyhiy/TCc38fibY1
        KHiz3InvdbMInrb5/ZqZOclhPUYePM/3bOgNObuGi1tow0J92xlvLVhO2T886fXTfMee5Gl3
        76mv5Ii8uf6HP+dbN9s40xBDn3zvSUJphyNzZy8NitysPUt5afuXWdsWTr7wm8c6V2r3hNWp
        IffbJv/1t9r+ersSS3FGoqEWc1FxIgD2gHHgKAMAAA==
X-CMS-MailID: 20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc
References: <20230417123618.22094-1-p.raghav@samsung.com>
        <CGME20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The folio version of set_bh_page(). This is required to convert
create_page_buffers() to folio_create_buffers() later in the series.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 15 +++++++++++++++
 include/linux/buffer_head.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index b3eb905f87d6..7e74bd77a81b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1484,6 +1484,21 @@ void set_bh_page(struct buffer_head *bh,
 }
 EXPORT_SYMBOL(set_bh_page);
 
+void folio_set_bh(struct buffer_head *bh, struct folio *folio,
+		  unsigned long offset)
+{
+	bh->b_folio = folio;
+	BUG_ON(offset >= folio_size(folio));
+	if (folio_test_highmem(folio))
+		/*
+		 * This catches illegal uses and preserves the offset:
+		 */
+		bh->b_data = (char *)(0 + offset);
+	else
+		bh->b_data = folio_address(folio) + offset;
+}
+EXPORT_SYMBOL(folio_set_bh);
+
 /*
  * Called when truncating a buffer on a page completely.
  */
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8f14dca5fed7..7e92d23f4782 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -196,6 +196,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh);
 void touch_buffer(struct buffer_head *bh);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
+void folio_set_bh(struct buffer_head *bh, struct folio *folio,
+		  unsigned long offset);
 bool try_to_free_buffers(struct folio *);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
-- 
2.34.1

