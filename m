Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5D6E47EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDQMgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDQMgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:43 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC41706
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 05:36:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230417123628euoutp022316f1640d22b970dc8b5172944804de~WuQ-jpkdO3116431164euoutp02i
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230417123628euoutp022316f1640d22b970dc8b5172944804de~WuQ-jpkdO3116431164euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681734988;
        bh=75KNfTxhmRWwu1RZJ9toOVORdWlwvdSd8OTiAl+Smo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDU5O+BSMq3uWBx9pwmYtQeUNDTrnYAvVdxhb40HpyuQ7EHA3poUM5uEILk7vjpNa
         mRfuLEFC5OrZiBPL3ZOeWs/3e0+daD8ADsa/hf7VAWGeE3pHrwEpqJUtqPnipa8XHW
         rM2oHd87nwPh58UVJMZDRzb4zcw91I8MHbBZBWEA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230417123627eucas1p1c6760ed26e4ff1e4c75da5b623b23ba8~WuQ_xK_UR1066610666eucas1p1r;
        Mon, 17 Apr 2023 12:36:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 34.F7.09966.B4D3D346; Mon, 17
        Apr 2023 13:36:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8~WuQ_aK0gu2096320963eucas1p2S;
        Mon, 17 Apr 2023 12:36:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230417123627eusmtrp11dd2fe97ce12e5ef91d4871ded5a761e~WuQ_Zi88U2401524015eusmtrp1E;
        Mon, 17 Apr 2023 12:36:27 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-0a-643d3d4b0190
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.57.22108.B4D3D346; Mon, 17
        Apr 2023 13:36:27 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230417123627eusmtip2753e05ead6617a6d286d2128e6ae72a9~WuQ_OFEe20504505045eusmtip2e;
        Mon, 17 Apr 2023 12:36:27 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/4] fs/buffer: convert create_page_buffers to
 folio_create_buffers
Date:   Mon, 17 Apr 2023 14:36:18 +0200
Message-Id: <20230417123618.22094-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417123618.22094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7retrYpBitfG1rMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgyrj+6yFTQbtwxfJby9gb
        GC/zdzFyckgImEjsO/uYpYuRi0NIYAWjxNs965ggnC+MEvd23WKDcD4zSkw4coi9i5EDrOXX
        Bi+QbiGB5YwSF9akQNS8ZJTY+nQmK0gNm4CWRGMnO0iNiECixOI93YwgNcwCCxglnvxZwwyS
        EBYIlTix5yEriM0ioCpxaMEvFhCbV8BSouH0FHaI8+Ql9h88C1bPKWAlsWJzDzNEjaDEyZlP
        wOqZgWqat85mBlkgIXCHQ6Lz7z82iGYXifYNMxghbGGJV8e3QA2VkTg9uYcFwq6WeHrjN1Rz
        C6NE/871bBBfWkv0nckBMZkFNCXW79KHKHeUeLSoFxoOfBI33gpCnMAnMWnbdGaIMK9ER5sQ
        RLWSxM6fT6CWSkhcbpoDtdRD4lLrCuYJjIqzkDwzC8kzsxD2LmBkXsUonlpanJueWmyUl1qu
        V5yYW1yal66XnJ+7iRGYlE7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4T3japUixJuSWFmVWpQf
        X1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1Oqgckq1sx6i37bE5U/901/3X3z
        hFMuUNFiosyRNzfbdzk/ehSW3Lpx9ZdISZvsF7pB6Zr3/dI3P9i5wO9rPle6zzXBW7NP8KR+
        ObmVnTG65nJt4POTMozzLh94e1Ny7qxrO6riVqgFG+ve/PpTtXrjlMd/vrDx84Y87zwuwvqM
        NcT3weXlqZnlVcveNjV9e9/9vWZCaIam6T5VI8FEnniWP1duXguVMJq47ael0dMTFfsS8yu1
        7GxO1ttkbL+tcfCf17sLl1M4mnv1YqaxvFi+7YTCaucDaydqh6w5wBOhamv+r+WMLCuri37Z
        9mz/JLe4Uv41ubPYwowvKkVPU/0QXvp+9f/HlxfHFjlaWe06LKfEUpyRaKjFXFScCAAP9az9
        uQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7retrYpBuceS1vMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy7j+6yFTQbtwxfJby9gbGC/zdzFycEgImEj82uDVxcjJ
        ISSwlFGi87w7iC0hICFxe2ETI4QtLPHnWhdbFyMXUM1zRol/jR3MIL1sAloSjZ3sIDUiAqkS
        K/7cAathFljGKHH4+11mkISwQLDEpdbJYINYBFQlDi34xQJi8wpYSjScnsIOsUBeYv/Bs2D1
        nAJWEis29zBDHGQpcf/SNmaIekGJkzOfgPUyA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PT
        c4sN9YoTc4tL89L1kvNzNzEC42fbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd4zrlYpQrwpiZVV
        qUX58UWlOanFhxhNge6eyCwlmpwPjOC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU
        1ILUIpg+Jg5OqQammFPXpDTk/a4+m9p3987siP1yNQuCt3bfK+RfWNus7us+48HHDr+Q0526
        QccWmoTfs3r45GXTnYPnjq9OF+jNnmb0KvKb3c4J86Zd429WWnt0iqtyi5f0O6Y7hoKJjqc/
        MhjUupe8ynVesM7oQPDkY7ut8gOXb74de2qRcR7jOZl834e73dtqQl7cCXjyilVi0TaLuRHH
        wmtkNDimH5O4mvZqaVDZtaU3n+TnOVoHpU/oaHfZbHXwy8Wn/dPzTrVMWv9U7M3UW4Kzez4q
        /eH/eyLbRPCJGts3g79xUytOBm3nrnxtFdoQIp56n/H3pULTjv21u9c5B10vXbvKS1aO2ebl
        +k1T2r7E9m+q+6YipsRSnJFoqMVcVJwIAHDzDbgoAwAA
X-CMS-MailID: 20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8
References: <20230417123618.22094-1-p.raghav@samsung.com>
        <CGME20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/buffer do not support large folios as there are many assumptions on
the folio size to be the host page size. This conversion is one step
towards removing that assumption. Also this conversion will reduce calls
to compound_head() if folio_create_buffers() calls
folio_create_empty_buffers().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 13724ef7eec7..a7fc561758b1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1722,14 +1722,17 @@ static inline int block_size_bits(unsigned int blocksize)
 	return ilog2(blocksize);
 }
 
-static struct buffer_head *create_page_buffers(struct page *page, struct inode *inode, unsigned int b_state)
+static struct buffer_head *folio_create_buffers(struct folio *folio,
+						struct inode *inode,
+						unsigned int b_state)
 {
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << READ_ONCE(inode->i_blkbits),
-				     b_state);
-	return page_buffers(page);
+	if (!folio_buffers(folio))
+		folio_create_empty_buffers(folio,
+					   1 << READ_ONCE(inode->i_blkbits),
+					   b_state);
+	return folio_buffers(folio);
 }
 
 /*
@@ -1773,8 +1776,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	head = create_page_buffers(page, inode,
-					(1 << BH_Dirty)|(1 << BH_Uptodate));
+	head = folio_create_buffers(page_folio(page), inode,
+				    (1 << BH_Dirty) | (1 << BH_Uptodate));
 
 	/*
 	 * Be very careful.  We have no exclusion from block_dirty_folio
@@ -2037,7 +2040,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 	BUG_ON(to > PAGE_SIZE);
 	BUG_ON(from > to);
 
-	head = create_page_buffers(&folio->page, inode, 0);
+	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
@@ -2323,7 +2326,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-	head = create_page_buffers(&folio->page, inode, 0);
+	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-- 
2.34.1

