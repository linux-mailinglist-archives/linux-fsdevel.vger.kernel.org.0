Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955665B60D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiILS3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiILS2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999845989;
        Mon, 12 Sep 2022 11:26:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c198so9411747pfc.13;
        Mon, 12 Sep 2022 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HQUrfRdnfiMPUlTfezXhcqX7GV4m5M0rlOnnNapCheA=;
        b=EWGIRsO0TQUjPA4NSpZhNtSF7U+oKW/75ivrprFYH3eLHknbNiJPBdeCKksthsDvHT
         p9VH4PtpUnMCZMAwx7DROHJWr7/Ah4rYynxtW5b0gtNTnCM4g+ZV4bimi/kEwOfXUOXL
         EXIuMFeQwxRjR7MDPmqZQPy8kFIte1xrKjKO9fkYlSO5ZAjVS/9lTh3/HcYUBxYfnCnS
         jffCNppR34pmyz4LTtsc95g9B1bfbwyW8e6tLM0fHOhkZ1IGhLZWN6p2Wmpdp9pivf+d
         BucUVnUqP/QnQXL7spYnWTmGi4J2gdTskcKPVzFxg/cASCQyhX2H2dZKyy9J1njNgD5p
         iMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HQUrfRdnfiMPUlTfezXhcqX7GV4m5M0rlOnnNapCheA=;
        b=7FB0d0I/9wPr1d2RlK5CXtblZ9hySuIvP0tB4s8xvQ0c6kzjrIb9vGMJp/Zxge+USY
         BDKk2oIp4cdB/1+DvypbNceYhQ6JgzLq5S7aGUpDzc2rCHfKQ5IRZxYt9z49HpB5xOBe
         YYIS3+EqAxEtE2LCwr1luXsXBYKMeDcLwYfu0ED6I/3uTgEDX4GL9YJDpsRPGFdWRrG+
         tuBczo9PlsUIN3ksIxmdynAgPd3OxRH5wV3271SsnTjfvTaA7sgZLMsysan86gS/a8MP
         +F5J4HePEbiQFguAl0QxJPQOsamzwzayigj5t1PQrW7bbekoaZRwSOiwxoUxEcOcx3f8
         3HPA==
X-Gm-Message-State: ACgBeo2QxP99UiTEYHGVmApJYR6z56Tvq3KJhVrNRMt0CAXmYum3x2os
        dcr987CP2ZPpOW92D5PMl+7udy0PBMr6Tw==
X-Google-Smtp-Source: AA6agR5zoGRPcJJ1BMErXHewDDt0vJdvoM167lmthDP3+E0KxFpRx9Na4XeqBQAsnEhH1ytuVdZJxQ==
X-Received: by 2002:a63:5d4e:0:b0:41d:2966:74e7 with SMTP id o14-20020a635d4e000000b0041d296674e7mr24037987pgm.526.1663007160214;
        Mon, 12 Sep 2022 11:26:00 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:59 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 23/23] filemap: Remove find_get_pages_range_tag()
Date:   Mon, 12 Sep 2022 11:22:24 -0700
Message-Id: <20220912182224.514561-24-vishal.moola@gmail.com>
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

All callers to find_get_pages_range_tag(), find_get_pages_tag(),
pagevec_lookup_range_tag(), and pagevec_lookup_tag() have been removed.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 10 -------
 include/linux/pagevec.h |  8 ------
 mm/filemap.c            | 60 -----------------------------------------
 mm/swap.c               | 10 -------
 4 files changed, 88 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 85cc96c82c2c..b8ea33751a66 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -742,16 +742,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
-unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages);
-static inline unsigned find_get_pages_tag(struct address_space *mapping,
-			pgoff_t *index, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages)
-{
-	return find_get_pages_range_tag(mapping, index, (pgoff_t)-1, tag,
-					nr_pages, pages);
-}
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			pgoff_t index);
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..a520632297ac 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,14 +26,6 @@ struct pagevec {
 };
 
 void __pagevec_release(struct pagevec *pvec);
-unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag);
-static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, xa_mark_t tag)
-{
-	return pagevec_lookup_range_tag(pvec, mapping, index, (pgoff_t)-1, tag);
-}
 
 static inline void pagevec_init(struct pagevec *pvec)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 435fc53b3f2f..b986f246a6ae 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2309,66 +2309,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 
-/**
- * find_get_pages_range_tag - Find and return head pages matching @tag.
- * @mapping:	the address_space to search
- * @index:	the starting page index
- * @end:	The final page index (inclusive)
- * @tag:	the tag index
- * @nr_pages:	the maximum number of pages
- * @pages:	where the resulting pages are placed
- *
- * Like find_get_pages_range(), except we only return head pages which are
- * tagged with @tag.  @index is updated to the index immediately after the
- * last page we return, ready for the next iteration.
- *
- * Return: the number of pages which were found.
- */
-unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
-			struct page **pages)
-{
-	XA_STATE(xas, &mapping->i_pages, *index);
-	struct folio *folio;
-	unsigned ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
-
-	rcu_read_lock();
-	while ((folio = find_get_entry(&xas, end, tag))) {
-		/*
-		 * Shadow entries should never be tagged, but this iteration
-		 * is lockless so there is a window for page reclaim to evict
-		 * a page we saw tagged.  Skip over it.
-		 */
-		if (xa_is_value(folio))
-			continue;
-
-		pages[ret] = &folio->page;
-		if (++ret == nr_pages) {
-			*index = folio->index + folio_nr_pages(folio);
-			goto out;
-		}
-	}
-
-	/*
-	 * We come here when we got to @end. We take care to not overflow the
-	 * index @index as it confuses some of the callers. This breaks the
-	 * iteration when there is a page at index -1 but that is already
-	 * broken anyway.
-	 */
-	if (end == (pgoff_t)-1)
-		*index = (pgoff_t)-1;
-	else
-		*index = end + 1;
-out:
-	rcu_read_unlock();
-
-	return ret;
-}
-EXPORT_SYMBOL(find_get_pages_range_tag);
-
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fail
  * a _large_ part of the i/o request. Imagine the worst scenario:
diff --git a/mm/swap.c b/mm/swap.c
index 9cee7f6a3809..7b8c1c8024a1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1055,16 +1055,6 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
-unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag)
-{
-	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
-					PAGEVEC_SIZE, pvec->pages);
-	return pagevec_count(pvec);
-}
-EXPORT_SYMBOL(pagevec_lookup_range_tag);
-
 /*
  * Perform any setup for the swap system
  */
-- 
2.36.1

