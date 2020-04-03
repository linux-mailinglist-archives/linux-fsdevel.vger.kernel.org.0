Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D619DF62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCUaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 16:30:24 -0400
Received: from fieldses.org ([173.255.197.46]:46832 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDCUaY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:30:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 25E693B9; Fri,  3 Apr 2020 16:30:24 -0400 (EDT)
Date:   Fri, 3 Apr 2020 16:30:24 -0400
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200403203024.GB27105@fieldses.org>
References: <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403151223.GB34800@gardel-login>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:12:23PM +0200, Lennart Poettering wrote:
> BTW, while we are at it: one more thing I'd love to see exposed by
> statx() is a simple flag whether the inode is a mount point. There's
> plenty code that implements a test like this all over the place, and
> it usually isn't very safe. There's one implementation in util-linux
> for example (in the /usr/bin/mountpoint binary), and another one in
> systemd. Would be awesome to just have a statx() return flag for that,
> that would make things *so* much easier and more robust. because in
> fact most code isn't very good that implements this, as much of it
> just compares st_dev of the specified file and its parent. Better code
> compares the mount ID, but as mentioned that's not as pretty as it
> could be so far...

nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
and ".." and returns true if they have different st_dev or the same
st_ino.  Comparing mount ids sounds better.

So anyway, yes, everybody reinvents the wheel here, and this would be
useful.  (And, yes, we want to know for the vfsmount, we don't care
whether the same inode is used as a mountpoint someplace else.)

--b.
