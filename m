Return-Path: <linux-fsdevel+bounces-7327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76121823A57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2611F262BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFA4C92;
	Thu,  4 Jan 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mgbMsV5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286554C65;
	Thu,  4 Jan 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VLcWWTAKpy632w/uyfnrcBEZtTlicseYYv0f54dfEQw=; b=mgbMsV5SX7AG8o7WEu6dvud4lF
	KQ8mBx29eLPFhAmiXUCU5TPGTy0WBGWyyneay0RFnXaYMwy72s0K3tkPoeXeapvqHY14ziZuLMcTW
	XSjJpBcO4n14tdhOnCMRhjb4cccWMlw4a9lU1nraFtQSOxyTWVWkYEGOK9jUuVGf33Cc1EIi6ESFG
	b6CkLqborIRdLPsWUs+VAk4mlsGJwBxt+6Ep4RIPMOJYfPaH9zN1vSAZHvfnQqNhqrVvgtjPh59GZ
	cv7xpG0MskJ4djMEyC8FAjEa2o/2jXOjQuQbqbrjPaGqplY0vSHTTxOj4jHWnFUmXBhyViUfDlOPO
	oO1nnGwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLCr2-00DzGt-Hr; Thu, 04 Jan 2024 01:49:04 +0000
Date: Thu, 4 Jan 2024 01:49:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZYOkCyujEaR7TdX@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>

On Wed, Jan 03, 2024 at 04:04:26PM -0300, Wedson Almeida Filho wrote:
> On Wed, 3 Jan 2024 at 15:02, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Oct 31, 2023 at 05:14:08PM -0300, Wedson Almeida Filho wrote:
> > > > Also, I see you're passing an inode to read_dir.  Why did you decide to
> > > > do that?  There's information in the struct file that's either necessary
> > > > or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> > > > network filesystems need user credentials to do readdir, which are stored
> > > > in struct file.  Block filesystems store readahead data in struct file.
> > >
> > > Because the two file systems we have don't use anything from `struct
> > > file` beyond the inode.
> > >
> > > Passing a `file` to `read_dir` would require us to introduce an
> > > unnecessary abstraction that no one uses, which we've been told not to
> > > do.
> > >
> > > There is no technical reason that makes it impractical though. We can
> > > add it when the need arises.
> >
> > Then we shouldn't merge any of this, or even send it out for review
> > again until there is at least one non-toy filesystems implemented.
> 
> What makes you characterize these filesystems as toys? The fact that
> they only use the file's inode in iterate_shared?

They're not real filesystems.  You can't put, eg, root or your home
directory on one of these filesystems.

> > Either stick to the object orientation we've already defined (ie
> > separate aops, iops, fops, ... with substantially similar arguments)
> > or propose changes to the ones we have in C.  Dealing only with toy
> > filesystems is leading you to bad architecture.
> 
> I'm trying to understand the argument here. Are saying that Rust
> cannot have different APIs with the same performance characteristics
> as C's, unless we also fix the C apis?
> 
> That isn't even a requirement when introducing new C apis, why would
> it be a requirement for Rust apis?

I'm saying that we have the current object orientation (eg each inode
is an object with inode methods) for a reason.  Don't change it without
understanding what that reason is.  And moving, eg iterate_shared() from
file_operations to struct file_system_type (effectively what you've done)
is something we obviously wouldn't want to do.

