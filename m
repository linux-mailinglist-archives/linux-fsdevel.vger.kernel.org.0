Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158FD61511D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKARyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKARx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51711CB04;
        Tue,  1 Nov 2022 10:53:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y203so3133pfb.4;
        Tue, 01 Nov 2022 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2J1+cr5yCkfhmlJuiea40UIW73C1SmYJz1XZ9F//oM=;
        b=a5nRUpRVccWsflu1tgAUVeXJZySVFCbti/up2zo4roQ9JkbZo/hfTJHelHBSHo5tLe
         tC1jaZjXp19/j7nU6I5PBFMdByE64i0asxNb/6rZb7HZt/BnmzkoLFNQr8xE+O4yNXaf
         cqrVi+oPQcK7NGLdteVHwS5XkTUUjXZ1UQiZE7t+qpHQdWqOSRb0WHS44woZVsj2Geoa
         Wa5ftzIuMBmVy8Dkdq3XIyYWOE/DlLtDUjaGU5oe7O8ZVy0BnuY36U/yEmFBBv2+hVFL
         dY5LBROUWb2htulwX6mqLJBYBf75f2WrHHjFLuu5Yb3twbmP/UR84r4LGdZDdoqGKA5f
         T83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2J1+cr5yCkfhmlJuiea40UIW73C1SmYJz1XZ9F//oM=;
        b=tQ/e9qAor0W5EYYEvn+3FGy9IrTyhEUQB/Tv2lB+Z74xBJsDagGQ6FMWzdMl6Kkpig
         IRvb6QBIHfFIpELeIgiaCMEmvW6jCrK05GCN/ICda+IYVWmSJQ3lb+kNYm5ut/usSIqr
         hqRD+iCCFKA4yDrXLPYuRUUJE2BcZAyiGCEd2KVy4EeuVMzKcIU7FC5AOeIVUpQazUyx
         q0ey/kbV4nPosu98trUTvZI+b7W8rzi+XPG6vDhs5AYQ1VCbq4AIq8K6wHSuSPxr4Ntr
         JdkikeWn2m+zN0N4QFi+JZpOckup6qCiO1ajG3XRESbfx7VH32ocaAQ5R9S+f01fOXiN
         lUmg==
X-Gm-Message-State: ACrzQf31u7/VtrPLgy66ZOJ7FaOckRAqdPo6Kbdn6J3F12gvviqBUTwf
        K05imVopJmYYeFf78ypMy0MloIkFxebB3g==
X-Google-Smtp-Source: AMsMyM51zCtXYMyAw9bd3/mTakXsP6meG/nQMZjuLadCOHRAo9SG1oiCI9WwArgVlu9PEj5R5eiZHg==
X-Received: by 2002:a05:6a00:891:b0:565:85a7:a6e with SMTP id q17-20020a056a00089100b0056585a70a6emr3854588pfj.21.1667325238285;
        Tue, 01 Nov 2022 10:53:58 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:57 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/5] folio-compat: Remove lru_cache_add()
Date:   Tue,  1 Nov 2022 10:53:26 -0700
Message-Id: <20221101175326.13265-6-vishal.moola@gmail.com>
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

There are no longer any callers of lru_cache_add(), so remove it. This
saves 107 bytes of kernel text. Also cleanup some comments such that
they reference the new folio_add_lru() instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/swap.h | 1 -
 mm/folio-compat.c    | 6 ------
 mm/truncate.c        | 2 +-
 mm/workingset.c      | 2 +-
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..c92ccff9b962 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -388,7 +388,6 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages);
 void lru_note_cost_folio(struct folio *);
 void folio_add_lru(struct folio *);
 void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
-void lru_cache_add(struct page *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e1e23b4947d7..efd65b7f48bb 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -82,12 +82,6 @@ bool redirty_page_for_writepage(struct writeback_control *wbc,
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
 
-void lru_cache_add(struct page *page)
-{
-	folio_add_lru(page_folio(page));
-}
-EXPORT_SYMBOL(lru_cache_add);
-
 void lru_cache_add_inactive_or_unevictable(struct page *page,
 		struct vm_area_struct *vma)
 {
diff --git a/mm/truncate.c b/mm/truncate.c
index c0be77e5c008..184fa17fce60 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -573,7 +573,7 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave pages behind because
  * shrink_page_list() has a temp ref on them, or because they're transiently
- * sitting in the lru_cache_add() pagevecs.
+ * sitting in the folio_add_lru() pagevecs.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
 					struct folio *folio)
diff --git a/mm/workingset.c b/mm/workingset.c
index ae7e984b23c6..25844171b72d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -492,7 +492,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	/* Folio was active prior to eviction */
 	if (workingset) {
 		folio_set_workingset(folio);
-		/* XXX: Move to lru_cache_add() when it supports new vs putback */
+		/* XXX: Move to folio_add_lru() when it supports new vs putback */
 		lru_note_cost_folio(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
-- 
2.38.1

