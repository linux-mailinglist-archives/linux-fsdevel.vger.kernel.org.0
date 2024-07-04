Return-Path: <linux-fsdevel+bounces-23136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01E927906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937C81C23536
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09321B1210;
	Thu,  4 Jul 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTrdfNKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784131B0106
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104059; cv=none; b=Mmn41OJwbJekB+/Qw9BG+n/iiH1/432UW8WFruBwqf2q5InKS1mI3PspeF2tJLJFwohGsCZ3yB47rk+W25Tg47oGtDg3YOQU0phyQZcF4fgKzNzgDVlqulrz0llqP5Qh1xFJfpIFfviQSAwwjEm88Ry4x/cHfnBQbVdYCZQmlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104059; c=relaxed/simple;
	bh=7HbxzxvZ6O54ybYuKdJocY8kqKrkHXVIvqjIhkTKOqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr3gibCrZr90UZWTZQVlnyjoMz7Ip9qZe9UqSh+bD9VC57z6iTH8/7DFqSjqegmmgRe620VCrI8ktvLUBvPuCnXyCLdFF6GWsbiXK3hs7Emnvuawr+pRKV4gnY3gJC1hcUmbS3ONxInNFWWyQt1nce/s7Fy5TLHkyLLMQnkxLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTrdfNKD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so10265a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720104056; x=1720708856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoLPRA+i9BYRAbwvGDWgm7HQ9jCtDQ1wLiDIU38H3hE=;
        b=cTrdfNKDg/0Q02xuZgVUOoswgU9ozFKW7u6f9q4R5+z9EEs+sP6HeC4aERU/NdHhvU
         PpJTL7vz36uxxkSEnXs5kRh95TzyZ1ecjkjfvsA/5ZTdqxfYOxCSyBRV+8RZevOTjT/Y
         VQz7l31Ld+mp7S8YLYwtSC4p8dLGg+HI67h+5PSRTeIQvGcmUl+pf0YBmg109AOh3TCF
         rwCtPSa9uvOBRCqH6/al07sTw/1tm8u4wItlH9KNADFaVOkjUPaSfUfbL0lhUjxCXBun
         WiVo1JiffZs5QZU3ubUPSbDPmUJDOcRfFV7kDtPg8An93mslrEaKjR2D1fX9n1d5T9b5
         H+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104056; x=1720708856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoLPRA+i9BYRAbwvGDWgm7HQ9jCtDQ1wLiDIU38H3hE=;
        b=sPQYPZLdoYcRRcN874Crwjqz6/0c6ch7gj0nf/8UCR6iCLUZXYrJ8tRhAAwl253j87
         zlVFb4d48WwHExSdAuAoO2uXSbil7OqPBNcW9UVwlpXhmxPj1n6QznCKi03o5FZSa5h2
         lI9d6i7nDRif6datnLezcSiMqJllwkdwpJekR4DgeNHWrqxV+NqFg7a9zG6F0BQBccG5
         In1iBlG2RR1YwiD+IkVGn7oKBU5TNkyWeXiJoxoxKU/MVdZKJNmbn4nyUDrILJprgOA/
         A3u2zcQXZOve06PtomY7DNNXsgLSdv5b2BHf4KRxdK9oktqHwAYxd1xvzMeOwiptovEB
         VTrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8OSgjA1r9NnY6isjBHCF9CSUIcTT9z2GxHdiE0GwNjVlsL2JuYwqFfuH4NVM0wQIrEDXlZKzHiNchl4ZCYtGUlb7q8O6oBYtUzyXGYA==
X-Gm-Message-State: AOJu0YySFwjfayCS3OVOd7hnBnkPdV529Tr++98dPKsbcWRaiNJ8O+Ew
	GuVK+sZkGJbZ24Wlq2cMdeJJkO2gKLS9WeddFBsAt0TiSflhm2wdRdjO+ggcULy0UIUYSzJHwne
	HuQ1UjOfTIz557u+H9MunomktI4WlyAwipqn+
X-Google-Smtp-Source: AGHT+IFrlXTCWuQfrcbv3kCuJEf2AxaTnkqg7uLz0SX7b6g3ZVoMlN3HPnKhGi/0cay3T6b6sdaWjs6Tg5SR3YNd8xw=
X-Received: by 2002:a50:934f:0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-58e2942d74fmr114676a12.7.1720104052327; Thu, 04 Jul 2024
 07:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fbb100061c6ce567@google.com>
In-Reply-To: <000000000000fbb100061c6ce567@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:40:40 +0200
Message-ID: <CACT4Y+Z34Mc_Vv8-dDvD+HE57tMez0Rd17zr_s-3Gn23tOVG3A@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __ep_remove / __fput (4)
To: syzbot <syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:38, syzbot
<syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    22a40d14b572 Linux 6.10-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f94dae980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3195ed1f3a2ab8bea49a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ebe2f3933faf/disk-22a40d14.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7227032da0fe/vmlinux-22a40d14.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a330dc1e107b/bzImage-22a40d14.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com


Double-checked locking in eventpoll_release_file() should prevent NULL
derefs in eventpoll_release_file(), right? If so, it's probably
benign-ish.


> ==================================================================
> BUG: KCSAN: data-race in __ep_remove / __fput
>
> write to 0xffff88810f2358d0 of 8 bytes by task 6036 on cpu 1:
>  __ep_remove+0x3c9/0x450 fs/eventpoll.c:826
>  ep_remove_safe fs/eventpoll.c:864 [inline]
>  ep_clear_and_put+0x158/0x260 fs/eventpoll.c:900
>  ep_eventpoll_release+0x32/0x50 fs/eventpoll.c:937
>  __fput+0x2c2/0x660 fs/file_table.c:422
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88810f2358d0 of 8 bytes by task 6037 on cpu 0:
>  eventpoll_release include/linux/eventpoll.h:45 [inline]
>  __fput+0x234/0x660 fs/file_table.c:413
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff888102f1e010 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 6037 Comm: syz.0.1032 Not tainted 6.10.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fbb100061c6ce567%40google.com.

