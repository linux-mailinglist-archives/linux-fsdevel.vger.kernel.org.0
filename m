Return-Path: <linux-fsdevel+bounces-46243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F360A85834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66298C5967
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E71EE017;
	Fri, 11 Apr 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nEJnnNQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882B290BC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364442; cv=none; b=Wxz/BwAU9WP9uvr7de0HwV+hCn5Iqqn84YkXLjcTJuENricC0OfxdG8GfnItrkoxZ3vaqxSR4sYb99cUUdskuR0WJNOd8+vYjkHo4cJvxDo2ORZLIc0mHoKqRu91bfJyhd/4/zXnbwdtNjmmAk/UfuXk/eakOo4S11JI2Hz/Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364442; c=relaxed/simple;
	bh=0TCPZ6U9nHyN4FMKSrPcFoAnI2xEIATR9nEgsM+Bnaw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OdNeh7dkoL842s/10If59xNg0YCIRpVdxraLkCR2ZvFDTqJdojqu/v2fCOK19ShuYqbdqqBpkTYxaY86q/XS6KQHsUEqKMYnDzdSlFBdA2JjOecsZUMdYue2spntS6J3UTz9y/0nNYRYalZEY9dPR2ML7cWeGuPqqPE4Dg1Htz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nEJnnNQq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c560c55bc1so186823485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744364438; x=1744969238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGAaSe4lHBB/iLCfF9u1m5RobCTbqv8Peph80ehxIVo=;
        b=nEJnnNQqRRciIImqOk02+tzy/AWd7Cz0iRgH0HkNw+PTr7YYmZKpM25s3JzehOIRe3
         +MQJ4x4UMSXUa19IaoTd5cfdr/rktxHOqoAZnzIaGkGPTjf82P+Pbg+t9tDYKIYInNpG
         9qd0Gq/tkLzLoy2xN/otcW04xkPfZAK3/hEl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744364438; x=1744969238;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGAaSe4lHBB/iLCfF9u1m5RobCTbqv8Peph80ehxIVo=;
        b=QnvHiFglqLFyEX5jg1aRlrERXujiXjsLziqR3iTxfPQ0Xyuf4RqCzV10tN/wdEP7Ug
         t78OWnw61m/hKwbpIp48kzy7qjPCSu/j6+y7oqUX0NPpUUNRdhhajiAtNbtmWa/iQVrE
         AZGPp0YQmFaHsfnYBgLbj7fjDZ11ENULSvMmFcG8A+P6mlrUGfo9MxOpyPn25jE0Q8mM
         xbNiGCW5BIWGRtqRfkBsydJHehMFroh6O/ns9wpmFXUle/pCWdUOkVO9zydOfDhPwbM1
         C/ofiEExOSqITY/VNAoGQWbY/eunlrrTPEijF8LJPINxBy48A5hofr/rFWMGfPmuPR5T
         coaA==
X-Gm-Message-State: AOJu0Yy53WLO+Ge2x7fNK5al9gIm2tDvaAcbIXcB7bHneHs21ylrkNIk
	JhBdeDjaUOJqw3eZNqGmKRhcMEXjqvaEBscax/XihLaHYUzGDu5hAFQAngJ4MIBjb39nXmcCoNC
	2t3LH5cM1C4vb4ggH+NF05nDeVeVYlLt8FhNRvdvIvYnglT5mavY=
X-Gm-Gg: ASbGncv6krYyb13c/NlhJz6bE9PVAb0K5hLPheSN17sWLGFeVGCMqPBFNCn0N1mB5Gp
	HEjX/t5UbpCDZvDMsyfJHCRqDC9EkW0FjbdApeVfzPta7N9EEqbJIcjc6y+yWTYLbUxNG7vroMo
	IgiUb6jpRY2s+e7g+/D5dSXQI=
X-Google-Smtp-Source: AGHT+IE+B9WR69lygMZw04kd6bLY5/ckgzwhgUkfRUDKwzW2mwxCgB25kgNSXb626GGhU2SLpnOHndZvx02QHC/KTws=
X-Received: by 2002:a05:620a:248c:b0:7c5:5d9b:b617 with SMTP id
 af79cd13be357-7c7af0d5da3mr277208585a.23.1744364438624; Fri, 11 Apr 2025
 02:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Apr 2025 11:40:28 +0200
X-Gm-Features: ATxdqUGQzBvy7h8PeGceG6Z0_XKKalPOAMyxMGUMc-G1IHYqwVnm_DBOEo9LOdk
Message-ID: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
Subject: bad things when too many negative dentries in a directory
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

There are reports of soflockups in fsnotify if there are large numbers
of negative dentries (e.g. ~300M) in a directory.   This can happen if
lots of temp files are created and removed and there's not enough
memory pressure to trigger the lru shrinker.

These are on old kernels and some of this is possibly due to missing
172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily"), but I
managed to reproduce the softlockup on a recent kernel in
fsnotify_set_children_dentry_flags() (see end of mail).

This was with ~1.2G negative dentries.  Doing "rmdir testdir"
afterwards does not trigger the softlockup detector, due to the
reschedules in shrink_dcache_parent() code, but it took 10 minutes(!)
to finish removing that empty directory.

So I wonder, do we really want negative dentries on ->d_children?
Except for shrink_dcache_parent() I don't see any uses.  And it's also
a question whether shrinking negative dentries is useful or not.  If
they've been around for so long that hundreds of millions of them
could accumulate and that memory wasn't needed by anybody, then it
shouldn't make a big difference if they kept hanging around. On
umount, at the latest, the lru list can be used to kill everything,
AFAICT.

I'm curious if this is the right path?  Any better ideas?

Thanks,
Miklos


[96789.366007] watchdog: BUG: soft lockup - CPU#79 stuck for 26s!
[fanotify4:52805]
[96789.373396] Modules linked in: rfkill mlx5_ib ib_uverbs macsec
ib_core vfat fat mlx5_core acpi_ipmi ast ipmi_ssif arm_spe_pmu igb
mlxfw psample i2c_algo_bit tls pci_hyperv_intf ipmi_devintf
ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq loop
fuse nfnetlink xfs nvme crct10dif_ce ghash_ce sha2_ce sha256_arm64
nvme_core sha1_ce sbsa_gwdt nvme_auth i2c_designware_platform
i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
[96789.413624] CPU: 79 UID: 0 PID: 52805 Comm: fanotify4 Kdump: loaded
Not tainted 6.12.0-55.9.1.el10_0.aarch64 #1
[96789.423698] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[96789.432990] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[96789.439939] pc : fsnotify_set_children_dentry_flags+0x80/0xf0
[96789.445675] lr : fsnotify_set_children_dentry_flags+0xa4/0xf0
[96789.451408] sp : ffff8000cc77b8c0
[96789.454710] x29: ffff8000cc77b8c0 x28: 0000000000000001 x27: 0000000000000000
[96789.461833] x26: ffff07ff8463dc50 x25: ffff080e6e44dc50 x24: 0000000000000001
[96789.468956] x23: ffff07ff9d94eec0 x22: ffff07fff2cf01b8 x21: ffff07ff9d94ee40
[96789.476079] x20: ffff0800eb6dff40 x19: ffff0800eb6df2c0 x18: 0000000000000014
[96789.483202] x17: 00000000cec6e315 x16: 00000000ed365140 x15: 00000000ae8684a4
[96789.490325] x14: 000000000d831309 x13: 00000000387d7ee0 x12: 0000000000000000
[96789.497448] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffc3bacc1864bc
[96789.504570] x8 : 000000001007ffff x7 : ffffc3bace89a4c0 x6 : 0000000000000001
[96789.511694] x5 : 0000000008000020 x4 : 0000000000000000 x3 : 0000000000000003
[96789.518816] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0800eb6df358
[96789.525939] Call trace:
[96789.528373]  fsnotify_set_children_dentry_flags+0x80/0xf0
[96789.533759]  fsnotify_recalc_mask.part.0+0x94/0xc8
[96789.538538]  fsnotify_recalc_mask+0x1c/0x40
[96789.542709]  fanotify_add_mark+0x15c/0x360
[96789.546794]  do_fanotify_mark+0x3c0/0x7a0
[96789.550791]  __arm64_sys_fanotify_mark+0x30/0x60
[96789.555396]  invoke_syscall.constprop.0+0x74/0xd0
[96789.560090]  do_el0_svc+0xb0/0xe8
[96789.563393]  el0_svc+0x44/0x1d0
[96789.566525]  el0t_64_sync_handler+0x120/0x130
[96789.570870]  el0t_64_sync+0x1a4/0x1a8
[151513.714945] INFO: task (ostnamed):77658 blocked for more than 122 seconds.
[151513.721903]       Tainted: G             L    -------  ---
6.12.0-55.9.1.el10_0.aarch64 #1
[151513.730334] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[151513.738241] task:(ostnamed)      state:D stack:0     pid:77658
tgid:77658 ppid:1      flags:0x00000205
[151513.747625] Call trace:
[151513.750146]  __switch_to+0xec/0x148
[151513.753712]  __schedule+0x234/0x738
[151513.757278]  schedule+0x3c/0xe0
[151513.760493]  schedule_preempt_disabled+0x2c/0x58
[151513.765188]  rwsem_down_write_slowpath+0x1e4/0x720
[151513.770054]  down_write+0xac/0xc0
[151513.773444]  do_lock_mount+0x3c/0x220
[151513.777185]  path_mount+0x378/0x810
[151513.780748]  __arm64_sys_mount+0x158/0x2d8
[151513.784921]  invoke_syscall.constprop.0+0x74/0xd0
[151513.789702]  do_el0_svc+0xb0/0xe8
[151513.793093]  el0_svc+0x44/0x1d0
[151513.796312]  el0t_64_sync_handler+0x120/0x130
[151513.800744]  el0t_64_sync+0x1a4/0x1a8

