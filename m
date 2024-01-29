Return-Path: <linux-fsdevel+bounces-9289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65A83FCE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574472825F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAD10979;
	Mon, 29 Jan 2024 03:40:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D110A03;
	Mon, 29 Jan 2024 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499657; cv=none; b=obUl0Z0cyL9+gKtq+aYIZhL+b0W7IUYLtXDyp7fzgf6H1zKYr/U2WSV7hLP5UV/ZQtG7QU1cIqvg3LYfcdBpqfujMiHsHE9F5OT8+z7dnfpe2vCc6fGlRWLE2xQrfesMfnmrsGZ7a6vFRUL/w+vyd82iNydC7fS5w5AcAeL3Eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499657; c=relaxed/simple;
	bh=Oz2gMS5fifJ1NkkC+E9odJnrcDRFtlzSRsNITi9/COg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfI3gusuSHOHzqOigOb8sEaVVXkCgM6e0nKLi67y6gc4FuqZemv92GpwbhYJjyZp8+5pAtgl46n8a1xoswh7zbBROeVOp76LStB4NFPru5zFyUclXalpotwl8lMkQjKwBYXl1reCQja2+1+VsEsoQv9PvFB9vwqUDPwIgyLQ/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF53C433C7;
	Mon, 29 Jan 2024 03:40:56 +0000 (UTC)
Date: Sun, 28 Jan 2024 22:40:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128224054.0df489b8@rorschach.local.home>
In-Reply-To: <20240128213249.605a7ade@rorschach.local.home>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128175111.69f8b973@rorschach.local.home>
	<CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
	<20240128185943.6920388b@rorschach.local.home>
	<20240128192108.6875ecf4@rorschach.local.home>
	<CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
	<CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
	<20240128213249.605a7ade@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 21:32:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  # echo 'p:sched schedule' >> kprobe_events
>  # ls events/kprobes
> enable  filter  sched  timer
> 
>  # ls events/kprobes/sched/
> ls: reading directory 'events/kprobes/sched/': Invalid argument
> 
> I have no access to the directory that was deleted and recreated.

Ah, this was because the final iput() does dentry->d_fsdata = NULL, and
in the lookup code I have:


	mutex_lock(&eventfs_mutex);
	ei = READ_ONCE(ti->private);
	if (ei && ei->is_freed)
		ei = NULL;
	mutex_unlock(&eventfs_mutex);

	if (!ei) {
		printk("HELLO no ei\n");
		goto out;
	}

Where that printk() was triggering.

So at least it's not calling back into the tracing code ;-)

Interesting that it still did the lookup, even though it was already
referenced.

I'm still learning the internals of VFS.

Anyway, after keeping the d_fsdata untouched (not going to NULL), just
to see what would happen, I ran it again with KASAN and did trigger:

[  106.255468] ==================================================================
[  106.258400] BUG: KASAN: slab-use-after-free in tracing_open_file_tr+0x3a/0x120
[  106.261228] Read of size 8 at addr ffff8881136f27b8 by task cat/868

[  106.264506] CPU: 2 PID: 868 Comm: cat Not tainted 6.8.0-rc1-test-00008-gbee668990ac4-dirty #454
[  106.267810] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  106.271337] Call Trace:
[  106.272406]  <TASK>
[  106.273317]  dump_stack_lvl+0x5c/0xc0
[  106.274750]  print_report+0xcf/0x670
[  106.276173]  ? __virt_addr_valid+0x15a/0x330
[  106.278807]  kasan_report+0xd8/0x110
[  106.280172]  ? tracing_open_file_tr+0x3a/0x120
[  106.281745]  ? tracing_open_file_tr+0x3a/0x120
[  106.283343]  tracing_open_file_tr+0x3a/0x120
[  106.284887]  do_dentry_open+0x3b7/0x950
[  106.286284]  ? __pfx_tracing_open_file_tr+0x10/0x10
[  106.287992]  path_openat+0xea8/0x11d0


That was with just these commands:

  cd /sys/kernel/tracing/
  echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events 
  echo 'p:timer read_current_timer' >> kprobe_events 
  ls events/kprobes/
  cat events/kprobes/sched/enable
  ls events/kprobes/sched
  echo '-:sched schedule' >> /sys/kernel/tracing/kprobe_events 
  ls events/kprobes/sched/enable
  cat events/kprobes/sched/enable

BTW, the ls after the deletion returned:

 # ls events/kprobes/sched/enable
 events/kprobes/sched/enable

In a normal file system that would be equivalent to:

 # mkdir events/kprobes/sched
 # touch events/kprobes/sched/enable
 # rm -rf events/kprobes/sched
 # ls events/kprobes/sched/enable
 events/kprobes/sched/enable

-- Steve

