Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6961D6D9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgEQVrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgEQVrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1316C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so9574288wrn.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SlqZ0+quTzs0gn5rYjmOostsnZNRU9Vv8J3xoIiDfhs=;
        b=VH7rLkRs00e3V5j6MTq+VAW1I0RCxdyuX/WcaV/wa9Iy/hLbDu/JAqqn7zXKJbDEGe
         7F47zhLySh5dNxZxyclhRFKF0wNt3kETEBfy6OerjR5ey0QtZeUrdizcT+T470iMyvGx
         9X/4DVXkxs69mTJ4Plb2j4jqjG/1z/W/akCauTZlj0LcbZZsEDdkhLlmP1IYgaaKv4rW
         PCMiLRYgiKtewxDJ0eItQ6pu4VbREnHgEK5x8SvZAciW3k1YW5dCr7fZCcF/CunQj4Xn
         h33yzPtvGDakdH0PvDVtUNWap8a5MysQezDzHgZRnRz7TgYkxpXDxH/XWX9PlFvA7C2R
         0y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SlqZ0+quTzs0gn5rYjmOostsnZNRU9Vv8J3xoIiDfhs=;
        b=K878MVM9dwGPKjNqJE9yLKmUhTlpADi6R3o6xW62txRxBKS8muC5vxZtELfPuvf1EV
         4u6g2XNu1YZtPJzQspEfU6ypV1NcEN/3aw4nXFqpynKBiqRgxIb7PaY2Wy6s75avaYd7
         PmkhfLJnlm5miYrjN/XnUx7saMg9m7uvVvv30xNbVpb3dKZbCfsgM2IDuM0swmzhH86p
         hdtHS1Nv1pwv5MUfaXb+wD4NTQvbHHbqmwitmOrSvXPIMX/We1yuHD/63w1kKtaGg/qQ
         iTUm1NPJCAjFgfERZBJtWS73k2Or8iI1hLFu2Po0RoVobQl+5rdpZZ1vsr7hhKbR6TQZ
         YqFA==
X-Gm-Message-State: AOAM532wwvfF0h6DiYfSpg2hhOAQtPonlpCZ9K6SObGG5YIkyOyYiOZF
        9JaJEP2ERH0DPXXjV1NbjiRaJg==
X-Google-Smtp-Source: ABdhPJza7OASSGVEI7sH52Q8TXauNBOHM5LsFEw9mjVCm8wvkCOSHgxfMNv0wdbu+ykEdVfLI5znaw==
X-Received: by 2002:a5d:438e:: with SMTP id i14mr16144528wrq.413.1589752051306;
        Sun, 17 May 2020 14:47:31 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:30 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [PATCH 08/10] orangefs: use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:16 +0200
Message-Id: <20200517214718.468-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
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
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. avoid potential use-after-free as suggested by Dave Chinner.

 fs/orangefs/inode.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..48f0547d4850 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -62,12 +62,7 @@ static int orangefs_writepage_locked(struct page *page,
 	} else {
 		ret = 0;
 	}
-	if (wr) {
-		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(detach_page_private(page));
 	return ret;
 }
 
@@ -409,9 +404,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 	return 0;
 }
@@ -459,18 +452,12 @@ static void orangefs_invalidatepage(struct page *page,
 	wr = (struct orangefs_write_range *)page_private(page);
 
 	if (offset == 0 && length == PAGE_SIZE) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(detach_page_private(page));
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(detach_page_private(page));
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -535,12 +522,7 @@ static int orangefs_releasepage(struct page *page, gfp_t foo)
 
 static void orangefs_freepage(struct page *page)
 {
-	if (PagePrivate(page)) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(detach_page_private(page));
 }
 
 static int orangefs_launder_page(struct page *page)
@@ -740,9 +722,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-- 
2.17.1

