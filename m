Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A990248F754
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiAOOmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jan 2022 09:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiAOOmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:42:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAAC06161C
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 06:42:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e16-20020a17090a119000b001b28f7b2a3bso9491793pja.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vQu2YGnyaem/WDCb/1ixVe4jFBzHYp6XDPfE+l97NRQ=;
        b=RAFTf5fJoVhrySxFeclsltYyb9p2i1twuPM/kLWQ+AFQ0Wh4oUI+8TVolsH83OcqBj
         nk/EF88RqtYjKHpmjifQ5+xGMnzVLUpYZuKU0LsDwODppMPNL/NusBwFSngJ8jGgVjB4
         8Hd8NAsMTlBAIYnqa2CKkW3Z7NYdyLGxFaKkHL7QAwZZWCwTrKtg/74BAqqzr5omvKpG
         Gcb0uEB9LaPxJouoiwL5DNLazEiRrev8MFAm+lz0ThqXFWJbtWhzyG3h14nKMnNQ6fAD
         BvCiWA4yTnQnwRCDXK0K2c2Ed5ebeyYF51MrZvkKWbKAx2fSFPVDfmfeAivojQxhkRo5
         HlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vQu2YGnyaem/WDCb/1ixVe4jFBzHYp6XDPfE+l97NRQ=;
        b=pLMf0dgiQVrOIlSv8dnUj1K/uk24rUXs0TNwIHVz+VR5FW5vMbV9rRIWkKKAdpDVNc
         abiJJCkqn3MqfHDnvnM+xMIin2WSW6HUjUpw0kxxBM222SujJ6CRVbE/gWWv22aVIcTH
         GugGgZQTkUdbrFPtkpBaxUud9/ZIwLz3zdfq3C3GKmGwksnGfuLNnHg2/SApHnoeTmGG
         7cYCarSVInJXV2WERW4ztesLG84+/khDtn+P9xE5C7eOdtFAfyYr6O0tclekZ9s6XzxS
         52rZmSNrFo4IZqPlxRPUiyCGP1nENjFfZph/oxoV5CYE+RdGdJXgroSOF6KnCZH8EOXQ
         clNQ==
X-Gm-Message-State: AOAM532sxlUmFIUiN6uPa4gbqhISwDathajmbwL/mr12xV0YgyheC317
        d8AAQL7h+5mRP1unHjqFYS+5ZD75tFOFUw==
X-Google-Smtp-Source: ABdhPJzDJ6OuCMhPiZXw84Q7hz0CXiTS8JIsrrIAXlT+ZM3uGrKf7jUah/OPOJXY4kS0xiWjZNQkDozDXW4OSw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:5db:c608:dd2d:a4b])
 (user=shakeelb job=sendgmr) by 2002:a17:903:41c1:b0:14a:6879:9333 with SMTP
 id u1-20020a17090341c100b0014a68799333mr14741762ple.36.1642257724752; Sat, 15
 Jan 2022 06:42:04 -0800 (PST)
Date:   Sat, 15 Jan 2022 06:41:50 -0800
Message-Id: <20220115144150.1195590-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] mpage: remove ineffective __GFP_HIGH flag
From:   Shakeel Butt <shakeelb@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the commit 8a5c743e308dd ("mm, memcg: use consistent gfp flags
during readahead") mpage_alloc is clearing all the flag bits other than
bits in GFP_KERNEL internally. Simply remove __GFP_HIGH from the call to
mpage_alloc as it is cleared by it.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 87f5cfef6caa..477ccc3f3ac3 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -609,7 +609,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 				goto out;
 		}
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-				BIO_MAX_VECS, GFP_NOFS|__GFP_HIGH);
+				  BIO_MAX_VECS, GFP_NOFS);
 		if (bio == NULL)
 			goto confused;
 
-- 
2.34.1.703.g22d0c6ccf7-goog

