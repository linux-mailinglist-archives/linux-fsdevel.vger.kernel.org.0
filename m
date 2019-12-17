Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97A122FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLQPLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 10:11:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36465 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLQPLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:11:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6239437pll.3;
        Tue, 17 Dec 2019 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aFantIhWi/fHJq2cr+Zbx6RZiqepAGB6P0r03ViBSsA=;
        b=QYJDZjza4evSS+x1Jb5cMJ3wbCTfcsYUKvfvznRoIgd8u+cAB3f1FHmgKHBqGccifv
         +hKsPzcBU+bQqytO2u0gvTtuT0Sq+PxFJ6fj3EwiBfQEN1Go7jVFTSkFJNX0zmeV2pLc
         +IGcG66ao0ZcAZ7qA/Z0QYrPbgyfyfXCwOj+xnGlM3qD8eLFIAffik0xOL/QrNWWY8Kc
         1q1Nmx7ZhN2DBdmGfpvcPxhtW5fS3vy/+TTNOTq99n015kp8dPLbArir2wbacyiJ5mFv
         AYUmkn7iXb/JcIZypbB9kLU5+GgYc1BrbUx4Kf2i7advrCV54BZfKmyO5j6O1UF7vsvi
         5mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFantIhWi/fHJq2cr+Zbx6RZiqepAGB6P0r03ViBSsA=;
        b=ZyvuYzWgDUKvXyJLVVYlHd/YXSqtuDp9WJVX+9wAtW4aj4sYCYaaeiihh0CvXsI6CY
         +dfEXOyc6V8U+4mFc6W6U7Ke+VGWn4Cc4QvjnesZrfo8T+BGCDuyXG9PTsJEbRwF/bqD
         eQKQ2CwqjiUMr+tCXjQfhE8c8JNHpD6Ks/rqY6FnT2CzSoZ514X2nRtGNWtAlT03sJkJ
         UO7aDyZct526RXuEF8iJsZ2kFM1n3LzPKg22uU//WjqZd8jbi7TCAeTHJxipieHgpIDf
         +537npA4QmVxM8gxhy6gUAqtZ8eipTuu3IY43gJ4DJJR18D5VSi3257hLmcHgVusBf/s
         MA6Q==
X-Gm-Message-State: APjAAAV0+ANZB+fMkX92aFB26dLdj47bYcka1cJO7MVLF9egmIZlxX8v
        QqNWorK4fGVD2FS3aAuEBpE=
X-Google-Smtp-Source: APXvYqwtYKpcn252vIXVA4HxmqgaVwlB9/YwzBUU2SU/SIyHMiI2r3UDySrZNyEa2AryZHkv2By44Q==
X-Received: by 2002:a17:902:6a8a:: with SMTP id n10mr23659556plk.9.1576595478158;
        Tue, 17 Dec 2019 07:11:18 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id m3sm26507128pgp.32.2019.12.17.07.11.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 07:11:17 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [RESEND PATCH] fput: Use unbound workqueue for scheduling delayed fput works
Date:   Tue, 17 Dec 2019 23:11:12 +0800
Message-Id: <1576595472-27341-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a potential starvation that the number of delayed fput works
increase rapidly if task exit storm or fs unmount issue happens.

Since the delayed fput works are expected to be executed as soon as
possible. The commonly accepted wisdom that the measurements of scheduling
works via the unbound workqueue show lowered worst-case latency responses
of up to 5x over bound workqueue.

Work items queued to an unbound wq are not bound to any specific CPU, not
concurrency managed. All queued works are executed immediately as long as
max_active limit is not reached and resources are available.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/file_table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 30d55c9..472ad92 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -348,7 +348,8 @@ void fput_many(struct file *file, unsigned int refs)
 		}
 
 		if (llist_add(&file->f_u.fu_llist, &delayed_fput_list))
-			schedule_delayed_work(&delayed_fput_work, 1);
+			queue_delayed_work(system_unbound_wq,
+					&delayed_fput_work, 1);
 	}
 }
 
-- 
1.9.1

