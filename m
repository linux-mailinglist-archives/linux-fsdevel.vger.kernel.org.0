Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CE13D47A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 07:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgAPGoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 01:44:34 -0500
Received: from mail.hallyn.com ([178.63.66.53]:40684 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAPGod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:44:33 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 5DD449C2; Thu, 16 Jan 2020 00:44:30 -0600 (CST)
Date:   Thu, 16 Jan 2020 00:44:30 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
Message-ID: <20200116064430.GA32763@mail.hallyn.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
 <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
 <20200113034149.GA27228@mail.hallyn.com>
 <1579112360.3249.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579112360.3249.17.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:19:20AM -0800, James Bottomley wrote:
> On Sun, 2020-01-12 at 21:41 -0600, Serge E. Hallyn wrote:
> > On Sat, Jan 04, 2020 at 12:39:45PM -0800, James Bottomley wrote:
> > > This implementation reverse shifts according to the user_ns
> > > belonging to the mnt_ns.  So if the vfsmount has the newly
> > > introduced flag MNT_SHIFT and the current user_ns is the same as
> > > the mount_ns->user_ns then we shift back using the user_ns before
> > > committing to the underlying filesystem.
> > > 
> > > For example, if a user_ns is created where interior (fake root, uid
> > > 0) is mapped to kernel uid 100000 then writes from interior root
> > > normally go to the filesystem at the kernel uid.  However, if
> > > MNT_SHIFT is set, they will be shifted back to write at uid 0,
> > > meaning we can bind mount real image filesystems to user_ns
> > > protected faker root.
> > 
> > Thanks, James, I definately would like to see shifting in the VFS
> > api.
> > 
> > I have a few practical concerns about this implementation, but my
> > biggest concern is more fundemental:  this again by design leaves
> > littered about the filesystem uid-0 owned files which were written by
> > an untrusted user.
> 
> Well, I think that's a consequence of my use case: using unmodified
> container images with the user namespace.  We're starting to do IMA/EVM
> signatures in our images, so shifted UID images aren't an option for us
> .  Therefore I have to figure out a way of allowing an untrusted user
> to write safely at UID zero.  For me that safety comes from strictly
> corralling where they can write and making sure the container
> orchestration system sets it up correctly.

Isn't that a matter of convention?  You could ship, store, and measure
the files already shifted.  An OCI annotation could show the offset,
say 100000.

Now if any admin runs across this device noone will be tricked by the root
owned files.

Mount could conceivably look like:

	mount --bind --origin-uid 100000 --shift /proc/50/ns/user /src /dest

(the --shift idea coming from Tycho).  I'd prefer --origin to be another
user namespace fd, which I suppose some tool could easily set up, for
instance:

	pid1=`setup-userns-fd -m b:0:100000:65536`
	pid2=$(prepare a container userns)
	mount --bind --shift-origin=/proc/$pid1/ns/user \
		--shift-target=/proc/$pid2/ns/user /src /dest

You could presumably always skip the shift-origin to achieve what you're
doing now.

> > I would feel much better if you institutionalized having the origin
> > shifted.  For instance, take a squashfs for a container fs, shift it
> > so that fsuid 0 == hostuid 100000.  Mount that, with a marker saying
> > how it is shifted, then set 'shiftable'.  Now use that as a base for
> > allowing an unpriv user to shift.  If that user has subuid 200000 as
> > container uid 0, then its root will write files as uid 100000 in the
> > fs.  This isn't perfect, but I think something along these lines
> > would be far safer.
> 
> OK, so I fully agree that if you're not doing integrity in the
> container, then this is an option for you and whatever API gets
> upstreamed should cope with that case.
> 
> So to push on the API a bit, what do you want?  The reverse along the
> user_ns one I implemented is easy: a single flag tells you to map back
> or not.  However, the implementation is phrased in terms of shifted
> credentials, so as long as we know how to map, it can work for both our
> use cases.  I think in plumbers you expressed interest in simply
> passing the map to the mount rather than doing it via a user_ns; is
> that still the case?

Oh I think I'm fine either way - I can always create a user_ns to match
the map I want.

-serge
