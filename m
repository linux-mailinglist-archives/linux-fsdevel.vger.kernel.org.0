Return-Path: <linux-fsdevel+bounces-44047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D77A61E05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E751B61D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E381F4622;
	Fri, 14 Mar 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHbdSpqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4882BA38;
	Fri, 14 Mar 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987513; cv=none; b=o/HNv9UkFZxh0xqYRFP1Y/0s0c9Uo//ArrFynpwH7B9xDejP9WVm1LJYv5D5CUk1Mu3PwmXeCcCtFFK8eyxurzWuRJNLaQrc2+eyrXxt9mvlKssTOdj//bMOXY/5Tgnv+wPjGMqEzH6OypkItaJTe2zNIWlrTAl9g77dJ+MdsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987513; c=relaxed/simple;
	bh=M3SHrQc2tgax4mt/YEgx/NFPdqYF7jJQHZUWCW+0P/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpIEmCZVzG2xxY5HkvfIVOtr5bKiC3k0+FfDdy8zg40xnVva07yFSK+3uOn9+7koj1C1E/Ry5Mxr/WfdOpjox/Vu31fd9TvGOk/Hue9kEY7z8kovAMdHmM2zjpQNsP9ARW1EfOIvPBscbUBdjGn4EM4ANug+h0cTUA0+hwLcus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHbdSpqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59417C4CEE3;
	Fri, 14 Mar 2025 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741987512;
	bh=M3SHrQc2tgax4mt/YEgx/NFPdqYF7jJQHZUWCW+0P/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHbdSpqhJwpTWDnjBe+rRqKqM7d69+KpBrghiH1jALmo2Ut7w+OVrQL+sNv6Szxi3
	 326GF/RFWeGbSfojoa1iRmH1e7HVgus6eRaDlrVhBRRIOdPIoAFPatBfvhS92VXWHJ
	 QVH2M8EN7oGslP8w9dE9LQ+RA6ZZOIOWVi1bw4Myr/7hXZYcfFlyNDSBb/rMl4jTKJ
	 DFZ6djxsBIhKMrp3Q6ie8mWWryGtqQUoFHQGOrIltE6/GlBzGUI7f3V3+nvNrMGs6E
	 9VVwk4rbaMUINBV5HFEwsyIERc35iE2ypjJX4nlkDl/JYa+NmQ3Ds42gw13g64mQMi
	 O2Mar20c9eNBw==
Date: Fri, 14 Mar 2025 14:25:09 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH RFC 0/2] Dynamically allocate memory to store task's full
 name
Message-ID: <202503141420.37D605B2@keescook>
References: <20250314052715.610377-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314052715.610377-1-bhupesh@igalia.com>

On Fri, Mar 14, 2025 at 10:57:13AM +0530, Bhupesh wrote:
> While working with user-space debugging tools which work especially
> on linux gaming platforms, I found that the task name is truncated due
> to the limitation of TASK_COMM_LEN.
> 
> For example, currently running 'ps', the task->comm value of a long
> task name is truncated due to the limitation of TASK_COMM_LEN.
>     create_very_lon
> 
> This leads to the names passed from userland via pthread_setname_np()
> being truncated.

So there have been long discussions about "comm", and it mainly boils
down to "leave it alone". For the /proc-scraping tools like "ps" and
"top", they check both "comm" and "cmdline", depending on mode. The more
useful (and already untruncated) stuff is in "cmdline", so I suspect it
may make more sense to have pthread_setname_np() interact with that
instead. Also TASK_COMM_LEN is basically considered userspace ABI at
this point and we can't sanely change its length without breaking the
world.

Best to use /proc/$pid/task/$tid/cmdline IMO...

-Kees

> will be shown in 'ps'. For example:
>     create_very_long_name_user_space_script.sh
> 
> Bhupesh (2):
>   exec: Dynamically allocate memory to store task's full name
>   fs/proc: Pass 'task->full_name' via 'proc_task_name()'
> 
>  fs/exec.c             | 21 ++++++++++++++++++---
>  fs/proc/array.c       |  2 +-
>  include/linux/sched.h |  9 +++++++++
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> -- 
> 2.38.1
> 

-- 
Kees Cook

