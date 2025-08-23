Return-Path: <linux-fsdevel+bounces-58866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB6B3260B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F305E5BE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B8146588;
	Sat, 23 Aug 2025 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6cbKchF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAA2DF68;
	Sat, 23 Aug 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910452; cv=none; b=JExuoch7ikdVZS9Geo/F8kZDky/9fPUOZBTs5wMkNdVW2Q7SWqa5nAIswmXeLFDfWWRhWO8hBk1CqD28rPW2ctfeUVkbX73MB0hmuzEkM2GNAClX0J4+Ul61WRWH7pdHP6tpHAqJ+RELbqady96tZQbYN+jwUafRcrJk7MeDV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910452; c=relaxed/simple;
	bh=TOvtwkvLXbhmk+7X8flgWnWXgBUdF+/gzHPzLJMg2cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUJlKyAJgU1mC3w2prL8bwm+7dafv4NbNGUkkQKgz8Ze+7l5SVIhzKGffGUW7WzS4+mm9X8t35ReIpTEiQLPxw+TLvKb1I8Vrr9I3kGAxETZxDgfPDkrR/DYV7tr1yQvIBaJxYGGA782giPqGN9ehJOpX6DYkRXX0Rm6/iF7jGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6cbKchF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b297962525so24511391cf.1;
        Fri, 22 Aug 2025 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755910449; x=1756515249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53GjFjykpPBqD5WgL54wNUpUBUx+3gxukD1+nTnxWog=;
        b=R6cbKchF2nrHss7ygZ/6AxPiDi6ZEVYf5Tmhp6V/OSwVHeeBr7FVYIXwB2Bx7TOhqe
         ESvFRK8P+ozB38BGU3Srrm1B/5r/2GFRtmFQNC+aZUD2/jWbiwbi4LAMHGgiGOMdHcCj
         lShLRDmHQkGOliLpomPLUa8q/b9KGFwfqOXPJJn69E6vWALc7Yqpl/Ibnc/VRVp5vg12
         JwK7Q3raoWHS4wqQfoLC19TnLT8PjkO043RaQAyXMPeziei5POv30ZbIH0nZWYOAjyTn
         esaiKry9zESz4TYu5zAd6gBQs5D9xQ/R82PHqIfrjxGmX86mI38jYnEgMeTazx6RaHGz
         M4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755910449; x=1756515249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53GjFjykpPBqD5WgL54wNUpUBUx+3gxukD1+nTnxWog=;
        b=FTWLU+2hYBAMuiiDagpXogDWMX6uqLyt3GG6XEUl9XbYBpGvP56ExMx3LHUjoDIBm/
         GLZBm78TZXcosTugvRajuWE9CgelWmLCCXmVgQuFkhh5M1WmCJuqiiPpNzeVXdNgKi1v
         uEA56i/GuYXAx0jdbExa1Ax0DekRNEYDoHgXOazb0PTVU/WNe079pFQTTuFYPlXQWdNt
         KDFjFgGTHgJLGi5MaXGNGYZyQUzlDed1KyhyeUMqAC3XhCjrcRVB3jNzhSDoBZ/rGHeN
         XB85miXCx7dbO/oTdn2Pecyr8m4VZunkixk//vzhspve8c+4RGyj/8J6DceJhuS6Kr7V
         vReA==
X-Forwarded-Encrypted: i=1; AJvYcCUcC7jSkRwytBT2yL2PM+h0XFtwdqFRndq/xlIsNZW6EmJMmQPoz1gr2Vc/WAK5O8EcKWJJl8vCJ3jFSS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd0hM93O9I6BXtBgKeFIcDdP4o+X0FrBy7OEDxaY1Z1WaqKj2
	Hyl9qRiY1Fi5BGchqvDHjSPFo6Yc6b0X9CGJzoaqqN6uOW6Ngyx2WTAe5+pWFtYxST3cUUEXKdY
	BefC64bQMMWyJnDkSq//GfHhBzuMIIVc=
X-Gm-Gg: ASbGncufu6SMeiA+MeGkl3Dp0+TSZ9WmkaCrz/smxelkYBdQxgKAT2BikHNT8w77CS9
	RNY4cfJpl83ohPNb0+KretFKmTzFnjRAXLQJhwKpBOaPk2voL7O1Yt9hTDSCmfnPFxZWKzSbuID
	SqFclfgX7fVGmdilHEM65uuBWk3gfePm+PtL4NP3CdawjAXLhxmgUKL7vCFDXrcp0YpFc4w/wG8
	6gewIFB
X-Google-Smtp-Source: AGHT+IFHms8iyND1wi//Z1dZcvUEce1eZQqqkPGz+r6Yfau+D9asJnAr08DF/wv6dZF01ZM+kZkKPL0XCJNGeRSY2k4=
X-Received: by 2002:a05:622a:581a:b0:4af:4bac:e539 with SMTP id
 d75a77b69052e-4b2aae2e387mr77427581cf.3.1755910449130; Fri, 22 Aug 2025
 17:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
In-Reply-To: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 17:53:57 -0700
X-Gm-Features: Ac12FXykfvJlT3U4O50PYkeJ9A-cM0Cr4LFU_PlCErQyFP1u9wxCcYdE2rFp1VI
Message-ID: <CAJnrk1bSD+HfwLqbFv8gsRsPt0kRsr8JZcEXdqBWuKh2Qnz_yA@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
To: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:24=E2=80=AFPM syzbot
<syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cf6fc5eefc5b Merge tag 's390-6.17-3' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15348c4258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7511150b112b=
9c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d215d165f9354b=
9c4ea
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147a5062580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D139caa3458000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-cf6fc5ee.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a27518272e48/vmlinu=
x-cf6fc5ee.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cf3f4cc06dfd/b=
zImage-cf6fc5ee.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in fuse_retrieve fs/fuse/dev.c:1911 [inlin=
e]
> BUG: KASAN: slab-out-of-bounds in fuse_notify_retrieve fs/fuse/dev.c:1959=
 [inline]
> BUG: KASAN: slab-out-of-bounds in fuse_notify fs/fuse/dev.c:2067 [inline]
> BUG: KASAN: slab-out-of-bounds in fuse_dev_do_write+0x308b/0x3420 fs/fuse=
/dev.c:2158
> Write of size 4 at addr ffff88803b8fc6dc by task syz.0.17/6135
>
> CPU: 0 UID: 0 PID: 6135 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  fuse_retrieve fs/fuse/dev.c:1911 [inline]
>  fuse_notify_retrieve fs/fuse/dev.c:1959 [inline]
>  fuse_notify fs/fuse/dev.c:2067 [inline]
>  fuse_dev_do_write+0x308b/0x3420 fs/fuse/dev.c:2158
>  fuse_dev_write+0x155/0x1e0 fs/fuse/dev.c:2242
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x7d3/0x11d0 fs/read_write.c:686
>  ksys_write+0x12a/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f440eb8ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f440f9e1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f440edb5fa0 RCX: 00007f440eb8ebe9
> RDX: 0000000000000030 RSI: 0000200000000140 RDI: 0000000000000004
> RBP: 00007f440ec11e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f440edb6038 R14: 00007f440edb5fa0 R15: 00007ffddcd08da8
>  </TASK>

Thanks for the report. I think the issue arises in cases where the
calculation for num_pages has to get rounded down to fc->max_pages and
a non-zero offset is passed in.

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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: upstream cf6fc5eefc5bbbbff92a085039ff74cdbd065c29

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..e84e05de9cdb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm,
struct inode *inode,

        index =3D outarg->offset >> PAGE_SHIFT;

-       while (num) {
+       while (num && num_pages) {
                struct folio *folio;
                unsigned int folio_offset;
                unsigned int nr_bytes;
@@ -1914,6 +1914,7 @@ static int fuse_retrieve(struct fuse_mount *fm,
struct inode *inode,

                offset =3D 0;
                num -=3D nr_bytes;
+               num_pages -=3D nr_pages;
                total_len +=3D nr_bytes;
                index +=3D nr_pages;
        }

