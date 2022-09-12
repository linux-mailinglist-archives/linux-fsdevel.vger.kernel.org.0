Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293D5B603C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiILSZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiILSZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D613DD2;
        Mon, 12 Sep 2022 11:25:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so9382299plz.7;
        Mon, 12 Sep 2022 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=;
        b=C8tTc8TnMRmq8rC87xPSSFuWkjT3xmHJ0btLP2zj1KPi/mYfzMf8Rr4ArHYir2v9F0
         aDLj56lDM+iFTWk/zg8V9FMLydED1mER+7ZW+HSacA1Ej5sNBEeth+9uec6b+pru0Fpv
         3sKnfJN/oUk6XdHc8r+TXXl+xNqynm1rWDRyJu95M1GlHq2pvxvtoyD/Kya0tcn4ND8L
         v1Lj8AH8zQNtOiQyHh0+tz0ZCnJc5SPGGoRYBgWwYy1Ws7ceTUrmQfwfqPJzc7zkKdfX
         2VvNkqm5gSbU5GD8ydRTGzlx8S2HOxhhfdTfh+LhphtedIuii+OhWYM3mjKtn9npS+TQ
         RINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CVjZRQRXjU7sjBLr6rHvAQKfUIl2rAWam+cMUVwdi8E=;
        b=L+9rz7EVq5uT0TY5SEWFuDMeqdm5VbdIzoJKXgRl2FwFdnUe8jm995KsWyKsJoYeqE
         7OpJLXZnY0beZmkZntShyFF0UrT+s9Un36jUsla332lWNEf9h7gJplQ+IYcKmjTN2wGS
         E3xBgS6JKeAB9LZ704DJtrfd+MVL30NyjZdddXN2peiOykGJFWcjYPS/rVHxZW/83Pe8
         8nmPSf8RthwhocVCsdsYiSJ2AaxhEFP2RAnu/CxTARWgeELgD/sfyvwRNjTOtWs9QBt8
         On8yDtf3lxoB1MY9i7JsiSiY8RUrlEIJoB0cGBcY1D/hXQqVbDq34EMg8U/EkE3wGeWh
         E0Pg==
X-Gm-Message-State: ACgBeo1bDDF6PLYZ3k66TAYOQAET6+aeOTqO3KUs8c4nfrV70WQOn66M
        vWezRKwJX+Ff2wxWx/lkykeia+XT7j0Eeg==
X-Google-Smtp-Source: AA6agR40OpkZ83mFEur41Nd8yYH6gBhsxOKDPQNbIwZqQIbEwWceV824CZSdb5ygWwDeOXZ24XfwnA==
X-Received: by 2002:a17:90b:4c46:b0:202:b9c5:2f24 with SMTP id np6-20020a17090b4c4600b00202b9c52f24mr10473866pjb.180.1663007123740;
        Mon, 12 Sep 2022 11:25:23 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:23 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 02/23] filemap: Added filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:03 -0700
Message-Id: <20220912182224.514561-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the equivalent of find_get_pages_range_tag(), except for folios
instead of pages.

One noteable difference is filemap_get_folios_tag() does not take in a
maximum pages argument. It instead tries to fill a folio batch and stops
either once full (15 folios) or reaching the end of the search range.

The new function supports large folios, the initial function did not
since all callers don't use large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4d3092d6b2c0..85cc96c82c2c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -740,6 +740,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..3ded72a65668 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2254,6 +2254,59 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(find_get_pages_contig);
 
+/**
+ * filemap_get_folios_tag - Get a batch of folios matching @tag.
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ * @fbatch:     The batch to fill
+ *
+ * Same as filemap_get_folios, but only returning folios tagged with @tag
+ *
+ * Return: The number of folios found
+ * Also update @start to index the next folio for traversal
+ */
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/* Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged. Skip over it.
+		 */
+		if (xa_is_value(folio))
+			continue;
+		if (!folio_batch_add(fbatch, folio)) {
+			unsigned long nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
+			goto out;
+		}
+	}
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios_tag);
+
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
-- 
2.36.1

