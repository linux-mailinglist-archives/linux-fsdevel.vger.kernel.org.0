Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9924206D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHKTjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:39:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgHKTjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:39:20 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k5a7A-0001Ts-UI; Tue, 11 Aug 2020 19:39:17 +0000
Date:   Tue, 11 Aug 2020 21:39:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200811193916.zcwebstmbyvushau@wittgenstein>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
 <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:05:22AM -0700, Linus Torvalds wrote:
> On Tue, Aug 11, 2020 at 8:30 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > What's the disadvantage of doing it with a single lookup WITH an enabling flag?
> >
> > It's definitely not going to break anything, so no backward
> > compatibility issues whatsoever.
> 
> No backwards compatibility issues for existing programs, no.
> 
> But your suggestion is fundamentally ambiguous, and you most
> definitely *can* hit that if people start using this in new programs.
> 
> Where does that "unified" pathname come from? It will be generated
> from "base filename + metadata name" in user space, and
> 
>  (a) the base filename might have double or triple slashes in it for
> whatever reasons.
> 
> This is not some "made-up gotcha" thing - I see double slashes *all*
> the time when we have things like Makefiles doing
> 
>     srctree=../../src/
> 
> and then people do "$(srctree)/". If you haven't seen that kind of
> pattern where the pathname has two (or sometimes more!) slashes in the
> middle, you've led a very sheltered life.
> 
>  (b) even if the new user space were to think about that, and remove
> those (hah! when have you ever seen user space do that?), as Al
> mentioned, the user *filesystem* might have pathnames with double
> slashes as part of symlinks.
> 
> So now we'd have to make sure that when we traverse symlinks, that
> O_ALT gets cleared. Which means that it's not a unified namespace
> after all, because you can't make symlinks point to metadata.
> 
> Or we'd retroactively change the semantics of a symlink, and that _is_
> a backwards compatibility issue. Not with old software, no, but it
> changes the meaning of old symlinks!
> 
> So no, I don't think a unified namespace ends up working.
> 
> And I say that as somebody who actually loves the concept. Ask Al: I
> have a few times pushed for "let's allow directory behavior on regular
> files", so that you could do things like a tar-filesystem, and access
> the contents of a tar-file by just doing
> 
>     cat my-file.tar/inside/the/archive.c
> 
> or similar.
> 
> Al has convinced me it's a horrible idea (and there you have a
> non-ambiguous marker: the slash at the end of a pathname that
> otherwise looks and acts as a non-directory)
> 

Putting my kernel hat down, putting my userspace hat on.

I'm looking at this from a potential user of this interface.
I'm not a huge fan of the metadata fd approach I'd much rather have a
dedicated system call rather than opening a side-channel metadata fd
that I can read binary data from. Maybe I'm alone in this but I was
under the impression that other users including Ian, Lennart, and Karel
have said on-list in some form that they would prefer this approach.
There are even patches for systemd and libmount, I thought?

But if we want to go down a completely different route then I'd prefer
if this metadata fd with "special semantics" did not in any way alter
the meaning of regular paths. This has the potential to cause a lot of
churn for userspace. I think having to play concatenation games in
shared libraries for mount information is a bad plan in addition to all
the issues you raised here.

Christian
