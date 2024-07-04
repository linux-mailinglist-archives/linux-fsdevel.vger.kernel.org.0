Return-Path: <linux-fsdevel+bounces-23135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3599278DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4406428D6A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751581B3738;
	Thu,  4 Jul 2024 14:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B91B1214
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103903; cv=none; b=uuO1CwRlhJyAyl/+yx3eXnVcYlG4xih79/+GT1a56hmXUXsYBUp9osAXFQp+GN5ldphi4cFsSuNP2mGCqGTNIhGxKMl/eooYTyxLABYaFVY1Vohq/s1FWQT74wmQcieRnpsFSX61hZTQyIBmZn/v2xAVRAf5UTPuULcWqjbgCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103903; c=relaxed/simple;
	bh=11ky+4rAzYeI15IHMbslfVqut9Xl2RbRxbj/jBLcjLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p3u7Y4rxegw+IiOiqVvN4u2hy7GO1EUuxIUWO6QTToBJ0EVmrKIFLuZkvjzDAY6K1TJdEx6MJ2yW2CEZV90z9whuqFoXi65IshbZDgZjMrQIIIZCQ3jCTqFjo8Dhke9ZfJHsTt8Qoh2eaySqZu7W2cllMhkPdQKbVuYZrcuOADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so85205139f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 07:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103901; x=1720708701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8RwYbFd+1D/aayv0GcskSCY5cRhlX3pKTCf8YYDs8E=;
        b=QRYo/DQMawXJSXUAw9AfDxAYnjkxRgiGj6Z+gZ/M6qf8SP8+xf/F92a3wXE8g6kMRB
         NcUESDgmndfse6Q/GkdTF9U3NrR+gsI7bjRQPtMqVtJOLeQ/aj9CokGCBZXcCaVjwS7Q
         7HJC9sqT2a5rJrkMqadPjReZX4gj137YcXz0YyaQPtkmcqk2wDzSujYBZYolvYufw6vS
         6SpabDRoVTFHM0bODwqBHEUbDB07o/VioXRNw/QvGdsd+xZmruQJMk6PHuQzx7pAodV+
         tJ/a0YaiRFK/u/JSnrEsT0JK7bZTjtCRVRDT3Rp1BFtqk1Cm1u9oYkXSvkOk2GUF5pn0
         roOw==
X-Forwarded-Encrypted: i=1; AJvYcCUa6ZzEHvbtTXsO8Pr/Fp+TGWtcX94AvKng0/bykwyptmq76izZ/+opJUZLfJfnhjrb3jbAkSQJwR2zFE6r1D/bSplD6cU4j2AlPJbjhg==
X-Gm-Message-State: AOJu0YwQQniJTDxRSsr/jtNyo9iryssN5Ie8GCjknH5N9s0sBOZL3uUC
	ldun6YfBDvWUhV+GsaVDit7m/lYRO3uS6wYJvELSbjCj5r/mOH4IoNRPBRH+rHQu7ODnGBZ4HnC
	rqkw0UGkwrM6RwC5PPXEKApC8lBh/Ws6v+pSF+/6wNmQRLacSWb+dA3w=
X-Google-Smtp-Source: AGHT+IFOVQNCaKJ5iTZjG6QaRv+CfxmdTczN97vLfQDQQ6oWENLTqFpkmHp6BhraCtknYITElrqcNFiodB6pncqOQxhnJvQI4WdP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f18:b0:4b9:6e79:8155 with SMTP id
 8926c6da1cb9f-4bf612d57b9mr88446173.3.1720103900781; Thu, 04 Jul 2024
 07:38:20 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbb100061c6ce567@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __ep_remove / __fput (4)
From: syzbot <syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22a40d14b572 Linux 6.10-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f94dae980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
dashboard link: https://syzkaller.appspot.com/bug?extid=3195ed1f3a2ab8bea49a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebe2f3933faf/disk-22a40d14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7227032da0fe/vmlinux-22a40d14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a330dc1e107b/bzImage-22a40d14.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __ep_remove / __fput

write to 0xffff88810f2358d0 of 8 bytes by task 6036 on cpu 1:
 __ep_remove+0x3c9/0x450 fs/eventpoll.c:826
 ep_remove_safe fs/eventpoll.c:864 [inline]
 ep_clear_and_put+0x158/0x260 fs/eventpoll.c:900
 ep_eventpoll_release+0x32/0x50 fs/eventpoll.c:937
 __fput+0x2c2/0x660 fs/file_table.c:422
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810f2358d0 of 8 bytes by task 6037 on cpu 0:
 eventpoll_release include/linux/eventpoll.h:45 [inline]
 __fput+0x234/0x660 fs/file_table.c:413
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888102f1e010 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 6037 Comm: syz.0.1032 Not tainted 6.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

