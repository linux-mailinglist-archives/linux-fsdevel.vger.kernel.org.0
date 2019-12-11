Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD811A1A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 03:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLKCvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 21:51:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLKCvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:51:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so792198plk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 18:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aFantIhWi/fHJq2cr+Zbx6RZiqepAGB6P0r03ViBSsA=;
        b=GAMJmgcdPRJaFN1T1e36nnOuQFZGcwkOKTOPJ+AV1KYRAlWOM7pKnGTDznLkT5RtT7
         lyyWgBqUU3vzmfe1Ut03vTcKtqA5RhljYFtJ+vdn517mI14K176a3Po0q+CRLBY/73rQ
         NoLN6miAKmRLRLGA5QipTa+p1NZmhdB+yvask5dzXmpCUsFnM1o4y8wRB4QT1oETumU1
         vZ1KrmL5nDssJ3wbfolSp+jLTh81zf26jfyMME9INEU7aQjcXR/QAEXGPnOYtvdXj0Rk
         cP6tkECPRa/z7TBPVFJGwUxmJQwYG5yBhNpHE61IZMORvDhfmLnav4U5EZLCpLpwnO1D
         cWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFantIhWi/fHJq2cr+Zbx6RZiqepAGB6P0r03ViBSsA=;
        b=d/6Yuw1r87KB+BUKOog3GnTQkJ28IeljpLQw+UFy2t6h98BhFoMOZUX983IxP/zp8m
         GUGKg/EszQ/uhcy0Tug7TNWN1D7iMcR6a+Ud2aH0U2xziavJNb6RAedNQQims/rci3nA
         rbkVbf2n53nhQp43pey8mI56eAfYL13K5tzGgj22VPZTof5s/SujUundbA9LvBiNJQQW
         rjHUUXtMzt0k6u+QDDoIMv8L7u75Ic7C5IDI0M7pZP/HBTf6DwZAfavciwfw1yLxP7u8
         0vdU2fI7j0XDxriYUO96Lf5pJDpo57N5cRhpBaWtDvZeIwl5eVko25B9aKqVtRBA5bJQ
         VTLw==
X-Gm-Message-State: APjAAAUycHR5M1IKjoxAJPwOTpKneVZYxZLJbWZvk/0sQON5LUFWVdwK
        naDJcvqZhoif5CHUJM6JMdw=
X-Google-Smtp-Source: APXvYqxmil5UzeokcyLmnUyxNdx/7lg1uv3PG7vaRskUy36iDDKbb0c4YNLiOSk7qJZhfB6T48ZLOQ==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17mr777497plp.96.1576032671491;
        Tue, 10 Dec 2019 18:51:11 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g22sm363836pgk.85.2019.12.10.18.51.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 18:51:10 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v1] fput: Use unbound workqueue for scheduling delayed fput works
Date:   Wed, 11 Dec 2019 10:51:05 +0800
Message-Id: <1576032665-10366-1-git-send-email-qiwuchen55@gmail.com>
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

