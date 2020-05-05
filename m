Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631F21C602F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEESgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEESgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 14:36:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBAC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 11:36:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so3443392wmh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GcTYW3tOVG8xxe7/8qSqWj352UIHhFGVhUiW0JJDp4=;
        b=gyZX+8A2ybgzS/UQsqKbBMwYPyCdQ5PB8z/wxaeyHscQVGopYIpDQES4peGDSLvxu4
         DjezD9CiaUHIDm/qG14xwzN0jmsHdDlo44lm/Gp9cFogPzchJpnsd9MA0PzNeTsHhQIh
         zIecvaUbl1iHiDGRfuwi1FIRYLhbwiHUFSiwIepCZZoMRl8ju13+TriJeF87mBKTcXwl
         JG5iWmr1aaQ82D4TucUVIybUHBWFMX0Kl9iAtijS5cXcV9YeW1u20/AEWYK4RR788OH5
         Jn+jyy8N0ATO8a3mKQ8LydzosFfiR3Q6welcFp1kfaHZXYeohhbqaAlOGUgw+BvwczL7
         8NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GcTYW3tOVG8xxe7/8qSqWj352UIHhFGVhUiW0JJDp4=;
        b=AXGnqSL9z8q3YokYbWHd2t84KUUnsywpXi2ZH9I/6ZRqkbs4vbX3QLvUXku/yQziW/
         qOBfNmRBTSLX1VEHOS+wjuOukUvOudTVf5b3cBTmxBmdj2cXwgPJ/39Jdn1LRy3GWA0/
         LZPjXkfI5k83GGVvAe22B69+NTziUO+an3pc4zulkKNUgsb9PAanJ98bxaIC+mmQZIGO
         /24fsjHZdb7UNYg4lu8si3Ob0uCE26IJjZCx7vKKZ279HBGl2JqGNpt6ZoxycxtPz5tf
         LhWKqoMTspsdzZYpIYhma3Fsm1Y8kr746XtDcKzQcm2/ucwfEbGWht61qtquOIkBJ2oD
         2HLA==
X-Gm-Message-State: AGi0PuaYkyhD+gqpDweeEwTNvtCmqL1QchWOcq2uj1YtyL7d9B3FAjOv
        Nq7ebJbt7UEcTaDtXEQPBaw=
X-Google-Smtp-Source: APiQypLxQbIflPBs5P99ZTG5+KYeKnl1LGqof9LYbeClNmdkBaMfESR3MiPYvUn3ztECEXDaltdsIA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr48008wmq.175.1588703780338;
        Tue, 05 May 2020 11:36:20 -0700 (PDT)
Received: from localhost.localdomain (cpc158779-hari22-2-0-cust230.20-2.cable.virginm.net. [86.22.86.231])
        by smtp.gmail.com with ESMTPSA id f9sm2003657wru.33.2020.05.05.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:36:19 -0700 (PDT)
From:   Yuxuan Shui <yshuiv7@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH] iomap: iomap_bmap should accept unwritten maps
Date:   Tue,  5 May 2020 19:36:08 +0100
Message-Id: <20200505183608.10280-1-yshuiv7@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
generic_block_bmap to iomap_bmap, this introduced a regression which
prevents some user from using previously working swapfiles. The kernel
will complain about holes while there is none.

What is happening here is that the swapfile has unwritten mappings,
which is rejected by iomap_bmap, but was accepted by ext4_get_block.

This commit makes sure iomap_bmap would accept unwritten mappings as
well.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 fs/iomap/fiemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index d55e8f491a5e..fb488dcfa8c7 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -115,7 +115,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
 {
 	sector_t *bno = data, addr;
 
-	if (iomap->type == IOMAP_MAPPED) {
+	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
 		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
 		*bno = addr;
 	}
-- 
2.26.2

