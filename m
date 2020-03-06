Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DC17C6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFUFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:05:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38560 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFUFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:05:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAJDm-006Sl9-H9; Fri, 06 Mar 2020 20:05:22 +0000
Date:   Fri, 6 Mar 2020 20:05:22 +0000
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
Message-ID: <20200306200522.GA23230@ZenIV.linux.org.uk>
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
 <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306195823.GZ23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 07:58:23PM +0000, Al Viro wrote:
> On Fri, Mar 06, 2020 at 07:43:22PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > > > 
> > > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > > preconceptions.
> > > 
> > > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > > Probably has rough edges, but appears to work.
> > 
> > For starters, you have just made namespace_sem held over copy_to_user().
> > This is not going to fly.
> 
> In case if the above is too terse: you grab your mutex while under
> namespace_sem (see attach_recursive_mnt()); the same mutex is held
> while calling dir_emit().  Which can (and normally does) copy data
> to userland-supplied buffer.
> 
> NAK for that reason alone, and to be honest I had been too busy
> suppressing the gag reflex to read and comment any deeper.
> 
> I really hate that approach, in case it's not clear from the above.
> To the degree that I don't trust myself to filter out the obscenities
> if I try to comment on it right now.
> 
> The only blocking thing we can afford under namespace_sem is GFP_KERNEL
> allocation.

Incidentally, attach_recursive_mnt() only gets you the root(s) of
attached tree(s); try mount --rbind and see how much you've missed.
