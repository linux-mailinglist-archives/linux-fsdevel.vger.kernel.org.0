Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FC1D4F04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEONS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgEONRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A86C05BD10;
        Fri, 15 May 2020 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=432shkXra2Q82xS7AlMDJKErtAEp0TEP0/wbg8xsW6c=; b=q74mV6QRfYbFQZYu2vwH5zkmR4
        p+/bUMKwtWFAv/4hgmenXnXmpXdjkHro+yfLTWiyo6nSeW3lLhMvQbSN9qdAyDBH4Ea/Aaw2Yp0Ig
        CDoi+Dls87v/CZtQMeGOOHH4rkfYPXH9AgQK1oqSZHRaOm1R6baM+5fBPYqcdkNpqDe+jeBUzW8kd
        B4YJ/BjtdQhCkfPTr7FEHIM6BAp2+V0AJsiXzHoVI/MS13Iqkc/B+bRkLkxXAlf4auQIfxzJvwM0P
        HhfRnC3z3U2KO6/XMic7iEVoXUDznjlvpXPYs7awPswHb4FWOAjhP9a4wsbJe5N3jqYkiVIBV6lde
        m/ECie9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCz-0005bP-6C; Fri, 15 May 2020 13:17:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/36] bio: Add bio_for_each_thp_segment_all
Date:   Fri, 15 May 2020 06:16:32 -0700
Message-Id: <20200515131656.12890-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Iterate once for each THP page instead of once for each base page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h  | 13 +++++++++++++
 include/linux/bvec.h | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1c0f9ea4e63..4cc883fd8d63 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -131,12 +131,25 @@ static inline bool bio_next_segment(const struct bio *bio,
 	return true;
 }
 
+static inline bool bio_next_thp_segment(const struct bio *bio,
+				    struct bvec_iter_all *iter)
+{
+	if (iter->idx >= bio->bi_vcnt)
+		return false;
+
+	bvec_thp_advance(&bio->bi_io_vec[iter->idx], iter);
+	return true;
+}
+
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
  */
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
+#define bio_for_each_thp_segment_all(bvl, bio, iter) \
+	for (bvl = bvec_init_iter_all(&iter); \
+	     bio_next_thp_segment((bio), &iter); )
 
 static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 				    unsigned bytes)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a81c13ac1972..e08bd192e0ed 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -153,4 +153,27 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
+static inline void bvec_thp_advance(const struct bio_vec *bvec,
+				struct bvec_iter_all *iter_all)
+{
+	struct bio_vec *bv = &iter_all->bv;
+	unsigned int page_size = thp_size(bvec->bv_page);
+
+	if (iter_all->done) {
+		bv->bv_page += hpage_nr_pages(bv->bv_page);
+		bv->bv_offset = 0;
+	} else {
+		BUG_ON(bvec->bv_offset >= page_size);
+		bv->bv_page = bvec->bv_page;
+		bv->bv_offset = bvec->bv_offset & (page_size - 1);
+	}
+	bv->bv_len = min(page_size - bv->bv_offset,
+			 bvec->bv_len - iter_all->done);
+	iter_all->done += bv->bv_len;
+
+	if (iter_all->done == bvec->bv_len) {
+		iter_all->idx++;
+		iter_all->done = 0;
+	}
+}
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.26.2

