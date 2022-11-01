Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09C61511C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKARx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKARxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156EA1CB00;
        Tue,  1 Nov 2022 10:53:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y4so14278201plb.2;
        Tue, 01 Nov 2022 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuGJz+KOe5nlhTqBhnCFZVh76KOjwWx4QzuxWRatQRw=;
        b=GLtbpdDagXfzzArPWFbzC1pLfwjGTFMl3yMdbdI+UPQWP6Safe9ZomEqovW5g78jsn
         u1gUxCUdpMfjPpRavHZw7PboDNLvOt2PJamvnpqII7rcm63F4RGcv2RcUj96F24eSfUd
         hxpSBMmmWfCzqKgvA7FhwffpTioO28REYvlpGitRbXdbz3iC3bTUAOjICPQXmDpUQGHC
         8XdjD6Q+zhl4iIWf96kJzS6ftU+ra0QIcIxEHG6pPH8gzHev8fLbDEvqhW+2lpB5ruE/
         /L7S0GqoVyp8Jl2KJeWLQEorqRqPJXZXVhX/NX1WBf+Q2G1KhhQ7tx14rlJXnQrmV5hP
         JIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuGJz+KOe5nlhTqBhnCFZVh76KOjwWx4QzuxWRatQRw=;
        b=RYRy6/TkwXdVlYnFxchu0aspS7eQ+EbvRqw2HmS0akm5Eptt9FRkqSlysPGXv1dCs+
         gSihFHpo0Is00xl2Yk5N3r+6PWCeS5jJKhxzqnqMoaSJzQueDnlIGCeGescrTnB/EcIw
         vonswIAen8eFcOjuYCw2NJkGiCIllZ3flKX6J99/02MYTkWwHM/x6IcheHz9TcVdJLFA
         sOkMet4hWO8Kg7qgxtdmrkCW6vZWPLNeATyzAZHWCxfTe2+cxxZ2a4cua0H8cXJ6h1iW
         eRbAA5HEQS1+ba78k2YF0YaEGaZ5He3+LaJ+6x+w2iBKTVIwikyCzelDbSU5mL++7psk
         wtrA==
X-Gm-Message-State: ACrzQf2z1WoHqJQtgWK+/UXLchZLIZJXSU9OrsMP3G/GMaxLDMoD//xW
        PB7ck4p7aowx2Dvjg528PP4=
X-Google-Smtp-Source: AMsMyM4Lo9FQUAx4PCChA3A3lYDxPoKT3ikIU8naaS8JY51piB8RrefMXEBKCh8ZFG34NdjISTQlXQ==
X-Received: by 2002:a17:902:cf02:b0:187:846:e007 with SMTP id i2-20020a170902cf0200b001870846e007mr18228062plg.70.1667325233484;
        Tue, 01 Nov 2022 10:53:53 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:53 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/5] filemap: Convert replace_page_cache_page() to replace_page_cache_folio()
Date:   Tue,  1 Nov 2022 10:53:22 -0700
Message-Id: <20221101175326.13265-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101175326.13265-1-vishal.moola@gmail.com>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eliminates 7 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/fuse/dev.c           |  2 +-
 include/linux/pagemap.h |  2 +-
 mm/filemap.c            | 52 ++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b4a6e0a1b945..26817a2db463 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -837,7 +837,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
-	replace_page_cache_page(oldpage, newpage);
+	replace_page_cache_folio(page_folio(oldpage), page_folio(newpage));
 
 	get_page(newpage);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb4044222..275810697d71 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1104,7 +1104,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 void filemap_remove_folio(struct folio *folio);
 void delete_from_page_cache(struct page *page);
 void __filemap_remove_folio(struct folio *folio, void *shadow);
-void replace_page_cache_page(struct page *old, struct page *new);
+void replace_page_cache_folio(struct folio *old, struct folio *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
 int try_to_release_page(struct page *page, gfp_t gfp);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..c61dfaa81fee 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -785,56 +785,54 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
 EXPORT_SYMBOL(file_write_and_wait_range);
 
 /**
- * replace_page_cache_page - replace a pagecache page with a new one
- * @old:	page to be replaced
- * @new:	page to replace with
- *
- * This function replaces a page in the pagecache with a new one.  On
- * success it acquires the pagecache reference for the new page and
- * drops it for the old page.  Both the old and new pages must be
- * locked.  This function does not add the new page to the LRU, the
+ * replace_page_cache_folio - replace a pagecache folio with a new one
+ * @old:	folio to be replaced
+ * @new:	folio to replace with
+ *
+ * This function replaces a folio in the pagecache with a new one.  On
+ * success it acquires the pagecache reference for the new folio and
+ * drops it for the old folio.  Both the old and new folios must be
+ * locked.  This function does not add the new folio to the LRU, the
  * caller must do that.
  *
  * The remove + add is atomic.  This function cannot fail.
  */
-void replace_page_cache_page(struct page *old, struct page *new)
+void replace_page_cache_folio(struct folio *old, struct folio *new)
 {
-	struct folio *fold = page_folio(old);
-	struct folio *fnew = page_folio(new);
 	struct address_space *mapping = old->mapping;
 	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 
-	VM_BUG_ON_PAGE(!PageLocked(old), old);
-	VM_BUG_ON_PAGE(!PageLocked(new), new);
-	VM_BUG_ON_PAGE(new->mapping, new);
+	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
+	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
+	VM_BUG_ON_FOLIO(new->mapping, new);
 
-	get_page(new);
+	folio_get(new);
 	new->mapping = mapping;
 	new->index = offset;
 
-	mem_cgroup_migrate(fold, fnew);
+	mem_cgroup_migrate(old, new);
 
 	xas_lock_irq(&xas);
 	xas_store(&xas, new);
 
 	old->mapping = NULL;
 	/* hugetlb pages do not participate in page cache accounting. */
-	if (!PageHuge(old))
-		__dec_lruvec_page_state(old, NR_FILE_PAGES);
-	if (!PageHuge(new))
-		__inc_lruvec_page_state(new, NR_FILE_PAGES);
-	if (PageSwapBacked(old))
-		__dec_lruvec_page_state(old, NR_SHMEM);
-	if (PageSwapBacked(new))
-		__inc_lruvec_page_state(new, NR_SHMEM);
+	if (!folio_test_hugetlb(old))
+		__lruvec_stat_sub_folio(old, NR_FILE_PAGES);
+	if (!folio_test_hugetlb(new))
+		__lruvec_stat_add_folio(new, NR_FILE_PAGES);
+	if (folio_test_swapbacked(old))
+		__lruvec_stat_sub_folio(old, NR_SHMEM);
+	if (folio_test_swapbacked(new))
+		__lruvec_stat_add_folio(new, NR_SHMEM);
 	xas_unlock_irq(&xas);
 	if (free_folio)
-		free_folio(fold);
-	folio_put(fold);
+		free_folio(old);
+	folio_put(old);
 }
-EXPORT_SYMBOL_GPL(replace_page_cache_page);
+EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
-- 
2.38.1

