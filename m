Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7460E1C9DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEGVoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEGVoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:23 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FD9C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s9so5896276eju.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=du3Ie5iI06/rdz6CvBPo+dvSjUqDqQE7i/LV2aJP+GA=;
        b=MiE+Ud43dKkBLTxwwtjTs8umgmPkN0BYwfIJF9NimpzgXaIoLUNwUPzrYIMfxjp/wE
         9z7US+ja9ZyQtJgqqQIWp21xQ1iOfe4ZgjJytHnEpV/HgRot8yYEuaSkR1lrjKRQtJWL
         SDy6+wKTfKyvFcVN2gr2WozwC7ThujTOvGVSBqNU8k8SlUaLgdDrqXEEzDqPLenmaVQf
         AEriawM+qcLmVmMqDnbfaqwG2jfhJisNwoFCodJ2W0L86jMRiXofvUsXlEKRNlHFYKFy
         UbH5e9SqflHWa7fKLZUcGwAbbt7xfzUDABCLtZyQIvIAQQxPhVa/Vfs12FCp3Tp5aLxs
         zQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=du3Ie5iI06/rdz6CvBPo+dvSjUqDqQE7i/LV2aJP+GA=;
        b=VPW4v1DO6T0/9ZLYwEtdmoPPWYQ4DaCrGhmyNsuxB+LOp8gstBnst2eejPxSGB/z1W
         yg1K/Xei7bzkJwswYLbe9XTM6wbHMLHnBHiuRI57Ix0LvRoxW0BUyeTTU/iW8J3mgDnL
         KKg8mBXBXzIqzvnEaBFeO9ozEq6xyTizhdc9CLo5GgZ7QEX81psixe4lGaoejbtY5/Mt
         YavyP0x+RYFysYE0n9J+T4bVRdpq9VIfng6FDXoS8bxPi5CLodyzaRJq6Gm1hA+Skdje
         tN17wmZDwxcDaFrv5ZuBMNT3iqTe7s361ejRyJdPtRzXrj8AA0fk018648xsj1xbqMwc
         3VBw==
X-Gm-Message-State: AGi0PuZaI7zXy9jB0ixxEuKUCR/R76ktbDKXiIqrT4zuhOyGogNjA/pJ
        9y2EhF7fBtgokUlLmATjKmTIcuL048n3rw==
X-Google-Smtp-Source: APiQypL4O3/QHa4GVRZbemx7icFjGNwfTGUsTYsyFOjCkG+jrsEi/Fe+zD6Xr+OUjvj3miNQGayvRw==
X-Received: by 2002:a17:906:ce4b:: with SMTP id se11mr14818360ejb.178.1588887861475;
        Thu, 07 May 2020 14:44:21 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:20 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH V3 04/10] fs/buffer.c: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:54 +0200
Message-Id: <20200507214400.15785-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..059404658d5d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -123,14 +123,6 @@ void __wait_on_buffer(struct buffer_head * bh)
 }
 EXPORT_SYMBOL(__wait_on_buffer);
 
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
-
 static void buffer_io_error(struct buffer_head *bh, char *msg)
 {
 	if (!test_bit(BH_Quiet, &bh->b_state))
@@ -906,7 +898,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 }
 
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
@@ -1580,7 +1572,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -2567,7 +2559,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 
@@ -3227,7 +3219,7 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
-	__clear_page_buffers(page);
+	detach_page_private(page);
 	return 1;
 failed:
 	return 0;
-- 
2.17.1

