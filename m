Return-Path: <linux-fsdevel+bounces-69395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D45C7B241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE43A27C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1E2EE612;
	Fri, 21 Nov 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfqAwGV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D2239E6F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747746; cv=none; b=r22geT6FWRFrrnemCHnXVGEs2OuE4gwe6cKe1X/9pi6i3ny++JThXdC2qT0iXn5ClKNRm+YiznovCSdAFfapuM1y0PcYQi6USjHZydgX0vwMHlq0nqCmqr+/aET1gKc0vMmOHJd1x/GAIDe2F78tTkb0yDx0DHqfamw1vvWGL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747746; c=relaxed/simple;
	bh=g4/coqzGtRlh4WCh1CQ26LpZhHLgKOfo/QyUP5RFhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbZ6wP/aDkmWi/rjnCGMJeEDuDh/nEi+RkXBwBnsb7VVoHm/Si4aefqx0gXRFZlREsGDRKCL/Q9sh5v0xND3DXmyymjf8mQtCMY/KExf8gcNe3rhVAe8W2GgmnFJCY59OSm+ZK4tcjVvArqZovu5bDcUNg0XIPN2Sd42sA8EZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfqAwGV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E8CC4CEF1;
	Fri, 21 Nov 2025 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763747746;
	bh=g4/coqzGtRlh4WCh1CQ26LpZhHLgKOfo/QyUP5RFhco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfqAwGV4Pm8gJS6//YxStykJh3L918ZEe6vqUshGt2yz7AEh807fGQMxrftSb+4Eb
	 SSJgfODTnX1EO/b5vLy6cmJ/5b1JZxj3NSUWJWf7oHJPu6MKcQqR7+bXuh45ND2TK6
	 Exz9M7ZbFmbW09rMAbYJBZbpXbhX4NbHtdMk5XohwQX71KIow8szKxMW9iDAP0qz+0
	 ZlHUa7CXLyRRKdFVCCM7ScNCZ+k40oci5SM5RlIsKtt3wFly/ZcI3s+S9nO5WsxSN+
	 xSzzSDZkd5lW0FAln1b9QNh5ePEo96liZZh577wEy+o9VDW/3nPS3KW4uzvzUxFjhB
	 hzWPqEkhfbqYQ==
Date: Fri, 21 Nov 2025 18:55:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/48] file: add and convert to FD_PREPARE()
Message-ID: <20251121-planen-abgebaut-c26d316a4722@brauner>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
 <CAHk-=wg+61ucgtDpK4kAL0cpNi1pk-t6=hTWumbF+L7b4_pfTg@mail.gmail.com>
 <CAHk-=wgmCtGuXVD2Q5jjCzxj5jBVAxXZOyVyq3+f+jAyxuUyMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmCtGuXVD2Q5jjCzxj5jBVAxXZOyVyq3+f+jAyxuUyMQ@mail.gmail.com>

On Thu, Nov 20, 2025 at 03:28:25PM -0800, Linus Torvalds wrote:
> On Thu, 20 Nov 2025 at 15:08, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I really wish the end result wouldn't look so odd. This is a case
> > where the scoping seems to hurt more than help.
> 
> Maybe you could make the basic building blocks not start a new scope
> at all, which would make the docs in the comment actually match
> reality?
> 
> And then the (few) cases that want a new scope and actually have
> something that follows the final
> 
>         return fd_publish(fdf);
> 
> would have to do their own scope themselves, possibly with a statement
> expression?
> 
> >From quick (and possibly incomplete) look through the patches, of 48
> patches, only *two* had a
> 
>         variable = fd_publish();
> 
> pattern with code after the scope. The rest all seemed to just want to
> finish with that fd_publish() and the scope didn't really help them.
> 
> eg media_request_alloc() ended up doing
> 
>                 *alloc_fd = fd_publish(fdf);
>                 return 0;
> 
> instead, and kcm_ioctl() does
> 
>                         err = fd_publish(fdf);
> 
> and then breaks out of the case statement. Maybe there were others.
> But all that the second case actually does is then "return err"
> outside the case statement anyway.
> 
> Now, those do probably want scoping, just because they do have other
> code after the "return" anyway (due to this all being inside a case
> statement, or they had a error label or something). But I think they
> could have actually used a statement expression (or even just a bare
> nested block) for that.
> 
> A statement expression might even look reasonable, something like
> 
>         int fd = ({
>                 FD_PREPARE(fdf, 0, kcm_clone(sock));
>                 if (fd_prepare_failed(fdf))
>                         return fd_prepare_error(fdf);
>                 info.fd = fd_prepare_fd(fdf);
>                 if (copy_to_user((void __user *)arg, &info, sizeof(info)))
>                         return -EFAULT;
>                 fd_publish(fdf);
>         });
> 
> certainly looks *very* odd too (those returns inside the statement
> expression are downright evil), but I think it would actually be
> preferable to the odd "you have to do a block scope after the
> FD_PREPARE()".
> 
> I dunno. There may be some reason you did it the way you did that I
> don't immediately see.

Having a separate scope avoids the "cannot jump from this goto statement
to its label" problem. But it's actually irrelevant because all
codepaths are simplified to an extent that by this new api that nearly
all gotos go away anyway.

So I think you're right to nak the scope.

Fwiw, the reason the documentation doesn't match the implementation is
that v1 - which I had cced you on already - had a non-scoped variant and
I forgot to update it. And I should've stuck with that.

I also realized that fd_prepare_failed() and fd_prepare_error() aren't
needed. Since peterz added ACQUIRE_ERR() a short while ago we can easily
integrate with that. I'll send you a v2 in a few minutes that does all
that.

