Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907B5753D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 19:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiGNRRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNRRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:17:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407FE474E6;
        Thu, 14 Jul 2022 10:17:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so4539212ejc.13;
        Thu, 14 Jul 2022 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aT73ovZkq/npubIyLigGbBLJTEexGlHL4gMxc6aPln8=;
        b=BGa0lNo0DUpc3iXq7AD97rOi8dhvdPScN7+fCgHUqML7PCEhKKx/6SqTF8RhC/d+Kh
         t69E9wzOjUmONW7qTsmVdvcX1KlUXFoz0DgJ6JRMdLUPEDa+T5t4eft4xhvUKknahqvd
         mrukhXm3X6e4R5hxAseAnz/Qi3kuQbIELrBA6tohi/Ra6mBgCRuJGB5lxaa9cSLpAOje
         0nyaRzHt1nTpIX8Ce6vo1OyjeePldLZLzM+ZTzl9U75+BqHBlEe7Of5UZnmRj6Bfcf6Z
         xBxicZQ8yVj5gucGWkxZIsvv2fFxJwi9XMG4CBTfYGtG5wypSyopZEBdHj3lPdrFq6kg
         1Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aT73ovZkq/npubIyLigGbBLJTEexGlHL4gMxc6aPln8=;
        b=J8znpMW69JgAeZnvOLMmlv/8FWuwvGCdxoShtGtBLxrEjFZE0BA2UJ6GS7B8hUlifW
         fm5ZEM88t8bWPaxKn1K5AbrL1p+fRCAR8KETNCH+HvqSLoCQejtOSXKV+9ITY+kSD8/e
         i6IzY9vTPdRsvzGAlbtOPdfk0XGcaH9gjQGaLXcin22R0H8Z4O2kKRuJ7awiiKf5/lCw
         MAkA/2jKNbICGO7EB7if6QJzEgA99j1CQX+9hvXHnj9WDUqCqdMzLWFsWYAmHgNGRgGR
         S4tYzMov5G0rsd4acEsFqj8IlOXQ1HQWrgN44JILduEoyBPXCkN2ZQbxva6Numzfe76b
         FQ5Q==
X-Gm-Message-State: AJIora/iqzRjFBq2IRfLG1QjPxqUUhjDf8/NhVUetrM7E3tMvP6hBJxw
        LdjyH2ImoRzuYgk99aq7iFDMHmk8nAQ=
X-Google-Smtp-Source: AGRyM1vpW2N1A1esFXcNudY8G1KDnk2qb0S7P6tY3W8yA8uidwsrHOnIuAdW49wShoHabBEK8TKCBw==
X-Received: by 2002:a17:906:106:b0:715:7cdf:400f with SMTP id 6-20020a170906010600b007157cdf400fmr9871224eje.1.1657819023585;
        Thu, 14 Jul 2022 10:17:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b0072b1bb3cc08sm905151ejo.120.2022.07.14.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:17:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] buffer: Use try_cmpxchg in discard_buffer
Date:   Thu, 14 Jul 2022 19:16:53 +0200
Message-Id: <20220714171653.12128-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
in discard_buffer. x86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg (and
related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

Note that the value from *ptr should be read using READ_ONCE to
prevent the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b..23e1f0dcdbc4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1464,19 +1464,15 @@ EXPORT_SYMBOL(set_bh_page);
 
 static void discard_buffer(struct buffer_head * bh)
 {
-	unsigned long b_state, b_state_old;
+	unsigned long b_state;
 
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
 	bh->b_bdev = NULL;
-	b_state = bh->b_state;
-	for (;;) {
-		b_state_old = cmpxchg(&bh->b_state, b_state,
-				      (b_state & ~BUFFER_FLAGS_DISCARD));
-		if (b_state_old == b_state)
-			break;
-		b_state = b_state_old;
-	}
+	b_state = READ_ONCE(bh->b_state);
+	do {
+	} while (!try_cmpxchg(&bh->b_state, &b_state,
+			      b_state & ~BUFFER_FLAGS_DISCARD));
 	unlock_buffer(bh);
 }
 
-- 
2.35.3

