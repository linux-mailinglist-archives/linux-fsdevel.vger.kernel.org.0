Return-Path: <linux-fsdevel+bounces-36641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FE9E72DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E6628203F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAACB207DFD;
	Fri,  6 Dec 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OH7cNNwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5B207670
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498033; cv=none; b=SGd8LABhfvzMl/H1Em/GG2Hhiv4nk5If1aJyZn04kYpDMsKmbiFlsRnDs/imzBibJ6p9+rDvLippI6UaVFM73l3aSJmlE+hSWMC2Q6+XWq2nkKEgl2LqAa2BiKOL6S/9AIqiuYkl4UJasbuTMyUdAwhw2TCm3L0gObKCXfIU+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498033; c=relaxed/simple;
	bh=8liA1sTQEEmfq+FT684h6YxI0E+3xtwS2RK5SUSEfj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcoQC0uRCOjSA7P0DDVtRCnGZGq1dw8KpIZp4JVsrgDFImyADlce0rEFomDm0ccb9yw6H7wYMsa3VBtRgO1QJdhIFIFVaZ6PJUbtxVLbvhoZ2nRHuoH0qL6nHs+9BU+memV20gIrv5DDAgF5Yb0jkjmYJxunKcKylBoxdydeBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OH7cNNwk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa5366d3b47so343150666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733498030; x=1734102830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBIylH2WoqXEC5PXsPbLbKHH/xROShxWYjYAl4Pnads=;
        b=OH7cNNwkM5VbtU03UcyLNkPiu/QYHXu60Y0ebSnD7qX0ccDXMIx+LtndlWDPYckT9m
         NJOvzrSgDVO8FrDl6bWzbEQ6oXidNO2XPArmhHySX7UfRwp6lm11KAO9vMPyDXi1S38b
         JysD6XC7gWAshJ95y/QlHBgtjqmHYNp2uZeKrf+M/jKDVVDBjkeEIfE769mU8pdaEwHZ
         6BsKfRCFgpAloNbBbNEdwFa05VMPnB1nLTWSKHu2W39r1SBkv5USjU2SIcM3Bf7zJ/4q
         9sb0gQxbQIBiy6KBNE/+IZg0wizWrovAG5n/u1+ZENvqe3eC9HVOajI7pjImocQKOnMO
         qYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498030; x=1734102830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBIylH2WoqXEC5PXsPbLbKHH/xROShxWYjYAl4Pnads=;
        b=k3e0GzOOSqdVFys+Q1hN2lR9oxXXN9lz4P7JhuunudOnbCtvpn+UHNaI22b2YvBfqx
         RHnW2bGAKnRc9v2TwOWu/SCGCQ8n1sziN1SfE86AiliaABfTxBWegVmf6SnpQR6AySF2
         6oR1Em+RUjlvOce9/3fzZbfd6+i11EsECvntHiyw9ybSoFlwj4bbiGxUMOpdQGIN4ZJT
         R7vpgiFYNRVETD6cT4cUKu7eYeabvYOENwsEQ93veObOLV5qMO3vQDO6/qqMm8PNxGRX
         mB3QWfMEuaxBKL66Pw1qFCU/+z7kOEtvOyurL1I7IUUQbSDwwDexJ6Fr/BVwdxwF80fW
         m+wg==
X-Forwarded-Encrypted: i=1; AJvYcCUScoLo1Oj/M+n9nch4Dvwucb8uuXp7GRixS5SHsCQFhCzZ63F1r8ra5EJP3ll76lf5jqPBi5icmE0UztaB@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkPmG6Nl9LBnhFCyWCsY+/qOHkGcQjvot/IKluXfjmnt+93rp
	SilvIQhlvaHgB4H1w38GyEzOA9SnRPs1rQbzlL97ZmMeuONOyOieMUKxKa7lg8KH3wpxyX/em6N
	PJ/s5QA1olL17WTJ3Odk7SlsS0Hi7kvuyrol4Czh1GPDYL4Jt1Bg/6Q==
X-Gm-Gg: ASbGncssg4qz4zBljCZJGxDty9ulufLc+WVa8d5VzZ2PY+QfQMkGzMLfvEN3PeqRhJw
	BbwvANoxkAO0EQUsXqC3jgXMEb2Co9qlydD/hgNhRgqL63EMwg02EuqZVZgOv
X-Google-Smtp-Source: AGHT+IGBlnNQyQHwMGtDrrdX3CreOzUXQEgfAHVDJHbn0J4R35WIrMg0ozIUkEHvGZDTG45AYzQi7pT+kdCmFyBEI9E=
X-Received: by 2002:a17:907:7702:b0:aa5:3705:2dc with SMTP id
 a640c23a62f3a-aa63a206fd5mr292025066b.45.1733498029618; Fri, 06 Dec 2024
 07:13:49 -0800 (PST)
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
Date: Fri, 6 Dec 2024 16:13:38 +0100
Message-ID: <CAKPOu+_PEmxR-LpnQFfxRpOVrU1G83npFmoQhgsBndZvNY+kYg@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:08=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> Similar hangs wth 6.12.2 (vanilla without your "netfs-writeback" branch):
>
> [<0>] folio_wait_bit_common+0x23a/0x4f0
> [<0>] folio_wait_private_2+0x37/0x70
> [<0>] netfs_invalidate_folio+0x168/0x520
> [<0>] truncate_cleanup_folio+0x281/0x340
> [<0>] truncate_inode_pages_range+0x1bb/0x780
> [<0>] ceph_evict_inode+0x17e/0x6b0
> [<0>] evict+0x331/0x780
> [<0>] __dentry_kill+0x17b/0x4f0
> [<0>] dput+0x2a6/0x4a0
> [<0>] __fput+0x36d/0x910
> [<0>] __x64_sys_close+0x78/0xd0
> [<0>] do_syscall_64+0x64/0x100
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

This might help you understand the problem:

 INFO: task cp:3345 blocked for more than 122 seconds.
       Not tainted 6.12.3-cm4all0-hp+ #297
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cp              state:D stack:0     pid:3345  tgid:3345
ppid:3331   flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0xc34/0x4df0
  ? __pfx___schedule+0x10/0x10
  ? lock_release+0x206/0x660
  ? schedule+0x283/0x340
  ? __pfx_lock_release+0x10/0x10
  ? schedule+0x1e8/0x340
  schedule+0xdc/0x340
  io_schedule+0xc0/0x130
  folio_wait_bit_common+0x23a/0x4f0
  ? __pfx_folio_wait_bit_common+0x10/0x10
  ? __pfx_wake_page_function+0x10/0x10
  ? __pfx_truncate_folio_batch_exceptionals.part.0+0x10/0x10
  folio_wait_private_2+0x37/0x70
  netfs_invalidate_folio+0x168/0x520
  ? ceph_invalidate_folio+0x114/0x2a0
  truncate_cleanup_folio+0x281/0x340
  truncate_inode_pages_range+0x1bb/0x780
  ? __pfx_truncate_inode_pages_range+0x10/0x10
  ? __pfx_do_raw_spin_lock+0x10/0x10
  ? find_held_lock+0x2d/0x110
  ? do_raw_spin_unlock+0x54/0x220
  ceph_evict_inode+0x17e/0x6b0
  ? lock_release+0x206/0x660
  ? __pfx_ceph_evict_inode+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? do_raw_spin_lock+0x12d/0x270
  ? __pfx_do_raw_spin_lock+0x10/0x10
  evict+0x331/0x780
  ? __pfx_evict+0x10/0x10
  ? do_raw_spin_unlock+0x54/0x220
  ? _raw_spin_unlock+0x1f/0x30
  ? iput.part.0+0x3d0/0x670
  __dentry_kill+0x17b/0x4f0
  dput+0x2a6/0x4a0
  __fput+0x36d/0x910
  __x64_sys_close+0x78/0xd0
  do_syscall_64+0x64/0x100
  ? syscall_exit_to_user_mode+0x57/0x120
  ? do_syscall_64+0x70/0x100
  ? do_raw_spin_unlock+0x54/0x220
  ? _raw_spin_unlock+0x1f/0x30
  ? generic_fadvise+0x210/0x590
  ? __pfx_generic_fadvise+0x10/0x10
  ? syscall_exit_to_user_mode+0x57/0x120
  ? __pfx___seccomp_filter+0x10/0x10
  ? fdget+0x53/0x430
  ? __pfx_do_sys_openat2+0x10/0x10
  ? __x64_sys_fadvise64+0x139/0x180
  ? syscall_exit_to_user_mode+0x57/0x120
  ? do_syscall_64+0x70/0x100
  ? __x64_sys_openat+0x135/0x1d0
  ? __pfx___x64_sys_openat+0x10/0x10
  ? syscall_exit_to_user_mode+0x57/0x120
  ? do_syscall_64+0x70/0x100
  ? irqentry_exit_to_user_mode+0x3d/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f66375bd960
 RSP: 002b:00007ffd5bcd65a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f66375bd960
 RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000003
 RBP: 00007ffd5bcd6990 R08: 7fffffffc0000000 R09: 0000000000000000
 R10: 00007f66374dc498 R11: 0000000000000202 R12: 0000000000000001
 R13: 0000000000000000 R14: 0000000000008000 R15: 0000000000000001
  </TASK>

 Showing all locks held in the system:
 1 lock held by khungtaskd/163:
  #0: ffffffffb5829b80 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x64/0x280
 2 locks held by kworker/14:1/476:
  #0: ffff88815cb2b548 ((wq_completion)ceph-cap){....}-{0:0}, at:
process_one_work+0xdea/0x14f0
  #1: ffff88810ca97da0
((work_completion)(&mdsc->cap_reclaim_work)){....}-{0:0}, at:
process_one_work+0x743/0x14f0

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 INFO: task kworker/14:1:476 blocked for more than 122 seconds.
       Not tainted 6.12.3-cm4all0-hp+ #297
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/14:1    state:D stack:0     pid:476   tgid:476   ppid:2
    flags:0x00004000
 Workqueue: ceph-cap ceph_cap_reclaim_work
 Call Trace:
  <TASK>
  __schedule+0xc34/0x4df0
  ? __pfx___schedule+0x10/0x10
  ? lock_release+0x206/0x660
  ? schedule+0x283/0x340
  ? __pfx_lock_release+0x10/0x10
  ? kick_pool+0x1da/0x530
  schedule+0xdc/0x340
  io_schedule+0xc0/0x130
  folio_wait_bit_common+0x23a/0x4f0
  ? __pfx_folio_wait_bit_common+0x10/0x10
  ? __pfx_wake_page_function+0x10/0x10
  ? __pfx_truncate_folio_batch_exceptionals.part.0+0x10/0x10
  folio_wait_private_2+0x37/0x70
  netfs_invalidate_folio+0x168/0x520
  ? ceph_invalidate_folio+0x114/0x2a0
  truncate_cleanup_folio+0x281/0x340
  truncate_inode_pages_range+0x1bb/0x780
  ? __pfx_truncate_inode_pages_range+0x10/0x10
  ? __lock_acquire.constprop.0+0x598/0x13e0
  ? release_sock+0x1b/0x180
  ? reacquire_held_locks+0x1e9/0x460
  ? release_sock+0x1b/0x180
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x206/0x660
  ? truncate_inode_pages_final+0x59/0x80
  ? __pfx_lock_release+0x10/0x10
  ? do_raw_spin_lock+0x12d/0x270
  ? __pfx_do_raw_spin_lock+0x10/0x10
  ? find_held_lock+0x2d/0x110
  ? do_raw_spin_unlock+0x54/0x220
  ceph_evict_inode+0x17e/0x6b0
  ? lock_release+0x206/0x660
  ? __pfx_ceph_evict_inode+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? lock_is_held_type+0xdb/0x110
  evict+0x331/0x780
  ? __pfx_evict+0x10/0x10
  ? do_raw_spin_unlock+0x54/0x220
  ? _raw_spin_unlock+0x1f/0x30
  ? iput.part.0+0x3d0/0x670
  __dentry_kill+0x17b/0x4f0
  dput+0x2a6/0x4a0
  __dentry_leases_walk+0x6c6/0x10d0
  ? do_raw_spin_lock+0x12d/0x270
  ? __pfx___dentry_leases_walk+0x10/0x10
  ? __pfx_do_raw_spin_lock+0x10/0x10
  ceph_trim_dentries+0x1b1/0x260
  ? __pfx_ceph_trim_dentries+0x10/0x10
  ? lock_acquire+0x11f/0x290
  ? process_one_work+0x743/0x14f0
  ceph_cap_reclaim_work+0x19/0xc0
  process_one_work+0x7b4/0x14f0
  ? __pfx_process_one_work+0x10/0x10
  ? assign_work+0x16c/0x240
  ? lock_is_held_type+0x9a/0x110
  worker_thread+0x52b/0xe40
  ? do_raw_spin_unlock+0x54/0x220
  ? __kthread_parkme+0x95/0x120
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x28a/0x350
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2d/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

