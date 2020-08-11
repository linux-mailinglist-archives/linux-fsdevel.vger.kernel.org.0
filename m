Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8B2421D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHKVUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKVUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:20:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B2C06174A;
        Tue, 11 Aug 2020 14:20:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5bgs-00DlEE-SY; Tue, 11 Aug 2020 21:20:14 +0000
Date:   Tue, 11 Aug 2020 22:20:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200811212014.GN1236603@ZenIV.linux.org.uk>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
 <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:28:31PM +0200, Miklos Szeredi wrote:
> On Tue, Aug 11, 2020 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > Since a////////b has known meaning, and lots of applications
> > play loose with '/', its really dangerous to treat the string as
> > special. We only get away with '.' and '..' because their behavior
> > was defined before many of y'all were born.
> 
> So the founding fathers have set things in stone and now we can't
> change it.   Right?

Right.

> Well that's how it looks... but let's think a little; we have '/' and
> '\0' that can't be used in filenames.  Also '.' and '..' are
> prohibited names. It's not a trivial limitation, so applications are
> probably not used to dumping binary data into file names.  And that
> means it's probably possible to find a fairly short combination that
> is never used in practice (probably containing the "/." sequence).

No, it is not.  Miklos, get real - you will end up with obscure
pathname produced once in a while by a script fragment from hell
spewed out by crusty piece of awk buried in a piece of shit
makefile from hell (and you are lucky if it won't be an automake
output, while we are at it).  Exercised only when some shipped
turd needs to be regenerated.  Have you _ever_ tried to debug e.g.
gcc build problems?  I have, and it's extremely unpleasant.  Failures
tend to be obscure as hell, backtracking them through the makefiles
is a massive PITA and figuring out why said piece of awk produces
what it does...

I know what I would've done if the likely 5 hours of cursing everything
would have ended up with discovery that some luser had assumed that
surely, no sane software would ever generate this sequence of characters
in anything used as a pathname, and that for this reason I'm looking
forward to several more hours of playing with utterly revolting crap
to convince it to stay away from that sequence...

> Why couldn't we reserve such a combination now?
> 
> I have no idea how to find such it, but other than that, I see no
> theoretical problem with extending the list of reserved filenames.

"not breaking userland", for one.
