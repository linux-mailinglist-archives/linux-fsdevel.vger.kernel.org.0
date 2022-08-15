Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA58F593B42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiHOUNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbiHOUJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB858832EF;
        Mon, 15 Aug 2022 11:55:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 17so7145994pli.0;
        Mon, 15 Aug 2022 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DC0lDtuVz6yFca92GBSK6djBgAZXj0wHc7OOD2pjghE=;
        b=QWwJlBuMd3BZgQulNy3FF7Q8pHPEfKIeqgRJRGAHI5ml30UD5XY5UUb29NmNZ8GBjD
         GxKLYh8ECcsSkfb8EV5IztKhRaUL+Onv2MfPhcIiNquRk71zD8RiLLFXvt/rviGRyCIk
         8Y4upNBC2pPja+wNdchcY0q5S40PIsZtaqTiOA9sRc5a2o5UyIANJhCZaX0QOfz/9BVr
         GEtb3lgFajKMMwzsCGpuGJ5UlCPBFGxy93H79eQF8kL1tcdvqUpqF3vDpp8wcQvlX07b
         aXwTAzF6n1dZNb0C6hPPmmlC4TUj3CmYGpvXa+ZGc7hQxiNrXl1vl+Y7ZpGVOO5I7umb
         rtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DC0lDtuVz6yFca92GBSK6djBgAZXj0wHc7OOD2pjghE=;
        b=bqY4Exf39EF0MJAKCoEzJQrr/9Cqbq8+3cyBDtp7WicKrm80u+rIexnXl0u98qceTH
         K37UVoh0kQNKPcVgEm5WHDiyyqq4/X91DGzFzPe+7knJbhIHhfuccgHfovckd7UGHHiH
         G60pG9klrA1gYTSUQlZrt+tTaXDEv1jMUDklowZEzGdNf6a0CaJleGXLkm4NXqDvsg4B
         WrVXLvKJxm3eodfKpkWPXKY4hQr27lejs1Vk3/EkzgYN2iZJPGNzLR4klnQA/6OVQwHJ
         TmcWtfoN6ZNB3piaT0Wi2rFnMOE1cqsXcKHnJHRsmdb3OkkPjz4+58z0YUu1qpyJbP75
         cuXw==
X-Gm-Message-State: ACgBeo2gW1npB6LJHigWlKjMzGUGbKqzKeHACT33Gar9VPeJyVt49SpQ
        FC32nzHV9yJjQMJTPJPxFHVbTnmGrXGntrwX
X-Google-Smtp-Source: AA6agR6oRWqK8fWSNacTEJBV1JAilD8l4rIaZKnYmiUqRPSQ33T+fZtCDVjT3SqOVrTd4JO1xkIN3Q==
X-Received: by 2002:a17:903:41c6:b0:16f:3d1:f63 with SMTP id u6-20020a17090341c600b0016f03d10f63mr18064404ple.50.1660589758240;
        Mon, 15 Aug 2022 11:55:58 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:55:57 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/7] filemap: Add filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:46 -0700
Message-Id: <20220815185452.37447-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
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
index 0178b2040ea3..8689c32d628b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -718,6 +718,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_contig(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..3a497e178fde 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2194,6 +2194,79 @@ bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
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

