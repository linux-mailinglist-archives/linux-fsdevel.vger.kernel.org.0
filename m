Return-Path: <linux-fsdevel+bounces-66976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA73C32694
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 18:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F38189203D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919C339B38;
	Tue,  4 Nov 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxt+8rhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918617DA66
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278341; cv=none; b=kn18G1TeMPcf3394cg9Od6OCfSf4JJTviw6kTRyNFneLWFlg9j7V437ACo3N8bgT74zpJCq/TSvLVmqa7EFHSvH3ViJZWtouH5Nf1CsB8GmSEVbuz8RTjvK9bi7Vd07zV9Zi7Bjc3ggMRI1zXTcyphHBbR0boJ7YK9i67QnHcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278341; c=relaxed/simple;
	bh=yoEeZv5HefId6LCZwnxFXkJr9LVmFJNEYdziYl5cpWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzD23sTkjWPQGj5PJL+7CEgyenY7DaLCHTdCOkUp9uakLYW62W6RJP726TFqpnwtrWASJ8/xkiKFVyYDuXM19nui0upGwUFwLDIMgr+2EtGz8E6DxzV3TKTjz7jtcySrg0YR4/XpwsvZ8rXSM4F9i3w27zjUGPbFDlVRLYZ5S00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxt+8rhS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b144ec3aa8so100604385a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278338; x=1762883138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6x1mMEr1ViK/4UEn7s/n9KiNBM26zd4bqgPz4hzX20=;
        b=Wxt+8rhSEuBstrG7hKDqn5aSs+9IAtJttm0N4JEwVIoBcaQWw7gsLIvpkUKkEP/Kpp
         qf1Jrf2WbswBAv1bUMqti4DdvOIoI2xadJsrVrhQ6lOpqm7EMOOpzSISUt9cXYGVtVm3
         xXWlp5DdzQg7RirdlAn1/4PoZoM7cymPQIFYZkI6HULpoB3Dh72vtftga2z3SS4t0jmE
         beKLWhxDUeGPe68Z7k1CV6eoX1zzX2848n4fJHPmB66x+r7879pkcw4hi7mWN2XnKS9g
         KAqSuKjGaEr4l2McLdmLhycJ49x+/2QDyLLX4NkZpgfV+uduCEzqMCi6AU3VisvjnPa7
         uycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278338; x=1762883138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6x1mMEr1ViK/4UEn7s/n9KiNBM26zd4bqgPz4hzX20=;
        b=X+MhtRwNW6d/2wh34/Madfxo0KTLZdmLWh+mj15JOZDRMDd8RxtBHwx3S13g09jtA6
         LcbISXhv16rMzqGpLDr4CDQvut/eMDzD3ryeFopd1JnrLTYr0bH5xQYW8TZ2VucQ220a
         ih+Nm6w6N07JLWhtDBE/oEudC5MHJoLfniwDNaluXyWfwbyJtJkJ5mhklIZJHSCfZVwb
         5vCQIIdmGfApF5UiHdkgOWghKP7wmcqP1CAfai7Fpn2Bce1p1uWGlTJDwov9AmlbDwDO
         3V/BwfswIkJN1huXo+PaK1GZdltM7azy51cn63cyXZsIXfmW0xZJ81sBfV978SQxR4uQ
         6iqw==
X-Forwarded-Encrypted: i=1; AJvYcCVmvOI19PfhExQ2RXGJuQLPkupqgUlRDnUOLnNxVOdwWOJIhe0nwGTj02qrLhPhctJmdKlAw2KwTUgiE2mc@vger.kernel.org
X-Gm-Message-State: AOJu0YyCRqPkYTD/h9cYdixAAg1JZbwkhGcNJyzmO7jRn/WC8n6QQOV8
	FChTNmlOdy6DCLCd2jrcV9q3bVPIHP7Mpx5bh+7dr/Dp8B8EJPpHXg+ib6JD6qK7gC0VCO1+Wvu
	z8s7AIzsjO2Fg8Sm/IeLnw2FqSiGcUD4=
X-Gm-Gg: ASbGncuxViJjCWCkfTxpAYoJO8NQOOOQzLZ/3dwqeGZoDBllxLTI0aFgWQxMEuW+F0J
	OZc/toHEGtopI7TssVougbiDgwh2JVJnh/I4zp2V/MzzGL8XBqlDZy3E9DWDVliIXtI9sdFJKSy
	5UvvDiHptUAp5ZvRNiRjKbNHD+Ia0ElUVmLxCuE3bOhtlSRfmGctol3AeuESv9U7QlOzYOyoXF9
	5Uv1g5gq21z5iYN1Ps5Ew497DcXmbls2UpszW/2NoCrEGZTwC+J/rF+eibFxsdm7B4DMo0cLgJS
	21t8Bb6uFkFvENBQK+FaAhUDBKcUqVZT
X-Google-Smtp-Source: AGHT+IHIemEGumbWMvCLAES8ZvcTesT/uJ+/JeVAzhULJ3mU86DKceJjKHvDWF4VbBI6aTt9xr2jHTuPM+nQhLeXf3k=
X-Received: by 2002:a05:620a:44d1:b0:80d:9993:889d with SMTP id
 af79cd13be357-8b22083861fmr71066585a.20.1762278338264; Tue, 04 Nov 2025
 09:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
In-Reply-To: <69096836.a70a0220.88fb8.0006.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Nov 2025 09:45:27 -0800
X-Gm-Features: AWmQ_bmsZ0FX7daxSTx60bXg7avbovxZmS1g2DtoGMxWSn0aBtqMvbz1O5rliIw
Message-ID: <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
To: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>
Cc: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 6:43=E2=80=AFPM syzbot
<syzbot+3686758660f980b402dc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> WARNING in get_data
>
> loop0: detected capacity change from 0 to 16
> ------------[ cut here ]------------
> WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 k=
ernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.585/7652
> Modules linked in:
> CPU: 1 UID: 0 PID: 7652 Comm: syz.0.585 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
> Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 e=
e 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 a7 19 1f 00 90 <0f> 0b 90 eb 05=
 e8 9c 19 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
> RSP: 0018:ffffc900035170e0 EFLAGS: 00010293
> RAX: ffffffff81a1eee9 RBX: 00003fffffffffff RCX: ffff888033255b80
> RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
> RBP: 0000000000000012 R08: 0000000000000e55 R09: 000000325e213cc7
> R10: 000000325e213cc7 R11: 00001de4c2000037 R12: 0000000000000012
> R13: 0000000000000000 R14: ffffc90003517228 R15: 1ffffffff1bca646
> FS:  00007f44eb8da6c0(0000) GS:ffff888125fda000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f44ea9722e0 CR3: 0000000066344000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
>  prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
>  _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
>  prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
>  printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
>  console_emit_next_record kernel/printk/printk.c:3062 [inline]
>  console_flush_one_record kernel/printk/printk.c:3194 [inline]
>  console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
>  __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
>  console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
>  vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
>  _printk+0xcf/0x120 kernel/printk/printk.c:2448
>  _erofs_printk+0x349/0x410 fs/erofs/super.c:33
>  erofs_fc_fill_super+0x1591/0x1b20 fs/erofs/super.c:746
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1752
>  fc_mount fs/namespace.c:1198 [inline]
>  do_new_mount_fc fs/namespace.c:3641 [inline]
>  do_new_mount+0x302/0xa10 fs/namespace.c:3717
>  do_mount fs/namespace.c:4040 [inline]
>  __do_sys_mount fs/namespace.c:4228 [inline]
>  __se_sys_mount+0x313/0x410 fs/namespace.c:4205
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f44ea99076a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 8=
4 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f44eb8d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f44eb8d9ef0 RCX: 00007f44ea99076a
> RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f44eb8d9eb0
> RBP: 0000200000000180 R08: 00007f44eb8d9ef0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
> R13: 00007f44eb8d9eb0 R14: 00000000000001a1 R15: 0000200000000080
>  </TASK>
>

This looks unrelated to the iomap changes and seems tied to the recent
printk console flushing changes. Hmm, maybe one of these changes
[1,2,3]?

ccing Andrew and Petr, who would know more

[1] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-=
v3-1-00f1f0ac055a@thegoodpenguin.co.uk/
[2] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-=
v3-2-00f1f0ac055a@thegoodpenguin.co.uk/
[3] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-=
v3-3-00f1f0ac055a@thegoodpenguin.co.uk/

Thanks,
Joanne

>
> Tested on:
>
> commit:         98231209 Add linux-next specific files for 20251103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1370a29258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D43cc0e31558cb=
527
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3686758660f980b=
402dc
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Note: no patches were applied.

