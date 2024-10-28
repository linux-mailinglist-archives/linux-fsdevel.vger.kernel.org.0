Return-Path: <linux-fsdevel+bounces-33039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB69B2470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22AA1C2082D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA790193403;
	Mon, 28 Oct 2024 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OyR4UzE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CA193091
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093741; cv=none; b=mvBplLEkBwgJl16mYUhe4ZlUemqVTtmsQ5/NUfO1xlhB4T22rCj6HrmKI3NEqBrjpS2LoEvr3gWn7X5ydrdJCe/8tMvs6LpuNGHXoF9t22KFA4z9OBgz1h3eju7982JhOg5GrTKRgEc7Le0qUxSIt6lEr3DtCxJMLFRTUYgCmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093741; c=relaxed/simple;
	bh=Nkwh3QiJA9aTcoKTpmFIDuGFx8/lVVwHIIhWeVmB4s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx22IRT+1u/jVShsA6EZIAGQQ9yGUeEKoIjIgfWEpmJlxL93f1yj848UEbReWiHRPVyDcxAQ48SM+SJHcVCGqosAu/Rgwporw1o82SFwdEXm4bnnr39gwnf2PWG6rWx+RMIXxRHH/NQk42gVF9DD6pBBR2qBuIDrpg6JX23X6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OyR4UzE8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so2745520a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730093738; x=1730698538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDUOjHdazO3hfZhAz8wp5HtOCCnbAVZWlUbmSakV3Hk=;
        b=OyR4UzE8+eNh36wY3HECvt4PNCciXaeNmu76a5lASz2W3m4bjXWeXzeKMdTkXfxP90
         TrqvYpPdfAmKjjqmStjTXnurfUyVQwOxkYrFCAyrcBiPRgsMVxSHEoX7LEG6juPSIopM
         H8gqLM4+GjkPN66dVBoZ+E2kfZpbHvbByWSOWoOD7vxDWNmP1jzA5SYsMO8olziAiugC
         9zcXICwtd6D+2zUyLPt2YPaEVX/tz1Vnrrx+oj4BL8KI5sEvpjMeC5Uvr8EMOHHPgH95
         eSTMPWMYqRPXs4oe0y6S0mAJj9QvU0VkNawkS0akSpwzqwUIflH06BCORPDpyENztOl7
         TJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093738; x=1730698538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDUOjHdazO3hfZhAz8wp5HtOCCnbAVZWlUbmSakV3Hk=;
        b=pHpniAdUz8gFLoQhs8uvoz1838c16n5VFJVzeL9LXelSpva4MlKdg1EtiKUB0cO+X3
         6iPbQ16FHSFViBmUQUtpf+uGxywa6Kz/ZIBWGMAJVF8VL0BPaZsuaficynU0N/tHidgo
         Qa5s08hvm3AcX1RRMHpK6Vb367WGfSRhX4z1cq9earjdMEFbEY83K0VyHyge05EzAdQm
         0r1YgmKRFzCCY7WxHl8QZxRXxZn7vqmyEgaSb/n43qa/lOeDQ1+aoryYR53NTKB6aAsN
         4l0OXLomn4szobH28+1FE+Hrw2dnJLsMpfyNHZ9pwiWQWSypZONOGAn36tChzcD1Gvzo
         f/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVRT8LL78ahuldeQLK4h1un0hf9smfNuHJ8Y0W2aU4rnJ01s0KEx7ECDVdlNahxsH5B5hgU36B1o95XOC22@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8AHB88fabAYSJlVDcaD9TVr+DhafILcNfZdjbf4lwEMgiUa+
	BDmvpui0fMFe+VU+u9KVMbzDJEV2J/4tzJEz/ZAQFoMJghQ6Dr4sWN2J8cAaGQM=
X-Google-Smtp-Source: AGHT+IGEBCVr5vnnmMt8QM1QC9K8S8zeTjGifJ6AfCX4y8peAAkOJOV/vgLUse23ENnevtr6MIrR1w==
X-Received: by 2002:a17:90b:30c:b0:2e2:ba35:3574 with SMTP id 98e67ed59e1d1-2e8f105e633mr9719781a91.11.1730093738327;
        Sun, 27 Oct 2024 22:35:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8f8abe1c6sm3864477a91.56.2024.10.27.22.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 22:35:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5IPf-006mu5-0N;
	Mon, 28 Oct 2024 16:35:35 +1100
Date: Mon, 28 Oct 2024 16:35:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <Zx8ip5avDVafVhtL@dread.disaster.area>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023203951.unvxg2claww4s2x5@quack3>
 <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>
 <Zxq4cEVjcHmluc9O@dread.disaster.area>
 <b1defde9-0a14-44ac-9324-9631b6576584@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1defde9-0a14-44ac-9324-9631b6576584@oracle.com>

On Thu, Oct 24, 2024 at 11:23:17PM +0100, John Garry wrote:
> On 24/10/2024 22:13, Dave Chinner wrote:
> > > > BTW, can you please share logs which would contain full stacktraces that
> > > > this softlockup reports produce? The attached dmesg is just from fresh
> > > > boot...  Thanks!
> > > > 
> > > thanks for getting back to me.
> > > 
> > > So I think that enabling /proc/sys/kernel/softlockup_all_cpu_backtrace is
> > > required there. Unfortunately my VM often just locks up without any sign of
> > > life.
> > Attach a "serial" console to the vm - add "console=ttyS0,115600" to
> > the kernel command line and add "-serial pty" to the qemu command
> > line. You can then attach something like minicom to the /dev/pts/X
> > device that qemu creates for the console output and capture
> > everything from initial boot right through to the softlockup traces
> > that are emitted...
> 
> I am using an OCI instance, so I can't change the qemu command line (as far
> as I know).
> 
> For this issue, the Cloud Shell locks up also. There are other console
> connection methods, which I can try.
> 
> BTW, earlier today I got this once when trying to recreate this issue:
> 
> [ 1549.241972] ------------[ cut here ]------------
> [ 1609.240236] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1609.240243] rcu:     5-...!: (0 ticks this GP)
> idle=a8f4/1/0x4000000000000000 softirq=71287/71287 fqs=1
> [ 1609.240249] rcu:     (detected by 2, t=60004 jiffies, g=168077, q=10823
> ncpus=16)
> [ 1609.240252] Sending NMI from CPU 2 to CPUs 5:
> [ 1609.240277] NMI backtrace for cpu 5
> [ 1609.240281] CPU: 5 UID: 1002 PID: 8250 Comm: mysqld Tainted: G W
> 6.12.0-rc4-g556c97f2ecbf #40
> [ 1609.240286] Tainted: [W]=WARN
> [ 1609.240288] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.5.1 06/16/2021
> [ 1609.240289] RIP: 0010:native_halt+0xe/0x20
> [ 1609.240296] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 f4 <e9>
> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
> [ 1609.240298] RSP: 0018:ffffc0c8c71dbd20 EFLAGS: 00000046
> [ 1609.240301] RAX: 0000000000000003 RBX: ffff9ff73fab6580 RCX:
> 0000000000000008
> [ 1609.240303] RDX: ffff9ff7bffaf740 RSI: 0000000000000003 RDI:
> ffff9ff73fab6580
> [ 1609.240304] RBP: ffff9ff73f8b7440 R08: 0000000000000008 R09:
> 0000000000000074
> [ 1609.240306] R10: 0000000000000002 R11: 0000000000000000 R12:
> 0000000000000000
> [ 1609.240307] R13: 0000000000000001 R14: 0000000000000100 R15:
> 0000000000180000
> [ 1609.240311] FS:  00007f9e12600700(0000) GS:ffff9ff73f880000(0000)
> knlGS:0000000000000000
> [ 1609.240313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1609.240315] CR2: 00007f9d63e00004 CR3: 0000001a0bc04005 CR4:
> 0000000000770ef0
> [ 1609.240319] PKRU: 55555554
> [ 1609.240320] Call Trace:
> [ 1609.240322]  <NMI>
> [ 1609.240325]  ? nmi_cpu_backtrace+0x98/0x110
> [ 1609.240330]  ? nmi_cpu_backtrace_handler+0x11/0x20
> [ 1609.240334]  ? nmi_handle+0x5c/0x150
> [ 1609.240339]  ? default_do_nmi+0x4e/0x120
> [ 1609.240343]  ? exc_nmi+0x137/0x1d0
> [ 1609.240347]  ? end_repeat_nmi+0xf/0x53
> [ 1609.240354]  ? native_halt+0xe/0x20
> [ 1609.240357]  ? native_halt+0xe/0x20
> [ 1609.240360]  ? native_halt+0xe/0x20
> [ 1609.240363]  </NMI>
> [ 1609.240364]  <TASK>
> [ 1609.240366]  kvm_wait+0x47/0x60
> [ 1609.240368]  __pv_queued_spin_lock_slowpath+0x255/0x370
> [ 1609.240373]  _raw_spin_lock+0x29/0x30
> [ 1609.240376]  raw_spin_rq_lock_nested+0x1c/0x80
> [ 1609.240381]  __task_rq_lock+0x3f/0xe0
> [ 1609.240384]  try_to_wake_up+0x3cf/0x640
> [ 1609.240387]  ? plist_del+0x63/0xc0
> [ 1609.240391]  wake_up_q+0x4d/0x90
> [ 1609.240394]  futex_wake+0x154/0x180
> [ 1609.240400]  do_futex+0xf8/0x1d0
> [ 1609.240404]  __x64_sys_futex+0x68/0x1c0
> [ 1609.240407]  ? restore_fpregs_from_fpstate+0x3c/0xa0
> [ 1609.240411]  do_syscall_64+0x62/0x170
> [ 1609.240416]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yup, I'm seeing random RCU stalls as well when running a 64p
VM under hard concurrent fstests load. The serial console output is
occasionally tripping RCU stall warnings, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

