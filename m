Return-Path: <linux-fsdevel+bounces-7658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F377A828D56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115381C23517
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D13D54B;
	Tue,  9 Jan 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofeVvIa0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE63D542;
	Tue,  9 Jan 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q7wk5dLqS1GiNGHj32FRb/6GSIg5UZpMgGfKYVefrTM=; b=ofeVvIa07Knd0LfET/gpv3mOe+
	rFVyDVqpf8/nU8G3CLEiLpsvAKgdOTuOZY0CxG2MUukTXOcL1U7uny8nHbv3cEHdvpmNf34BvuduS
	saoQVlR5l7yZHX3hAEPY1FRa68sfnhUtHXDAyQ30wEn4ndRzoT7eTTHmeV0WQkz+v58yi9k88dMc0
	vUXHKKIs0xTq5bRPiczI3+q33kRflvyxxACSoZ4AJ6LiKQXawP6YyEQuXnH/U8gSqPaI5z+TXGy8C
	KBwmIPohzbEHVKA/mYtOa0Us3X0k8s5mo1OIKgJN6AFnHYIrkunJ1aPKi7mOu0HPeguzsS/oO/PQp
	yg4CsTng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNHjH-00ADwl-0O; Tue, 09 Jan 2024 19:25:39 +0000
Date: Tue, 9 Jan 2024 19:25:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZ2dsiK77Se65wFY@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV>
 <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>

On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
> On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > No.  This "cleaner version on the Rust side" is nothing of that sort;
> > this "readdir doesn't need any state that might be different for different
> > file instances beyond the current position, because none of our examples
> > have needed that so far" is a good example of the garbage we really do
> > not need to deal with.
> 
> What you're calling garbage is what Greg KH asked us to do, namely,
> not introduce anything for which there are no users. See a couple of
> quotes below.
> 
> https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
> The best feedback is "who will use these new interfaces?"  Without that,
> it's really hard to review a patchset as it's difficult to see how the
> bindings will be used, right?
> 
> https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
> And I'd recommend that we not take any more bindings without real users,
> as there seems to be just a collection of these and it's hard to
> actually review them to see how they are used...

You've misunderstood Greg.  He's saying (effectively) "No fs bindings
without a filesystem to use them".  And Al, myself and others are saying
"Your filesystem interfaces are wrong because they're not usable for real
filesystems".  And you're saying "But I'm not allowed to change them".
And that's not true.  Change them to be laid out how a real filesystem
would need them to be.  Or argue that your current interfaces are the
right ones (they aren't).

