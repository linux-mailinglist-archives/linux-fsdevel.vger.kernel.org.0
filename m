Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392DF1AF5B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgDRWvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1717C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p6so4361455edu.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFu/s1WUWRTKfL++ymdKBNKB4z5V4nO3awV8fbzpHOU=;
        b=bAelyIOiycqdA3PHytQ5JNmxRIMokDZCfaqXWmLiSP5v93FMbAIm0wa9608080qvqd
         rLaIcXx9UIkgQ6WRkH/owbm7Id1Ae9CbwqmQQhUkI5YfW1hTWWJpSjdGwxTY6pxhUaGa
         X/m2YLLAd2wX0n7Z2FrFmGsPJ6qeqGH88wz9YfYHN721hH/FtHzZ2fXXkJ6+RgCZ1W/Q
         SunK8CV/RC7dWu8zH+78Edn8jvkeZdj2iEUztsu32TAoG1PJNFQN4GcwhmMlWtsRb9bV
         jFcmOTKm/+/BSwcyjPpr9A8cmqpNwt0dHrVCkVkEJPSfpR/vpPY0KdxLzaOPZe5GuJGw
         nUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFu/s1WUWRTKfL++ymdKBNKB4z5V4nO3awV8fbzpHOU=;
        b=SZJnM0+rcjwS4ZNRX7QNW8JxY7Nd5XUqOyDwJLz9G2FSUjdsIP0pUE8zr7XXUuwPA6
         EVvfy5D7QkXHjjEQcqqRhUzEXDdwjqW3cfHWxBHP/NnIUoBQ+ZGnuH5yhLfMqMIETWF7
         kZHw8uh2Lb30dY9qOnd/7nS3HjG//kX+HrRYybTms94h6qeUeHDuVo3+qEzNEVatET91
         ZmcCxme5XKDsUD7m2V7Yisp1tbWHtX0ZnxgtVI9kwGHWH7GkHra58FDGdr48WphA1XOf
         LxncHxTzzygQV2Guc5puOmYpClB1SHNw/pmxKiufIOpLPywIeMSPhZquV2OpMm948vur
         aELg==
X-Gm-Message-State: AGi0PuaJRkh6sc9qjs2k8iDI11s/RX2xb/U92nb9iuQHIkTbLnL2kCsh
        w4g5DZr9EcM3joPY1uOR3PLGCJaUUDTLkQ==
X-Google-Smtp-Source: APiQypLsLZrtVlzve3FEY5SXreoZYBhW88KG0qYYT5BpqW2oJ2LQ+9RIy+hUEyxe+l77uJ1OW7+F7A==
X-Received: by 2002:aa7:d3cb:: with SMTP id o11mr8422616edr.194.1587250288517;
        Sat, 18 Apr 2020 15:51:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:27 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/5] fs/buffer: export __clear_page_buffers
Date:   Sun, 19 Apr 2020 00:51:19 +0200
Message-Id: <20200418225123.31850-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export the function so others (such as md, btrfs and iomap) can reuse it.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/buffer.c                 | 4 ++--
 include/linux/buffer_head.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f73276d746bb..05b7489d9aa3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -123,13 +123,13 @@ void __wait_on_buffer(struct buffer_head * bh)
 }
 EXPORT_SYMBOL(__wait_on_buffer);
 
-static void
-__clear_page_buffers(struct page *page)
+void __clear_page_buffers(struct page *page)
 {
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
 	put_page(page);
 }
+EXPORT_SYMBOL(__clear_page_buffers);
 
 static void buffer_io_error(struct buffer_head *bh, char *msg)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e0b020eaf32e..735b094d89e1 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -181,6 +181,7 @@ static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 
 void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
+void __clear_page_buffers(struct page *page);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
-- 
2.17.1

