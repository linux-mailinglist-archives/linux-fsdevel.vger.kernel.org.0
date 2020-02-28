Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF4173E21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgB1RPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 12:15:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34502 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgB1RPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:15:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7jE8-002VQ3-Fz; Fri, 28 Feb 2020 17:15:04 +0000
Date:   Fri, 28 Feb 2020 17:15:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200228171504.GK23230@ZenIV.linux.org.uk>
References: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
 <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
 <20200228122712.GA3013026@kroah.com>
 <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 05:24:23PM +0100, Miklos Szeredi wrote:
> On Fri, Feb 28, 2020 at 1:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > > Superblocks and mounts could get enumerated by a unique identifier.
> > > mnt_id seems to be good for mounts, s_dev may or may not be good for
> > > superblock, but  s_id (as introduced in this patchset) could be used
> > > instead.
> >
> > So what would the sysfs tree look like with this?
> 
> For a start something like this:
> 
> mounts/$MOUNT_ID/
>   parent -> ../$PARENT_ID
>   super -> ../../supers/$SUPER_ID
>   root: path from mount root to fs root (could be optional as usually
> they are the same)
>   mountpoint -> $MOUNTPOINT
>   flags: mount flags
>   propagation: mount propagation
>   children/$CHILD_ID -> ../../$CHILD_ID
> 
>  supers/$SUPER_ID/
>    type: fstype
>    source: mount source (devname)
>    options: csv of mount options

Oh, wonderful.  So let me see if I got it right - any namespace operation
can create/destroy/move around an arbitrary amount of sysfs objects.
Better yet, we suddenly have to express the lifetime rules for struct mount
and struct superblock in terms of struct device garbage.

I'm less than thrilled by the entire fsinfo circus, but this really takes
the cake.

In case it needs to be spelled out: NAK.
