Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8921244604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHNH6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgHNH6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:58:44 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA78C061383;
        Fri, 14 Aug 2020 00:58:43 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 973F3E814D8;
        Fri, 14 Aug 2020 09:58:37 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 1001B16081D; Fri, 14 Aug 2020 09:58:36 +0200 (CEST)
Date:   Fri, 14 Aug 2020 09:58:36 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API
Message-ID: <20200814075836.GA230635@gardel-login>
References: <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
 <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 12.08.20 12:50, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
> >
> > The point of this is to give us the ability to monitor mounts from
> > userspace.
>
> We haven't had that before, I don't see why it's suddenly such a big deal.
>
> The notification side I understand. Polling /proc files is not the answer.
>
> But the whole "let's design this crazy subsystem for it" seems way
> overkill. I don't see anybody caring that deeply.
>
> It really smells like "do it because we can, not because we must".

With my systemd maintainer hat on (and of other userspace stuff),
there's a couple of things I really want from the kernel because it
would fix real problems for us:

1. we want mount notifications that don't require to scan
   /proc/self/mountinfo entirely again every time things change, over
   and over again, simply because that doesn't scale. We have various
   bugs open about this performance bottleneck, I could point you to,
   but I figure it's easy to see why this currently doesn't scale...

2. We want an unpriv API to query (and maybe set) the fs UUID, like we
   have nowadays for the fs label FS_IOC_[GS]ETFSLABEL

3. We want an API to query time granularity of file systems
   timestamps. Otherwise it's so hard in userspace to reproducibly
   re-generate directory trees. We need to know for example that some
   fs only has 2s granularity (like fat).

4. Similar, we want to know if an fs is case-sensitive for file
   names. Or case-preserving. And which charset it accepts for filenames.

5. We want to know if a file system supports access modes, xattrs,
   file ownership, device nodes, symlinks, hardlinks, fifos, atimes,
   btimes, ACLs and so on. All these things currently can only be
   figured out by changing things and reading back if it worked. Which
   sucks hard of course.

6. We'd like to know the max file size on a file system.

7. Right now it's hard to figure out mount options used for the fs
   backing some file: you can now statx() the file, determine the
   mnt_id by that, and then search that in /proc/self/mountinfo, but
   it's slow, because again we need to scan the whole file until we
   find the entry we need. And that can be huge IRL.

8. Similar: we quite often want to know submounts of a mount. It would
   be great if for that kind of information (i.e. list of mnt_ids
   below some other mnt_id) we wouldn't have to scan the whole of
   /p/s/mi again. In many cases in our code we operate recursively,
   and want to know the mounts below some specific dir, but currently
   pay performance price for it if the number of file systems on the
   host is huge. This doesn't sound like a biggie, but actually is a
   biggie. In systemd we spend a lot of time scaninng /p/s/mi...

9. How are file locks implemented on this fs? Are they local only, and
   orthogonal to remote locks? Are POSIX and BSD locks possibly merged
   at the backend? Do they work at all?

I don't really care too much how an API for this looks like, but let
me just say that I am not a fan of APIs that require allocating an fd
for querying info about an fd. This 'feels' a bit too recursive: if
you expose information about some fd in some magic procfs subdir, or
even in some virtual pseudo-file below the file's path then this means
we have to allocate a new fd to figure out things or the first fd, and
if we'd know the same info for that, we'd theoretically recurse
down. Now of course, most likely IRL we wouldn't actually recurse down,
but it is still smelly. In particular if fd limits are tight. I mean,
I really don't care if you expose non-file-system stuff via the fs, if
that's what you want, but I think exposing *fs* metainfo in the *fs*,
it's just ugly.

I generally detest APIs that have no chance to ever returning multiple
bits of information atomically. Splitting up querying of multiple
attributes into multiple system calls means they couldn't possibly be
determined in a congruent way. I much prefer APIs where we provide a
struct to fill in and do a single syscall, and at least for some
fields we'd know afterwards that the fields were filled in together
and are congruent with each other.

I am a fan of the statx() system call I must say. If we had something
like this for the file system itself I'd be quite happy, it could tick
off many of the requests I list above.

Hope this is useful,

Lennart

--
Lennart Poettering, Berlin
