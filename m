Return-Path: <linux-fsdevel+bounces-44333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF20A67864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416FE19C07BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86A210185;
	Tue, 18 Mar 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDRtp2xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D920F078;
	Tue, 18 Mar 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313078; cv=none; b=WzIjMIZyA9lP/t/6fZuhNwSpNKS7spUwj7fkttLfzlbKFL2CMglE+9WGJbudXegYcxDqjGlyzU/OCBTJ7pRuVDcNcurMcGKntZ6xhGjqJa7GhV24AI6ubHhZ96zcCOhnv0Vp5Zy6cjpFm5UWqH+qa+AELCPbay/zDGm+yNUZlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313078; c=relaxed/simple;
	bh=cUwvZQQ+NjakBpbZKcTfx3t1d3Z+pAZHSuUAZGVxDxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou+ioyszzn2Kb2W/lVZwlSbzdjAljXqKGjkdOtVSvyiQQ0gfupmIZhTMsHmd0MjYUJ4KZAi+lWzAS7h+YwlLHb9tK1g2ou8nCpmWznn/rqDRl0TgWtT9J2TBdE25tuT374nXdhwZQ6MwMOMva3uasKIVK5ZE+DYq5jL/eLCFPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDRtp2xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB81C4CEDD;
	Tue, 18 Mar 2025 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742313078;
	bh=cUwvZQQ+NjakBpbZKcTfx3t1d3Z+pAZHSuUAZGVxDxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDRtp2xuLYROQzbQK0ZXRpd/eWbvAUBk+xosqGBpv4QyNuXbt5tWpBrOCCdXzKHRh
	 dgnAXbktka2ZLS25yb09k+fyai7woE9wmk4uPzhKSYeDWFLAB2Du05CZBd0ujHnXOP
	 GfRPFvWNYW0M+LiXAnL1PbpMA1haUl885t/s2xrFPKWfq6ns/MwHOuOMPmuQXZ0SwE
	 x9RrEmMNgy4p6j5tyYwkvRHYyPj+T8oF68TqrXf5wNnDIgsKpLMCrmn4AiW7NgeitG
	 IdNBoBHj/ri2USwpaTRwW2SaQ6fKw+AHJpm8PvrDfg9cWgqYq079CIUcfjUM8Uc3fr
	 xW9pmgpkWQPOQ==
Date: Tue, 18 Mar 2025 08:51:14 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Bhupesh <bhupesh@igalia.com>,
	akpm@linux-foundation.org, kernel-dev@igalia.com,
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
Message-ID: <202503180846.EAB79290D@keescook>
References: <20250314052715.610377-1-bhupesh@igalia.com>
 <202503141420.37D605B2@keescook>
 <a73ea646-0a24-474a-9e14-d59ea5eaa662@gmail.com>
 <8b11d5f6-bb16-7af6-8377-bb0951fcfb60@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b11d5f6-bb16-7af6-8377-bb0951fcfb60@igalia.com>

On Tue, Mar 18, 2025 at 04:49:28PM +0530, Bhupesh Sharma wrote:
> On 3/15/25 1:13 PM, Andres Rodriguez wrote:
> > On 3/14/25 14:25, Kees Cook wrote:
> > > On Fri, Mar 14, 2025 at 10:57:13AM +0530, Bhupesh wrote:
> > > > While working with user-space debugging tools which work especially
> > > > on linux gaming platforms, I found that the task name is truncated due
> > > > to the limitation of TASK_COMM_LEN.
> > > > 
> > > > For example, currently running 'ps', the task->comm value of a long
> > > > task name is truncated due to the limitation of TASK_COMM_LEN.
> > > >      create_very_lon
> > > > 
> > > > This leads to the names passed from userland via pthread_setname_np()
> > > > being truncated.
> > > 
> > > So there have been long discussions about "comm", and it mainly boils
> > > down to "leave it alone". For the /proc-scraping tools like "ps" and
> > > "top", they check both "comm" and "cmdline", depending on mode. The more
> > > useful (and already untruncated) stuff is in "cmdline", so I suspect it
> > > may make more sense to have pthread_setname_np() interact with that
> > > instead. Also TASK_COMM_LEN is basically considered userspace ABI at
> > > this point and we can't sanely change its length without breaking the
> > > world.
> > > 
> > 
> > Completely agree that comm is best left untouched. TASK_COMM_LEN is
> > embedded into the kernel and the pthread ABI changes here should be
> > avoided.
> > 
> 
> So, basically my approach _does not_ touch TASK_COMM_LEN at all. The normal
> 'TASK_COMM_LEN' 16byte design remains untouched.
> Which means that all the legacy / existing ABi which uses 'task->comm' and
> hence are designed / written to handle 'TASK_COMM_LEN' 16-byte name,
> continue to work as before using '/proc/$pid/task/$tid/comm'.
> 
> This change-set only adds a _parallel_ dynamically allocated
> 'task->full_name' which can be used by interested users via
> '/proc/$pid/task/$tid/full_name'.

I don't want to add this to all processes at exec time as the existing
solution works for those processes: read /proc/$pid/cmdline.

That said, adding another pointer to task_struct isn't to bad I guess,
and it could be updated by later calls. Maybe by default it just points
to "comm".

> I am fine with adding either '/proc/$pid/task/$tid/full_name' or
> '/proc/$pid/task/$tid/debug_name' (actually both of these achieve the same).
> The new / modified users (especially the debug applications you listed
> above) can switch easily to using '/proc/$pid/task/$tid/full_name' instead
> of ''/proc/$pid/task/$tid/comm'
> 
> AFAIK we already achieved for the kthreads using d6986ce24fc00 ("kthread:
> dynamically allocate memory to store kthread's full name"), which adds
> 'full_name' in parallel to 'comm' for kthread names.

If we do this for task_struct, we should remove "full_name" from kthread
and generalize it for all processes.

-- 
Kees Cook

