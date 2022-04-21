Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA7F50AC53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381767AbiDUXv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442787AbiDUXvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98042EF1;
        Thu, 21 Apr 2022 16:48:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c1so4878901qvl.3;
        Thu, 21 Apr 2022 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE94/Kbz0iYkWqSiwiZXgkxJUhacoUay8DsU/fM4rGc=;
        b=O+Cm9zSSCAsfuY1cv1uyHWIfLd6AHQdXHkxkvQ1owHl1q4ed7gdNQPhDpX5U39ujmv
         yxHn/O7exq1vCm2R4Di+f5GdGcazARxVpYR+LbOz/om50ZJUiuhNwSe/W6O8i7ARpSGQ
         sY60BVfp3B8pLDaUfDS918qDgPQvki6XTXv1SXJUne0mHecVCvAkhP5SeB7Jl11anPcV
         tOw2oSITm50Hq0EvbwOmG5qp2GC/7aihcvhgAY7xt6OtbutHsyMm6T/DKNO72WWyzLXb
         2+dFGD2ybpnAYizCWKXrnWd+g1rkN8/gCfZSr+xRjYSlsTPkWNm/Ms8qB1RnC85iuZTd
         JJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE94/Kbz0iYkWqSiwiZXgkxJUhacoUay8DsU/fM4rGc=;
        b=kI9ve79GTJP9TH4fUIhtIe5rbWwpMg09m529I99NoFP92ggHBzvgDOFdVLW//LyuSI
         QQv/t3PTRFkcr2a0HrW+0ff+qZW8srkY6nuZ5PLLCEGSUgTQDBZM/OKrAHQ1ofdWaI6r
         wcFXc3c7PZ48sI+5BMBe9n///RV1ohx0dcB5h843+WoRG9Zz93zGTlRf3kkqislbh3d2
         zZJ0w82kE+jRoeJtoMgmaSnIk64vU7RrdTEhzPDqNdoNKkJepVrpK7liw8R+Z2N4SKQA
         U6th1P+TpRPJfkHwutHbSGJHlhSpvHu6PkLrxzx9KGreOpxF6nKQT6ibVYxAXOfig0FU
         Wnsw==
X-Gm-Message-State: AOAM530O4wDXdsjvYsqWJBZr4jAsjkAj9W0VTNP7flGuK6RKE8FdE/pJ
        6z2PM2nMyyhnOLHBIBHC5wMkcVnVpzjD
X-Google-Smtp-Source: ABdhPJy1Vx4dCLoAejscY+AlE0uvjsIV8mL4rJ+39tNdmbaMB3K37JbaK9DmVM8bGfz4EduxkZW3sw==
X-Received: by 2002:a05:6214:c85:b0:441:2b1c:dd46 with SMTP id r5-20020a0562140c8500b004412b1cdd46mr1437161qvr.41.1650584934575;
        Thu, 21 Apr 2022 16:48:54 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:53 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 2/8] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Thu, 21 Apr 2022 19:48:31 -0400
Message-Id: <20220421234837.3629927-8-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

seq_buf is being deprecated, this converts to printbuf which is similar
but heap allocates the string buffer.

This means we have to consider memory allocation context & failure: Here
we're in device initialization so GFP_KERNEL should be fine, and also as
we're in device initialization returning -ENOMEM is fine.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/input/joystick/analog.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3088c5b829..72e1e30d19 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -19,7 +19,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/jiffies.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/timex.h>
 #include <linux/timekeeping.h>
 
@@ -337,26 +337,32 @@ static void analog_calibrate_timer(struct analog_port *port)
  * analog_name() constructs a name for an analog joystick.
  */
 
-static void analog_name(struct analog *analog)
+static int analog_name(struct analog *analog)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF;
+	int ret = 0;
 
-	seq_buf_init(&s, analog->name, sizeof(analog->name));
-	seq_buf_printf(&s, "Analog %d-axis %d-button",
-		 hweight8(analog->mask & ANALOG_AXES_STD),
-		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
-		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
+	pr_buf(&buf, "Analog %d-axis %d-button",
+	       hweight8(analog->mask & ANALOG_AXES_STD),
+	       hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
+	       hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		seq_buf_printf(&s, " %d-hat",
-			       hweight16(analog->mask & ANALOG_HATS_ALL));
+		pr_buf(&buf, " %d-hat",
+		       hweight16(analog->mask & ANALOG_HATS_ALL));
 
 	if (analog->mask & ANALOG_HAT_FCS)
-		seq_buf_printf(&s, " FCS");
+		pr_buf(&buf, " FCS");
 	if (analog->mask & ANALOG_ANY_CHF)
-		seq_buf_printf(&s, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
+		pr_buf(&buf, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
 
-	seq_buf_printf(&s, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+	pr_buf(&buf, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+
+	ret = buf.allocation_failure ? -ENOMEM : 0;
+	if (!ret)
+		strlcpy(analog->name, buf.buf, sizeof(analog->name));
+	printbuf_exit(&buf);
+	return ret;
 }
 
 /*
@@ -369,7 +375,10 @@ static int analog_init_device(struct analog_port *port, struct analog *analog, i
 	int i, j, t, v, w, x, y, z;
 	int error;
 
-	analog_name(analog);
+	error = analog_name(analog);
+	if (error)
+		return error;
+
 	snprintf(analog->phys, sizeof(analog->phys),
 		 "%s/input%d", port->gameport->phys, index);
 	analog->buttons = (analog->mask & ANALOG_GAMEPAD) ? analog_pad_btn : analog_joy_btn;
-- 
2.35.2

