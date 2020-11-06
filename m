Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD82AA0D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgKFXSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgKFXRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:51 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7DC0613D4;
        Fri,  6 Nov 2020 15:17:51 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g13so1255385qvu.1;
        Fri, 06 Nov 2020 15:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7k6fYQ9K5vRm3PXjQcfxqUpud2NB02Cs/V2CtqqpG6M=;
        b=AIIXVyDhthOlEuqc7en/uBEzaqrbD7+TQK4buBybf+OyfThOBXyRJqp8H/lk1vrqWe
         n3xSzNGuMpQcDH2Nk3Gh9YZn1v+SrGcy3Qxdu6uvf/yqPHwYOJaXztKzyNeMMv8HlxwA
         hg8tmeYIj4Kpo3jaA8UF0sJO99O5zKyf7HhzedIFcZwvx6uZSHfyMKq35jDjLXO6P/tN
         xc5qJa1D4AMd48phAZYm9yPSw5lq4UogTFg6aFGTAme846WVYyRd7ywPHQaUjTX0biYu
         xzPxL9G3tIYl9BbMZwPX4tWO0Bmhr4aVnngPZo7c9Vdpp+0bxbnqYg1ahWaJUmAGVAyG
         FRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7k6fYQ9K5vRm3PXjQcfxqUpud2NB02Cs/V2CtqqpG6M=;
        b=QtpxzzBHd3NiRgO6qcqdjm1r+fbiX84q6Uk8D/G8Wt2Y1Y4veO2gmgi3db2KXaX0+K
         gzEAPIYZCV1YC7kos+x70o8cMGAKLs9vDslNvyB+bjCZz/AnHvPx9IjG5NKy71+S1LyC
         K52lcs6L9xJGZLTraFXVtunsdmCipfM07Vr4zwLuBaUfYi9Iz0bFrcL2Rb674Td2zUq/
         ntGk5TnclrYvM/2HLzS4fZIxPgV0Vv9akTnaLRlc8lG/qnyN+U2SbmHcldOeQyT/c4rb
         ucr6hQ1wGbrubp/cbOb6rcdLLwNx7U3kJlxO37rR7HQxrROBB02s39x+L7LIK2lgxnju
         QZVg==
X-Gm-Message-State: AOAM53150LvDZeh+WmuN7WIxAjXAxPWMyAZ/zFv4NECn9CqFOoAFLACK
        IOiX3ldhP8PzdhspeZpkqU8=
X-Google-Smtp-Source: ABdhPJyGTIkUWAGtRmr2zgTP+0Zcs2Ik4PTw6YFjewy5dY/Iifjj7lFMowd+sVi3OhEVYdw6/8BReg==
X-Received: by 2002:a05:6214:c2:: with SMTP id f2mr3909399qvs.2.1604704670992;
        Fri, 06 Nov 2020 15:17:50 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:50 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 4/8] epoll: move eavail next to the list_empty_careful check
Date:   Fri,  6 Nov 2020 18:16:31 -0500
Message-Id: <20201106231635.3528496-5-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

This is a no-op change and simply to make the code more coherent.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ed9deeab2488..5226b0cb1098 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1913,6 +1913,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		if (!eavail)
 			timed_out = !schedule_hrtimeout_range(to, slack,
 							      HRTIMER_MODE_ABS);
+		__set_current_state(TASK_RUNNING);
 
 		/*
 		 * We were woken up, thus go and try to harvest some events.
@@ -1922,8 +1923,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = 1;
 	} while (0);
 
-	__set_current_state(TASK_RUNNING);
-
 	if (!list_empty_careful(&wait.entry)) {
 		write_lock_irq(&ep->lock);
 		/*
-- 
2.29.1.341.ge80a0c044ae-goog

