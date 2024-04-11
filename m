Return-Path: <linux-fsdevel+bounces-16668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE08A139C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F09283534
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AD14A4CA;
	Thu, 11 Apr 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGYtHYob";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="04+Z2cZI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2PEs9v8z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqlVc7Dz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99E14A08D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836457; cv=none; b=nkUU7ayQotVGMHviSpCnHtAmUM0JLkotANzypAw9cUuq02d5C8+dvs1ZgkfZszUtgJCFrI8dUY4O8UevZMxlImARGswuJMLuZQee9QH9Vo0jfr3T79RLn9G0mSxNiWacuNHz1HpcMDRmLCigMNHmjYrcG/kCH7YFUkUWMDpvxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836457; c=relaxed/simple;
	bh=TA/YPAajjNyIIotnHjWiObXk2BXMdmKLLV9FN8ERQhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ7yhrW6gdY3plcBB7FpRwhNRw491i2oNcDgEz3t6nprUB7VND7eisMMzEGhvAVNYzeiPdNBHy7ws1c3fzelyYtW8hCMhVf7y7G7NQ3IP7dDsvIoSq+aIKjCb4qoc/n6tLoBIUOt2h8qXgQeOwF5PsnGHDAfhgiYkEjGgeKTA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGYtHYob; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=04+Z2cZI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2PEs9v8z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqlVc7Dz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4ED2537402;
	Thu, 11 Apr 2024 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712836450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vub+0Hugz2BCiyYseKjnMmLH+EpFTQ2j+Au5ztX/kWQ=;
	b=YGYtHYobcYDst9snu8cr3pTt5l9uCyIo/aBsmb9oaqkcFGOAh2bzUBgj5Lj6zIeOawRBlY
	WRK/6Rj8HX9pJl5cv3ZISwN3qWsCWq7uKwvT+6nDjfV3r4bB+dKCkSQuluQhl7+tciri5C
	9RRzQFtEWx/B+KUDaVaPyXhtkpcdAJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712836450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vub+0Hugz2BCiyYseKjnMmLH+EpFTQ2j+Au5ztX/kWQ=;
	b=04+Z2cZIRlXdD20s8ppJuo1c0rQgvdvDa1WBzzFRChEaMRmgKCeqD2WJJJnXfqLAm0kdmO
	oMq4M2I+POf/CSDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2PEs9v8z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qqlVc7Dz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712836449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vub+0Hugz2BCiyYseKjnMmLH+EpFTQ2j+Au5ztX/kWQ=;
	b=2PEs9v8zZL1mvlNyXCmjoIjeCoAwQGTMd/HA4g+drFQNBw19qCPrB6EOElXRHnHONBnyTa
	X84n4LrOF398925JVxiCXCOpCCTwBHrhi/pLItspFBmuTPDchzDMLAuT1QcNP6f6Aefb7y
	jcJpG+sL34MX2FdGbk0OBltrPf/yfnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712836449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vub+0Hugz2BCiyYseKjnMmLH+EpFTQ2j+Au5ztX/kWQ=;
	b=qqlVc7Dz+QPK2+q3Kvg3siccDicRlfWl6t7rR7H6sCjAt+onoAXK5xgKJp2vADShAJxqaF
	Rc13T90IyHeooWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 372AD139DE;
	Thu, 11 Apr 2024 11:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /gp3DWHPF2YUEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Apr 2024 11:54:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D16BAA06F8; Thu, 11 Apr 2024 13:54:08 +0200 (CEST)
Date: Thu, 11 Apr 2024 13:54:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [fsnotify] a5e57b4d37:
 stress-ng.full.ops_per_sec -17.3% regression
Message-ID: <20240411115408.266zydqiwalko5k3@quack3>
References: <202404101624.85684be8-oliver.sang@intel.com>
 <CAOQ4uxgFAPMsD03cyez+6rMjRsX=aTo_+d2kuGG9eUwwa6P-zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgFAPMsD03cyez+6rMjRsX=aTo_+d2kuGG9eUwwa6P-zA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.23 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	R_MIXED_CHARSET(2.78)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,intel.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4ED2537402
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.23

On Thu 11-04-24 12:23:34, Amir Goldstein wrote:
> On Thu, Apr 11, 2024 at 4:42 AM kernel test robot <oliver.sang@intel.com> wrote:
> > for "[amir73il:fsnotify-sbconn] [fsnotify]  629f30e073: unixbench.throughput 5.8% improvement"
> > (https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.com/)
> > you requested us to test unixbench for this commit on different branches and we
> > observed consistent performance improvement.
> >
> > now we noticed this commit is merged into linux-next/master, we still
> > observed similar unixbench improvement, however, we also captured a
> > stress-ng regression now. below details FYI.
> >
> > Hello,
> >
> > kernel test robot noticed a -17.3% regression of stress-ng.full.ops_per_sec on:
> >
> >
> > commit: a5e57b4d370c6d320e5bfb0c919fe00aee29e039 ("fsnotify: optimize the case of no permission event watchers")
> 
> Odd. This commit does add an extra fsnotify_sb_has_priority_watchers()
> inline check for reads and writes, but the inline helper
> fsnotify_sb_has_watchers()
> already exists in fsnotify_parent() and it already accesses fsnotify_sb_info.
> 
> It seems like stress-ng.full does read/write/mmap operations on /dev/full,
> so the fsnotify_sb_info object would be that of devtmpfs.
> 
> I think that the permission events on special files are not very relevant,
> but I am not sure.
> 
> Jan, any ideas?

So I'm not 100% sure but this load simply seems to run 'stress-ng' with all
the syscalls it is able to exercise (one per CPU if I'm right). Hum...
looking at perf numbers I've noticed changes like:

      0.43 ą  3%      -0.2        0.21 ą  5%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.00            +2.8        2.79 ą  5%  perf-profile.self.cycles-pp.fsnotify_open_perm

or

      1.77 ą 12%      +1.9        3.64 ą  8%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71 ą 15%      +1.9        3.64 ą  9%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.8        2.79 ą  5%  perf-profile.calltrace.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_open

So the savings in __fsnotify_parent() don't really outweight the costs in
fsnotify_file()... I can see stress-ng exercises also inotify so maybe
there's some contention on the counters which is causing the regression now
that we have more of them?

BTW, I'm not sure how you've arrived at the conclusing the test is using
/dev/full. For all I can tell the e.g. the stress-mmap test is using a file
in a subdir of CWD.

								Honza

> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > testcase: stress-ng
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> >
> >         nr_threads: 100%
> >         testtime: 60s
> >         test: full
> >         cpufreq_governor: performance
> >
> >
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | unixbench: unixbench.throughput 6.4% improvement                                                |
> > | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> > | test parameters  | cpufreq_governor=performance                                                                    |
> > |                  | nr_task=1                                                                                       |
> > |                  | runtime=300s                                                                                    |
> > |                  | test=fsbuffer-r                                                                                 |
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | unixbench: unixbench.throughput 5.8% improvement                                                |
> > | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> > | test parameters  | cpufreq_governor=performance                                                                    |
> > |                  | nr_task=1                                                                                       |
> > |                  | runtime=300s                                                                                    |
> > |                  | test=fstime-r                                                                                   |
> > +------------------+-------------------------------------------------------------------------------------------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202404101624.85684be8-oliver.sang@intel.com
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240410/202404101624.85684be8-oliver.sang@intel.com
> >
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> >   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/full/stress-ng/60s
> >
> > commit:
> >   477cf917dd ("fsnotify: use an enum for group priority constants")
> >   a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")
> >
> > 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      20489 ą  7%     -19.2%      16565 ą 13%  perf-c2c.HITM.remote
> >     409.48 ą  9%     -14.0%     352.13 ą  5%  sched_debug.cfs_rq:/.util_est.avg
> >     217.94 ą  8%     +12.9%     246.07 ą  4%  sched_debug.cfs_rq:/.util_est.stddev
> >  1.461e+08 ą  3%     -17.3%  1.208e+08 ą  5%  stress-ng.full.ops
> >    2434462 ą  3%     -17.3%    2013444 ą  5%  stress-ng.full.ops_per_sec
> >      71.04 ą  3%     -16.6%      59.28 ą  6%  stress-ng.time.user_time
> >   9.95e+09 ą  4%     -13.4%  8.617e+09 ą  3%  perf-stat.i.branch-instructions
> >       0.48 ą  3%      +0.1        0.55 ą  2%  perf-stat.i.branch-miss-rate%
> >       4.36 ą  4%     +17.1%       5.10 ą  3%  perf-stat.i.cpi
> >  5.162e+10 ą  4%     -14.5%  4.416e+10 ą  3%  perf-stat.i.instructions
> >       0.24 ą  3%     -13.8%       0.21 ą  3%  perf-stat.i.ipc
> >       0.46 ą  3%      +0.1        0.54 ą  2%  perf-stat.overall.branch-miss-rate%
> >       4.38 ą  4%     +16.9%       5.12 ą  3%  perf-stat.overall.cpi
> >       0.23 ą  4%     -14.5%       0.20 ą  3%  perf-stat.overall.ipc
> >  9.781e+09 ą  4%     -13.4%  8.471e+09 ą  3%  perf-stat.ps.branch-instructions
> >  5.075e+10 ą  4%     -14.5%  4.341e+10 ą  3%  perf-stat.ps.instructions
> >  3.111e+12 ą  4%     -14.5%   2.66e+12 ą  3%  perf-stat.total.instructions
> >       8.39 ą  7%      -2.8        5.56 ą  4%  perf-profile.calltrace.cycles-pp.__mmap
> >       8.09 ą  7%      -2.8        5.31 ą  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
> >       8.05 ą  7%      -2.8        5.28 ą  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
> >       7.95 ą  7%      -2.8        5.19 ą  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
> >       6.80 ą  8%      -2.7        4.14 ą  4%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
> >       7.46 ą  8%      -2.7        4.80 ą  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
> >       6.78 ą  8%      -2.7        4.13 ą  4%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
> >       4.12 ą 14%      -2.0        2.09 ą 10%  perf-profile.calltrace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       3.54 ą 14%      -1.7        1.81 ą 10%  perf-profile.calltrace.cycles-pp.apparmor_mmap_file.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
> >       3.46 ą  8%      -1.5        1.99 ą  6%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
> >       3.15 ą  8%      -1.4        1.71 ą  7%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
> >       3.06 ą  9%      -1.4        1.63 ą  7%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
> >       2.95 ą  9%      -1.4        1.54 ą  8%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
> >       5.50 ą  7%      -1.1        4.39 ą  5%  perf-profile.calltrace.cycles-pp.fstatat64
> >       5.34 ą  7%      -1.1        4.26 ą  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
> >       5.32 ą  7%      -1.1        4.24 ą  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
> >       5.27 ą  8%      -1.1        4.20 ą  6%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
> >       4.95 ą  8%      -1.0        3.91 ą  7%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
> >       4.78 ą  8%      -1.0        3.77 ą  7%  perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       4.75 ą  9%      -1.0        3.74 ą  7%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64
> >       1.74 ą 12%      -0.9        0.83 ą 11%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.__x64_sys_pread64
> >       1.75 ą 12%      -0.9        0.84 ą 11%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64
> >       2.08 ą 13%      -0.9        1.17 ą  9%  perf-profile.calltrace.cycles-pp.write
> >       1.78 ą 13%      -0.9        0.88 ą 13%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
> >       1.77 ą 13%      -0.9        0.87 ą 13%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
> >       1.68 ą 15%      -0.9        0.80 ą 13%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
> >       1.68 ą 15%      -0.9        0.80 ą 13%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
> >       1.68 ą 14%      -0.9        0.80 ą 14%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
> >       1.68 ą 14%      -0.9        0.81 ą 14%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
> >       1.90 ą 14%      -0.9        1.02 ą 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
> >       1.88 ą 14%      -0.9        1.00 ą 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
> >       1.82 ą 15%      -0.9        0.96 ą 11%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
> >       1.77 ą 15%      -0.8        0.92 ą 11%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
> >       1.74 ą 15%      -0.8        0.90 ą 12%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.72 ą 15%      -0.8        0.87 ą 12%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
> >       1.73 ą 15%      -0.8        0.89 ą 12%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
> >       1.32 ą  5%      -0.5        0.80 ą  5%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.31 ą  5%      -0.5        0.80 ą  5%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
> >       2.72 ą  2%      -0.5        2.24 ą  6%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.68 ą  9%      -0.4        0.26 ą100%  perf-profile.calltrace.cycles-pp.kobject_put.cdev_put.__fput.__x64_sys_close.do_syscall_64
> >       2.48 ą  2%      -0.4        2.07 ą  5%  perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
> >       2.39 ą  2%      -0.4        1.99 ą  6%  perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
> >       2.22 ą  2%      -0.4        1.84 ą  5%  perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff
> >       1.54 ą  2%      -0.3        1.27 ą  6%  perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap
> >       0.91 ą  8%      -0.2        0.66 ą  6%  perf-profile.calltrace.cycles-pp.cdev_put.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.17 ą  3%      -0.2        0.96 ą  6%  perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area
> >       0.64 ą  2%      -0.1        0.57 ą  4%  perf-profile.calltrace.cycles-pp.ioctl
> >       2.80 ą  7%      +1.7        4.48 ą  6%  perf-profile.calltrace.cycles-pp.__libc_pread
> >       2.65 ą  7%      +1.7        4.35 ą  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pread
> >       2.63 ą  7%      +1.7        4.33 ą  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
> >       2.58 ą  7%      +1.7        4.29 ą  7%  perf-profile.calltrace.cycles-pp.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
> >       2.79 ą  8%      +1.7        4.50 ą  7%  perf-profile.calltrace.cycles-pp.read
> >       2.53 ą  8%      +1.7        4.25 ą  7%  perf-profile.calltrace.cycles-pp.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
> >       2.64 ą  9%      +1.7        4.37 ą  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
> >       2.62 ą  9%      +1.7        4.35 ą  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >       2.57 ą  9%      +1.7        4.31 ą  8%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >       2.52 ą 10%      +1.7        4.27 ą  8%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >       1.77 ą 12%      +1.9        3.64 ą  8%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.71 ą 15%      +1.9        3.64 ą  9%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +2.8        2.79 ą  5%  perf-profile.calltrace.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_open
> >       8.50 ą  7%      -2.8        5.66 ą  4%  perf-profile.children.cycles-pp.__mmap
> >       7.96 ą  7%      -2.8        5.20 ą  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
> >       6.81 ą  8%      -2.7        4.14 ą  4%  perf-profile.children.cycles-pp.security_file_open
> >       6.79 ą  8%      -2.7        4.14 ą  4%  perf-profile.children.cycles-pp.apparmor_file_open
> >       7.48 ą  7%      -2.7        4.83 ą  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
> >       5.14 ą 14%      -2.6        2.51 ą 12%  perf-profile.children.cycles-pp.apparmor_file_permission
> >       5.18 ą 14%      -2.6        2.54 ą 11%  perf-profile.children.cycles-pp.security_file_permission
> >       4.13 ą 14%      -2.0        2.10 ą 10%  perf-profile.children.cycles-pp.security_mmap_file
> >       3.55 ą 14%      -1.7        1.81 ą 10%  perf-profile.children.cycles-pp.apparmor_mmap_file
> >       3.47 ą  8%      -1.5        2.00 ą  6%  perf-profile.children.cycles-pp.alloc_empty_file
> >       3.15 ą  8%      -1.4        1.72 ą  7%  perf-profile.children.cycles-pp.init_file
> >       3.06 ą  9%      -1.4        1.64 ą  7%  perf-profile.children.cycles-pp.security_file_alloc
> >       2.95 ą  9%      -1.4        1.55 ą  8%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
> >       2.18 ą 16%      -1.2        1.02 ą 14%  perf-profile.children.cycles-pp.security_current_getsecid_subj
> >       2.16 ą 16%      -1.2        1.00 ą 14%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
> >       5.55 ą  7%      -1.1        4.44 ą  5%  perf-profile.children.cycles-pp.fstatat64
> >       5.27 ą  8%      -1.1        4.20 ą  6%  perf-profile.children.cycles-pp.__do_sys_newfstatat
> >       4.96 ą  8%      -1.0        3.92 ą  7%  perf-profile.children.cycles-pp.vfs_fstat
> >       4.78 ą  8%      -1.0        3.77 ą  7%  perf-profile.children.cycles-pp.security_inode_getattr
> >       4.75 ą  9%      -1.0        3.74 ą  7%  perf-profile.children.cycles-pp.common_perm_cond
> >       2.16 ą 12%      -0.9        1.25 ą  8%  perf-profile.children.cycles-pp.write
> >       1.78 ą 13%      -0.9        0.88 ą 13%  perf-profile.children.cycles-pp.security_file_post_open
> >       1.77 ą 13%      -0.9        0.87 ą 13%  perf-profile.children.cycles-pp.ima_file_check
> >       1.86 ą 14%      -0.9        1.00 ą 10%  perf-profile.children.cycles-pp.ksys_write
> >       1.81 ą 15%      -0.8        0.96 ą 10%  perf-profile.children.cycles-pp.vfs_write
> >       1.32 ą  5%      -0.5        0.80 ą  5%  perf-profile.children.cycles-pp.security_file_free
> >       1.31 ą  5%      -0.5        0.80 ą  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
> >       2.73 ą  2%      -0.5        2.25 ą  6%  perf-profile.children.cycles-pp.do_mmap
> >       2.50 ą  2%      -0.4        2.08 ą  6%  perf-profile.children.cycles-pp.get_unmapped_area
> >       2.41 ą  2%      -0.4        2.01 ą  6%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
> >       2.24 ą  2%      -0.4        1.86 ą  5%  perf-profile.children.cycles-pp.vm_unmapped_area
> >       0.52 ą 23%      -0.3        0.23 ą 14%  perf-profile.children.cycles-pp.ima_file_mmap
> >       1.58 ą  2%      -0.3        1.31 ą  6%  perf-profile.children.cycles-pp.mas_empty_area_rev
> >       0.91 ą  7%      -0.2        0.67 ą  6%  perf-profile.children.cycles-pp.cdev_put
> >       0.44 ą  3%      -0.2        0.22 ą  6%  perf-profile.children.cycles-pp.__fsnotify_parent
> >       1.21 ą  3%      -0.2        0.99 ą  6%  perf-profile.children.cycles-pp.mas_rev_awalk
> >       0.69 ą  9%      -0.2        0.50 ą  6%  perf-profile.children.cycles-pp.kobject_put
> >       1.13 ą  3%      -0.2        0.96 ą  4%  perf-profile.children.cycles-pp.read_iter_zero
> >       1.09 ą  3%      -0.2        0.93 ą  4%  perf-profile.children.cycles-pp.iov_iter_zero
> >       0.96 ą  2%      -0.1        0.82 ą  4%  perf-profile.children.cycles-pp.rep_stos_alternative
> >       0.76 ą  3%      -0.1        0.64 ą  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
> >       0.21 ą 24%      -0.1        0.11 ą 12%  perf-profile.children.cycles-pp.aa_file_perm
> >       0.31 ą  7%      -0.1        0.20 ą  8%  perf-profile.children.cycles-pp.down_write_killable
> >       0.75 ą  2%      -0.1        0.66 ą  4%  perf-profile.children.cycles-pp.ioctl
> >       0.59 ą  2%      -0.1        0.50 ą  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.31 ą  9%      -0.1        0.23 ą  8%  perf-profile.children.cycles-pp.fget
> >       0.52 ą  3%      -0.1        0.44 ą  5%  perf-profile.children.cycles-pp.stress_full
> >       0.34            -0.1        0.27 ą  5%  perf-profile.children.cycles-pp.llseek
> >       0.30 ą  3%      -0.1        0.24 ą  8%  perf-profile.children.cycles-pp.kmem_cache_free
> >       0.34 ą  2%      -0.0        0.29 ą  6%  perf-profile.children.cycles-pp.mas_prev_slot
> >       0.29 ą  2%      -0.0        0.24 ą  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
> >       0.16 ą  5%      -0.0        0.11 ą  8%  perf-profile.children.cycles-pp.__legitimize_mnt
> >       0.16 ą  6%      -0.0        0.12 ą 13%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
> >       0.07 ą  5%      -0.0        0.03 ą 81%  perf-profile.children.cycles-pp.ksys_lseek
> >       0.25 ą  3%      -0.0        0.22 ą  6%  perf-profile.children.cycles-pp.mas_ascend
> >       0.18            -0.0        0.15 ą  5%  perf-profile.children.cycles-pp.mas_data_end
> >       0.19 ą  2%      -0.0        0.16 ą  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
> >       0.11 ą  7%      -0.0        0.08 ą  8%  perf-profile.children.cycles-pp.open_last_lookups
> >       0.07 ą  4%      -0.0        0.04 ą 50%  perf-profile.children.cycles-pp.mas_prev
> >       0.11 ą  4%      -0.0        0.08 ą  9%  perf-profile.children.cycles-pp.__fdget_pos
> >       0.07 ą  4%      -0.0        0.04 ą 51%  perf-profile.children.cycles-pp.process_measurement
> >       0.06            -0.0        0.04 ą 65%  perf-profile.children.cycles-pp.vfs_getattr_nosec
> >       0.06            -0.0        0.04 ą 33%  perf-profile.children.cycles-pp.amd_clear_divider
> >       0.08 ą  5%      -0.0        0.06 ą  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
> >       0.07 ą 10%      +0.0        0.10 ą 10%  perf-profile.children.cycles-pp.walk_component
> >       0.35            +0.0        0.40 ą  6%  perf-profile.children.cycles-pp.link_path_walk
> >      97.57            +0.4       97.94        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      97.40            +0.4       97.80        perf-profile.children.cycles-pp.do_syscall_64
> >       2.85 ą  7%      +1.7        4.53 ą  6%  perf-profile.children.cycles-pp.__libc_pread
> >       2.85 ą  8%      +1.7        4.54 ą  7%  perf-profile.children.cycles-pp.read
> >       2.59 ą  7%      +1.7        4.30 ą  7%  perf-profile.children.cycles-pp.__x64_sys_pread64
> >       2.58 ą  9%      +1.7        4.31 ą  8%  perf-profile.children.cycles-pp.ksys_read
> >       0.00            +2.8        2.80 ą  5%  perf-profile.children.cycles-pp.fsnotify_open_perm
> >       5.23 ą 14%      +3.0        8.19 ą  8%  perf-profile.children.cycles-pp.rw_verify_area
> >       5.06 ą  8%      +3.5        8.53 ą  7%  perf-profile.children.cycles-pp.vfs_read
> >       6.77 ą  8%      -2.6        4.12 ą  4%  perf-profile.self.cycles-pp.apparmor_file_open
> >       5.01 ą 14%      -2.6        2.44 ą 12%  perf-profile.self.cycles-pp.apparmor_file_permission
> >       3.45 ą 13%      -1.7        1.77 ą 10%  perf-profile.self.cycles-pp.apparmor_mmap_file
> >       2.93 ą  9%      -1.4        1.54 ą  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
> >       2.14 ą 16%      -1.2        0.99 ą 14%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
> >       4.74 ą  9%      -1.0        3.73 ą  7%  perf-profile.self.cycles-pp.common_perm_cond
> >       1.31 ą  5%      -0.5        0.79 ą  5%  perf-profile.self.cycles-pp.apparmor_file_free_security
> >       0.43 ą  3%      -0.2        0.21 ą  5%  perf-profile.self.cycles-pp.__fsnotify_parent
> >       1.07 ą  3%      -0.2        0.88 ą  6%  perf-profile.self.cycles-pp.mas_rev_awalk
> >       0.68 ą  9%      -0.2        0.50 ą  6%  perf-profile.self.cycles-pp.kobject_put
> >       0.95 ą  2%      -0.1        0.81 ą  4%  perf-profile.self.cycles-pp.rep_stos_alternative
> >       0.20 ą 25%      -0.1        0.10 ą 14%  perf-profile.self.cycles-pp.aa_file_perm
> >       0.28 ą  8%      -0.1        0.18 ą  8%  perf-profile.self.cycles-pp.down_write_killable
> >       0.57 ą  3%      -0.1        0.48 ą  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.31 ą  8%      -0.1        0.22 ą  9%  perf-profile.self.cycles-pp.fget
> >       0.50 ą  3%      -0.1        0.43 ą  5%  perf-profile.self.cycles-pp.stress_full
> >       0.22 ą  6%      -0.1        0.16 ą  6%  perf-profile.self.cycles-pp.cdev_put
> >       0.15 ą  5%      -0.0        0.11 ą  6%  perf-profile.self.cycles-pp.__legitimize_mnt
> >       0.24 ą  4%      -0.0        0.20 ą  6%  perf-profile.self.cycles-pp.mas_empty_area_rev
> >       0.28 ą  3%      -0.0        0.24 ą  4%  perf-profile.self.cycles-pp.do_syscall_64
> >       0.24 ą  3%      -0.0        0.20 ą  6%  perf-profile.self.cycles-pp.mas_ascend
> >       0.18 ą  3%      -0.0        0.14 ą  6%  perf-profile.self.cycles-pp.do_mmap
> >       0.14 ą  5%      -0.0        0.11 ą 12%  perf-profile.self.cycles-pp.chrdev_open
> >       0.19 ą  2%      -0.0        0.15 ą  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
> >       0.20 ą  3%      -0.0        0.17 ą  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64
> >       0.20 ą  4%      -0.0        0.17 ą  3%  perf-profile.self.cycles-pp.vfs_read
> >       0.18 ą  2%      -0.0        0.15 ą  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       0.16 ą  2%      -0.0        0.13 ą  4%  perf-profile.self.cycles-pp.mas_data_end
> >       0.07 ą  4%      -0.0        0.04 ą 50%  perf-profile.self.cycles-pp.process_measurement
> >       0.16 ą  3%      -0.0        0.13 ą  5%  perf-profile.self.cycles-pp.vm_unmapped_area
> >       0.12 ą  4%      -0.0        0.09 ą  6%  perf-profile.self.cycles-pp.mas_prev_slot
> >       0.14 ą  2%      -0.0        0.12 ą  5%  perf-profile.self.cycles-pp.kmem_cache_free
> >       0.10 ą  5%      -0.0        0.07 ą  6%  perf-profile.self.cycles-pp.open64
> >       0.15 ą  2%      -0.0        0.13 ą  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
> >       0.15 ą  2%      -0.0        0.13 ą  4%  perf-profile.self.cycles-pp.ioctl
> >       0.09 ą  5%      -0.0        0.07 ą  8%  perf-profile.self.cycles-pp.write
> >       0.07 ą  6%      -0.0        0.06        perf-profile.self.cycles-pp.__close
> >       0.11 ą  4%      +0.0        0.13 ą  4%  perf-profile.self.cycles-pp.link_path_walk
> >       0.01 ą200%      +0.0        0.06 ą  9%  perf-profile.self.cycles-pp.__virt_addr_valid
> >       0.75 ą  2%      +0.1        0.89 ą  3%  perf-profile.self.cycles-pp._raw_spin_lock
> >       0.00            +2.8        2.79 ą  5%  perf-profile.self.cycles-pp.fsnotify_open_perm
> >       0.05            +5.6        5.63 ą 10%  perf-profile.self.cycles-pp.rw_verify_area
> >
> >
> > ***************************************************************************************************
> > lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
> >   gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/fsbuffer-r/unixbench
> >
> > commit:
> >   477cf917dd ("fsnotify: use an enum for group priority constants")
> >   a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")
> >
> > 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    1339661            +6.4%    1425877        unixbench.throughput
> >  5.765e+08            +6.4%  6.131e+08        unixbench.workload
> >  1.159e+09            +2.2%  1.184e+09        perf-stat.i.branch-instructions
> >       1.49            +0.0        1.54        perf-stat.i.branch-miss-rate%
> >   10449249 ą  2%      +6.7%   11149426        perf-stat.i.branch-misses
> >       4514            -5.3%       4273        perf-stat.overall.path-length
> >  1.156e+09            +2.2%  1.181e+09        perf-stat.ps.branch-instructions
> >   10430168 ą  2%      +6.7%   11128869        perf-stat.ps.branch-misses
> >       7.02 ą  2%      -3.3        3.70 ą  3%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.45 ą  3%      +0.2        1.62 ą  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
> >       1.24 ą  3%      +0.2        1.44 ą  3%  perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.filemap_read.vfs_read
> >       2.55 ą  8%      +0.4        2.91 ą  4%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
> >       3.04 ą  6%      +0.4        3.44 ą  3%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
> >       1.94 ą  9%      +0.5        2.42 ą  3%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >       8.62 ą  3%      +0.5        9.14        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
> >       7.90 ą  2%      +0.6        8.51        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
> >       9.29 ą  2%      +0.8       10.04        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
> >       4.43 ą  7%      +0.8        5.28 ą  2%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
> >      29.04 ą  3%      +1.8       30.80        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       7.06 ą  2%      -3.3        3.73 ą  3%  perf-profile.children.cycles-pp.__fsnotify_parent
> >       0.77 ą  6%      +0.1        0.88 ą  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
> >       1.26 ą  2%      +0.2        1.45 ą  3%  perf-profile.children.cycles-pp.current_time
> >       1.66 ą  3%      +0.2        1.90 ą  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
> >       3.72 ą  2%      +0.3        4.03        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       2.56 ą  7%      +0.4        2.91 ą  4%  perf-profile.children.cycles-pp.apparmor_file_permission
> >       5.72 ą  2%      +0.4        6.08        perf-profile.children.cycles-pp.entry_SYSCALL_64
> >       4.40 ą  4%      +0.4        4.81 ą  2%  perf-profile.children.cycles-pp.rep_movs_alternative
> >       3.10 ą  6%      +0.4        3.52 ą  3%  perf-profile.children.cycles-pp.security_file_permission
> >       1.94 ą  9%      +0.5        2.42 ą  3%  perf-profile.children.cycles-pp.__fdget_pos
> >       8.68 ą  3%      +0.5        9.20        perf-profile.children.cycles-pp.filemap_get_pages
> >       8.37 ą  2%      +0.7        9.05        perf-profile.children.cycles-pp._copy_to_iter
> >       9.52 ą  2%      +0.8       10.28        perf-profile.children.cycles-pp.copy_page_to_iter
> >      29.25 ą  3%      +1.7       30.99        perf-profile.children.cycles-pp.filemap_read
> >       6.94            -3.2        3.72 ą  3%  perf-profile.self.cycles-pp.__fsnotify_parent
> >       0.77 ą  6%      +0.1        0.88 ą  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
> >       0.83 ą  5%      +0.1        0.97 ą  7%  perf-profile.self.cycles-pp.current_time
> >       1.66 ą  3%      +0.2        1.90 ą  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
> >       3.52 ą  2%      +0.2        3.76        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       2.42 ą  3%      +0.3        2.67 ą  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
> >       1.92 ą  6%      +0.3        2.20 ą  5%  perf-profile.self.cycles-pp.apparmor_file_permission
> >       3.92 ą  4%      +0.3        4.25 ą  2%  perf-profile.self.cycles-pp.rep_movs_alternative
> >       4.38            +0.3        4.72 ą  2%  perf-profile.self.cycles-pp._copy_to_iter
> >       1.16 ą  8%      +0.3        1.51 ą  2%  perf-profile.self.cycles-pp.ksys_read
> >       1.85 ą 10%      +0.5        2.36 ą  2%  perf-profile.self.cycles-pp.__fdget_pos
> >
> >
> >
> > ***************************************************************************************************
> > lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
> >   gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/fstime-r/unixbench
> >
> > commit:
> >   477cf917dd ("fsnotify: use an enum for group priority constants")
> >   a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")
> >
> > 477cf917dd02853b a5e57b4d370c6d320e5bfb0c919
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    4709035            +5.8%    4980152        unixbench.throughput
> >  2.026e+09            +5.7%  2.141e+09        unixbench.workload
> >  1.034e+09            +1.4%  1.048e+09        perf-stat.i.branch-instructions
> >       1.56            +0.0        1.59        perf-stat.i.branch-miss-rate%
> >   60950726            +5.3%   64193405        perf-stat.i.cache-references
> >       0.02 ą 30%     -36.7%       0.01 ą 39%  perf-stat.i.major-faults
> >       0.78            -0.0        0.75        perf-stat.overall.cache-miss-rate%
> >       1145            -5.4%       1083        perf-stat.overall.path-length
> >  1.031e+09            +1.4%  1.046e+09        perf-stat.ps.branch-instructions
> >   60812120            +5.3%   64047513        perf-stat.ps.cache-references
> >       0.02 ą 30%     -36.7%       0.01 ą 39%  perf-stat.ps.major-faults
> >       6.22 ą  3%      -2.9        3.30 ą  3%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      49.43            -1.5       47.90        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >      52.39            -1.0       51.34        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >      55.16            -0.9       54.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >      56.49            -0.7       55.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
> >       2.40 ą  4%      +0.2        2.64 ą  5%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_read
> >       2.59 ą  4%      +0.3        2.86 ą  5%  perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
> >       6.88            +0.3        7.23 ą  2%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
> >       2.26 ą  3%      +0.4        2.64 ą 10%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
> >       7.90 ą  3%      +0.4        8.29        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
> >       2.68 ą  2%      +0.4        3.13 ą  8%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
> >       8.47            +0.4        8.91        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
> >      32.80            +1.8       34.63        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       6.27 ą  3%      -2.9        3.34 ą  3%  perf-profile.children.cycles-pp.__fsnotify_parent
> >      49.50            -1.4       48.07        perf-profile.children.cycles-pp.vfs_read
> >      52.46            -1.0       51.45        perf-profile.children.cycles-pp.ksys_read
> >       1.16 ą  4%      +0.1        1.28 ą  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
> >       2.46 ą  4%      +0.2        2.69 ą  6%  perf-profile.children.cycles-pp.atime_needs_update
> >       5.03 ą  3%      +0.3        5.30        perf-profile.children.cycles-pp.entry_SYSCALL_64
> >       2.66 ą  4%      +0.3        2.94 ą  6%  perf-profile.children.cycles-pp.touch_atime
> >       3.27 ą  2%      +0.3        3.59        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       6.96            +0.4        7.31 ą  2%  perf-profile.children.cycles-pp.filemap_get_read_batch
> >       2.27 ą  3%      +0.4        2.64 ą 10%  perf-profile.children.cycles-pp.apparmor_file_permission
> >       2.76 ą  2%      +0.4        3.20 ą  7%  perf-profile.children.cycles-pp.security_file_permission
> >       8.52            +0.5        8.98        perf-profile.children.cycles-pp.filemap_get_pages
> >      32.99            +1.8       34.80        perf-profile.children.cycles-pp.filemap_read
> >       6.16 ą  3%      -2.8        3.32 ą  3%  perf-profile.self.cycles-pp.__fsnotify_parent
> >       1.19 ą  3%      -0.4        0.81 ą  6%  perf-profile.self.cycles-pp.rw_verify_area
> >       1.55 ą  3%      +0.1        1.64 ą  2%  perf-profile.self.cycles-pp.filemap_get_pages
> >       0.70 ą  3%      +0.1        0.81 ą  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
> >       1.31 ą  4%      +0.1        1.43 ą  4%  perf-profile.self.cycles-pp.do_syscall_64
> >       2.15 ą  4%      +0.1        2.28        perf-profile.self.cycles-pp.entry_SYSCALL_64
> >       4.00 ą  2%      +0.2        4.22        perf-profile.self.cycles-pp.read
> >       1.06 ą  4%      +0.3        1.31 ą  5%  perf-profile.self.cycles-pp.ksys_read
> >       3.09 ą  2%      +0.3        3.36        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       3.89 ą  2%      +0.3        4.19 ą  3%  perf-profile.self.cycles-pp._copy_to_iter
> >       1.66 ą  2%      +0.3        2.01 ą 13%  perf-profile.self.cycles-pp.apparmor_file_permission
> >
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

