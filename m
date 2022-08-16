Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF18596181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiHPRx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiHPRxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E065E564;
        Tue, 16 Aug 2022 10:53:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q16so9886685pgq.6;
        Tue, 16 Aug 2022 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=roEOVbMBkZrS+KI85Bv7B/f0yshSydvUYCZY5utraVI=;
        b=ActwK8Jt7K27jbZ1SDooaQBHFc3mnygMHje2PjXbo9ZNsrwCXn6G0xUASvSNkzD+0y
         AyrgUxkLsem6YNeJWCOpIkU9+FKbKit2PtMC1X7yLU2njQc5/9LmJY0jRsWpZys5v+64
         QChiPuqoPa2KA/eNJN1WLHS9y/DWnByD1K5nUAMlLlh5aLH36skgBCbSvl8ULnW0DHRY
         JUVCK/1kL+F2ub7VBdWH+Eb9bmID7kmFepbMBG9fkMqxZ3UAokQBCSPCZ0FbI3GfgZq9
         5BM0nLr4PP5Mm7iTE2zCy82fW9yhHLip/dCtTDvVrFIg0otieB7a8guaOQT3WQnSYtD9
         abSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=roEOVbMBkZrS+KI85Bv7B/f0yshSydvUYCZY5utraVI=;
        b=RE9nxKN0/TnEECSkb9loWctJ5aSKd3DuwCuNK36yDwRuSyOYdiQNWrG/F4WsT9SBov
         LVXrRBq0TdA4Z6RBKnBAAprkyB3O4B4MyoHQDvD+ZIk/ZoQmraAY8xSa5QHA/mwW8lXa
         xCXavNNKEsnps4jDf+5hURQyba/Z3IaGsuOlb78rVFn5/wTb6e5tlPZdoLpajAUGKTaq
         BWpp6svZ/NFQ0/SDJToGQ9c1zQCVcdPmV3ClSqZAd0nERsohvblWKstNQCFvvYu4xqdY
         LH9PLA2qDnPrlYsPUwFcd0keEgzqgZwRhxakvWN0PdbuRztQGDLQN31grsJnKcJujAOm
         lmhQ==
X-Gm-Message-State: ACgBeo3LpUDoTRh6BsLwTTJUQJm7JVFeyDk+RXPvax1qTDSIx9xJPr5x
        72oe+dX/IJIY3nXz8YzJ06WKNS7MqWdd2Xg7
X-Google-Smtp-Source: AA6agR6yFUT1jJHdNPbYH3EPp/bBZozQNeNVWrwD0KmtCBeHjs9sgp2lRPVNSFhHowmEeaH5rPDg7Q==
X-Received: by 2002:a63:d55:0:b0:41c:86b0:59b5 with SMTP id 21-20020a630d55000000b0041c86b059b5mr18810471pgn.351.1660672402576;
        Tue, 16 Aug 2022 10:53:22 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:22 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 1/7] filemap: Add filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:40 -0700
Message-Id: <20220816175246.42401-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is meant to replace find_get_pages_contig().

Unlike find_get_pages_contig(), filemap_get_folios_contig() no
longer takes in a target number of pages to find - It returns up to 15
contiguous folios.

To be more consistent with filemap_get_folios(), filemap_get_folios_contig()
now also updates the start index passed in, and takes an end index.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 73 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cc9adbaddb59..951936a2be1d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -720,6 +720,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_contig(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
diff --git a/mm/filemap.c b/mm/filemap.c
index 8ccb868c3d95..8167bcc96e37 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2196,6 +2196,79 @@ bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 	return index < folio->index + folio_nr_pages(folio) - 1;
 }
 
+/**
+ * filemap_get_folios_contig - Get a batch of contiguous folios
+ * @mapping:	The address_space to search
+ * @start:	The starting page index
+ * @end:	The final page index (inclusive)
+ * @fbatch:	The batch to fill
+ *
+ * filemap_get_folios_contig() works exactly like filemap_get_folios(),
+ * except the returned folios are guaranteed to be contiguous. This may
+ * not return all contiguous folios if the batch gets filled up.
+ *
+ * Return: The number of folios found.
+ * Also update @start to be positioned for traversal of the next folio.
+ */
+
+unsigned filemap_get_folios_contig(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	unsigned long nr;
+	struct folio *folio;
+
+	rcu_read_lock();
+
+	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
+			folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
+			continue;
+		/*
+		 * If the entry has been swapped out, we can stop looking.
+		 * No current caller is looking for DAX entries.
+		 */
+		if (xa_is_value(folio))
+			goto update_start;
+
+		if (!folio_try_get_rcu(folio))
+			goto retry;
+
+		if (unlikely(folio != xas_reload(&xas)))
+			goto put_folio;
+
+		if (!folio_batch_add(fbatch, folio)) {
+			nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
+			goto out;
+		}
+		continue;
+put_folio:
+		folio_put(folio);
+
+retry:
+		xas_reset(&xas);
+	}
+
+update_start:
+	nr = folio_batch_count(fbatch);
+
+	if (nr) {
+		folio = fbatch->folios[nr - 1];
+		if (folio_test_hugetlb(folio))
+			*start = folio->index + 1;
+		else
+			*start = folio->index + folio_nr_pages(folio);
+	}
+out:
+	rcu_read_unlock();
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios_contig);
+
 /**
  * find_get_pages_contig - gang contiguous pagecache lookup
  * @mapping:	The address_space to search
-- 
2.36.1

