Return-Path: <linux-fsdevel+bounces-30615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC16F98C9CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 02:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78911284ED3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2A1940B5;
	Wed,  2 Oct 2024 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUCZlUwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2617C200;
	Wed,  2 Oct 2024 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827349; cv=none; b=AJgG9P74g9c7NKmRemOgosL7UMPClti4diNNUQza1xhFeyJ+gYq6+OIN0ZQ7/ByXJQet90owouZEcvnpnxT+GPs7lqIPiU0g0GZSetdI6/GagBNkhP1B45WzaW3iFIYWEj/xjZwsFu5rUGoihTEMrmbiUho0y4bCaSyoem1tGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827349; c=relaxed/simple;
	bh=HBWQHZvJzPqgRN4EzqO5BQd/eioDBMjtN/0DgNXsDg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saJEgMmN6oRYDnEUXnbPbQF+noaMmAsUc2pXxeuh6xcALiqB7GOZqNMH6plmIDaZLrzlKlX9WPIj4+AFitqwN5UW6kXsMecWnhp4SbpHyYJOfBrMyO4odC/zWnMW4gIENrL8ynUSDoclx9gApaekUIM8HIaKoGQTUvCXXOUQytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUCZlUwW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4585721f6edso39209531cf.2;
        Tue, 01 Oct 2024 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727827347; x=1728432147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6w1bZBFUavLGqGQplB7qBjCH8sYsl4kppSvY/cFyuE=;
        b=fUCZlUwWzDNMeTobjOCq8A0sbisPnu4K/ButtPv4GeS/NtEK6lrkNFcx71oLz2pU/L
         ZbmZ1TWeBOcFWh7WBka4NWX+VYBFM2wQeEl6omSI/1MDDCvz0M/ZK9lqU1PN3jVUxYaP
         LE6mlraQxxczZqWw/TmQaCvktK8KZPcdt1kmXw3CbkO8n7ZCr3SpRIGt2BYImZwIkrUi
         iEiMYZ+gFEtZ15QTgNNiMN0Nnw1IU6g7ZHzUOXAN6ldJx+jPTGmgoCu1TYtcjATxGDY/
         uv26N1IKIvhZ8KNJc/bbvREylzF2Yjuu64U85Z6HPMlpnZjH+rX+AwpOei+6piJ/gz01
         OklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827347; x=1728432147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6w1bZBFUavLGqGQplB7qBjCH8sYsl4kppSvY/cFyuE=;
        b=EykztgT84bG7RXAIfmh1dKKIIbOecxEMhpz8Envz4wztu/QW4VNe9D1U8kslO0HRoR
         rxICqAhFOQ0ieGh8siBZZM4kwwn8zHrjtA2aMZH2x5nmyRZI1IfIMSBZwsz1aBYWuNww
         xKALAQcwmYaQGaRNIt9WWGnhCLbCWlw3nrJA2V5/JUp/04ZUxfoRGKehnP2+hiM91X7W
         jzy33qn/WUtOvZaQBYVYgPfPW11rFyp1Q4lW1BpVndjwqy733r8+SEfouRo/3GT1GGvq
         LpR9xR1MiR7lCmdf9/rEmSKY/QKP2+ETrVZ4VnfRsbUNHYHWYZyrJ1cSNsqK7dyW+QQH
         d68w==
X-Forwarded-Encrypted: i=1; AJvYcCX7M0j/nEqteufddRQhhdxs0Q4DRNx5gvDttz3vnTybWr+BN/UZOpQdHONg/eLmc9+iwc8FYNv6IV2fUuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvY/iCI1AkMSnxmkD8dw+5VjSA9hUoZSQ328zGRVDy2OrAgKr
	z/GlNdddMWgSfCH8MrVaCQOspka6FTv5oEDSFvSSgBzwifwFMTOQ4B7ITVyZrrj4qjuPIvWwI79
	Y/aeZKWqocCY3W1pwMt1TzT+F40k=
X-Google-Smtp-Source: AGHT+IEdaOk4RzSUk/e4jdYh020KjbjLbPl67w3NxiY8B/tNHRk6u58KrsFSTOSHQMVFVnT91Az4GYr+bOLcaLMPoD8=
X-Received: by 2002:a05:622a:134a:b0:458:368a:dd4e with SMTP id
 d75a77b69052e-45d804b5cd1mr20904031cf.22.1727827346771; Tue, 01 Oct 2024
 17:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com>
In-Reply-To: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Oct 2024 17:02:15 -0700
Message-ID: <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:24=E2=80=AFPM syzbot
<syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' o=
f..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12e8bdd058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1b5201b91035a=
876
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D217a976dc26ef2f=
a8711
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a585cdb91cda/dis=
k-e32cde8d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbeec5d7b296/vmlinu=
x-e32cde8d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/000fd790e08a/b=
zImage-e32cde8d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs/f=
use/file.c:1989 [inline]
> WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs/f=
use/file.c:1986 [inline]
> WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_writepages+0x497/0x=
5a0 fs/fuse/file.c:2368
> Modules linked in:
> CPU: 0 UID: 0 PID: 5296 Comm: kworker/u8:8 Not tainted 6.12.0-rc1-syzkall=
er-00031-ge32cde8d2bd7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Workqueue: writeback wb_workfn (flush-0:52)
> RIP: 0010:fuse_write_file_get fs/fuse/file.c:1989 [inline]
> RIP: 0010:fuse_write_file_get fs/fuse/file.c:1986 [inline]
> RIP: 0010:fuse_writepages+0x497/0x5a0 fs/fuse/file.c:2368
> Code: 00 00 00 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 7=
9 b6 90 fe 48 8b 7c 24 08 e8 af 6f 27 08 e8 6a b6 90 fe 90 <0f> 0b 90 41 bf=
 fb ff ff ff eb 8b e8 59 b6 90 fe 48 8b 7c 24 18 be
> RSP: 0018:ffffc900044ff4a8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc900044ff4f8 RCX: 0000000000000000
> RDX: ffff88802d42da00 RSI: ffffffff82fcd286 RDI: 0000000000000001
> RBP: ffff88805c994aa0 R08: 0000000000000000 R09: ffffed100b9329d7
> R10: ffff88805c994ebb R11: 0000000000000003 R12: ffffc900044ff840
> R13: ffff88805c994880 R14: ffff88805f330000 R15: ffff88805c994d50
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020055000 CR3: 000000005df4a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
>  __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1658
>  writeback_sb_inodes+0x603/0xfa0 fs/fs-writeback.c:1954
>  wb_writeback+0x199/0xb50 fs/fs-writeback.c:2134
>  wb_do_writeback fs/fs-writeback.c:2281 [inline]
>  wb_workfn+0x294/0xbc0 fs/fs-writeback.c:2321
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>

#syz dup: [syzbot] [fuse?] WARNING in fuse_write_file_get (2)

This is the same warning reported in
https://lore.kernel.org/linux-fsdevel/66fbae38.050a0220.6bad9.0051.GAE@goog=
le.com/T/#u

The warning is complaining about this WARN_ON here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
fuse/file.c#n1989.
I think this warning can get triggered if there's a race between a
write() and a close() where the page is dirty in the cache after the
release has happened. Then when writeback (eg fuse_writepages()) is
triggered, we hit this warning. (this possibility has always existed,
it was surfaced after this refactoring commit 4046d3adcca4: "move fuse
file initialization to wpa allocation time" but the actual logic
hasn't been changed).

I think we can address this by instead calling "data.ff =3D
__fuse_write_file_get(fi);" in fuse_writepages(). I'll submit a fix
for this to Miklos's tree.


Thanks,
Joanne

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

