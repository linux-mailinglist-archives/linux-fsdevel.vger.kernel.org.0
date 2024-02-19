Return-Path: <linux-fsdevel+bounces-12003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A927E85A37A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBFC1C237B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CD3306B;
	Mon, 19 Feb 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOWWv+TZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3D2E65B;
	Mon, 19 Feb 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345997; cv=none; b=U6DiVZsm5fNimw4qAz8mpFDI4+Li0ZxX89CF1LOEHYF/0UCwnw6S5WA/98SAHIlVKU454ItVNrOPXk0wCWHjXNMxqPK0AOIKws+v8KOTZeiuBfubIy/8Xotu0vnnktvp6pTisZL9AVedIDCW5JjZ4RukfCeEA9sg8oPyWlfA47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345997; c=relaxed/simple;
	bh=yKcEeSgukC018TLmkQDTMD4nrfUWkZd2Lbs6EAEldeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2tIlEZWbmLpcNMGVqnFi6Of5I8r/y5U/EHY1DalM3W2UG8XxQRClIJeTRb+rp5GEeLAGhSCoRnYasZYzYax5TRhg0pzkOP76TsN+qibXktSxJ7PNr7vyt3RMBkb1AD1plrcV39MxD9kzZea9FPM+zQJjGAjEyMKhn0jtpNvyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOWWv+TZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d241ff062cso5669851fa.3;
        Mon, 19 Feb 2024 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708345994; x=1708950794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMKCp2LN93kpCfJY2ryW6udrCW77sW8a9JV5VL4IBIM=;
        b=OOWWv+TZFiGFlf15OYjVByRUQClgnVZHN9q+ybK7L8aJaIhv03tPkDucNFoTUzfGx3
         jvSCpepuSH2JP/tE+576HqHh9VFhINt0vJKKzNR44dyHCNIHmC84pxfmqwt66AF5YKT+
         tKI/BZnRwITChVJTTfQibx3zQeXWQL+AZ5VPq6ntWJF78jsC77tQq/aQb8PMHVwfFdrW
         jG46PmYBiCVnfZmVlXyreU12YsLV5UvMsN52r92NgRg8d2zuZp1dzta7EUQjBN+OkX8w
         R/Ufk8X03/TRKA9cgD0arRQOlR8LrohTt33aBr+S/4sRamu4rcSKNVAwDVfv/xBFA/FV
         /rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345994; x=1708950794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMKCp2LN93kpCfJY2ryW6udrCW77sW8a9JV5VL4IBIM=;
        b=HgmccBKPNP3LEb0bZ2BwpwCkzuRQAD11UmHoIRfccWUai/F+i7OOyXneW62iIy/GPv
         OhsuqGLgXsSnKXk1RGXoQHUeVYLX1h74CqVN3ctgsMKlVggiAxXCoSm4XH7MCvVmoiRt
         bacUYiyxij/BWv8Haxu7hjUrYcJ26HksV2Hnvd/37fAXhguXMs4hMbSL+QHO3RnwIMYD
         LBQ4zIS+VvzZHLawVgU52gu911aWSkbSWNxxYB5FmX9hvOoGI0+xMN3xpz28Pcz5sVWY
         1ozYpUlIXNu1SZEABtB5Kb9eDOlMwbAyDkk2qZJIWRoXz11TEq5OlT5a0dGrTsHqLydv
         6Q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRsVhdzQYWXq3WCXkfa1eLQ+nh0TEfvGfOqpnpXT6tAYNYRrI3QE0tyL9UkRrAp4H8FZtwO1aNmC/Co2NH/ztZapMfW94223sBmMvQ+7KOZfXRsoV7HRjGXNzhXLGgMl8ObL4dYX/60Uk=
X-Gm-Message-State: AOJu0YxqswIScWGvdGP2FlC+5QWQpR2q62ETK8NePRO/nEnbXVKUhTkc
	cfHQIinUAtvgMn3Ns2RIsI1bASvCm/+eXYdyD0FLpp2zck5xubdrJcJ59sCl3CDNM2jbddBkPs7
	cStdbNyqN7POWEdO4Vi1fe5+w/nbnR3lI
X-Google-Smtp-Source: AGHT+IFRrdknNHyrck3eNCsLXc/Oda66cv896Gfi1bYCbpOojgSdSTEPAYfbnfeg6FxWAGCjDf+SgxlSiEp9QDoE+8g=
X-Received: by 2002:a2e:a9a0:0:b0:2d2:3b72:4c17 with SMTP id
 x32-20020a2ea9a0000000b002d23b724c17mr1499745ljq.3.1708345993420; Mon, 19 Feb
 2024 04:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003d6c9d0611b9ea2d@google.com>
In-Reply-To: <0000000000003d6c9d0611b9ea2d@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 19 Feb 2024 21:32:56 +0900
Message-ID: <CAKFNMonBntuJ4Z8_tXkfBLzU=4vYOEYHd3YqxC7yWTOwkw+ypg@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] INFO: task hung in nilfs_segctor_thread (2)
To: syzbot <syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:54=E2=80=AFPM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f735966ee23c Merge branches 'for-next/reorg-va-space' and=
 ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12dbb3dc18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd47605a39da2c=
f06
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc8166c541d3971b=
f6c87
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bdea2316c4db/dis=
k-f735966e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75ba7806a91c/vmlinu=
x-f735966e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/208f119d45ed/I=
mage-f735966e.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com
>
> INFO: task segctord:26558 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc3-syzkaller-gf735966ee23c #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:segctord        state:D stack:0     pid:26558 tgid:26558 ppid:2     =
 flags:0x00000008
> Call trace:
>  __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xb8/0x19c kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6874
>  rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
>  __down_write_common kernel/locking/rwsem.c:1306 [inline]
>  __down_write kernel/locking/rwsem.c:1315 [inline]
>  down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
>  nilfs_transaction_lock+0x178/0x33c fs/nilfs2/segment.c:357
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2523 [inline]
>  nilfs_segctor_thread+0x3cc/0xd78 fs/nilfs2/segment.c:2608
>  kthread+0x288/0x310 kernel/kthread.c:388
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/29:
>  #0: ffff80008ee43fc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0=
xc/0x44 include/linux/rcupdate.h:297
> 2 locks held by getty/5931:
>  #0: ffff0000d82710a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+=
0x3c/0x4c drivers/tty/tty_ldsem.c:340
>  #1: ffff800093fe72f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_r=
ead+0x41c/0x1228 drivers/tty/n_tty.c:2201
> 1 lock held by syz-executor.0/6205:
>  #0: ffff0000d6d12c68 (&pipe->mutex/1){+.+.}-{3:3}, at: rcu_lock_acquire+=
0xc/0x44 include/linux/rcupdate.h:297
> 2 locks held by kworker/u4:26/13298:
> 6 locks held by syz-executor.2/26553:
> 1 lock held by segctord/26558:
>  #0: ffff00011fc2d2a0
>  (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x178/0=
x33c fs/nilfs2/segment.c:357
> 1 lock held by syz-executor.3/11586:
>  #0: ffff0000c346f8b8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables=
_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
> 1 lock held by syz-executor.1/11588:
> 1 lock held by syz-executor.2/11593:
>  #0: ffff0001485282b8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables=
_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
> 1 lock held by syz-executor.4/11594:
>  #0: ffff0000d343fcb8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables=
_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
> 4 locks held by syz-executor.0/11595:
>  #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nes=
ted kernel/sched/core.c:559 [inline]
>  #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock ker=
nel/sched/sched.h:1385 [inline]
>  #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched=
/sched.h:1699 [inline]
>  #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x2e0/0x2=
4b4 kernel/sched/core.c:6643
>  #1: ffff0001b3ffac88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, =
at: psi_task_switch+0x3c0/0x618 kernel/sched/psi.c:988
>  #2: ffff0001b401cc88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, =
at: psi_task_change+0x100/0x234 kernel/sched/psi.c:912
>  #3: ffff0001b401cc88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, =
at: psi_task_change+0x100/0x234 kernel/sched/psi.c:912
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
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

This is difficult to handle as there is no reproducer and lack of
information, but one of the fixes merged in 6.8-rc4 is related to this
task hang, so I would like to see if it can be reproduced in 6.8-rc4
or later.

Ryusuke Konishi

