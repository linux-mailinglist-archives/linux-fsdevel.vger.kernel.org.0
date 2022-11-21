Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3470A632089
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKUL0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 06:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKUL0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:26:14 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F28C050D
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:45 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so2977366wmb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=;
        b=VyCfbuWOem8BwV+1kbZt92/iURKerhApO5tHJL82Q3g8gJjhEf8Gf81lkNXinPV0WG
         33XKENJFJcX8AOPHW1fpifSRoqxXlHBwqxVqieU0qAQ3CQLak9yv9kSmC8Cd+mpuXWqA
         dMw4MYS/tqwBn9HATfin7JwAng24nM99T15wf8oiaR3VGtSchxTXvOchJ46VW/seRWPz
         sXs38pJvJqRP0PnnJsEFB9KY5UE+hWn5HdPDuNxMBW9IoYXeVIqpE2I6F0yMLJyOGUuI
         BmntwbMnaWN9YoJTyImpLCf9dUeBmBP1Zw2C7sgj5r2JExdS6DMuSGOCl6Jd1Ab+9sfj
         6cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ROk7430AgCjRwu8JCLeHALA6B0dvLhERaon//wlR0=;
        b=0Ori3UHhxQZO5hqMzhK11IG0neUcRJpmRPXWJWehGCz2fop1NOp/jUYHQ14PqxzvF7
         JEl/lV0cbht0c8RGjS59gUkqHxr0R15o6iCaL3UYVhbJxXp5/NLImbJmUkL3oBFW35Gh
         nYhiMEnRUo58AIP8pB+34p6LM0HHfpv+yXIy9cNyMSCojdAbiHBPKu4KZ0O68e6f7GZZ
         lZYm7VJbmcEzjZP+iqGl/pqMPJL+3eVTfFo3m/2RQhGezxATy4RpRka1eRivt8QBX8Ry
         rZ/K1Fje1A/5wxdjEe4a0Lg8YK02PMisDtMwaB0LKLHrZGb5J1gXacOxVcVVAL749jJn
         OP+Q==
X-Gm-Message-State: ANoB5pkDBjOp3u+vdWosc0F4RBy6lERsQ08pC/1iDulcZTMRvliQmKof
        i0POPc97I/0pR7P+lJQBw5NFcyJosHA=
X-Google-Smtp-Source: AA0mqf4lwPSD6Y7DTAtXw3/2Z+F5J2o+aieN11Xy71eaA/djePFQf5kKRgdlXgAOixk8oilkdCgBRF7Z9oo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id
 o6-20020a5d6706000000b00241cf90ab1emr1020206wru.685.1669029703858; Mon, 21
 Nov 2022 03:21:43 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:21:32 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-3-glider@google.com>
Subject: [PATCH 3/5] fs: f2fs: initialize fsdata in pagecache_write()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/f2fs/verity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c352fff88a5e6..3f4f3295f1c66 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
-- 
2.38.1.584.g0f3c55d4c2-goog

