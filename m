Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09A3BC95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbfFJTOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:42 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41869 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389290AbfFJTOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:41 -0400
Received: by mail-ua1-f65.google.com with SMTP id n2so3525329uad.8;
        Mon, 10 Jun 2019 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3U3sA7JK4Wx4xJS71wfGXZ4KSvEZtwk1XyQ4suCC7B8=;
        b=BoFQLMwXN/UZRVJyQluQO+IOXl42mInR39LPWD30FsUVUbwEcOlNCwBRSs675vWfTp
         nDqqZC1kbJ5x4khJxDiawgPzJ5IcAGNh1tPH2eugTRlOKxMFBm3LjVwZKYadSI/l/qWa
         0YP0ZfnQClFEIDjaqch6oLsjPXAWHQx3LovF86tLYwakeGuSfkV6h3h1DRFLr2qfNIWr
         HQigF/Ymtnn8lCCeTJXeLY/TAhQxJJ3VOPEallbf+zk3hBFBgj9N38eBPUVnb4C1sgkK
         APKy17dJTO2PC8mMUr8vpM34yPNj8ugLwG9vVxthcoEXlLID1am+Z6isAI3lhI6/lmFh
         pb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3U3sA7JK4Wx4xJS71wfGXZ4KSvEZtwk1XyQ4suCC7B8=;
        b=cyXAi90wfIVRqHjQ/iVqGtjI8uY/cpGGUOGxsYC+EtVeI8qiU9IYoE3x1FLF7D7c4v
         ZBs+OAMejVeM4y6uLAlLqTEzeGRLdhA+shsC7Xbo7CCM5+sWNs2yMMmGh8E1iFLqzQpq
         T7CWpUsrt5FKw47K/xLvZXBmqKHsQOmPn0WFzm7WSb+WIB1O60LOPX4Kp40cg7aGpCph
         gu9jgNk2pIjmdtN2AsRNrn6DvIB4/X+p3ypYgxRGDsw/FzBFjBnTlWTWeffpKSOaQ98z
         83PoXr7jGX9EbUFPnQYHDePfLMG8VGTh//dWpmNbidtpxNUX7U2xImwdBRPZUatKTZqa
         R18w==
X-Gm-Message-State: APjAAAX995cWUtUnIWsmA4/b345sq7AXZwlLzl8MMM6HslJxoYKrvzXM
        tAZ7N9HBQIEetlfpFVvKf0/KBaj4rA==
X-Google-Smtp-Source: APXvYqz+UI+IwkgjNqvo1opaGdx3Xa36p3YJ2cGddzfl+1CV+RI8VIKQc3zO5YmWny0ZbpULl+VSpQ==
X-Received: by 2002:ab0:2c09:: with SMTP id l9mr5860205uar.6.1560194080267;
        Mon, 10 Jun 2019 12:14:40 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:39 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 09/12] bcache: optimize continue_at_nobarrier()
Date:   Mon, 10 Jun 2019 15:14:17 -0400
Message-Id: <20190610191420.27007-10-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/closure.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index c88cdc4ae4..376c5e659c 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -245,7 +245,7 @@ static inline void closure_queue(struct closure *cl)
 		     != offsetof(struct work_struct, func));
 	if (wq) {
 		INIT_WORK(&cl->work, cl->work.func);
-		BUG_ON(!queue_work(wq, &cl->work));
+		queue_work(wq, &cl->work);
 	} else
 		cl->fn(cl);
 }
@@ -340,8 +340,13 @@ do {									\
  */
 #define continue_at_nobarrier(_cl, _fn, _wq)				\
 do {									\
-	set_closure_fn(_cl, _fn, _wq);					\
-	closure_queue(_cl);						\
+	closure_set_ip(_cl);						\
+	if (_wq) {							\
+		INIT_WORK(&(_cl)->work, (void *) _fn);			\
+		queue_work((_wq), &(_cl)->work);			\
+	} else {							\
+		(_fn)(_cl);						\
+	}								\
 } while (0)
 
 /**
-- 
2.20.1

