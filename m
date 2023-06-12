Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443472B54E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 04:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFLCOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjFLCOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:14:51 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE079B;
        Sun, 11 Jun 2023 19:14:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39c84863e34so2188001b6e.2;
        Sun, 11 Jun 2023 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686536087; x=1689128087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwR+Br//mM4TJi0nAuK5n5aI7xVUDVwbzD2JoLH3tEk=;
        b=PXDJpBTHA65AcsByKj3qIbsDGTBrzv/cIP0WWsyYTbifSRsMn2EKrGuV6JrC1xx3v0
         7ysn33KTQuyb1hoSAYtq5bU4rvsKiC3M8ZPITZUG6kYLIjvoEr+FIpyRjGlQOGz2m9N5
         OGDo0U4P4nJHg6OOOWB75XuUh/2X+GzOFVhIe+X3E0r4mpLOgt4z53KlmDyY80B3oBUq
         1Sfon+W614AYqd5wRse3I/xCmiUChfG/xJXExqkI7BxWYTa1sdIt+Pg8xYXbLfdyrety
         9O7khHrt013zGI1GoSDkX+4/Arogi8iezBGs9Wnwcu/2PQuFHK9KTwpVDOhj2Rjdq/v2
         g/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686536087; x=1689128087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwR+Br//mM4TJi0nAuK5n5aI7xVUDVwbzD2JoLH3tEk=;
        b=Us8jaA/CUZ4UHg/JC1qOaA9bTK+D1IkdBFFa5FjQ7NtgUb090xXHK6/pM8/5+FyzWr
         dXdIis9ajp6CywE5xrMELLmESSawtUtDf1FgmbLcEuPGSJ4QRZVQOa9MCiK3Hq6S5ZHX
         6CaVds/O8W6iyJcV5ZpernZOwJamkhamn5rpAXP4EWy9XEDbiBi571gnF/MFsRyc+S1D
         tBnR2eRS4ZtNJpTFfVibDFaUc3dDo7DyGWVcHShUuqLQ+WaiNTgHAQKox0yQ2AlJRs6I
         l8RaGo/ZtZ/H/kvRuFc6+ni3mXktoCXKOl9cajdyI1x+q7wifG9ykYeKtv3JxqSxCPj4
         a4GQ==
X-Gm-Message-State: AC+VfDzcX0eP/VHm1IwRaexI9OoIJ8his/6B0yP6E49dDLuE3SWpIq6t
        wnBHLz/Oaempd8ozlM+rIEg=
X-Google-Smtp-Source: ACHHUZ5PE9wOquTkUtuI0bCcH/TLGYln0KWz10kAgqXWDtg1dnOA4CtvNtkYx/b5z8NkvfZpBLNkew==
X-Received: by 2002:aca:121a:0:b0:398:5478:b7fa with SMTP id 26-20020aca121a000000b003985478b7famr2676100ois.45.1686536086775;
        Sun, 11 Jun 2023 19:14:46 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b1c3542f57sm6931347plb.103.2023.06.11.19.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 19:14:46 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: prevent general protection fault in nilfs_clear_dirty_page()
Date:   Mon, 12 Jun 2023 11:14:56 +0900
Message-Id: <20230612021456.3682-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000da4f6b05eb9bf593@google.com>
References: <000000000000da4f6b05eb9bf593@google.com>
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

In a syzbot stress test that deliberately causes file system errors on
nilfs2 with a corrupted disk image, it has been reported that
nilfs_clear_dirty_page() called from nilfs_clear_dirty_pages() can cause
a general protection fault.

In nilfs_clear_dirty_pages(), when looking up dirty pages from the page
cache and calling nilfs_clear_dirty_page() for each dirty page/folio
retrieved, the back reference from the argument page to "mapping" may have
been changed to NULL (and possibly others).  It is necessary to check
this after locking the page/folio.

So, fix this issue by not calling nilfs_clear_dirty_page() on a page/folio
after locking it in nilfs_clear_dirty_pages() if the back reference
"mapping" from the page/folio is different from the "mapping" that held
the page/folio just before.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000da4f6b05eb9bf593@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/page.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5cf30827f244..b4e54d079b7d 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -370,7 +370,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct folio *folio = fbatch.folios[i];
 
 			folio_lock(folio);
-			nilfs_clear_dirty_page(&folio->page, silent);
+
+			/*
+			 * This folio may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(folio->mapping == mapping))
+				nilfs_clear_dirty_page(&folio->page, silent);
+
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
-- 
2.34.1

