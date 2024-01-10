Return-Path: <linux-fsdevel+bounces-7744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE182A0F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63742282822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4F4EB25;
	Wed, 10 Jan 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WX4uJm1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B74EB22
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Jan 2024 14:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704914384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZlg2gyd0y0ZDd2Z9FOmhI3dnR3plW0RbOtBJCEA2cM=;
	b=WX4uJm1K//vBDlQI96RPNrOj/Cc/UTLDSRp31X7yLjiVUwL8UPQ3N9kzoUcz5yYt6ZA7Gh
	M9mOzaxfp3BsVvyoiqbux+jGRiMRBVTDa3+KcZtH0PY5Lz44S0+7Vz2k8dv8BkpINZx863
	V7mrf8a+4nS+SdTFkWeZJBb4cTAxBUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <zdc66q6svna4t5zwa5hkxc72evxqplqpra5j47wq33hidspnjb@r4k7dewzjm7e>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
 <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
 <ZZ2dsiK77Se65wFY@casper.infradead.org>
 <ZZ3GeehAw/78gZJk@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3GeehAw/78gZJk@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 10, 2024 at 09:19:37AM +1100, Dave Chinner wrote:
> On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
> > > On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > No.  This "cleaner version on the Rust side" is nothing of that sort;
> > > > this "readdir doesn't need any state that might be different for different
> > > > file instances beyond the current position, because none of our examples
> > > > have needed that so far" is a good example of the garbage we really do
> > > > not need to deal with.
> > > 
> > > What you're calling garbage is what Greg KH asked us to do, namely,
> > > not introduce anything for which there are no users. See a couple of
> > > quotes below.
> > > 
> > > https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
> > > The best feedback is "who will use these new interfaces?"  Without that,
> > > it's really hard to review a patchset as it's difficult to see how the
> > > bindings will be used, right?
> > > 
> > > https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
> > > And I'd recommend that we not take any more bindings without real users,
> > > as there seems to be just a collection of these and it's hard to
> > > actually review them to see how they are used...
> > 
> > You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> > without a filesystem to use them".  And Al, myself and others are saying
> > "Your filesystem interfaces are wrong because they're not usable for real
> > filesystems".
> 
> And that's why I've been saying that the first Rust filesystem that
> should be implemented is an ext2 clone. That's our "reference
> filesystem" for people who want to learn how filesystems should be
> implemented in Linux - it's relatively simple but fully featured and
> uses much of the generic abstractions and infrastructure.
> 
> At minimum, we need a filesystem implementation that is fully
> read-write, supports truncate and rename, and has a fully functional
> userspace and test infrastructure so that we can actually verify
> that the Rust code does what it says on the label. ext2 ticks all of
> these boxes....

I think someone was working on that? But I'd prefer that not to be a
condition of merging the VFS interfaces; we've got multiple new Rust
filesystems being implemented and I'm also planning on merging Rust
bcachefs code next merge window.

