Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4235280359
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgJAP6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbgJAP6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:58:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8675EC0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 08:58:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c2so5820568qkf.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXDs47lMlTRlP0XheGF9Zm9dG83RHo7+jO2aQkO/SXo=;
        b=Ir4EP3z+jvPhnOfaFc9Esj4bI8GU+xB/ImgKTpBxEQLVVvLissuPhPJxgrYXTDrFlT
         5ze2RPNw2gyOtR/cPeUDGDi50NXtf3yfThXVo92Xdrg5fZYfo9MTc1XKRzk3KNvL5y3d
         V+6aul8c7CU6UvZKiTecmaAN7etcHb/gdQezC0qO5Gcq2ohHUNx6R0CUxqU9mbbH9PNe
         nVRiJk3KQHYPdaChJI85LzD3KaBrg5fAecDhwQEoCWoT08ls61o6wd+CTqx7Hja4dqB4
         xVO/wBnwkHNBE6vv2Z4CI2G1ddQDpndJda2zpmTM5P0kme5pRO6kp2Q4F9/38NQlurvZ
         WNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXDs47lMlTRlP0XheGF9Zm9dG83RHo7+jO2aQkO/SXo=;
        b=EbG+wYJpLLbubo4VRaEvDI2SN3rcOCm8oNFq+XEjPqz9LSwZD6svNbpIruoonZ0Vzz
         dHCratrCB/TlziUPv1Wnds859y7bTeL6hru+XCKGbcJeA4iIjAS9JgzqKiuP4cN6jwYC
         4mG+njIkg/4881JB2YLYT8kUyyKV1xDz73XJxU9b1kHNANa+UVHOkAOZai0IEbE7qKss
         qMPyDBXWYFXA50TwyFeIosEaDT6AbQwdj/Nntn5FFQHaIG8EcNw5cPRsYBKf0DaOqRt/
         XmwgyVMnoL5ojUX5hu4uCNeOikjS+kuPyx0SLdQvgYRj+VuG/NQdqXYVeHt+RwQfJ0b0
         Qulg==
X-Gm-Message-State: AOAM533jQx5xqk5OJ8XzjZv6lLjhfXckapazh02MZCMSy7NNyRz4iMtI
        WAIrRtAwn9gM/N98VGp1QMq//A==
X-Google-Smtp-Source: ABdhPJw9LzfTuBrbkh/Mw+XXPkcKHTTWBhiL4U6t5WndAJiTgQoUn3KqDjNoumNGOa0dYByHmyY2RA==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr7829883qkg.447.1601567913499;
        Thu, 01 Oct 2020 08:58:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x18sm2068693qth.47.2020.10.01.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 08:58:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH] pipe: fix hang when racing with a wakeup
Date:   Thu,  1 Oct 2020 11:58:31 -0400
Message-Id: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I hit a hang with fstest btrfs/187, which does a btrfs send into
/dev/null.  This works by creating a pipe, the write side is given to
the kernel to write into, and the read side is handed to a thread that
splices into a file, in this case /dev/null.  The box that was hung had
the write side stuck here

[<0>] pipe_write+0x38b/0x600
[<0>] new_sync_write+0x108/0x180
[<0>] __kernel_write+0xd4/0x160
[<0>] kernel_write+0x74/0x110
[<0>] btrfs_ioctl_send+0xb51/0x1867
[<0>] _btrfs_ioctl_send+0xbf/0x100
[<0>] btrfs_ioctl+0x1d4c/0x3090
[<0>] __x64_sys_ioctl+0x83/0xb0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

and the read side stuck here

[<0>] pipe_wait+0xa4/0x100
[<0>] splice_from_pipe_next.part.0+0x33/0xe0
[<0>] __splice_from_pipe+0x6a/0x200
[<0>] splice_from_pipe+0x50/0x70
[<0>] do_splice+0x35c/0x7e0
[<0>] __x64_sys_splice+0x92/0x110
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Using drgn to debug, I found that the pipe rd_wait was empty, but the
wr_wait was not

>>> pipe.rd_wait.head
(struct list_head){
        .next = (struct list_head *)0xffff9d2e5a3ad8d0,
        .prev = (struct list_head *)0xffff9d2e5a3ad8d0,
}
>>> pipe.wr_wait.head
(struct list_head){
        .next = (struct list_head *)0xffffa8934111bd88,
        .prev = (struct list_head *)0xffffa89341143ba8,
}

>>> for e in list_for_each_entry('struct wait_queue_entry',
				 pipe.wr_wait.head.address_of_(), 'entry'):
...   task = Object(prog, 'struct task_struct',
		    address=e.private.value_())
...   print("pid {} state {}".format(task.pid, task.state))
...
pid (pid_t)3080640 state (volatile long)1
pid (pid_t)3080638 state (volatile long)1
>>> for e in list_for_each_entry('struct wait_queue_entry',
				 pipe.rd_wait.head.address_of_(), 'entry'):
...   task = Object(prog, 'struct task_struct',
		    address=e.private.value_())
...   print("pid {} state {}".format(task.pid, task.state))
...

The wr_wait has both the writer and the reader waiting, which is
expected, the pipe is full

>>> pipe.head
(unsigned int)179612
>>> pipe.tail
(unsigned int)179596
>>> pipe.max_usage
(unsigned int)16

and the read side is only waiting on wr_wait, rd_wait doesn't have our
entry any more.

This can happen in the following way

WRITER					READER
pipe_write()				splice
  pipe_lock				pipe_lock()
    was_empty = true
    do the write
    break out of the loop
  pipe_unlock
					  consume what was written
					pipe_wait()
					prepare_to_wait(rd_wait)
					  set_task_state(INTERRUPTIBLE)
  wake_up(rd_wait)
    set_task_state(READER, RUNNING)
					prepare_to_wait(wr_wait)
					  set_task_state(INTERRUPTIBLE)
					pip_unlock()
					schedule()

The problem is we're doing the prepare_to_wait, which sets our state
each time, however we can be woken up either with reads or writes.  In
the case above we race with the WRITER waking us up, and re-set our
state to INTERRUPTIBLE, and thus never break out of schedule.

Instead we need to set our state once, and then add ourselves to our
respective waitqueues.  This way if any of our waitqueues wake us up,
we'll have TASK_RUNNING set when we enter schedule() and will go right
back to check for whatever it is we're waiting on.

I tested this patch with the test that hung, but this only happened on
one vm last night, and these tests run twice on 3 vm's every night and
this is the first time I hit the problem, so it's a rare occurrence.

Fixes: 0ddad21d3e99 ("pipe: use exclusive waits when reading or writing")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/pipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..8803a11cbc1b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -116,8 +116,9 @@ void pipe_wait(struct pipe_inode_info *pipe)
 	 * Pipes are system-local resources, so sleeping on them
 	 * is considered a noninteractive wait:
 	 */
-	prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
-	prepare_to_wait(&pipe->wr_wait, &wrwait, TASK_INTERRUPTIBLE);
+	set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&pipe->rd_wait, &rdwait);
+	add_wait_queue(&pipe->wr_wait, &wrwait);
 	pipe_unlock(pipe);
 	schedule();
 	finish_wait(&pipe->rd_wait, &rdwait);
-- 
2.26.2

