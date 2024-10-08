Return-Path: <linux-fsdevel+bounces-31309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7D99451A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE46F28771B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A821925A7;
	Tue,  8 Oct 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqb7pygB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540F18DF65
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382344; cv=none; b=gcvs3XZQeyqH3orBmWLkwTqXwNC2/V7HQEKEqUj3HpZuleJkWBXS6eZsMKPJdUOrOXmhg++tMBGSJInzbyVh8621lWEr0kqsTcXsiquiboSMKb5ugXib0z5RcKPf1I+2vPn2RbEChgUNC5mQjHxSiDIGJfHCQy5TLpvZhsoN+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382344; c=relaxed/simple;
	bh=r/E8HthcLTiRaBMh5fSFd9ShQ0v/rbT0c8lrmgrpEkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8E1rCQdNM5hXoFQPIkai2COUOOHgofn7HPqg6PX0xgcVO6X+pLrtqHXtnQB8HWPhVWJ//KwtZU4WH5IBcTg15MBWqi1h5Zo8kzkbue4k/jMjXVIq66T1PjEkCjP6Jww89kpDkI/7sDuLp3617kKKqsycR0O/rvFCC6dQLe7kK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqb7pygB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E382C4CEC7;
	Tue,  8 Oct 2024 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728382344;
	bh=r/E8HthcLTiRaBMh5fSFd9ShQ0v/rbT0c8lrmgrpEkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lqb7pygB5e25n19xn7AaHTd+84yoCJKbnQIV2ax4DFPzZk/jr8XMZbwSkKe+x4qfz
	 WBtcBTxVkVrt1+G0F1Czkf2SbCrrMhLTx393aOKtgKrKZwuO3tRNbLFcrJUL5eWK62
	 gueVF5+7u/MZLgHFpj3utncSss2FOB80Eek01qpCCPuGEMpX4XGm0DATFTvbcmpP2S
	 LfL+9Cck9XQjchKPSeG4FAn5EgyWO4B031f+sVGLHmaZ6Vnczo7xUeYiGV88Juk2XO
	 J0N1hF7wKKzBQnoHs2GHpQDvbM4EU6g9OB9Nb9jjY8vy+5ejeeP0NRHmDDk4x5RmuU
	 dhZFK/auMrigQ==
Date: Tue, 8 Oct 2024 12:12:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] fs: add file_ref
Message-ID: <20241008-gedeck-jemand-ebd8c1bf2737@brauner>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-2-387e24dc9163@kernel.org>
 <CAHk-=wj3Nt6Fyu_YYuNoa+Xi4h__MxAjJs5M3YTHvTshehegzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3Nt6Fyu_YYuNoa+Xi4h__MxAjJs5M3YTHvTshehegzg@mail.gmail.com>

On Mon, Oct 07, 2024 at 11:07:51AM GMT, Linus Torvalds wrote:
> On Mon, 7 Oct 2024 at 07:24, Christian Brauner <brauner@kernel.org> wrote:
> >
> > +static __always_inline __must_check bool file_ref_get(file_ref_t *ref)
> > +{
> > +       /*
> > +        * Unconditionally increase the reference count with full
> > +        * ordering. The saturation and dead zones provide enough
> > +        * tolerance for this.
> > +        */
> > +       if (likely(!atomic_long_add_negative(1, &ref->refcnt)))
> > +               return true;
> > +
> > +       /* Handle the cases inside the saturation and dead zones */
> > +       return __file_ref_get(ref);
> > +}
> 
> Ack. This looks like it does the right thing.
> 
> That said, I wonder if we could clarify this code sequence by using
> 
>         long old = atomic_long_fetch_inc(&ref->refcnt);
>         if (old > 0)
>                 return true;
>         return __file_ref_get(ref, old);
> 
> instead, which would obviate all the games with using the magic
> offset? IOW, it could use 0 as "free" instead of the special
> off-by-one "-1 is free".
> 
> The reason we have that special "add_negative()" thing is that this
> *used* to be much better on x86, because "xadd" was only added in the
> i486, and used to be a few cycles slower than "lock ; add".
> 
> We got rid of i386 support some time ago, and the lack of xadd was
> _one_ of the reasons for it (the supervisor mode WP bit handling issue
> was the big one).
> 
> And yes, "add_negative()" still generates simpler code, in that it
> just returns the sign flag, but I do feel it makes that code harder to
> follow.  And I say that despite being very aware of the whole

Thanks for the background. That was helpful!

Switching atomic_long_fetch_inc() would change the logic quite a bit
though as atomic_long_fetch_inc() returns the previous value. In the
current scheme atomic_long_add_negative() will signal that an overflow
happened and then we drop into the slowpath reading the updated value
and resetting to FILE_REF_DEAD if we overflowed.

So if T1 overflows but accidently happens to be the last thread that
does a file_ref_get() then T1 will reset the counter to FILE_REF_DEAD.

But iiuc, if we now rely on the previous value T1 wouldn't reset if it
overflowed and happened to currently be the last thread that does some
operation that takes a lot of time. It also would mean that T1 overflows
but does still return success.

We could handle such cases by either using atomic_long_inc_return() or
by manually checking the previous value against FILE_REF_MAXREF and
passing a +1 or -1 value to the slowpath helpers.

But imho I find the current code easier to follow. Maybe I'm being held
hostage by having read the rcuref code a bit too often by now. But if
you don't feel strongly I'd leave it as is.

