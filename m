Return-Path: <linux-fsdevel+bounces-32690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE39ADA56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DD51C21866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DD15A86B;
	Thu, 24 Oct 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="i8/upinb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962A156997
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739911; cv=none; b=Tf6W7Gxq1Ccpac7bs/kQx8NcJ6C4fleC2BhVUgkWqyNJyMspPBYZtr2CRHPPnLpuFtfgbwjWar52prKz1q5I3efbj/aA0pi1khFO7i2lKzjwaQzDKpBjUVkxSr89RbpyhYbQlyYUerxtT5CRbXmL8B0cj1n0K20E2R2uLJXIAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739911; c=relaxed/simple;
	bh=vkJ91YhpgOXQfcIuKk0TlyvwVdhO8vsyzzqAJ2hpnm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6tu2s9dGCJRFfy4+uyYOEiuLVBHBRGSBlp5/RKScG/u38DqfA0OS+h8Xb59TgkSxc+28Ky6K4hPT5mqaX3V9K5VisHByJt1X9BQanZKxNCsW8BsBSazuX3szJaFtUfL39vtWYSxfaYGP10mXO2FfKg4BcaiqWOgDG11xskou6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=i8/upinb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so306772b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 20:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729739908; x=1730344708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3k4VXE/eXp/g8cIlKj35+R9+J+Fc3C5xZ7QeG6NE+s=;
        b=i8/upinb8+a0TORMuTG3DnNW3w/iwiqarcjwtPMBtljna4sQwRVRlqlIa5Kh03GxUT
         hySogaIK7C44twzDG3CYDDeBkObZztZXrUfYL4Pd0qehDcWyJ7dlDMGtOwV0pddZryD9
         dxoXdbldgo9vdhguj8SHFAsEwjx9XbPHBMxxksUlPJoE7u2V5XwJ/VcOxzDqMPcpyqI8
         ZEdEdMfEG4OB1U8jTs+Ynp13xdlT11O97Z+pyjC0g7eSNqtn/8xpXbqjPHVun7QRNDT/
         pmZNTuesaqfkF/Qed6MT5OZEs6EknAEOzrb3+fvJ63S1fMd3PZ6GT8eFiDapCigy3qbk
         QRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729739908; x=1730344708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3k4VXE/eXp/g8cIlKj35+R9+J+Fc3C5xZ7QeG6NE+s=;
        b=s3qeGibBvKpXjXVVMaUeSV9oz096J6ukVDiU7T8KqKyh3g+TgGzOEVrddDfur2Vg+W
         34TfAoc3vxF8FLvyXcfpYTTKtnyB8N21JYxMQfw+9BRJ4wG4B1ZyGviuwEdQz4832iD1
         C5AWmAL7cI6nR8oaHGqxfDQGTCrYZhU2iBF7JHV7sjvie4Yqv9y0/DllpjV+Ehc82F/U
         SiIz38Imd/ZsPy5f2nV3Y+3nw1bodJAu5jgp7hpzAq9QzfmYJ7oyf83hxGMkg5d2i5zm
         YkizNMUd7cxUxAADjCxyJjXF2T6Oe+NtFNMC3PaJy79IYbYsH8msEW71GBI7HUsADQbf
         5uLw==
X-Forwarded-Encrypted: i=1; AJvYcCV//E+ZoRytmiDUcNbRP0BWcUye1XXVOiPMAEf+2dWtwRilpr/ST0w/tOcmgD2dAAQSclsCJrS0CVcH0aY1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tl5g1nxAmNMOztfGz9RJ0NdNY5cbsrAP14ldmjpfvMudcAjS
	CyfbM68e44aC0s6foihjNUbxGu9U3e0Pnf9KUApoccd+NJCwraTi2OkScMfgx08=
X-Google-Smtp-Source: AGHT+IFdYTFHRqAoiQ2lgk4xHV8wPMsV/3bpZaiqw+oaQJscULRVo3CN2XYJVIdgWxCvgMPUmd+20g==
X-Received: by 2002:a05:6a00:8603:b0:71e:4798:8753 with SMTP id d2e1a72fcca58-720452afb2amr955940b3a.6.1729739908421;
        Wed, 23 Oct 2024 20:18:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f7bsm7595898a12.39.2024.10.23.20.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 20:18:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t3oMj-004xvR-1p;
	Thu, 24 Oct 2024 14:18:25 +1100
Date: Thu, 24 Oct 2024 14:18:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <Zxm8gf0aUg2+uEks@dread.disaster.area>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023201314.hqfewgr6lej6f7df@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023201314.hqfewgr6lej6f7df@quack3>

On Wed, Oct 23, 2024 at 10:13:14PM +0200, Jan Kara wrote:
> 
> Hi!
> 
> On Wed 23-10-24 11:19:24, John Garry wrote:
> > I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
> > master branch:
> > 
> > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > Oct 22 09:07:15 ...
> >  kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]
> > 
> > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > Oct 22 09:08:07 ...
> >  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck
> > for 44s!
> > 
> > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > Oct 22 09:08:07 ...
> >  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck
> > for 35s!
> > 
> > Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> > Oct 22 09:08:07 ...
> >  kernel:BUG: workqueue lockup - pool cpus=10 node=0 flags=0x0 nice=0 stuck
> > for 33s!
> > 
> > This is while doing some server MySQL performance testing. v6.11 has no such
> > issue.
> > 
> > I added some debug, and we seem to be spending a lot of time in FS
> > writeback, specifically wb_workfn() -> wb_do_writeback() - ring any bells?
> 
> Thanks for report. This doesn't remind me of anything but checking the
> writeback changes we have merged 532980cb1bf ("inode: port __I_SYNC to var
> event") which could have odd consequences if we made mistake somewhere...
> It probably won't be easy to revert but you could try whether the problem
> reproduces before / after this commit.

I haven't seen the above hangs, but I just got this scheduler
warning a few minutes ago waiting for writeback:

[12886.406341] WARNING: CPU: 19 PID: 504037 at kernel/sched/fair.c:5629 pick_task_fair+0xb6/0x1b0
[12886.412600] Modules linked in:
[12886.414325] CPU: 19 UID: 0 PID: 504037 Comm: fsstress Not tainted 6.12.0-rc4-dgc+ #268
[12886.418822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[12886.424280] RIP: 0010:pick_task_fair+0xb6/0x1b0
[12886.426885] Code: 40 f3 d3 03 01 74 2a 41 80 7f 50 00 74 96 f6 05 31 f3 d3 03 01 75 8d c6 05 28 f3 d3 03 01 48 c7 c7 f7 22 c4 82 e8 ea d7 fa ff <0f> 0b e9 73 ff ff ff c6 05 0d f3 d3 03 01 48 c7 c7 e5 22 c4 82 e8
[12886.437460] RSP: 0018:ffffc9001e703c88 EFLAGS: 00010046
[12886.440448] RAX: 02f256539620ed00 RBX: 0000000000000000 RCX: 0000000000000027
[12886.444542] RDX: 0000000000000000 RSI: 00000000ffdfffff RDI: ffff88901fadc9c8
[12886.448601] RBP: ffffc9001e703cb0 R08: 00000000001fffff R09: ffff88a018a00000
[12886.452655] R10: 00000000005ffffd R11: 0000000000000004 R12: ffff888861406400
[12886.456585] R13: ffff88901faf0140 R14: ffff88901faf00c0 R15: ffff889079412900
[12886.460679] FS:  00007f65469d8740(0000) GS:ffff88901fac0000(0000) knlGS:0000000000000000
[12886.465309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12886.468469] CR2: 00007f9de8006248 CR3: 00000009b7c16000 CR4: 0000000000350ef0
[12886.472382] Call Trace:
[12886.473751]  <TASK>
[12886.474947]  ? show_regs+0x5e/0x70
[12886.476829]  ? __warn+0xd0/0x1d0
[12886.478634]  ? pick_task_fair+0xb6/0x1b0
[12886.480794]  ? report_bug+0x145/0x1f0
[12886.482875]  ? handle_bug+0x67/0x90
[12886.484804]  ? exc_invalid_op+0x1b/0x50
[12886.486932]  ? asm_exc_invalid_op+0x1b/0x20
[12886.489230]  ? pick_task_fair+0xb6/0x1b0
[12886.491389]  ? pick_task_fair+0xb6/0x1b0
[12886.493538]  pick_next_task_fair+0x27/0x330
[12886.495836]  __schedule+0x2ad/0xb10
[12886.497756]  schedule+0x6d/0xf0
[12886.499511]  wb_wait_for_completion+0x56/0x90
[12886.501972]  ? __pfx_autoremove_wake_function+0x10/0x10
[12886.504832]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[12886.507432]  sync_inodes_sb+0xb0/0x2b0
[12886.509500]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[12886.512094]  sync_inodes_one_sb+0x14/0x20
[12886.514314]  iterate_supers+0x7a/0xd0
[12886.516338]  ksys_sync+0x40/0xa0
[12886.518132]  __ia32_sys_sync+0xe/0x20
[12886.520141]  x64_sys_call+0x2a59/0x2ee0
[12886.522258]  do_syscall_64+0x68/0x130
[12886.524275]  ? exc_nmi+0xbd/0x110
[12886.526116]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[12886.528883] RIP: 0033:0x7f6546ae97c7
[12886.530862] Code: 73 01 c3 48 8b 0d 59 86 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a2 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 86 0d 00 f7 d8 64 89 01 48
[12886.540989] RSP: 002b:00007ffdf43f4178 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[12886.545125] RAX: ffffffffffffffda RBX: 0000000000000247 RCX: 00007f6546ae97c7
[12886.549029] RDX: 00000000ffffffff RSI: 000000000a8ca705 RDI: 0000000000000247
[12886.552926] RBP: 00000000000001f4 R08: 000000000000004c R09: 0000000000000006
[12886.556823] R10: 0000000000000007 R11: 0000000000000206 R12: 000055f5884d45a0
[12886.560725] R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 000055f5884c16c0
[12886.564659]  </TASK

Which is from a wait_event() call and ends up warning here:

static struct sched_entity *
pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
{
        /*
         * Enabling NEXT_BUDDY will affect latency but not fairness.
         */
        if (sched_feat(NEXT_BUDDY) &&
            cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
                /* ->next will never be delayed */
                SCHED_WARN_ON(cfs_rq->next->sched_delayed);
                return cfs_rq->next;
        }

        struct sched_entity *se = pick_eevdf(cfs_rq);
        if (se->sched_delayed) {
                dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
                SCHED_WARN_ON(se->sched_delayed);
>>>>>>>>>       SCHED_WARN_ON(se->on_rq);
                return NULL;
        }
        return se;
}

Possibly a scheduler bug?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

