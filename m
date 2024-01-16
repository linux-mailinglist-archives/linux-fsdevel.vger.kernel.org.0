Return-Path: <linux-fsdevel+bounces-8082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B027282F3BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E31C23801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFF1CD25;
	Tue, 16 Jan 2024 18:11:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6A1CD0B;
	Tue, 16 Jan 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428675; cv=none; b=c6nseegCZ9VSREN7Qic0+PQyKZzcWq/4Qlslov94vBWtJzeqzD5CLzlmTDBYAadoiUjGoVHSm/fr1l9eP7FR9gHzmKYvpRgjDO6+V3BuBMm+3RyErNePdG6yMBixFTfQ2xKOR4ZBxjV9La+8IiagH2MkIfpVYMctpFAGtjyfe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428675; c=relaxed/simple;
	bh=HF08xReEYJVEYlyq4VqGFGWbxcsg4P7vW27ttWr2NEg=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Yqv5zaMQ2+XkJZGANimrYL1L84VNuXIg35fqK7SWvzE14Zf4kK/9oiDy7ctNT835UaLrbeyl95vtTXC+aFYxMnURnboeXpLexFyU0NU+ECmxDn+XCMnwjOI/kGsEHXtNskJX05WWlzNy2O9/V43yypikr5FtPXJJhr/+JOW0yVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5D4C433F1;
	Tue, 16 Jan 2024 18:11:13 +0000 (UTC)
Date: Tue, 16 Jan 2024 13:12:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 kernel test robot <oliver.sang@intel.com>, Ajay Kaher <akaher@vmware.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] eventfs: Create dentries and inodes at dir open
Message-ID: <20240116131228.3ed23d37@gandalf.local.home>
In-Reply-To: <CAHk-=wjna5QYoWE+v3BWDwvs8N=QWjNN=EgxTN4dBbmySc-jcg@mail.gmail.com>
References: <20240116114711.7e8637be@gandalf.local.home>
	<CAHk-=wjna5QYoWE+v3BWDwvs8N=QWjNN=EgxTN4dBbmySc-jcg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 09:55:15 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [ html crud because I still don't have power or real Internet, just trying
> to keep an eye on things on my phone. Mailing lists removed to avoid
> bounces, please put them back in replies that don't have my horrible
> formatting ]
> 
> No.
> 
> Christ, you're making things worse again
> 
> The reason for the bug is that you're still messing with the dentries at
> readdir() time.

I may have deleted the comment, but the only reason I created the
inodes/destries is to keep the consistent inode number as it's created at
the time the inodes and dentries are.

Ah I did delete the comment, but it is still applicable :-/

       /*
-        * Need to create the dentries and inodes to have a consistent
-        * inode number.
+        * Need to make a struct eventfs_dent array, start by
+        * allocating enough for just the files, which is a fixed
+        * array. Then use realloc via add_entry() for the directories
+        * which is stored in a linked list.
         */

So if for some reason, user space did a getdents() and used the inode
numbers to match what it found, they would likely be the same.

> 
> Just stop it. Readdir should not be creating dentries. Readdir should not
> be even *looking* at dentries. You're not a virtual filesystem, the
> dentries are just caches for filename lookup, and have *nothing* to do with
> readdir.

Actually, it's not looking at them. I did it as a way to just have the
inode numbers be consistent.

	dents[cnt].ino = d->d_inode->i_ino;

Yes, that's the only reason I create them. The dentry/inode is not used for
anything outside of that.

> 
> So just iterate over your own internal data structures in readdir. DO NOT
> CREATE DENTRIES OR INODES FOR READDIR.
> 
> I've told you before, and I'll tell you again: either you are a real and
> proper virtual filesystem and you let the vfs layer manage *everything*,
> and the dentries and inodes are all you have. Or you are a *real*
> filesystem and you maintain your own data structures and the dentries and
> inodes are just the in-memory caches.
> 
> This "do both" is UNACCEPTABLE.
> 

The dentries were created for the inode numbers so that I did not need to
add them to meta data. They are generated at creation time.

I don't know how important inode numbers are. If they can all just have
random inode numbers and it doesn't break user space, where an inode number
will be one value at one read and another shortly after, is that going to
cause a problem?

Maybe I can just use a hash to generate he inode numbers from the name?
Hopefully there will be no collisions. Then I don't need the dentry
creation at all.

I do realize that if the dentries get freed due to reclaim and recreated,
their inode numbers will be different. But for a virtual file system, I
don't know how important having consistent inode numbers is.

-- Steve


