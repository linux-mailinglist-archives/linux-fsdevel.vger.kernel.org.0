Return-Path: <linux-fsdevel+bounces-20677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F08D6C0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 00:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1179FB25A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148777111;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ifp1ic0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2D848D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192879; cv=none; b=D4hTtUX0C7S/tHViYpVjRQsO93PD4BI9wyt77bd+zd4j25HF5kFxXvS76THZkdGqtPsyv8dlqxrX8I9H9uVbkQQrMYnkLrx+khbW03c9CV20vMHdAlQ5nfwP6teSbSFtRQ3D4IN+7HXct7w23MegE+JSwTqqvru26pLTUmox4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192879; c=relaxed/simple;
	bh=WSyA1Yx2zJu/y1FFPFbN4IhilTmep2kJCO/Y10aVXqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTZiB/xHPLyXajf+cUSxC9ck48IOfb6i9hw0AJCU5trpj0eAOjW/hR/ohXUDbPTo4qTDqjH4FD7//mycgJlmzqinuEwKBjsG0GkZ6MrmwRmjZupsOh0h35ee2jtbyYCfMt3RnI4N4TFv+QwLe6/TrXVCDz+Huuei1qZ8l2hiqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ifp1ic0L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x5q8p/p2PWU8aqGdqwUt2FKMfTtxTmW0IFS3lC9W3Gg=; b=Ifp1ic0LpDcrkrhfYan7ALZ6wy
	Gj4pkhq0XmH40vYgbBaLjHRHv8+3QrCsd06TRnfVCz5wzSn0QXp8sFw4QduF4YRB/xB26P1d60XlK
	SnILLzmbxWiM7S8NYBYsZ7KJHkKcbKI0eH+ncplISZZg3lr/YbXLzhPqlTdT7CSvbcs+ssBFmCFg6
	WkMIS1b5SYvHOa5mZt/fK4i3wy+eA1LUf5sZXwOewOULWi1Lqwyip83gN0wFZ/0Y2hahx0S0goLMl
	OPfu2mes2xIjdaBM/KLqsvC2EUJpAAco0IqHaE9e0VuyfwDbSKhsK77oksLCANUuQInPuJEXPOZ7q
	+4v5Ioqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDAJF-008LkS-2v;
	Fri, 31 May 2024 22:01:14 +0000
Date: Fri, 31 May 2024 23:01:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] struct fd situation
Message-ID: <20240531220113.GC1629371@ZenIV>
References: <20240531031802.GA1629371@ZenIV>
 <20240531163045.GA1916035@ZenIV>
 <CAHk-=wjm3XN1rOWpOKp0=Jgce-bCUmeWvaHLmUiqsDgunUDzxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm3XN1rOWpOKp0=Jgce-bCUmeWvaHLmUiqsDgunUDzxw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 31, 2024 at 11:44:22AM -0700, Linus Torvalds wrote:

> The above obviously assumes that an 'fd_err' never contains NULL.
> Either it's the pointer to the fd (with whatever FDPUT_xyz bits) or
> it's an error value. I don't know if that was your plan.

Definitely.  Mixing NULL and ERR_PTR() for error reporting is a bloody
bad idea; we *do* have functions that may legitimately return both,
but there NULL does not serve as an error indicator - ->lookup()
is one such case (ERR_PTR() on error, NULL - success, use dentry
passed to ->lookup(), non-NULL - a different dentry had to be
spliced in, use it instead).  IS_ERR_OR_NULL() is almost always
a sign of bad calling conventions, or the author being too lazy to
check what the calling conventions are... ;-/

> You can use similar tricks to then get the error value, ie
> 
>    #define fd_error(f) _Generic(f, \
>         struct fd: -EBADF, \
>         struct fd_err: PTR_ERR((f).word))
> 
> and now you can write code like
> 
>         if (fd_empty(x))
>                 return fd_error(x);
> 
> and it will automagically just DTRT, regardless of whether 'x' is a
> 'struct fd' or a 'struct fd_err'.

... except that there's a sizable fraction of those checks that return
something completely different instead of -EBADF ;-/  Userland ABI,
can't do anything about it...

> The same model goes for 'fdput()' - don't make people have to use two
> names and pointlessly state the type.

Maybe, but that depends upon the amount of explicit calls of either
left when we are done.  Conversions to CLASS(fd) eliminate a lot
of those...

> The bad old days where people were convinced that "Hungarian notation"
> was a good thing were bad. Let's leave them behind completely.
> 
> Worth it? Who knows.. But I like your type-based approach, and I think
> that _Generic() thing would fit very very with it.

I'm fine with that for fd_empty(); for the rest... let's see how the
things look like at the end of that series.

