Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE614012B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 03:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhIFBWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 21:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238959AbhIFBVo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:21:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9568E610E5;
        Mon,  6 Sep 2021 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891239;
        bh=62YYar+mdw0Dk2wJcjESavjQkmC+SW+ycjRjxCHh2Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyMg2Zg1o6UtlEWBCz4tyLqxtZX88diMRcDGKWmG/duolV+D8GoVT5qILTtRDgg5k
         q+nKfDA3MioacqEZQVgYFVdlAOhItWhouhO5xN7Vdz/tZMhFWv5W97c33t9XqJNnCZ
         OSUEwftoZj6f/gz+ZoRk1LJ0VjA+tcm7bYawegfhrWRueWHdkk1Mm5KwAC2X2LTZ+/
         47ZLYI992Pz4JGkD3QZxLGs1B3eiuXd38TLJ9hX0lpGtEMpeZ1zfhm2WiMFAB8psXs
         KBDYTa7Cd4cU+lRKd+u7hKtt5mBS8WCzI23rG5lIyM1dVdE/7c1IQ57z3ygWBi1JF1
         uacj/INWslmpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 38/47] fcntl: fix potential deadlocks for &fown_struct.lock
Date:   Sun,  5 Sep 2021 21:19:42 -0400
Message-Id: <20210906011951.928679-38-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906011951.928679-1-sashal@kernel.org>
References: <20210906011951.928679-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

[ Upstream commit f671a691e299f58835d4660d642582bf0e8f6fda ]

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

Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f946bec8f1f1..932ec1e9f5bf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -150,7 +150,8 @@ void f_delown(struct file *filp)
 pid_t f_getown(struct file *filp)
 {
 	pid_t pid = 0;
-	read_lock(&filp->f_owner.lock);
+
+	read_lock_irq(&filp->f_owner.lock);
 	rcu_read_lock();
 	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
 		pid = pid_vnr(filp->f_owner.pid);
@@ -158,7 +159,7 @@ pid_t f_getown(struct file *filp)
 			pid = -pid;
 	}
 	rcu_read_unlock();
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 	return pid;
 }
 
@@ -208,7 +209,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 	struct f_owner_ex owner = {};
 	int ret = 0;
 
-	read_lock(&filp->f_owner.lock);
+	read_lock_irq(&filp->f_owner.lock);
 	rcu_read_lock();
 	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
 		owner.pid = pid_vnr(filp->f_owner.pid);
@@ -231,7 +232,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		break;
 	}
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 
 	if (!ret) {
 		ret = copy_to_user(owner_p, &owner, sizeof(owner));
@@ -249,10 +250,10 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 	uid_t src[2];
 	int err;
 
-	read_lock(&filp->f_owner.lock);
+	read_lock_irq(&filp->f_owner.lock);
 	src[0] = from_kuid(user_ns, filp->f_owner.uid);
 	src[1] = from_kuid(user_ns, filp->f_owner.euid);
-	read_unlock(&filp->f_owner.lock);
+	read_unlock_irq(&filp->f_owner.lock);
 
 	err  = put_user(src[0], &dst[0]);
 	err |= put_user(src[1], &dst[1]);
-- 
2.30.2

