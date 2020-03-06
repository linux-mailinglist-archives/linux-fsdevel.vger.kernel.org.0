Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6975317C7DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 22:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFV2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 16:28:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39692 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFV2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:28:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAKW7-006Vf9-Km; Fri, 06 Mar 2020 21:28:23 +0000
Date:   Fri, 6 Mar 2020 21:28:23 +0000
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
Message-ID: <20200306212823.GG23230@ZenIV.linux.org.uk>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
 <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk>
 <20200306200522.GA23230@ZenIV.linux.org.uk>
 <20200306203705.GB23230@ZenIV.linux.org.uk>
 <20200306203844.GC23230@ZenIV.linux.org.uk>
 <20200306204523.GD23230@ZenIV.linux.org.uk>
 <20200306204926.GE23230@ZenIV.linux.org.uk>
 <CAJfpegvK+v9LZ_VinPAgVV+iuxiVSFqYnX3oRXsBJM8keDgzJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvK+v9LZ_VinPAgVV+iuxiVSFqYnX3oRXsBJM8keDgzJg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:51:50PM +0100, Miklos Szeredi wrote:
> On Fri, Mar 6, 2020 at 9:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Mar 06, 2020 at 08:45:23PM +0000, Al Viro wrote:
> > > On Fri, Mar 06, 2020 at 08:38:44PM +0000, Al Viro wrote:
> > > > On Fri, Mar 06, 2020 at 08:37:05PM +0000, Al Viro wrote:
> > > >
> > > > > You are misreading mntput_no_expire(), BTW - your get_mount() can
> > > > > bloody well race with umount(2), hitting the moment when we are done
> > > > > figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
> > > > > set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
> > > > > is not mounted anywhere else, they are not supposed to see the sucker
> > > > > return 0 until the filesystem is shut down.  You break that.
> > > >
> > > > While we are at it, d_alloc_parallel() requires i_rwsem on parent held
> > > > at least shared.
> > >
> > > Egads...  Let me see if I got it right - you are providing procfs symlinks
> > > to objects on the internal mount of that thing.  And those objects happen
> > > to be directories, so one can get to their parent that way.  Or am I misreading
> > > that thing?
> >
> > IDGI.  You have (in your lookup) kstrtoul, followed by snprintf, followed
> > by strcmp and WARN_ON() in case of mismatch?  Is there any point in having
> > stat(2) on "00" spew into syslog?  Confused...
> 
> The WARN_ON() is for the buffer overrun, not for the strcmp mismatch.

That makes even less sense - buffer overrun on snprintf of an int into
32-character array?  That's what, future-proofing it for the time we
manage to issue 10^31 syscalls since the (much closer) moment when we
get 128bit int?
