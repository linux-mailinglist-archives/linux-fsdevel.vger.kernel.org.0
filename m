Return-Path: <linux-fsdevel+bounces-62615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE84B9B1F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03DB4E2D20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C2314B71;
	Wed, 24 Sep 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsC/9rht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F722068B;
	Wed, 24 Sep 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736257; cv=none; b=q5KR5iIoJNL8547kYTQRz27N9IXHcbGW1U3tW+kYSm6b/KPPeYonEhJ9w2EC+RuY5xehPD6Gnd6+OfN4DyO3XXkJEUQgkGn1e/10qUBru5yACLU5rBAU/paaRBh+8KDBsmTdx21zBrNOU7MSp+5/FoUP6nmmPchrWWXcCVJQ+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736257; c=relaxed/simple;
	bh=mPI30sfIxB4Z9YJf25cmnacoN5+604ymyUksz+i0HLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxPp6YsSUrkTLQT6z/Leu4aBozBg3YvgX6hKk9pJ/FtWVJmtMt9FAWqFeGauuycjKWhy/qwKz+tH33VSisFKdY8mrAosNj0BJdhtxW60dwu2K7K+fUp5SMFPVLWrXUGIMyjFz3yHQ5BsYOgYfrI3QT4OQ/U5s3NdE+dQlxsVa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsC/9rht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9909C4CEE7;
	Wed, 24 Sep 2025 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758736256;
	bh=mPI30sfIxB4Z9YJf25cmnacoN5+604ymyUksz+i0HLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsC/9rht9rwkphL5ebFbJoKhX9nbh/W8C2NtcoZBtVkyipWwtz/IYhY8KnsPDF0/a
	 OoVbkvKSgY/YJJxUVIAmlaldRf/42bWheXhtUdxRxCAUDRvchNidZ6B6HhbezZVAjf
	 kyGU/zf+ZDOhJfzdUD24s3HYyL16JF93/g4sPFPa0FihdkENhhYaT2waFPwtyvStxi
	 dGhSnYax0NtqPjACOZyEgE+aIiB/W9xUV2VK1VyPtOiEVPc5mK1rBnvhXUvhPI7KX4
	 qRSrFBU53jfsWR35/hTLNX0XdSHUFdmgRXbPWgiDMKetig0MN2AkAZ3jy+pB1IcPLJ
	 JB8HIZJY5BUGA==
Date: Wed, 24 Sep 2025 10:50:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250924175056.GO8117@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs>
 <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs>
 <20250923223447.GJ1587915@frogsfrogsfrogs>
 <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>

On Wed, Sep 24, 2025 at 02:04:20PM +0200, Miklos Szeredi wrote:
> On Wed, 24 Sept 2025 at 00:34, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Conclusion: The loop is necessary to avoid softlockup warnings while the
> > fuse requests are processed by the server, but it is not necessary to
> > touch the watchdog in the loop body.
> 
> I'm still confused.
> 
> What is the kernel message you get?
> 
> "watchdog: BUG: soft lockup - CPU#X stuck for NNs!"
> 
> or
> 
> "INFO: task PROC blocked for more than NN seconds."

Oh!  The second:

INFO: task umount:1279 blocked for more than 20 seconds.
      Not tainted 6.17.0-rc7-xfsx #rc7
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690
Call Trace:
 <TASK>
 __schedule+0x4cb/0x1a70
 ? vprintk_emit+0x10e/0x330
 schedule+0x2a/0xe0
 fuse_flush_requests_and_wait+0xe5/0x110 [fuse 810ab4024704e943aea18e16]
 ? cpuacct_css_alloc+0xa0/0xa0
 fuse_iomap_unmount+0x15/0x30 [fuse 810ab4024704e943aea18e1670e01b473ed]
 fuse_conn_destroy+0xdb/0xe0 [fuse 810ab4024704e943aea18e1670e01b473ed1]
 fuse_kill_sb_anon+0xb7/0xc0 [fuse 810ab4024704e943aea18e1670e01b473ed1]
 deactivate_locked_super+0x29/0xa0
 cleanup_mnt+0xbd/0x150
 task_work_run+0x55/0x90
 exit_to_user_mode_loop+0xa0/0xb0
 do_syscall_64+0x16b/0x1a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f24c342ab77
RSP: 002b:00007ffd683ce5e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00005648fc1208a8 RCX: 00007f24c342ab77
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005648fc1209c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f24c3566264
R13: 00005648fc1209c0 R14: 0000000000000000 R15: 00005648fc120790
 </TASK>

Apologies for my imprecise description of what I was trying to avoid; I
should have paid closer attention.

The wait_event_timeout() loop causes the process to schedule at least
once per second, which avoids the "blocked for more than..." warning.
Since the process actually does go to sleep, it's not necessary to touch
the softlockup watchdog because we're not preventing another process
from being scheduled on a CPU.

I can copy the above into the commit message if that resolves the
confusion.

--D

> Thanks,
> Miklos

