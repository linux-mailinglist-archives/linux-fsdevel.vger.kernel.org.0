Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967DB2E1704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 04:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgLWDFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 22:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgLWCTN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:19:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 456F622A83;
        Wed, 23 Dec 2020 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689913;
        bh=s8xvwIHiB3yfvpHTfpYs8sG2KAGOIsQE/riBO1EdJxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VItxIoCIEUbWc2ae6JyQ5MBAn6siFygLd7XkZVMRvAl194dsjl2mq+0/X+oeRBE8S
         d8Viqm+QOCyh3uwmnGK+Bc7L3lNOmiWhV5fnwa9gqelqFOFYdKhzNuphfUVQ3EgI+I
         0eLeVs+DzGeX/JbhfG2WYvauWBmuEyYg5f0KmI77kX/qeX7Tu+U7zoLk8dA7URLlR4
         L3753edhzampsE7Cjf0Qlb8B8FGmRQjJpNdUxSV0bfpbieBVTGlTaDMBcYTnbNYVkb
         s/tyAKoaZcdEQjk101wXKD8hK9fUoH+UdNbOnNa9VqGsDUqrPdeCz3a/S4azTgOTGt
         dRPNev6xfSgzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com,
        syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 014/130] fcntl: Fix potential deadlock in send_sig{io, urg}()
Date:   Tue, 22 Dec 2020 21:16:17 -0500
Message-Id: <20201223021813.2791612-14-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

[ Upstream commit 8d1ddb5e79374fb277985a6b3faa2ed8631c5b4c ]

Syzbot reports a potential deadlock found by the newly added recursive
read deadlock detection in lockdep:

[...] ========================================================
[...] WARNING: possible irq lock inversion dependency detected
[...] 5.9.0-rc2-syzkaller #0 Not tainted
[...] --------------------------------------------------------
[...] syz-executor.1/10214 just changed the state of lock:
[...] ffff88811f506338 (&f->f_owner.lock){.+..}-{2:2}, at: send_sigurg+0x1d/0x200
[...] but this lock was taken by another, HARDIRQ-safe lock in the past:
[...]  (&dev->event_lock){-...}-{2:2}
[...]
[...]
[...] and interrupts could create inverse lock ordering between them.
[...]
[...]
[...] other info that might help us debug this:
[...] Chain exists of:
[...]   &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
[...]
[...]  Possible interrupt unsafe locking scenario:
[...]
[...]        CPU0                    CPU1
[...]        ----                    ----
[...]   lock(&f->f_owner.lock);
[...]                                local_irq_disable();
[...]                                lock(&dev->event_lock);
[...]                                lock(&new->fa_lock);
[...]   <Interrupt>
[...]     lock(&dev->event_lock);
[...]
[...]  *** DEADLOCK ***

The corresponding deadlock case is as followed:

	CPU 0		CPU 1		CPU 2
	read_lock(&fown->lock);
			spin_lock_irqsave(&dev->event_lock, ...)
					write_lock_irq(&filp->f_owner.lock); // wait for the lock
			read_lock(&fown-lock); // have to wait until the writer release
					       // due to the fairness
	<interrupted>
	spin_lock_irqsave(&dev->event_lock); // wait for the lock

The lock dependency on CPU 1 happens if there exists a call sequence:

	input_inject_event():
	  spin_lock_irqsave(&dev->event_lock,...);
	  input_handle_event():
	    input_pass_values():
	      input_to_handler():
	        handler->event(): // evdev_event()
	          evdev_pass_values():
	            spin_lock(&client->buffer_lock);
	            __pass_event():
	              kill_fasync():
	                kill_fasync_rcu():
	                  read_lock(&fa->fa_lock);
	                  send_sigio():
	                    read_lock(&fown->lock);

To fix this, make the reader in send_sigurg() and send_sigio() use
read_lock_irqsave() and read_lock_irqrestore().

Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7cf..3dc90e5293e65 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -779,9 +779,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
 	enum pid_type type;
+	unsigned long flags;
 	struct pid *pid;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
 	pid = fown->pid;
@@ -802,7 +803,7 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 		read_unlock(&tasklist_lock);
 	}
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
 }
 
 static void send_sigurg_to_task(struct task_struct *p,
@@ -817,9 +818,10 @@ int send_sigurg(struct fown_struct *fown)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
+	unsigned long flags;
 	int ret = 0;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
 	pid = fown->pid;
@@ -842,7 +844,7 @@ int send_sigurg(struct fown_struct *fown)
 		read_unlock(&tasklist_lock);
 	}
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
 	return ret;
 }
 
-- 
2.27.0

