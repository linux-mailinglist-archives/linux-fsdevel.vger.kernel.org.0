Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4D184EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 19:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgCMSdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 14:33:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45386 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgCMSdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:33:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCp36-00AyVa-Sz; Fri, 13 Mar 2020 18:28:45 +0000
Date:   Fri, 13 Mar 2020 18:28:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Allison <jra@samba.org>,
        Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200313182844.GO23230@ZenIV.linux.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313095901.tdv4vl7envypgqfz@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 08:59:01PM +1100, Aleksa Sarai wrote:
> On 2020-03-12, Stefan Metzmacher <metze@samba.org> wrote:
> > Am 12.03.20 um 17:24 schrieb Linus Torvalds:
> > > But yes, if we have a major package like samba use it, then by all
> > > means let's add linkat2(). How many things are we talking about? We
> > > have a number of system calls that do *not* take flags, but do do
> > > pathname walking. I'm thinking things like "mkdirat()"?)
> > 
> > I haven't looked them up in detail yet.
> > Jeremy can you provide a list?
> > 
> > Do you think we could route some of them like mkdirat() and mknodat()
> > via openat2() instead of creating new syscalls?
> 
> I have heard some folks asking for a way to create a directory and get a
> handle to it atomically -- so arguably this is something that could be
> inside openat2()'s feature set (O_MKDIR?). But I'm not sure how popular
> of an idea this is.

For fuck sake, *NO*!

We don't need any more multiplexors from hell.  mkdir() and open() have
deeply different interpretation of pathnames (and anyone who asks for
e.g. traversals of dangling symlinks on mkdir() is insane).  Don't try to
mix those; even O_TMPFILE had been a mistake.

Folks, we'd paid very dearly for the atomic_open() merge.  We are _still_
paying for it - and keep finding bugs induced by the convoluted horrors
in that thing (see yesterday pull from vfs.git#fixes for the latest crop).
I hope to get into more or less sane shape (part - this cycle, with
followups in the next one), but the last thing we need is more complexity
in the area.

Keep the semantics simple and regular; corner cases _suck_.  "Infinitely
extensible (without review)" is no virtue.  And having nowhere to hide
very special flags for very special kludges is a bloody good thing.

Every fucking time we had a multiplexed syscall, it had been a massive
source of trouble.  IF it has a uniform semantics - fine; we don't need
arseloads of read_this(2)/read_that(2).  But when you need pages upon
pages to describe the subtle differences in the interpretation of
its arguments, you have already lost.  It will be full of corner
cases, they will get zero testing and they will rot.  Inevitably.  All
the faster for the lack of people who would be able to keep all of that
in head.

We do have a mechanism for multiplexing; on amd64 it lives in do_syscall_64().
We really don't need openat2() turning into another one.  Syscall table
slots are not in a short supply, and the level of review one gets from
"new syscall added" is higher than from "make fubar(2) recognize a new
member in options->union_full_of_crap if it has RESOLVE_TO_WANK_WITH_RIGHT_HAND
set in options->flags, affecting its behaviour in some odd ways".
Which is a good thing, damnit.
