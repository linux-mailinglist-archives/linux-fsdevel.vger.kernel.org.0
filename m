Return-Path: <linux-fsdevel+bounces-16660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2138A0C3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFE51F23175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693D1448F3;
	Thu, 11 Apr 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrEq+lcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E951448C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827430; cv=none; b=erBxsJBGVVQcj9A3O3aol2EeNIsDZrYPFxQjX28ey7z6e/tmRk74VwY4Drone+Q2ChVONGRRXGwMcuxK+DVeQgliv/8VRbl7YIujLMDeihP95TzPmuqCLCcPlqFUs/kCiuPFPRPafeDRzWEwAdXC7b5MtSP8CxczfC+Jt7xyTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827430; c=relaxed/simple;
	bh=ABgpdJshPnwfKKx2N15otCwtrzRDowhePeht/AbaOzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7iIk+qcSI0DG9USqwlbJRgNsbMSbObzdj967pY9pLeVODTf5C01XI7Jk6n5sz2X/OsVO9+3U0RYpO4FjxixcJL4BnTJGrvPSdWd+A+CEPcpvPAPfgQIXzBkUlz8N+pzUrrvpcAB9y31P+depo82HqlRc6V9cIRFVxV3FY2th6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrEq+lcW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b3d05e945so7533076d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712827426; x=1713432226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AJx8PWcQhKwOqvkurlKKux4I6JV2Y1LnKqjekyOL0w=;
        b=RrEq+lcW8mdHXKMBma+exlYJN0OPe8rc9EwYlj+lUudiozoUXzW+qvQ91jGTKj8xQ/
         oAFJ1rN9Oh+8y9ldbyNAzo/sRsGhG5cXb2nPwNvqtilCCmvthscgO/ZIveOC/slrOAkF
         srdEGU+inEv8vvyEll1jh797lYNR4wizr2W5E8LuAdc030AFVqZdoqvp2md/tb4Xc2Oz
         1sOpJeqxasgx8lZUVMYP7Xct+c+NkzohmC1n8niRzMaNsfBCbRdRnkyUuwNOkkRZuCEU
         DgCYBIRb5X1Fyj44qnRDkgR4QMpsY+amn/LMGsNBzllqzINJeQMElg8uRDYJZ1vVYdyM
         Cklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712827426; x=1713432226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AJx8PWcQhKwOqvkurlKKux4I6JV2Y1LnKqjekyOL0w=;
        b=KXyut6MI/+zOMC9d5PikXsHsWuvhe9cAsYqP0REwE4Irt2/9uccXwTvpw63IQ8NBoB
         BD+B+71X1GfqdYM+vungeGVlTCNkWNEkUOejFx9SsavB5e+JBq4iA7C4dDoXI/pg5PVO
         Ew9f2TqMCbiVa+yhMfxGfswVN3WeYl8FVDeOYfZYzGtli5nPQvIHYjIDmuNHamBfZgsD
         JDInRVctrpSpfVCyZHpsnX63gWK+ZUKmq2gNm0zi86I2ClJlsRxYefazKgeBgSXeiCBV
         Hr+mlmURQLUux4SRCYxQLraZPft9l4cKApn3pmU9+pr/9QlxxOPBS7LycYBOOFvdjkj2
         ZEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJEA9T8O506PGAUq3W5YvwrZDONogRIO1W7JOigBB9VjSv2SokK/KfpJnZy5e4iHBCJRqSbbcEmrZ2IE7dmvRChqNyOiBNk0+JTZxw3g==
X-Gm-Message-State: AOJu0Yx+KRZb8ix2diodtBJoEWR2W9xIc63/AEpC0hgfUEJrlNefIYes
	vZ8orAwVZxHfAiWSw3tfW+a2nCu5DgZ0eEGMbRJFZOYowac0As/Mq/xneey1m0ks3TmaqYZ98vj
	BkY6RnCTKwqMCFAxY4+YclhkqTNQ=
X-Google-Smtp-Source: AGHT+IEpHc7JjTX8KXsNXhyZG1qjEe9lOnxPVyT8DA1IwXRLl/K/mvc/dGwplD+FuTdTfnEkoBOlIywGIHu4Q0MEqXI=
X-Received: by 2002:a05:6214:301c:b0:69b:229e:91f6 with SMTP id
 ke28-20020a056214301c00b0069b229e91f6mr4525988qvb.52.1712827425833; Thu, 11
 Apr 2024 02:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404101624.85684be8-oliver.sang@intel.com>
In-Reply-To: <202404101624.85684be8-oliver.sang@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Apr 2024 12:23:34 +0300
Message-ID: <CAOQ4uxgFAPMsD03cyez+6rMjRsX=aTo_+d2kuGG9eUwwa6P-zA@mail.gmail.com>
Subject: Re: [linux-next:master] [fsnotify] a5e57b4d37: stress-ng.full.ops_per_sec
 -17.3% regression
To: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:42=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, Amir,
>
> for "[amir73il:fsnotify-sbconn] [fsnotify]  629f30e073: unixbench.through=
put 5.8% improvement"
> (https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.com/=
)
> you requested us to test unixbench for this commit on different branches =
and we
> observed consistent performance improvement.
>
> now we noticed this commit is merged into linux-next/master, we still obs=
erved
> similar unixbench improvement, however, we also captured a stress-ng regr=
ession
> now. below details FYI.
>
>
>
> Hello,
>
> kernel test robot noticed a -17.3% regression of stress-ng.full.ops_per_s=
ec on:
>
>
> commit: a5e57b4d370c6d320e5bfb0c919fe00aee29e039 ("fsnotify: optimize the=
 case of no permission event watchers")

Odd. This commit does add an extra fsnotify_sb_has_priority_watchers()
inline check for reads and writes, but the inline helper
fsnotify_sb_has_watchers()
already exists in fsnotify_parent() and it already accesses fsnotify_sb_inf=
o.

It seems like stress-ng.full does read/write/mmap operations on /dev/full,
so the fsnotify_sb_info object would be that of devtmpfs.

I think that the permission events on special files are not very relevant,
but I am not sure.

Jan, any ideas?

Thanks,
Amir.



> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>         nr_threads: 100%
>         testtime: 60s
>         test: full
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
--------------------------------------------+
> | testcase: change | unixbench: unixbench.throughput 6.4% improvement    =
                                            |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CP=
U @ 3.00GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                              |
> |                  | nr_task=3D1                                         =
                                              |
> |                  | runtime=3D300s                                      =
                                              |
> |                  | test=3Dfsbuffer-r                                   =
                                              |
> +------------------+-----------------------------------------------------=
--------------------------------------------+
> | testcase: change | unixbench: unixbench.throughput 5.8% improvement    =
                                            |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CP=
U @ 3.00GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                              |
> |                  | nr_task=3D1                                         =
                                              |
> |                  | runtime=3D300s                                      =
                                              |
> |                  | test=3Dfstime-r                                     =
                                              |
> +------------------+-----------------------------------------------------=
--------------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404101624.85684be8-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240410/202404101624.85684be8-ol=
iver.sang@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp8/full/stress-ng/60s
>
> commit:
>   477cf917dd ("fsnotify: use an enum for group priority constants")
>   a5e57b4d37 ("fsnotify: optimize the case of no permission event watcher=
s")
>
> 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      20489 =C4=85  7%     -19.2%      16565 =C4=85 13%  perf-c2c.HITM.rem=
ote
>     409.48 =C4=85  9%     -14.0%     352.13 =C4=85  5%  sched_debug.cfs_r=
q:/.util_est.avg
>     217.94 =C4=85  8%     +12.9%     246.07 =C4=85  4%  sched_debug.cfs_r=
q:/.util_est.stddev
>  1.461e+08 =C4=85  3%     -17.3%  1.208e+08 =C4=85  5%  stress-ng.full.op=
s
>    2434462 =C4=85  3%     -17.3%    2013444 =C4=85  5%  stress-ng.full.op=
s_per_sec
>      71.04 =C4=85  3%     -16.6%      59.28 =C4=85  6%  stress-ng.time.us=
er_time
>   9.95e+09 =C4=85  4%     -13.4%  8.617e+09 =C4=85  3%  perf-stat.i.branc=
h-instructions
>       0.48 =C4=85  3%      +0.1        0.55 =C4=85  2%  perf-stat.i.branc=
h-miss-rate%
>       4.36 =C4=85  4%     +17.1%       5.10 =C4=85  3%  perf-stat.i.cpi
>  5.162e+10 =C4=85  4%     -14.5%  4.416e+10 =C4=85  3%  perf-stat.i.instr=
uctions
>       0.24 =C4=85  3%     -13.8%       0.21 =C4=85  3%  perf-stat.i.ipc
>       0.46 =C4=85  3%      +0.1        0.54 =C4=85  2%  perf-stat.overall=
.branch-miss-rate%
>       4.38 =C4=85  4%     +16.9%       5.12 =C4=85  3%  perf-stat.overall=
.cpi
>       0.23 =C4=85  4%     -14.5%       0.20 =C4=85  3%  perf-stat.overall=
.ipc
>  9.781e+09 =C4=85  4%     -13.4%  8.471e+09 =C4=85  3%  perf-stat.ps.bran=
ch-instructions
>  5.075e+10 =C4=85  4%     -14.5%  4.341e+10 =C4=85  3%  perf-stat.ps.inst=
ructions
>  3.111e+12 =C4=85  4%     -14.5%   2.66e+12 =C4=85  3%  perf-stat.total.i=
nstructions
>       8.39 =C4=85  7%      -2.8        5.56 =C4=85  4%  perf-profile.call=
trace.cycles-pp.__mmap
>       8.09 =C4=85  7%      -2.8        5.31 =C4=85  4%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       8.05 =C4=85  7%      -2.8        5.28 =C4=85  4%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       7.95 =C4=85  7%      -2.8        5.19 =C4=85  4%  perf-profile.call=
trace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__mmap
>       6.80 =C4=85  8%      -2.7        4.14 =C4=85  4%  perf-profile.call=
trace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_fi=
lp_open
>       7.46 =C4=85  8%      -2.7        4.80 =C4=85  4%  perf-profile.call=
trace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.__mmap
>       6.78 =C4=85  8%      -2.7        4.13 =C4=85  4%  perf-profile.call=
trace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_ope=
n.path_openat
>       4.12 =C4=85 14%      -2.0        2.09 =C4=85 10%  perf-profile.call=
trace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>       3.54 =C4=85 14%      -1.7        1.81 =C4=85 10%  perf-profile.call=
trace.cycles-pp.apparmor_mmap_file.security_mmap_file.vm_mmap_pgoff.ksys_mm=
ap_pgoff.do_syscall_64
>       3.46 =C4=85  8%      -1.5        1.99 =C4=85  6%  perf-profile.call=
trace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__=
x64_sys_openat
>       3.15 =C4=85  8%      -1.4        1.71 =C4=85  7%  perf-profile.call=
trace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_=
openat2
>       3.06 =C4=85  9%      -1.4        1.63 =C4=85  7%  perf-profile.call=
trace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.=
do_filp_open
>       2.95 =C4=85  9%      -1.4        1.54 =C4=85  8%  perf-profile.call=
trace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.=
alloc_empty_file.path_openat
>       5.50 =C4=85  7%      -1.1        4.39 =C4=85  5%  perf-profile.call=
trace.cycles-pp.fstatat64
>       5.34 =C4=85  7%      -1.1        4.26 =C4=85  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
>       5.32 =C4=85  7%      -1.1        4.24 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
>       5.27 =C4=85  8%      -1.1        4.20 =C4=85  6%  perf-profile.call=
trace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.fstatat64
>       4.95 =C4=85  8%      -1.0        3.91 =C4=85  7%  perf-profile.call=
trace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.fstatat64
>       4.78 =C4=85  8%      -1.0        3.77 =C4=85  7%  perf-profile.call=
trace.cycles-pp.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
>       4.75 =C4=85  9%      -1.0        3.74 =C4=85  7%  perf-profile.call=
trace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_fstat.__do_sys_=
newfstatat.do_syscall_64
>       1.74 =C4=85 12%      -0.9        0.83 =C4=85 11%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_read.__x64_sys_pread64
>       1.75 =C4=85 12%      -0.9        0.84 =C4=85 11%  perf-profile.call=
trace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.__x64_sys_=
pread64.do_syscall_64
>       2.08 =C4=85 13%      -0.9        1.17 =C4=85  9%  perf-profile.call=
trace.cycles-pp.write
>       1.78 =C4=85 13%      -0.9        0.88 =C4=85 13%  perf-profile.call=
trace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do=
_sys_openat2
>       1.77 =C4=85 13%      -0.9        0.87 =C4=85 13%  perf-profile.call=
trace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.=
do_filp_open
>       1.68 =C4=85 15%      -0.9        0.80 =C4=85 13%  perf-profile.call=
trace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.=
do_syscall_64
>       1.68 =C4=85 15%      -0.9        0.80 =C4=85 13%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_read.ksys_read
>       1.68 =C4=85 14%      -0.9        0.80 =C4=85 14%  perf-profile.call=
trace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_su=
bj.ima_file_check.security_file_post_open.do_open
>       1.68 =C4=85 14%      -0.9        0.81 =C4=85 14%  perf-profile.call=
trace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file=
_post_open.do_open.path_openat
>       1.90 =C4=85 14%      -0.9        1.02 =C4=85 10%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       1.88 =C4=85 14%      -0.9        1.00 =C4=85 11%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.82 =C4=85 15%      -0.9        0.96 =C4=85 11%  perf-profile.call=
trace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>       1.77 =C4=85 15%      -0.8        0.92 =C4=85 11%  perf-profile.call=
trace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.write
>       1.74 =C4=85 15%      -0.8        0.90 =C4=85 12%  perf-profile.call=
trace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
>       1.72 =C4=85 15%      -0.8        0.87 =C4=85 12%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_write.ksys_write
>       1.73 =C4=85 15%      -0.8        0.89 =C4=85 12%  perf-profile.call=
trace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_writ=
e.do_syscall_64
>       1.32 =C4=85  5%      -0.5        0.80 =C4=85  5%  perf-profile.call=
trace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
>       1.31 =C4=85  5%      -0.5        0.80 =C4=85  5%  perf-profile.call=
trace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64=
_sys_close.do_syscall_64
>       2.72 =C4=85  2%      -0.5        2.24 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       0.68 =C4=85  9%      -0.4        0.26 =C4=85100%  perf-profile.call=
trace.cycles-pp.kobject_put.cdev_put.__fput.__x64_sys_close.do_syscall_64
>       2.48 =C4=85  2%      -0.4        2.07 =C4=85  5%  perf-profile.call=
trace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_=
syscall_64
>       2.39 =C4=85  2%      -0.4        1.99 =C4=85  6%  perf-profile.call=
trace.cycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm=
_mmap_pgoff.ksys_mmap_pgoff
>       2.22 =C4=85  2%      -0.4        1.84 =C4=85  5%  perf-profile.call=
trace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmappe=
d_area.do_mmap.vm_mmap_pgoff
>       1.54 =C4=85  2%      -0.3        1.27 =C4=85  6%  perf-profile.call=
trace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_=
topdown.get_unmapped_area.do_mmap
>       0.91 =C4=85  8%      -0.2        0.66 =C4=85  6%  perf-profile.call=
trace.cycles-pp.cdev_put.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL=
_64_after_hwframe
>       1.17 =C4=85  3%      -0.2        0.96 =C4=85  6%  perf-profile.call=
trace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_=
unmapped_area_topdown.get_unmapped_area
>       0.64 =C4=85  2%      -0.1        0.57 =C4=85  4%  perf-profile.call=
trace.cycles-pp.ioctl
>       2.80 =C4=85  7%      +1.7        4.48 =C4=85  6%  perf-profile.call=
trace.cycles-pp.__libc_pread
>       2.65 =C4=85  7%      +1.7        4.35 =C4=85  7%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pread
>       2.63 =C4=85  7%      +1.7        4.33 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
>       2.58 =C4=85  7%      +1.7        4.29 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.__libc_pread
>       2.79 =C4=85  8%      +1.7        4.50 =C4=85  7%  perf-profile.call=
trace.cycles-pp.read
>       2.53 =C4=85  8%      +1.7        4.25 =C4=85  7%  perf-profile.call=
trace.cycles-pp.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.__libc_pread
>       2.64 =C4=85  9%      +1.7        4.37 =C4=85  8%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>       2.62 =C4=85  9%      +1.7        4.35 =C4=85  8%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       2.57 =C4=85  9%      +1.7        4.31 =C4=85  8%  perf-profile.call=
trace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       2.52 =C4=85 10%      +1.7        4.27 =C4=85  8%  perf-profile.call=
trace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.read
>       1.77 =C4=85 12%      +1.9        3.64 =C4=85  8%  perf-profile.call=
trace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
>       1.71 =C4=85 15%      +1.9        3.64 =C4=85  9%  perf-profile.call=
trace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
>       0.00            +2.8        2.79 =C4=85  5%  perf-profile.calltrace=
.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_op=
en
>       8.50 =C4=85  7%      -2.8        5.66 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__mmap
>       7.96 =C4=85  7%      -2.8        5.20 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ksys_mmap_pgoff
>       6.81 =C4=85  8%      -2.7        4.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.security_file_open
>       6.79 =C4=85  8%      -2.7        4.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.apparmor_file_open
>       7.48 =C4=85  7%      -2.7        4.83 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.vm_mmap_pgoff
>       5.14 =C4=85 14%      -2.6        2.51 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.apparmor_file_permission
>       5.18 =C4=85 14%      -2.6        2.54 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.security_file_permission
>       4.13 =C4=85 14%      -2.0        2.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.security_mmap_file
>       3.55 =C4=85 14%      -1.7        1.81 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.apparmor_mmap_file
>       3.47 =C4=85  8%      -1.5        2.00 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.alloc_empty_file
>       3.15 =C4=85  8%      -1.4        1.72 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.init_file
>       3.06 =C4=85  9%      -1.4        1.64 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.security_file_alloc
>       2.95 =C4=85  9%      -1.4        1.55 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.apparmor_file_alloc_security
>       2.18 =C4=85 16%      -1.2        1.02 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.security_current_getsecid_subj
>       2.16 =C4=85 16%      -1.2        1.00 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.apparmor_current_getsecid_subj
>       5.55 =C4=85  7%      -1.1        4.44 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.fstatat64
>       5.27 =C4=85  8%      -1.1        4.20 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__do_sys_newfstatat
>       4.96 =C4=85  8%      -1.0        3.92 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vfs_fstat
>       4.78 =C4=85  8%      -1.0        3.77 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.security_inode_getattr
>       4.75 =C4=85  9%      -1.0        3.74 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.common_perm_cond
>       2.16 =C4=85 12%      -0.9        1.25 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.write
>       1.78 =C4=85 13%      -0.9        0.88 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.security_file_post_open
>       1.77 =C4=85 13%      -0.9        0.87 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.ima_file_check
>       1.86 =C4=85 14%      -0.9        1.00 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.ksys_write
>       1.81 =C4=85 15%      -0.8        0.96 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.vfs_write
>       1.32 =C4=85  5%      -0.5        0.80 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.security_file_free
>       1.31 =C4=85  5%      -0.5        0.80 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.apparmor_file_free_security
>       2.73 =C4=85  2%      -0.5        2.25 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_mmap
>       2.50 =C4=85  2%      -0.4        2.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.get_unmapped_area
>       2.41 =C4=85  2%      -0.4        2.01 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.arch_get_unmapped_area_topdown
>       2.24 =C4=85  2%      -0.4        1.86 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.vm_unmapped_area
>       0.52 =C4=85 23%      -0.3        0.23 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.ima_file_mmap
>       1.58 =C4=85  2%      -0.3        1.31 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_empty_area_rev
>       0.91 =C4=85  7%      -0.2        0.67 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.cdev_put
>       0.44 =C4=85  3%      -0.2        0.22 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__fsnotify_parent
>       1.21 =C4=85  3%      -0.2        0.99 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_rev_awalk
>       0.69 =C4=85  9%      -0.2        0.50 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.kobject_put
>       1.13 =C4=85  3%      -0.2        0.96 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.read_iter_zero
>       1.09 =C4=85  3%      -0.2        0.93 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.iov_iter_zero
>       0.96 =C4=85  2%      -0.1        0.82 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.rep_stos_alternative
>       0.76 =C4=85  3%      -0.1        0.64 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64
>       0.21 =C4=85 24%      -0.1        0.11 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.aa_file_perm
>       0.31 =C4=85  7%      -0.1        0.20 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.down_write_killable
>       0.75 =C4=85  2%      -0.1        0.66 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ioctl
>       0.59 =C4=85  2%      -0.1        0.50 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.31 =C4=85  9%      -0.1        0.23 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.fget
>       0.52 =C4=85  3%      -0.1        0.44 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.stress_full
>       0.34            -0.1        0.27 =C4=85  5%  perf-profile.children.=
cycles-pp.llseek
>       0.30 =C4=85  3%      -0.1        0.24 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.kmem_cache_free
>       0.34 =C4=85  2%      -0.0        0.29 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_prev_slot
>       0.29 =C4=85  2%      -0.0        0.24 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.16 =C4=85  5%      -0.0        0.11 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__legitimize_mnt
>       0.16 =C4=85  6%      -0.0        0.12 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.__memcg_slab_free_hook
>       0.07 =C4=85  5%      -0.0        0.03 =C4=85 81%  perf-profile.chil=
dren.cycles-pp.ksys_lseek
>       0.25 =C4=85  3%      -0.0        0.22 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_ascend
>       0.18            -0.0        0.15 =C4=85  5%  perf-profile.children.=
cycles-pp.mas_data_end
>       0.19 =C4=85  2%      -0.0        0.16 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.syscall_return_via_sysret
>       0.11 =C4=85  7%      -0.0        0.08 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.open_last_lookups
>       0.07 =C4=85  4%      -0.0        0.04 =C4=85 50%  perf-profile.chil=
dren.cycles-pp.mas_prev
>       0.11 =C4=85  4%      -0.0        0.08 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.__fdget_pos
>       0.07 =C4=85  4%      -0.0        0.04 =C4=85 51%  perf-profile.chil=
dren.cycles-pp.process_measurement
>       0.06            -0.0        0.04 =C4=85 65%  perf-profile.children.=
cycles-pp.vfs_getattr_nosec
>       0.06            -0.0        0.04 =C4=85 33%  perf-profile.children.=
cycles-pp.amd_clear_divider
>       0.08 =C4=85  5%      -0.0        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.07 =C4=85 10%      +0.0        0.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.walk_component
>       0.35            +0.0        0.40 =C4=85  6%  perf-profile.children.=
cycles-pp.link_path_walk
>      97.57            +0.4       97.94        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      97.40            +0.4       97.80        perf-profile.children.cycle=
s-pp.do_syscall_64
>       2.85 =C4=85  7%      +1.7        4.53 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__libc_pread
>       2.85 =C4=85  8%      +1.7        4.54 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.read
>       2.59 =C4=85  7%      +1.7        4.30 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__x64_sys_pread64
>       2.58 =C4=85  9%      +1.7        4.31 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.ksys_read
>       0.00            +2.8        2.80 =C4=85  5%  perf-profile.children.=
cycles-pp.fsnotify_open_perm
>       5.23 =C4=85 14%      +3.0        8.19 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.rw_verify_area
>       5.06 =C4=85  8%      +3.5        8.53 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vfs_read
>       6.77 =C4=85  8%      -2.6        4.12 =C4=85  4%  perf-profile.self=
.cycles-pp.apparmor_file_open
>       5.01 =C4=85 14%      -2.6        2.44 =C4=85 12%  perf-profile.self=
.cycles-pp.apparmor_file_permission
>       3.45 =C4=85 13%      -1.7        1.77 =C4=85 10%  perf-profile.self=
.cycles-pp.apparmor_mmap_file
>       2.93 =C4=85  9%      -1.4        1.54 =C4=85  8%  perf-profile.self=
.cycles-pp.apparmor_file_alloc_security
>       2.14 =C4=85 16%      -1.2        0.99 =C4=85 14%  perf-profile.self=
.cycles-pp.apparmor_current_getsecid_subj
>       4.74 =C4=85  9%      -1.0        3.73 =C4=85  7%  perf-profile.self=
.cycles-pp.common_perm_cond
>       1.31 =C4=85  5%      -0.5        0.79 =C4=85  5%  perf-profile.self=
.cycles-pp.apparmor_file_free_security
>       0.43 =C4=85  3%      -0.2        0.21 =C4=85  5%  perf-profile.self=
.cycles-pp.__fsnotify_parent
>       1.07 =C4=85  3%      -0.2        0.88 =C4=85  6%  perf-profile.self=
.cycles-pp.mas_rev_awalk
>       0.68 =C4=85  9%      -0.2        0.50 =C4=85  6%  perf-profile.self=
.cycles-pp.kobject_put
>       0.95 =C4=85  2%      -0.1        0.81 =C4=85  4%  perf-profile.self=
.cycles-pp.rep_stos_alternative
>       0.20 =C4=85 25%      -0.1        0.10 =C4=85 14%  perf-profile.self=
.cycles-pp.aa_file_perm
>       0.28 =C4=85  8%      -0.1        0.18 =C4=85  8%  perf-profile.self=
.cycles-pp.down_write_killable
>       0.57 =C4=85  3%      -0.1        0.48 =C4=85  4%  perf-profile.self=
.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.31 =C4=85  8%      -0.1        0.22 =C4=85  9%  perf-profile.self=
.cycles-pp.fget
>       0.50 =C4=85  3%      -0.1        0.43 =C4=85  5%  perf-profile.self=
.cycles-pp.stress_full
>       0.22 =C4=85  6%      -0.1        0.16 =C4=85  6%  perf-profile.self=
.cycles-pp.cdev_put
>       0.15 =C4=85  5%      -0.0        0.11 =C4=85  6%  perf-profile.self=
.cycles-pp.__legitimize_mnt
>       0.24 =C4=85  4%      -0.0        0.20 =C4=85  6%  perf-profile.self=
.cycles-pp.mas_empty_area_rev
>       0.28 =C4=85  3%      -0.0        0.24 =C4=85  4%  perf-profile.self=
.cycles-pp.do_syscall_64
>       0.24 =C4=85  3%      -0.0        0.20 =C4=85  6%  perf-profile.self=
.cycles-pp.mas_ascend
>       0.18 =C4=85  3%      -0.0        0.14 =C4=85  6%  perf-profile.self=
.cycles-pp.do_mmap
>       0.14 =C4=85  5%      -0.0        0.11 =C4=85 12%  perf-profile.self=
.cycles-pp.chrdev_open
>       0.19 =C4=85  2%      -0.0        0.15 =C4=85  5%  perf-profile.self=
.cycles-pp.syscall_return_via_sysret
>       0.20 =C4=85  3%      -0.0        0.17 =C4=85  5%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64
>       0.20 =C4=85  4%      -0.0        0.17 =C4=85  3%  perf-profile.self=
.cycles-pp.vfs_read
>       0.18 =C4=85  2%      -0.0        0.15 =C4=85  3%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.16 =C4=85  2%      -0.0        0.13 =C4=85  4%  perf-profile.self=
.cycles-pp.mas_data_end
>       0.07 =C4=85  4%      -0.0        0.04 =C4=85 50%  perf-profile.self=
.cycles-pp.process_measurement
>       0.16 =C4=85  3%      -0.0        0.13 =C4=85  5%  perf-profile.self=
.cycles-pp.vm_unmapped_area
>       0.12 =C4=85  4%      -0.0        0.09 =C4=85  6%  perf-profile.self=
.cycles-pp.mas_prev_slot
>       0.14 =C4=85  2%      -0.0        0.12 =C4=85  5%  perf-profile.self=
.cycles-pp.kmem_cache_free
>       0.10 =C4=85  5%      -0.0        0.07 =C4=85  6%  perf-profile.self=
.cycles-pp.open64
>       0.15 =C4=85  2%      -0.0        0.13 =C4=85  5%  perf-profile.self=
.cycles-pp.syscall_exit_to_user_mode
>       0.15 =C4=85  2%      -0.0        0.13 =C4=85  4%  perf-profile.self=
.cycles-pp.ioctl
>       0.09 =C4=85  5%      -0.0        0.07 =C4=85  8%  perf-profile.self=
.cycles-pp.write
>       0.07 =C4=85  6%      -0.0        0.06        perf-profile.self.cycl=
es-pp.__close
>       0.11 =C4=85  4%      +0.0        0.13 =C4=85  4%  perf-profile.self=
.cycles-pp.link_path_walk
>       0.01 =C4=85200%      +0.0        0.06 =C4=85  9%  perf-profile.self=
.cycles-pp.__virt_addr_valid
>       0.75 =C4=85  2%      +0.1        0.89 =C4=85  3%  perf-profile.self=
.cycles-pp._raw_spin_lock
>       0.00            +2.8        2.79 =C4=85  5%  perf-profile.self.cycl=
es-pp.fsnotify_open_perm
>       0.05            +5.6        5.63 =C4=85 10%  perf-profile.self.cycl=
es-pp.rw_verify_area
>
>
> *************************************************************************=
**************************
> lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00=
GHz (Cascade Lake) with 128G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/=
testcase:
>   gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s=
/lkp-csl-d02/fsbuffer-r/unixbench
>
> commit:
>   477cf917dd ("fsnotify: use an enum for group priority constants")
>   a5e57b4d37 ("fsnotify: optimize the case of no permission event watcher=
s")
>
> 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    1339661            +6.4%    1425877        unixbench.throughput
>  5.765e+08            +6.4%  6.131e+08        unixbench.workload
>  1.159e+09            +2.2%  1.184e+09        perf-stat.i.branch-instruct=
ions
>       1.49            +0.0        1.54        perf-stat.i.branch-miss-rat=
e%
>   10449249 =C4=85  2%      +6.7%   11149426        perf-stat.i.branch-mis=
ses
>       4514            -5.3%       4273        perf-stat.overall.path-leng=
th
>  1.156e+09            +2.2%  1.181e+09        perf-stat.ps.branch-instruc=
tions
>   10430168 =C4=85  2%      +6.7%   11128869        perf-stat.ps.branch-mi=
sses
>       7.02 =C4=85  2%      -3.3        3.70 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>       1.45 =C4=85  3%      +0.2        1.62 =C4=85  3%  perf-profile.call=
trace.cycles-pp.syscall_return_via_sysret.read
>       1.24 =C4=85  3%      +0.2        1.44 =C4=85  3%  perf-profile.call=
trace.cycles-pp.current_time.atime_needs_update.touch_atime.filemap_read.vf=
s_read
>       2.55 =C4=85  8%      +0.4        2.91 =C4=85  4%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_read.ksys_read
>       3.04 =C4=85  6%      +0.4        3.44 =C4=85  3%  perf-profile.call=
trace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.=
do_syscall_64
>       1.94 =C4=85  9%      +0.5        2.42 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.read
>       8.62 =C4=85  3%      +0.5        9.14        perf-profile.calltrace=
.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
>       7.90 =C4=85  2%      +0.6        8.51        perf-profile.calltrace=
.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
>       9.29 =C4=85  2%      +0.8       10.04        perf-profile.calltrace=
.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
>       4.43 =C4=85  7%      +0.8        5.28 =C4=85  2%  perf-profile.call=
trace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.filema=
p_read.vfs_read
>      29.04 =C4=85  3%      +1.8       30.80        perf-profile.calltrace=
.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
>       7.06 =C4=85  2%      -3.3        3.73 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__fsnotify_parent
>       0.77 =C4=85  6%      +0.1        0.88 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_safe_stack
>       1.26 =C4=85  2%      +0.2        1.45 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.current_time
>       1.66 =C4=85  3%      +0.2        1.90 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.syscall_return_via_sysret
>       3.72 =C4=85  2%      +0.3        4.03        perf-profile.children.=
cycles-pp.entry_SYSRETQ_unsafe_stack
>       2.56 =C4=85  7%      +0.4        2.91 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.apparmor_file_permission
>       5.72 =C4=85  2%      +0.4        6.08        perf-profile.children.=
cycles-pp.entry_SYSCALL_64
>       4.40 =C4=85  4%      +0.4        4.81 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.rep_movs_alternative
>       3.10 =C4=85  6%      +0.4        3.52 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.security_file_permission
>       1.94 =C4=85  9%      +0.5        2.42 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__fdget_pos
>       8.68 =C4=85  3%      +0.5        9.20        perf-profile.children.=
cycles-pp.filemap_get_pages
>       8.37 =C4=85  2%      +0.7        9.05        perf-profile.children.=
cycles-pp._copy_to_iter
>       9.52 =C4=85  2%      +0.8       10.28        perf-profile.children.=
cycles-pp.copy_page_to_iter
>      29.25 =C4=85  3%      +1.7       30.99        perf-profile.children.=
cycles-pp.filemap_read
>       6.94            -3.2        3.72 =C4=85  3%  perf-profile.self.cycl=
es-pp.__fsnotify_parent
>       0.77 =C4=85  6%      +0.1        0.88 =C4=85  7%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.83 =C4=85  5%      +0.1        0.97 =C4=85  7%  perf-profile.self=
.cycles-pp.current_time
>       1.66 =C4=85  3%      +0.2        1.90 =C4=85  3%  perf-profile.self=
.cycles-pp.syscall_return_via_sysret
>       3.52 =C4=85  2%      +0.2        3.76        perf-profile.self.cycl=
es-pp.entry_SYSRETQ_unsafe_stack
>       2.42 =C4=85  3%      +0.3        2.67 =C4=85  3%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64
>       1.92 =C4=85  6%      +0.3        2.20 =C4=85  5%  perf-profile.self=
.cycles-pp.apparmor_file_permission
>       3.92 =C4=85  4%      +0.3        4.25 =C4=85  2%  perf-profile.self=
.cycles-pp.rep_movs_alternative
>       4.38            +0.3        4.72 =C4=85  2%  perf-profile.self.cycl=
es-pp._copy_to_iter
>       1.16 =C4=85  8%      +0.3        1.51 =C4=85  2%  perf-profile.self=
.cycles-pp.ksys_read
>       1.85 =C4=85 10%      +0.5        2.36 =C4=85  2%  perf-profile.self=
.cycles-pp.__fdget_pos
>
>
>
> *************************************************************************=
**************************
> lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00=
GHz (Cascade Lake) with 128G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/=
testcase:
>   gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s=
/lkp-csl-d02/fstime-r/unixbench
>
> commit:
>   477cf917dd ("fsnotify: use an enum for group priority constants")
>   a5e57b4d37 ("fsnotify: optimize the case of no permission event watcher=
s")
>
> 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    4709035            +5.8%    4980152        unixbench.throughput
>  2.026e+09            +5.7%  2.141e+09        unixbench.workload
>  1.034e+09            +1.4%  1.048e+09        perf-stat.i.branch-instruct=
ions
>       1.56            +0.0        1.59        perf-stat.i.branch-miss-rat=
e%
>   60950726            +5.3%   64193405        perf-stat.i.cache-reference=
s
>       0.02 =C4=85 30%     -36.7%       0.01 =C4=85 39%  perf-stat.i.major=
-faults
>       0.78            -0.0        0.75        perf-stat.overall.cache-mis=
s-rate%
>       1145            -5.4%       1083        perf-stat.overall.path-leng=
th
>  1.031e+09            +1.4%  1.046e+09        perf-stat.ps.branch-instruc=
tions
>   60812120            +5.3%   64047513        perf-stat.ps.cache-referenc=
es
>       0.02 =C4=85 30%     -36.7%       0.01 =C4=85 39%  perf-stat.ps.majo=
r-faults
>       6.22 =C4=85  3%      -2.9        3.30 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>      49.43            -1.5       47.90        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      52.39            -1.0       51.34        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      55.16            -0.9       54.29        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      56.49            -0.7       55.80        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.read
>       2.40 =C4=85  4%      +0.2        2.64 =C4=85  5%  perf-profile.call=
trace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_r=
ead
>       2.59 =C4=85  4%      +0.3        2.86 =C4=85  5%  perf-profile.call=
trace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
>       6.88            +0.3        7.23 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.k=
sys_read
>       2.26 =C4=85  3%      +0.4        2.64 =C4=85 10%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_read.ksys_read
>       7.90 =C4=85  3%      +0.4        8.29        perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64.read
>       2.68 =C4=85  2%      +0.4        3.13 =C4=85  8%  perf-profile.call=
trace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.=
do_syscall_64
>       8.47            +0.4        8.91        perf-profile.calltrace.cycl=
es-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
>      32.80            +1.8       34.63        perf-profile.calltrace.cycl=
es-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>       6.27 =C4=85  3%      -2.9        3.34 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__fsnotify_parent
>      49.50            -1.4       48.07        perf-profile.children.cycle=
s-pp.vfs_read
>      52.46            -1.0       51.45        perf-profile.children.cycle=
s-pp.ksys_read
>       1.16 =C4=85  4%      +0.1        1.28 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       2.46 =C4=85  4%      +0.2        2.69 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.atime_needs_update
>       5.03 =C4=85  3%      +0.3        5.30        perf-profile.children.=
cycles-pp.entry_SYSCALL_64
>       2.66 =C4=85  4%      +0.3        2.94 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.touch_atime
>       3.27 =C4=85  2%      +0.3        3.59        perf-profile.children.=
cycles-pp.entry_SYSRETQ_unsafe_stack
>       6.96            +0.4        7.31 =C4=85  2%  perf-profile.children.=
cycles-pp.filemap_get_read_batch
>       2.27 =C4=85  3%      +0.4        2.64 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.apparmor_file_permission
>       2.76 =C4=85  2%      +0.4        3.20 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.security_file_permission
>       8.52            +0.5        8.98        perf-profile.children.cycle=
s-pp.filemap_get_pages
>      32.99            +1.8       34.80        perf-profile.children.cycle=
s-pp.filemap_read
>       6.16 =C4=85  3%      -2.8        3.32 =C4=85  3%  perf-profile.self=
.cycles-pp.__fsnotify_parent
>       1.19 =C4=85  3%      -0.4        0.81 =C4=85  6%  perf-profile.self=
.cycles-pp.rw_verify_area
>       1.55 =C4=85  3%      +0.1        1.64 =C4=85  2%  perf-profile.self=
.cycles-pp.filemap_get_pages
>       0.70 =C4=85  3%      +0.1        0.81 =C4=85  7%  perf-profile.self=
.cycles-pp.syscall_exit_to_user_mode
>       1.31 =C4=85  4%      +0.1        1.43 =C4=85  4%  perf-profile.self=
.cycles-pp.do_syscall_64
>       2.15 =C4=85  4%      +0.1        2.28        perf-profile.self.cycl=
es-pp.entry_SYSCALL_64
>       4.00 =C4=85  2%      +0.2        4.22        perf-profile.self.cycl=
es-pp.read
>       1.06 =C4=85  4%      +0.3        1.31 =C4=85  5%  perf-profile.self=
.cycles-pp.ksys_read
>       3.09 =C4=85  2%      +0.3        3.36        perf-profile.self.cycl=
es-pp.entry_SYSRETQ_unsafe_stack
>       3.89 =C4=85  2%      +0.3        4.19 =C4=85  3%  perf-profile.self=
.cycles-pp._copy_to_iter
>       1.66 =C4=85  2%      +0.3        2.01 =C4=85 13%  perf-profile.self=
.cycles-pp.apparmor_file_permission
>
>
>
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

