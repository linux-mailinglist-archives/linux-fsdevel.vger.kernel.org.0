Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8333BE0EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 04:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGGCjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:39:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E459C061574;
        Tue,  6 Jul 2021 19:36:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so728837pgn.4;
        Tue, 06 Jul 2021 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TB8onvnOdRzBhXcM0BQxnCfpEzao9xlhXPQShnXVkY=;
        b=g8aCcFIC4UnDaHpMFdQPMsUmGeXYoWo+7Lkht6pyNVOZdMraW2EjxneFt5ZgncJvi/
         QGmTYR58g7gFH9/ssjNR/v+fpEyf7QQL3zxlASkqwuKA9jGtXkRCzxmPyb4pKc9DZX9Y
         a+Uv5s5Ft8pxfQ1xP/pt8sAHaQ9ExEIhzSr1GSRWdoA046NSxFC5CPWGECl/JOUMRz66
         kYBd3+41pkT0HS1bhoV7JXyJYsA3jXjZD2MxpeVC79KY3/UlqhVkWDdcFVwIX31Cjqp6
         NVnd/Gg0pUzH36PoPhoIyCGGBdR8pJjJ6aQ7s9TGcLwKiCSzHvrHzcA0OzN3TP0E86bg
         +0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TB8onvnOdRzBhXcM0BQxnCfpEzao9xlhXPQShnXVkY=;
        b=UYf/xdgphhGByH/VOFYGO2Jlpy0SlakRxQqXbD0UA9KfC4kHoZFT44/7ZDu7XNofkZ
         UfaN0PwT+LKxDgP3uvaTnrxtf7fE32t2XeXe5FaskiEr/wPcmJxxylQ6pcThKEdSyep+
         /RqE/eW1IloX8tWFyEpZIocPJr6h99p3X5ZyAG51pPjOnqqbuLISwQjuk6Kn9U780wdK
         3TWq0stToKlmPLWhzgo8En9/GWBKB0mLKgvI3Fwljep6AdHaG9OrpWejCV8wwESJQnTq
         tcS3bmSxTt72nakCeVFLelAhqfQUqwXVFkW6p9NYzbZvkd61X5TjwkqRitb8OIYwuhKs
         Pavg==
X-Gm-Message-State: AOAM532oL+sBTLhRSqjh5ausP4AGuO+/49gsXhrMqNZBxzEzzzo1uFR7
        AAtwJQQT3+HTC8bADiBQZzE=
X-Google-Smtp-Source: ABdhPJz6kHl6mX2vacuql778ra9vfxn/94P2SoCpqLrH8HpAQ5Mv95lEbRrFEzJxmCKGvefAlgVxsQ==
X-Received: by 2002:a63:5616:: with SMTP id k22mr23821959pgb.211.1625625394789;
        Tue, 06 Jul 2021 19:36:34 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id r14sm20589446pgm.28.2021.07.06.19.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:36:34 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/2] fcntl: fix potential deadlock for &fasync_struct.fa_lock
Date:   Wed,  7 Jul 2021 10:35:48 +0800
Message-Id: <20210707023548.15872-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707023548.15872-1-desmondcheongzx@gmail.com>
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is an existing lock hierarchy of
&dev->event_lock --> &fasync_struct.fa_lock --> &f->f_owner.lock
from the following call chain:

  input_inject_event():
    spin_lock_irqsave(&dev->event_lock,...);
    input_handle_event():
      input_pass_values():
        input_to_handler():
          evdev_events():
            evdev_pass_values():
              spin_lock(&client->buffer_lock);
              __pass_event():
                kill_fasync():
                  kill_fasync_rcu():
                    read_lock(&fa->fa_lock);
                    send_sigio():
                      read_lock_irqsave(&fown->lock,...);

&dev->event_lock is HARDIRQ-safe, so interrupts have to be disabled
while grabbing &fasync_struct.fa_lock, otherwise we invert the lock
hierarchy. However, since kill_fasync which calls kill_fasync_rcu is
an exported symbol, it may not necessarily be called with interrupts
disabled.

As kill_fasync_rcu may be called with interrupts disabled (for
example, in the call chain above), we replace calls to
read_lock/read_unlock on &fasync_struct.fa_lock in kill_fasync_rcu
with read_lock_irqsave/read_unlock_irqrestore.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/fcntl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 262235e02c4b..fd9c895d704c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1008,13 +1008,14 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 {
 	while (fa) {
 		struct fown_struct *fown;
+		unsigned long flags;
 
 		if (fa->magic != FASYNC_MAGIC) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
 		}
-		read_lock(&fa->fa_lock);
+		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
 			fown = &fa->fa_file->f_owner;
 			/* Don't send SIGURG to processes which have not set a
@@ -1023,7 +1024,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 			if (!(sig == SIGURG && fown->signum == 0))
 				send_sigio(fown, fa->fa_fd, band);
 		}
-		read_unlock(&fa->fa_lock);
+		read_unlock_irqrestore(&fa->fa_lock, flags);
 		fa = rcu_dereference(fa->fa_next);
 	}
 }
-- 
2.25.1

