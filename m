Return-Path: <linux-fsdevel+bounces-20502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676CD8D45B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EBAB24084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 07:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD83DABE9;
	Thu, 30 May 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhljHI3L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B6143727;
	Thu, 30 May 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052665; cv=none; b=lNDjxwZNIynDlcz252GiJ1ubXEF56GfpOvtnsdd58DFDCq7XbsStDkDb7GYRBjN3AAjKvtK4sm6kGGsa13Efd2MLyqh9fBf75Xl04oL4asvYi3GEqYp/iXMYv/YV5JKHQgWmFJDSnCzKfwsbfX3tF28hLdX7izL9FYwW0TBIPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052665; c=relaxed/simple;
	bh=IuWXRoKt0Vda7ySINYJLMDsAIM6XZ2RgN5AA+dUFZXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLeFuD+CbZ3Q3icQA2Gsvun3/+V2O7aXFnAcyNn3hHDwBMczGBrxbukUwljlXLDHkjrV4B3oNpz5Td/47lbZxqWW2/GU+qPAQOybAdnScw7skzlFlB7uMZ8poEg35oi2++zGotBVItuc3SMrLmnrS1GaSjrsERzq3aQbh41tb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhljHI3L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ab9d9f0ee2so2059046d6.3;
        Thu, 30 May 2024 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717052662; x=1717657462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaUlsS1ePGHCHrnvMkDqo0MpQ0D+mVu2iqLzzZf7A4c=;
        b=RhljHI3LaI2MbQRmKg9uZpz6NOhQJTWZFRF8MxpEe4Jltqpa7DZeGymIs3D1n1eSzN
         wzEhqQB9KcUMvgl6bXeNktVerbBd3yvxoYgpJfuO5hBhdsSKUXmQuN+WxOaM/NE5qgp6
         r9dHYb28qU9m+5tPhgsiKR81jE9YgkHN8auQGCrtUN9DGSyWTxVadPLvmV5Q+4WohhGx
         9IZEWdjohVZWBgeBIWAqZ+bLcTjV80o/bG2v61Oa5zXEZmqGfsCTOAkQU7XkcdpzqTCB
         urXWW6zS4YsWBW7tQdNwvg0koA8AQnbkL+3BE0wxNALe6oqzCVRQvHygtkzpnjiCHX16
         ZByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717052662; x=1717657462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaUlsS1ePGHCHrnvMkDqo0MpQ0D+mVu2iqLzzZf7A4c=;
        b=Blc9cgDMNTaqFyiPpW53RoJRrlqgIn2idUk5nTJCtwpk5dJSQsSZOYYUkKWlkeGWjE
         xaZ7aTq2YwuQCgS+orAHDa2yrLUpjrqsvoB+b3rQ/Mgk/3LcutKs3/86my2b4eDESu/C
         GpgGoMw8r1ZbJWu/S6W8e528AGX7nFC5RCOsSoO3Scjdzf6n9gzNo7JDu0dCoGoV1YT1
         0nQFtsweVg+9T5hMvDoB3zIBmo5pJ8dkP7jw/SNBk6HGvSMDNxKtadU/KC+GU1B1WRqA
         hL0T8ne7h7ikYFruc/oG6TXprfHXt0PFrbXU15x+6DvcxAdFj4lYVG/0k6QVqo00+9pe
         +n6g==
X-Forwarded-Encrypted: i=1; AJvYcCWShWt/B/0OPwk0el2QJc58wJ3cCV8bRqZPI5Urt7VwhwBnxNr/hIF+W3/O0Xve9UWkSEkDAg1yisEznUycZ42t38nbf1elHN10oe7kSY2Cne4SuN/UKUdD9tByuuksPlzrKpMcBfbrjV+4EA==
X-Gm-Message-State: AOJu0Yz4ERQ0ufNeR/ojG0rzwP3A5cCMnrnaN4ChXznU11/xeYs42oYz
	jdazGR4S3lCnEzH6augfEK7XR4XS+PbZbATm9Q01Joh+6KNfQT31ICTEC/GOLJbddVlSqPbNzOo
	jEKA/k1VlMF3At1oDxzBJaWdqabM=
X-Google-Smtp-Source: AGHT+IFQiOmb3dQ5hvUp1rbKF61gb6kMqn/i8DMawpaq/sUFnU3c13M4jxRIunwOTrEzwn9ekAzKaMWDurTdpflkeZQ=
X-Received: by 2002:a0c:f8c5:0:b0:6ae:116b:ef6a with SMTP id
 6a1803df08f44-6ae116bf4d8mr5393436d6.60.1717052662119; Thu, 30 May 2024
 00:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405291318.4dfbb352-oliver.sang@intel.com>
In-Reply-To: <202405291318.4dfbb352-oliver.sang@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 May 2024 15:03:45 +0800
Message-ID: <CALOAHbBOpjbY=daw0WKHGvmA5Uh7zoW5bYf9CEoVVKsFDy9kVA@mail.gmail.com>
Subject: Re: [linus:master] [vfs] 681ce86235: filebench.sum_operations/s -7.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:52=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, Yafang Shao,
>
> we captured this filebench regression after this patch is merged into mai=
line.
>
> we noticed there is difference with original version in
> https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/
>
> but we confirmed there is similar regression by origial version. details =
as
> below [1] FYI.
>
>
>
> Hello,
>
> kernel test robot noticed a -7.4% regression of filebench.sum_operations/=
s on:
>
>
> commit: 681ce8623567ba7e7333908e9826b77145312dda ("vfs: Delete the associ=
ated dentry when deleting a file")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
>
> [still regression on linus/master 2bfcfd584ff5ccc8bb7acde19b42570414bf880=
b]
>
>
> testcase: filebench
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
> parameters:
>
>         disk: 1HDD
>         fs: ext4
>         test: webproxy.f
>         cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405291318.4dfbb352-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240529/202405291318.4dfbb352-ol=
iver.sang@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase=
:
>   gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.=
cgz/lkp-icl-2sp6/webproxy.f/filebench
>
> commit:
>   29c73fc794 ("Merge tag 'perf-tools-for-v6.10-1-2024-05-21' of git://git=
.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")
>   681ce86235 ("vfs: Delete the associated dentry when deleting a file")
>
> 29c73fc794c83505 681ce8623567ba7e7333908e982
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   31537383 =C4=85  2%     -75.1%    7846497 =C4=85  4%  cpuidle..usage
>      27.21            +1.4%      27.59        iostat.cpu.system
>    3830823 =C4=85  5%     -16.2%    3208825 =C4=85  4%  numa-numastat.nod=
e1.local_node
>    3916065 =C4=85  5%     -16.3%    3277633 =C4=85  3%  numa-numastat.nod=
e1.numa_hit
>     455641           -74.2%     117514 =C4=85  4%  vmstat.system.cs
>      90146           -34.9%      58712        vmstat.system.in
>       0.14            -0.0        0.12 =C4=85  2%  mpstat.cpu.all.irq%
>       0.07            -0.0        0.04 =C4=85  2%  mpstat.cpu.all.soft%
>       0.56            -0.2        0.36 =C4=85  2%  mpstat.cpu.all.usr%
>       2038 =C4=85  6%     -25.8%       1511 =C4=85  3%  perf-c2c.DRAM.loc=
al
>      20304 =C4=85 14%     -62.9%       7523 =C4=85  2%  perf-c2c.DRAM.rem=
ote
>      18850 =C4=85 16%     -71.0%       5470 =C4=85  2%  perf-c2c.HITM.loc=
al
>      13220 =C4=85 15%     -68.1%       4218 =C4=85  3%  perf-c2c.HITM.rem=
ote
>      32070 =C4=85 15%     -69.8%       9688 =C4=85  2%  perf-c2c.HITM.tot=
al
>     191435 =C4=85  7%     +37.3%     262935 =C4=85 11%  sched_debug.cfs_r=
q:/.avg_vruntime.stddev
>     191435 =C4=85  7%     +37.3%     262935 =C4=85 11%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>     285707           -72.1%      79601 =C4=85 11%  sched_debug.cpu.nr_swi=
tches.avg
>     344088 =C4=85  2%     -69.8%     103953 =C4=85  9%  sched_debug.cpu.n=
r_switches.max
>     206926 =C4=85  8%     -73.0%      55912 =C4=85 15%  sched_debug.cpu.n=
r_switches.min
>      26177 =C4=85 10%     -63.9%       9453 =C4=85 10%  sched_debug.cpu.n=
r_switches.stddev
>       5.00 =C4=85  9%     +21.2%       6.06 =C4=85  6%  sched_debug.cpu.n=
r_uninterruptible.stddev
>     497115 =C4=85 40%     -44.8%     274644 =C4=85 44%  numa-meminfo.node=
0.AnonPages
>    2037838 =C4=85 26%     -78.4%     440153 =C4=85 49%  numa-meminfo.node=
1.Active
>    2001934 =C4=85 26%     -79.8%     405182 =C4=85 52%  numa-meminfo.node=
1.Active(anon)
>     527723 =C4=85 38%     +42.4%     751463 =C4=85 16%  numa-meminfo.node=
1.AnonPages
>    3853109 =C4=85 35%     -85.5%     559704 =C4=85 33%  numa-meminfo.node=
1.FilePages
>      93331 =C4=85 18%     -58.7%      38529 =C4=85 22%  numa-meminfo.node=
1.Mapped
>    5189577 =C4=85 27%     -61.5%    1999161 =C4=85 13%  numa-meminfo.node=
1.MemUsed
>    2014284 =C4=85 26%     -78.2%     439808 =C4=85 51%  numa-meminfo.node=
1.Shmem
>     123485 =C4=85 41%     -45.0%      67888 =C4=85 44%  numa-vmstat.node0=
.nr_anon_pages
>     500704 =C4=85 26%     -79.8%     101309 =C4=85 52%  numa-vmstat.node1=
.nr_active_anon
>     131174 =C4=85 38%     +42.6%     187092 =C4=85 16%  numa-vmstat.node1=
.nr_anon_pages
>     963502 =C4=85 35%     -85.5%     139952 =C4=85 33%  numa-vmstat.node1=
.nr_file_pages
>      23724 =C4=85 18%     -59.2%       9690 =C4=85 22%  numa-vmstat.node1=
.nr_mapped
>     503779 =C4=85 26%     -78.2%     109954 =C4=85 51%  numa-vmstat.node1=
.nr_shmem
>     500704 =C4=85 26%     -79.8%     101309 =C4=85 52%  numa-vmstat.node1=
.nr_zone_active_anon
>    3915420 =C4=85  5%     -16.3%    3276906 =C4=85  3%  numa-vmstat.node1=
.numa_hit
>    3830177 =C4=85  5%     -16.2%    3208097 =C4=85  4%  numa-vmstat.node1=
.numa_local
>    2431824           -65.5%     839190 =C4=85  4%  meminfo.Active
>    2357128           -67.3%     770208 =C4=85  4%  meminfo.Active(anon)
>      74695 =C4=85  3%      -7.6%      68981 =C4=85  2%  meminfo.Active(fi=
le)
>    5620559           -27.6%    4067556        meminfo.Cached
>    3838924           -40.4%    2286726        meminfo.Committed_AS
>      25660 =C4=85 19%     +25.8%      32289 =C4=85  5%  meminfo.Inactive(=
file)
>     141631 =C4=85  5%     -32.4%      95728 =C4=85  4%  meminfo.Mapped
>    8334057           -18.6%    6783406        meminfo.Memused
>    2390655           -64.9%     837973 =C4=85  4%  meminfo.Shmem
>    9824314           -15.2%    8328190        meminfo.max_used_kB
>       1893            -7.4%       1752        filebench.sum_bytes_mb/s
>   45921381            -7.4%   42512980        filebench.sum_operations
>     765287            -7.4%     708444        filebench.sum_operations/s
>     201392            -7.4%     186432        filebench.sum_reads/s
>       0.04          +263.5%       0.14        filebench.sum_time_ms/op
>      40278            -7.4%      37286        filebench.sum_writes/s
>   48591837            -7.4%   44996528        filebench.time.file_system_=
outputs
>       6443 =C4=85  3%     -88.7%     729.10 =C4=85  4%  filebench.time.in=
voluntary_context_switches
>       3556            +1.4%       3605        filebench.time.percent_of_c=
pu_this_job_got
>       5677            +2.1%       5798        filebench.time.system_time
>      99.20           -41.4%      58.09 =C4=85  2%  filebench.time.user_ti=
me
>   37526666           -74.5%    9587296 =C4=85  4%  filebench.time.volunta=
ry_context_switches
>     589410           -67.3%     192526 =C4=85  4%  proc-vmstat.nr_active_=
anon
>      18674 =C4=85  3%      -7.6%      17253 =C4=85  2%  proc-vmstat.nr_ac=
tive_file
>    6075100            -7.4%    5625692        proc-vmstat.nr_dirtied
>    3065571            +1.3%    3104313        proc-vmstat.nr_dirty_backgr=
ound_threshold
>    6138638            +1.3%    6216217        proc-vmstat.nr_dirty_thresh=
old
>    1407207           -27.6%    1019126        proc-vmstat.nr_file_pages
>   30829764            +1.3%   31217496        proc-vmstat.nr_free_pages
>     262267            +3.4%     271067        proc-vmstat.nr_inactive_ano=
n
>       6406 =C4=85 19%     +26.1%       8076 =C4=85  5%  proc-vmstat.nr_in=
active_file
>      35842 =C4=85  5%     -32.2%      24284 =C4=85  4%  proc-vmstat.nr_ma=
pped
>     597809           -65.0%     209518 =C4=85  4%  proc-vmstat.nr_shmem
>      32422            -3.3%      31365        proc-vmstat.nr_slab_reclaim=
able
>     589410           -67.3%     192526 =C4=85  4%  proc-vmstat.nr_zone_ac=
tive_anon
>      18674 =C4=85  3%      -7.6%      17253 =C4=85  2%  proc-vmstat.nr_zo=
ne_active_file
>     262267            +3.4%     271067        proc-vmstat.nr_zone_inactiv=
e_anon
>       6406 =C4=85 19%     +26.1%       8076 =C4=85  5%  proc-vmstat.nr_zo=
ne_inactive_file
>     100195 =C4=85 10%     -54.0%      46112 =C4=85 10%  proc-vmstat.numa_=
hint_faults
>      48654 =C4=85  9%     -50.1%      24286 =C4=85 13%  proc-vmstat.numa_=
hint_faults_local
>    7506558           -12.4%    6577262        proc-vmstat.numa_hit
>    7373151           -12.6%    6444638        proc-vmstat.numa_local
>     803560 =C4=85  4%      -6.4%     752097 =C4=85  5%  proc-vmstat.numa_=
pte_updates
>    4259084            -3.8%    4098506        proc-vmstat.pgactivate
>    7959837           -11.3%    7064279        proc-vmstat.pgalloc_normal
>     870736            -9.4%     789267        proc-vmstat.pgfault
>    7181295            -5.6%    6775640        proc-vmstat.pgfree
>       1.96 =C4=85  2%     -36.9%       1.23        perf-stat.i.MPKI
>  3.723e+09           +69.5%  6.309e+09        perf-stat.i.branch-instruct=
ions
>       2.70            -0.0        2.66        perf-stat.i.branch-miss-rat=
e%
>   16048312           -38.4%    9889213        perf-stat.i.branch-misses
>      16.44            -2.0       14.42        perf-stat.i.cache-miss-rate=
%
>   43146188           -47.3%   22744395 =C4=85  2%  perf-stat.i.cache-miss=
es
>  1.141e+08           -39.8%   68732731        perf-stat.i.cache-reference=
s
>     465903           -75.4%     114745 =C4=85  4%  perf-stat.i.context-sw=
itches
>       4.11           -36.6%       2.61        perf-stat.i.cpi
>   1.22e+11            -5.2%  1.157e+11        perf-stat.i.cpu-cycles
>     236.15           -18.3%     192.90        perf-stat.i.cpu-migrations
>       1997 =C4=85  2%     +40.1%       2798        perf-stat.i.cycles-bet=
ween-cache-misses
>  1.644e+10           +90.3%   3.13e+10        perf-stat.i.instructions
>       0.38           +14.7%       0.43        perf-stat.i.ipc
>       3.63           -75.7%       0.88 =C4=85  4%  perf-stat.i.metric.K/s=
ec
>       4592 =C4=85  2%     -11.6%       4057        perf-stat.i.minor-faul=
ts
>       4592 =C4=85  2%     -11.6%       4057        perf-stat.i.page-fault=
s
>       2.62           -72.3%       0.73 =C4=85  2%  perf-stat.overall.MPKI
>       0.43            -0.3        0.16        perf-stat.overall.branch-mi=
ss-rate%
>      37.79            -4.6       33.22        perf-stat.overall.cache-mis=
s-rate%
>       7.41           -50.1%       3.70        perf-stat.overall.cpi
>       2827           +80.1%       5092 =C4=85  2%  perf-stat.overall.cycl=
es-between-cache-misses
>       0.13          +100.5%       0.27        perf-stat.overall.ipc
>  3.693e+09           +77.2%  6.544e+09        perf-stat.ps.branch-instruc=
tions
>   15913729           -36.1%   10173711        perf-stat.ps.branch-misses
>   42783592           -44.9%   23577137 =C4=85  2%  perf-stat.ps.cache-mis=
ses
>  1.132e+08           -37.3%   70963587        perf-stat.ps.cache-referenc=
es
>     461953           -74.2%     118964 =C4=85  4%  perf-stat.ps.context-s=
witches
>     234.44           -17.3%     193.77        perf-stat.ps.cpu-migrations
>  1.632e+10           +99.0%  3.246e+10        perf-stat.ps.instructions
>       4555 =C4=85  2%     -10.9%       4060        perf-stat.ps.minor-fau=
lts
>       4555 =C4=85  2%     -10.9%       4060        perf-stat.ps.page-faul=
ts
>  2.659e+12           +99.2%  5.299e+12        perf-stat.total.instruction=
s
>
>
>
> [1]
>
> for patch in
> https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/
>
> we apply it upon
>   3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tj/wq")
>
> there is similar regression
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase=
:
>   gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.=
cgz/lkp-icl-2sp6/webproxy.f/filebench
>
> commit:
>   3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tj/wq")
>   3681ce3644 ("vfs: Delete the associated dentry when deleting a file")
>
> 3c999d1ae3c75991 3681ce364442ce2ec7c7fbe90ad
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      31.06            +2.8%      31.94        boot-time.boot
>   30573542 =C4=85  2%     -77.0%    7043084 =C4=85  5%  cpuidle..usage
>      27.25            +1.3%      27.61        iostat.cpu.system
>       0.14            -0.0        0.12        mpstat.cpu.all.irq%
>       0.07            -0.0        0.04        mpstat.cpu.all.soft%
>       0.56            -0.2        0.34 =C4=85  2%  mpstat.cpu.all.usr%
>       0.29 =C4=85100%     -77.4%       0.07 =C4=85 28%  vmstat.procs.b
>     448491 =C4=85  2%     -76.3%     106251 =C4=85  5%  vmstat.system.cs
>      90174           -36.5%      57279        vmstat.system.in
>    3460368 =C4=85  4%     -10.3%    3103696 =C4=85  4%  numa-numastat.nod=
e0.local_node
>    3522472 =C4=85  4%      -9.2%    3197492 =C4=85  3%  numa-numastat.nod=
e0.numa_hit
>    3928489 =C4=85  4%     -17.7%    3232163 =C4=85  3%  numa-numastat.nod=
e1.local_node
>    3998985 =C4=85  3%     -18.2%    3270980 =C4=85  3%  numa-numastat.nod=
e1.numa_hit
>       1968 =C4=85  5%     -23.2%       1511        perf-c2c.DRAM.local
>      16452 =C4=85 22%     -54.2%       7541 =C4=85  4%  perf-c2c.DRAM.rem=
ote
>      14780 =C4=85 26%     -64.0%       5321 =C4=85  4%  perf-c2c.HITM.loc=
al
>      10689 =C4=85 24%     -60.1%       4262 =C4=85  5%  perf-c2c.HITM.rem=
ote
>      25469 =C4=85 25%     -62.4%       9584 =C4=85  4%  perf-c2c.HITM.tot=
al
>     196899 =C4=85 10%     +31.1%     258125 =C4=85 11%  sched_debug.cfs_r=
q:/.avg_vruntime.stddev
>     196899 =C4=85 10%     +31.1%     258125 =C4=85 11%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>     299051 =C4=85 12%     -76.0%      71664 =C4=85 15%  sched_debug.cpu.n=
r_switches.avg
>     355466 =C4=85 11%     -73.4%      94490 =C4=85 14%  sched_debug.cpu.n=
r_switches.max
>     219349 =C4=85 12%     -76.6%      51435 =C4=85 12%  sched_debug.cpu.n=
r_switches.min
>      25523 =C4=85 11%     -67.4%       8322 =C4=85 18%  sched_debug.cpu.n=
r_switches.stddev
>      36526 =C4=85  4%     -16.4%      30519 =C4=85  6%  numa-meminfo.node=
0.Active(file)
>     897165 =C4=85 14%     -26.7%     657740 =C4=85  9%  numa-meminfo.node=
0.AnonPages.max
>      23571 =C4=85 10%     -14.5%      20159 =C4=85 10%  numa-meminfo.node=
0.Dirty
>    2134726 =C4=85 10%     -76.9%     493176 =C4=85 35%  numa-meminfo.node=
1.Active
>    2096208 =C4=85 11%     -78.3%     455673 =C4=85 38%  numa-meminfo.node=
1.Active(anon)
>     965352 =C4=85 13%     +23.5%    1192437 =C4=85  2%  numa-meminfo.node=
1.AnonPages.max
>      18386 =C4=85 17%     +23.8%      22761 =C4=85  4%  numa-meminfo.node=
1.Inactive(file)
>    2108104 =C4=85 11%     -76.7%     492042 =C4=85 37%  numa-meminfo.node=
1.Shmem
>    2395006 =C4=85  2%     -67.4%     779863 =C4=85  3%  meminfo.Active
>    2319964 =C4=85  2%     -69.3%     711848 =C4=85  4%  meminfo.Active(an=
on)
>      75041 =C4=85  2%      -9.4%      68015 =C4=85  2%  meminfo.Active(fi=
le)
>    5583921           -28.3%    4002297        meminfo.Cached
>    3802632           -41.5%    2224370        meminfo.Committed_AS
>      28940 =C4=85  5%     +13.6%      32890 =C4=85  4%  meminfo.Inactive(=
file)
>     134576 =C4=85  6%     -31.2%      92641 =C4=85  3%  meminfo.Mapped
>    8310087           -19.2%    6718172        meminfo.Memused
>    2354275 =C4=85  2%     -67.1%     775732 =C4=85  4%  meminfo.Shmem
>    9807659           -15.7%    8271698        meminfo.max_used_kB
>       1903            -9.3%       1725        filebench.sum_bytes_mb/s
>   46168615            -9.4%   41846487        filebench.sum_operations
>     769403            -9.4%     697355        filebench.sum_operations/s
>     202475            -9.4%     183514        filebench.sum_reads/s
>       0.04          +268.3%       0.14        filebench.sum_time_ms/op
>      40495            -9.4%      36703        filebench.sum_writes/s
>   48846906            -9.3%   44298468        filebench.time.file_system_=
outputs
>       6633           -89.4%     701.33 =C4=85  6%  filebench.time.involun=
tary_context_switches
>       3561            +1.3%       3607        filebench.time.percent_of_c=
pu_this_job_got
>       5686            +2.1%       5804        filebench.time.system_time
>      98.62           -44.2%      55.04 =C4=85  2%  filebench.time.user_ti=
me
>   36939924 =C4=85  2%     -76.6%    8653175 =C4=85  5%  filebench.time.vo=
luntary_context_switches
>       9134 =C4=85  4%     -16.5%       7628 =C4=85  6%  numa-vmstat.node0=
.nr_active_file
>    3141362 =C4=85  3%     -11.5%    2780445 =C4=85  4%  numa-vmstat.node0=
.nr_dirtied
>       9134 =C4=85  4%     -16.5%       7628 =C4=85  6%  numa-vmstat.node0=
.nr_zone_active_file
>    3522377 =C4=85  4%      -9.2%    3197360 =C4=85  3%  numa-vmstat.node0=
.numa_hit
>    3460272 =C4=85  4%     -10.3%    3103565 =C4=85  4%  numa-vmstat.node0=
.numa_local
>     524285 =C4=85 11%     -78.3%     113936 =C4=85 38%  numa-vmstat.node1=
.nr_active_anon
>       4630 =C4=85 17%     +22.6%       5674 =C4=85  4%  numa-vmstat.node1=
.nr_inactive_file
>     527242 =C4=85 11%     -76.7%     123018 =C4=85 37%  numa-vmstat.node1=
.nr_shmem
>     524285 =C4=85 11%     -78.3%     113936 =C4=85 38%  numa-vmstat.node1=
.nr_zone_active_anon
>       4630 =C4=85 17%     +22.5%       5674 =C4=85  4%  numa-vmstat.node1=
.nr_zone_inactive_file
>    3998675 =C4=85  3%     -18.2%    3270307 =C4=85  3%  numa-vmstat.node1=
.numa_hit
>    3928179 =C4=85  4%     -17.7%    3231491 =C4=85  3%  numa-vmstat.node1=
.numa_local
>       1.82 =C4=85 18%      -0.5        1.28 =C4=85 16%  perf-profile.call=
trace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscal=
l_64
>       1.58 =C4=85  8%      -0.5        1.13 =C4=85 18%  perf-profile.call=
trace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e
>       1.53 =C4=85  9%      -0.4        1.13 =C4=85 18%  perf-profile.call=
trace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       2.05 =C4=85  7%      -0.3        1.76 =C4=85 11%  perf-profile.call=
trace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balan=
ce_rq.sched_balance_newidle.balance_fair
>       3.80 =C4=85  5%      -0.3        3.52 =C4=85  5%  perf-profile.call=
trace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       2.11 =C4=85 11%      +0.3        2.39 =C4=85  4%  perf-profile.call=
trace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.p=
rocess_interval.dispatch_events
>       3.55 =C4=85 10%      +0.3        3.86 =C4=85  4%  perf-profile.call=
trace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       2.63 =C4=85  9%      +0.4        3.03 =C4=85  6%  perf-profile.call=
trace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.di=
spatch_events.cmd_stat
>       3.47 =C4=85  2%      -0.6        2.86 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.vm_mmap_pgoff
>       3.30 =C4=85  2%      -0.6        2.73 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.do_mmap
>       3.02 =C4=85  6%      -0.6        2.46 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.mmap_region
>       2.34 =C4=85  8%      -0.6        1.80 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.ksys_mmap_pgoff
>       3.80 =C4=85  5%      -0.3        3.52 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.acpi_evaluate_dsm
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.acpi_evaluate_object
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.acpi_nfit_ctl
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.acpi_nfit_query_poison
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.acpi_nfit_scrub
>       0.16 =C4=85 36%      -0.1        0.05 =C4=85 44%  perf-profile.chil=
dren.cycles-pp._find_first_bit
>       0.10 =C4=85 44%      -0.1        0.03 =C4=85100%  perf-profile.chil=
dren.cycles-pp.mtree_load
>       0.30 =C4=85 25%      +0.2        0.47 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.__update_blocked_fair
>       0.23 =C4=85 55%      -0.2        0.08 =C4=85 70%  perf-profile.self=
.cycles-pp.malloc
>       0.16 =C4=85 40%      -0.1        0.05 =C4=85 44%  perf-profile.self=
.cycles-pp._find_first_bit
>       0.19 =C4=85 30%      -0.1        0.09 =C4=85 84%  perf-profile.self=
.cycles-pp.d_alloc_parallel
>       0.86 =C4=85 17%      +0.3        1.12 =C4=85 10%  perf-profile.self=
.cycles-pp.menu_select
>     580113 =C4=85  2%     -69.3%     177978 =C4=85  4%  proc-vmstat.nr_ac=
tive_anon
>      18761 =C4=85  2%      -9.3%      17008 =C4=85  2%  proc-vmstat.nr_ac=
tive_file
>    6107024            -9.3%    5538417        proc-vmstat.nr_dirtied
>    3066271            +1.3%    3105966        proc-vmstat.nr_dirty_backgr=
ound_threshold
>    6140041            +1.3%    6219526        proc-vmstat.nr_dirty_thresh=
old
>    1398313           -28.3%    1002802        proc-vmstat.nr_file_pages
>   30835864            +1.3%   31234154        proc-vmstat.nr_free_pages
>     262597            +2.8%     269986        proc-vmstat.nr_inactive_ano=
n
>       7233 =C4=85  5%     +13.4%       8201 =C4=85  4%  proc-vmstat.nr_in=
active_file
>      34066 =C4=85  6%     -31.1%      23487 =C4=85  3%  proc-vmstat.nr_ma=
pped
>     588705 =C4=85  2%     -67.0%     193984 =C4=85  4%  proc-vmstat.nr_sh=
mem
>      32476            -3.6%      31292        proc-vmstat.nr_slab_reclaim=
able
>     580113 =C4=85  2%     -69.3%     177978 =C4=85  4%  proc-vmstat.nr_zo=
ne_active_anon
>      18761 =C4=85  2%      -9.3%      17008 =C4=85  2%  proc-vmstat.nr_zo=
ne_active_file
>     262597            +2.8%     269986        proc-vmstat.nr_zone_inactiv=
e_anon
>       7233 =C4=85  5%     +13.4%       8201 =C4=85  4%  proc-vmstat.nr_zo=
ne_inactive_file
>     148417 =C4=85 19%     -82.3%      26235 =C4=85 17%  proc-vmstat.numa_=
hint_faults
>      76831 =C4=85 23%     -84.5%      11912 =C4=85 33%  proc-vmstat.numa_=
hint_faults_local
>    7524741           -14.0%    6471471        proc-vmstat.numa_hit
>    7392150           -14.2%    6338859        proc-vmstat.numa_local
>     826291 =C4=85  4%     -12.3%     724471 =C4=85  4%  proc-vmstat.numa_=
pte_updates
>    4284054            -6.1%    4024194        proc-vmstat.pgactivate
>    7979760           -12.9%    6948927        proc-vmstat.pgalloc_normal
>     917223 =C4=85  2%     -16.2%     768255        proc-vmstat.pgfault
>    7212208            -7.4%    6679624        proc-vmstat.pgfree
>       1.97           -39.5%       1.19 =C4=85  2%  perf-stat.i.MPKI
>  3.749e+09           +65.2%  6.195e+09        perf-stat.i.branch-instruct=
ions
>       2.69            -0.0        2.65        perf-stat.i.branch-miss-rat=
e%
>   15906654           -39.7%    9595633        perf-stat.i.branch-misses
>      16.53            -2.2       14.37        perf-stat.i.cache-miss-rate=
%
>   43138175           -48.8%   22080984 =C4=85  2%  perf-stat.i.cache-miss=
es
>  1.137e+08           -41.1%   67035007 =C4=85  2%  perf-stat.i.cache-refe=
rences
>     458704 =C4=85  2%     -77.4%     103593 =C4=85  6%  perf-stat.i.conte=
xt-switches
>       4.04           -39.3%       2.45        perf-stat.i.cpi
>  1.221e+11            -5.4%  1.155e+11        perf-stat.i.cpu-cycles
>     238.75           -19.5%     192.29        perf-stat.i.cpu-migrations
>       1960           +45.0%       2843 =C4=85  2%  perf-stat.i.cycles-bet=
ween-cache-misses
>  1.678e+10          +103.7%  3.419e+10        perf-stat.i.instructions
>       0.39           +17.5%       0.46        perf-stat.i.ipc
>       3.58 =C4=85  2%     -77.8%       0.80 =C4=85  6%  perf-stat.i.metri=
c.K/sec
>       4918 =C4=85  3%     -19.9%       3940        perf-stat.i.minor-faul=
ts
>       4918 =C4=85  3%     -19.9%       3940        perf-stat.i.page-fault=
s
>       2.57           -74.9%       0.65 =C4=85  2%  perf-stat.overall.MPKI
>       0.42            -0.3        0.15        perf-stat.overall.branch-mi=
ss-rate%
>      37.92            -4.8       33.07        perf-stat.overall.cache-mis=
s-rate%
>       7.27           -53.5%       3.38        perf-stat.overall.cpi
>       2830           +85.1%       5239 =C4=85  2%  perf-stat.overall.cycl=
es-between-cache-misses
>       0.14          +115.0%       0.30        perf-stat.overall.ipc
>   3.72e+09           +72.8%  6.428e+09        perf-stat.ps.branch-instruc=
tions
>   15775403           -37.5%    9854215        perf-stat.ps.branch-misses
>   42773264           -46.5%   22897139 =C4=85  2%  perf-stat.ps.cache-mis=
ses
>  1.128e+08           -38.6%   69221969 =C4=85  2%  perf-stat.ps.cache-ref=
erences
>     454754 =C4=85  2%     -76.4%     107434 =C4=85  6%  perf-stat.ps.cont=
ext-switches
>     237.02           -18.5%     193.17        perf-stat.ps.cpu-migrations
>  1.666e+10          +113.0%  3.548e+10        perf-stat.ps.instructions
>       4878 =C4=85  3%     -19.3%       3937        perf-stat.ps.minor-fau=
lts
>       4878 =C4=85  3%     -19.3%       3937        perf-stat.ps.page-faul=
ts
>  2.715e+12          +113.5%  5.796e+12        perf-stat.total.instruction=
s
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Thanks for your report. I will try to reproduce it on my test machine.

--=20
Regards
Yafang

