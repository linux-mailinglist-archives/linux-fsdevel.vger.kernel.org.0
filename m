Return-Path: <linux-fsdevel+bounces-36654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE029E75F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C98218878F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ECD1F3D35;
	Fri,  6 Dec 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VNo1ZZuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B181F3D32
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502605; cv=none; b=ZBUZJ/5/7ZOZmZ5fZWydr3CT/G5MLSwttq8lFL9mO7SDIrOtrJHOrWkBtC0yWEvrIESRHPN+5E/L3JouLYFZh4uOIT1sgCO6xbjIEQZWbVuaa5utctcKazRlT/zJmfjMGE6HKsurQzaYrcOjxa4mtvgFbP/vcGvJY2XpzhAoo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502605; c=relaxed/simple;
	bh=iASFRyjG/S6Ebor+z9GMdLWPsB4CFLmC/8GPn6xbuIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/YqTDpPmh6mexhsVpMWGPOpxMGYxAUgjrF7loQzu/Jxkxp2gSwoaNRIKA3fqTH1tTazRMIK7JVMTUqex0bWni2oKr6hc6gCPqLohhLLbVJAJ/Rz/Ao227UjTOE9YC2S00OlyYpu3FXxfBQYIdli2174pRWc22BRPec3Jrlf6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VNo1ZZuL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so5900417a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733502602; x=1734107402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsbyoNKlnVgtEFVmMOHQGbSnGiUHN7vF1skQ5qsVn1A=;
        b=VNo1ZZuLW7xNnfZONoo1LY6x6xu/AsFlNVdJYFWXwwa4DCUYfRqeXsa+8rg5n4pCoC
         lxYxRsm3+ElL+L0M3SWsAVLVc9FPbAsDMSzxx+DAUV0WGNiepfNYDe+7MTQnxyaR/06w
         dUzeQfL7B/sLsAFvVzUEA8d0COaugw3yLWs+jl4Oi2pk2Q+2voAWK26V4GCgrhj8PRB2
         5XQiu+KnrGNLfbn3L850HrA0ALSsn3Ov/JgTZSGQGYM83Tma6P4CNc/QgHtv1t2AVNsI
         c5cSZ8NN6ttbJNSd4hIDPV4yYUdDrGZET4xl5VtJ4Z3RzmSZrfhXXghbU1bPBn+/AJuw
         F/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502602; x=1734107402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsbyoNKlnVgtEFVmMOHQGbSnGiUHN7vF1skQ5qsVn1A=;
        b=E9tfGrIGaJO83eVHrwjRlc7e4/pg81Y5Y+RQGNbztvaIV3lSZpaO7D3t90Z2sLf1/7
         JeEizWQc0w+oQtxkSwXYxlWyEk8kSY5oLhZUDbXn+YSgHExXy/lAUOEsWHXN4ZxrgGIb
         Bj5tt8tJpkTUK/BmNG1jGWhOJ0m12SJuQbTVujhiup0N7TPVhZH33Xxuuv75WYGBq428
         AOcKHVN6UHKlWy09DUY5Pwb2BlWiL3nQvQCSgVrocdNGdmd9FoABf5ol69ASNrT3M/Pe
         bg1HZlfZctreFEc7dj7m98flCJg4lW+tORNhmNW4RMDyj19NzMtPwHoE9peuXTVDQjfk
         i9kg==
X-Forwarded-Encrypted: i=1; AJvYcCV06yDC9Ow8jr5GfHj4mNqATGpcDC4cMFE2GYPR2NyABsHtK+M0Y2y/3kWAoJS9QGUR72nfUQzspSG4R3Ek@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEOEaJy3ZUCfNbW7hcYaUvt12+1GlSIpJ6EH6UfdUXx9x3ABF
	xGkHTGfKeQEr0uMh5wS5AT+3LpyMcrpRiarkaNY7F3kzA8o5ru0zSxkacxbGMOsJAeXYx7a29GC
	uE5xuZ9VpR6+0qxhlq4TAmjCI+AbFP7pBTQbuZw==
X-Gm-Gg: ASbGncvvEXIWzDhtaedQ47VRhDHh0Pgrk4V88phKRhGp7iciW2S6aKRd5txaLtCliIm
	dYxDFMAkSn/LR/z/q2WpiKL6LARjzMXFE3mGE6v0xIbmoFOniKXhsTBBpR+QN
X-Google-Smtp-Source: AGHT+IGbY3n2R7iy/JSI5Qz+LHz0BZaCS4Pynm+3V2whRZY+qn9I/oJoXVOUWeyHTfw1THY79nJm/nfDYuqOilG9nz0=
X-Received: by 2002:a17:906:311a:b0:aa5:3c57:c407 with SMTP id
 a640c23a62f3a-aa63741d43fmr410899066b.16.1733502601718; Fri, 06 Dec 2024
 08:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
In-Reply-To: <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 17:29:50 +0100
Message-ID: <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:08=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> Similar hangs wth 6.12.2 (vanilla without your "netfs-writeback" branch):

(Correction: this was 6.12.3, not 6.12.2)

I tried with 6.12.3 + dhowells/netfs-writeback; David's branch solved
many problems and it took much longer to trigger the hang, but it
eventually occurred:

 INFO: task bash:6599 blocked for more than 122 seconds.
       Not tainted 6.12.3-cm4all0-hp+ #298
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:bash            state:D stack:0     pid:6599  tgid:6599
ppid:6598   flags:0x00000006
 Call Trace:
  <TASK>
  __schedule+0xc34/0x4df0
  ? is_dynamic_key+0x120/0x150
  ? __pfx___schedule+0x10/0x10
  ? lock_release+0x206/0x660
  ? schedule+0x283/0x340
  ? __pfx_lock_release+0x10/0x10
  ? schedule+0x1e8/0x340
  schedule+0xdc/0x340
  schedule_preempt_disabled+0xa/0x10
  rwsem_down_read_slowpath+0x6ba/0xd00
  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
  ? kernel_text_address+0xb8/0x150
  ? lock_acquire+0x11f/0x290
  ? ceph_start_io_read+0x19/0x80
  down_read+0xcd/0x220
  ? __pfx_down_read+0x10/0x10
  ? do_sys_openat2+0x106/0x160
  ? stack_trace_save+0x96/0xd0
  ? __pfx_stack_trace_save+0x10/0x10
  ceph_start_io_read+0x19/0x80
  ceph_read_iter+0x2e2/0xe70
  ? __pfx_ceph_read_iter+0x10/0x10
  ? psi_task_switch+0x256/0x810
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x206/0x660
  ? finish_task_switch.isra.0+0x1db/0xa40
  vfs_read+0x6e1/0xc40
  ? lock_acquire+0x11f/0x290
  ? finish_task_switch.isra.0+0x129/0xa40
  ? __pfx_vfs_read+0x10/0x10
  ? finish_task_switch.isra.0+0x225/0xa40
  ? fdget_pos+0x1b3/0x540
  ? __pfx___seccomp_filter+0x10/0x10
  ksys_read+0xee/0x1c0
  ? __pfx_ksys_read+0x10/0x10
  ? lock_release+0x206/0x660
  ? __ceph_do_getattr+0xe8/0x380
  do_syscall_64+0x64/0x100
  ? fdget_raw+0x53/0x390
  ? __do_sys_newfstatat+0x86/0xd0
  ? __pfx___do_sys_newfstatat+0x10/0x10
  ? syscall_exit_to_user_mode+0x57/0x120
  ? do_syscall_64+0x70/0x100
  ? irqentry_exit_to_user_mode+0x3d/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f71fb04f21d
 RSP: 002b:00007ffdd516a918 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f71fb04f21d
 RDX: 0000000000003003 RSI: 00005597dc55d4d0 RDI: 0000000000000003
 RBP: 0000000000003003 R08: 00007f71fb12a020 R09: 00007f71fb12a020
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001f4
 R13: 00005597dc485340 R14: 00005597dc55d4d0 R15: 00005597be8d7524
  </TASK>
 INFO: task bash:6614 blocked for more than 122 seconds.
       Not tainted 6.12.3-cm4all0-hp+ #298
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:bash            state:D stack:0     pid:6614  tgid:6614
ppid:6613   flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0xc34/0x4df0
  ? __free_insn_slot+0x370/0x3d0
  ? __pfx___schedule+0x10/0x10
  ? lock_release+0x206/0x660
  ? schedule+0x283/0x340
  ? __pfx_lock_release+0x10/0x10
  ? schedule+0x1e8/0x340
  schedule+0xdc/0x340
  schedule_preempt_disabled+0xa/0x10
  rwsem_down_read_slowpath+0x6ba/0xd00
  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
  ? kasan_save_stack+0x1c/0x40
  ? kasan_save_track+0x10/0x30
  ? lock_acquire+0x11f/0x290
  ? ceph_start_io_read+0x19/0x80
  ? find_held_lock+0x2d/0x110
  down_read+0xcd/0x220
  ? __ceph_caps_issued_mask+0x416/0xa10
  ? __pfx_down_read+0x10/0x10
  ceph_start_io_read+0x19/0x80
  ceph_read_iter+0x2e2/0xe70
  ? _copy_to_user+0x50/0x70
  ? __pfx_ceph_read_iter+0x10/0x10
  ? fdget_raw+0x53/0x390
  vfs_read+0x6e1/0xc40
  ? __do_sys_newfstatat+0x86/0xd0
  ? __pfx___do_sys_newfstatat+0x10/0x10
  ? __pfx_vfs_read+0x10/0x10
  ? fdget_pos+0x1b3/0x540
  ? __pfx___seccomp_filter+0x10/0x10
  ksys_read+0xee/0x1c0
  ? __pfx_ksys_read+0x10/0x10
  do_syscall_64+0x64/0x100
  ? do_user_addr_fault+0x401/0x8f0
  ? find_held_lock+0x59/0x110
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x206/0x660
  ? do_user_addr_fault+0x45e/0x8f0
  ? __pfx_lock_release+0x10/0x10
  ? do_user_addr_fault+0x401/0x8f0
  ? do_user_addr_fault+0x463/0x8f0
  ? irqentry_exit_to_user_mode+0x3d/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fa84a43a21d
 RSP: 002b:00007ffec8720278 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa84a43a21d
 RDX: 0000000000003003 RSI: 0000565007f224d0 RDI: 0000000000000003
 RBP: 0000000000003003 R08: 00007fa84a515020 R09: 00007fa84a515020
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001f4
 R13: 0000565007e4a340 R14: 0000565007f224d0 R15: 0000565005ba8524
  </TASK>

 Showing all locks held in the system:
 1 lock held by khungtaskd/163:
  #0: ffffffffae629b80 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x64/0x280
 2 locks held by bash/3365:
  #0: ffff8881661803e0 (sb_writers#19){....}-{0:0}, at: ksys_write+0xee/0x1=
c0
  #1: ffff888192604b18 (&sb->s_type->i_mutex_key#19){....}-{3:3}, at:
ceph_start_io_write+0x15/0x30
 1 lock held by bash/6599:
  #0: ffff888192604b18 (&sb->s_type->i_mutex_key#19){....}-{3:3}, at:
ceph_start_io_read+0x19/0x80
 1 lock held by bash/6614:
  #0: ffff888192604b18 (&sb->s_type->i_mutex_key#19){....}-{3:3}, at:
ceph_start_io_read+0x19/0x80

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

