Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE390628F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiKOBax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKOBau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:30:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E760E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:49 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d20so11742813plr.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAlz7tqq0QNaEwK87s1iuzIYezDUz9kvZQYKXkSLXDo=;
        b=sd9UI1HlQaNvLFt5yYvNRsOv7VflJP4IAUrhnHE7flexeeuoQ5hP8TKmCc+BaiIfMP
         ZiRGlgPAXhmbHSKa7yVy2L3lIOlPynkkJEHtQmdc7TRdfpUE6pywh2aPcPiv4GoVLz0Q
         zd0iww4tAvO4mJl3M8G/RaiY6Ava/FpH3GuKDApgHTJPoSxt/5F8/qZBvVpNgq1A8Prs
         fHl1IL0/KmUzftODKT8X6Jm4m4ecva0wyKgRR8mwwBU4D5J7BY/i/6NoDYqBkj3VD1qD
         r5la6S0xsiSZSjAQpJVXSlemhOX2B55pAvdhXhpwAkHkFieaYn2mwZYDwfepK+WLZrd3
         Y0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAlz7tqq0QNaEwK87s1iuzIYezDUz9kvZQYKXkSLXDo=;
        b=ORxPZlYkO79ZqB+YQQDEAbslt2ZbxA8k+YZXYIEGflIXqBEBJCU9PrAfQnIV2XpUeS
         +ma8E7bulpRq3V6oY8crEyIRT3B25WwBaLcpbCoitUhvskbUm4EDtbaahsNhxkcfOBNU
         jrx8cftbrS7xCaNOHXxG9oFDl5zOV8SyBiDWMHCK0aINDcNUarkcshcTL8lPHvchtvRP
         uiF+eqRB+426T+iU4OC+kmoMXHW/tN1LGwwk3vZLp7lncD6jwr0RRQKzWnGTSbQ7Y9ju
         wHTBAwB7rz8oK5DIp58ByP/RGLX6I1GqSX4asIgM1fBaI9jbeHMkHbhEwfwXvKhPkleY
         mLZA==
X-Gm-Message-State: ANoB5pkYxUTE9qWW410wUNhW1anJADOhXwy1Ymkadj8f0kllXpTuFKHp
        YUKl+aMTi3qAqFOLTaQIhcuKqw==
X-Google-Smtp-Source: AA0mqf7VUafnzdFgsn+0nyI7dq9zs5JPeB8q0hRVxivQdDOKjWJ/q10BkeaEXZRzwUNmnCwRvxAnNQ==
X-Received: by 2002:a17:90b:4b4b:b0:213:2262:e3f8 with SMTP id mi11-20020a17090b4b4b00b002132262e3f8mr16127935pjb.82.1668475849114;
        Mon, 14 Nov 2022 17:30:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id w3-20020a626203000000b0056bc31f4f9fsm7390484pfb.65.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:47 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKFu-9H; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001VpE-0o;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/9] mm: export mapping_seek_hole_data()
Date:   Tue, 15 Nov 2022 12:30:35 +1100
Message-Id: <20221115013043.360610-2-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115013043.360610-1-david@fromorbit.com>
References: <20221115013043.360610-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

XFS needs this for finding cached dirty data regions when cleaning
up short writes, so it needs to be exported as XFS can be built as a
module.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..07d255c41c43 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2925,6 +2925,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 		return end;
 	return start;
 }
+EXPORT_SYMBOL_GPL(mapping_seek_hole_data);
 
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
-- 
2.37.2

