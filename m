Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE52250BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHXW35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 18:29:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60100 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgHXW35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:29:57 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07OMTP7L027765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 18:29:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AD08A42010C; Mon, 24 Aug 2020 18:29:24 -0400 (EDT)
Date:   Mon, 24 Aug 2020 18:29:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        Frank van der Linden <fllinden@amazon.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200824222924.GF199705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824212656.GA17817@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <3081309.dU5VghuM72@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 05:30:18PM +0200, Christian Schoenebeck wrote:
> Ok, maybe I should make this more clear with another example: one major use
> case for forks/ADS is extending (e.g. proprietary) binary file formats with
> new features. Say company B is developing an editor application that supports
> working directly with a binary media file (format) of another company A. And
> say that company B's application has some feature that don't exist in app of
> company A.

But that's going to happen today (company B's feature silently getting
dropped) when using data forks/ADS if the file is sent via zip,
http/https, compressed using gzip, xz, bzip2, etc.  I remember that
world when I had to deal with with MacOS files decades ago, and it was
a total mess.

> > Keep in mind that you are not going to get universal support for ADS
> > any time soon as most filesystems will require on-disk format
> > changes to support them. Further, you are goign to have to wait for
> > the entire OS ecosystem to grow support for ADS (e.g. cp, tar,
> > rsync, file, etc) before you can actually use it sanely in
> > production systems. Even if we implement kernel support right now,
> > it will be years before it will be widely available and supported at
> > an OS/distro level...
> 
> Sure, that's a chicken egg problem.
> 
> Being realistic, I don't expect that forks are something that would be landing
> in Linux very soon. I think it is an effort that will take its time, probably
> as a Linux-test-fork / PoC for quite a while, up to a point where a common
> acceptance is reached.

We're talking *decades*.  It's not enough for new protocol specs for
https, rsync, nfs, etc., to be modified, and then implemented.  It's
not enough for file formats for zip, xz, gzip, etc., to be created;
all of this new software has to be deployed throughout the entire
ecosystem.  People don't upgrade server software quickly; look up long
IPv6 has taken to be adopted!

In that amount of time, it's going to be easier to implement a more
modular application container format which allows for new features to
be added into a file --- for example, such as ISO/IEC 26300....

> But file forks already exist on other systems for multiple good reasons. So I
> think it makes sense to thrive the effort on Linux as well.

They aren't actually used all that often with Windows/Windows Office.
That's why you can upload/upload a docx file via https, or check it
into git, etc. without it being broken.  (Trying doing that with an
old-style MacOS file with resource forks; what a nightmare....)

The only place where you really see use of forks/ADS is in places
where interoperability isn't a big deal, such as MacOS executables, or
back when a certain company with monopolistic tendencies was trying to
lock desktop users into their OS....

On Mon, Aug 24, 2020 at 09:26:56PM +0000, Frank van der Linden wrote:
> I agree with him and Linus that the Solaris interface of:
> 
> ffd = open("foo", O_RDONLY);
> afd = openat(ffd, "attrpath", O_XATTR|O_RDWR);
> 
> ..is the best starting point. It's simple, it's clean, it doesn't overload
> path separators. And hey, if you like doing it with path separators, put
> a library function on top of it that uses them :-)

The Solaris interface is pretty clean, but there if we really want to
do this (and from above, I'm not a fan), there is one thing that I
would drop from the Solaris API, and that's the ability to use chdirat
to cd into a directory which is inside a file's ADS.  There were
malware authors who were using this to go to town, since most shells
didn't know about ADS, and so it was a *great* way to hide setuid root
binaries, files that were being prepared for exfiltration from the
corporation's intranet, etc.

So let's learn from Solaris's mistake, and let's not.  Solaris may
have that feature, for Windows compatibility, but I'm not aware of any
enterprise Unix software that has used it, for all of the reasons
discussed above.

					- Ted

