Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E80113E01B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgAPQ3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 11:29:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36398 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgAPQ3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:29:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 612908EE2C4;
        Thu, 16 Jan 2020 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579192177;
        bh=pQRi3+wwOxvlWDUraKfiyH2iDcUpxUN3F7M9OE93/M0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dl5TL884MajUeY8QHlWiWFtKJ0BaW/vT0tZxYkouYdfAfpDOLAO4jTyUoe2G6aNv0
         ncPhR0UXE6VMmLTVEcE6XM44tBGBb1XYQW6PP81r3Q3Kw020n1OMABSJKTyBDdS44f
         NXZ3dbh8vE435bP8+i/+9YJOFMIBeHGpVqy6W0xI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fkqIpkGWMD1e; Thu, 16 Jan 2020 08:29:37 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2A3308EE180;
        Thu, 16 Jan 2020 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579192177;
        bh=pQRi3+wwOxvlWDUraKfiyH2iDcUpxUN3F7M9OE93/M0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dl5TL884MajUeY8QHlWiWFtKJ0BaW/vT0tZxYkouYdfAfpDOLAO4jTyUoe2G6aNv0
         ncPhR0UXE6VMmLTVEcE6XM44tBGBb1XYQW6PP81r3Q3Kw020n1OMABSJKTyBDdS44f
         NXZ3dbh8vE435bP8+i/+9YJOFMIBeHGpVqy6W0xI=
Message-ID: <1579192173.3551.38.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 16 Jan 2020 08:29:33 -0800
In-Reply-To: <20200116064430.GA32763@mail.hallyn.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
         <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
         <20200113034149.GA27228@mail.hallyn.com>
         <1579112360.3249.17.camel@HansenPartnership.com>
         <20200116064430.GA32763@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-01-16 at 00:44 -0600, Serge E. Hallyn wrote:
> On Wed, Jan 15, 2020 at 10:19:20AM -0800, James Bottomley wrote:
> > On Sun, 2020-01-12 at 21:41 -0600, Serge E. Hallyn wrote:
> > > On Sat, Jan 04, 2020 at 12:39:45PM -0800, James Bottomley wrote:
> > > > This implementation reverse shifts according to the user_ns
> > > > belonging to the mnt_ns.  So if the vfsmount has the newly
> > > > introduced flag MNT_SHIFT and the current user_ns is the same
> > > > as the mount_ns->user_ns then we shift back using the user_ns
> > > > before committing to the underlying filesystem.
> > > > 
> > > > For example, if a user_ns is created where interior (fake root,
> > > > uid 0) is mapped to kernel uid 100000 then writes from interior
> > > > root normally go to the filesystem at the kernel uid.  However,
> > > > if MNT_SHIFT is set, they will be shifted back to write at uid
> > > > 0, meaning we can bind mount real image filesystems to user_ns
> > > > protected faker root.
> > > 
> > > Thanks, James, I definately would like to see shifting in the VFS
> > > api.
> > > 
> > > I have a few practical concerns about this implementation, but my
> > > biggest concern is more fundemental:  this again by design leaves
> > > littered about the filesystem uid-0 owned files which were
> > > written by an untrusted user.
> > 
> > Well, I think that's a consequence of my use case: using unmodified
> > container images with the user namespace.  We're starting to do
> > IMA/EVM signatures in our images, so shifted UID images aren't an
> > option for us.  Therefore I have to figure out a way of allowing an
> > untrusted user to write safely at UID zero.  For me that safety
> > comes from strictly corralling where they can write and making sure
> > the container orchestration system sets it up correctly.
> 
> Isn't that a matter of convention?  You could ship, store, and
> measure the files already shifted.  An OCI annotation could show the
> offset, say 100000.

We could, but it's the wrong way to look at it to tell a customer that
if they want us to run the image safely they have to modify it at the
build stage.  As a cloud service provider I want to make the statement
that I can run any customer image safely as long as it was built to
whatever standards the registry supports.  That has to include
integrity protected images.  And I have to be able to attest to a
customer that I'm running their image as part of the customer integrity
verification.

> Now if any admin runs across this device noone will be tricked by the
> root owned files.

Perhaps you could go into what tricks you think will happen?  This is
clearly the thread model of using unmodified images you have which
might be different from the one I have.  My mitigation is basically
that as long as no tenant or unprivileged user can get at the unshifted
image, we're fine.

> Mount could conceivably look like:
> 
> 	mount --bind --origin-uid 100000 --shift /proc/50/ns/user /src
> /dest
> 
> (the --shift idea coming from Tycho).

Just so we're clear --origin-uid <uid> means map back along the --shift 
user_ns but add this <uid> to whatever interior id the shift produces? 
I think that's fairly easy to parametrise and store in the bind mount,
yes.

>   I'd prefer --origin to be another user namespace fd, which I
> suppose some tool could easily set up, for instance:
> 
> 	pid1=`setup-userns-fd -m b:0:100000:65536`
> 	pid2=$(prepare a container userns)
> 	mount --bind --shift-origin=/proc/$pid1/ns/user \
> 		--shift-target=/proc/$pid2/ns/user /src /dest
> 
> You could presumably always skip the shift-origin to achieve what
> you're doing now.

Yes, if you're happy to have --shift-origin <uid> default to 0

I have to ask in the above, what is the point of the pid1 user_ns?  Do
you ever use pid1 for anything else? It looks like you were merely
creating it for the object of having it passed into the bind.  If
there's never any use for the --shift-origin <ns_fd> then I think I
agree that a bare number is a better abstraction.  Or are you thinking
we'll have use cases where a simple numeric addition won't serve and
our only user mechanism for complex parametrisation of the shift map is
a user_ns?

The other slight problem is that now the bind mount does need to
understand complex arguments, which it definitely doesn't today.  I'm
happy with extending fsconfig to bind, so it can do complex arguments
like this, but it sounds like others are dubious so doing the above
also depends on agreeing whatever extension we do to bind.

I suppose bind reconfigure could be yet another system call in the
open_tree/move_mount pantheon, which would also solve the remount with
different bind parameters problem with the new API.

The other thing I worry about is that is separating the shift_user_ns
from the mount_ns->user_ns a potential security hole?  For the
unprivileged operation of this, I like the idea of enforcing them to be
the same so the tenant can only shift back along a user_ns they're
operating in.  The problem being that the kernel has no way of
validating that the passed in <ns_fd> is within the subuid/subgid range
of the unprivileged user, so we're trusting that the user can't get
access to the ns_fd of a user_ns outside that range.

> > > I would feel much better if you institutionalized having the
> > > origin shifted.  For instance, take a squashfs for a container
> > > fs, shift it so that fsuid 0 == hostuid 100000.  Mount that, with
> > > a marker saying how it is shifted, then set 'shiftable'.  Now use
> > > that as a base for allowing an unpriv user to shift.  If that
> > > user has subuid 200000 as container uid 0, then its root will
> > > write files as uid 100000 in the fs.  This isn't perfect, but I
> > > think something along these lines would be far safer.
> > 
> > OK, so I fully agree that if you're not doing integrity in the
> > container, then this is an option for you and whatever API gets
> > upstreamed should cope with that case.
> > 
> > So to push on the API a bit, what do you want?  The reverse along
> > the user_ns one I implemented is easy: a single flag tells you to
> > map back or not.  However, the implementation is phrased in terms
> > of shifted credentials, so as long as we know how to map, it can
> > work for both our use cases.  I think in plumbers you expressed
> > interest in simply passing the map to the mount rather than doing
> > it via a user_ns; is that still the case?
> 
> Oh I think I'm fine either way - I can always create a user_ns to
> match the map I want.

I think it comes down to whether there's an actual use for the user_ns
you create.  It seems a bit wasteful merely to create a user_ns for the
purpose of passing something that can also be simply parametrised if
there's no further use for that user_ns.

James

