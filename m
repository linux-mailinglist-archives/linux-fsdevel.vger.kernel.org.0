Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBCF60D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKIS0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Nov 2019 13:26:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKIS0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Nov 2019 13:26:05 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTVQv-00051B-Km; Sat, 09 Nov 2019 18:26:01 +0000
Date:   Sat, 9 Nov 2019 18:26:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wugyuan@cn.ibm.com, Jeff Layton <jlayton@kernel.org>,
        hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH][RFC] race in exportfs_decode_fh()
Message-ID: <20191109182601.GW26530@ZenIV.linux.org.uk>
References: <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191109031333.GA8566@ZenIV.linux.org.uk>
 <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 09, 2019 at 08:55:38AM -0800, Linus Torvalds wrote:
> On Fri, Nov 8, 2019 at 7:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > We have derived the parent from fhandle, we have a disconnected dentry for child,
> > we go look for the name.  We even find it.  Now, we want to look it up.  And
> > some bastard goes and unlinks it, just as we are trying to lock the parent.
> > We do a lookup, and get a negative dentry.  Then we unlock the parent... and
> > some other bastard does e.g. mkdir with the same name.  OK, nresult->d_inode
> > is not NULL (anymore).  It has fuck-all to do with the original fhandle
> > (different inumber, etc.) but we happily accept it.
> 
> No arguments with your patch, although I doubt that this case has
> actually ever happened in practice ;)

Frankly, by this point I'm rather tempted to introduce new sparse annotation for
dentries - "might not be positive".  The thing is, there are four cases when
->d_inode is guaranteed to be stable:
	1) nobody else has seen that dentry; that includes in-lookup ones - they
can be found in in-lookup hash by d_alloc_parallel(), but it'll wait until they
cease to be in-lookup.
	2) ->d_lock is held
	3) pinned positive
	4) pinned, parent held at least shared
Anything else can have ->d_inode changed by another thread.  And class 3 is by
far the most common.  As the matter of fact, most of dentry pointers in the
system (as opposed to (h)lists traversing dentries) are such.

For obvious reasons we have shitloads of ->d_inode accesses; I'd been going
through a tree-wide audit of those and doing that manually is bloody unpleasant.
And we do have races in that area - the one above is the latest I'd caught;
there had been more and I'm fairly sure that it's not the last.

Redoing that kind of audit every once in a while is something I wouldn't
wish on anyone; it would be nice to use sparse to narrow the field.  Note
that simply checking ->d_inode (or ->d_flags) is not enough unless we
know them to be stable.  E.g. callers of lookup_one_len_unlocked() tend
to be racy exactly because of such tests.  I'm going to add
lookup_positive_unlocked() that would return ERR_PTR(-ENOENT) on
negatives and convert the callers - with one exception they treat
negatives the same way they would treat ERR_PTR(-ENOENT) and their
tests are racy.  I'd rather have sufficient barriers done in one common
helper, instead of trying to add them in 11 places and hope that new
users won't fuck it up...

I'm still not sure what's the best way to do the annotations - propagation
is not a big deal, but expressing the transitions and checking that
maybe-negative ones are not misused is trickier.  The last part can
be actually left to manual audit - annotations would already reduce
the search area big way.  A not too ugly way to say that now this dentry
is known to be non-negative, OTOH...  I want to finish the audit and
take a good look at the list of places where such transitions happen.
