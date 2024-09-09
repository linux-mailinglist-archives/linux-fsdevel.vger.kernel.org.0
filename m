Return-Path: <linux-fsdevel+bounces-28929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6239712F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3858D1C224C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FD1B2ECF;
	Mon,  9 Sep 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVUgasGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D41B29AA;
	Mon,  9 Sep 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872876; cv=none; b=QrzaLQAfuaHw7qEEMkgTqiHl0Ip24GLAV6lXDG8h0GoTcnpXy8Y4oyNnY9xjJ9jCK2DjfQlmUS0PMNeg8NeJz6aiP9PXLWuAEViCZiI6O5/jdEOCYlzDvTUkOn+TBjT3aronkOEttcDFMHD4IdbMO1D75DuAlyBT+q/7S2ADGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872876; c=relaxed/simple;
	bh=V/slzjxF+QekQUJxEFMYqDh9AUHCyg0pmt1KtMEnvis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5wwPAnpb1P3bfVja5jW3Pvr4+alqxXlVlbHlxJELQqNsW0u30ruMRNU/NdbN3NU0BkmwnJx0DDvCaae5S4R4BYbRjJwC/Vj41mbLl3b4WM0+UhVreAoqPfv6276bH+Jhhy00pASphEuycxkmvMzsw/kihLPL4efL7TQwKjOYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVUgasGu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725872874; x=1757408874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/slzjxF+QekQUJxEFMYqDh9AUHCyg0pmt1KtMEnvis=;
  b=QVUgasGulJ8cJ5bIu82Zo7iOqy6LaKju2NjGqim+bfm2soh3GObihLAw
   s8/D5n2W68PRcs+0Wt4zy6FhatjpBN/Z+MiQ3Cy+L7M2Lxx9rXQibFo8Z
   xHbSmePniUx7ARKy1U0xvK8NbjO4AZax109QJK77ikT7c+G9xd7i9NeJH
   o47Ocner/PfVkNfop0VpxLZo+f84AMyLsD3pgPHxpO2856LDOBQNPg4eD
   NVp27jp3frzpYNaHmJGx3TxU4cN017+NcOSQA1pGNcqoqgfUGmOsJmwBz
   EbZrhEXHjSWHP628UjOBVtkx/jLKHRZajC8BnU6uL0ZeHKiS6X/M+cJgL
   Q==;
X-CSE-ConnectionGUID: cJCDaRU8Tz6k2PqqhepSxw==
X-CSE-MsgGUID: hWCLrRAqRyu+x6GXQzVr4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35906721"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35906721"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:07:54 -0700
X-CSE-ConnectionGUID: FdqRaOSaQlOJjszMXka2Lg==
X-CSE-MsgGUID: YPmk04xxQmWs0pRaAdrmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71008760"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:07:49 -0700
Date: Mon, 9 Sep 2024 17:06:37 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>,
	pengfei.xu@intel.com
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <Zt66nWAon7ue5xnw@ly-workstation>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <ZtqmtjZ+mVTDx208@ly-workstation>
 <20240906080120.q6xff2odea3ay4k7@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906080120.q6xff2odea3ay4k7@quentin>

Hi,

I have tried running the repro.c for 1 hour using next-20240905 kernel. Issue
cannot be reproduced.

Thank you.

Regards,
Yi Lai

On Fri, Sep 06, 2024 at 08:01:20AM +0000, Pankaj Raghav (Samsung) wrote:
> On Fri, Sep 06, 2024 at 02:52:38PM +0800, Lai, Yi wrote:
> Hi Yi,
> 
> > 
> > I used Syzkaller and found that there is task hang in soft_offline_page in Linux-next tree - next-20240902.
> 
> I don't know if it is related, but we had a fix for this commit for a
> ltp failure due to locking issues that is there in next-20240905 but not
> in next-20240902.
> 
> Fix: https://lore.kernel.org/linux-next/20240902124931.506061-2-kernel@pankajraghav.com/
> 
> Is this reproducible also on next-20240905?
> 
> > 
> > After bisection and the first bad commit is:
> > "
> > fd031210c9ce mm: split a folio in minimum folio order chunks
> > "
> > 
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240904_155526_soft_offline_page/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/f633dcbc3a8e4ca5f52f0110bc75ff17d9885db4/240904_155526_soft_offline_page/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240904_155526_soft_offline_page/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log
> > 
> > "
> > [  447.976688]  ? __pfx_soft_offline_page.part.0+0x10/0x10
> > [  447.977255]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> > [  447.977858]  soft_offline_page+0x97/0xc0
> > [  447.978281]  do_madvise.part.0+0x1a45/0x2a30
> > [  447.978742]  ? __pfx___lock_acquire+0x10/0x10
> > [  447.979227]  ? __pfx_do_madvise.part.0+0x10/0x10
> > [  447.979716]  ? __this_cpu_preempt_check+0x21/0x30
> > [  447.980225]  ? __this_cpu_preempt_check+0x21/0x30
> > [  447.980729]  ? lock_release+0x441/0x870
> > [  447.981160]  ? __this_cpu_preempt_check+0x21/0x30
> > [  447.981656]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> > [  447.982321]  ? lockdep_hardirqs_on+0x89/0x110
> > [  447.982771]  ? trace_hardirqs_on+0x51/0x60
> > [  447.983191]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> > [  447.983819]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> > [  447.984282]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> > [  447.984673]  __x64_sys_madvise+0x139/0x180
> > [  447.984997]  x64_sys_call+0x19a5/0x2140
> > [  447.985307]  do_syscall_64+0x6d/0x140
> > [  447.985600]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  447.986011] RIP: 0033:0x7f782623ee5d
> > [  447.986248] RSP: 002b:00007fff9ddaffb8 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
> > [  447.986709] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f782623ee5d
> > [  447.987147] RDX: 0000000000000065 RSI: 0000000000003000 RDI: 0000000020d51000
> > [  447.987584] RBP: 00007fff9ddaffc0 R08: 00007fff9ddafff0 R09: 00007fff9ddafff0
> > [  447.988022] R10: 00007fff9ddafff0 R11: 0000000000000217 R12: 00007fff9ddb0118
> > [  447.988428] R13: 0000000000401716 R14: 0000000000403e08 R15: 00007f782645d000
> > [  447.988799]  </TASK>
> > [  447.988921]
> > [  447.988921] Showing all locks held in the system:
> > [  447.989237] 1 lock held by khungtaskd/33:
> > [  447.989447]  #0: ffffffff8705c500 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
> > [  447.989947] 1 lock held by repro/628:
> > [  447.990144]  #0: ffffffff87258a28 (mf_mutex){+.+.}-{3:3}, at: soft_offline_page.part.0+0xda/0xf40
> > [  447.990611]
> > [  447.990701] =============================================
> > 
> > "
> > 
> > I hope you find it useful.
> > 
> > Regards,
> > Yi Lai
> > 

