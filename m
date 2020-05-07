Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E311C9D9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEGVoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEGVoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C339DC05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l3so6705359edq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRmHX3IZZP32x36RObq8cJr3jcmYRzNNrV24AaRSD3Q=;
        b=BwT/Zh3w5Ab/2fyrWKjcImjnCLggazQc5C+NxIqfPv7fWBCfut0N3l156Zqibr5H47
         cI5J4ono9XJ8qJ9rDaMRJlcuwuIZBxSUTRJOrkFEJ9EPJmu38UutefuP0qibEyeDhguL
         sU5BY7JZW4JNRQrJiYUJtzEVYWJpPYwSQZRdF+8sI3Z+F/CK/fiJAysAbbLy+Vp3naDf
         gUQvavWsolWGkgXU9XkGB6E5mPg7vARWDkkNfUITP5FYfD30vkbWgx6WwVpiDtHEOUZZ
         C4ecKMvVonzP+dt4s0jxzpuO3NCSo6CE9eOd9AOyPnNqOtiBMzlmw2TTULpRknpxApAN
         QLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRmHX3IZZP32x36RObq8cJr3jcmYRzNNrV24AaRSD3Q=;
        b=m9Gpx7T1tCPzEGX25gdFvK7tIOOgIJJV75Yuhb9EU5154MKdKEy12e+XdFTVcEKuvg
         d5eM5f87qkJ93M0lk7tKWedODWlDw8kJnwq1J9xn8472YU8e3EZUnR7QPUxRpytDQpGr
         Y4OpZlMcBpKVCQLM0wrrw+QC3rzZJvl0bJ3m+75Lw60ImjCNPFL/Otat+8ig+OSNxnwW
         UvGIzIT1+7RacQfXGOjJ9H7OUeRGQecyYeybBm/pLK8gxet2vENHBC7y2w6goKPuDwo8
         QNBw6me7lwT0ggWu9Av1TZhY4mrhs0xvIRi80GpfKmaBZGHG/sg7EwUU1ZyAdbgASUJa
         ggxQ==
X-Gm-Message-State: AGi0PuY0UudXqaTakT/FI7lxDRbLxWAvIbDnnql4D9IfAPG4m7/7keWZ
        L/Ek+kOe+fxJEtPwqfdKWpfKAf702tW1Iw==
X-Google-Smtp-Source: APiQypLzMcqBJI/17Vgt7qv4BkMPLnn8Kb2liCXz1NippJB7rxuZ91wxVX1EIVwT7gew8QEwlM4s9Q==
X-Received: by 2002:a50:88a6:: with SMTP id d35mr8080403edd.238.1588887859059;
        Thu, 07 May 2020 14:44:19 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:18 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [RFC PATCH V3 02/10] md: remove __clear_page_buffers and use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:52 +0200
Message-Id: <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After introduce attach/detach_page_private in pagemap.h, we can remove
the duplicat code and call the new functions.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 drivers/md/md-bitmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b952bd45bd6a..95a5f3757fa3 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -324,14 +324,6 @@ static void end_bitmap_write(struct buffer_head *bh, int uptodate)
 		wake_up(&bitmap->write_wait);
 }
 
-/* copied from buffer.c */
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
 static void free_buffers(struct page *page)
 {
 	struct buffer_head *bh;
@@ -345,7 +337,7 @@ static void free_buffers(struct page *page)
 		free_buffer_head(bh);
 		bh = next;
 	}
-	__clear_page_buffers(page);
+	detach_page_private(page);
 	put_page(page);
 }
 
@@ -374,7 +366,7 @@ static int read_page(struct file *file, unsigned long index,
 		ret = -ENOMEM;
 		goto out;
 	}
-	attach_page_buffers(page, bh);
+	attach_page_private(page, bh);
 	blk_cur = index << (PAGE_SHIFT - inode->i_blkbits);
 	while (bh) {
 		block = blk_cur;
-- 
2.17.1

