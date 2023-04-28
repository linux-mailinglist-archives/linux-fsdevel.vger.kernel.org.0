Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8826E6F1FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbjD1UzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjD1UzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:55:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0D1719
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 13:55:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so15404244b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682715318; x=1685307318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKH9cNLoRl7F0jBRyhbLlrHWLrcYg1/BWBgCd+GuWTY=;
        b=ce9F3+ulqAEqFwiYR/spGPVhrpwPFT1fWBM0liGcnadWqkv4icXpwr2gdbNiKWQ8rE
         HcqhSBIph7l3DtZaF/tFWpHZ/+MuocskRsD6H860hXG4OI8j6KPYCjbakr5agU/0+dBd
         rdxHgWSg5gYqhDB7e0psB12+n1j0kz1T5SSfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682715318; x=1685307318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKH9cNLoRl7F0jBRyhbLlrHWLrcYg1/BWBgCd+GuWTY=;
        b=YetEZYIvtnpgjHMteKwJEqmE8ie+AQ3UkKaU6sEMaqEUU7ikrpOtFo182dUNVnsNrr
         wrxdOfuDB9f6BZhSmR42D1R6SMBUDb0vMwBWujwITlBREmkkpECvm9fc1jw7MQzrrfh2
         aciEjgOmodiAWsGYikOQ/ICYFaT6tQVwjTIykkr2QUN3Z6Sz0xxvnc6Admihhx1f2JGW
         HAu6dTBEq6wzJ5zHFqW0ffcqgf7mRHNVU5oinnQPiYp0JHLgDWBQG5lj/uYhV4q9M1SB
         0OqUnYPPdTtFc3ESbf6UQbvcfsXgJamzANAiLHNksWM+Xi+NzrRciS1sdA6U+KJfU2yp
         7QUg==
X-Gm-Message-State: AC+VfDyU1lBQnQH9uUdYf8Zte7zLvA0OLjUFGQQ0hMBWW0G7KbA+gy0i
        Z/NQFhjxaRqIDPRjqwfzusVS5hjwnJwcygKGARc=
X-Google-Smtp-Source: ACHHUZ6De0YxbQH2D6OwuGFtK8lmn3ZJojdNUDvryKWf288AdhWSrN9Pts0NChi6SUTLfH3Cn69SfA==
X-Received: by 2002:a17:903:2341:b0:1a2:8924:2230 with SMTP id c1-20020a170903234100b001a289242230mr14459019plh.27.1682715318482;
        Fri, 28 Apr 2023 13:55:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2d50:d792:6783:38db])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13704122plb.70.2023.04.28.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:55:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3] migrate_pages: Avoid blocking for IO in MIGRATE_SYNC_LIGHT
Date:   Fri, 28 Apr 2023 13:54:38 -0700
Message-ID: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
finish quickly but not for things that will take a long time. Exactly
how long is too long is not well defined, but waits of tens of
milliseconds is likely non-ideal.

When putting a Chromebook under memory pressure (opening over 90 tabs
on a 4GB machine) it was fairly easy to see delays waiting for some
locks in the kcompactd code path of > 100 ms. While the laptop wasn't
amazingly usable in this state, it was still limping along and this
state isn't something artificial. Sometimes we simply end up with a
lot of memory pressure.

Putting the same Chromebook under memory pressure while it was running
Android apps (though not stressing them) showed a much worse result
(NOTE: this was on a older kernel but the codepaths here are similar).
Android apps on ChromeOS currently run from a 128K-block,
zlib-compressed, loopback-mounted squashfs disk. If we get a page
fault from something backed by the squashfs filesystem we could end up
holding a folio lock while reading enough from disk to decompress 128K
(and then decompressing it using the somewhat slow zlib algorithms).
That reading goes through the ext4 subsystem (because it's a loopback
mount) before eventually ending up in the block subsystem. This extra
jaunt adds extra overhead. Without much work I could see cases where
we ended up blocked on a folio lock for over a second. With more
extreme memory pressure I could see up to 25 seconds.

We considered adding a timeout in the case of MIGRATE_SYNC_LIGHT for
the two locks that were seen to be slow [1] and that generated much
discussion. After discussion, it was decided that we should avoid
waiting for the two locks during MIGRATE_SYNC_LIGHT if they were being
held for IO. We'll continue with the unbounded wait for the more full
SYNC modes.

With this change, I couldn't see any slow waits on these locks with my
previous testcases.

NOTE: The reason I stated digging into this originally isn't because
some benchmark had gone awry, but because we've received in-the-field
crash reports where we have a hung task waiting on the page lock
(which is the equivalent code path on old kernels). While the root
cause of those crashes is likely unrelated and won't be fixed by this
patch, analyzing those crash reports did point out these very long
waits seemed like something good to fix. With this patch we should no
longer hang waiting on these locks, but presumably the system will
still be in a bad shape and hang somewhere else.

[1] https://lore.kernel.org/r/20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Most of the actual code in this patch came from emails written by
Matthew Wilcox and I just cleaned the code up to get it to compile.
I'm happy to set authorship to him if he would like, but for now I've
credited him with Suggested-by.

This patch has changed pretty significantly between versions, so
adding a link to previous versions to help anyone needing to find the
history:
v1 - https://lore.kernel.org/r/20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid
v2 - https://lore.kernel.org/r/20230421221249.1616168-1-dianders@chromium.org/

Changes in v3:
- Combine patches for buffers and folios.
- Use buffer_uptodate() and folio_test_uptodate() instead of timeout.

Changes in v2:
- Keep unbounded delay in "SYNC", delay with a timeout in "SYNC_LIGHT".
- Also add a timeout for locking of buffers.

 mm/migrate.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..4a384eb32917 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -698,37 +698,32 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 							enum migrate_mode mode)
 {
 	struct buffer_head *bh = head;
+	struct buffer_head *failed_bh;
 
-	/* Simple case, sync compaction */
-	if (mode != MIGRATE_ASYNC) {
-		do {
-			lock_buffer(bh);
-			bh = bh->b_this_page;
-
-		} while (bh != head);
-
-		return true;
-	}
-
-	/* async case, we cannot block on lock_buffer so use trylock_buffer */
 	do {
 		if (!trylock_buffer(bh)) {
-			/*
-			 * We failed to lock the buffer and cannot stall in
-			 * async migration. Release the taken locks
-			 */
-			struct buffer_head *failed_bh = bh;
-			bh = head;
-			while (bh != failed_bh) {
-				unlock_buffer(bh);
-				bh = bh->b_this_page;
-			}
-			return false;
+			if (mode == MIGRATE_ASYNC)
+				goto unlock;
+			if (mode == MIGRATE_SYNC_LIGHT && !buffer_uptodate(bh))
+				goto unlock;
+			lock_buffer(bh);
 		}
 
 		bh = bh->b_this_page;
 	} while (bh != head);
+
 	return true;
+
+unlock:
+	/* We failed to lock the buffer and cannot stall. */
+	failed_bh = bh;
+	bh = head;
+	while (bh != failed_bh) {
+		unlock_buffer(bh);
+		bh = bh->b_this_page;
+	}
+
+	return false;
 }
 
 static int __buffer_migrate_folio(struct address_space *mapping,
@@ -1162,6 +1157,14 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		if (current->flags & PF_MEMALLOC)
 			goto out;
 
+		/*
+		 * In "light" mode, we can wait for transient locks (eg
+		 * inserting a page into the page table), but it's not
+		 * worth waiting for I/O.
+		 */
+		if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(src))
+			goto out;
+
 		folio_lock(src);
 	}
 	locked = true;
-- 
2.40.1.495.gc816e09b53d-goog

