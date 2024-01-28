Return-Path: <linux-fsdevel+bounces-9265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4383FA4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C51F22681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E63C496;
	Sun, 28 Jan 2024 22:17:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC23C46B;
	Sun, 28 Jan 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480256; cv=none; b=FXhVTl3iFox2q5NaoSi4sVm91Y3sc8sbS0YOgNEk7t4A28ernq0IlN/TAMijuKcU9Zpa0J+OfG674yUCXOheOWkr2W27s/ESB0Y+NGJ0NBP15aHpumPeCkzEX8YP5rq+2uZgVaAPEwU9OgKBkkCYIcqMmTeERZLgerGGhIxjeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480256; c=relaxed/simple;
	bh=BUSERkOvlG2VoJBGGXoB3teG6OEEWG8bRMj3RwYf988=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+RPg/9FwgDC/PzdwV6rG51arrO5ImCTVhp9/6SBLe3IIXYGejEKiyiTrUwHnLT5vyw72/4H6WsX5EWP3ztIecxGeg+U4dN2jEwLx60lNbiN2V1I78OCOeMu3Vbj264/+pOOST83/se5PJO/5c2f5q5P9DXxOTYvZ1vw8NYxObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A581C433C7;
	Sun, 28 Jan 2024 22:17:34 +0000 (UTC)
Date: Sun, 28 Jan 2024 17:17:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128171733.2ba41226@rorschach.local.home>
In-Reply-To: <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128151542.6efa2118@rorschach.local.home>
	<CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
	<20240128161935.417d36b3@rorschach.local.home>
	<CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
	<CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 14:07:49 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Jan 2024 at 13:43, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That's just wrong.
> >
> > Either you look things up under your own locks, in which case the SRCU
> > dance is unnecessary and pointless.
> >
> > Or you use refcounts.
> >
> > In which case SRCU is also unnecessary and pointless.  
> 
> So from what I can see, you actually protect almost everything with
> the eventfs_mutex, but the problem is that you then occasionally drop
> that mutex in the middle.
> 
> The one valid reason for dropping it is the readdir callback, which
> does need to write to user space memory.
> 
> But no, that's not a valid reason to use SRCU. It's a very *bad*
> reason to use SRCU.
> 
> The thing is, you can fix it two ways:
> 
>  - either refcount things properly, ie when you do that lookup under your lock:
> 
>         mutex_lock(&eventfs_mutex);
>         ei = READ_ONCE(ti->private);
>         if (ei && ei->is_freed)
>                 ei = NULL;
>         mutex_unlock(&eventfs_mutex);
> 
>    you just go "I now have a ref" to the ei, and you increment the
> refcount like you should, and then you dcrement it at the end when
> you're done.
> 
> Btw, what's with the READ_ONCE()? You have locking.
> 
> The other option is to simply re-lookup the ei when you re-get the
> eventfs_mutext anyway.
> 
> Either of those cases, and the SRCU is entirely pointless. It  really
> looks wrong, because you seem to take that eventfs_mutex everywhere
> anyway.

The original code just used the mutex, but then we were hitting
deadlocks because we used the mutex in the iput() logic. But this could
have been due to the readdir logic causing the deadlocks.

A lot of the design decisions were based on doing the dentry creation
in the readdir code. Now that it's no longer there, I could go back and
try taking the eventfs_mutex for the entirety of the lookup and see if
lockdep complains again about also using it in the iput logic.

Then yes, we can get rid of the SRCU as that was added as a way to get
out of that deadlock.

-- Steve

