Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8C5AA255
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiIAWHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiIAWGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:06:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF09F0EC;
        Thu,  1 Sep 2022 15:03:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so274130pjb.2;
        Thu, 01 Sep 2022 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6jEJW/hdf8NlYILH28nH262i/WrC/eObbm9U3wHW7N0=;
        b=N9gi0ek73D6+Ob4gJQTCenTIizkASUjD+NGWnY0SxFC164jHY2z+KDjngS5u8a5ea1
         pTnBRJWlclL9jxrutcaq59svND4AAi3Mu6zjZ5R0ZdTzg7WkwILrexZuQIgRHx4yncJe
         OCQ0GP35CE39948Jkx+DdsWr/hVemLW0aPd8pHpB8mjZW2hr0avHI7FZaniFXz2bEU5c
         8rj/3cGG0sHkP+Xg1vHbPyhxWGLC3ZGSwUXEq4Bo3qDVM63ON1NgwYw3KkUKbds8fRoP
         Z5oZrMmJFM7HBd6JNC8OlP+eYzpgfFP4AsKvNF+23CtWe3kx/Wqjrlwut0YprghhKCzN
         8ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6jEJW/hdf8NlYILH28nH262i/WrC/eObbm9U3wHW7N0=;
        b=Yw+B58Bx3KjaDVUIp22F0b09mWlJ9vVWqOWidEERczs4qMmRG7eaxhL4k+ABI+XzxL
         PWv77w5/oZzZWQqOEAtUoyJksGr8A4LDtf+PRKLl7s8516OBWp6Z+HVwlhmrsig/EJ42
         ETtwimDbhO0GTVcFRYDto7FiBldLT+6ZGr+XLXuMYm8pLq7Eb+mwOnWBdwb0gM65dDIU
         sch+ZROfR1WW7SgGE2u26vds8cbtztCBtpvtNdTqgMElpGju6HUUNG38ACEmbyQz7sgy
         a+gI6BWnZhBOxq/GocPfHGbtPXrDKji6czshDBJ46SN0wx5LH6qka6BDQ022RpNf44AD
         HYXA==
X-Gm-Message-State: ACgBeo0fQVNFDsFRjAZHPLkWozmScDx4/KL8q1OkjiyyoykpB1e9zOgQ
        A8vPendCOaU04nXlJRi/GcfZwqh8VZ4hgg==
X-Google-Smtp-Source: AA6agR6ueb+SpLMpe0ENf809+aslBhtpdEEwbT3aRvZt/q/0zk6S/BuXNiziVl4cLeo0K8hj5HTpaw==
X-Received: by 2002:a17:903:40d2:b0:174:e086:c748 with SMTP id t18-20020a17090340d200b00174e086c748mr19496625pld.108.1662069786179;
        Thu, 01 Sep 2022 15:03:06 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:03:05 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:37 -0700
Message-Id: <20220901220138.182896-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/nilfs2/page.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5c96084e829f..b66f4e988016 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -358,22 +358,22 @@ void nilfs_copy_back_pages(struct address_space *dmap,
  */
 void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+	while (filemap_get_folios_tag(mapping, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
-			unlock_page(page);
+			folio_lock(folio);
+			nilfs_clear_dirty_page(&folio->page, silent);
+			folio_unlock(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

