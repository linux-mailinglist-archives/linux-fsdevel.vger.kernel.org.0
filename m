Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C183A711E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhFNVWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 17:22:12 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:33516 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhFNVWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:22:12 -0400
Received: by mail-qk1-f175.google.com with SMTP id c9so13608645qkm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPrRC5GgzYjCmG/sOcyalcGlRFIg9CpzRtffxeyBsJs=;
        b=Cq8Kh47l8CTW8cX2gegKOmPYyRubXDBLX8Wra8IzL6m6emUBcjZl3GKYuVRjuPm0v9
         c8de88BP5fIqRjTKx231bOte4GqGnXQa5hRxJAXZ+iTiOAm2AKnIdPPGwFBl7rm+BupS
         rtTtKLbNKohQeqdYJVJSHO92kBetmnTG+rxFCT9JPqkF3aeC6dM+TflTPVIG9wTwdhjt
         aprvCNb3nTKFMGz12ZOCSNZuyeBhL6XL5r4uMlViOup2ZnYSFgNBSarroZlxVKO+JybG
         syK0UQnL89xa3dQyaH9afsouyOR1DSfr+T31Aw3k56HwDy//BIeRhq00BKxnJLzo1dvn
         xHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPrRC5GgzYjCmG/sOcyalcGlRFIg9CpzRtffxeyBsJs=;
        b=oV0uEueZVGF/olrJJWuHEA0rqTktebKljCt7+ecLV1HYKWQ5e9pgKNHRT3XSVAbr0m
         p0DaPFe3DKYM1AaAltoKgWbQMofEyog/loVCWEhWs0byxl9hcEKwH8PK4AAed5HwqszL
         Ch3JxvkTeMyPgjf8lkn3vD2QyXW55I1FSFw430WniXqV9uqy1NW0S3zirPeN9zp2S/vb
         blRLwEOyjGOr/uj5Kyw5nRx8gVmiPUyQzujo4gOOQhBm5F4Nvj3TRvs/CLZ5HAhMY0iM
         tgKXv+gUnD54cNPn0tII13OqN/LrCV6SE+GlslU106IUeyufdbwAvGfTFQ2SU1Z/2iny
         BCHA==
X-Gm-Message-State: AOAM531RFBHJBV7oPCkSBEI8KWODlhQqyS9/LhqhR5zwBovawx6s+wkY
        NTiSFcMeCQjpf2Wox3ysI7/t5w==
X-Google-Smtp-Source: ABdhPJzhFoyCqJfWV/336OnsiH+zuoKpzlTCfmft41UKsBXIgezPkNBEAf1ehK2PH+sWsE9isbmljQ==
X-Received: by 2002:a37:5943:: with SMTP id n64mr18642452qkb.122.1623705548426;
        Mon, 14 Jun 2021 14:19:08 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 4sm10968318qkv.134.2021.06.14.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:19:07 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] fs: inode: count invalidated shadow pages in pginodesteal
Date:   Mon, 14 Jun 2021 17:19:03 -0400
Message-Id: <20210614211904.14420-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614211904.14420-1-hannes@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pginodesteal is supposed to capture the impact that inode reclaim has
on the page cache state. Currently, it doesn't consider shadow pages
that get dropped this way, even though this can have a significant
impact on paging behavior, memory pressure calculations etc.

To improve visibility into these effects, make sure shadow pages get
counted when they get dropped through inode reclaim.

This changes the return value semantics of invalidate_mapping_pages()
semantics slightly, but the only two users are the inode shrinker
itsel and a usb driver that logs it for debugging purposes.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/inode.c    |  2 +-
 mm/truncate.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..8830a727b0af 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -768,7 +768,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_ROTATE;
 	}
 
-	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
+	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
diff --git a/mm/truncate.c b/mm/truncate.c
index b92b86222625..95934c98259a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,8 +486,9 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 			index = indices[i];
 
 			if (xa_is_value(page)) {
-				invalidate_exceptional_entry(mapping, index,
-							     page);
+				count += invalidate_exceptional_entry(mapping,
+								      index,
+								      page);
 				continue;
 			}
 			index += thp_nr_pages(page) - 1;
@@ -515,19 +516,18 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 }
 
 /**
- * invalidate_mapping_pages - Invalidate all the unlocked pages of one inode
- * @mapping: the address_space which holds the pages to invalidate
+ * invalidate_mapping_pages - Invalidate all clean, unlocked cache of one inode
+ * @mapping: the address_space which holds the cache to invalidate
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
  *
- * This function only removes the unlocked pages, if you want to
- * remove all the pages of one inode, you must call truncate_inode_pages.
+ * This function removes pages that are clean, unmapped and unlocked,
+ * as well as shadow entries. It will not block on IO activity.
  *
- * invalidate_mapping_pages() will not block on IO activity. It will not
- * invalidate pages which are dirty, locked, under writeback or mapped into
- * pagetables.
+ * If you want to remove all the pages of one inode, regardless of
+ * their use and writeback state, use truncate_inode_pages().
  *
- * Return: the number of the pages that were invalidated
+ * Return: the number of the cache entries that were invalidated
  */
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t end)
-- 
2.32.0

