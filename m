Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4B5ACFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 21:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfF2TGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 15:06:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfF2TGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:06:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhIg4-0007QN-HD; Sat, 29 Jun 2019 19:06:24 +0000
Date:   Sat, 29 Jun 2019 20:06:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: shrink_dentry_list() logics change (was Re: [RFC PATCH v3 14/15]
 dcache: Implement partial shrink via Slab Movable Objects)
Message-ID: <20190629190624.GU17978@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
 <20190411210200.GH2217@ZenIV.linux.org.uk>
 <20190629040844.GS17978@ZenIV.linux.org.uk>
 <20190629043803.GT17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629043803.GT17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 05:38:03AM +0100, Al Viro wrote:

> PS: the problem is not gone in the next iteration of the patchset in
> question.  The patch I'm proposing (including dput_to_list() and _ONLY_
> compile-tested) follows.  Comments?

FWIW, there's another unpleasantness in the whole thing.  Suppose we have
picked a page full of dentries, all with refcount 0.  We decide to
evict all of them.  As it turns out, they are from two filesystems.
Filesystem 1 is NFS on a server, with currently downed hub on the way
to it.  Filesystem 2 is local.  We attempt to evict an NFS dentry and
get stuck - tons of dirty data with no way to flush them on server.
In the meanwhile, admin tries to unmount the local filesystem.  And
gets stuck as well, since umount can't do anything to its dentries
that happen to sit in our shrink list.

I wonder if the root of problem here isn't in shrink_dcache_for_umount();
all it really needs is to have everything on that fs with refcount 0
dragged through __dentry_kill().  If something had been on a shrink
list, __dentry_kill() will just leave behind a struct dentry completely
devoid of any connection to superblock, other dentries, filesystem
type, etc. - it's just a piece of memory that won't be freed until
the owner of shrink list finally gets around to it.  Which can happen
at any point - all they'll do to it is dentry_free(), and that doesn't
need any fs-related data structures.

The logics in shrink_dcache_parent() is
	collect everything evictable into a shrink list
	if anything found - kick it out and repeat the scan
	otherwise, if something had been on other's shrink list
		repeat the scan

I wonder if after the "no evictable candidates, but something
on other's shrink lists" we ought to do something along the
lines of
	rcu_read_lock
	walk it, doing
		if dentry has zero refcount
			if it's not on a shrink list,
				move it to ours
			else
				store its address in 'victim'
				end the walk
	if no victim found
		rcu_read_unlock
	else
		lock victim for __dentry_kill
		rcu_read_unlock
		if it's still alive
			if it's not IS_ROOT
				if parent is not on shrink list
					decrement parent's refcount
					put it on our list
				else
					decrement parent's refcount
			__dentry_kill(victim)
		else
			unlock
	if our list is non-empty
		shrink_dentry_list on it
in there...
