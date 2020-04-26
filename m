Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18191B944F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDZVuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgDZVty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA81C061A10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so12018728edv.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=je11VssEqcRjDcQQUY7TMs+S/p8Pe+y4zVJlfwO1AIY=;
        b=OwNMupnSJkBuaJfMXeCgM1rYXjTmzIAla+tSBp7FYda6Z0do31Tv6/LqXGLMcBBWhG
         nqjIhBJEalueOvj9V2LZ+TuLLeFNIXzVb6OK45n66rzci+x/eJxewCUOYOo06dTayDKj
         B5iJ94emWcTjwQbgVlPIpz9Lz++7r/aQF//fpjSxu2/XNpEhrL+lHBErqiCynz5SbjB2
         iW4ERClUfrgtnD0QmDonsDibcZjmNyxtpI2M/DaGWxbm7W5qNx0fPMGF44KjexJ6P8/1
         2LGOGXLbZT3PVyAX3yAvtCf/8vJUr85wyASdWC+0wMGkNwBqVxwGJ+99/wys6z7wxDo+
         YYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=je11VssEqcRjDcQQUY7TMs+S/p8Pe+y4zVJlfwO1AIY=;
        b=SZu6kNuNzgkHoD4MvVwG1zkbNvLRv6FnZQKNvi76ZCAHZNU9+hxu2ACPGNvWHJLsxx
         +rAR2QOilgLHW3yTtPAcieVdtkTXN9iMZPASsk6DrzRGmrvHWWFNotV39e59CY29IcKW
         soZp4a3rKXuN+XHOJ0kvXiViGuvq3JZ2bjrF6fpsRbjkvGz62B4LjDBXDFJoV7/sUURG
         xEiPx7VWpY53eO94rmeEqigrcacxLNvHgDFDDYkPV/1I4Gm8iqeUTvXkNjhz4gOG9jp3
         0pjezBBhhKmZVvADJnkr7+s8vQmcwF8CSAtJbNxCFe4k+QY+BdYXMxBQwYJyZCiQiGTa
         EP4Q==
X-Gm-Message-State: AGi0PubAGyVODh9GwutOCY9UckYD07VJwX9xaZPsgfvJ07PRaBkEFNBj
        GbpcRG0Rw7+5DCRA+2zTLoVhTUJ4YBTqaLY0
X-Google-Smtp-Source: APiQypLeC6iTKrMS3r2CPJ1hgROOG19gCAO83wMvAt7p0NE0/jtP9fk8m1Bkoh+kIZpagKS8bUmlOQ==
X-Received: by 2002:a50:99c4:: with SMTP id n4mr16930973edb.187.1587937792458;
        Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:51 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [RFC PATCH 6/9] iomap: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:22 +0200
Message-Id: <20200426214925.10970-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in iomap.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/iomap/buffered-io.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 89e21961d1ad..cc48bf4f1193 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -59,24 +59,18 @@ iomap_page_create(struct inode *inode, struct page *page)
 	 * migrate_page_move_mapping() assumes that pages with private data have
 	 * their count elevated by 1.
 	 */
-	get_page(page);
-	set_page_private(page, (unsigned long)iop);
-	SetPagePrivate(page);
-	return iop;
+	return (struct iomap_page *)set_fs_page_private(page, iop);
 }
 
 static void
 iomap_page_release(struct page *page)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = clear_fs_page_private(page);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
 	kfree(iop);
 }
 
@@ -556,11 +550,9 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 
 	if (page_has_private(page)) {
 		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
+		set_fs_page_private(newpage, (void *)page_private(page));
 		set_page_private(page, 0);
 		put_page(page);
-		SetPagePrivate(newpage);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-- 
2.17.1

