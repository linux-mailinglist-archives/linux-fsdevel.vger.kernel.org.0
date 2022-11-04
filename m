Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E361A349
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDVZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDVZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:25:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05942F59
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 14:25:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37342ba89dbso56420937b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMzbEeAq/WBS4iwvB8bBgtIMvjV4CPxHl4/ZDJnosVw=;
        b=ZrK+ebo6lUDd9raxHtPZNseJQ/MOuileQPeRTp4FqpnqL0PiBei0t3rlsIuGVkcSLe
         XEDJC+IYxG3reEa/CtJkBvLhItgY1jvFfy3GuJ+ZEKv5HEGpNrUnjfNPy88NIBi1Hj9T
         migd7LYzNVulF8C/ji8OMzcXpYeEG5xHIioY8v/c1JWgn9sPzmNVN/p201g8/u+imUxM
         4QNvk8nFy7QDPLIu6OItVQClzrdd4NntORcBuLPRO5B+GncFefpH8PoMbfJaaX2r+2Rg
         8zZHpVttHLQGuvbnJo+t3LKSkaxbqielNnURCipoejdspuUUJ98WPGImxS/b+GrBeY9X
         /YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMzbEeAq/WBS4iwvB8bBgtIMvjV4CPxHl4/ZDJnosVw=;
        b=bbKXTT5OscBNOZWb315Uns4wxEHtVd9v2NL9a8+vJSQgdpEGNTdbIwlGkT2wg1Fw56
         ZlViogYxcg7/k166kUJkfq/rpDRz0tkyqBhnw5/xcYQoTPjzlGH6txagwkgaoQL2dgkS
         rPQrlw2c6iicDogSFc5VzJQBF8wxGZj8P853Iu8SEWQg2qm4FX+a5nTema0n8HX5ZnqM
         w08BwjtCY0ow0P6UkJ2dotWyC32sL80K3VqvOt7fUd3fwLh+Xflr09bB104fZHrfO6Zb
         2PdvgDID+6zyn73+sXFq0UBSSWxtxpRMCil3bODVGsBnBSC7f4OMUUZh+82k5RjYxdfm
         9STA==
X-Gm-Message-State: ACrzQf3YyylV3DVKvZ66pHNYbpETrh0pjXaCbAIYEWPSziKvo5GSOlPW
        piOt0aqxbGRvaBj6ZsLyty09T5MztG9kFbKMPw==
X-Google-Smtp-Source: AMsMyM6jYvgmQ0dGg901njBI8YTBH+yqg5uTvJfXKDJ/PvHypkHSyES9/YTnaGT1+uHsuq+9g+l3pGRe6ZlOTtYStA==
X-Received: from roguebantha-cloud.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:1eee])
 (user=sethjenkins job=sendgmr) by 2002:a05:6902:8d:b0:6bc:47ea:42da with SMTP
 id h13-20020a056902008d00b006bc47ea42damr34014092ybs.529.1667597134725; Fri,
 04 Nov 2022 14:25:34 -0700 (PDT)
Date:   Fri,  4 Nov 2022 17:25:19 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104212519.538108-1-sethjenkins@google.com>
Subject: [PATCH] aio: fix mremap after fork null-deref
From:   Seth Jenkins <sethjenkins@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Seth Jenkins <sethjenkins@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit e4a0d3e720e7 ("aio: Make it possible to remap aio ring") introduced
a null-deref if mremap is called on an old aio mapping after fork as
mm->ioctx_table will be set to NULL.

Fixes: e4a0d3e720e7 ("aio: Make it possible to remap aio ring")
Cc: stable@vger.kernel.org
Signed-off-by: Seth Jenkins <sethjenkins@google.com>
---
 fs/aio.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad322..74eae7de7323 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -361,16 +361,18 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	spin_lock(&mm->ioctx_lock);
 	rcu_read_lock();
 	table = rcu_dereference(mm->ioctx_table);
-	for (i = 0; i < table->nr; i++) {
-		struct kioctx *ctx;
-
-		ctx = rcu_dereference(table->table[i]);
-		if (ctx && ctx->aio_ring_file == file) {
-			if (!atomic_read(&ctx->dead)) {
-				ctx->user_id = ctx->mmap_base = vma->vm_start;
-				res = 0;
+	if (table) {
+		for (i = 0; i < table->nr; i++) {
+			struct kioctx *ctx;
+
+			ctx = rcu_dereference(table->table[i]);
+			if (ctx && ctx->aio_ring_file == file) {
+				if (!atomic_read(&ctx->dead)) {
+					ctx->user_id = ctx->mmap_base = vma->vm_start;
+					res = 0;
+				}
+				break;
 			}
-			break;
 		}
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

