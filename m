Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCA4C4E1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 19:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiBYSzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiBYSz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C61CABD2;
        Fri, 25 Feb 2022 10:54:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a23so12607875eju.3;
        Fri, 25 Feb 2022 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30FtiEJuq9qGFmUI8IIMSlcoGWFh+LIv/FHGSxMj9s4=;
        b=XxbC7/vBtnDNEt7ILz46BHuX63TOinU9K9L0OafslHSPYMTj9mZGTjor8bMkLEuCrw
         xYrZdh9VK2A44AZUQEnV6cJmFuzNOGJ6ugAmq8w+yNMPYNpVdVLGBQscP1/i0F5OANJO
         GQKMOaenKgE9qbUbABe7Rf7jadC/rkhBFqQKkjy/4XA42hC5Nk75RDUahybN4ODWiLxR
         4OTP0boDnQ7z67o7G9ZjmkXv9P5HubXkGMJIOTOd3v1F4OI4tsXgT72Y692PapJcLMK6
         ClQ4/U66nD7x5NWoSGopOcUpjz3LPxBoWLQ/5tiVtpXrjuuIBO++Nv+erm8r0ggZbSjD
         F2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30FtiEJuq9qGFmUI8IIMSlcoGWFh+LIv/FHGSxMj9s4=;
        b=Iqo25f6geELFFsqKx/7Sp/u6TZDI8byBrQt0mlO9GzEYcAFp5zMlW/Ob4anktxeEAh
         etLaVyDePnm0UlmtpRdnp9jT6emqHDbihZ0E8cqnUFcpOHO64BBA0sqQFjobe7fYNmNp
         7CubzFWb/UnB1jSDVXfVavqUtU4ncwrPOS8bbGg1rv68jNaaj6tiNXrqdqdsmZN3rk4c
         SSSbaN2Cy/a/j9+OFnGMf8VEQaMQst8H6aVdfqXhQy9EUwhwrQc0HaSiXHKCMCm5Vnk7
         XDPGvUgDaq9pUOCAmqonhp4RFBalqWYkxWyDarIGRagK1ZOZMBCPrHpEa8w1HrfZuLz+
         Fikw==
X-Gm-Message-State: AOAM533MjtQ4X9bXqCkoObqjynWElQg3g9OiN24is0PBuclW3h8CYDTO
        35ACWi+SYmYz8ILBraKMrM/KUyq9jas=
X-Google-Smtp-Source: ABdhPJwPQb1aWFUmGMgBXT0ARgSfobiUItWqutWRvZDgkko8ojm1DyqEPa/MZf4MDBvhVPdOfXGPLQ==
X-Received: by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id bw6-20020a170906c1c600b006d5cc27a66cmr7402379ejb.650.1645815294126;
        Fri, 25 Feb 2022 10:54:54 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f1cbe000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f1c:be00::fd2])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm1328508eja.91.2022.02.25.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:54:53 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 3/4] fs/pipe: remove unnecessary "buf" initializer
Date:   Fri, 25 Feb 2022 19:54:30 +0100
Message-Id: <20220225185431.2617232-3-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220225185431.2617232-1-max.kellermann@gmail.com>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
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

This one has no effect because this value is not used before it is
assigned again.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index aca717a89631..b2075ecd4751 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -487,7 +487,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
-			struct pipe_buffer *buf = &pipe->bufs[head & mask];
+			struct pipe_buffer *buf;
 			struct page *page = pipe->tmp_page;
 			int copied;
 
-- 
2.34.0

