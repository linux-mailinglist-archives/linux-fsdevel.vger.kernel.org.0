Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7EA3BC9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbfFJTO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38645 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbfFJTOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:44 -0400
Received: by mail-ua1-f65.google.com with SMTP id j2so3529399uaq.5;
        Mon, 10 Jun 2019 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckddRdKuY3n99DQ30I8Ucr4dD4i/wMlRy1QE1lcEpe0=;
        b=BdyAt9kKhE85l9YnxOxtZEV5ZNunxZzUaVFn/32oWTDCrze5pjJ7U9L53aXthrLGOy
         Lk51+I5TuZ5DmVk8+LXBzrN7h8fzZ9zKOMcL/d0LUc6aIvI2+FHKN+g+5//Rjh6BF2tK
         ckVeJfDgPIfikX7h64HDovPUq5ypZm7x6dqRUqYkuGOz53QhmE2KwSCvTWaWdpHzYc8b
         hMs213eb/Vi6vF+XJwc7hKWvHAYWIMZeEFnI+3vzVhRtr2DhnR0YBtnaNmhKJimfggnQ
         FL6xVr8XOdlQHZfcGMJD9hlzW43eULL3dLlXhl8f0gYn7bDonk8+U2D1vWIceEHLb5PR
         1dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckddRdKuY3n99DQ30I8Ucr4dD4i/wMlRy1QE1lcEpe0=;
        b=ZdEnkOtNlY9hWRvoz1W8ZXG6qvBPW23pbJ+9stAXZPJb2YNZSL12zNTtfEc5qSflXn
         SQyRiOr04glsZgZpiPyB3GZOUsANkIT31pbq/5Du5HNRt5cqajS/BjAOLD6jCVDJ+KME
         bvAt29noj87VDBevtOoRUhgkOV5my0Uhe+3bjfpFXZsFzyqbEE2Chg2dQNn2V2CSA3nP
         4OD622uQAiwm8di4Z+eD+2NNOOwQqRNfI+Z/UMEctGlCcfIbFaIK/Gl00CybYwr8QdBL
         gf4QGdtWmXTWB2VnOBzt8DwwGbjcNhdGge08A2WS6DFDT/2bjRoKiStCGmh7KpGTUl/S
         uaMA==
X-Gm-Message-State: APjAAAWl2Ju5duHBERS2XIVMa6NxlOyQfkUnlgKA97RyVzZUrwsVEpkz
        l6uHeOaDbJ9lA1eSHNHazrg9H0JigQ==
X-Google-Smtp-Source: APXvYqy9Ha5IMQid3VUAn6+bt6stjC+0pzI9SwfLubGHSWXn5aqbz4Jmg0Z0iQimvpw2aRpxt808Jg==
X-Received: by 2002:a9f:21e7:: with SMTP id 94mr7564002uac.137.1560194083552;
        Mon, 10 Jun 2019 12:14:43 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:42 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 11/12] closures: closure_wait_event()
Date:   Mon, 10 Jun 2019 15:14:19 -0400
Message-Id: <20190610191420.27007-12-kent.overstreet@gmail.com>
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
 include/linux/closure.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 308e38028c..abacb91c35 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -379,4 +379,26 @@ static inline void closure_call(struct closure *cl, closure_fn fn,
 	continue_at_nobarrier(cl, fn, wq);
 }
 
+#define __closure_wait_event(waitlist, _cond)				\
+do {									\
+	struct closure cl;						\
+									\
+	closure_init_stack(&cl);					\
+									\
+	while (1) {							\
+		closure_wait(waitlist, &cl);				\
+		if (_cond)						\
+			break;						\
+		closure_sync(&cl);					\
+	}								\
+	closure_wake_up(waitlist);					\
+	closure_sync(&cl);						\
+} while (0)
+
+#define closure_wait_event(waitlist, _cond)				\
+do {									\
+	if (!(_cond))							\
+		__closure_wait_event(waitlist, _cond);			\
+} while (0)
+
 #endif /* _LINUX_CLOSURE_H */
-- 
2.20.1

