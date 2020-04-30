Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C41C09BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgD3VxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgD3Vwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31089C08ED7D
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id k8so5995732ejv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDEyu4DqGHwJ7t/wlLTaUyFP1PKV8rYydYP0xvjnvj8=;
        b=K0b9BUEbUMN4c/HcO3EMetbwDKa/bQB7gEHoueMz+xCk9NFN8tJEEGyelIxvpaZToN
         ECQhJ9+wuy6qVtEwW9mUbisrOp3Pj/n5ULKfaLTMyrAgHJ/y7vfV7+QRzZcu/ByCJwZV
         CPuAb8QHPy18fm4QKel2ZHntwvTIDJWCm5hPjM+GtW6xp2scc5EbWir72q2kghoVWPxH
         Az6OQH50Tuf5V695TOo+L4tAZIwvPVOvxxLMV5G8tX86ymSPIZ2N9QR403Il6RFjXg4b
         ouaTyJZDdGlDGYke3obk+Sa+ExaUEl1q26wAKLnV/KKIMOjQcxkwBOITpksORcNhKjYu
         O75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDEyu4DqGHwJ7t/wlLTaUyFP1PKV8rYydYP0xvjnvj8=;
        b=mxt3dsRo6rr1/EJAtDPWs6cC7zMk2xn/RUJZmXbLlR2J4Hs8ej0iXWIQH9d+jOHcHI
         tjIcoRR683cdBUDu64XZjXwNPRVEp9HW5wDgHpJWeR5c40tdDlnOr6uvh+xX7SHbb79i
         OXJOfXAG+Z/IUvmkeGTgksyqrfw4WjqaCxNzNGZW2mXgNXW8wekXfqyVWOwp5Yo9beyx
         E9/CsRk7jsYStIpwy5ZIzHxdBDl35Ka3MJLRAF5viPFn+ihlmq/RtcPAFWcDIOBhakBO
         W3wProZ5J3YhDl22FtuJZzaemqQopGJMvSGhYfhq047NcFofgP0RLr1tJzKmdCd8nWDB
         4jHQ==
X-Gm-Message-State: AGi0PuYIqxoqlz+w1VzesPGCAT5f5Q0ofJugPOrVPfBvOWqnpDp+l/tF
        cAcsoVs1bjHls5vyP+jMjUybM9/zKl9Jmg==
X-Google-Smtp-Source: APiQypJYcY11pPgGBq9YSYemUl02BKlG2gtWtnLYjB8d8jL0gxleYPu+2YtHv3X6Kc4Pait6eLK1vg==
X-Received: by 2002:a17:906:5918:: with SMTP id h24mr537740ejq.210.1588283562672;
        Thu, 30 Apr 2020 14:52:42 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:42 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [RFC PATCH V2 6/9] iomap: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:47 +0200
Message-Id: <20200430214450.10662-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
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
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. call attach_page_private(newpage, clear_page_private(page)) to
   cleanup code further as suggested by Matthew Wilcox.
3. don't return attach_page_private in iomap_page_create per the
   comment from Christoph Hellwig.

 fs/iomap/buffered-io.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 89e21961d1ad..cf4c1b02a9d8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -59,24 +59,19 @@ iomap_page_create(struct inode *inode, struct page *page)
 	 * migrate_page_move_mapping() assumes that pages with private data have
 	 * their count elevated by 1.
 	 */
-	get_page(page);
-	set_page_private(page, (unsigned long)iop);
-	SetPagePrivate(page);
+	attach_page_private(page, iop);
 	return iop;
 }
 
 static void
 iomap_page_release(struct page *page)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = clear_page_private(page);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
 	kfree(iop);
 }
 
@@ -554,14 +549,8 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (page_has_private(page)) {
-		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
-		put_page(page);
-		SetPagePrivate(newpage);
-	}
+	if (page_has_private(page))
+		attach_page_private(newpage, clear_page_private(page));
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
-- 
2.17.1

