Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815FD19FD69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDFSq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 14:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:52306 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDFSq1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:46:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B62FB1C7B; Mon,  6 Apr 2020 14:46:26 -0400 (EDT)
Date:   Mon, 6 Apr 2020 14:46:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Karel Zak <kzak@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200406184626.GE2147@fieldses.org>
References: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
 <20200403203024.GB27105@fieldses.org>
 <20200406091701.q7ctdek2grzryiu3@ws.net.home>
 <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:34:08AM -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> > >
> > > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > > and ".." and returns true if they have different st_dev or the same
> > > st_ino.  Comparing mount ids sounds better.
> >
> > BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> > For mountpoint(1) we search the directory in /proc/self/mountinfo.
> 
> These days you should probably use openat2() with RESOLVE_NO_XDEV.
> 
> No need for any mountinfo or anything like that. Just look up the
> pathname and say "don't cross mount-points", and you'll get an error
> if it's a mount crossing lookup.

OK, I can't see why that wouldn't work, thanks.

--b.

> 
> So this kind of thing is _not_ an argument for another kernel querying
> interface.  We got a new (and better) model for a lot of this.
> 
>               Linus
