Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3B7A3606
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjIQPFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjIQPFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A8185;
        Sun, 17 Sep 2023 08:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43D2BC433C7;
        Sun, 17 Sep 2023 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694963106;
        bh=j1JVve+qJ7sTdtq49F/gZGwOv9df2c74smS23KOG1Fk=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=flCT/y/ba3CsA49saOAKIKSSwz2nt5NzlpYejycBqN0DIhgksLY0yMm81Tiefcj4p
         F5YdR0AfBMlE4VbrOhr5P3GDQU3ICuuw6lA0zi6KwnXpmWMFdi3A+AlnWGCywG19ai
         NrdixOKwvsz4TZHRDPlTW5H+WjiNrXBuqkBcgPiWdJ4fG8UL1gCGeE+Exr05nHMunY
         uQhFYQWwLvGldcfn7Oe7P4nACqYn5w3i3F1TOViXeCMOF3MZC85onffv5Bxeelhd36
         m7go+oOgS/SUPII7K9vAoU7mL6DX9R800D4TWLBSmsi9MK0rRo2JJCzaSvheadGqFt
         Ypp9FVtAtAf8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 2A106CD13CF;
        Sun, 17 Sep 2023 15:05:06 +0000 (UTC)
From:   Jianguo Bau via B4 Relay <devnull+roidinev.gmail.com@kernel.org>
Date:   Sun, 17 Sep 2023 23:04:01 +0800
Subject: [PATCH] mm/writeback: Update filemap_dirty_folio() comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230917-trycontrib1-v1-1-db22630b8839@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGAVB2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Nz3ZKiyuT8vJKizCRD3eQki7Q0CxMDc0uTZCWgjoKi1LTMCrBp0bG
 1tQBsnUXdXQAAAA==
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jianguo Bau <roidinev@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694963054; l=1010;
 i=roidinev@gmail.com; s=20230906; h=from:subject:message-id;
 bh=e7I1qPIXQ/mVKNWlcvVD0erRN97KbQ0kdRdeC2hZk4g=;
 b=trGc0zHM0wysIWlSONy9j7FLdZmOah1N9MQVJhlsORkyZ2GnQ+Mgw6Lap9SZve9f8nwMvXPJP
 P5bgnzAkVtXD7zJ5iOftev7XsBu/uEPEdtsdQjHwlVLI1U6JyeYe8uR
X-Developer-Key: i=roidinev@gmail.com; a=ed25519;
 pk=Itb2tVLere2RkCXs1smCQpxuXvWY0XesWo353ZMHfxs=
X-Endpoint-Received: by B4 Relay for roidinev@gmail.com/20230906 with auth_id=82
X-Original-From: Jianguo Bau <roidinev@gmail.com>
Reply-To: <roidinev@gmail.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jianguo Bau <roidinev@gmail.com>

Change to use new address space operation dirty_folio

Signed-off-by: Jianguo Bau <roidinev@gmail.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a50..001adbb4a180 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2679,7 +2679,7 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
  * @folio: Folio to be marked as dirty.
  *
  * Filesystems which do not use buffer heads should call this function
- * from their set_page_dirty address space operation.  It ignores the
+ * from their dirty_folio address space operation.  It ignores the
  * contents of folio_get_private(), so if the filesystem marks individual
  * blocks as dirty, the filesystem should handle that itself.
  *

---
base-commit: f0b0d403eabbe135d8dbb40ad5e41018947d336c
change-id: 20230917-trycontrib1-cb8ff840794c

Best regards,
-- 
Jianguo Bau <roidinev@gmail.com>

