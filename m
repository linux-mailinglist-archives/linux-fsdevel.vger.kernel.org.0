Return-Path: <linux-fsdevel+bounces-7659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6C828D67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EBFB24CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2D3D39F;
	Tue,  9 Jan 2024 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTK4nwDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0D3AC34;
	Tue,  9 Jan 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rCctwAWfiDoxb42kUYu+5LER8Jetw3fsb+LRP85kBXg=; b=UTK4nwDxhEyhHOcQoPAnCsJWhk
	JqQjaMsrQCo4uG24rfCYz+ftz/tfisvmSCR503s18eCCRgwllWJFT/6FQYwm5hpg6baFX64DfsudI
	pZFamxzsdW0gvORPEijm5oEtEX+IrkcZ/a2MtmUY0YqzxfKtXRRt7R5TeKQKpT2dhsLN4IFsJM1IQ
	+JXsF87p53raJIHSVkGU8n4gk4Iqddr1X9LUTFSq7pTnvRgSKhEvA4z3/IcChTw6W5py42zYQA/ED
	9HVLza7e9+biN2H3G2zUuCFc0X2DrEGeJ49egYdollgSjUmFCvd4Tpw6wqLwDK9EwOkMoE20F6qP0
	uS4zHV+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNHoN-00AEKu-19; Tue, 09 Jan 2024 19:30:55 +0000
Date: Tue, 9 Jan 2024 19:30:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZ2e7kxMettpFu6f@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
 <ZZYOkCyujEaR7TdX@casper.infradead.org>
 <CANeycqppvyhHhDSpRjxcNMGsKhm=-HCsR3fvpaH9FirNZCnSGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqppvyhHhDSpRjxcNMGsKhm=-HCsR3fvpaH9FirNZCnSGw@mail.gmail.com>

On Tue, Jan 09, 2024 at 03:25:11PM -0300, Wedson Almeida Filho wrote:
> On Wed, 3 Jan 2024 at 22:49, Matthew Wilcox <willy@infradead.org> wrote:
> > > What makes you characterize these filesystems as toys? The fact that
> > > they only use the file's inode in iterate_shared?
> >
> > They're not real filesystems.  You can't put, eg, root or your home
> > directory on one of these filesystems.
> 
> tarfs is a real file system, we use it to mount read-only container
> layers on top of dm-verity for integrity.

You're using it in production?  Oh dear.

> > > I'm trying to understand the argument here. Are saying that Rust
> > > cannot have different APIs with the same performance characteristics
> > > as C's, unless we also fix the C apis?
> > >
> > > That isn't even a requirement when introducing new C apis, why would
> > > it be a requirement for Rust apis?
> >
> > I'm saying that we have the current object orientation (eg each inode
> > is an object with inode methods) for a reason.  Don't change it without
> > understanding what that reason is.  And moving, eg iterate_shared() from
> > file_operations to struct file_system_type (effectively what you've done)
> > is something we obviously wouldn't want to do.
> 
> I don't think I'm changing anything. AFAICT, I'm adding a way to write
> file systems in Rust. It uses the C API faithfully -- if you find ways
> in which it doesn't, I'd be happy to fix them.

You are changing the _object model_.  The C API has separate objects
for inodes, files, filesystems, superblocks, dentries, etc, etc.  You've
just smashed all of it together into a FileSystem which implements all
of the inode, file, address_space, etc, etc ops.  And this is the wrong
approach.


