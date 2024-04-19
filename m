Return-Path: <linux-fsdevel+bounces-17319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5098AB670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEADB1F2178B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDF137779;
	Fri, 19 Apr 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="PxIgxQQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8879107B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562187; cv=none; b=VKbVGwM/3w3b6OR4QlE0loKusecCSKzPTAKWDydSD//aFL0Ww13UeTOIAkI7/TxbI9EnySSPd0Z6NRQmKZPDv6CytR+xhXsBHPtTuS/AwDvJ/MtZqyhGj4+24TW7Yi/K33ruNgA7CXQYmZdHQcRRqp5fBrUAp+kua1jxDX09/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562187; c=relaxed/simple;
	bh=eI8Wm6s4gWpfQCuME8j6SaegNZSJ7ySN/NVWK11v7WI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MviDPAo+kmlEuZU4+ksXRxytJJfRL0Wqd18xkp0OTqIkyXkRYNoT4HkI/q0VcrauO9s4wycRjNPyYY7eY/7KaAl0K9Kgtob1IANV7JSAsIZdZeKSf5ziizfZDTr5CeqfIFXINUGk98WpvdIXRezEpiOysuiR/vy0PlSHbzSTrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=PxIgxQQK; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713562176; x=1713821376;
	bh=/5Ay99VDFGjpaFPbCNU0yVz0uJQnWEHz8RxzAQ1T3Ho=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PxIgxQQKMkPKKXVI3FpzxciA8NavHVob+nOXuKQWZJUEwqnfes7hIer4INHJT+lLH
	 9oLzcgvszLEIc3qeuKT/LDz9LEx/PtzQ0ql+d1Ag1LTWnZfEGUZUJS7xeBpVAu1Tfn
	 xfooWMmyXjQqThmigESFs8HvzovWXt7bHBI6hIiR1P+0Je43/zoOco+mlM0b3MQJ/H
	 RdmDrADSxrGWB+i6QY7kyO3WSNazeyfhHKE0futXBM8WgxbK41zH/y19nVPPTwTKlg
	 8+/SGM0Nr4V7F+Yic/icpOAhlTjRNASDctjjw1+k6johmJf+ju9Boexd7M5YvXeJ3L
	 awRceLAFVfV4A==
Date: Fri, 19 Apr 2024 21:29:27 +0000
To: The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
From: Antonio SJ Musumeci <trapexit@spawn.link>
Subject: Re: EBADF returned from close() by FUSE
Message-ID: <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
In-Reply-To: <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de> <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link> <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de> <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link> <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de> <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link> <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: c58f834c1e6be58b7370924c92b6bb9e14b172f9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/24 15:45, The 8472 wrote:
> Syscalls have documentation. Errors and their semantics are part
> of the documentation. If the kernel cannot actually provide
> the documented semantics because it passes errors through without
> sanitizing them then this should at least be documented
> for each affected syscall.
And that documentation is *different* depending on the platform. The=20
clean vision you seem to have about errnos is not real. There are=20
conventions... not strong contracts. I had this exact debate days ago=20
about `link`. The claim that if link isn't supported by the OS FUSE=20
should return EPERM. But this just isn't standard the way people think=20
it is. Not on paper. And if a FUSE server wants to return EPERM then it=20
can. I don't see why the kernel needs to get in the business of reading=20
the mind of the server author.
>
> Proper API documentation and stability guarantees are important
> so we can write robust software against them.
>
> Note that write(2) documents
>
>      Other errors may occur, depending on the object connected to fd.
>
> close(2) has no such note.

Your idea is laudable but not realistic. errnos are not even fully=20
consistent across devices or filesystem. Yes, there are norms and some=20
standards but they are not enforced by some central arbiter across all=20
forms of *nix.

> That does not mean userspace should be exposed to the entirety
> of the mess. And in my opinion EIO is better than EBADF because
> the former "merely" indicates that something went wrong relating
> to a particular file. EBADF indicates that the file descriptor
> table of the process may have been corrupted.

"should"... but it is exposed to it. *Most* software doesn't even=20
attempt to handle errors intelligently and just return the error up the=20
stack blindly. EIO is about as generic as can be and I've seen it used=20
many times as the "catch all" error making it meaningless. Further=20
incentivizing client software to behave as they do... not paying=20
attention. I will again point out that I've seen EXDEV treated like any=20
random other error several times in my career by important pieces of=20
software made by major vendors.

> Will try. But the kernel should imo also do its part fulfilling its API
> contract.
Then you are barking up the wrong tree. This isn't an issue unique to=20
FUSE. FUSE just makes it more obvious to you because anyone can write a=20
FUSE server and return (almost) anything they want.
> That it requires perhaps some thought to do it properly does not seem
> sufficient to me to dismiss the request to provide a proper
> abstraction boundary with reliable semantics that match its documentation=
.

I simply don't see what you could do to "do it properly." I am trying to=20
argue there is no such thing. And again it would require breaking every=20
single FUSE server.



