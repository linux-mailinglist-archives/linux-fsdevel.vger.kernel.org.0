Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C97242D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHLQeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHLQeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:34:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258B7C061383;
        Wed, 12 Aug 2020 09:34:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5thD-00EB4R-36; Wed, 12 Aug 2020 16:33:47 +0000
Date:   Wed, 12 Aug 2020 17:33:47 +0100
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
Message-ID: <20200812163347.GS1236603@ZenIV.linux.org.uk>
References: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk>
 <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:13:14PM +0200, Miklos Szeredi wrote:

> > Lovely.  And what of fchdir() to those?
> 
> Not allowed.

Not allowed _how_?  Existing check is "is it a directory"; what do you
propose?  IIRC, you've mentioned using readdir() in that context, so
it's not that you only allow to open the leaves there.

> > > > Is that a flat space, or can they be directories?"
> > >
> > > Yes it has a directory tree.   But you can't mkdir, rename, link,
> > > symlink, etc on anything in there.
> >
> > That kills the "shared inode" part - you'll get deadlocks from
> > hell that way.
> 
> No.  The shared inode is not for lookup, just for the open file.

Bloody hell...  So what inodes are you using for lookups?  And that
thing you would be passing to readdir() - what inode will _that_ have?

> > Next: what will that tree be attached to?  As in, "what's the parent
> > of its root"?  And while we are at it, what will be the struct mount
> > used with those - same as the original file, something different
> > attached to it, something created on the fly for each pathwalk and
> > lazy-umounted?  And see above re fchdir() - if they can be directories,
> > it's very much in the game.
> 
> Why does it have to have a struct mount?  It does not have to use
> dentry/mount based path lookup.

What the fuck?  So we suddenly get an additional class of objects
serving as kinda-sorta analogues of dentries *AND* now struct file
might refer to that instead of a dentry/mount pair - all on the VFS
level?  And so do all the syscalls you want to allow for such "pathnames"?

Sure, that avoids all questions about dcache interactions - by growing
a replacement layer and making just about everything in fs/namei.c,
fs/open.c, etc. special-case the handling of that crap.

But yes, the syscall-level interface will be simple.  Wonderful.

I really hope that's not what you have in mind, though.
