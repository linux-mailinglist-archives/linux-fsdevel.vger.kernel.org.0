Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D251C09B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgD3Vwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgD3Vwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7BC08E934
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w2so5810488edx.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVC4XtCI51zwuXU4kfWUPmx3mXCoCkfv76JEys4qRWI=;
        b=h2hh4ukdjcrj1rKmeKUhGkIVIjVb+CMDuH/sGucO7vCFGioyAXpgts7c4azzs0Gv7I
         wrrOrJwzU58JHtDYO/oOtVLQCBlpEQUKurGOOWp5RON/lTp6xfIclss2781r6FT2zQjS
         waJNn4vy45DkGKi2F57eOjNlloFB9D2TGMAF2DfeQd8ohuFn2EMA9lBw3MtHlItasTn9
         wOTEDBE7MleC0ix9SqqkvpZrZ1sgdUaF2T+Av7FJzZBBcKhUcdAmdu9JJMmDy91e2g+Z
         LF1NGTxFVnN7PPxwmfknLpvMMpUf8O1hq9o353eJlvR73KIYEeo13Rl69tHDdOm7Bj85
         8f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVC4XtCI51zwuXU4kfWUPmx3mXCoCkfv76JEys4qRWI=;
        b=FqsSJt8vBzyXylRntP+IOD/SnKR66BFZx1WpTQDvOhg94MByCsVsvt0gkKVayFQWPM
         ah5ig+9f11rSXuD9nsIFV8KPZmGzgkRHwOlpjKF1UIYledWNJwuk9n6qZuolM1xRJwLJ
         DDUsFqDdG3AbmNMzqVnpx7uWyQPJ5/AVEueXgORtk8JHhSMQMMwZUhiqStEUSYEzZIIH
         tQvmDYmRDl+y2KZfqYK+9XtsAG4cqdwfFMkHK2Jygukwu0k19BPj+OmGE27Z2o67Q/8c
         HxDRJejJZZMMzEazMC5pdw0rt0HqfTfBGZWIrwWRFkphiquRzaCOG3hpZ7/tMn3lJlgk
         vDyw==
X-Gm-Message-State: AGi0PubkiDRgWsMtgqjWy2+O2Q/kbsm+wDDBFeLsKIMdY8zwezmupcFF
        cs6wH3wCKkceND3tnGfFa9j8woHzUZXxLA==
X-Google-Smtp-Source: APiQypLipNJe1CcB6DTPAa4UTwx9mH+5ihqyAcGLs5v0DbpMIgL9Cfj+7fXuU233MI38OzTIhsROgw==
X-Received: by 2002:aa7:d481:: with SMTP id b1mr1073575edr.226.1588283565949;
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH V2 9/9] buffer_head.h: remove attach_page_buffers
Date:   Thu, 30 Apr 2020 23:44:50 +0200
Message-Id: <20200430214450.10662-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the callers have replaced attach_page_buffers with the new function
attach_page_private, so remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/buffer_head.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 15b765a181b8..22fb11e2d2e0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -272,14 +272,6 @@ void buffer_init(void);
  * inline definitions
  */
 
-static inline void attach_page_buffers(struct page *page,
-		struct buffer_head *head)
-{
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)head);
-}
-
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
-- 
2.17.1

