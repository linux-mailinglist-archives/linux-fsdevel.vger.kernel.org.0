Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA14D0E2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 03:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiCHC7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 21:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiCHC7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:59:38 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C903A19B;
        Mon,  7 Mar 2022 18:58:42 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b23so15071627qtt.6;
        Mon, 07 Mar 2022 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isRqt1Y496G0sLivJF5nVqMHeY/3u42l/ZTo/kY3Jlc=;
        b=K9daq1jdLt9eKdelC1BMlASmFPLlrLIyn89a9N0BrgOinjjjvar2+YedcK5bbRKljl
         SufRCIHbXU0jxFDXl784sWbxevCT3ztb08lBWTd9z5b0NF9yRwt2XyrzVP6Gr28GZjxi
         QnoFVf4rh6lL/HP+mF2xYa10bgHviKgWYg2Mv6HBJ8tmTtyunAus67E61HzyjVgJbrZO
         xLiFuB0uS0zIkt2s6KD3PaEJruyDYFii/stMWmvQ8kho/3HfkEo65yihoqLsapq49/2W
         STpp0n/A5OAzEVHkBUZ/CrD7y3h0GuICRFppo5BXcLgn2AmTZ0+5r9GOuEsZbY4brEOX
         kqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isRqt1Y496G0sLivJF5nVqMHeY/3u42l/ZTo/kY3Jlc=;
        b=27zBzPbbh/0l0oJd2R1sTX8OlZD/hMdVuW58ZU5qFon23mLk/0r1ZNFe9fP7Q5pXjx
         0mddl0kNB7A8AT/8c5NDEHwTw+Em9kzANg3YQ5UEqU8VZ5SxWilmqOjA8GTUfOB8xRnE
         RPOR+BMpz42bZgmcb5ZWyRyB8VCOZXhQAbugDA27yYLzKHvrTvgCkIb6n6zKIcNbkTxV
         S5JC0CFC8/vGEEwURI9NHmPs5DDSCDwqDqnK+svY08Ab+UDHnW+xMnHRT2nElzTXi9To
         CPIao27m+nUWykPxxi4KkUpvk8Jdy7GHxnQv8ENpv51hB5sInYeE7O+smd+/yPmCk7uC
         mltg==
X-Gm-Message-State: AOAM532Abzx9ITiCC60Ag4+ngkF/xPCrwrLR1sZW8o1xjwI18V7L077y
        CVp47fVjJlz//FoRzKrqIO0nCSBnGdg=
X-Google-Smtp-Source: ABdhPJx/n/Hca715d9nmQDjr6uyXUeMAUP5MD7xvR9VEZ0J4ik3fWmXNzK+9W51fdoOCD59qPiiL5Q==
X-Received: by 2002:a05:622a:1825:b0:2e0:64e4:5a93 with SMTP id t37-20020a05622a182500b002e064e45a93mr7428449qtc.400.1646708321576;
        Mon, 07 Mar 2022 18:58:41 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85f8a000000b002dde6288fa7sm10036766qta.83.2022.03.07.18.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:58:41 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, zealci@zte.com.cn
Subject: [PATCH] pipe: fix data race in pipe_poll / pipe_release
Date:   Tue,  8 Mar 2022 02:58:20 +0000
Message-Id: <20220308025820.2077261-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>

pipe_poll is reading pipe->writers without any synchronization while
pipe_release can write it with holding pipe lock. It is same to
pipe->readers.

Reading pipe state only, no need for acquiring the semaphore. Use
READ_ONCE to document them.

BUG: KCSAN: data-race in pipe_poll / pipe_release
write to 0xff1100003f332de8 of 4 bytes by task 31893 on cpu 0:
 pipe_release+0xc3/0x1f0 fs/pipe.c:721
 __fput+0x29b/0x530 fs/file_table.c:280
 ____fput+0x11/0x20 fs/file_table.c:313
 task_work_run+0x94/0x120 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0x675/0x1720 kernel/exit.c:832
 do_group_exit+0xa4/0x180 kernel/exit.c:929
 __do_sys_exit_group+0xb/0x10 kernel/exit.c:940
 __se_sys_exit_group+0x5/0x10 kernel/exit.c:938
 __x64_sys_exit_group+0x16/0x20 kernel/exit.c:938
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x4a/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
read to 0xff1100003f332de8 of 4 bytes by task 31891 on cpu 3:
 pipe_poll+0x18b/0x270 fs/pipe.c:679
 vfs_poll include/linux/poll.h:90 [inline]
 do_select+0x7bb/0xec0 fs/select.c:537
 core_sys_select+0x42a/0x6a0 fs/select.c:680
 kern_select fs/select.c:721 [inline]
 __do_sys_select fs/select.c:728 [inline]
 __se_sys_select+0x1a7/0x1e0 fs/select.c:725
 __x64_sys_select+0x63/0x70 fs/select.c:725
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x4a/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
value changed: 0x00000001 -> 0x00000000
Reported by Kernel Concurrency Sanitizer on:
CPU: 3 PID: 31891 Comm: sshd Not tainted 5.16.10 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
==================================================================

kernel version : linux_5.16.10/linux-stable

(gdb) l *pipe_release+0xc3
0xffffffff8144f2d3 is in pipe_release (fs/pipe.c:721).
716
717             __pipe_lock(pipe);
718             if (file->f_mode & FMODE_READ)
719                     pipe->readers--;
720             if (file->f_mode & FMODE_WRITE)
721                     pipe->writers--;
722
723             /* Was that the last reader or writer, but not the other side? */
724             if (!pipe->readers != !pipe->writers) {
725                     wake_up_interruptible_all(&pipe->rd_wait);
(gdb) l *pipe_poll+0x18b
0xffffffff8144e84b is in pipe_poll (fs/pipe.c:679).
674
675             mask = 0;
676             if (filp->f_mode & FMODE_READ) {
677                     if (!pipe_empty(head, tail))
678                             mask |= EPOLLIN | EPOLLRDNORM;
679                     if (!pipe->writers && filp->f_version != pipe->w_counter)
680                             mask |= EPOLLHUP;
681             }
682
683             if (filp->f_mode & FMODE_WRITE) {

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 fs/pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 71946832e33f..ddc8050f97ca 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -677,7 +677,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 	if (filp->f_mode & FMODE_READ) {
 		if (!pipe_empty(head, tail))
 			mask |= EPOLLIN | EPOLLRDNORM;
-		if (!pipe->writers && filp->f_version != pipe->w_counter)
+		if (!READ_ONCE(pipe->writers) && filp->f_version != pipe->w_counter)
 			mask |= EPOLLHUP;
 	}
 
@@ -688,7 +688,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 		 * behave exactly like pipes for poll().
 		 */
-		if (!pipe->readers)
+		if (!READ_ONCE(pipe->readers))
 			mask |= EPOLLERR;
 	}
 
-- 
2.25.1

