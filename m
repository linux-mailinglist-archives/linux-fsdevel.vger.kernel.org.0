Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC41B9452
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDZVuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgDZVtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:53 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B52C061A41
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s9so12494664eju.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nk7EV8qONapDcMrz48oPwtLT8Zin9+cq+j0iMab0m4A=;
        b=Jp65FI7Lo+Cn8/FOgWCuXZHNnKbn3DioxWHStDkNrmH2gVOtVcURqIHsod5j6u5BLR
         /bzkNSBHvR65E7Cc8qY4fKAkGe64M3OAQyMWt4e89dAlgVvLImCOAq02qBwmXSn+VHvK
         T3Ei+CxAHR2A+azyaRyZCEtKDP0LyhjtDBp4T4MPxOCW8FBvLTK1mMFO06vPCAhZC/UZ
         4Y365TApm81j5lGrkPGBW0G54qzQUXcDXG2jNf7vIprZiYAlXUdj7DbHP0JH2jfk4bsF
         p7Jkpb1gKLj0A7hYSunF2Dox+xkU5KikPl1Pl0jESVe7A/kkxilmSAif+MqAH2hA6/up
         oM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nk7EV8qONapDcMrz48oPwtLT8Zin9+cq+j0iMab0m4A=;
        b=c+wYV9Z1xF2EmtQbNcN7tBcJ2T9MvFrnge4Eu74F/D7ke8Gc3kSHcu7+K1TztY3qB6
         phIhAH/Oy/BpOsol8klt4EMC4bbq21yFHRNvOlNTFcA/fcGaF4VvDGgKLxvrbZkdS/ih
         wpuvS/bUfqIXu5hqQj8rH2e6Idu7yDSiysi4KNlyhfkExHggNxk3ABOYSpTwt8CQFdia
         ZcBG0mV+IC2q/LZx4/kd22hc0F9hEpI+bx3/SEqLT+fnlbYuoz9enRnjTSjq4IZj6nVj
         9Xrp3QQ0K8vOQQ1rTgJ7shrVuhrHmK9U+qRoCwAq1jqiWfiSE1AI0xMYQSEmnMWEcmRM
         EAKA==
X-Gm-Message-State: AGi0PubdGOup4uLySxgb8ENXtkmkIb0rY/xEDq1HwQqqlTh58PNY7Taz
        SGd9E75iOUOvuf2rUm6qYC7zz2GFLngJ5csf
X-Google-Smtp-Source: APiQypIPM3/WHEI2bnt8PhQVPXZZ9xFUarLWq3VdADMkJuzy3kZOX2mY6i1kz2a/wwgLRKeFp4qKZQ==
X-Received: by 2002:a17:906:6b05:: with SMTP id q5mr16557099ejr.329.1587937790675;
        Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 4/9] fs/buffer.c: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:20 +0200
Message-Id: <20200426214925.10970-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..1d9b32e77c2b 100644
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
+	set_fs_page_private(page, head);
 }
 
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
@@ -1580,7 +1572,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_buffers(page, head);
+	set_fs_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -2567,7 +2559,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	attach_page_buffers(page, head);
+	set_fs_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 
@@ -3227,7 +3219,7 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
-	__clear_page_buffers(page);
+	clear_fs_page_private(page);
 	return 1;
 failed:
 	return 0;
-- 
2.17.1

