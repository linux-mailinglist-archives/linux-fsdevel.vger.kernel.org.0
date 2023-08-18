Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC0780E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377880AbjHROqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbjHROqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:46:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB141BB;
        Fri, 18 Aug 2023 07:45:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so9900575e9.0;
        Fri, 18 Aug 2023 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692369958; x=1692974758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6i9pCVUjF2qmzQ66FFN2ILF9KSYNTknknoJlRz3YoXg=;
        b=kbPrliKvxLCHmqg3CWjzMWBRlHZgnPewXPHSfKzqTAgoQuySYZaEFyUCSXMFV7k7+W
         QWCYLSrmVyn6MnXuJfMkDtiAbd42GwPKjkWeWt3M4X1MRUBiwrkbPaKhT8dsfmQP1xPN
         HSX5WyrwJ5ZInNNiWEcmLDLZ8PEgCE8dxx2T9NC80IJCuXuRM5Jgyq1rUBUZDg8hg4Nl
         odAYB+C64Liahvd2tw8+a5ujxNUqAI6eXYjYa3OqBpwiG9EuGWMsVU2mICvaeO3BKHZA
         LQpJ3tt5+OdYLcMslAtNw+fSV0otKFIi2IoZIL+NsJIZ4ETdR5TrylJRslx22yAiyby/
         hp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369958; x=1692974758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i9pCVUjF2qmzQ66FFN2ILF9KSYNTknknoJlRz3YoXg=;
        b=Vg2NDO0TXc2/FQfdsqosXK0d+kZ6dUFfQbxA7CmrHJR0vNgZ/COmrcJ02PIUrEyQJH
         2H2iVdkulVEgzslZanwG4HUorHxQZ1cGROYH7HM0PaRlVbp21wzweofm1SFjmllXGiUf
         ONhoWRp6jln/mjtz0PrAOzQsdweelaGjVBAKogLzE7VIyLxVgBYhm0cAPzB8nbnjv75t
         8fGhDNFNR9Uhy4AMtP1lIwiVmlf95dlP2y0KNbZwWP5a1RBkxX8iDD399gJsHCZ1712J
         xHnH6O7fUH+yZwKiadq67T5g7051crEXsrmcFXvKhvWi3G8D0WyuzyRG7myFfq/bFi7I
         lp1g==
X-Gm-Message-State: AOJu0Yyd4FyXccaFv1wrGeeFijuDqnSTwApHZnPm5tWNkmit2wOHS8uO
        7aQCsbrxSvUh6LGX7Ke9Gpg=
X-Google-Smtp-Source: AGHT+IFY7AEmsqMhdY/QP1fKn9uU0KQsrQV1OMK0/me8P/u+kQSGtj29eqa/moyk7N5blGSj02ra9Q==
X-Received: by 2002:a5d:40c6:0:b0:319:731f:748c with SMTP id b6-20020a5d40c6000000b00319731f748cmr2246008wrq.34.1692369958001;
        Fri, 18 Aug 2023 07:45:58 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n23-20020a1c7217000000b003fe4548188bsm6521058wmc.48.2023.08.18.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:45:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/pipe: remove redundant initialization of pointer buf
Date:   Fri, 18 Aug 2023 15:45:56 +0100
Message-Id: <20230818144556.1208082-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pointer buf is being initializated with a value that is never read,
it is being re-assigned later on at the pointer where it is being used.
The initialization is redundant and can be removed. Cleans up clang scan
build warning:

fs/pipe.c:492:24: warning: Value stored to 'buf' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 8190a231329b..6c1a9b1db907 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -489,7 +489,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
-			struct pipe_buffer *buf = &pipe->bufs[head & mask];
+			struct pipe_buffer *buf;
 			struct page *page = pipe->tmp_page;
 			int copied;
 
-- 
2.39.2

