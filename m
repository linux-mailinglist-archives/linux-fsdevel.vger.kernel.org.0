Return-Path: <linux-fsdevel+bounces-24085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3C939274
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DE61F227E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FA16EB63;
	Mon, 22 Jul 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAVAsc4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D432907;
	Mon, 22 Jul 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665493; cv=none; b=aE46ChwBwJ1/6/oCFx+DWW9/Tq5qX0uaFzWzC+Ja158YkHIEjuBOgcVNysFmBZsMepCnl4VYQqXaaIB+y7qRL9Q6f4iM8D/+cAMiG5I7amYWJOgKzRDsJHj0O5cO+qxJh0DZiQ3iNTZAY9jbu8jcy2ZJ8AbAEag2TClYryQkw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665493; c=relaxed/simple;
	bh=qYT6j/I3syHmyDZlCnzo5vlh9AeUyx3BeW7uSWEgkt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv+lNwb9Nyoxf6VyZ80QFD0PMiIEeXVjgPSVNaZUnSL9I+8CfvbJd4N58SLffa+vIFmkPleQZethHQ+6xFMcGZZ102aTJf1yBlQCYvfCxrd0rTuVy6T+8M9g5euu8IRRrFWz6pBZ44XxKPuKJi3S6bGM1J0y298vsPdQQL+S9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAVAsc4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94354C116B1;
	Mon, 22 Jul 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721665493;
	bh=qYT6j/I3syHmyDZlCnzo5vlh9AeUyx3BeW7uSWEgkt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAVAsc4SWu3K55rjnTpHqA8x2+J76wYP7R4MaPnFw3Yp9b2JKklizcCBhjBzSWnl9
	 MimDQUtyo5KhNm/7y4uSzRg5kdY0jtGO/Dnz3NJ4dsgbBz33ieO/n+6nTyFZV9o5Z7
	 dgPDv6WevV9+p0/UzduIfjPGv2hjDfU55er5Fd+Q=
Date: Mon, 22 Jul 2024 18:24:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] tty: tty_io: fix race between tty_fops and
 hung_up_tty_fops
Message-ID: <2024072238-reversing-despise-b555@gregkh>
References: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>
 <20240722-gehminuten-fichtenwald-9dd5a7e45bc5@brauner>
 <20240722161041.t6vizbeuxy5kj4kz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722161041.t6vizbeuxy5kj4kz@quack3>

On Mon, Jul 22, 2024 at 06:10:41PM +0200, Jan Kara wrote:
> On Mon 22-07-24 16:41:22, Christian Brauner wrote:
> > On Fri, Jul 19, 2024 at 10:37:47PM GMT, Tetsuo Handa wrote:
> > > syzbot is reporting data race between __tty_hangup() and __fput(), and
> > > Dmitry Vyukov mentioned that this race has possibility of NULL pointer
> > > dereference, for tty_fops implements e.g. splice_read callback whereas
> > > hung_up_tty_fops does not.
> > > 
> > >   CPU0                                  CPU1
> > >   ----                                  ----
> > >   do_splice_read() {
> > >                                         __tty_hangup() {
> > >     // f_op->splice_read was copy_splice_read
> > >     if (unlikely(!in->f_op->splice_read))
> > >       return warn_unsupported(in, "read");
> > >                                           filp->f_op = &hung_up_tty_fops;
> > >     // f_op->splice_read is now NULL
> > >     return in->f_op->splice_read(in, ppos, pipe, len, flags);
> > >                                         }
> > >   }
> > > 
> > > Fix possibility of NULL pointer dereference by implementing missing
> > > callbacks, and suppress KCSAN messages by adding __data_racy qualifier
> > > to "struct file"->f_op .
> > 
> > This f_op replacing without synchronization seems really iffy imho.
> 
> Yeah, when I saw this I was also going "ouch". I was just waiting whether a
> tty maintainer will comment ;)

I really didn't want to :)

> Anyway this replacement of ops in file /
> inode has proven problematic in almost every single case where it was used
> leading to subtle issues.

Yeah, let's not do this.

Let me dig after -rc1 is out and see if there's a better way to handle
this contrived race condition...

thanks,

greg k-h

