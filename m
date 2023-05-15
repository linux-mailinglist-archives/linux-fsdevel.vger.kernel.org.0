Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880F702AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjEOKlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbjEOKk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:40:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F51B8;
        Mon, 15 May 2023 03:40:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643846c006fso13360037b3a.0;
        Mon, 15 May 2023 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147257; x=1686739257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmGLmW3S8LQBrJuXQPeRYg8zvRh9RwXahnvoZneTmsk=;
        b=OTK0iOHOVFYd3iPy0ipNfqAyMR5brridi1K+yGpGYHxa/KnODdVA7MLp7utUqDsxnp
         zWHtw92vNWRvab832cjOOmOx2icp10NPQqp7vDKAKOSbCNEf4uMi4vERH7Ij8lkeNYZB
         BLqZoyBzhePW/u9jn3MCXabAc6TXGTYhk/BuhFeB0+R5uFaty5SD57KIL+/DXu4w1/N4
         CQFP9ATbJSfGvegBJLuz8PoZ1DmXqknpufx/WfySiq4bW6khrr9sTFJVa0GsxcbPTh0L
         rPpTi784eDOVmfdX51qyHYtNAhzU54Y8mdKHsJunslyW90cjRTyJzRqg2x70Emkk0igM
         ixoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147257; x=1686739257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmGLmW3S8LQBrJuXQPeRYg8zvRh9RwXahnvoZneTmsk=;
        b=adP3HmdFMTW0FZQ03pxbUf3Rd9YIcBrdvPyrBBFv3LKxJJoQPCNMR2Tw4lo5VbZakg
         azX5HQv7SfP5yBRuACLYU5Kq/JEP3FlKnygen2v+SkOSGxLdZ16MfKczstDSOP6SOLDA
         9R59/xmnfAdh2lm2ZeFWiWQNGMLXGMSSURHH8IVu0fIyVeJOPw7CqpX4/sS6GgQzt+h+
         WFF+l7DSMtdWengK5hv2Vda1GKyGATaghBUL4lOyQA+/6cef414SLFTvUgsaH0f4N0ee
         /FCqpOVQ/p8FE2b2vlBU42JERU641ByhwKDyFDB1uSQvMlnjc+j50SYgHTdD2oyviX5c
         rCTQ==
X-Gm-Message-State: AC+VfDzriJoldchQUNRlGiFBihrx9m1zMUqkDsS1y3WjuwL11bzpJUq8
        CwnXWJZpHvcEEXbPron0HizSkUS4phI=
X-Google-Smtp-Source: ACHHUZ50hQHHMjp+/4dtdYrpG0Y2ACkeNLspvQy5Z7J+AgAJEg0R1YE5AAyR6vuR2wwm7BZkVqpE+Q==
X-Received: by 2002:aa7:88ce:0:b0:645:cfb0:2779 with SMTP id k14-20020aa788ce000000b00645cfb02779mr29124620pff.26.1684147256606;
        Mon, 15 May 2023 03:40:56 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:40:56 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
Date:   Mon, 15 May 2023 16:10:41 +0530
Message-Id: <74182f5607ccfc3b1e7f08737fcb3442b42a2124.1684122756.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684122756.git.ritesh.list@gmail.com>
References: <cover.1684122756.git.ritesh.list@gmail.com>
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

mpage_submit_folio() was converted to take folio. Even though
folio_size() in ext4 as of now is PAGE_SIZE, but it's better to
remove that assumption which I am assuming is a missed left over from
patch[1].

[1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce5f21b6c2b3..b9fa7c30a9a5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1885,7 +1885,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	len = folio_size(folio);
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
-		len = size & ~PAGE_MASK;
+		len = size - folio_pos(folio);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
-- 
2.40.1

