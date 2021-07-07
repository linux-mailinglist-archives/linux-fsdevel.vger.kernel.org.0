Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191903BE3D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 09:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhGGHrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhGGHra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:47:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D8C061574;
        Wed,  7 Jul 2021 00:44:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v7so1372448pgl.2;
        Wed, 07 Jul 2021 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm45adTul5XCFOT6dnN8MdpgDMBSy0CJdfrYkdLx/To=;
        b=JvujxPgGeFFXJLV4VgnaOvEWcqLxkTicmWjRKRE+/gZ0ubdVTZtgIKZmq+uK1FnWoP
         5hM5/DJt29vd3zVlwQ3Fg/b8bjZW7yY8JFaojBwaa8ippYF6R+yKRMu2Nq3d5zROBN1i
         wspFdCE6Yx2rEjTxOt6MdbmT8O/Na3hO2aBFBoMvVfY34bixF9G8xCfyVrNyMAiNqta4
         9z29avISjNU6YQa14gBqjdGFU1PKOvZC+m80wAc7ImbGh1Gwx/tdXvfw8Klpn0I2xAdL
         Ufatl2E7KLQH9YnFpC5nYSfLvMjfkR/M+VT1+PnbG6neS7jHpWj9VeiwyTsdybyWiqgJ
         VOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm45adTul5XCFOT6dnN8MdpgDMBSy0CJdfrYkdLx/To=;
        b=pW1Hp/Ur03OFtQMB+GfhuEwfn/D9Ym9sivSIDbKpLfVbYRtre6IS8uJOZxAo+lZXAS
         oFRxmxuXdLSEpil06WbqqDhf6GXywBSaSn28wpdo/T+Y2Vgd4q/Xbfk2+bivS8mSfxE6
         0Jk3JmbZJoV3GtKR/wDnibhF8xii3oa0QVFsEp5CsjUvEiGU7nv2AJsG3PWGipwNAb2K
         io2iPpsP21zv/+DMtZfliGXOGvs+4TxkaR7OEqLvQBhxl3teQnWvrITDZ8yZ0OMJCMQc
         rxmSquzhgMHrAsTUJ4MLZKaPJif08wssWqzGuAaioVi4aVo3Uez9qgh0hnHr0QmCgFI6
         EdHA==
X-Gm-Message-State: AOAM531jA5pf1anj0UFllHvUUJcsTGvQDqpZ1xg3H28jiF800nBEDwnp
        B9V9EjEBEr6Q9rfJRBVObnI=
X-Google-Smtp-Source: ABdhPJwYGdokAkXQH3vmrjVB/CtZ9xYKAxLxHg0OD36CEeiocCeU/Lkf+IgxyWmTmuyy5GHnX8U0qQ==
X-Received: by 2002:aa7:8218:0:b029:316:88e:2a3a with SMTP id k24-20020aa782180000b0290316088e2a3amr24021518pfi.16.1625643889487;
        Wed, 07 Jul 2021 00:44:49 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id x39sm12958519pfu.81.2021.07.07.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 00:44:49 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 2/2] fcntl: fix potential deadlock for &fasync_struct.fa_lock
Date:   Wed,  7 Jul 2021 15:44:01 +0800
Message-Id: <20210707074401.447952-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707074401.447952-1-desmondcheongzx@gmail.com>
References: <20210707074401.447952-1-desmondcheongzx@gmail.com>
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
index cf9e81dfa615..887db4918a89 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1004,13 +1004,14 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
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
@@ -1019,7 +1020,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
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

