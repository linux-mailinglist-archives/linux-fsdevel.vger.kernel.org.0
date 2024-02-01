Return-Path: <linux-fsdevel+bounces-9796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E03844F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DB11F2161C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107FC3AC34;
	Thu,  1 Feb 2024 03:21:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5333DF;
	Thu,  1 Feb 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757674; cv=none; b=dX++stocZKYr92U7CL/wnD/fzqvjaqbf/5A1jH++Kd9Tu7zjszVjGp+xS/GYDY3uRy8XkBgodZaPrxgyj91MAKOWRROg8VXX1Jf5iwO/3B7mIGRj6KUn/xnnlvr0JyJapC4iZtonM3xzjSRfaPH1US/rKz9iEF5P7ZnwqcuLa4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757674; c=relaxed/simple;
	bh=Ot3wgC0bxq6Jp7mJAxkZM9efe6ruj/cl2hI17BeFrn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJAQpdOXBhKjc0chYMFhyJtEJ0tBoLjSgF2afN6WK/JlRFL94nrgSR3CwLCCq1PR5ofaaLVsAoWxPmVlqTeFLtsJJrQoqGlAyut1MeCTzytKTyfKmRGxj0tRD00wDz+ETXm6dGeanh/kDsdYqJtZ8UnVreo4kPI2ldyfswhtCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92F0C433F1;
	Thu,  1 Feb 2024 03:21:12 +0000 (UTC)
Date: Wed, 31 Jan 2024 22:21:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
Message-ID: <20240131222127.15b2731b@gandalf.local.home>
In-Reply-To: <20240201030205.GT2087318@ZenIV>
References: <20240131184918.945345370@goodmis.org>
	<20240131185512.799813912@goodmis.org>
	<20240201002719.GS2087318@ZenIV>
	<20240131212642.2e384250@gandalf.local.home>
	<20240201030205.GT2087318@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 03:02:05 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> > We had a problem here with just returning NULL. It leaves the negative
> > dentry around and doesn't get refreshed.  
> 
> Why would that dentry stick around?  And how would anyone find
> it, anyway, when it's not hashed?

We (Linus and I) got it wrong. It originally had:

	d_add(dentry, NULL);
	[..]
	return NULL;

and it caused the:


  # ls events/kprobes/sched/
ls: cannot access 'events/kprobes/sched/': No such file or directory

  # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events 
  # ls events/kprobes/sched/
ls: cannot access 'events/kprobes/sched/': No such file or directory

I just changed the code to simply return NULL, and it had no issues:

  # ls events/kprobes/sched/
ls: cannot access 'events/kprobes/sched/': No such file or directory

  # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events 
  # ls events/kprobes/sched/
enable  filter  format  hist  hist_debug  id  inject  trigger

But then I added the: d_add(dentry, NULL); that we originally had, and then
it caused the issue again.

So it wasn't the returning NULL that was causing a problem, it was calling
the d_add(dentry, NULL); that was.

I'll update the patch.

-- Steve

