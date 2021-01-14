Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CCE2F6C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 21:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhANUoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 15:44:34 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:58162 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbhANUod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:44:33 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 84A94D5E47A;
        Fri, 15 Jan 2021 07:43:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l09Sw-006UW3-9I; Fri, 15 Jan 2021 07:43:34 +1100
Date:   Fri, 15 Jan 2021 07:43:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 00/42] idmapped mounts
Message-ID: <20210114204334.GK331610@dread.disaster.area>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210114171241.GA1164240@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114171241.GA1164240@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=In5g3teRgiYIkOrEuZ4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:12:41AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 12, 2021 at 11:00:42PM +0100, Christian Brauner wrote:
> > Hey everyone,
> > 
> > The only major change is the inclusion of hch's patch to port XFS to
> > support idmapped mounts. Thanks to Christoph for doing that work.
> 
> Yay :)
> 
> > (For a full list of major changes between versions see the end of this
> >  cover letter.
> >  Please also note the large xfstests testsuite in patch 42 that has been
> >  kept as part of this series. It verifies correct vfs behavior with and
> >  without idmapped mounts including covering newer vfs features such as
> >  io_uring.
> >  I currently still plan to target the v5.12 merge window.)
> > 
> > With this patchset we make it possible to attach idmappings to mounts,
> > i.e. simply put different bind mounts can expose the same file or
> > directory with different ownership.
> > Shifting of ownership on a per-mount basis handles a wide range of
> > long standing use-cases. Here are just a few:
> > - Shifting of a subset of ownership-less filesystems (vfat) for use by
> >   multiple users, effectively allowing for DAC on such devices
> >   (systemd, Android, ...)
> > - Allow remapping uid/gid on external filesystems or paths (USB sticks,
> >   network filesystem, ...) to match the local system's user and groups.
> >   (David Howells intends to port AFS as a first candidate.)
> > - Shifting of a container rootfs or base image without having to mangle
> >   every file (runc, Docker, containerd, k8s, LXD, systemd ...)
> > - Sharing of data between host or privileged containers with
> >   unprivileged containers (runC, Docker, containerd, k8s, LXD, ...)
> > - Data sharing between multiple user namespaces with incompatible maps
> >   (LXD, k8s, ...)
> 
> That sounds neat.  AFAICT, the VFS passes the filesystem a mount userns
> structure, which is then carried down the call stack to whatever
> functions actually care about mapping kernel [ug]ids to their ondisk
> versions?
> 
> Does quota still work after this patchset is applied?  There isn't any
> mention of that in the cover letter and I don't see a code patch, so
> does that mean everything just works?  I'm particularly curious about
> whether there can exist processes with CAP_SYS_ADMIN and an idmapped
> mount?  Syscalls like bulkstat and quotactl present file [ug]ids to
> programs, but afaict there won't be any translating going on?

bulkstat is not allowed inside user namespaces. It's an init
namespace only thing because it provides unchecked/unbounded access
to all inodes in the filesystem, not just those contained within a
specific mount container.

Hence I don't think bulkstat output (and other initns+root only
filesystem introspection APIs) should be subject to or concerned
about idmapping.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
