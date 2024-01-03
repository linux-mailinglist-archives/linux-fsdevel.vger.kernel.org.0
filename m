Return-Path: <linux-fsdevel+bounces-7245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E95823410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B1E1F24BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB01C69A;
	Wed,  3 Jan 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhUs6e0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FD1C68D;
	Wed,  3 Jan 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWER9x+whBQFwVO4W3tJPiy6lVTMUJainTq9saVULFM=; b=qhUs6e0R3mEKJvT2GfbaqFGmTd
	f2st7nOpVu8hMouZeW3FWaQTslKXiE6ObQyPwGGuOdAKpVvVQf4ryCkpBiUBtC2tKcJ2Ccbai1K5z
	ekGtCAxf9ZqKtDZJIiKq87eorJPyP0FhbEdd3JyyvjJjdQs/klu/mbk0Hk3DxulucXW+nVKEOASwm
	pRkg4V0htH6BwRsyYtz5s66xPr3nFZv4SvNg2c4L1MAtDQxAsqCZf1rc5GAoxDXa75JDyNrZqF17k
	AMAVTnm1zkODEVvQFRL9c6rpE+DAdKa4acKR1sT/CrV+UxLQjpwCmOhWh0w6fFqDpQkK/JG3KANdi
	blSSwFLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rL5Zg-00DGdT-3U; Wed, 03 Jan 2024 18:02:40 +0000
Date: Wed, 3 Jan 2024 18:02:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZZWhQGkl0xPiBD5/@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>

On Tue, Oct 31, 2023 at 05:14:08PM -0300, Wedson Almeida Filho wrote:
> > Also, I see you're passing an inode to read_dir.  Why did you decide to
> > do that?  There's information in the struct file that's either necessary
> > or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> > network filesystems need user credentials to do readdir, which are stored
> > in struct file.  Block filesystems store readahead data in struct file.
> 
> Because the two file systems we have don't use anything from `struct
> file` beyond the inode.
> 
> Passing a `file` to `read_dir` would require us to introduce an
> unnecessary abstraction that no one uses, which we've been told not to
> do.
> 
> There is no technical reason that makes it impractical though. We can
> add it when the need arises.

Then we shouldn't merge any of this, or even send it out for review
again until there is at least one non-toy filesystems implemented.
Either stick to the object orientation we've already defined (ie
separate aops, iops, fops, ... with substantially similar arguments)
or propose changes to the ones we have in C.  Dealing only with toy
filesystems is leading you to bad architecture.

