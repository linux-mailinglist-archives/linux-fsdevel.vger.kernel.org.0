Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8581B9450
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDZVuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgDZVtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3EC09B052
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n4so12440631ejs.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=;
        b=PQHhUt4QYQ2lcD4jntv56PBlw8VdGuIt0HSBR79UTYajgyZK0++h/tPZu2kqq35XIu
         VQv5xha59bI/qnB/aXKoYi6BjZIINrM77x90Cgp6DjnmaHXEsm8ljA77zdoEMfWSD+fI
         3f4bUgA12mwtiRNTtGM3Q13n5EcbuVHKwT8C2ih3iEjeaa9/d4NW/1V0gsbc1ikhBIDI
         /1LZ5Vzn6deZu3/DnXr2bR20wJJjvM+5C9qPDftdJdgSrwBaTLd+3F3ISpapRW24rpKR
         y2Lt4zcbxvN74rzniBO05POHASY5jnQlgLyAqNPyp9MtgdgEeV9UXduqimBOYxBDV6BO
         cn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EVShq73FSgP/iPd7sAu/gmu6WN22oBRzfyOsdhWlH7E=;
        b=H5JCM8Da1YpmgtTeOCc5Tyva4AezL0VvzzcYlgOBbvJCQd6ALyj3m1W7hkr2xkfmxm
         xnfFxNV6lFL4xS30gjcpo2/g6Jm8qFBVSZHQXgSzG1EXYTGAX/UyXqQHw+kZSYx2MglF
         AaamQJiXNYzI2xosIZulOP5M0eIdjVIEn/Nxv9m4l/qltjvAxpJy63Kc4fJd9ipLgqmr
         sLVuQcAhBHW8MtqwUWcq2BnH6UocJ7L/ZmSQu5T3gJ7944F8CXngTEqrP19GXTlVLXs1
         BJcz6l+EVa6uXuhJocHrj2dAine7cHGUnLb4bFhUWFy6Rp+Iytv8H8qPREVYJTvgAECq
         yNbA==
X-Gm-Message-State: AGi0PuaAUO5ufyXiwAgSmE+uW0JwCmmMAMsVWOHezTrfYoDcuJ++nx9S
        IiWdVYCU72KFUi2xUQnBSGr6ufvXMqDbZrIq
X-Google-Smtp-Source: APiQypIEBGSwt/5p1EI0EPh1JLjp11svK9dHJaYN2weAh6ctv9R1LUU52PMHSz/H21K9Jnelbw7huw==
X-Received: by 2002:a17:906:7e5a:: with SMTP id z26mr17585240ejr.168.1587937791521;
        Sun, 26 Apr 2020 14:49:51 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [RFC PATCH 5/9] f2fs: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:21 +0200
Message-Id: <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba470d5687fe..70ad8c51e0fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3051,19 +3051,12 @@ static inline void f2fs_set_page_private(struct page *page,
 	if (PagePrivate(page))
 		return;
 
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, data);
+	set_fs_page_private(page, (void *)data);
 }
 
 static inline void f2fs_clear_page_private(struct page *page)
 {
-	if (!PagePrivate(page))
-		return;
-
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
-	f2fs_put_page(page, 0);
+	clear_fs_page_private(page);
 }
 
 /*
-- 
2.17.1

