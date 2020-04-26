Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641501B944C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDZVuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgDZVt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10055C061A10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p16so11993949edm.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qimnPXc/z1dTWaJyW3qhOlSkB0/PAvYb4yEUYXtkvBs=;
        b=Gm5iEQRGXjL2eUupRJ1Bh30r73SUBX84ADcBLaYreiF3hSkQEWeKNIEUgAFgJLtLMv
         wPfZtMjOqDacKdHwqWjWK8uVQ188OIkqVCt146DjBGGH399nUPOYIlJkSW4dfDknFdUF
         7MZbSYWDEpgvMg69WJ+M7z5zshqFGp9auxPkebka7dLFCiHYBwsu5dsfZgALElUrvwf8
         DMOqEwdKpZ2bPipHuh1KAjPEo3Qe2sEvSDGUJU0QwVaiR6GH/gZlDzprRcFZ2Ke6EyZ9
         yUX9cBs8ilZZTyPKS+PUWadroC9CcJIR2cNNDoHBKSUR8zw2YRZtoZQ+7apQE5HafRd2
         Sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qimnPXc/z1dTWaJyW3qhOlSkB0/PAvYb4yEUYXtkvBs=;
        b=kjUhp6k3F34WZRlv4twBu1mQzD17DMhNwnj4+gCEOleOb4LTkEE+bnweUtA+0omiy4
         +/j4qEi5blL9hY0rY2whZ8NGCXYrhEa5W+7itf808zwTXBEDojzISQyTdf2Epcd5MJz3
         T3oSib7izuXhMTjd9/zi/jCyzQErTnPhOKJunCbI4Mja0jNJlXicLOeBXR6MZe559N6W
         5GKMxqEg+V2uJcrSnYMFKKWtxqNBFrupc5UQrdvslc3VFitY5TB5rRFsSBalMiDk47bW
         qE29Jja27nY9cQBqSF7Xd/dRLYTXJ+2mfsNWx2FEKIQDxT763V7nVUUshUlut4S9LP4v
         9hbw==
X-Gm-Message-State: AGi0Pub+FuzsxUeGFt52TzzWKcZX6/m8eisAadncAdOi30GKpse0H8AB
        BL53idmv8yiHPX4oDep0OgwWCocifjVCw3Z2
X-Google-Smtp-Source: APiQypIxdj3EgE49EVNEoQZtKa8LHmNouU6TNbFXBP16dEsDxvsw1UYgQ/dUsGDgJvJe0Ig5v2bGJQ==
X-Received: by 2002:a50:c3c2:: with SMTP id i2mr15735367edf.93.1587937794634;
        Sun, 26 Apr 2020 14:49:54 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:54 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:24 +0200
Message-Id: <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in orangefs.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/orangefs/inode.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..893099d36e20 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -64,9 +64,7 @@ static int orangefs_writepage_locked(struct page *page,
 	}
 	if (wr) {
 		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 	}
 	return ret;
 }
@@ -409,9 +407,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	set_fs_page_private(page, wr);
 okay:
 	return 0;
 }
@@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
 
 	if (offset == 0 && length == PAGE_SIZE) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -537,9 +529,7 @@ static void orangefs_freepage(struct page *page)
 {
 	if (PagePrivate(page)) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 	}
 }
 
@@ -740,9 +730,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	set_fs_page_private(page, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-- 
2.17.1

