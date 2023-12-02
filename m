Return-Path: <linux-fsdevel+bounces-4674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D3801B7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2195C281DE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC079FC06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jDsHLwNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323381B3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 22:37:41 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d81fc0ad6eso980750a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 22:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701499060; x=1702103860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fU6qRJtgEbT1G/wePVSX2m3ILhzk5zEbcdCS9Xw6g4o=;
        b=jDsHLwNPtt0rjbkRzHdLkNbvUdByfdthmCZ3/mu6mLiwIjsQ8Ot8brblxgDGyC597I
         F5IrwguHH5Pr817AJTjACsNmdhoajyWVtHfiO6M57LmRLEX/EpIx9saOTKR4mhMCCPA+
         Z+TDa7y3bCajc4IMSyCPqlkZ56+5bvQocmWG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701499060; x=1702103860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU6qRJtgEbT1G/wePVSX2m3ILhzk5zEbcdCS9Xw6g4o=;
        b=DbFSe4o/iPXyCig2Ihcg1dfuhWMMZgrZfv0mubN2jZuzB3INTi/BMk6ZVPDfmJAJhf
         DFV3ZTlNDT/qCUlrFdPUCHVwoaG93vr6SotgxZz1sGAuPQMR4IeDnFunlge2fl8FXF2v
         86x8uYGYRvp3RWiT6M2QCPZZjlaD5SQwXLDkk/nGrH5ZzI1ptl5ecjZ58SPjc2wpXR00
         IMBgJ25h+gVNX0/cStdDpAZ2noWZLUKS7hAaNzW31aer2282kOCU1J2KujiwTbYmUSAt
         MJwz5HGCCT6PjGXAUSnLWfOh0ULOEGIJ9YsVZGZc6wb9A3VWECrMG1q3FKPs9V3ERYK+
         7zlA==
X-Gm-Message-State: AOJu0Ywg844gFB7V9Re7lLaU6DUYlcdz0yGR+1WrANmkEln19X2H2//t
	hMkI+vDO8s+jEVmpJxysfS8JXw==
X-Google-Smtp-Source: AGHT+IHnEp3NIeb+BoU6LcDHhI9xngPKkOaRLjSefVBiChRgLsiCllOprO6iu5BrunNCLL0JFKAnkw==
X-Received: by 2002:a05:6830:3a87:b0:6d8:74e2:634d with SMTP id dj7-20020a0568303a8700b006d874e2634dmr708294otb.39.1701499060469;
        Fri, 01 Dec 2023 22:37:40 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id 13-20020a056a00072d00b006cdb8ef2db6sm4028316pfm.94.2023.12.01.22.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 22:37:39 -0800 (PST)
Date: Sat, 2 Dec 2023 15:37:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Minchan Kim <minchan@kernel.org>
Subject: Re: [RFC PATCH 2/6] debugfs: annotate debugfs handlers vs. removal
 with lockdep
Message-ID: <20231202063735.GD404241@google.com>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
 <20231109222251.a62811ebde9b.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109222251.a62811ebde9b.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>

On (23/11/09 22:22), Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When you take a lock in a debugfs handler but also try
> to remove the debugfs file under that lock, things can
> deadlock since the removal has to wait for all users
> to finish.
> 
> Add lockdep annotations in debugfs_file_get()/_put()
> to catch such issues.

So this triggers when I reset zram device (zsmalloc compiled with
CONFIG_ZSMALLOC_STAT).

debugfs_create_file() and debugfs_remove_recursive() are called
under zram->init_lock, and zsmalloc never calls into zram code.
What I don't really get is where does the
	`debugfs::classes -> zram->init_lock`
dependency come from?

[   47.283364] ======================================================
[   47.284790] WARNING: possible circular locking dependency detected
[   47.286217] 6.7.0-rc3-next-20231201+ #239 Tainted: G                 N
[   47.287723] ------------------------------------------------------
[   47.289145] zram-test.sh/727 is trying to acquire lock:
[   47.290350] ffff88814b824070 (debugfs:classes){++++}-{0:0}, at: remove_one+0x65/0x210
[   47.292202] 
[   47.292202] but task is already holding lock:
[   47.293554] ffff88812fe7ee48 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: simple_recursive_removal+0x217/0x3a0
[   47.295895] 
[   47.295895] which lock already depends on the new lock.
[   47.295895] 
[   47.297757] 
[   47.297757] the existing dependency chain (in reverse order) is:
[   47.299498] 
[   47.299498] -> #4 (&sb->s_type->i_mutex_key#2){++++}-{3:3}:
[   47.301129]        down_write+0x40/0x80
[   47.302028]        start_creating+0xa5/0x1b0
[   47.303024]        debugfs_create_dir+0x16/0x240
[   47.304104]        zs_create_pool+0x5da/0x6f0
[   47.305123]        disksize_store+0xce/0x320
[   47.306129]        kernfs_fop_write_iter+0x1cb/0x270
[   47.307279]        vfs_write+0x42f/0x4c0
[   47.308205]        ksys_write+0x8f/0x110
[   47.309129]        do_syscall_64+0x40/0xe0
[   47.310100]        entry_SYSCALL_64_after_hwframe+0x62/0x6a
[   47.311403] 
[   47.311403] -> #3 (&zram->init_lock){++++}-{3:3}:
[   47.312856]        down_write+0x40/0x80
[   47.313755]        zram_reset_device+0x22/0x2b0
[   47.314814]        reset_store+0x15b/0x190
[   47.315788]        kernfs_fop_write_iter+0x1cb/0x270
[   47.316946]        vfs_write+0x42f/0x4c0
[   47.317869]        ksys_write+0x8f/0x110
[   47.318787]        do_syscall_64+0x40/0xe0
[   47.319754]        entry_SYSCALL_64_after_hwframe+0x62/0x6a
[   47.321051] 
[   47.321051] -> #2 (&of->mutex){+.+.}-{3:3}:
[   47.322374]        __mutex_lock+0x97/0x810
[   47.323338]        kernfs_seq_start+0x34/0x190
[   47.324387]        seq_read_iter+0x1e1/0x6c0
[   47.325389]        vfs_read+0x38f/0x420
[   47.326295]        ksys_read+0x8f/0x110
[   47.327200]        do_syscall_64+0x40/0xe0
[   47.328164]        entry_SYSCALL_64_after_hwframe+0x62/0x6a
[   47.329460] 
[   47.329460] -> #1 (&p->lock){+.+.}-{3:3}:
[   47.330740]        __mutex_lock+0x97/0x810
[   47.331717]        seq_read_iter+0x5c/0x6c0
[   47.332696]        seq_read+0xfe/0x140
[   47.333577]        full_proxy_read+0x90/0x110
[   47.334598]        vfs_read+0xfb/0x420
[   47.335482]        ksys_read+0x8f/0x110
[   47.336382]        do_syscall_64+0x40/0xe0
[   47.337344]        entry_SYSCALL_64_after_hwframe+0x62/0x6a
[   47.338636] 
[   47.338636] -> #0 (debugfs:classes){++++}-{0:0}:
[   47.340056]        __lock_acquire+0x20b1/0x3b50
[   47.341117]        lock_acquire+0xe3/0x210
[   47.342072]        remove_one+0x7d/0x210
[   47.342991]        simple_recursive_removal+0x325/0x3a0
[   47.344210]        debugfs_remove+0x40/0x60
[   47.345181]        zs_destroy_pool+0x4e/0x3d0
[   47.346199]        zram_reset_device+0x151/0x2b0
[   47.347272]        reset_store+0x15b/0x190
[   47.348257]        kernfs_fop_write_iter+0x1cb/0x270
[   47.349426]        vfs_write+0x42f/0x4c0
[   47.350350]        ksys_write+0x8f/0x110
[   47.351273]        do_syscall_64+0x40/0xe0
[   47.352239]        entry_SYSCALL_64_after_hwframe+0x62/0x6a
[   47.353536] 
[   47.353536] other info that might help us debug this:
[   47.353536] 
[   47.355381] Chain exists of:
[   47.355381]   debugfs:classes --> &zram->init_lock --> &sb->s_type->i_mutex_key#2
[   47.355381] 
[   47.358105]  Possible unsafe locking scenario:
[   47.358105] 
[   47.359484]        CPU0                    CPU1
[   47.360545]        ----                    ----
[   47.361599]   lock(&sb->s_type->i_mutex_key#2);
[   47.362665]                                lock(&zram->init_lock);
[   47.364146]                                lock(&sb->s_type->i_mutex_key#2);
[   47.365781]   lock(debugfs:classes);
[   47.366626] 
[   47.366626]  *** DEADLOCK ***
[   47.366626] 
[   47.368005] 5 locks held by zram-test.sh/727:
[   47.369028]  #0: ffff88811420c420 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xff/0x4c0
[   47.370873]  #1: ffff8881346e1090 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x126/0x270
[   47.372932]  #2: ffff88810b7bfb38 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x137/0x270
[   47.375052]  #3: ffff88810b3e60b0 (&zram->init_lock){++++}-{3:3}, at: zram_reset_device+0x22/0x2b0
[   47.377131]  #4: ffff88812fe7ee48 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: simple_recursive_removal+0x217/0x3a0
[   47.379599] 
[   47.379599] stack backtrace:
[   47.380619] CPU: 39 PID: 727 Comm: zram-test.sh Tainted: G                 N 6.7.0-rc3-next-20231201+ #239
[   47.382836] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.384976] Call Trace:
[   47.385565]  <TASK>
[   47.386074]  dump_stack_lvl+0x6e/0xa0
[   47.386942]  check_noncircular+0x1b6/0x1e0
[   47.387910]  ? lockdep_unlock+0x96/0x130
[   47.388838]  __lock_acquire+0x20b1/0x3b50
[   47.389789]  ? d_walk+0x3c3/0x410
[   47.390589]  lock_acquire+0xe3/0x210
[   47.391449]  ? remove_one+0x65/0x210
[   47.392301]  ? preempt_count_sub+0x14/0xc0
[   47.393264]  ? _raw_spin_unlock+0x29/0x40
[   47.394214]  ? d_walk+0x3c3/0x410
[   47.395005]  ? remove_one+0x65/0x210
[   47.395866]  remove_one+0x7d/0x210
[   47.396675]  ? remove_one+0x65/0x210
[   47.397523]  ? d_invalidate+0xbe/0x170
[   47.398412]  simple_recursive_removal+0x325/0x3a0
[   47.399521]  ? debugfs_remove+0x60/0x60
[   47.400430]  debugfs_remove+0x40/0x60
[   47.401302]  zs_destroy_pool+0x4e/0x3d0
[   47.402214]  zram_reset_device+0x151/0x2b0
[   47.403187]  reset_store+0x15b/0x190
[   47.404043]  ? sysfs_kf_read+0x170/0x170
[   47.404968]  kernfs_fop_write_iter+0x1cb/0x270
[   47.406015]  vfs_write+0x42f/0x4c0
[   47.406829]  ksys_write+0x8f/0x110
[   47.407642]  do_syscall_64+0x40/0xe0
[   47.408491]  entry_SYSCALL_64_after_hwframe+0x62/0x6a

