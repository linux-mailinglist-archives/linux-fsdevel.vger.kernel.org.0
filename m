Return-Path: <linux-fsdevel+bounces-64474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AEBE84FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4D41AA3768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A0343D87;
	Fri, 17 Oct 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hs9rnXkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047632ED3F;
	Fri, 17 Oct 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700326; cv=none; b=ZSVX0vfDisJITw6OBIcF4Bh3KoED5G0yPhABt4Bza8HZ/veIznTIeh4Fu65zdS8JysunqNSKP8EYoo1kkEn04zsBPNSOMXDg9AXM9K0IUliH0nh8EJTdPmQzvetk/Pnw+rNnEbtegZTCcWIcQZv5qm+YYR/JWZoVRgXcd1qz+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700326; c=relaxed/simple;
	bh=rhmicNJZ4ZANfqK4EyUslfDMqZYqgCT0QFRgPraKr38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4tHoDG9ZQdEiCorZHmWkGyh95LyThJmubSlxBYp4ZylEq1HW8Yplc1ydJQZv+TlmiD2EdSkVQRiHmhpungIpFnfry9yvrBbZyJNxq5+KExDr819K4k1+ssvSskPW+/juKn/ggrH2HZHT6q+dLxbVZM+DNaR7OZUzBKXF7fBxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hs9rnXkx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6NUdGt9MtwvZM8jFQHDsw1CCYzG2H7JFSs9BY7PdJqA=; b=Hs9rnXkxHjJhukQH8YKpfmx1MG
	VZA60esTzih9n9wz+52eqcD59QOx+XDFIHyh7c+pophLHqgU4pS4pFhzbPljuZVWqPytPuzxcaLl7
	S+E7SYSRSFwMybJrMhDmdTjSEfc00iD7BHmyfTmTRiICFGeQllh5SzKuMB3fgb9Ax4AAWWvj3Uavu
	KjG5+YOXW8tPPa0//Qqm1AlGRYRbcs7Y3JxSsHqhWz2AGe38QnB6cYh9h9t3xtx3WZuOcipGJF8lQ
	1baXzfSn292iNCLYPtUPcw5e9HmK8yNQQvOc+EEUeIP/k8jyFwFcGC+J6+je+9353wqrDfz3kSPye
	pecvA4Gw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9ia1-00000007Web-1SpD;
	Fri, 17 Oct 2025 11:25:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1F4030023C; Fri, 17 Oct 2025 13:25:04 +0200 (CEST)
Date: Fri, 17 Oct 2025 13:25:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
Message-ID: <20251017112504.GE3245006@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de>
 <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com>

On Fri, Oct 17, 2025 at 12:08:24PM +0100, Andrew Cooper wrote:
> On 17/10/2025 11:09 am, Thomas Gleixner wrote:
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
> > +for (bool ____stop = false; !____stop; ____stop = true)						\
> > +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\
> > +	     !____stop; ____stop = true)							\
> > +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
> > +		     ____stop = true)					\
> > +			/* Force modified pointer usage within the scope */			\
> > +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\
> > +				if (1)
> > +
> 
> Truly a thing of beauty.  At least the end user experience is nice.
> 
> One thing to be aware of is that:
> 
>     scoped_masked_user_rw_access(ptr, efault) {
>         unsafe_get_user(rval, &ptr->rval, efault);
>         unsafe_put_user(wval, &ptr->wval, efault);
>     } else {
>         // unreachable
>     }
> 
> will compile.  Instead, I think you want the final line of the macro to
> be "if (0) {} else" to prevent this.
> 
> 
> While we're on the subject, can we find some C standards people to lobby.
> 
> C2Y has a proposal to introduce "if (int foo =" syntax to generalise the
> for() loop special case.  Can we please see about fixing the restriction
> of only allowing a single type per loop?   This example could be a
> single loop if it weren't for that restriction.

So elsewhere, Linus suggested to use a struct to get around that. See
for example this lovely thing:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=1bc5d8cefd0d9768dc03c83140dd54c552bea470


