Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8611E242BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHLPIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLPIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:08:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8FC061383;
        Wed, 12 Aug 2020 08:08:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5sMJ-00E8Uk-5O; Wed, 12 Aug 2020 15:08:07 +0000
Date:   Wed, 12 Aug 2020 16:08:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200812150807.GR1236603@ZenIV.linux.org.uk>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
 <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:46:20PM +0200, Miklos Szeredi wrote:

> > "Can those suckers be passed to
> > ...at() as starting points?
> 
> No.

Lovely.  And what of fchdir() to those?  Are they all non-directories?
Because the starting point of ...at() can be simulated that way...

> >  Can they be bound in namespace?
> 
> No.
> 
> > Can something be bound *on* them?
> 
> No.
> 
> >  What do they have for inodes
> > and what maintains their inumbers (and st_dev, while we are at
> > it)?
> 
> Irrelevant.  Can be some anon dev + shared inode.
> 
> The only attribute of an attribute that I can think of that makes
> sense would be st_size, but even that is probably unimportant.
> 
> >  Can _they_ have secondaries like that (sensu Swift)?
> 
> Reference?

http://www.online-literature.com/swift/3515/
	So, naturalists observe, a flea
	Has smaller fleas that on him prey;
	And these have smaller still to bite 'em,
	And so proceed ad infinitum.
of course ;-)
IOW, can the things in those trees have secondary trees on them, etc.?
Not "will they have it in your originally intended use?" - "do we need
the architecture of the entire thing to be capable to deal with that?"

> > Is that a flat space, or can they be directories?"
> 
> Yes it has a directory tree.   But you can't mkdir, rename, link,
> symlink, etc on anything in there.

That kills the "shared inode" part - you'll get deadlocks from
hell that way.  "Can't mkdir" doesn't save you from that.  BTW,
what of unlink()?  If the tree shape is not a hardwired constant,
you get to decide how it's initially populated...

Next: what will that tree be attached to?  As in, "what's the parent
of its root"?  And while we are at it, what will be the struct mount
used with those - same as the original file, something different
attached to it, something created on the fly for each pathwalk and
lazy-umounted?  And see above re fchdir() - if they can be directories,
it's very much in the game.
