Return-Path: <linux-fsdevel+bounces-6692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC381B6F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82497B22A9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D87318B;
	Thu, 21 Dec 2023 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X97151HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CA745CA;
	Thu, 21 Dec 2023 13:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB7C433C8;
	Thu, 21 Dec 2023 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163963;
	bh=oBgqdArhy+BkKeGKSCOcUORFE4ISxI24tE8gu8Yz288=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X97151HPjjqpQwxtLFnVWnwQVR/G9woeqH0xc3UskQOOM4lWjHZq/81qmP7RviyD0
	 DR36dNzpsu4fUAacobuC18XmQyOocOSiJS08hAYd9fnjOVxJGj93uavsucwcf/meeX
	 n17z8uz/+gjjWOuW6c3gOdG2S+dLYAr0C1IQ4kZsC4p7ieUwpOmFwNjP3syVEjUZsq
	 kH6DKULHXKJSeFzZEAoT1+FW55qncA8MAayBp44ViMz3LrDHiVxd0n9qPLjtCzmnUX
	 CetNGqlO1cc/BAZTe2ILEf37ETT/0izd7vqNbkuujEeh19gmYdybJhDlBIbaosvbYo
	 fW0qS18QQVJ2w==
Date: Thu, 21 Dec 2023 14:05:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: pull-request: bpf-next 2023-12-18
Message-ID: <20231221-wolldecke-burggraben-40f9b60cee83@brauner>
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner>
 <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
 <20231220-einfiel-narkose-72cf400ae7e6@brauner>
 <CAEf4BzYMJ1DCnRCXv4q=M-QG29Bgm+jrnkEuXNivmGmHShjnPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYMJ1DCnRCXv4q=M-QG29Bgm+jrnkEuXNivmGmHShjnPg@mail.gmail.com>

> Of course, and you'll be CC'ed on all the BPF token patches I will
> resend after the holidays.
> 
> And just to be clear for the future, by "core fs semantics" you also
> mean any BPF UAPI FD field, right?

Yes, because ultimately you end up with calling:

fdget()/fdget_raw()/fget()

to turn a userspace handle in the form of an fd and turn it into a
struct file. And that is uniform across the kernel. And therein lies the
beauty of it all imo.

IMHO, a file descriptor is one of the most widely used generic
abstraction we have across all of the kernel. It is almost literally
used everywhere. And everyone has the same contract: a non-negative
integer is a valid fd, a negative one is invalid. It's simple, there
aren't corner cases, there aren't custom semantics.

And it's also arguably one of the most successful ones as we keep
implementing new apis on top of this abstraction (pidfd, seccomp,
process_*(), memfd_*(), endless kvm ioctls etc etc).

