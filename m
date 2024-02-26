Return-Path: <linux-fsdevel+bounces-12749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B4866956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 05:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7591C213D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 04:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863C1B582;
	Mon, 26 Feb 2024 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm66kUyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CB1947E;
	Mon, 26 Feb 2024 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921476; cv=none; b=kr3ZjYDl9dRLQ4n8m7PJuVZUjB1uMkbFFKpwmGJ2zQdZ7Faa2eas//t/3rmBs+ttDD6hdgAT3hBfuA+gdF5oVN54iFqZpDlzkDxW1Vpk88eU8A9XjdzNf5dQClgr1tcHgY7YqepUFqFEtaui6r2Ab7GumXGYZ+0I55bWlD2sdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921476; c=relaxed/simple;
	bh=qcqEaGzQWy2K4XWuuhIFuuqeDkBLql4NDO/YoZO1nTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igjxYv+m5nFgMPXZ6mCcw9F+mqNR0wraaypsoX350ZypcfDErQw2p/m5JY/SaHXxDCIwIFBfKHSf7/wOiNjTuxOd538Mg29SGPhwejHevCdRMyC534YbpYruVs5T5hki3sChhc7gZxNlvN16c6wa81Ewp/EPJzDxYEFKnEphY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm66kUyZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e5e1643adso22816071cf.3;
        Sun, 25 Feb 2024 20:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708921474; x=1709526274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5hcfbJm00KFDUujxMG7JzPHaMn5k7FHxNAb1yVdXMY=;
        b=bm66kUyZ5BnVEiesGFgZJM+afqf/v9KtPo2gP0yRwe9a0yZaEU+6fQAghyBNMjyG3Y
         raDxfF8a6X4acCwQPBjTTM2vT/1sq3bE75CpdbmcP8eKdL34ZVTAFNgf1rc7xuPBXR6R
         SznHEiSKmX1RwsmdXNDRMkKU8Of873/OccvNff1WQ8cqgez73bEUGsT+8gSKt8OQNzU3
         1gf/6BaHmUtR3Pi7MtRBvZaQdaaeZx5tBTbsOjdDAFmyrCcfbwLyhOFD188ofc/MQ08z
         0YMD9YTl0vmdunI6et5+2m5TL4iXmhX7ETvu3nWH96usFdHfpENlW4jfChJ4qHWRAvFy
         SlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708921474; x=1709526274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5hcfbJm00KFDUujxMG7JzPHaMn5k7FHxNAb1yVdXMY=;
        b=C20mN10u86Eg/rnOUiJQfQsrafOShF8iHFzZyMwHj53N3406ZmN+EvIROWwnsT4ORf
         HQWWRZ/H/FnNPn5hshfTyvXGfbPidM0erf4LXsLCPNfOBTQm25H6a2BRACAJRkayHujm
         PDZa4m4k2Ue7nXhaErzG956TkwdXMswtMtnQrtQFwCMwBcRW9DXhYhmphKSnOz2fgx8j
         Rlt52yNioNE6fXyPRnPWQ+rop+8Ilv7xwLpQ1wGYueAnR4Ec9boeIazAwglSn27EMAfo
         Xha8eHWbw7n5FmW2YqhvAPQdZ8YZjCHSa7jAdthsR1nao+2guM8rL5P9Klta+Gay9UeC
         WPhg==
X-Forwarded-Encrypted: i=1; AJvYcCWIFq2VsuzFniIf7hmWL63Guv97OLS+pJJOt+wuNPLyYTgq447ROiCibsrvG65r78WRjgls8/ggBM9jp/YI4Ydf8ZRVw2+8eOR3Ba1zssmeR7iNsNkWAg0TnFy1Odd1ZZ9N4wzQ3qSlUVBDZQ==
X-Gm-Message-State: AOJu0Yxrjr7XuKcKOMxFzmZL0UWSg7VMngGEcbxXqQtdX3DQP2NKUOLK
	c68KIujxBbOi7dzGd9A3VizRllMHgSe5hSQ+t3sW6AoiS9pBHnAw
X-Google-Smtp-Source: AGHT+IG+iZN6LsYo/klFrFA/+JwrzlNrmlQduMMlaBP2gTLmV9vNzbRDJPhrO8RP2MI8X44MhmXdhQ==
X-Received: by 2002:a05:622a:408:b0:42e:8835:592b with SMTP id n8-20020a05622a040800b0042e8835592bmr1100639qtx.3.1708921473676;
        Sun, 25 Feb 2024 20:24:33 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id fp7-20020a05622a508700b0042e6d2dd6bbsm2046044qtb.11.2024.02.25.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 20:24:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5D2E8120006A;
	Sun, 25 Feb 2024 23:24:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 25 Feb 2024 23:24:32 -0500
X-ME-Sender: <xms:fxLcZVaRFbXj3bFuhQDzA04DrmW3ZQyaayD24UMRTw3ztHYZY5s5cg>
    <xme:fxLcZcZBAFIgtFd0fZbQmPqgDvBJK1wPJybmsVz6QTpNr_q0Z0Ex3a6FxZuwUiKbh
    As7BxHGq0ueBDv-Ug>
X-ME-Received: <xmr:fxLcZX89HHMsji6ratmxLP2DBMRroBwlZ2q4PzydHZcoVyaH0jzojS1jwYnsog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffeuvedtvddvhefg
    feevheeuheelueejteejieduudehjeehgedvgfelffelnecuffhomhgrihhnpehshiiikh
    grlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhdpghho
    ohdrghhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fxLcZTq1PXqvL0JGoVlquqGBpTRYtpWglh9jiG1sMvR_JuA7zlr6YQ>
    <xmx:fxLcZQoK1BaK2HCNfGyBMAEXN-TLpTLi6CyP0TA4fyjH_Huf571Q6Q>
    <xmx:fxLcZZTea6dVxnkiEmwN6VQe1Sg0OO_40hukYAcrfyY8SH9iXLJPyA>
    <xmx:gBLcZX2YcoAlSPP3L-5ieIHlKv_GB-fvMw5_q35uY0TP-VoY8FipKIrJbIQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 23:24:31 -0500 (EST)
Date: Sun, 25 Feb 2024 20:23:56 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>,
	almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Message-ID: <ZdwSXCaTrzq7mm7Z@boqun-archlinux>
References: <000000000000998cff06113e1d91@google.com>
 <20240213114151.982-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114151.982-1-hdanton@sina.com>

On Tue, Feb 13, 2024 at 07:41:50PM +0800, Hillf Danton wrote:
> On Mon, 12 Feb 2024 23:12:22 -0800
> > HEAD commit:    716f4aaa7b48 Merge tag 'vfs-6.8-rc5.fixes' of git://git.ke..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=100fd062180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcbd48180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6e642180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ca4bf59e5a18/disk-716f4aaa.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3d7ade517e63/vmlinux-716f4aaa.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e13f7054c0c1/bzImage-716f4aaa.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/00ba9c2f3dd0/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 4096
> > ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
> > ntfs3: loop0: ino=5, "/" ntfs_iget5
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0 Not tainted
> > --------------------------------------------
> > syz-executor354/5071 is trying to acquire lock:
> > ffff888070ee0100 (&ni->ni_lock#3){+.+.}-{3:3}, at: ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947

this is a mutex_lock_nested() with a subkey 0.

> > 
> > but task is already holding lock:
> > ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
> > ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265

These two are try locks.

> > 
> This report looks false positive but raises the question -- what made lockedp

This is not a false positive by lockdep locking rules, basically it
reported deadlock cases as the follow:

	mutex_trylock(A1);
	mutex_trylock(A2);
	mutex_lock(A1 /* or A2 */);

Two things to notice here: 1) these two trylock()s not resulting in
real deadlock cases must be because they are on different lock
instances, 2) deadlock detectors work on lock classes, so although the
mutex_lock() above may be on a different instance (say A3), currently
there is no way for lockdep to tell that. In this case, users need to
use subkeys to tell lockdep mutex_lock() and mutex_trylock() are on
different sets of instannces (i.e. sub classes). Note that subkey == 0
means the main class.

Regards,
Boqun

> pull the wrong trigger? Because of the correct lock_class_key in mutex_init()
> instead of &ni->ni_lock?
> 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&ni->ni_lock#3);
> >   lock(&ni->ni_lock#3);
> > 
> >  *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 3 locks held by syz-executor354/5071:
> >  #0: ffff88802223a420 (sb_writers#9){.+.+}-{0:0}, at: do_sys_ftruncate+0x25c/0x390 fs/open.c:191
> >  #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
> >  #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x20c/0x310 fs/open.c:64
> >  #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
> >  #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265
> > 
> > stack backtrace:
> > CPU: 0 PID: 5071 Comm: syz-executor354 Not tainted 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> >  check_deadlock kernel/locking/lockdep.c:3062 [inline]
> >  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> >  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> >  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> >  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> >  ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
> >  ntfs_iget5+0x3f0/0x3b70 fs/ntfs3/inode.c:535
> >  ni_update_parent+0x943/0xdd0 fs/ntfs3/frecord.c:3218
> >  ni_write_inode+0xde9/0x1010 fs/ntfs3/frecord.c:3324
> >  ntfs_truncate fs/ntfs3/file.c:410 [inline]
> >  ntfs3_setattr+0x950/0xb40 fs/ntfs3/file.c:703
> >  notify_change+0xb9f/0xe70 fs/attr.c:499
> >  do_truncate+0x220/0x310 fs/open.c:66
> >  do_sys_ftruncate+0x2f7/0x390 fs/open.c:194
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x7fd0ca446639
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff0baab678 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > RAX: ffffffffffffffda RBX: 00007fff0baab848 RCX: 00007fd0ca446639
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> > RBP: 00007fd0ca4d8610 R08: 0000000000000000 R09: 00007fff0baab848
> > R10: 000000000001f20a R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007fff0baab838 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> > 

