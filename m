Return-Path: <linux-fsdevel+bounces-16781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1CA8A2871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0B21C23E2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918764CE13;
	Fri, 12 Apr 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1F2Q5jh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10202C683;
	Fri, 12 Apr 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907961; cv=none; b=EhrMZpmSuXxHwCRNhFJch4LLMVSptILalBZATLwE7o4L7vuTrmLgxVP2XsmK2lFVqyRff6W0AXE7jxBB3yZTQNqNhAWqxbfoBYgHgiw+Q9Hpz+eL8PNw7xRIaZmeBV0ipoKY+H8kiuIpOWQ446+LioU4RGGCnvUd7ES1+uUugq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907961; c=relaxed/simple;
	bh=d9Fj19nto8yMpblmpYciB+bMkDw4NUhzh99gQX4C+Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP3SlRZX2vgD1TabL9AOSw1epzZFwWi8R3YdJZsSQdPl1EVLSBJWgrZaVIeRv7u1PXgvlm3h7R3Ics3PLHwyyoc4PcPqIvVYzsZgZwYLIBU0IWnZshk97s8r/ToetbPrTd2B+9tF8rj6yNSNewnoA1l+IdrYaaWWOALaK0hItI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1F2Q5jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21857C113CC;
	Fri, 12 Apr 2024 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907960;
	bh=d9Fj19nto8yMpblmpYciB+bMkDw4NUhzh99gQX4C+Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1F2Q5jhVqFqvTPQxTegfczkiEv3krTlYYVQakY7k3YeK9Rdbe9aHvwlDYzatJhSY
	 dVwfTzwxWU28Zr5UvyjWToLz657a7bCVTL8ivdXSuq1rEhge2vc3zz6JYqR6dNjJ/q
	 f5l3bzr2TcyderpaYu6ew6IOWfvBtsDMVg3Sn+oCeZqD+0ZRBjDActfTT9RMoYdtpA
	 qQDc5Hrcn2mDP+kLEFguiLwIOlyfnL8LvPknMo4hoMA2vZiWwkeSQH+YooVqF/V0fW
	 D7PIpvOuclhbFyhSp35R2lGlBkar+rYV7Rwko8IdPDyPZPJVul5HSrRH2kCqffmaA5
	 c0CGMh5BW5aXQ==
Date: Fri, 12 Apr 2024 09:45:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240412-labeln-filmabend-42422ec453d7@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner>
 <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
 <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:34:52PM -0700, Linus Torvalds wrote:
> On Thu, 11 Apr 2024 at 11:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So while I understand your motivation, I actually think it's actively
> > wrong to special-case __O_TMPFILE, because it encourages a pattern
> > that is bad.
> 
> Just to clarify: I think the ns_capable() change is a good idea and
> makes sense. The whole "limited to global root" makes no sense if the
> file was opened within a namespace, and I think it always just came
> from the better check not being obvious at the point where
> AT_EMPTY_PATH was checked for.
> 
> Similarly, while the FMODE_PATH test _looks_ very similar to an
> O_TMPFILE check, I think it's fundamentally different in a conceptual
> sense: not only is FMODE_PATH filesystem-agnostic, a FMODE_PATH file
> is *only* useful as a pathname (ie no read/write semantics).

But the annoying part imho is that we also allow stuff like fsetxattr()
to work on O_PATH file descriptors. Something that I really dislike.

> 
> And so if a FMODE_PATH file descriptor is passed in from the outside,
> I feel like the "you cannot use this to create a path" is kind of a
> fundamentally nonsensical rule.

Hm, I would like to avoid adding an exception for O_PATH. While it is
useful for lookup O_PATH is also often used simply as an opaque handle
to a file. O_PATH is often used to simply identify or compare files, or
for execveat(). Especially for cross-container interactions it would be
nice to not generally allow O_PATH to be linkat()ed. The current
behavior proposed in this patch should be enough.

