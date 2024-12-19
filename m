Return-Path: <linux-fsdevel+bounces-37786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D163F9F7A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3537D188CBE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E590223E6D;
	Thu, 19 Dec 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsPNORym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E922259E;
	Thu, 19 Dec 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607092; cv=none; b=qLsjAectqzrmFVh27yc7CY5kQQmPJHI3st+FUUd6mztV4QJ1vOLu885mTs5jfE+mUjxm7QjYgvCd+buq9V5P8L5stPguf3BNOwpHpbnUgLJhhuAy8ClUJ1hnDD1gAtMeLxd4wCbFOanVVMLhRM8XZqgP0xh65n6tjbE0M4LNONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607092; c=relaxed/simple;
	bh=R+TiUcgLo24VJojmHr9ZqzBvlzZ43Li6LyDvZJ8uy3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niLjxW/rTSaniUycPVK/7fgxOeQrjcpQ8ZX26dmNxEM372dPxcyqq104mTWFXanfxXZESSrXZltkprhAUTM6joJ6cZbpOnENYeCFYyPCR2I7oszGJXxczLRpWrZh3+Og/p/pg/WlvrfSBygv498cdf3SJpJAoXY6cwzqSWMVmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsPNORym; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so847019a12.0;
        Thu, 19 Dec 2024 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734607089; x=1735211889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfnNYXlpOFuqbnlDS2yLgsFocuX0idGNUiC2LJkMgQ=;
        b=ZsPNORymrGVVdDXSTZR698R7funSZ/3ac+kIhaT1CF7rUpV6MZ7mJdhF+nMqmKBk86
         gOL7DxZWmoSlE7r2i47S+RIqW9DfYkBTJPT8G+qETfC/GbBvc+oiOPuVa2wm0VxMSXP4
         HOnEhAYCVawulf2+ZldVMmvSc+IvfMaydUY68tq0YG/JTC4oL0YHFy/npqBlEFvnpgic
         ltAFIO4aD/Z3AaM+Je14ZM0P7XppS08CXP6tkyWLWYKmrwMk+jJXzl0l8VKsjXBxL3GF
         QzGO1FsbI5WOM+IaHHCW+1la0D3gqOYM9rIeb/+BBw8ys5mjp9K8sMR5Af6bQbvPTp/T
         nEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734607089; x=1735211889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcfnNYXlpOFuqbnlDS2yLgsFocuX0idGNUiC2LJkMgQ=;
        b=wUPkQ8L4JaHJ8OU9HBGMtSe1OQrOVk2ZsCZCqTLQ0QQcrZYLxS/eTL5kcBe683xkoi
         Ly4sJmusWlDSxbphaF2Mzexc+pKh2rsXvB/8e3O7gT2Ul+kCnCeLli6/anpaUXMnPq1D
         THiYdCqPOFVjgGEB5jSH3Wt/2xvOETISXBy5t5ww69qBiil3/UJqju4AXjrt05aoGmIY
         tNUTnY6F+CY3NThICiCHutNZbrds9zwwDa/+6a53NPGC63v2r0Rj4YLKWbf9j8LXWRha
         4T255kRij3YlUHapj6CY/wfIKv7n4f4sfwuTsTExgzk8ZRD/JeLpVAdjznCa3927OA5z
         8YZA==
X-Forwarded-Encrypted: i=1; AJvYcCXCdcOUOrmgz3cm+i7RsADylKD9uKJbVz+lvHgNMcxlrVnwSM4MZjsam79nKCueND5T7m7yqcTqCiJLQLv+7Q==@vger.kernel.org, AJvYcCXU8dIH1VqBIR0/wE0/b8jKa3c8optgC0tg/KxShmqJMEk7tFvv7O1MLzXtHcb7K1WigcgMQmvLW+blHJ13@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6Xh+kAHEHWFo1UJN/mReL4cLNNaEA+6enRNHuCBiNcEU2sji
	KsrnpJ6XAyrlJV8fpHZRIoXbL1OuafHrvTKiwLhQ016F4ccTyAvkeuWrpyuBIk+VN9x5PdK/c31
	EfGyNU7bzTVH/mIY/hLGEPdtgwuU=
X-Gm-Gg: ASbGnctD9ABt5X9Pc/jl1bqyMd+8tWiDJvmwQKyhkG8yfQcot0FQHJDS4ljFpNQqYDk
	gic7pjrGHAjMZWbc4g7NjBivrhNYLbOdk1Ju1Mg==
X-Google-Smtp-Source: AGHT+IF8XBbdoYd8J8D9hYDXcmNIUPnKDOc41b81Q4yMHsBpso6pmq6OVFUMeBsGMwPNhyMTL1B/TDx3WUxiAjLmfJE=
X-Received: by 2002:a05:6402:51cb:b0:5d2:7199:ae5 with SMTP id
 4fb4d7f45d1cf-5d7ee3b3924mr4713143a12.5.1734607088533; Thu, 19 Dec 2024
 03:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <671fd40c.050a0220.4735a.024f.GAE@google.com>
In-Reply-To: <671fd40c.050a0220.4735a.024f.GAE@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Dec 2024 12:17:57 +0100
Message-ID: <CAOQ4uxg36w5rE6RgOCLBqbPsmytJ24cXhhahuQE0H8pqSZ_FJg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_encode_real_fh
To: syzbot <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:12=E2=80=AFPM syzbot
<syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 arch=
i..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D178bf64058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfc6f8ce8c5369=
043
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dec07f6f5ce62b85=
8579f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D112628a7980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D104bf64058000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinu=
x-c2ee9f59.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/b=
zImage-c2ee9f59.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
>
> RDX: 0000000000000000 RSI: 0000000020000440 RDI: 00000000ffffff9c
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003932
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b4e42fc
> R13: 0000000000000004 R14: 431bde82d7b634db R15: 00007ffc9b4e4330
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5103 at fs/overlayfs/copy_up.c:448 ovl_encode_real_f=
h+0x2e2/0x410 fs/overlayfs/copy_up.c:448
> Modules linked in:
> CPU: 0 UID: 0 PID: 5103 Comm: syz-executor195 Not tainted 6.12.0-rc4-syzk=
aller-00047-gc2ee9f594da8 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:ovl_encode_real_fh+0x2e2/0x410 fs/overlayfs/copy_up.c:448
> Code: 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 05 b6 75 fe 90 0f 0b 9=
0 eb 14 e8 fa b5 75 fe 90 0f 0b 90 eb 09 e8 ef b5 75 fe 90 <0f> 0b 90 4c 89=
 ff e8 b3 6a d3 fe 49 c7 c7 fb ff ff ff eb 8b 89 d1
> RSP: 0018:ffffc9000b1f73c0 EFLAGS: 00010293
> RAX: ffffffff831f21f1 RBX: 1ffff9200163ee80 RCX: ffff88801fbc2440
> RDX: 0000000000000000 RSI: 00000000000000ff RDI: 00000000000000ff
> RBP: ffffc9000b1f7470 R08: ffffffff831f208c R09: 1ffffffff2039fdd
> R10: dffffc0000000000 R11: fffffbfff2039fde R12: 00000000000000ff
> R13: 0000000000000080 R14: 1ffff9200163ee7c R15: ffff888036790300
> FS:  0000555590223480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6fdf3d7709 CR3: 0000000040e6e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ovl_get_origin_fh fs/overlayfs/copy_up.c:484 [inline]
>  ovl_do_copy_up fs/overlayfs/copy_up.c:961 [inline]
>  ovl_copy_up_one fs/overlayfs/copy_up.c:1203 [inline]
>  ovl_copy_up_flags+0x1068/0x46f0 fs/overlayfs/copy_up.c:1258
>  ovl_setattr+0x11d/0x5a0 fs/overlayfs/inode.c:40
>  notify_change+0xbca/0xe90 fs/attr.c:503
>  chown_common+0x501/0x850 fs/open.c:793
>  do_fchownat+0x16a/0x240 fs/open.c:824
>  __do_sys_fchownat fs/open.c:839 [inline]
>  __se_sys_fchownat fs/open.c:836 [inline]
>  __x64_sys_fchownat+0xb5/0xd0 fs/open.c:836
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6fdf3812f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1b 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc9b4e42a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
> RAX: ffffffffffffffda RBX: 00007ffc9b4e42b0 RCX: 00007f6fdf3812f9
> RDX: 0000000000000000 RSI: 0000000020000440 RDI: 00000000ffffff9c
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003932
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b4e42fc
> R13: 0000000000000004 R14: 431bde82d7b634db R15: 00007ffc9b4e4330
>  </TASK>
>

#syz test https://github.com/amir73il/linux fsnotify-fixes

