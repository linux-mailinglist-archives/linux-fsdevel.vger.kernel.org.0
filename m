Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE741DF402
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgEWBvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgEWBvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B326C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so5100774plq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=xN8NwRmSZj3KWZhRv/KRaMZungdyWud1fPfvxX91TBDAas0f3RGQJhtwUc9bsOpYD+
         qehVzky+nxxds1s08uTpi6wNc8TSmWi+wAH1qS+2cwAlKmSLByajIDk3fKTDP07EBCv1
         ByzrBhkqH7Fi15hf+Xcef1drhJrC86fxHQy4O1XwSsOy6g6ZItp3jK4wbh6fQqdEYK1E
         +2XGqQXuLkliIC+pIUdmCRrWM3FS8yGjyJyGlVxU6myazzPESWv3XhG9efZtbIdTM8DE
         5Ve0zocw4u7wy39QwnyOZCoAfBY3yGuJ3lJHjSGqujeS9/y7N0Ws1hVjzPIG1hmM41Gb
         3hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=XwhA+x+JoT4inGJkCVFPfaChWxYm2GwAX58XrwIaNkTaXJM0Fnsfagoc/H/XTt7xqY
         BSPx5a06RWBKO7cjDB37MIZgp7L1dBvf7+yD01AoTrrB7h6sYF2INBIMMY6HHsygmvkI
         V+ArpvhVj8C5UPWZXcCU7bZWeOKPVa3mYPrdyL1KmNcp5b8/vpftVzemREKJ0ArVjyXb
         127Ux36tR/KAB8r6tFSJQAkElkcdAs5/M3svCvBuvNC2JvhGdEiPQbSlHfu23YF/NljT
         iAh5KSkNyUdRpc6RP5QRpIiwuRO1ed9/N7DUPvdRaYwNwwTbsLwkrhwX1HUjPGAPw9GU
         irjg==
X-Gm-Message-State: AOAM531zf74a8w+55Nk9N6vkWhKy5f6gYgCjMRIHkhK6z88p31MFBtB3
        kl55iA0xqLO/JJuFauRHB9aVPg==
X-Google-Smtp-Source: ABdhPJztwQahKJhtCBJUZvWAeijHNskrzA5ff8ZARDi37j/dWUEIIWlaDM7fyqURSemcqutfVlZDKg==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr8098085pjv.8.1590198668620;
        Fri, 22 May 2020 18:51:08 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] btrfs: flag files as supporting buffered async reads
Date:   Fri, 22 May 2020 19:50:47 -0600
Message-Id: <20200523015049.14808-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..c933b6a1b4a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3480,7 +3480,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.26.2

