Return-Path: <linux-fsdevel+bounces-7249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6846823561
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6291F24D1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D41CAA4;
	Wed,  3 Jan 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkxoGN4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D771CA97
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Jan 2024 14:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704309278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/YNnCrtCw2RaQdRgaw1iiukczrdsnnbdB/yFFLnTZo=;
	b=VkxoGN4QgL18C5+lbZPadBDhUC5uoPm09m2o6NA/fSQTg2fkmervlluyEb0f/b8yx3GkyP
	jKc7t5s42cEZqGydIcFtSIGi8KFF7LFZyZL/6xh44hTU4Q9bSmVIhGPfcpIa83OkJBfjQm
	TUr58dWRa5UdxPFrTEYMVp5tAzcllSw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWhQGkl0xPiBD5/@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 03, 2024 at 06:02:40PM +0000, Matthew Wilcox wrote:
> On Tue, Oct 31, 2023 at 05:14:08PM -0300, Wedson Almeida Filho wrote:
> > > Also, I see you're passing an inode to read_dir.  Why did you decide to
> > > do that?  There's information in the struct file that's either necessary
> > > or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> > > network filesystems need user credentials to do readdir, which are stored
> > > in struct file.  Block filesystems store readahead data in struct file.
> > 
> > Because the two file systems we have don't use anything from `struct
> > file` beyond the inode.
> > 
> > Passing a `file` to `read_dir` would require us to introduce an
> > unnecessary abstraction that no one uses, which we've been told not to
> > do.
> > 
> > There is no technical reason that makes it impractical though. We can
> > add it when the need arises.
> 
> Then we shouldn't merge any of this, or even send it out for review
> again until there is at least one non-toy filesystems implemented.
> Either stick to the object orientation we've already defined (ie
> separate aops, iops, fops, ... with substantially similar arguments)
> or propose changes to the ones we have in C.  Dealing only with toy
> filesystems is leading you to bad architecture.

Not sure I agree - this is a "waterfall vs. incremental" question, and
personally I would go with doing things incrementally here.

We don't need to copy the C interface as is; we can use this as an
opportunity to incrementally design a new API that will obviously take
lessons from the C API (since it's wrapping it), but it doesn't have to
do things the same and it doesn't have to do everything all at once.

Anyways, like you alluded to the C side is a bit of a mess w.r.t. what's
in a_ops vs. i_ops, and cleaning that up on the C side is a giant hassle
because then you have to fix _everything_ that implements or consumes
those interfaces at the same time.

So instead, it would seem easier to me to do the cleaner version on the
Rust side, and then once we know what that looks like, maybe we update
the C version to match - or maybe we light it all on fire and continue
with rewriting everything in Rust... *shrug*

