Return-Path: <linux-fsdevel+bounces-29781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1797DC3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865991C20E31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E111552E3;
	Sat, 21 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9LQevFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03C2AE66;
	Sat, 21 Sep 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726907873; cv=none; b=tH5AH1DjsGVdcn+CR2GBqInsd1b3hEOGKQk1ZPYVxkKneCOgDfMSP+xeSDyYVaos95IUWuxuqhFyQvaxJQpZvShISehTP0+k3HmGDoS7YIqvpw9TWOtUtDt8GNV2f5yoqD1wGjWHio4o574xbtinVt7QQhKjucrBa4yyYo7ys34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726907873; c=relaxed/simple;
	bh=KxxWpvQduRwVza8T/KLp4zvZBV1HMs25Lt6z6qf+pdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUh7y685Wd5unNFEgs8aG2hIjMuuB+en4e6xZiiiYfWk7QRiA1waoHGiorfOXTFvcCtYNFUQU4F3jLZBtifIqClTYalB+3kBJIDm2Pl5O8AooNWQI7JxI920yHqaSC12TskVnS62LcqIOpn1Trst0qoMO09hKrs566nm0yPuCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9LQevFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714C4C4CEC2;
	Sat, 21 Sep 2024 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726907872;
	bh=KxxWpvQduRwVza8T/KLp4zvZBV1HMs25Lt6z6qf+pdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9LQevFxhNgopRXOA7UnsLba/AZawJyLHhNOh2xJARcVERaI7stTpmh+6pIJt0k5c
	 Ye/3r6qG9ZnXN0E26vdTmP/AXz7K78JN6XSHiaUk2DNa9pzU8AWJfAUueJxuvBCMSR
	 FB9MuczbZnv8gNhXohH1OAq7To9sO+dJmJSx3ma0=
Date: Sat, 21 Sep 2024 10:37:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
	Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <2024092139-kimono-heap-8431@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <b5c77d5b-7f6d-4fe5-a711-6376c265ed53@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c77d5b-7f6d-4fe5-a711-6376c265ed53@linux.alibaba.com>

On Fri, Sep 20, 2024 at 08:49:26AM +0800, Gao Xiang wrote:
> 
> 
> On 2024/9/20 03:36, Benno Lossin wrote:
> > On 19.09.24 17:13, Gao Xiang wrote:
> > > Hi Benno,
> > > 
> > > On 2024/9/19 21:45, Benno Lossin wrote:
> > > > Hi,
> > > > 
> > > > Thanks for the patch series. I think it's great that you want to use
> > > > Rust for this filesystem.
> > > > 
> > > > On 17.09.24 01:58, Gao Xiang wrote:
> > > > > On 2024/9/17 04:01, Gary Guo wrote:
> > > > > > Also, it seems that you're building abstractions into EROFS directly
> > > > > > without building a generic abstraction. We have been avoiding that. If
> > > > > > there's an abstraction that you need and missing, please add that
> > > > > > abstraction. In fact, there're a bunch of people trying to add FS
> > > > > 
> > > > > No, I'd like to try to replace some EROFS C logic first to Rust (by
> > > > > using EROFS C API interfaces) and try if Rust is really useful for
> > > > > a real in-tree filesystem.  If Rust can improve EROFS security or
> > > > > performance (although I'm sceptical on performance), As an EROFS
> > > > > maintainer, I'm totally fine to accept EROFS Rust logic landed to
> > > > > help the whole filesystem better.
> > > > 
> > > > As Gary already said, we have been using a different approach and it has
> > > > served us well. Your approach of calling directly into C from the driver
> > > > can be used to create a proof of concept, but in our opinion it is not
> > > > something that should be put into mainline. That is because calling C
> > > > from Rust is rather complicated due to the many nuanced features that
> > > > Rust provides (for example the safety requirements of references).
> > > > Therefore moving the dangerous parts into a central location is crucial
> > > > for making use of all of Rust's advantages inside of your code.
> > > 
> > > I'm not quite sure about your point honestly.  In my opinion, there
> > > is nothing different to use Rust _within a filesystem_ or _within a
> > > driver_ or _within a Linux subsystem_ as long as all negotiated APIs
> > > are audited.
> > 
> > To us there is a big difference: If a lot of functions in an API are
> > `unsafe` without being inherent from the problem that it solves, then
> > it's a bad API.
> 
> Which one? If you point it out, we will update the EROFS kernel
> APIs then.
> 
> > 
> > > Otherwise, it means Rust will never be used to write Linux core parts
> > > such as MM, VFS or block layer. Does this point make sense? At least,
> > > Rust needs to get along with the existing C code (in an audited way)
> > > rather than refuse C code.
> > 
> > I am neither requiring you to write solely safe code, nor am I banning
> > interacting with the C side. What we mean when we talk about
> > abstractions is that we want to minimize the Rust code that directly
> > interfaces with C. Rust-to-Rust interfaces can be a lot safer and are
> 
> We will definitly minimize the API interface between Rust and C in
> EROFS.
> 
> And it can be done incrementally, why not?  I assume your world is
> not pure C and pure Rust as for the Rust for Linux project, no?
> 
> > easier to implement correctly.
> > 
> > > My personal idea about Rust: I think Rust is just another _language
> > > tool_ for the Linux kernel which could save us time and make the
> > > kernel development better.
> > 
> > Yes, but we do have conventions, rules and guidelines for writing such
> > code. C code also has them. If you want/need to break them, there should
> > be a good reason to do so. I don't see one in this instance.
> > >> Or I wonder why not writing a complete new Rust stuff instead rather
> > > than living in the C world?
> > 
> > There are projects that do that yes. But Rust-for-Linux is about
> > bringing Rust to the kernel and part of that is coming up with good
> > conventions and rules.
> 
> Which rule is broken?  Was they discussed widely around the
> Linux world?
> 
> > 
> > > > > For Rust VFS abstraction, that is a different and indepenent story,
> > > > > Yiyang don't have any bandwidth on this due to his limited time.
> > > > 
> > > > This seems a bit weird, you have the bandwidth to write your own
> > > > abstractions, but not use the stuff that has already been developed?
> > > 
> > > It's not written by me, Yiyang is still an undergraduate tudent.
> > > It's his research project and I don't think it's his responsibility
> > > to make an upstreamable VFS abstraction.
> > 
> > That is fair, but he wouldn't have to start from scratch, Wedsons
> > abstractions were good enough for him to write a Rust version of ext2.
> 
> The Wedson one is just broken, I assume that you've read
> https://lwn.net/Articles/978738/ ?

Yes, and if you see the patches on linux-fsdevel, people are working to
get these vfs bindings correct for any filesystem to use.  Please review
them and see if they will work for you for erofs, as "burying" the
binding in just one filesystem is not a good idea.

> > In addition, tarfs and puzzlefs also use those bindings.
> 
> These are both toy fses, I don't know who will use these two
> fses for their customers.

tarfs is being used by real users as it solves a need they have today.
And it's a good example of how the vfs bindings would work, although
in a very simple way.  You have to start somewhere :)

> > Miguel Ojeda.
> > However, we can only reach that longterm goal if maintainers are willing
> > and ready to put Rust into their subsystems (either by knowing/learning
> > Rust themselves or by having a co-maintainer that does just the Rust
> > part). So you wanting to experiment is great. I appreciate that you also
> > have a student working on this. Still, I think we should follow our
> > guidelines and create abstractions in order to require as little
> > `unsafe` code as possible.
> 
> I've expressed my point.  I don't think some `guideline`
> could bring success to RFL.  Since many subsystems needs
> an incremental way, not just a black-or-white thing.

Incremental is good, and if you want to use a .rs file or two in the
middle of your module, that's fine.  But please don't try to implement
bindings to common kernel data structures like inodes and dentries and
superblocks if at all possible and ignore the work that others are doing
in this area as that's just duplicated work and will cause more
confusion over time.

It's the same for drivers, I will object strongly if someone attempted
to create a USB binding for 'struct usb_interface' in the middle of a
USB driver and instead insist they work on a generic binding that can be
used by all USB drivers.  I imagine the VFS maintainers have the same
opinion on their apis as well for valid reasons.

thanks,

greg k-h

