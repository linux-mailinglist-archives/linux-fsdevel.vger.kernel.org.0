Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E51D6D9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgEQVry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQVrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303EC05BD0B
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so9520644wrp.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhLF+EAo4dGVe9BW/cZoXpOODpgV89tLSnKlct0jr14=;
        b=OnCwteZT1cB8ocCGH1aeVFrR4EgF5VX00CwdKk8KWUvXv5ftfo0fsjEkaKXrYyqAko
         mv8QW8YvOau+ddNZijQJPWJlc875CMZRCq5jPs47LtKcK0iAs7w4XKAdfWadVkwF5yh0
         vbZ8lxoep7MmAuEH6k47PeqCAdK68/ugEpDe30/qtwZ9iClzkmuyh8DAmed8tdkPBipP
         jtwANFKLPWtFlbDtTJ0ozTDQyrJ/8MF+yVMxoywDnUPV0eAnzFwGIvF1UFAWTh1jfkPy
         frPno0kwJWfIWzY+KzjmatENTMD8D9ajyV22QBav5R+pK9+lpGb7JXY4w7s1coccPTEN
         Jq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KhLF+EAo4dGVe9BW/cZoXpOODpgV89tLSnKlct0jr14=;
        b=A9fqyqbqEiDE+aoWczFaHkNwHMj/pAv5hxfwWuYfpZG80E8TSx0Kq5RsBSPPALZy9i
         otq/zS7/LugZKUqa264p2UDRX1vs/4TLRPGXpsV8GxZzGU6scIWbhA0tKiXK0jyzY/1y
         IKMCzq6re4QAGnpeiNK+vORDY/Mrk0UdNCO2/U99hs6ZOE209hktq4y5s4ww4k+2TP+v
         EiViZfvJyCj1BZ5WiuJSFSBVII2KoTkqTyLHx9PjCb8ForHJGFVm6fGBJUsh8GVC8XbD
         s31Vaqe/5dVLdpN42B8Oin6bDYZaUuN0ws+PtAZrNazSoXMhEqrW28PIP0qEPWt1s4Xk
         eDRg==
X-Gm-Message-State: AOAM530b7KBRDpdBqCpHCadrbTrI+pMSjDAmolcBi8bsxHw+ck5XivtU
        fF1eXwkGEX+FIzv0ihZZYf3ni1JO++W7Qg==
X-Google-Smtp-Source: ABdhPJxxkRT4OGk3cy6v3FeXQDoR5/LNYOrP29Np5Cq4jtgQoATViCQkp2walv4nqYI4LHoZCE16MQ==
X-Received: by 2002:a5d:5228:: with SMTP id i8mr16279223wra.359.1589752049269;
        Sun, 17 May 2020 14:47:29 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:28 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 06/10] iomap: use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:14 +0200
Message-Id: <20200517214718.468-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
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
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. call attach_page_private(newpage, clear_page_private(page)) to
   cleanup code further as suggested by Matthew Wilcox.
3. don't return attach_page_private in iomap_page_create per the
   comment from Christoph Hellwig.

 fs/iomap/buffered-io.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 890c8fcda4f3..a1ed7620fbac 100644
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
+	struct iomap_page *iop = detach_page_private(page);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
 	kfree(iop);
 }
 
@@ -526,14 +521,8 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
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
+		attach_page_private(newpage, detach_page_private(page));
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
-- 
2.17.1

