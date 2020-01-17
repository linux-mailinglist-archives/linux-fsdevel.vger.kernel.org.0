Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBA140EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAQQZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:25:48 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59700 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbgAQQZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:25:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DBCF28EE2DB;
        Fri, 17 Jan 2020 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579278346;
        bh=izv4giKi52TjMWIsAzoniJ1TG247toz8zNENRYRrsIo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RtFcG+AjZDnHg9z1AA08XjyHNPqVVzAmY1ViicsL3NKKKkjokQHbBTlIgxz/xajrS
         B9oWYd6yROi0dvUWQmlrG7o5nSeGVq92qCNF9cE1foK169D+MDnjJwzGfIlmA15G5B
         IjVI0psg0abttT0RVPwrU43MvW5JKC14EoMe3up4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NiHNbuh2IeE7; Fri, 17 Jan 2020 08:25:46 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7EC6E8EE181;
        Fri, 17 Jan 2020 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579278346;
        bh=izv4giKi52TjMWIsAzoniJ1TG247toz8zNENRYRrsIo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RtFcG+AjZDnHg9z1AA08XjyHNPqVVzAmY1ViicsL3NKKKkjokQHbBTlIgxz/xajrS
         B9oWYd6yROi0dvUWQmlrG7o5nSeGVq92qCNF9cE1foK169D+MDnjJwzGfIlmA15G5B
         IjVI0psg0abttT0RVPwrU43MvW5JKC14EoMe3up4=
Message-ID: <1579278342.3227.36.camel@HansenPartnership.com>
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
Date:   Fri, 17 Jan 2020 08:25:42 -0800
In-Reply-To: <20200117154402.GA16882@mail.hallyn.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
         <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
         <20200113034149.GA27228@mail.hallyn.com>
         <1579112360.3249.17.camel@HansenPartnership.com>
         <20200116064430.GA32763@mail.hallyn.com>
         <1579192173.3551.38.camel@HansenPartnership.com>
         <20200117154402.GA16882@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-01-17 at 09:44 -0600, Serge E. Hallyn wrote:
> On Thu, Jan 16, 2020 at 08:29:33AM -0800, James Bottomley wrote:
> > On Thu, 2020-01-16 at 00:44 -0600, Serge E. Hallyn wrote:
> > > On Wed, Jan 15, 2020 at 10:19:20AM -0800, James Bottomley wrote:
> > > > On Sun, 2020-01-12 at 21:41 -0600, Serge E. Hallyn wrote:
> > > > > On Sat, Jan 04, 2020 at 12:39:45PM -0800, James Bottomley
> > > > > wrote:
> > > > > > This implementation reverse shifts according to the user_ns
> > > > > > belonging to the mnt_ns.  So if the vfsmount has the newly
> > > > > > introduced flag MNT_SHIFT and the current user_ns is the
> > > > > > same as the mount_ns->user_ns then we shift back using the
> > > > > > user_ns before committing to the underlying filesystem.
> > > > > > 
> > > > > > For example, if a user_ns is created where interior (fake
> > > > > > root,uid 0) is mapped to kernel uid 100000 then writes from
> > > > > > interior root normally go to the filesystem at the kernel
> > > > > > uid.  However, if MNT_SHIFT is set, they will be shifted
> > > > > > back to write at uid 0, meaning we can bind mount real
> > > > > > image filesystems to user_ns protected faker root.
> > > > > 
> > > > > Thanks, James, I definately would like to see shifting in the
> > > > > VFS api.
> > > > > 
> > > > > I have a few practical concerns about this implementation,
> > > > > but my biggest concern is more fundemental:  this again by
> > > > > design leaves littered about the filesystem uid-0 owned files
> > > > > which were written by an untrusted user.
> > > > 
> > > > Well, I think that's a consequence of my use case: using
> > > > unmodified container images with the user namespace.  We're
> > > > starting to do IMA/EVM signatures in our images, so shifted UID
> > > > images aren't an option for us.  Therefore I have to figure out
> > > > a way of allowing an untrusted user to write safely at UID
> > > > zero.  For me that safety comes from strictly corralling where
> > > > they can write and making sure the container orchestration
> > > > system sets it up correctly.
> > > 
> > > Isn't that a matter of convention?  You could ship, store, and
> > > measure the files already shifted.  An OCI annotation could show
> > > the offset, say 100000.
> > 
> > We could, but it's the wrong way to look at it to tell a customer
> > that if they want us to run the image safely they have to modify it
> > at the build stage.  As a cloud service provider I want to make the
> > statement that I can run any customer image safely as long as it
> > was built to whatever standards the registry supports.  That has to
> > include integrity protected images.  And I have to be able to
> > attest to a 
>  
> And does the customer measure the files, or do you?

Well, the customer signs the image, which is why we can't alter it. 
The idea would be that the CSP does the measurement and the provision
of the running dashboard but that the customer could also do it
themselves if they didn't trust the CSP ... or just wanted to verify
the CSP integrity tool was working correctly.

> > customer that I'm running their image as part of the customer
> > integrity verification.
> 
> Makes sense.  And in your environment, you can easily partition off a
> place (or an otherwise unused namespace) in which to mount these
> images. So using a null mapping for the 'origin' would make sense
> there.
> 
> But in cases where what you want is a single directory shared by
> several containers with disjoint uid mappings, where this is the only
> directory they share - be it for logs, or data, etc, and be it by
> infrastructure containers in the course of running a cluster or a set
> of students manipulating shared data with their otherwise completely
> unprivileged containers - we can make the shared directory a lot less
> of a minefield.

Sure ... I didn't say you didn't have a use case.   I was just pointing
out that I have a write at uid 0 one.  I'm happy to implement a scheme
that covers both.

> > > Now if any admin runs across this device noone will be tricked by
> > > the root owned files.
> > 
> > Perhaps you could go into what tricks you think will happen?  This
> > is
> 
> I don't like to use my own underactive imagination to decide what an
> attacker - or accidental fool - might be likely to do.  But simply
> writing a setuid-root shell script called 'ls' will probably hit
> *someone* who against all advice has . at the front of their path.

The suid/sgid is already on my list of potential threats.  It's
mitigated by never letting the tenant get access to where the unshifted
image is unpacked.

> (Don't look at me like that - it's 2020 and we still have flashy
> respectable-looking websites encouraging people to wget | sudo
> /bin/sh)

Person with root access being stupid is definitely a problem, but it's
not really in my threat model.

> > clearly the thread model of using unmodified images you have which
> > might be different from the one I have.  My mitigation is basically
> > that as long as no tenant or unprivileged user can get at the
> > unshifted image, we're fine.
> 
> Are you sure?  What if $package accidentally ships a broken cronjob
> that tries to run ./bin/sh -c "logger $(date)" ?

You mean sends a message to the systemd log socket?  That's usually
intercepted to go into the per-container Kafka receiver (or whatever
else the CSP uses for logging).

> > > Mount could conceivably look like:
> > > 
> > > 	mount --bind --origin-uid 100000 --shift /proc/50/ns/user /src
> > > /dest
> > > 
> > > (the --shift idea coming from Tycho).
> > 
> > Just so we're clear --origin-uid <uid> means map back along the --
> > shift user_ns but add this <uid> to whatever interior id the shift
> > produces? 
> 
> If by interior id you mean the kuid, then yes :)

Oh, no ... we need to get the terminogy straight.  The kuid, as in the
uid the kernel sees, is what I think of as the exterior uid.  The uid
the container tenant thinks they see is the interior one.

So let's say the user_ns maps interior 0 to exterior 20,000 but that
the image begins at 100,000.  You have an --origin-uid of 100000 in the
above, I believe.  How we get there is the user as sudo root writes a
file "f".  "f" has interior owner 0.  However, the exterior owner,
which is what usually gets written, as 20,000.  Doing the shift I'd
take the 20,000; shift back along the tenant user_ns to get 0 and then
add the 100,000 offset to end up writing to the image at 100,000

That would mean a bunch of different user_ns could be set up all
shifting back to the same 100,000 and thus share the image.

> > I think that's fairly easy to parametrise and store in the bind
> > mount, yes.
> > 
> > >   I'd prefer --origin to be another user namespace fd, which I
> > > suppose some tool could easily set up, for instance:
> > > 
> > > 	pid1=`setup-userns-fd -m b:0:100000:65536`
> > > 	pid2=$(prepare a container userns)
> > > 	mount --bind --shift-origin=/proc/$pid1/ns/user \
> > > 		--shift-target=/proc/$pid2/ns/user /src /dest
> > > 
> > > You could presumably always skip the shift-origin to achieve what
> > > you're doing now.
> > 
> > Yes, if you're happy to have --shift-origin <uid> default to 0
> 
> Yeah I think that's fine.  I'd expect any distro which tries to
> configure this for easy consumption to allocate a 65k subuid range
> for 'images', and set a default shift-origin under /etc which 'mount'
> would consult, or something like that.  The kernel almost certainly
> would default to 0.
> 
> > I have to ask in the above, what is the point of the pid1
> > user_ns?  Do you ever use pid1 for anything else?
> 
> Probably not.
> 
> > It looks like you were merely creating it for the object of having
> > it passed into the bind.  If there's never any use for the --shift-
> > origin <ns_fd> then I think I agree that a bare number is a better
> > abstraction.  Or are you thinking we'll have use cases where a
> > simple numeric addition won't serve and our only user mechanism for
> > complex parametrisation of the shift map is a user_ns?
> 
> I don't think so.  People can have some pretty convoluted uid
> mappings right now, but presumably the images we are talking about
> would be the result of an rsync or tar *in* such a namespace.  Though
> again, limited imagination and all that.  There *may* be very good
> use cases for a more complicated mapping.

Would it be OK to implement the simple now and add the complex later if
it ever materializes.  Provided we can agree on a way of passing extra
arguments to bind, we have the freedom to add stuff later.

> > The other slight problem is that now the bind mount does need to
> > understand complex arguments, which it definitely doesn't
> > today.  I'm happy with extending fsconfig to bind, so it can do
> > complex arguments like this, but it sounds like others are dubious
> > so doing the above also depends on agreeing whatever extension we
> > do to bind.
> > 
> > I suppose bind reconfigure could be yet another system call in the
> > open_tree/move_mount pantheon, which would also solve the remount
> > with different bind parameters problem with the new API.
> > 
> > The other thing I worry about is that is separating the
> > shift_user_ns from the mount_ns->user_ns a potential security
> > hole?  For the unprivileged operation of this, I like the idea of
> > enforcing them to be the same so the tenant can only shift back
> > along a user_ns they're operating in.  The problem being that the
> > kernel has no way of validating that the passed in <ns_fd> is
> > within the subuid/subgid range of the unprivileged user, so we're
> > trusting that the user can't get access to the ns_fd of a user_ns
> > outside that range.
> 
> I guess I figured we would have privileged task in the owning
> namespace (presumably init_user_ns) mark a bind mount as shiftable 

Yes, that's what I've got today in the prototype.  It mirrors the
original shiftfs mechanism.  However, I have also heard people say they
want a permanent mark, like an xattr for this.

> (maybe specifying who is allowed to bind mount it using the mapped
> root uid, analogous to how the namespaced file capabilities are
> identified) and then the ns_fd of the task doing the "mount --bind --
> shift" (which is privileged inside the ns_fd userns) would be used,
> unmodified (or even modified, since whatever uid args the task would
> pass would have to be valid inside the mounting userns)
> 
> So something like:
> 
> 1. On the host:
> 
>    mount --bind --mark-shiftable-by 200000 --origin-uid 100000
> /data/group1
> 
> 2. In the container which has its root mapped to host uid 200000
> 
>    mount --bind --shift /data/group1 /data/group1

We can certainly do that, but it does mean one mark (i.e. one mount
point, so /data/group<n>) per user_ns at different uids.  A simpler
alternative may be to do the mark as

mount --bind --mark-shiftable --origin-uid 100000 /data/group

And regulate access to /data/group by the usual filesystem ACL.  Then
anyone who can get at /data/group can do

mount --bind --shift /data/group1 /my/place/for/the/image

I tend to think that ACL security is sufficient, since it's what
everyone is used to but I don't object to having the additional origin
check as well.

> > > > > I would feel much better if you institutionalized having the
> > > > > origin shifted.  For instance, take a squashfs for a
> > > > > container fs, shift it so that fsuid 0 == hostuid
> > > > > 100000.  Mount that, with a marker saying how it is shifted,
> > > > > then set 'shiftable'.  Now use that as a base for allowing an
> > > > > unpriv user to shift.  If that user has subuid 200000 as
> > > > > container uid 0, then its root will write files as uid 100000
> > > > > in the fs.  This isn't perfect, but I think something along
> > > > > these lines would be far safer.
> > > > 
> > > > OK, so I fully agree that if you're not doing integrity in the
> > > > container, then this is an option for you and whatever API gets
> > > > upstreamed should cope with that case.
> > > > 
> > > > So to push on the API a bit, what do you want?  The reverse
> > > > along the user_ns one I implemented is easy: a single flag
> > > > tells you to map back or not.  However, the implementation is
> > > > phrased in terms of shifted credentials, so as long as we know
> > > > how to map, it can work for both our use cases.  I think in
> > > > plumbers you expressed interest in simply passing the map to
> > > > the mount rather than doing it via a user_ns; is that still the
> > > > case?
> > > 
> > > Oh I think I'm fine either way - I can always create a user_ns to
> > > match the map I want.
> > 
> > I think it comes down to whether there's an actual use for the
> > user_ns you create.  It seems a bit wasteful merely to create a
> > user_ns for the purpose of passing something that can also be
> > simply parametrised if there's no further use for that user_ns.
> 
> Oh - I consider the detail of whether we pass a userid or userns nsfd
> as more of an implementation detail which we can hash out after the
> more general shift-mount api is decided upon.  Anyway, passing nsfds
> just has a cool factor :)

Well, yes, won't aruge on the cool factor-ness.

James

> -serge
> 

