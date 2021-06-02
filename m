Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75B398479
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhFBIst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhFBIss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:48:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48629C061574;
        Wed,  2 Jun 2021 01:47:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s14so756886pfd.9;
        Wed, 02 Jun 2021 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kkIsnNFmAvlWdtRxA1m3c5iZTCBb3ZA5Lqe6EMHkpxY=;
        b=mRxWcKMF/6JU6Ihk2bST67XkUKE0aiizvyrVzfGNgiIEdOGkbMvIEfZwHYlyYddsH1
         avUKEmgMQMu1ZvGAYMDCCHxjZiVqpetkabOBa6Lf4+9aTr5U0KwBQdlGQ/xVQGsqqgXB
         TXm+KCw///2OsciA56qIZw+uYRbMubImpPdqLFcLNlsRwb4VdzDBKHgMhv2BkPvh7AlM
         qj3TNx6tRVUxNIg3QaSPa+FwroXHCzAMo6K5eP0A24IaWlFPa3KT93gknvbPBW4EglHw
         V1K6UZ5NtxTExQ+9vz9+SX0aHGRkANNB0o1BDEhVX2gvzpqQrTh0lOOMXWt/6C3Y0SGL
         AtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kkIsnNFmAvlWdtRxA1m3c5iZTCBb3ZA5Lqe6EMHkpxY=;
        b=GVU1O8yFiKV8gAyeLI266r17V7oPw06nxpIX3iFXVq82rIYHEanp7nwBv+Wy7+m2qW
         HYEApw8QSUnNy3sUSv0Z4CX1D7yT+xmafQczHXSH3tLdqh9FF0TlX/ieYqyZtz8FnMxN
         1HG8CIJHzjO9K4AGitmng6HlBCB24J9AWIs/tciay5Q+0LJ4NnWwI8vAXmD3cKvqY2iJ
         vvpnS2wf1pspsRNAWKdzFyWiicaPpE1A48G/BQ8cNVaGIStEFvQvFXu1NYuUn2Ucj6hO
         Dai3d3QvBxvhTf/ED9ykcj2gVHhr9ZydRi9WfrnN2blOy7D74f+uZJ9HLyK7QMgQUl5r
         VKNw==
X-Gm-Message-State: AOAM531UZFLAVFG4vMv1JpDcIMj0vah2KTovUnpExgJt9dsgT6EuHcUh
        XnI0ViLuu5YlJ26ZBVS+HEg=
X-Google-Smtp-Source: ABdhPJwwrrlvCSlIIYzIzTPcIYDzUY/PLIu8Es9yYsCdYPiSxMQeC92gn2TwiG+TUex+1JuDcOb0fQ==
X-Received: by 2002:aa7:9188:0:b029:2d8:96df:8dec with SMTP id x8-20020aa791880000b02902d896df8decmr26122043pfa.8.1622623624777;
        Wed, 02 Jun 2021 01:47:04 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([151.248.69.100])
        by smtp.gmail.com with ESMTPSA id i10sm10473970pfk.74.2021.06.02.01.47.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:47:04 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH] fs/epoll: Simplify error case
Date:   Wed,  2 Jun 2021 16:46:49 +0800
Message-Id: <1622623609-7394-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is only one failure case, so there is no need
to use goto statements and define error.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 fs/eventpoll.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1e596e1..b53f263 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -928,15 +928,15 @@ void eventpoll_release_file(struct file *file)
 
 static int ep_alloc(struct eventpoll **pep)
 {
-	int error;
 	struct user_struct *user;
 	struct eventpoll *ep;
 
 	user = get_current_user();
-	error = -ENOMEM;
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
-	if (unlikely(!ep))
-		goto free_uid;
+	if (unlikely(!ep)) {
+		free_uid(user);
+		return -ENOMEM;
+	}
 
 	mutex_init(&ep->mtx);
 	rwlock_init(&ep->lock);
@@ -950,10 +950,6 @@ static int ep_alloc(struct eventpoll **pep)
 	*pep = ep;
 
 	return 0;
-
-free_uid:
-	free_uid(user);
-	return error;
 }
 
 /*
-- 
2.7.4

