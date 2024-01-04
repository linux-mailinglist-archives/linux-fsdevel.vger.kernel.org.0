Return-Path: <linux-fsdevel+bounces-7409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960D824889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1910DB21432
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FDC28E3B;
	Thu,  4 Jan 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtpCyBrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C32C681;
	Thu,  4 Jan 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Axy8b7yTVmlWQ3J02cuBqfZM28j68uaGpo9P0Q0lef8=; b=FtpCyBrszIbomqrZcJVs3ACgAW
	jDaVkMzCrpfEduq46FlNmEmn4hXnLMFsBg/yqd/I5v90EiMxxbIRvhAsAGO8hx7whKKpzMCuKRodz
	jxPOoxGNXqudhGsrX2cazJQgtZvGc/TciQavrsTx1Lzu/lyrMeerdNTAVuCN92kx3/su0GhP7ZQ75
	C2Bef3Q+0tphpjBh6MYfAkMKaAhxeo75tiwrJWrBx34n8WNX0Nsx81jvtHYYslD7MC0bVvBGcKEGC
	tC5ZaFwAoIj6g9b3ucxQrmVQlOssd64/r+DVgjxHN4M0Tze+MYcEQMZumo2yqVV8fsiFkHPQeOMUl
	U/6jHccQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLSzw-00Fnxu-9n; Thu, 04 Jan 2024 19:03:20 +0000
Date: Thu, 4 Jan 2024 19:03:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <ZZcA+LnSFyZFuqNX@casper.infradead.org>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home>
 <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104100544.593030e0@gandalf.local.home>

On Thu, Jan 04, 2024 at 10:05:44AM -0500, Steven Rostedt wrote:
> > file_system_type: what filesystem instances belong to.  Not quite the same
> > thing as fs driver (one driver can provide several of those).  Usually
> > it's 1-to-1, but that's not required (e.g. NFS vs NFSv4, or ext[234], or...).
> 
> I don't know the difference between NFS and NFSv4 as I just used whatever
> was the latest. But I understand the ext[234] part.

What Al's sying is that nfs.ko provides both nfs_fs_type and
nfs4_fs_type.  ext4.ko provides ext2_fs_type, ext3_fs_type and
ext4_fs_type.  This is allowed but anomalous.  Most filesystems provide
only one, eg ocfs2_fs_type.

> > 
> > super_block: individual filesystem instance.  Hosts dentry tree (connected or
> > several disconnected parts - think NFSv4 or the state while trying to get
> > a dentry by fhandle, etc.).
> 
> I don't know how NFSv4 works, I'm only a user of it, I never actually
> looked at the code. So that's not the best example, at least for me.

Right, so NFS (v4 or otherwise) is Special.  In the protocol, files
are identified by a thing called an fhandle.  This is (iirc) a 32-byte
identifier which must persist across server reboot.  Originally it was
probably supposed to encode dev_t plus ino_t plus generation number.
But you can do all kinds of things in the NFS protocol with an fhandle
that you need a dentry for in Linux (like path walks).  Unfortunately,
clients can't be told "Hey, we've lost context, please rewalk" (which
would have other problems anyway), so we need a way to find the dentry
for an fhandle.  I understand this very badly, but essentially we end
up looking for canonical ones, and then creating isolated trees of
dentries if we can't find them.  Sometimes we then graft these isolated
trees into the canonical spots if we end up connecting them through
various filesystem activity.

At least that's my understanding which probably contains several
misunderstandings.

> >  Filesystem object contents belongs here; multiple hardlinks
> > have different dentries and the same inode.
> 
> So, can I assume that an inode could only have as many dentries as hard
> links? I know directories are only allowed to have a single hard link. Is
> that why they can only have a single dentry?

There could be more.  For example, I could open("A"); ln("A", "B");
open("B"); rm("A"); ln("B", "C"); open("C"); rm("B").

Now there are three dentries for this inode, its link count is currently
one and never exceeded two.

> Thanks for this overview. It was very useful, and something I think we
> should add to kernel doc. I did read Documentation/filesystems/vfs.rst but
> honestly, I think your writeup here is a better overview.

Documentation/filesystems/locking.rst is often a better source, although
the two should really be merged.  Not for the faint-hearted.

