Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6717C727
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFUhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:37:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFUhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:37:16 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAJiT-006Tvg-Sf; Fri, 06 Mar 2020 20:37:06 +0000
Date:   Fri, 6 Mar 2020 20:37:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200306203705.GB23230@ZenIV.linux.org.uk>
References: <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
 <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk>
 <20200306200522.GA23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306200522.GA23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:05:22PM +0000, Al Viro wrote:
> On Fri, Mar 06, 2020 at 07:58:23PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 07:43:22PM +0000, Al Viro wrote:
> > > On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > > > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > > > > 
> > > > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > > > preconceptions.
> > > > 
> > > > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > > > Probably has rough edges, but appears to work.
> > > 
> > > For starters, you have just made namespace_sem held over copy_to_user().
> > > This is not going to fly.
> > 
> > In case if the above is too terse: you grab your mutex while under
> > namespace_sem (see attach_recursive_mnt()); the same mutex is held
> > while calling dir_emit().  Which can (and normally does) copy data
> > to userland-supplied buffer.
> > 
> > NAK for that reason alone, and to be honest I had been too busy
> > suppressing the gag reflex to read and comment any deeper.
> > 
> > I really hate that approach, in case it's not clear from the above.
> > To the degree that I don't trust myself to filter out the obscenities
> > if I try to comment on it right now.
> > 
> > The only blocking thing we can afford under namespace_sem is GFP_KERNEL
> > allocation.
> 
> Incidentally, attach_recursive_mnt() only gets you the root(s) of
> attached tree(s); try mount --rbind and see how much you've missed.

You are misreading mntput_no_expire(), BTW - your get_mount() can
bloody well race with umount(2), hitting the moment when we are done
figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
is not mounted anywhere else, they are not supposed to see the sucker
return 0 until the filesystem is shut down.  You break that.
