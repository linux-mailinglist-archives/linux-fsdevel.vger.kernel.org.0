Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0281359F04A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiHXAnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiHXAmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563E8670D;
        Tue, 23 Aug 2022 17:42:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso16326163pjo.5;
        Tue, 23 Aug 2022 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/CfNnOMJk6G65551bZckVmJ3kjJ/k4Yc+qvoAg65GHU=;
        b=G8TXZ41ypzXH2ZGDemwUIRnrhlgVru1aOFOrt11RUGeOxYD2OEbjqjcKoGK6qHOJi9
         MbtYizKOZFfhZwL8kE8b9i9Vda56q1LheWpsm8zBqVGawexnK256o4cNnjDR2yR0RNj1
         jWmHonngeuWnuopR3tvKa2pkmlrs5Pvf+FehXXpbrFYiVp5TramRl4P9BVFicecGfqZH
         7P5r07WqQCaO+01g7WRirRh4lfh0/bgOArCv3maqdBcWCfoaSptp5Y2zL01c+FWlMUrG
         VMAMO5V/XsqnEjfd4gfoDT7FqrQQU9iEiOVlcQ7iQkIuLOAklkrQAyE4dm4arHMjJXHc
         ptNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/CfNnOMJk6G65551bZckVmJ3kjJ/k4Yc+qvoAg65GHU=;
        b=rWnHl09JEFu2ZUGBehDWRZ5p5UW9zfY0o8HmeyhhXIuu4vAKjhgtSEvvJ72QAPho4T
         q724JQsBgOUf7b4CxDvqj03nTXX3ZoBf6JdnSUtlyQa8Uyg+EzcPdED/6CDJ1G3idQjV
         n610irLHnsxnh95FsvXZHeXKa3A6KnMmevij5Qf7GO/rCwss4BE4rt6K7vY3VT+7v6fY
         56eQlto9sINx7OgnTPfN/Youcb7BLkYidfFTkwT6udh2SD7g48RETQQ4ijFa+LP/GuCw
         PQLVcuYRs8C0GY66RDQ5Em0re3+OvJ8+58KJOxSdfX/1m5XC9JdPFjnYe2msspDAx5MC
         ODyQ==
X-Gm-Message-State: ACgBeo2xZSjyGsCI3u2iEypefd7DPESZF21saFNt5lOJicfpYUKyEXyS
        PYclF368eAE6pKwf9SFP3xXXi/f/PdEg51Ot
X-Google-Smtp-Source: AA6agR5WT/40tN+ZgWF8O3r0YRQFSvwdr0HcxJVpLFddbFnLr3FgL+4iWeI2l6ZXe1RaOMtfOyIiEw==
X-Received: by 2002:a17:902:bd41:b0:172:74c9:2a08 with SMTP id b1-20020a170902bd4100b0017274c92a08mr26498900plx.9.1661301773430;
        Tue, 23 Aug 2022 17:42:53 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:52 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 7/7] filemap: Remove find_get_pages_contig()
Date:   Tue, 23 Aug 2022 17:40:23 -0700
Message-Id: <20220824004023.77310-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
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

All callers of find_get_pages_contig() have been removed, so it is no
longer needed.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 60 -----------------------------------------
 2 files changed, 62 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 951936a2be1d..a04a645b64e9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -722,8 +722,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
-unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
-			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 8167bcc96e37..af5a4b5f866d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2269,66 +2269,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
-/**
- * find_get_pages_contig - gang contiguous pagecache lookup
- * @mapping:	The address_space to search
- * @index:	The starting page index
- * @nr_pages:	The maximum number of pages
- * @pages:	Where the resulting pages are placed
- *
- * find_get_pages_contig() works exactly like find_get_pages_range(),
- * except that the returned number of pages are guaranteed to be
- * contiguous.
- *
- * Return: the number of pages which were found.
- */
-unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
-			       unsigned int nr_pages, struct page **pages)
-{
-	XA_STATE(xas, &mapping->i_pages, index);
-	struct folio *folio;
-	unsigned int ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
-
-	rcu_read_lock();
-	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
-		if (xas_retry(&xas, folio))
-			continue;
-		/*
-		 * If the entry has been swapped out, we can stop looking.
-		 * No current caller is looking for DAX entries.
-		 */
-		if (xa_is_value(folio))
-			break;
-
-		if (!folio_try_get_rcu(folio))
-			goto retry;
-
-		if (unlikely(folio != xas_reload(&xas)))
-			goto put_page;
-
-again:
-		pages[ret] = folio_file_page(folio, xas.xa_index);
-		if (++ret == nr_pages)
-			break;
-		if (folio_more_pages(folio, xas.xa_index, ULONG_MAX)) {
-			xas.xa_index++;
-			folio_ref_inc(folio);
-			goto again;
-		}
-		continue;
-put_page:
-		folio_put(folio);
-retry:
-		xas_reset(&xas);
-	}
-	rcu_read_unlock();
-	return ret;
-}
-EXPORT_SYMBOL(find_get_pages_contig);
-
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
-- 
2.36.1

