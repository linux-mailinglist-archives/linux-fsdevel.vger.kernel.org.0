Return-Path: <linux-fsdevel+bounces-9112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0183E41C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912C4282ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1224B2B;
	Fri, 26 Jan 2024 21:42:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E924A02;
	Fri, 26 Jan 2024 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305329; cv=none; b=d9CEXaXKag5CxuGiOFyEWFOtLOrTkcbo0Ds+0u4PqfDmIaONG+ghKUy4HJsLcwic6Z6NrIzwId6YlAljNmaS237H45JsgI+bkKn+KKLEYFVuYBjulKCMKloeLhTDPyDm+EvsGskdzVTcin4SgD0FsdPAr117qhXTxw41LrKFk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305329; c=relaxed/simple;
	bh=M+qWWIk9HH5ZKtcGJLB0VA1tZ9Q0fzWbKtbJsBsOrBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coqye95NkaaJqbRaC0CeaOZnjBGvvW1iSal4mjXNRxWZ+N9iR8zJEUWXrpc1nCufKZZgSzqq3QUjANHbXzxNrIDxb/HLRZ0oKhNfk54LvsW/NgyX3koymCC2QEyXqkBQXpM9c/gvHR8FQkm3XRY90yzuL9O1QFxX+7AzYgSsYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EFBC433C7;
	Fri, 26 Jan 2024 21:42:07 +0000 (UTC)
Date: Fri, 26 Jan 2024 16:42:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240126164206.637ba8bd@rorschach.local.home>
In-Reply-To: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 13:36:20 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 26 Jan 2024 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'd be happy to change that patch to what I originally did before deciding
> > to copy get_next_ino():
> >
> > unsigned int tracefs_get_next_ino(int files)
> > {
> >         static atomic_t next_inode;
> >         unsigned int res;
> >
> >         do {
> >                 res = atomic_add_return(files + 1, &next_inode);
> >
> >                 /* Check for overflow */
> >         } while (unlikely(res < files + 1));
> >
> >         return res - files;  
> 
> Still entirely pointless.
> 
> If you have more than 4 billion inodes, something is really really wrong.

No, but you can trivially make a loop that creates and destroys
directories that will eventually overflow the count.

-- Steve

