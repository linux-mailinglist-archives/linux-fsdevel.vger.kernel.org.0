Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B51140F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAQQse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:48:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35290 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgAQQsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:48:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isUnL-00AMg3-6W; Fri, 17 Jan 2020 16:48:27 +0000
Date:   Fri, 17 Jan 2020 16:48:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117164827.GM8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <9bfe61643b676d27abd5e3d7f8ca8ac907fbf65e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfe61643b676d27abd5e3d7f8ca8ac907fbf65e.camel@hammerspace.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:12:28PM +0000, Trond Myklebust wrote:

> > Unfortunately, it does *not* fit easily.  And IMO that's linux-abi
> > fodder more
> > than anything else.  The problem is in coming up with sane semantics
> > - there's
> > a plenty of corner cases with that one.  What to do when destination
> > is
> > a dangling symlink, for example?  Or has something mounted on it (no,
> > saying
> > "we'll just reject directories" is not enough).  What should happen
> > when
> > destination is already a hardlink to the same object?
> > 
> > It's less of a horror than rename() would've been, but that's not
> > saying
> > much.
> 
> We already have precedents for all of that when handling bog-standard
> open(O_CREAT) (which creates the first link to the file). Yes, there is
> the question of choosing whether to implement O_NOFOLLOW semantics or
> not, but that should be dictated by the requirements of the use case.
> 
> As for the "hard link on top of itself", that case is already well
> defined by POSIX to be a null op IIRC.

Where in POSIX does it say anything about it?  It is a null op for
rename, but for link it's EEXIST on the general grounds.

> What in the proposal is requiring new semantics beyond these precedents
> already set by open() and link() itself?

The fact that O_CREAT does not do anything to the existing target,
perhaps?  This, unless I'm seriously misunderstanding the proposal,
should have the preexisting link removed.  Which makes it a lot
more similar to "unlink target, then link source to target, atomically"
than to O_CREAT.

Incidentally,

echo foo >/tmp/foo
echo bar >/tmp/bar
ln /tmp/foo /tmp/foo2
mount --bind /tmp/foo /tmp/bar
echo a >/tmp/bar
cat /tmp/foo2

will print "a" - IOW, O_CREAT in the redirect of that last echo will
	find /tmp/bar
	see it overmounted (by /tmp/foo)
	access /tmp/foo, which happens to be the same file as /tmp/foo2

What would you want that link() variant do in similar situation
(i.e. mount traversal at the end of pathname)?  I can see several
variants of behaviour, none of them too appealing.

What should happen if target is opened by somebody?  I would expect it
to be treated as opened-and-unlinked (with sillyrename if fs requires
that).  Which is where the corner case with target already being a link
to source comes from...

For fuck sake, I'm not being obstructionist - if you (or David, or anyone
else) is willing to come up with sane semantics (I'm _not_ talking about
implementation, VFS or fs data structures, etc. - just the rules describing
what the effect should it have), great, I'll be happy to help with the
implementation side.  As well as poking holes in said proposal (i.e.
asking what should happen in such and such case).

But it's really _not_ as trivial as "do by analogy with O_CREAT".  I don't
have any problem with discussing that over email, but latencies do suck
sometimes (e.g. when discussing autofs ->d_manage() semantics, with
3-way conversation - one participant on US east coast, one in UK, one
on AU west coast), so I understand why David (who'd just had exactly that
lovely experience) might find an idea of doing that face-to-face appealing...
