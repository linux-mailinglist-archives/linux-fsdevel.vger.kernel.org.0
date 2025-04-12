Return-Path: <linux-fsdevel+bounces-46309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00DA86A23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C761B67D8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6A55897;
	Sat, 12 Apr 2025 01:48:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C32367D9
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422524; cv=none; b=tw/erZ5qo8SWnuXAZDTzh5HY1PQY2Z0LUZsLRlFWiDtiSV7cuvrO9ZLF/B6c8QLriRKifa9pHyAgWxSnRph8HyyQozhJK9P+b9ZJaTmse17ElCYyiChR5eTEbejipQ4u6imiY+05QjRzX42F4bssoosliASozXw26sPBWmVDi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422524; c=relaxed/simple;
	bh=5W4+1tVxQPo7ce5wBU6G4OTRGTrLzwThjjQFJnlD+wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4o/06xrcVF7i9cwrzvm1elrpyM6LAaZ4/DbYfR/Oq4my7YjtGmYWgdZ4NPX/183vA/CIpfO0v1jsb6gK9cn2elXlntEPaprXdUkvRYl2Ji4oQFLraPZGcHAC2YpZ5cvYGdBbN2RMNlwCLsYCMdXSe20wwQe1fkQAxpk2ch6ryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 748D1100C33
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 11:48:34 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tcOh11ivJis for <linux-fsdevel@vger.kernel.org>;
	Sat, 12 Apr 2025 11:48:34 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 64EBE100C50; Sat, 12 Apr 2025 11:48:34 +1000 (AEST)
X-Spam-Level: 
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 67479100B3A;
	Sat, 12 Apr 2025 11:48:26 +1000 (AEST)
Message-ID: <3be4c502-8246-436e-a7cf-3eb4be6ff7d4@themaw.net>
Date: Sat, 12 Apr 2025 09:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bad things when too many negative dentries in a directory
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <20250411-rennen-bleichen-894e4b8d86ac@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/4/25 22:47, Christian Brauner wrote:
> On Fri, Apr 11, 2025 at 11:40:28AM +0200, Miklos Szeredi wrote:
>> There are reports of soflockups in fsnotify if there are large numbers
>> of negative dentries (e.g. ~300M) in a directory.   This can happen if
>> lots of temp files are created and removed and there's not enough
>> memory pressure to trigger the lru shrinker.
>>
>> These are on old kernels and some of this is possibly due to missing
>> 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily"), but I
>> managed to reproduce the softlockup on a recent kernel in
>> fsnotify_set_children_dentry_flags() (see end of mail).
>>
>> This was with ~1.2G negative dentries.  Doing "rmdir testdir"
>> afterwards does not trigger the softlockup detector, due to the
>> reschedules in shrink_dcache_parent() code, but it took 10 minutes(!)
>> to finish removing that empty directory.
>>
>> So I wonder, do we really want negative dentries on ->d_children?
>> Except for shrink_dcache_parent() I don't see any uses.  And it's also
>> a question whether shrinking negative dentries is useful or not.  If
>> they've been around for so long that hundreds of millions of them
>> could accumulate and that memory wasn't needed by anybody, then it
>> shouldn't make a big difference if they kept hanging around. On
>> umount, at the latest, the lru list can be used to kill everything,
>> AFAICT.
>>
>> I'm curious if this is the right path?  Any better ideas?
> Note that we have a new sysctl:
>
> /proc/sys/fs/dentry-negative
>
> that can be used to control the negative dentry policy because any
> generic change that we tried to make has always resulted in unacceptable
> regressions for someone's workload. Currently we only allow it to be set
> to 1 (default 0). If set to 1 it will not create negative dentries
> during unlink. If that's sufficient than recommend this to users that
> suffer from this problem if not consider adding another sensitive
> policy.

Interesting, I wasn't sure how the negative dentries were accumulating but

I didn't actually look at the unlink code (I'll take a look). I thought the

most likely cause was laziness not unlinking temporary files (the file names

in question "looked" like temporary file names).


When I do look at unlink I suspect I'll find the VFS is justified in caching

these and the responsibility (or should) lies with the file system call back

to unhash the dentry if it doesn't want this caching ... but the file system

always doing this is not ideal either ... maybe we need a hint so that the

relevant file system callbacks can make this decision for themselves.


Ian

>
>> Thanks,
>> Miklos
>>
>>
>> [96789.366007] watchdog: BUG: soft lockup - CPU#79 stuck for 26s!
>> [fanotify4:52805]
>> [96789.373396] Modules linked in: rfkill mlx5_ib ib_uverbs macsec
>> ib_core vfat fat mlx5_core acpi_ipmi ast ipmi_ssif arm_spe_pmu igb
>> mlxfw psample i2c_algo_bit tls pci_hyperv_intf ipmi_devintf
>> ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq loop
>> fuse nfnetlink xfs nvme crct10dif_ce ghash_ce sha2_ce sha256_arm64
>> nvme_core sha1_ce sbsa_gwdt nvme_auth i2c_designware_platform
>> i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
>> [96789.413624] CPU: 79 UID: 0 PID: 52805 Comm: fanotify4 Kdump: loaded
>> Not tainted 6.12.0-55.9.1.el10_0.aarch64 #1
>> [96789.423698] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS
>> F31n (SCP: 2.10.20220810) 09/30/2022
>> [96789.432990] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [96789.439939] pc : fsnotify_set_children_dentry_flags+0x80/0xf0
>> [96789.445675] lr : fsnotify_set_children_dentry_flags+0xa4/0xf0
>> [96789.451408] sp : ffff8000cc77b8c0
>> [96789.454710] x29: ffff8000cc77b8c0 x28: 0000000000000001 x27: 0000000000000000
>> [96789.461833] x26: ffff07ff8463dc50 x25: ffff080e6e44dc50 x24: 0000000000000001
>> [96789.468956] x23: ffff07ff9d94eec0 x22: ffff07fff2cf01b8 x21: ffff07ff9d94ee40
>> [96789.476079] x20: ffff0800eb6dff40 x19: ffff0800eb6df2c0 x18: 0000000000000014
>> [96789.483202] x17: 00000000cec6e315 x16: 00000000ed365140 x15: 00000000ae8684a4
>> [96789.490325] x14: 000000000d831309 x13: 00000000387d7ee0 x12: 0000000000000000
>> [96789.497448] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffc3bacc1864bc
>> [96789.504570] x8 : 000000001007ffff x7 : ffffc3bace89a4c0 x6 : 0000000000000001
>> [96789.511694] x5 : 0000000008000020 x4 : 0000000000000000 x3 : 0000000000000003
>> [96789.518816] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0800eb6df358
>> [96789.525939] Call trace:
>> [96789.528373]  fsnotify_set_children_dentry_flags+0x80/0xf0
>> [96789.533759]  fsnotify_recalc_mask.part.0+0x94/0xc8
>> [96789.538538]  fsnotify_recalc_mask+0x1c/0x40
>> [96789.542709]  fanotify_add_mark+0x15c/0x360
>> [96789.546794]  do_fanotify_mark+0x3c0/0x7a0
>> [96789.550791]  __arm64_sys_fanotify_mark+0x30/0x60
>> [96789.555396]  invoke_syscall.constprop.0+0x74/0xd0
>> [96789.560090]  do_el0_svc+0xb0/0xe8
>> [96789.563393]  el0_svc+0x44/0x1d0
>> [96789.566525]  el0t_64_sync_handler+0x120/0x130
>> [96789.570870]  el0t_64_sync+0x1a4/0x1a8
>> [151513.714945] INFO: task (ostnamed):77658 blocked for more than 122 seconds.
>> [151513.721903]       Tainted: G             L    -------  ---
>> 6.12.0-55.9.1.el10_0.aarch64 #1
>> [151513.730334] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [151513.738241] task:(ostnamed)      state:D stack:0     pid:77658
>> tgid:77658 ppid:1      flags:0x00000205
>> [151513.747625] Call trace:
>> [151513.750146]  __switch_to+0xec/0x148
>> [151513.753712]  __schedule+0x234/0x738
>> [151513.757278]  schedule+0x3c/0xe0
>> [151513.760493]  schedule_preempt_disabled+0x2c/0x58
>> [151513.765188]  rwsem_down_write_slowpath+0x1e4/0x720
>> [151513.770054]  down_write+0xac/0xc0
>> [151513.773444]  do_lock_mount+0x3c/0x220
>> [151513.777185]  path_mount+0x378/0x810
>> [151513.780748]  __arm64_sys_mount+0x158/0x2d8
>> [151513.784921]  invoke_syscall.constprop.0+0x74/0xd0
>> [151513.789702]  do_el0_svc+0xb0/0xe8
>> [151513.793093]  el0_svc+0x44/0x1d0
>> [151513.796312]  el0t_64_sync_handler+0x120/0x130
>> [151513.800744]  el0t_64_sync+0x1a4/0x1a8

