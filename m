Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26D01C09BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgD3VxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgD3Vwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:41 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22DC09B042
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id r16so5831417edw.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPlN3fZ7s3A++1C7sjyXHDQViaM0ZwVaqGJ/ArH8ydc=;
        b=UOPZmwOFBz31CA1a013XCSUWOTz7+nHfoiYRSbBtN9DTrVUw2HSjsz2tXg/V4BYZ2c
         8kHvJ1qceIU5vULZn7JEiYulYGw5R7/x1A7zSCjqntBD9zeG+2E4ndkO6t+9iQpB+RRF
         ksYbCWMkTUG4zF0GfztaqimkvrbkwBrSJjfW10WETmEA9E+Gt8PDdB679AJKe6bIhaj8
         loRLKU2TTfgNIgSBPoypHr8C+alLR1Cp5Tj5VrOfOv4Hgu2wwPGU3hSBDCjXPtRNcw3z
         qAUejIde2vbObWtIkpGtIRUXfQONKK9z7FBHqhKKGmEfxxWwvpYwRp0WYqSRaV8jCI0e
         esDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPlN3fZ7s3A++1C7sjyXHDQViaM0ZwVaqGJ/ArH8ydc=;
        b=kqsMdDUtGdJPZsE2AEB0WmdpMB4OCQCrm/ZH1ZRofq6Pu3as7i0Fu30qSrWEZ4GsSD
         jlafXKLczCL0NrDVdvOGD0Imc+0iEJyGZg0XS7NCfnfpnQuEI7DNqcsWBFC8kxhV27jd
         OakmSCnB8EuH1hfk3c0lOL+5MtUiVIF16ecYn47zukHOVpYlv56Q9T9XRQfZb+KBiyZT
         zC2fIVqBQOEA0NyOWuhBU/eBqxHQEndjCiHygaXpZTcyLB5toq9TrPK0HilkiF7kbXIr
         u2Rnfecj8FeE1ft9HTgUOS6Jdgrbl21luW336bkThU3xrkhfllX2GjoIB+BXTWzWpXAp
         IJFA==
X-Gm-Message-State: AGi0PubPHDsvNTqfiWRQKPpVBdhl8OA0FgRQmur37B/OUkRWKjRHYCDp
        AUs/dYbenBEQQVr1F7LbCBSu3UJeu0QuXw==
X-Google-Smtp-Source: APiQypKU16GiA01s65hPwNkOTaUje+/he/O4OTLJGHb+/4rc2Vf1fIUqVKimDiLTjtArR3CW7lCK2A==
X-Received: by 2002:a05:6402:1651:: with SMTP id s17mr1043143edx.173.1588283558338;
        Thu, 30 Apr 2020 14:52:38 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:37 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [RFC PATCH V2 2/9] md: remove __clear_page_buffers and use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:43 +0200
Message-Id: <20200430214450.10662-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After introduce attach/clear_page_private in pagemap.h, we can remove
the duplicat code and call the new functions.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 drivers/md/md-bitmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b952bd45bd6a..033d12063600 100644
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
+	clear_page_private(page);
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

