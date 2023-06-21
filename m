Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B5737D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFUIim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjFUIie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693371981
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621083828euoutp02e6a87b8839d883c42a6f0976e8847ab4~qn8vVmqQg0634806348euoutp023
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 08:38:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621083828euoutp02e6a87b8839d883c42a6f0976e8847ab4~qn8vVmqQg0634806348euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687336708;
        bh=p3mOYJ8f1hVTCexaglZ7i/L8HoJqlurEbyVlQliHZdg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RaplaNf1wD/mwGTQe7KrTATIyCaJoFt2irKviIfjU0pDW6CWKHtrBLCHDHKQvwqpk
         6b0rBkL0UzeXgIfPw8hSf11Hfl7g4KDbdK1Tt8Y4hoLoGhAkiKlceQMWHFq6aozxvY
         S4tAdL5htcY1Q5vHyb4BzPLzcTGONgw3f+gD3JDg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621083827eucas1p1911afb01b8e07c4de65ceb9ae1cca543~qn8vFJWSq2121821218eucas1p1Z;
        Wed, 21 Jun 2023 08:38:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.2A.42423.307B2946; Wed, 21
        Jun 2023 09:38:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083827eucas1p2948b4efaf55064c3761c924b5b049219~qn8u0qtvQ2799227992eucas1p27;
        Wed, 21 Jun 2023 08:38:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621083827eusmtrp2c2782f3198b3fa03d1bb09a40cf6c73f~qn8u0FFW40288202882eusmtrp2n;
        Wed, 21 Jun 2023 08:38:27 +0000 (GMT)
X-AuditID: cbfec7f2-25927a800002a5b7-93-6492b703aa1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.8B.14344.307B2946; Wed, 21
        Jun 2023 09:38:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083827eusmtip239f1c51b1230f7e64d3e672ac51768e8~qn8uq2k3_0773907739eusmtip22;
        Wed, 21 Jun 2023 08:38:27 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 09:38:26 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <hare@suse.de>, <willy@infradead.org>, <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 2/4] filemap: use minimum order while allocating folios
Date:   Wed, 21 Jun 2023 10:38:21 +0200
Message-ID: <20230621083823.1724337-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621083823.1724337-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/n6bmn42lPd9FnUXJjUio34Ugk5JDNj8T8k1NPaa6r3ZX8
        ijslOqJdfswpWvltXd1dnVLRD8dSGkucX2E6qsmms0lt0vWw9d/r/X2/39v7s30pXHDBxYtK
        UqSxSoVMLiL5hOXR7/ZA/K4uft554wJJ5aMuJKkr0WGSW3esmORl2ylMUlffQkg67hWSElu+
        HUmGBwvJcEr6pASk5pv+UtPtXFJa+1pNSs2tB6UOk89Gcgd/aTwrT9rLKoOX7eTvtl8eJFLv
        +e1ztH9FatTnq0WuFDAhUKxpxrSITwmYmwi6TZ9JTvxE8KqljHSmBIwDQV1xwv9GxadKFy50
        A4HjgwFxYjQ0XPGBx4lKBC+thYQWURTJ+IMml+dsezDhYDYWjrVxpg5Bg2YAcxpCZjVUPcsj
        nEwws6D8Ys5Yl2ZCocGgdCIw06H0IzgTrsxSMN5qRE6mGXdoudg91sRHI1lVl3COARp7enBu
        tAjU5jaC40yoz2oYmwnMCAXV2iIXzlgFnY1ZPI6F0Pe48h9Pg5GaKxjHB8FuG8a5cjaCMzXl
        JDcuFE63yTlcAfYXOzh0A1u/OzfHDXSWCzj3TMOJHEE+mqkfd4B+3AH6cQcUI/w28mTTVcmJ
        rEqsYDOCVLJkVboiMSguJdmERv9O65/HA9WoqO9HUBPCKNSEgMJFHrS3SRcvoONl+w+wypRY
        ZbqcVTWhqRQh8qQDwlriBEyiLI3dw7KprPK/i1GuXmosc2skr3+ka+XQ8prrBQuN5ZOOJezK
        Prkxw7fDgs/kead55fZOClky51xXqLB8zcTtJ709Sqdsmus7O2PN5zsJv4xWka3bWv3GEEFn
        pya+isJ+mo7e78wNs19dFKXUDvUaDj+MVFhDHN+igmv18wJritQLN+8vCDv7tDVgm3tXTo9o
        4Jx+vbYpzP56bfaEKn5seP9ay/pmIm9LdMgig3idW+aRFXb5Es20oudCR8wvn+/B7wYHHamX
        vXSG6PeRETPmD4UeK/va/q6xd3HKsg3Nf0pviGeU9gYc9xPR6r7oLz4RtkPr8h9kvBWXLCiw
        dMho+po9bihNaI6JSZImqYzRk/00IkK1Wyb2x5Uq2V87wpuHqgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7rM2yelGOy6qWKx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jKfzfrAU7NKo+HzuOWMD4yuFLkZODgkBE4kND7ewdjFycQgJLGWUaPy0iQUiISOx
        8ctVVghbWOLPtS42iKKPjBLdy14yQThbGCX+PjoM1MHBwSagJdHYyQ7SICLgILF54xywqcwC
        exglDjR+YgJJCAu4Smy90Au2gUVAVWL9zDawXl4Ba4kD64pATAkBeYnFDyRAKjgFbCQ2rjzI
        CGILAVW0H58KNp5XQFDi5MwnYFOYgcqbt85mhrAlJA6+eMEMcbOSRMPmM1C/1Ep0vjrNNoFR
        ZBaS9llI2mchaV/AyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMDK3Hfu5ZQfjylcf9Q4x
        MnEwHmKU4GBWEuGV3TQpRYg3JbGyKrUoP76oNCe1+BCjKdCXE5mlRJPzgakhryTe0MzA1NDE
        zNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBae/L6W9T1wbu3uCwYNr/ZQ4BNyO1
        LQ8wbLL8k5l0rT99ddz/r6sF446+/NF6q3vurennH0e+dvtz48SCsh6B0mm3407ObT77yjH2
        svm6SE3e4zdUTgp9uzntoc/G59s3SnQmtpp/v9NZ1623pvP7tyuzTtcX86qkik1i3K80waTz
        7/rVPF+b3n2aJSi1v/9HtNIMe8fp00Rmeehk/PZereLMxqCygLV5buT1iWoncjNV+R5ut7nX
        1fL33rOb+3Su3zg/+6jiR5Xs63v63wY+fP3o3AHRs/N2qK+wmPvvCqNIfpX9oq4DO9R+BPnq
        WCyN/r/t2L/T113aufYJcjc9nxxlsntir0ick9u1RQcOLajuV2Ipzkg01GIuKk4EAByVAs1V
        AwAA
X-CMS-MailID: 20230621083827eucas1p2948b4efaf55064c3761c924b5b049219
X-Msg-Generator: CA
X-RootMTR: 20230621083827eucas1p2948b4efaf55064c3761c924b5b049219
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083827eucas1p2948b4efaf55064c3761c924b5b049219
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083827eucas1p2948b4efaf55064c3761c924b5b049219@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to filemap and readahead to use the folio order set by
mapping_min_folio_order().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c   |  9 ++++++---
 mm/readahead.c | 34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3b73101f9f86..9dc8568e9336 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1936,7 +1936,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp |= GFP_NOWAIT | __GFP_NOWARN;
 		}
 
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 
@@ -2495,7 +2496,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_min_folio_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -3663,7 +3665,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..090b810ddeed 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -245,7 +245,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
@@ -259,7 +260,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio) - 1;
 	}
 
 	/*
@@ -311,6 +313,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
+	unsigned int folio_order = mapping_min_folio_order(mapping);
+	unsigned int nr_of_pages = (1  << folio_order);
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -320,6 +324,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * be up to the optimal hardware IO size
 	 */
 	index = readahead_index(ractl);
+	if (folio_order && (index & (nr_of_pages - 1))) {
+		unsigned long old_index = index;
+
+		index = round_down(index, nr_of_pages);
+		nr_to_read += (old_index - index);
+	}
+
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
@@ -795,18 +806,20 @@ void readahead_expand(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	pgoff_t new_index, new_nr_pages;
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	unsigned min_folio_count = 1U << mapping_min_folio_order(mapping);
 
-	new_index = new_start / PAGE_SIZE;
+	new_index = new_start / (min_folio_count * PAGE_SIZE);
 
 	/* Expand the leading edge downwards */
 	while (ractl->_index > new_index) {
-		unsigned long index = ractl->_index - 1;
+		unsigned long index = ractl->_index - min_folio_count;
 		struct folio *folio = xa_load(&mapping->i_pages, index);
 
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
@@ -818,7 +831,7 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
 		ractl->_index = folio->index;
 	}
 
@@ -833,7 +846,8 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
@@ -845,10 +859,10 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
 		if (ra) {
-			ra->size++;
-			ra->async_size++;
+			ra->size += folio_nr_pages(folio);
+			ra->async_size += folio_nr_pages(folio);
 		}
 	}
 }
-- 
2.39.2

