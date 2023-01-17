Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1245066D41D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjAQCLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 21:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjAQCLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:11:00 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DA1F92A
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 18:10:59 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-142b72a728fso30599862fac.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 18:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.cerritos.edu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0OQq6sgsmukTPLDtsi9sQirhnS6juHbF/KtUXWbWsQw=;
        b=UE+D5RBHuqgPxFaUfvL0pMCO2VdpmpiH/iGxIY6bhROO7PC0m4Qz+qhO9z1xctMzbS
         c/wJZdNcCgNreZ/bCC0U5LdfkroOieXOh21UBP8W2AgdZlH673u9W6/UBb7YTYJkMEA9
         MouajhwfTa+yAyVBNF4TnqqxNxeAXZ2wwA/70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OQq6sgsmukTPLDtsi9sQirhnS6juHbF/KtUXWbWsQw=;
        b=vBcB8Da9yeebU8n6vcF4OrFrW/HbwrtjjJ0N1mwM56Y2ArzICXR7JxW9z6XAdHQtsO
         X/J+DOBXW7z5z8/fOnoqGbRIQ5V3iNVCaKcBWV2kkttVp2q+I6SkNVdbFj4K1UwfUBOQ
         LSmds1roVr3csoVIXKyx+bm57H3T3CpGgIrehaRs2peo5QPi6QtPNYQU8bPjCLcJl89b
         WbENV1jLvbX9+EGbEIo1vQWZZ1Q1hiET2ylMrlK+H5xr4BzZuVYQ/6mN+KZiKtxu15Nb
         CaxQS3n06qHyvA3j3/F+9DZOfTcftJzVeCoeWwXhIEFE5FmxfENMJ4GsdLtKlEEk/dwr
         sVUA==
X-Gm-Message-State: AFqh2koNklj+GbpStvNWZH5sr5t7ZZoKp377B3jl6fYtLCLBABp/Z1xG
        8ZEo3MjSKhUW4QepoA7+VxX1F1fK4D5yRZOgGuTpaGA1WRwKHbCx
X-Google-Smtp-Source: AMrXdXs/GIZ2QFT/lL5r3nXrYUYMPp3XALm9kB4VA9t1YRxoA3vWiyPbll+Kw4SBtelCDAotyTHNjc12EdyeKEqOlhs=
X-Received: by 2002:a05:6870:4949:b0:144:8d99:ef86 with SMTP id
 fl9-20020a056870494900b001448d99ef86mr152873oab.254.1673921459055; Mon, 16
 Jan 2023 18:10:59 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <apark0006@student.cerritos.edu>
Date:   Mon, 16 Jan 2023 18:11:00 -0800
Message-ID: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
Subject: [PATCH] dax: use switch statement over chained ifs
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch uses a switch statement for pe_order, which improves
readability and on some platforms may minorly improve performance. It
also, to improve readability, recognizes that `PAGE_SHIFT - PAGE_SHIFT' is
a constant, and uses 0 in its place instead.

Signed-off-by: Amy Parker <apark0006@student.cerritos.edu>
---
 fs/dax.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c48a3a93ab29..e8beed601384 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -32,13 +32,16 @@

 static inline unsigned int pe_order(enum page_entry_size pe_size)
 {
-    if (pe_size == PE_SIZE_PTE)
-        return PAGE_SHIFT - PAGE_SHIFT;
-    if (pe_size == PE_SIZE_PMD)
+    switch (pe_size) {
+    case PE_SIZE_PTE:
+        return 0;
+    case PE_SIZE_PMD:
         return PMD_SHIFT - PAGE_SHIFT;
-    if (pe_size == PE_SIZE_PUD)
+    case PE_SIZE_PUD:
         return PUD_SHIFT - PAGE_SHIFT;
-    return ~0;
+    default:
+        return ~0;
+    }
 }

 /* We choose 4096 entries - same as per-zone page wait tables */
-- 
2.39.0
