Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936E6EB47F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjDUWNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjDUWNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:13:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8602D5F
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso2285426b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682115210; x=1684707210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc5jbER8wEc7OW3/IotC+kA2A3o7OZfeQaN33ZlBlP4=;
        b=Bj7hb2g1Ygk+uI1Xxfx+Lf8COV76humjsOT5sJKw8qFdCUzNXODMPPSgSmVEXfumLP
         gUzdVnED6ugNaAcG2SKbDhlEqm5/AA1x3lyiaYtvzKe1z+7yY9FeeWZjZ4j8ZGNYMvpT
         nSEalWU0KsSv7vdtph2qjlryw/U/r62x/nUxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115210; x=1684707210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc5jbER8wEc7OW3/IotC+kA2A3o7OZfeQaN33ZlBlP4=;
        b=ZU8ByIIIQajQt2X6q74RFlkCmizK8ITnStpf/u4Pa8GTylBz1lqvRNsf5/NL5Q0FLS
         MJ1QjCiN3zbK3bGYhjEtJbFStcm1ahnfmnHy3++p/m+MypEjYxGkiuP+TMXjoM7zyK38
         bntaW8oDJEC2gwyQoQ8s1a/Pp/0oAXt3SO/lVcFysr0ufEaevnyJdtfEEZ9ZL/CrdQJQ
         g7QlgDXqBWb5u6UodRUz3sMdQxxZo0+6xQ+jeJEHKWi8JE6Q1w4s/SIj/TgRN4Gsy/YC
         VzR/ZS6BLdnFBBe6StcJu9Ip6HEMtnI7GcHXhyp9KMUpqJ8oAR26lK2MiwGhRE1fXqdQ
         f7xQ==
X-Gm-Message-State: AAQBX9dkO3ZRXfsgV6aPPK++mLZdHcdHS1ciWijKHWiyVskkwgiTWfx1
        4RfKfOdNS1Rposn1Y6eBC6Gz1g==
X-Google-Smtp-Source: AKy350aBr9TvmZeKHCBJSqIpG2B/nWcBgQOHXkcvQWceE4r02qrPTXFu3nXc3bs+0O5+8kUMfAUyog==
X-Received: by 2002:a05:6a00:1a56:b0:63d:3789:733f with SMTP id h22-20020a056a001a5600b0063d3789733fmr8752575pfv.15.1682115209980;
        Fri, 21 Apr 2023 15:13:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:87cc:9018:e569:4a27])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm3424715pfb.104.2023.04.21.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:13:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 4/4] migrate_pages: Don't wait forever locking buffers in MIGRATE_SYNC_LIGHT
Date:   Fri, 21 Apr 2023 15:12:48 -0700
Message-ID: <20230421151135.v2.4.Ic39f0b16516acf4af1ce5d923150f93ee85a9398@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421221249.1616168-1-dianders@chromium.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just as talked about in the patch ("migrate_pages: Don't wait forever
locking pages in MIGRATE_SYNC_LIGHT"), we don't really want unbounded
waits when we're running in MIGRATE_SYNC_LIGHT mode. Waiting on the
buffer lock is a second such unbounded wait. Let's put a timeout on
it.

While measurement didn't show this wait to be quite as bad as the one
waiting for the folio lock, it could still be measured to be over a
second in some cases.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- "Don't wait forever locking buffers in MIGRATE_SYNC_LIGHT" new for v2.

 mm/migrate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 60982df71a93..97c93604eb4c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -715,25 +715,16 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 							enum migrate_mode mode)
 {
 	struct buffer_head *bh = head;
+	bool locked;
 
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
-		if (!trylock_buffer(bh)) {
-			/*
-			 * We failed to lock the buffer and cannot stall in
-			 * async migration. Release the taken locks
-			 */
+		if (mode == MIGRATE_ASYNC)
+			locked = trylock_buffer(bh);
+		else
+			locked = !lock_buffer_timeout(bh, timeout_for_mode(mode));
+
+		if (!locked) {
+			/* We failed to lock the buffer. Release the taken locks. */
 			struct buffer_head *failed_bh = bh;
 			bh = head;
 			while (bh != failed_bh) {
-- 
2.40.0.634.g4ca3ef3211-goog

