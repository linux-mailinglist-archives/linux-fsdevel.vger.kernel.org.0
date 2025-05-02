Return-Path: <linux-fsdevel+bounces-47905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6BAA6E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A6C9A5B6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDD2356DD;
	Fri,  2 May 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrZcYTWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC222F39C
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179551; cv=none; b=RPUciWtDJO/9pHINPo1CO9EA/gHxkoIgWKQ8/XQtqSBCnVQKGywFwFDRVTsfqd9Tt+Xgk9JucGQpiKJzq+cbcSppCr4HWJCG9KqQQHwT5W0lsN3p8Jnca7LJMpQK9/iv3iYnxqdA2dYbesjio8ZtUZxLqcVni9+DDFr+61KeSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179551; c=relaxed/simple;
	bh=ZS+f+Pfa5TGtF2r8wVszZHda4cYa5Eb0bHdA6ZwVU+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBtELmR+ajAadf4FPy0bgMq0CuMcQhDP95A2Tn5Ik2KbBZS+YCf6fhs7/XWD2kjBoVnm5/VscMhNhyoiP8DYS6L8kLu3gUDwrKw/VjeZ1en68b2gUlgQIX7RRUzHphXhyHw1Ld27rKlvTg8m9Kse5jfTvZODuoY6fDib9O9a1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrZcYTWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746179548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXGsWu/sVUjfIQjTnfB+mQNrmVQD1XLyhhrYW1W2edU=;
	b=OrZcYTWNJq8zrfRrG6jgc8X5U3cJw5QI+6YhAtp918e8C73zZWbfuYLFXWDef/gyJpMLAw
	It0AdRxJ26Fy6TfkxyQo58kz9zfRntO5hJqGMzQpXL63pDSr2lVvp4wJiz9n3ubTQU1qd9
	KZNfcxKiRQVbg/VIaPvTPkvHV+U7u5k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-7ZPR-PGDPsy1bpr2nGjECQ-1; Fri, 02 May 2025 05:52:26 -0400
X-MC-Unique: 7ZPR-PGDPsy1bpr2nGjECQ-1
X-Mimecast-MFC-AGG-ID: 7ZPR-PGDPsy1bpr2nGjECQ_1746179545
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225429696a9so27940935ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746179545; x=1746784345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXGsWu/sVUjfIQjTnfB+mQNrmVQD1XLyhhrYW1W2edU=;
        b=a9qZVn1huGEB/0Ecnlz2gTxZ3ph5qRVuZFZ2PTgWRM0IWy+qSK7d+0w0S0GKxMuPl8
         OGR6woBdNHPmxeGWEkUg0LEPp06Nmh5WtkQQaDeAXFDQgof9eW0FQD3B1fPNpPljyPpx
         Hx8ghIaj4xxZrsdfAAxwdpg3y/EQ7KxsTBNke/Vw7jgERPGDzz5+zN/RXzhxAh4EJxKo
         /FokfgzHCuXrYwTaaRnlfKyrifDJ8CiYs9s4moyEjvHhCVAG+N08sWOBxWUYme04MduL
         3R2uCeATJvy2+VvCdBF0oFz7A0miR/g5EG41ANnqY9k6IQS7ooA67wamQLqpYLCLiUDq
         lgCA==
X-Forwarded-Encrypted: i=1; AJvYcCXK27pVjQpnY0g3wOvhbPzZT2BcUsbKFEJ/iMml2LpGXU/G0FtruwOLpAQkYuMTF3ErBYShcisp0BRgDULV@vger.kernel.org
X-Gm-Message-State: AOJu0YyrI7ZQ1m8qQwFLCKyDRCpDaGf8mWR6EW9tppnhuEcQvpnYMg37
	XVgGO7tJrjJtKory4bvQnsFiQc1WTmrPTwJizcb2XBUhvSGc/Zl72c7xkGIF7KGdHFQyVJvIDx1
	oWFUUezdkqJIexXa22/ljDzERWq2cWYVQl7tsuWWf+KsGiHIbHYOwrkw6+B0d5HAM/UxtM48aoL
	4AIhxh1D8Yvz33Q3tthBqGWrOFtZrPpGClgO5hgA==
X-Gm-Gg: ASbGncv4/bkm8Ov0jLj+b71M6EVJUjTIBQMuMRxwz/YW3xjjfI5dUXAdtv9KRgfOWWC
	0Ubvif/DsZy4Dxt0hwLBmcxr5wo8i8cS8kRhMFv11D1A++D+2RyiMW46bSEYP2873ciM=
X-Received: by 2002:a17:903:2352:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22e1032ebc5mr35111585ad.36.1746179545282;
        Fri, 02 May 2025 02:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPi23jEaWUfx5+/hAlXlXqhO6rvOVoF1TJPb1nn7S1D1B2KjpWylLrHJ8i6Jmbfs80U/fXdvtp29JFcP9CCWA=
X-Received: by 2002:a17:903:2352:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22e1032ebc5mr35111125ad.36.1746179544756; Fri, 02 May 2025
 02:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR06MB7158B63753ECD29758D09D49F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
 <20250501202943.e72b7bae3d1957efa60db553@linux-foundation.org>
In-Reply-To: <20250501202943.e72b7bae3d1957efa60db553@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 2 May 2025 11:52:13 +0200
X-Gm-Features: ATxdqUEmdWvqbf7pU_cAzCFcFc3sFR361fdkrY_4pFwKDQj8PiTwFoGn-3DHIGc
Message-ID: <CAHc6FU6O9ys6cbwOBmgz9e3EZgNDSRnnm6c=056VdJKF490ixQ@mail.gmail.com>
Subject: Re: WARNING in __folio_mark_dirty
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>, "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, 
	=?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:36=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
> On Fri, 2 May 2025 03:26:20 +0000 "huk23@m.fudan.edu.cn" <huk23@m.fudan.e=
du.cn> wrote:
> > Dear Maintainers=EF=BC=8C
>
> Let's Cc the gfs2 developers.

On gfs2, these warnings should be fixed by the following two commits:

9e888998ea4d ("writeback: fix false warning in inode_to_wb()")
ae9f3bd8259a ("gfs2: replace sd_aspace with sd_inode")

The first one is in v6.15-rc3 thanks to Andrew; the second one is on
gfs2's for-next branch right now:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/=
?h=3Dfor-next&id=3Dae9f3bd8259a

> Do you know if this is reproducible on any other filesystem?
>
> >
> > When using our customized Syzkaller to fuzz the latest Linux kernel, th=
e following crash (37th and 76th)was triggered.
> >
> >
> > 37th=EF=BC=9A
> > HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> > git tree: upstream
> > Output:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN=
/2.%E5%9B%9E%E5%BD%92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20hfspl=
us_bnode_read/14call_trace.txt
> > Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15r=
c1/config.txt
> > C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc=
7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined=
/37repro.c
> > Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219=
_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_o=
utlined/37repro.txt
> >
> > 76th=EF=BC=9A
> > HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> > git tree: upstream
> > Output:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo=
/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/76cal=
l_trace.txt
> > Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15r=
c1/config.txt
> > C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc=
7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined=
/76repro.c
> > Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219=
_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_o=
utlined/76repro.txt
> >
> >
> >
> > The two errors seem to have the same error points, but there are a few =
differences in the process. They all trigger warnings in the __folio_mark_d=
irty+0xb50/0xf10 function of backing-dev.h:251. In __folio_mark_dirty funct=
ion, a warning is triggered when the code tries to access or modify the bac=
king-dev information. The 76th call stack has longer call chains from file =
writebacks: writeback work queues =E2=86=92 writeback inodes =E2=86=92 GFS2=
 write inodes =E2=86=92 log refreshes.
> > We have reproduced this issue several times on 6.15-rc1 again.
> >
> >
> >
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.=
edu.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
> >
> >
> >
> > 37th=EF=BC=9A
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: CPU: 2 PID: 9494 at ./include/linux/backing-dev.h:251 __folio_=
mark_dirty+0xb50/0xf10
> > Modules linked in:
> > CPU: 2 UID: 0 PID: 9494 Comm: gfs2_logd/syz:s Not tainted 6.15.0-rc1 #1=
 PREEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubu=
ntu1.1 04/01/2014
> > RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> > Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3=
 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 =
a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> > RSP: 0018:ffffc90014bb7b18 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff88804298cb58 RCX: ffffffff81f5408e
> > RDX: 0000000000000000 RSI: ffff888023edc900 RDI: 0000000000000002
> > RBP: ffffea00015c9d80 R08: 0000000000000000 R09: ffffed10085319a0
> > R10: ffffed100853199f R11: ffff88804298ccff R12: 0000000000000246
> > R13: ffff888049bd8bc8 R14: 0000000000000001 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff888097c6b000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ff2c7be9028 CR3: 000000000e180000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  mark_buffer_dirty+0x358/0x410
> >  gfs2_unpin+0x106/0xef0
> >  buf_lo_after_commit+0x155/0x230
> >  gfs2_log_flush+0xd95/0x2cb0
> >  gfs2_logd+0x29b/0x12c0
> >  kthread+0x447/0x8a0
> >  ret_from_fork+0x48/0x80
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > extracting prog: 1h56m11.644263162s
> > minimizing prog: 14m12.695891417s
> > simplifying prog options: 0s
> > extracting C: 32.234365976s
> > simplifying C: 9m50.565845853s
> >
> >
> >
> >
> >
> > 76th=EF=BC=9A
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: CPU: 3 PID: 3051 at ./include/linux/backing-dev.h:251 __folio_=
mark_dirty+0xb50/0xf10
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 3051 Comm: kworker/u18:5 Not tainted 6.15.0-rc1 #1 P=
REEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubu=
ntu1.1 04/01/2014
> > Workqueue: writeback wb_workfn (flush-7:0)
> > RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> > Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3=
 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 =
a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> > RSP: 0018:ffffc90011e2f410 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff88804266bfd8 RCX: ffffffff81f5408e
> > RDX: 0000000000000000 RSI: ffff888043e48000 RDI: 0000000000000002
> > RBP: ffffea000086e9c0 R08: 0000000000000000 R09: ffffed10084cd830
> > R10: ffffed10084cd82f R11: ffff88804266c17f R12: 0000000000000246
> > R13: ffff888012bf87f0 R14: 0000000000000001 R15: 0000000000000001
> > FS: 0000000000000000(0000) GS:ffff8880eb46b000(0000) knlGS:000000000000=
0000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6410e8e140 CR3: 0000000023648000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> > mark_buffer_dirty+0x358/0x410
> > gfs2_unpin+0x106/0xef0
> > buf_lo_after_commit+0x155/0x230
> > gfs2_log_flush+0xd95/0x2cb0
> > gfs2_write_inode+0x371/0x450
> > __writeback_single_inode+0xad7/0xf50
> > writeback_sb_inodes+0x5f5/0xee0
> > __writeback_inodes_wb+0xbe/0x270
> > wb_writeback+0x728/0xb50
> > wb_workfn+0x96e/0xe90
> > process_scheduled_works+0x5de/0x1bd0
> > worker_thread+0x5a9/0xd10
> > kthread+0x447/0x8a0
> > ret_from_fork+0x48/0x80
> > ret_from_fork_asm+0x1a/0x30
> > </TASK>
> >
> >
> >
> > thanks,
> > Kun Hu
> >
>

Thanks,
Andreas


