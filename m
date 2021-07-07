Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEB3BE0E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 04:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGGCjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 22:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:39:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A81AC061760;
        Tue,  6 Jul 2021 19:36:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s13so224628plg.12;
        Tue, 06 Jul 2021 19:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56B++SYcNkGDLySJ62AZWIU2HnskBoJwEPVYnQNmO+k=;
        b=GKET/NY1Nx2Y5xu+oDqx0/TbbJiMtBTMgoBUSBbsMBHh9ds59E661pkGTnSp7zFS+j
         km54h2aSpXdZOjEWrlVBj1sC94cDVYW3MfTckbHWXhW1aWUEvSWZ73msF5FPwXv0Y5Gx
         yPfV8xYFMV5aeQb31xdtXeylWm+7PCDoQS1gh9pgdwpAZch4pJeAapTLu7w/tg2VMO5E
         OplE+SaYd9ZbzUBqDL/Bdtg0hdADpRJRHN9qYk9P56chRIKr1bVrYpeua826UXZBreBE
         hG0T5Yg5d8D2MTVSJBRMpjUFU8uru4qhvDa8P4nPzrDesmk5jtP9m5wnFx0MYfZTZ7d2
         cdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56B++SYcNkGDLySJ62AZWIU2HnskBoJwEPVYnQNmO+k=;
        b=KfexMjeypb3nfMa+4y9qi8/Z/NSz4tzzbmo/5UzEyEpC0LHkaqCEVLpe70ZoSCW1CG
         wm6rRd2orS7DhM3KhiQaD3y2cnJ5Wp/RaBmmSbTHcw4i0IjZJHjXW8bg5GMp0w2bETzz
         czWsnXa4Z9qeGUIaFiS+K4Cuv0bWwaD1D4zXrdNyRM8Fehvm+kfMxBX81G7w4IT8vYaV
         OyFNrh1+5MOW1BRYkJPcQAZXv3IxLFFMTP7kUw5/nDmD3IkXztKYen8ZXkpiml2tAzmf
         sZTxtGrcBbCj+RizhvFQXPEOzorClYIV1cuX+CxBdXflsinmNzUhc+DOvv/fwR1zCw1A
         HbSA==
X-Gm-Message-State: AOAM531CQR6PfNql79TgqI6/DtXUOt0yCuY5wMiMEMbblOiZ6nwsPR+D
        UCttjZmntvrkPp8m5FK+nZc=
X-Google-Smtp-Source: ABdhPJx91RGsxB/41s0UAlUUMFfVC1qmfXCDkYuvwC8M76HoaZ3YwNp9zJJkMJ8Ghg0pyrj39cUb3A==
X-Received: by 2002:a17:902:d213:b029:127:9520:7649 with SMTP id t19-20020a170902d213b029012795207649mr19497260ply.10.1625625390833;
        Tue, 06 Jul 2021 19:36:30 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id r14sm20589446pgm.28.2021.07.06.19.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:36:30 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] fcntl: fix potential deadlocks for &fown_struct.lock
Date:   Wed,  7 Jul 2021 10:35:47 +0800
Message-Id: <20210707023548.15872-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707023548.15872-1-desmondcheongzx@gmail.com>
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzbot reports a potential deadlock in do_fcntl:

========================================================
WARNING: possible irq lock inversion dependency detected
5.12.0-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor132/8391 just changed the state of lock:
ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:211 [inline]
ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8b4/0x1200 fs/fcntl.c:395
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&dev->event_lock){-...}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
Chain exists of:
  &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&f->f_owner.lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

This happens because there is a lock hierarchy of
&dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
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

However, since &dev->event_lock is HARDIRQ-safe, interrupts have to be
disabled while grabbing &f->f_owner.lock, otherwise we invert the lock
hierarchy.

Hence, we replace calls to read_lock/read_unlock on &f->f_owner.lock,
with read_lock_irq/read_unlock_irq.

Here read_lock_irq/read_unlock_irq should be safe to use because the
functions f_getown_ex and f_getowner_uids are only called from
do_fcntl, and f_getown is only called from do_fnctl and
sock_ioctl. do_fnctl itself is only called from syscalls.

For sock_ioctl, the chain is
  compat_sock_ioctl():
    compat_sock_ioctl_trans():
      sock_ioctl()

And interrupts are not disabled on either path. We assert this
assumption with WARN_ON_ONCE(irqs_disabled()). This check is also
inserted into another use of write_lock_irq in f_modown.

Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/fcntl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index dfc72f15be7f..262235e02c4b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -88,6 +88,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
                      int force)
 {
+	WARN_ON_ONCE(irqs_disabled());
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
 		put_pid(filp->f_owner.pid);
@@ -150,7 +151,9 @@ void f_delown(struct file *filp)
 pid_t f_getown(struct file *filp)
 {
 	pid_t pid = 0;
-	read_lock(&filp->f_owner.lock);
+
+	WARN_ON_ONCE(irqs_disabled());
+	read_lock_irq(&filp->f_owner.lock);
 	rcu_read_lock();
 	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
 		pid = pid_vnr(filp->f_owner.pid);
@@ -158,7 +161,7 @@ pid_t f_getown(struct file *filp)
 			pid = -pid;
 	}
 	rcu_read_unlock();
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 	return pid;
 }
 
@@ -208,7 +211,8 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 	struct f_owner_ex owner = {};
 	int ret = 0;
 
-	read_lock(&filp->f_owner.lock);
+	WARN_ON_ONCE(irqs_disabled());
+	read_lock_irq(&filp->f_owner.lock);
 	rcu_read_lock();
 	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
 		owner.pid = pid_vnr(filp->f_owner.pid);
@@ -231,7 +235,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		break;
 	}
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 
 	if (!ret) {
 		ret = copy_to_user(owner_p, &owner, sizeof(owner));
@@ -249,10 +253,11 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 	uid_t src[2];
 	int err;
 
-	read_lock(&filp->f_owner.lock);
+	WARN_ON_ONCE(irqs_disabled());
+	read_lock_irq(&filp->f_owner.lock);
 	src[0] = from_kuid(user_ns, filp->f_owner.uid);
 	src[1] = from_kuid(user_ns, filp->f_owner.euid);
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 
 	err  = put_user(src[0], &dst[0]);
 	err |= put_user(src[1], &dst[1]);
-- 
2.25.1

