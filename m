Return-Path: <linux-fsdevel+bounces-7259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5338236AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3200C1F25980
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE71CABB;
	Wed,  3 Jan 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VG0xO2tO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4071DA22
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Jan 2024 15:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704314292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFxyz9wssG6um4s3MhUM+MnW6V8Bjf+t4BOKKcwlx0A=;
	b=VG0xO2tO+cS7WdgFJ6ioE19dU8Gw79wBE2v0qNr+1F0BHkoi7ZLU92Gj9lU8DHTDIf0lzQ
	XNrYFmqqyuPX7em73otxDHNTndi+TS8PUhr+6A/1ikaxZFXLvEVZ/EGaxO+TZ+t1c9EoM3
	zNqVUfuyhtgra/VmfDWm6bAEaB+S0UI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <nmpmqptnjgblqyhiz4ma7inevim7h4qh56jobbvmdyucfc754z@nx5nkrijuavp>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
 <20240103195358.GK1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103195358.GK1674809@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 03, 2024 at 07:53:58PM +0000, Al Viro wrote:
> On Wed, Jan 03, 2024 at 04:04:26PM -0300, Wedson Almeida Filho wrote:
> 
> > > Either stick to the object orientation we've already defined (ie
> > > separate aops, iops, fops, ... with substantially similar arguments)
> > > or propose changes to the ones we have in C.  Dealing only with toy
> > > filesystems is leading you to bad architecture.
> > 
> > I'm trying to understand the argument here. Are saying that Rust
> > cannot have different APIs with the same performance characteristics
> > as C's, unless we also fix the C apis?
> 
> Different expressive power, not performance characteristics.
> 
> It's *NOT* about C vs Rust; we have an existing system of objects and
> properties of such.  Independent from the language being used to work
> with them.
> 
> If we have to keep a separate system for your language, feel free to fork
> the kernel and do whatever you want with it.  Just don't expect anybody
> else to play with your toy.

The rust people have been getting conflicting advice, and your response
is to tell them to fork the kernel and go away?

> In case it's not entirely obvious - your arguments about not needing
> something or other for the instances you have tried to work with so far
> do not hold water.  At all.
> 
> The only acceptable way to use Rust in that space is to treat the existing
> set of objects and operations as externally given; we *can* change those,
> with good enough reasons, but "the instances in Rust-using filesystems 
> don't need this and that" doesn't cut it.

The question was just about whether to add something now that isn't used
on the Rust side yet, or wait until later when it is.

I think this has gone a bit afield, and gotten a bit dramatic.

