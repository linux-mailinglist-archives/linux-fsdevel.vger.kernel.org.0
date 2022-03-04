Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B804CCC8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 05:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiCDE0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 23:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiCDE0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:26:44 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EE1405C2
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 20:25:55 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d84so5621886qke.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 20:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=Id7pgGOO69QmZf5bRtrRvNE114HKj31YJPHYLkWotfI=;
        b=Dc1GakVAq5QcDWMo9XcNXQhyxj1Lv7bV4IPMOboz54pcw3aO3cCUTl9n5x8tdDGSRj
         RILQi1WeKzyNaJ5kktQrMrJqSp3U8o9oVM7zTxtCUsrs6jQyjxlEYlr3aUo+YmAjIWOl
         iA3mWWLh2H9bOnouKiAReKFf22SS5+rsN+21qp9DAbfjbbiYLuSz7hl8iEAoEU6vYwwJ
         Riwj/JmoOyV6KUUKcUZuXrp9hdqwg4RkLrET8z1Av/z2jx+c/yrEUNtTJJ8x6+2kqMle
         XgLS/8zlGA4IgKcRq3te4B20sKEQjVuSiZ42SmteKS8CAWFbmLPZKqkb09CSrtEnOune
         lp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=Id7pgGOO69QmZf5bRtrRvNE114HKj31YJPHYLkWotfI=;
        b=kFzILJ9p5VBBKBK1wC1NTmu8i6YWQqPD6qQtyH8GFj45r3nOyJZjuifCtKK+0+uAiv
         F3y6BFVZnCyo13iwV/qxMTcJBW2cejuLz53LsEslG5ymARz0AzoFMy6T36aw7YMw+Bne
         SPFxzX0AOdMc5MLuNm3HizYs2+cKiWc3096piZnQIjAKrQ1Rs9iZ+4ZBRFHNmK28qVD4
         wqQBdy+Yqd+Ok/Y91b36pJfgkSyeKqQtD9aPWv2H2It8w3zh1WYi0Zy2M62RCFK7d3OO
         YSR/5FusW8N8jheV6aX5USDnioj9NQSnUdSbA3Vz32tPdP+uAXwL27QHBPTvxDLHeyGp
         gPRA==
X-Gm-Message-State: AOAM53006DgA9pFPALq7JELtlprsgw3GjqMT3dHky1CkAE/aNt47Qaeg
        fyKCDZmM5b2TyAPpKjA7TAkIpw==
X-Google-Smtp-Source: ABdhPJwWxulxlUIucVMWVbypFF9SWrVVSTvDuxJyPZr+pGZGBPM5dTO1DK0hFQM7uCbr/4r7p60MMg==
X-Received: by 2002:a37:3c6:0:b0:5e9:57ac:a5be with SMTP id 189-20020a3703c6000000b005e957aca5bemr1451609qkd.756.1646367954057;
        Thu, 03 Mar 2022 20:25:54 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm1957965qka.80.2022.03.03.20.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:25:52 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:25:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm: warn on deleting redirtied only if accounted
Message-ID: <b5a1106c-7226-a5c6-ad41-ad4832cae1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_unaccount_folio() has a WARN_ON_ONCE(folio_test_dirty(folio)).
It is good to warn of late dirtying on a persistent filesystem, but late
dirtying on tmpfs can only lose data which is expected to be thrown away;
and it's a pity if that warning comes ONCE on tmpfs, then hides others
which really matter.  Make it conditional on mapping_cap_writeback().

Cleanup: then folio_account_cleaned() no longer needs to check that
for itself, and so no longer needs to know the mapping.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/pagemap.h |  3 +--
 mm/filemap.c            | 14 +++++++++-----
 mm/page-writeback.c     | 18 ++++++++----------
 3 files changed, 18 insertions(+), 17 deletions(-)

--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -991,8 +991,7 @@ static inline void __set_page_dirty(struct page *page,
 {
 	__folio_mark_dirty(page_folio(page), mapping, warn);
 }
-void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
-			  struct bdi_writeback *wb);
+void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
 void __folio_cancel_dirty(struct folio *folio);
 static inline void folio_cancel_dirty(struct folio *folio)
 {
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -193,16 +193,20 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 	/*
 	 * At this point folio must be either written or cleaned by
 	 * truncate.  Dirty folio here signals a bug and loss of
-	 * unwritten data.
+	 * unwritten data - on ordinary filesystems.
 	 *
-	 * This fixes dirty accounting after removing the folio entirely
+	 * But it's harmless on in-memory filesystems like tmpfs; and can
+	 * occur when a driver which did get_user_pages() sets page dirty
+	 * before putting it, while the inode is being finally evicted.
+	 *
+	 * Below fixes dirty accounting after removing the folio entirely
 	 * but leaves the dirty flag set: it has no effect for truncated
 	 * folio and anyway will be cleared before returning folio to
 	 * buddy allocator.
 	 */
-	if (WARN_ON_ONCE(folio_test_dirty(folio)))
-		folio_account_cleaned(folio, mapping,
-					inode_to_wb(mapping->host));
+	if (WARN_ON_ONCE(folio_test_dirty(folio) &&
+			 mapping_can_writeback(mapping)))
+		folio_account_cleaned(folio, inode_to_wb(mapping->host));
 }
 
 /*
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2548,16 +2548,14 @@ static void folio_account_dirtied(struct folio *folio,
  *
  * Caller must hold lock_page_memcg().
  */
-void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
-			  struct bdi_writeback *wb)
+void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
-	if (mapping_can_writeback(mapping)) {
-		long nr = folio_nr_pages(folio);
-		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-		wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
-		task_io_account_cancelled_write(nr * PAGE_SIZE);
-	}
+	long nr = folio_nr_pages(folio);
+
+	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+	task_io_account_cancelled_write(nr * PAGE_SIZE);
 }
 
 /*
@@ -2768,7 +2766,7 @@ void __folio_cancel_dirty(struct folio *folio)
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (folio_test_clear_dirty(folio))
-			folio_account_cleaned(folio, mapping, wb);
+			folio_account_cleaned(folio, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
 		folio_memcg_unlock(folio);
