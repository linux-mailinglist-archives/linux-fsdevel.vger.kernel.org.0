Return-Path: <linux-fsdevel+bounces-23133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016F927855
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA76B2822F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07E1B0119;
	Thu,  4 Jul 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB9G3SW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FD1AE0AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103304; cv=none; b=uOatC0ePnwqm0gv2VfmlU/fWKt5EpmYzHV5kJxNzZC6j6PuW7CCZ3Ssfw+XvSJK/F8KrKOa0tP/w6WFGCDtWuc47qvKH3Dw+G6Xteq0k7Tn890fwU8Zo7gMYFKCYaRaoyj3pgttp6phWpr922b1bEzEHQwgAqkcFFKlY/D5qE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103304; c=relaxed/simple;
	bh=klcv0iJPfnyqJC0zdGFDfeZ90nx+1IkMvIljASpIwyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idyYqcOGiHgO1nKvo/8tyRJz2O8kupq2p7d0HO+w3flH1D8lHE05Kzop7DQjl5mJLL33+rqPURC2soj+7FSy1jFYTQZcLrIwwF/CmhPZ36HsO07O089b0TSBn+hXQpUKIMV6u4pqNdpH2xB4QfdgfM38zFko2xczYln/dUV9SHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kB9G3SW4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4255f915611so84555e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720103301; x=1720708101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6FziicbfvJ4ZiuSQIpadzUmzwr4pmtmpZSgG/HGKc4=;
        b=kB9G3SW4R8cRTUKGZfygga5lK9RR6/nWRFzsdttV3URFNHBcGBKNRklz45wBvjjQDM
         nP1XVAdcwYXLIhbC4crV5UbDlflIMFWpi9XZvgU3eTyEBp3Xh/NBLtWA6TgAuvZoUDRn
         xZ4bhnEhkSlnG2lxkNOJUg/xSBeikAPRYax7Jk7NyqHKLd0E+x1hXGy6QzEoij2fjwN2
         opxb/lJtulq+XUeItOX6G0UqHO2ftPX/taKQ2m5+rOuZYaQ0zuX7so2ba3v2OybCu74O
         86JgkIX5XI5mr0VIB+b5q04q22fwwuvPjQ6mY7yW9LugIhRRlqa6BabQvMvinvof6Fev
         MD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103301; x=1720708101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6FziicbfvJ4ZiuSQIpadzUmzwr4pmtmpZSgG/HGKc4=;
        b=c1uZRLhzY0aR7E0Urkw+CUQPdVjm1H6/uCB3QRANCEIPWRc7bRKZv9B0JxoDqdyQuA
         /L9E1dEX4qiPions9jnHY3uN7lx/ZNbHoiNdv+9N733+alh7IsUsR8Ms26T6S9xUl2PX
         rWKxRZerkdKxgbv/XF+ECQrKt5tzOyNH1TNIG/0YjP+qj+ENzYhDf4rHqR3NJpvCx2ch
         zOQg8l8tZ5kQMhly/Sy/AwwgjhHfqdG/UVTsPwjV6xknOOKM4GwZJz7ui+l2RV9QWhRY
         U2TPeny6J1awLAGiwZoBteQu7a/Wo93zK6DJyheLpYTIi96s/TurMqY8v+QoMCOLPuPp
         jXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWsF+fXkYhWVj3RqOhNlcKeB1fXxLCj4jfvPgNHeMmce01+eEvY0W/i/W+Zu5C2lf6S8l27bbQP+OcLwVqH5+LHUOfLZrSK9qfAnpy9mg==
X-Gm-Message-State: AOJu0YyxbEPMkZp92yof36nhjcjjrOhYzv1l47egmkdZQyldS1mmwDbY
	Uazd6ap+mYUJ22A/1wOnkTTbeFFJ/j1vgWBcO3N7MdoP7dIXO8t5q9b9nZwWfWAJ+m+mQ3MlGs2
	LZPaINFW4Cn1pns4lc0tAubNxESyfkCm7mKJi
X-Google-Smtp-Source: AGHT+IEfl1aTNgldqQxnijvcOwkJppBlrG7YkJA8kh0cuuzciQ+XLp2g2dqZh/j8mGS6AwNYwSOFEMsKkWf/7pue8Ko=
X-Received: by 2002:a05:600c:350a:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-42648529fcbmr1884895e9.4.1720103300890; Thu, 04 Jul 2024
 07:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc5b12061c6cac00@google.com>
In-Reply-To: <000000000000dc5b12061c6cac00@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:28:09 +0200
Message-ID: <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __fsnotify_parent /
 __fsnotify_recalc_mask (5)
To: syzbot <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:22, syzbot
<syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a6b6b9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> dashboard link: https://syzkaller.appspot.com/bug?extid=701037856c25b143f1ad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3d1d205c1fdf/disk-795c58e4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/641c78d42b7a/vmlinux-795c58e4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/45ecf25d8ba3/bzImage-795c58e4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
>
> EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-000000000000.
> ==================================================================
> BUG: KCSAN: data-race in __fsnotify_parent / __fsnotify_recalc_mask
>
> write to 0xffff8881001c9d44 of 4 bytes by task 6671 on cpu 1:
>  __fsnotify_recalc_mask+0x216/0x320 fs/notify/mark.c:248
>  fsnotify_recalc_mask fs/notify/mark.c:265 [inline]
>  fsnotify_add_mark_locked+0x703/0x870 fs/notify/mark.c:781
>  fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:812 [inline]
>  inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
>  inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
>  __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
>  __se_sys_inotify_add_watch+0x66f/0x810 fs/notify/inotify/inotify_user.c:729
>  __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c:729
>  x64_sys_call+0x2af1/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:255
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff8881001c9d44 of 4 bytes by task 10004 on cpu 0:
>  fsnotify_object_watched fs/notify/fsnotify.c:187 [inline]
>  __fsnotify_parent+0xd4/0x370 fs/notify/fsnotify.c:217
>  fsnotify_parent include/linux/fsnotify.h:96 [inline]
>  fsnotify_file include/linux/fsnotify.h:131 [inline]
>  fsnotify_open include/linux/fsnotify.h:401 [inline]
>  vfs_open+0x1be/0x1f0 fs/open.c:1093
>  do_open fs/namei.c:3654 [inline]
>  path_openat+0x1ad9/0x1fa0 fs/namei.c:3813
>  do_filp_open+0xf7/0x200 fs/namei.c:3840
>  do_sys_openat2+0xab/0x120 fs/open.c:1413
>  do_sys_open fs/open.c:1428 [inline]
>  __do_sys_openat fs/open.c:1444 [inline]
>  __se_sys_openat fs/open.c:1439 [inline]
>  __x64_sys_openat+0xf3/0x120 fs/open.c:1439
>  x64_sys_call+0x1057/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:258
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000000 -> 0x00002008
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 10004 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================


I think __fsnotify_recalc_mask() can be compiled along the lines of:

*fsnotify_conn_mask_p(conn) = 0;
hlist_for_each_entry(mark, &conn->list, obj_list) {
   ...
   *fsnotify_conn_mask_p(conn) |= fsnotify_calc_mask(mark);
   ...
}

And then fsnotify_object_watched() may falsely return that it's not
watched (if it observes 0, or any other incomplete value).

