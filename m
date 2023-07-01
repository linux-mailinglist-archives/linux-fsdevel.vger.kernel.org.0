Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AF7447C4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGAHf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGAHfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84175E46;
        Sat,  1 Jul 2023 00:35:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ecf9a081so2063797b3a.2;
        Sat, 01 Jul 2023 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196934; x=1690788934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ/jQNKid21qXJou8CnoLfrwuQ5vopNmAWZzAmROpvo=;
        b=g1cnZGQHwHY4j5KqSn3DnVK6viYRmvBT8dDWQEStnmyYo0zrWwBOBgDAKfzjQ3O00e
         ia0xhnaXagXyWT+ExNhYx8B9R4Yg7/roQkvvse8PFvuPC2k2Zh8HRKQl/X9f035YdvK3
         EhrcA61QPKcSDd8l1k2joX528ZdnUFlES/F5+KYNZceB75QKvQhZKax6v56YSxzVwd+X
         x0/PgC8rIkV0kftn0Uhag7cdxdO6eB/GXcGSWrjQRWBLdd6MCHVXXJILXJOiQKYwJyUL
         8O6yxXwLYIVDHcKDUoab3Q824p7RWhP0kJsWcnJp5V6oYJSJp3mnuPJH5ga0z3xNCbt/
         eoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196934; x=1690788934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ/jQNKid21qXJou8CnoLfrwuQ5vopNmAWZzAmROpvo=;
        b=bKOSFAOZ/XzqpRiXo9kBlBEx7Po5UStbCjdPUKy1tv7G7qBx95G8CENF5xl0E1SXvq
         ABc05lBRaLBm3igCvRwHNy6Q0WASs6Y5zrV6ZJT51tMlT9YpBr081qHJYHGgNmyLMmnm
         p6sWKcenbiKUIcYVTd/zsbkPeBeKT+WeFc9pcYMtVwj0DCmLlJUhjG+ow2TxtY8vHmD5
         fESZfxxkyF0Lt876CZgvxOAhlcuHzkyj1NZIF5kp4UBG414gqysim+bZIutVVha8U7Yq
         pf/kKo1GSBLgz7fMIN62sHSEkW09Z2L2G7J1s9yO6YMhxzq/YTijRUwqF1ZVmCrAwr0t
         6sxw==
X-Gm-Message-State: ABy/qLbdXp87bqNiiEdwJaXXzaj1TchhZnUf5o22qhZar8416mXw6yXz
        EoU+k14CeAi8g2VRr4HC9lc1tt0YNAc=
X-Google-Smtp-Source: APBJJlHv0wtr72ZPUzmgnzwvqNQjWmc+9jhDBZ6z+VKpMVHtjQGh+HFxjKQ7X5P9DC+9+dmPKBrBOQ==
X-Received: by 2002:a05:6a00:9a8:b0:677:cda3:2222 with SMTP id u40-20020a056a0009a800b00677cda32222mr6554696pfg.14.1688196934433;
        Sat, 01 Jul 2023 00:35:34 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:33 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv11 4/8] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
Date:   Sat,  1 Jul 2023 13:04:37 +0530
Message-Id: <c126c4aeecc436dce702a20e5100ed148598ff8b.1688188958.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1688188958.git.ritesh.list@gmail.com>
References: <cover.1688188958.git.ritesh.list@gmail.com>
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

folio_next_index() returns an unsigned long value which left shifted
by PAGE_SHIFT could possibly cause an overflow on 32-bit system. Instead
use folio_pos(folio) + folio_size(folio), which does this correctly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e45368e91eca..cddf01b96d8a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -933,7 +933,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			 * the end of this data range, not the end of the folio.
 			 */
 			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+					folio_pos(folio) + folio_size(folio));
 		}

 		/* move offset to start of next folio in range */
--
2.40.1

