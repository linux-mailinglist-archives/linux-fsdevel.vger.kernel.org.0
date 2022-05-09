Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067151FDED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiEINWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiEINWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:22:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A2244F25;
        Mon,  9 May 2022 06:18:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so9524368pgc.1;
        Mon, 09 May 2022 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5qUGj6TkUHNHFMic3usSXTRRtjySZFw0zGgaGW/wF4=;
        b=ShZ2wxuiybBMtW3FWvdh6RLZuwBd4gU1HMyZiDxnEOgpry6Rj8Mj530IJ4kCkPv3bQ
         JTWfuATbW4QCOpS7jXig/8L2v5y3pFgsIhyp9l5LkK27oDsmiIpemJVnca0c1Q+v9BHF
         1xkBn5kWV81pu0IY84zyGIOQPdHLWrLak1qzTRD+6wbkVNPNsgcgjiyHYUGHZb2SjGZy
         BK+4nxJafN6y2rlYhW5T1dhZJNOX0M/Vxo9Op+LO8LSGChu3cmcMNrXgyWjpN3jpIoLj
         8wxjk2uCx+7LEohE58aEApy2bsShzAp910cgoXgFAilTUrpGKg9vF7ejgGiRhan6Qn3e
         YscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5qUGj6TkUHNHFMic3usSXTRRtjySZFw0zGgaGW/wF4=;
        b=i05RZVvHN3eL5VvGQrTappE86+SfwQPw1HetDexP0s/iY2TOmUAr/nqvbAokORoFyo
         rPSZzyJU1WbRuaFtEEDOw2Dk4QKZR9KpnhzeocPD7Bv5UoBrkRh+b0aOeJ9Uxk/X/opO
         lQI/wBEk7x5SUa7OGBLRBTM3DSOzae+UVK01ivAuVnC5WBu5KCZ5PgR/IvbhttjeW9bc
         Aus0REjkiUupThb1HrVLs32sVzCLuYP8jaA0EWpMuXfYPUJpLL2xB99detHWMnMegGTA
         b1Ko3AAaPuG1hLppDn/WjEjqZRByrnzMSBg1RikOExburwOGhfxcWJcpXRgH8bAlhDry
         xvDw==
X-Gm-Message-State: AOAM531Tm6L9t+F2R9hGmy+q7nlwQ/zn5OWY2LcqsFzJItmURpCnYZSw
        QxidNMVyk8KuLoAZAMd5PJU=
X-Google-Smtp-Source: ABdhPJyoW4yKa/hH6Q1NGvG7lyAsgatg6JMl9V+3WRHs5B+lPA/y6gzIJzb/QLYOdKIkbPFxW7yGZg==
X-Received: by 2002:a63:2486:0:b0:3ab:84c3:864a with SMTP id k128-20020a632486000000b003ab84c3864amr13068540pgk.358.1652102324175;
        Mon, 09 May 2022 06:18:44 -0700 (PDT)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b0015e981111d5sm7038007pld.234.2022.05.09.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 06:18:13 -0700 (PDT)
From:   Haimin Zhang <tcs.kernel@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is freed
Date:   Mon,  9 May 2022 21:17:26 +0800
Message-Id: <20220509131726.59664-1-tcs.kernel@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

Add a new function call to deinitialize the watch_queue of a freed pipe.
When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
Later when function post_one_notification is called, it will use this
field, but it has been freed and watch_queue->pipe is a dangling pointer.
It makes a uaf issue.
Check wqueu->defunct before pipe check since pipe becomes invalid once all
watch queues were cleared.

Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
---
The following is the callstacks:
1. The pipe was created as follows:
```
 kmalloc build/../include/linux/slab.h:581 [inline]
 kzalloc build/../include/linux/slab.h:714 [inline]
 alloc_pipe_info+0x105/0x590 build/../fs/pipe.c:790
 get_pipe_inode build/../fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 build/../fs/pipe.c:913
 __do_pipe_flags build/../fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 build/../fs/pipe.c:1010
 __do_sys_pipe2 build/../fs/pipe.c:1028 [inline]
 __se_sys_pipe2 build/../fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 build/../fs/pipe.c:1026
 do_syscall_x64 build/../arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 build/../arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
```
2. The pipe was freed as follows:
```
 kfree+0xd6/0x4d0 build/../mm/slub.c:4552
 put_pipe_info build/../fs/pipe.c:711 [inline]
 pipe_release+0x2b6/0x310 build/../fs/pipe.c:734
 __fput+0x277/0x9d0 build/../fs/file_table.c:317
 task_work_run+0xdd/0x1a0 build/../kernel/task_work.c:164
 resume_user_mode_work build/../include/linux/resume_user_mode.h: 49 [inline]
 exit_to_user_mode_loop build/../kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 build/../kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work build/../kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 build/../kernel/entry/common.c:294
 do_syscall_64+0x42/0x80 build/../arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
```
3. The dangling pointer was used:
```
 __lock_acquire+0x3eb0/0x56c0 build/../kernel/locking/lockdep.c:4899
 lock_acquire build/../kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 build/../kernel/locking/lockdep.c:5606
 __raw_spin_lock_irq build/../include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x32/0x50 build/../kernel/locking/spinlock.c:170
 spin_lock_irq build/../include/linux/spinlock.h:374 [inline]
 post_one_notification.isra.0+0x59/0x990 build/../kernel/watch_queue.c:86
 remove_watch_from_object+0x35a/0x9d0 build/../kernel/watch_queue.c:527
 remove_watch_list build/../include/linux/watch_queue.h:115 [inline]
 key_gc_unused_keys.constprop.0+0x2e5/0x600 build/../security/keys/gc.c:135
 key_garbage_collector+0x3d7/0x920 build/../security/keys/gc.c:297
 process_one_work+0x996/0x1610 build/../kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 build/../kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 build/../kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 build/../arch/x86/entry/entry_64.S:298
```

 fs/pipe.c                   |  4 +++-
 include/linux/watch_queue.h |  5 +++++
 kernel/watch_queue.c        | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index e140ea150bbb..d0e9d8697810 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -844,8 +844,10 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 			pipe_buf_release(pipe, buf);
 	}
 #ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe->watch_queue) {
+		watch_queue_deinit(pipe);
 		put_watch_queue(pipe->watch_queue);
+	}
 #endif
 	if (pipe->tmp_page)
 		__free_page(pipe->tmp_page);
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 3b9a40ae8bdb..e5086b195fb7 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -90,6 +90,7 @@ extern long watch_queue_set_size(struct pipe_inode_info *, unsigned int);
 extern long watch_queue_set_filter(struct pipe_inode_info *,
 				   struct watch_notification_filter __user *);
 extern int watch_queue_init(struct pipe_inode_info *);
+extern int watch_queue_deinit(struct pipe_inode_info *);
 extern void watch_queue_clear(struct watch_queue *);
 
 static inline void init_watch_list(struct watch_list *wlist,
@@ -129,6 +130,10 @@ static inline int watch_queue_init(struct pipe_inode_info *pipe)
 	return -ENOPKG;
 }
 
+static inline int watch_queue_deinit(struct pipe_inode_info *pipe)
+{
+	return -ENOPKG;
+}
 #endif
 
 #endif /* _LINUX_WATCH_QUEUE_H */
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 230038d4f908..4357511880f5 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -80,13 +80,22 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	unsigned int head, tail, mask, note, offset, len;
 	bool done = false;
 
-	if (!pipe)
+	if (!kref_get_unless_zero(&wqueue->usage))
 		return false;
 
-	spin_lock_irq(&pipe->rd_wait.lock);
-
-	if (wqueue->defunct)
+	spin_lock_bh(&wqueue->lock);
+	if (wqueue->defunct) {
+		spin_unlock_bh(&wqueue->lock);
 		goto out;
+	}
+	spin_unlock_bh(&wqueue->lock);
+
+	if (!pipe) {
+		put_watch_queue(wqueue);
+		return false;
+	}
+
+	spin_lock_irq(&pipe->rd_wait.lock);
 
 	mask = pipe->ring_size - 1;
 	head = pipe->head;
@@ -123,6 +132,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	done = true;
 
 out:
+	put_watch_queue(wqueue);
 	spin_unlock_irq(&pipe->rd_wait.lock);
 	if (done)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
@@ -663,3 +673,19 @@ int watch_queue_init(struct pipe_inode_info *pipe)
 	pipe->watch_queue = wqueue;
 	return 0;
 }
+
+/*
+ * Deinitialise a watch queue
+ */
+int watch_queue_deinit(struct pipe_inode_info *pipe)
+{
+	struct watch_queue *wqueue;
+
+	if (pipe) {
+		wqueue = pipe->watch_queue;
+		if (wqueue)
+			wqueue->pipe = NULL;
+		pipe->watch_queue = NULL;
+	}
+	return 0;
+}
-- 
2.27.0

