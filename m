Return-Path: <linux-fsdevel+bounces-9286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B783FC40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5137285B62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D593EEDA;
	Mon, 29 Jan 2024 02:32:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28CF9D6;
	Mon, 29 Jan 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495573; cv=none; b=XET4rGEhxRoDjkNDV9WIcS7IzXgumrhLNzt8QPKfLAoiic+THDlzpKt4tzMEf2YqytnaoGPafofhF4QqHNw5hmqE6g/D+8nFk6iS0Jp2soiNxlfN6Be3A0/dReGrnB2FhhgZIkgljcV5fezWUJ9p3+Hr/05oCiwWSUvG84pJG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495573; c=relaxed/simple;
	bh=o63n5WMpln1TRFn0Kucd9NqGIM5xQz1xSMHbQaPz57Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBgRREvlveqz6ArDd2d7oegSGdWZLNHL1NhUqAPOI1OQpvTOgfWlbDkktA0VlEP7/+tjzcDplNjFJ6Q0qPe7ydVb+4xOpLfdGrAPGxpQWG4puz/bdrSWZiSkvj/kKNMGXAy9pAebxjkREPShk8xsyhk84qGn1muHiYKl3fIcDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A10C43390;
	Mon, 29 Jan 2024 02:32:50 +0000 (UTC)
Date: Sun, 28 Jan 2024 21:32:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128213249.605a7ade@rorschach.local.home>
In-Reply-To: <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 17:42:30 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 17:00, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >    mkdir dummy
> >    cd dummy
> >    echo "Hello" > hello
> >    ( sleep 10; cat ) < hello &
> >    rm hello
> >    cd ..
> >    rmdir dummy  
> 
> Note that it's worth repeating that simple_recursive_removal()
> wouldn't change any of the above. It only unhashes things and makes
> them *look* gone, doing things like clearing i_nlink etc.

I know, but I already cover the above case. And that case is not what
simple_recursive_removal() is covering.

I'm worried about what can be opened after a deletion. Not what has
already been opened. The simple_recrusive_removal() is the way to clear
the dcache on those files and directories that are being removed so
that no new references can happen on them.

So, I removed the simple_recursive_removal() from the code to see what
happened. Interesting, the opposite occurred.

 # cd /sys/kernel/tracing
 # echo 'p:sched schedule' > kprobe_events
 # ls events/kprobes
enable  filter  sched
 # ls events/kprobes/sched
enable  filter  format  hist  hist_debug  id  inject  trigger
 # cat events/kprobes/sched/enable
0

 # echo 'p:timer read_current_timer' >> kprobe_events
 # ls events/kprobes
enable  filter  sched  timer

Now delete just one kprobe (keeping the kprobes directory around)

 # echo '-:sched schedule' >> kprobe_events
 # ls events/kprobes/
enable  filter  timer

Now recreate that kprobe

 # echo 'p:sched schedule' >> kprobe_events
 # ls events/kprobes
enable  filter  sched  timer

 # ls events/kprobes/sched/
ls: reading directory 'events/kprobes/sched/': Invalid argument

I have no access to the directory that was deleted and recreated.

> 
> But those VFS data structures would still exist, and the files that
> had them open would still continue to be open.
> 
> So if you thought that simple_recursive_removal() would make the above
> kind of thing not able to happen, and that eventfs wouldn't have to
> deal with dentries that point to event_inodes that are dead, you were
> always wrong.

No but I want to shrink the dentries after the directory is removed.

Perhaps something else is the error here.

> 
> simple_recursive_removal() is mostly just lipstick on a pig. It does
> cause the cached dentries that have no active use be removed earlier,
> so it has that "memory pressure" kind of effect, but it has no real
> fundamental semantic effect.

I was using it to "flush" the cache on that directory. Nothing more.

> 
> Of course, for a filesystem where the dentry tree *is* the underlying
> data (ie the 'tmpfs' kind, but also things like debugfs or ipathfs,
> for example), then things are different.

Note, tracefs was built on debugfs. Only the "events" directory is
"different". The rest of /sys/kernel/tracing behaves exactly like
debugfs.

> 
> There the dentries are the primary thing, and not just a cache in
> front of the backing store.
> 
> But you didn't want that, and those days are long gone as far as
> tracefs is concerned.

Well, as long as eventfs is ;-)

-- Steve

