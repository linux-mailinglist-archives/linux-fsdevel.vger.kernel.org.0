Return-Path: <linux-fsdevel+bounces-62033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9914B82019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A1616BC69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1630DECB;
	Wed, 17 Sep 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fujaylDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC429ACEE;
	Wed, 17 Sep 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145355; cv=none; b=iVb1jFV0npIeeT2xexuxrnXOUxUoPKzpd1CN+LZznFI6jn/VCjVLcRXxwi58ZipdTwRZX1QJt9MZ752k/XQ+6eGY1OK6g51mQ9wRuynitLM3nNlQAmiYR7BEYx9eAhO9BbNWm+iljRqFqwsdcUHpn2IeN0NZLYnmyq1+KyiFhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145355; c=relaxed/simple;
	bh=nACUe0FSp68cspj0vtQsCKiZrJYGsqXNS1vUNt5ADbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeE3oW89zzmKERsQmVMuR0kK2OoGMCcZyxHzTOjOLWRxV6peJb+Pcpg9iZMDb6gbtIZQ+SXYVDCE0aascRnsBduTyILzSywO/MSsaz+oVMByEhhMHIXuSptIBd0a/SOlN6qA8+tLEk/BG9QRo7a98fabk5F/J3P0O1dVH7ZTCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fujaylDM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WiA4cNkcVugPJeaGJ538psZmIXMv7YQioKZQ8gTrQT0=; b=fujaylDMlrRZuozd8WGkA8xUs5
	obML/9dTfJzLt9IZahq8QmdwdaWWQl5tfmd7fCVNCSfVy5C+HY9i7X1NO56ExQdhDkdK6Xv39xACN
	ZXDE1aty3ryZ1rZuFk5n5/XRYy4/lbHFbwQq3N441qXXfLWfAx6dC6AlsLxy6QiyUwOv0yZVUINox
	wTbtmE7SJIqu6x/IaMZWGZmSmeLbEQ1XaJu3/x9UIizNdsxmz2vq1WPywbEJeCJTI4+UjF2g37jtX
	UqsMcs8q0e9m7Q0HBxKxXE98e785EEp7vA1+aJxDokL3q9vjL/Zd88/Y0oXJRQzIy+gxiFcKc9cLB
	2jFsJGEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzv3-000000098eu-2Sc6;
	Wed, 17 Sep 2025 21:42:29 +0000
Date: Wed, 17 Sep 2025 22:42:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917214229.GF39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV>
 <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV>
 <CAGudoHGDW9yiROidHio8Ow-yZb8uY7wMBjx94fJ7zTkL+rVAFg@mail.gmail.com>
 <20250917210241.GD39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917210241.GD39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:02:41PM +0100, Al Viro wrote:
> On Wed, Sep 17, 2025 at 10:39:22PM +0200, Mateusz Guzik wrote:
> 
> > Linux has to have something of the sort for dentries, otherwise the
> > current fput stuff would not be safe. I find it surprising to learn
> > inodes are treated differently.
> 
> If you are looking at vnode counterparts, dentries are closer to that.
> Inodes are secondary.
> 
> And no, it's not a "wait for references to go away" - every file holds
> a _pair_ of references, one to mount and another to dentry.
> 
> Additional references to mount => umount() gets -EBUSY, lazy umount()
> (with MNT_DETACH) gets the sucker removed from the mount tree, with
> shutdown deferred (at least) until the last reference to mount goes away.
> 
> Once the mount refcount hits zero and the damn thing gets taken apart,
> an active reference to superblock (i.e. to filesystem instance) is
> dropped.
> 
> If that was not the last one (e.g. it's mounted elsewhere as well), we
> are not waiting for anything.  If it *was* the last active ref, we
> shut the filesystem instance down; that's _it_ - once you are into
> ->kill_sb(), it's all over.
> 
> Linux VFS is seriously different from Heidemann's-derived ones you'll find in
> BSD land these days.  Different taxonomy of objects, among other things...

FWIW, the basic overview of objects:

super_block: filesystem instance.  Two refcounts (passive and active, having
positive active refcount counts as one passive reference).  Shutdown when
active refcount gets to zero; freeing of in-core struct super_block - when
passive gets there.

mount: a subtree of an active filesystem.  Most of them are in mount tree(s),
but they might exist on their own - e.g. pipefs one, etc.  Has a refcount,
bears an active reference to fs instance (super_block) *and* a reference to
a dentry belonging to that instance - root of the (sub)tree visible in
it.  Shutdown when refcount hits zero.  Being in mount tree contributes
to refcount; that contribution goes away when it's detached from the tree
(on umount, normally).  Refcount is responsible for -EBUSY from non-lazy
umount; lazy one (umount -l, umount2(path, MNT_DETACH)) dissolves the entire
subtree that used to be mounted at that point and shuts down everything
that had refcounts reach zero, leaving the rest until their refcounts drop
to zero too.  Shutdown drops the superblock and root dentry refs.

inode & dentry: that's what vnodes map onto.  Dentry is the main object,
inode is secondary.  Each belongs to a specific fs instance for the entire
lifetime.  Dentries form a forest; inodes are attached to some of them.
Details are a lot more involved than anything that would fit into a short
overview.  Both are refcounted, attaching dentry to an inode contributes
1 to inode's refcount.  Child dentry contributes 1 to refcount of parent.
Shutdown does *not* happen until the dentry refcount hits zero; once it's
zero, the normal policy is "keep it around if it's still hashed", but
filesystem may say "no point keeping it".  Memory pressure => kill the
ones with zero refcount (and if their parents had been pinned only by
those children, take the parents out as well, etc.).  Filesystem shutdown =>
kick out everything with zero refcount, complain if anything's left after
that (shrink_dcache_for_umount() does it, so if filesystem kept anything
pinned internally, it would better drop those before we get to that
point).  evict_inodes() does the same to inodes.

file: the usual; open IO channel, as on any Unix.  Carries a reference to
dentry and to mount.  Shutdown happens when refcount goes to zero, normally
delayed until return to userland, when we are on shallow stack and without
any locks held.  Incidentally, sockets and pipes come with those as well -
none of the "sockets don't have a vnode" headache.

cwd (and process's root as well): a pair of mount and dentry references.

