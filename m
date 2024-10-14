Return-Path: <linux-fsdevel+bounces-31841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D494999C02D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587E31F23565
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4214601F;
	Mon, 14 Oct 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU2+SkDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641B145B25;
	Mon, 14 Oct 2024 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888022; cv=none; b=UxL0hX5njRkKVsJUWBWKyFGDXvOENtYAXTCrUUab4D4Gl4yOuPPSIiidtXAKVLUW8KMQnIK6h56RBH5AGcX2WxJxE+4d+Ud2ubhPLgth9Q1xCoHHcJT8tcBcvhp6g+HOkaJIwx4q3G/FMzEyeK/OVwic+65OU4wN7+uAAjIz5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888022; c=relaxed/simple;
	bh=qeMWDu12NNYM+7QV9eOamgVscxaBtn9XX7DSuKmcOuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+AYLPjn2rjqHb8tbVtfs6g+z0fB4DMFh3oP9cq6VFQxxFPmXDCP5iFxy8e9DsMnm2IyxEOXCTpzjq8ihcEpAcJjJRu89waTWHcNzwvg7eqEYSMKOREJwDnrdSrT4xBfQNSQQA9n7AagktC/ai+4/QJujL5hYwHx9MAaeW42HTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU2+SkDV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a998a5ca499so590039966b.0;
        Sun, 13 Oct 2024 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728888017; x=1729492817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR0VkSzHgQed4LGhsboXO1HzDsdYANLCRc7hah45+yU=;
        b=NU2+SkDVHtv9eIx8wM2yx6rHcrLmRNloiMUDe3roOJ8cUFWB3kT1gTw5LmtRcg8UbI
         wXaylKB4ohKywqxutReVd9lx18XXlBTWFJRIgNYSaa1Qeg5VSBQ2NZeTNGmiV88R0tdN
         ph4LATz7Ssst4e8EtzfI0gUnupeSq/Q/HeSEcNsRL3uPgN0Za1ixJYS7CBWL1scRkUq2
         2Qyb8MFnKVDzyBROMbi8pFItB3OtKYZo+HrALm3ipyyYtive8fW6kHt33iqxWZj+Grah
         vr7iCMvwA/lPXCh4mgK5IaUAks9UtG0WJCE1egNC82PtRlgKnFe1wu6avBFw6gdbXmaX
         N0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888017; x=1729492817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR0VkSzHgQed4LGhsboXO1HzDsdYANLCRc7hah45+yU=;
        b=btG4IEJDSdy9NE67lCmsWVWg8W3jHsbJAtM61CumKxzlsvekGsDVYaaWWpwm/NK0WY
         eNrSmRpPUIlB5cMMg79pmNSrfjPLiYi3N+20VIIY4RSpo8e0065xeutI1dHxr4rTc93w
         LZ95RW8qK3UUpe1ksWkNJZCZXpbBGyKMoG4UeXBs1aVTKp3Oe+CCcfL/3RtndZz1iphA
         +VnRv0jopSMzZP8mnQvJEcuh/NcuSMwuOFLaxT8fTCXS0yzadrcgO83L31jEeUiwgHFr
         MR3ORBkwV2V/z80zG0mOoCdy/tVKtxfKMqgDq0R4f/RA/2d1hetYsJQE30i7Y+Y2AptV
         +wwg==
X-Forwarded-Encrypted: i=1; AJvYcCUQVSJusjmfoaoQOZCyDaeJPVcg4uJEI7tUl/sRHjdjjfZHhHZqOFx89PVv073zTD2p1UlcVSCEu3e1QQ+9@vger.kernel.org, AJvYcCVJ5IHAVn/brBZQPhoegexlIODLYv22pUCkGmF3UeDCtpflJpoLeNyyPIl6Yz2E88OqeQsYJ+6SCj8uouuG@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsMVw8K/toPaBDrRMtwTzmsMKJurfqDbrwhzoZVSRo7m28rfs
	Viqusyx6cu1uL5kMcfRCtmTrY4WeKZUXr2wHCos0ezAVg6qTf5gAv/51Xfy97L5k2OWPKkMWIJY
	Elzb1a4DfQMW2PdMAxQfCZaecIgQ=
X-Google-Smtp-Source: AGHT+IExpJghYioV548dHA4Vly+YTesctkQRh7Suh3jV5PgqvkuqJWKYh/PFxaOj5DjRa0XLAezNCR3pXRc8LJZOTw8=
X-Received: by 2002:a17:906:da83:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-a99e3e9c139mr665660066b.61.1728888017171; Sun, 13 Oct 2024
 23:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb562.050a0220.4cbc0.0042.GAE@google.com>
In-Reply-To: <670cb562.050a0220.4cbc0.0042.GAE@google.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 14 Oct 2024 11:40:05 +0500
Message-ID: <CACzwLxgJb=xUCO+TFN_Y6SZ6YxoRn=pg0yfif3+GuHK8kL3x0Q@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in xas_create / xas_find (8)
To: syzbot <syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:08=E2=80=AFAM syzbot
<syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2f91ff27b0ee Merge tag 'sound-6.12-rc2' of git://git.kern=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D155c879f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D95098faba89c7=
0c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db79be83906cd9ba=
b16ff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14933c4ac457/dis=
k-2f91ff27.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6725831fc1a1/vmlinu=
x-2f91ff27.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/98d64e038e72/b=
zImage-2f91ff27.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com
>
> loop4: detected capacity change from 0 to 4096
> EXT4-fs: Ignoring removed nobh option
> EXT4-fs: Ignoring removed i_version option
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in xas_create / xas_find
>
> write to 0xffff888106819919 of 1 bytes by task 3435 on cpu 0:
>  xas_expand lib/xarray.c:613 [inline]
>  xas_create+0x666/0xbd0 lib/xarray.c:654
>  xas_store+0x6f/0xc90 lib/xarray.c:788

AFAIU, xas_store() itself, doesn't have a locking mechanism,
but is locked in xa_* functions. Example:

void *xa_store_range(...)
{
   XA_STATE(xas, xa, 0);
   ...
   do {
      xas_lock(&xas);
      if (entry) {
      ...
         xas_create(&xas, true);
   }
...
unlock:
   xas_unlock(&xas);
}

Same thing is for the another racing xas_find() function:

void *xa_find(...)
{
   XA_STATE(xas, xa, *indexp);
   void *entry;
   rcu_read_lock();
   do {
      if (...)
         entry =3D xas_find_marked(&xas, max, filter);
      else
         entry =3D xas_find(&xas, max);
      ...
   rcu_read_unlock();
}

In this KCSAN report, xas_create() and xas_find() are racing for `offset` f=
ield.

>  __filemap_add_folio+0x3cc/0x6f0 mm/filemap.c:916
>  filemap_add_folio+0x9c/0x1b0 mm/filemap.c:972
>  page_cache_ra_unbounded+0x175/0x310 mm/readahead.c:268
>  do_page_cache_ra mm/readahead.c:320 [inline]
>  force_page_cache_ra mm/readahead.c:349 [inline]
>  page_cache_sync_ra+0x252/0x670 mm/readahead.c:562
>  page_cache_sync_readahead include/linux/pagemap.h:1394 [inline]
>  filemap_get_pages+0x2c1/0x10e0 mm/filemap.c:2547
>  filemap_read+0x216/0x680 mm/filemap.c:2645
>  blkdev_read_iter+0x20e/0x2c0 block/fops.c:765
>  new_sync_read fs/read_write.c:488 [inline]
>  vfs_read+0x5f6/0x720 fs/read_write.c:569
>  ksys_read+0xeb/0x1b0 fs/read_write.c:712
>  __do_sys_read fs/read_write.c:722 [inline]
>  __se_sys_read fs/read_write.c:720 [inline]
>  __x64_sys_read+0x42/0x50 fs/read_write.c:720
>  x64_sys_call+0x27d3/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:=
1
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888106819919 of 1 bytes by task 9109 on cpu 1:
>  xas_find+0x372/0x3f0 lib/xarray.c:1278
>  find_get_entry+0x66/0x390 mm/filemap.c:1992
>  find_get_entries+0xa4/0x220 mm/filemap.c:2047
>  truncate_inode_pages_range+0x4ac/0x6b0 mm/truncate.c:378
>  truncate_inode_pages+0x24/0x30 mm/truncate.c:423
>  kill_bdev block/bdev.c:91 [inline]
>  set_blocksize+0x258/0x270 block/bdev.c:173
>  sb_set_blocksize block/bdev.c:182 [inline]
>  sb_min_blocksize+0x63/0xe0 block/bdev.c:198
>  ext4_load_super fs/ext4/super.c:4992 [inline]
>  __ext4_fill_super fs/ext4/super.c:5213 [inline]
>  ext4_fill_super+0x38b/0x3a10 fs/ext4/super.c:5686
>  get_tree_bdev+0x256/0x2e0 fs/super.c:1635
>  ext4_get_tree+0x1c/0x30 fs/ext4/super.c:5718
>  vfs_get_tree+0x56/0x1e0 fs/super.c:1800
>  do_new_mount+0x227/0x690 fs/namespace.c:3507
>  path_mount+0x49b/0xb30 fs/namespace.c:3834
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4055 [inline]
>  __se_sys_mount+0x27c/0x2d0 fs/namespace.c:4032
>  __x64_sys_mount+0x67/0x80 fs/namespace.c:4032
>  x64_sys_call+0x203e/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:=
166
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0e -> 0x00
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 9109 Comm: syz.4.1794 Not tainted 6.12.0-rc1-syzkaller=
-00257-g2f91ff27b0ee #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> EXT4-fs (loop4): mounted filesystem 00000000-0000-0000-0000-000000000000 =
r/w without journal. Quota mode: writeback.
> EXT4-fs (loop4): unmounting filesystem 00000000-0000-0000-0000-0000000000=
00.
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

