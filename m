Return-Path: <linux-fsdevel+bounces-7273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C4823794
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F422867C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37771DA4C;
	Wed,  3 Jan 2024 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ryvZdaw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1C1DDE0;
	Wed,  3 Jan 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mevc66h8/YxLoi9wAdpdKGyoq3lct+F8bAue6hHvt8U=; b=ryvZdaw25tkBx62MMMAokDj+sv
	Xu16nIxI4VKMfhO2Bz/pCYQ8wrIPdkYPbh9I61CDiT/jhEJVoTN97bO89Nnlu2HcvDkOJumBauzot
	WSwrN3XPMDPvjKlDqOZi38GVI9f8SGs5zDEilx0VX6Ji2he3ahgCeCcMAH6AmKYp8cGGDtfLc4zp6
	wAqPLIXYIFTFq9XLGup06M6avGfp15hfLtr9xBf9/g6Hc0ytS18eTZvMCKQixJhmf2TLtLrVBJEHy
	UEnxTBNIs+4JSaOohoAfYnSTPetakC2dMvDCyuErGeRi5Tnub+yC66+8hsuBWZdJ4bX1F0vmeTV6B
	QFCVR4jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9Vc-000owZ-0C;
	Wed, 03 Jan 2024 22:14:44 +0000
Date: Wed, 3 Jan 2024 22:14:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103221444.GM1674809@ZenIV>
References: <20240103102553.17a19cea@gandalf.local.home>
 <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home>
 <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 03, 2024 at 01:54:36PM -0800, Linus Torvalds wrote:

> Again: UNTESTED, and meant as a "this is another way to avoid messing
> with the dentry tree manually, and just using the VFS interfaces we
> already have"

That would break chown(), though.  From conversation back in November:

17:50 #kernel: < viro> while we are at it, why not simply supply ->permission() and ->getattr() that would pick gid from superblock 
 and shove them into ->i_gid?
17:50 #kernel: < viro> and called the default variants
17:50 #kernel: < viro> no need to scan the tree, etc.
17:51 #kernel: < viro> how many place in VFS or VM give a fuck about GID of inode?
17:53 #kernel: < viro> stat() and permission checks
17:56 #kernel: < viro> but that boils down to "well, generic getattr and permission use that field and on-disk filesystems use it to keep track of what value to put on disk"
17:56 #kernel: < viro> you can trivially override the defaults for ->permission() and ->getattr()
17:57 #kernel: < viro> and have them set the right ->i_gid whenever called

17:58 #kernel: < viro> what do you want to happen for chown() + remount?
17:58 #kernel: < viro> any group changes from the former lost on the latter?
18:00 #kernel: < viro> if you want the current semantics, slap generation counter in superblock (bumped on remount)
18:00 #kernel: < viro> sample it into inode on ->setattr()
18:01 #kernel: < viro> and have ->permission() and ->getattr() compare inode and superblock gen counts, picking ->i_gid from superblock if it's more recent there
18:02 #kernel: < viro> if you want the result of chown() to stick, have it stuff ~0U into inode's gen counter instead of sampling the superblock's counter there

18:17 #kernel: < viro> OK... so we need to filter SB_I_VERSION out of flags on mount/remount, lest the timestamp updates start playing silly buggers with it
18:18 #kernel: < viro> and use inode_..._iversion_raw() for access
18:19 #kernel: < viro> or use ->i_generation, perhaps...
18:20 #kernel: < viro> 32bit, but if somebody does 4G mount -o remount, they are deliberately asking for trouble

21:37 #kernel: < viro> hmm...
21:37 #kernel: < viro> ->d_revalidate() as well, probably
21:39 #kernel: < viro> rostedt: my apologies, looks like I had been too optimistic

I have the beginnings of patch along those lines stuck in the local tree, but
the problem had been that ->d_revalidate() is not always called on the way to
some places where ->i_uid/->i_gid is accessed ;-/

I can resurrect the analysis, but that'll take a few hours.

