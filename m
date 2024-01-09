Return-Path: <linux-fsdevel+bounces-7660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16A828D70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60A21F2594D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74723D3A5;
	Tue,  9 Jan 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+0wWYVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2193D393;
	Tue,  9 Jan 2024 19:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F03CC433F1;
	Tue,  9 Jan 2024 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704828770;
	bh=24Y8Lvvcp1QkWPOM6bp4SZv3jzIsnC2H69DV6tGRAIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+0wWYVsjzNWsFasfDnslm+fuC+5Li1WzpaPw/Qy0ghZix7s0qRh+HbhB4vEX5OeJ
	 7g/awGj2V1w0kUh+8EAD+rFF6X66A+WbB8MfMe/a022L0UGeAVPtRBislrjM26XmVy
	 ZIHe/522i1fzz42ISomTQv9KS9C950I95limcMhg=
Date: Tue, 9 Jan 2024 20:32:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <2024010935-tycoon-baggage-a85b@gregkh>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
 <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
 <ZZ2dsiK77Se65wFY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2dsiK77Se65wFY@casper.infradead.org>

On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
> > On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > No.  This "cleaner version on the Rust side" is nothing of that sort;
> > > this "readdir doesn't need any state that might be different for different
> > > file instances beyond the current position, because none of our examples
> > > have needed that so far" is a good example of the garbage we really do
> > > not need to deal with.
> > 
> > What you're calling garbage is what Greg KH asked us to do, namely,
> > not introduce anything for which there are no users. See a couple of
> > quotes below.
> > 
> > https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
> > The best feedback is "who will use these new interfaces?"  Without that,
> > it's really hard to review a patchset as it's difficult to see how the
> > bindings will be used, right?
> > 
> > https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
> > And I'd recommend that we not take any more bindings without real users,
> > as there seems to be just a collection of these and it's hard to
> > actually review them to see how they are used...
> 
> You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> without a filesystem to use them".  And Al, myself and others are saying
> "Your filesystem interfaces are wrong because they're not usable for real
> filesystems".  And you're saying "But I'm not allowed to change them".
> And that's not true.  Change them to be laid out how a real filesystem
> would need them to be.

Note, I agree, change them to work our a "real" filesystem would need
them and then, automatically, all of the "fake" filesystems like
currently underway (i.e. tarfs) will work just fine too, right?  That
way we can drop the .c code for binderfs at the same time, also a nice
win.

thanks,

greg k-h

