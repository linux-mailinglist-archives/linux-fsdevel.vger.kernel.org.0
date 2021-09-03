Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E857400238
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbhICP1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349808AbhICP1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630682779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IFlEJUC0U0NqVTgGzAcET9w1a85sQ4N2YPsK8GdcFM=;
        b=FTX7fOu2E1r6q/tx3zXsh9u9WP5OSWY5NWG77gfUcqlCgW5YGdaYQaEW1aqK3aMMxIFKws
        0i+xnSoiYxzFgDsQFVcHsgFR3cai1tkkkrg8d+PjXjc2CceILd+R3ZOHiEVoffxWD5F3zc
        F4kWaRPJhh95y/MCEJWSSKgbykni8+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-xAZIrLopNvGktHE1DW4IbA-1; Fri, 03 Sep 2021 11:26:18 -0400
X-MC-Unique: xAZIrLopNvGktHE1DW4IbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA1E210B7441;
        Fri,  3 Sep 2021 15:26:16 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDA019C59;
        Fri,  3 Sep 2021 15:26:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A9AD3220257; Fri,  3 Sep 2021 11:26:11 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:26:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YTI+k29AoeGdX13Q@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
 <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 03:34:17PM -0700, Casey Schaufler wrote:
> On 9/2/2021 1:06 PM, Vivek Goyal wrote:
> > On Thu, Sep 02, 2021 at 11:55:11AM -0700, Casey Schaufler wrote:
> >> On 9/2/2021 10:42 AM, Vivek Goyal wrote:
> >>> On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
> >>>> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
> >>>>> On 9/2/2021 8:22 AM, Vivek Goyal wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> This is V3 of the patch. Previous versions were posted here.
> >>>>>>
> >>>>>> v2:
> >>>>>> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> >>>>>> v1:
> >>>>>> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.co
> >>>>>> +m/
> >>>>>>
> >>>>>> Changes since v2
> >>>>>> ----------------
> >>>>>> - Do not call inode_permission() for special files as file mode bits
> >>>>>>   on these files represent permissions to read/write from/to device
> >>>>>>   and not necessarily permission to read/write xattrs. In this case
> >>>>>>   now user.* extended xattrs can be read/written on special files
> >>>>>>   as long as caller is owner of file or has CAP_FOWNER.
> >>>>>>  
> >>>>>> - Fixed "man xattr". Will post a patch in same thread little later. (J.
> >>>>>>   Bruce Fields)
> >>>>>>
> >>>>>> - Fixed xfstest 062. Changed it to run only on older kernels where
> >>>>>>   user extended xattrs are not allowed on symlinks/special files. Added
> >>>>>>   a new replacement test 648 which does exactly what 062. Just that
> >>>>>>   it is supposed to run on newer kernels where user extended xattrs
> >>>>>>   are allowed on symlinks and special files. Will post patch in 
> >>>>>>   same thread (Ted Ts'o).
> >>>>>>
> >>>>>> Testing
> >>>>>> -------
> >>>>>> - Ran xfstest "./check -g auto" with and without patches and did not
> >>>>>>   notice any new failures.
> >>>>>>
> >>>>>> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
> >>>>>>   filesystems and it works.
> >>>>>>  
> >>>>>> Description
> >>>>>> ===========
> >>>>>>
> >>>>>> Right now we don't allow setting user.* xattrs on symlinks and special
> >>>>>> files at all. Initially I thought that real reason behind this
> >>>>>> restriction is quota limitations but from last conversation it seemed
> >>>>>> that real reason is that permission bits on symlink and special files
> >>>>>> are special and different from regular files and directories, hence
> >>>>>> this restriction is in place. (I tested with xfs user quota enabled and
> >>>>>> quota restrictions kicked in on symlink).
> >>>>>>
> >>>>>> This version of patch allows reading/writing user.* xattr on symlink and
> >>>>>> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.
> >>>>> This part of your project makes perfect sense. There's no good
> >>>>> security reason that you shouldn't set user.* xattrs on symlinks
> >>>>> and/or special files.
> >>>>>
> >>>>> However, your virtiofs use case is unreasonable.
> >>>> Ok. So we can merge this patch irrespective of the fact whether virtiofs
> >>>> should make use of this mechanism or not, right?
> >> I don't see a security objection. I did see that Andreas Gruenbacher
> >> <agruenba@redhat.com> has objections to the behavior.
> >>
> >>
> >>>>>> Who wants to set user.* xattr on symlink/special files
> >>>>>> -----------------------------------------------------
> >>>>>> I have primarily two users at this point of time.
> >>>>>>
> >>>>>> - virtiofs daemon.
> >>>>>>
> >>>>>> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
> >>>>>>   fuse-overlay as well and he ran into similar issue. So fuse-overlay
> >>>>>>   should benefit from this change as well.
> >>>>>>
> >>>>>> Why virtiofsd wants to set user.* xattr on symlink/special files
> >>>>>> ----------------------------------------------------------------
> >>>>>> In virtiofs, actual file server is virtiosd daemon running on host.
> >>>>>> There we have a mode where xattrs can be remapped to something else.
> >>>>>> For example security.selinux can be remapped to
> >>>>>> user.virtiofsd.securit.selinux on the host.
> >>>>> As I have stated before, this introduces a breach in security.
> >>>>> It allows an unprivileged process on the host to manipulate the
> >>>>> security state of the guest. This is horribly wrong. It is not
> >>>>> sufficient to claim that the breach requires misconfiguration
> >>>>> to exploit. Don't do this.
> >>>> So couple of things.
> >>>>
> >>>> - Right now whole virtiofs model is relying on the fact that host
> >>>>   unpriviliged users don't have access to shared directory. Otherwise
> >>>>   guest process can simply drop a setuid root binary in shared directory
> >>>>   and unpriviliged process can execute it and take over host system.
> >>>>
> >>>>   So if virtiofs makes use of this mechanism, we are well with-in
> >>>>   the existing constraints. If users don't follow the constraints,
> >>>>   bad things can happen.
> >>>>
> >>>> - I think Smalley provided a solution for your concern in other thread
> >>>>   we discussed this issue.
> >>>>
> >>>>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3x3CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d650020361030209d6
> >>>>
> >>>>
> >>>>   "So for example if the host policy says that only virtiofsd can set
> >>>> attributes on those files, then the guest MAC labels along with all
> >>>> the other attributes are protected against tampering by any other
> >>>> process on the host."
> >> You can't count on SELinux policy to address the issue on a
> >> system running Smack.
> >> Or any other user of system.* xattrs,
> >> be they in the kernel or user space. You can't even count on
> >> SELinux policy to be correct. virtiofs has to present a "safe"
> >> situation regardless of how security.* xattrs are used and
> >> regardless of which, if any, LSMs are configured. You can't
> >> do that with user.* attributes.
> > Lets take a step back. Your primary concern with using user.* xattrs
> > by virtiofsd is that it can be modified by unprivileged users on host.
> > And our solution to that problem is hide shared directory from
> > unprivileged users.
> 
> You really don't see how fragile that is, do you?

Yes, I am not sure why we are so opposed to the idea of using 
user.* xattrs for storing the guest security.selinux xattrs by virtiofsd.
And I am trying to understand that. And this discussion should help.

With virtiofsd, we want to keep all shared directory trees in a
parent directory which has read/write/search permissions only for root
so that no unpriviliged process can get to files in shared directory
and do any of the operations.

For example, /var/lib/containers/storage setup by podman has
following permissions.

ll -d /var/lib/containers/storage/
drwx------. 10 root root 4096 Jun 18  2020 /var/lib/containers/storage/

Now I should be able to create /var/lib/containers/storage/shared1
directory and ask virtiofsd to export "share1" to guest. Unprivileged
process on host can not open any of the files in shared1 dir, hence
should not be able to modify any data/metadata associated with the
file.

If this assumption is correct, then I should be able to use "user.*"
xattrs without having to worry about unprivileged processes modifying
security labels of guest/nested-guest.

> How a single
> errant call to rename(), chmod() or chown() on the host can expose
> the entire guest to exploitation. That's not even getting into
> the bag of mount() tricks.

I am relying on unpriviliged processes not having permissions to
read/search in shared directory. And I guess I have to. Even if
I use "trusted.*" xattrs, what about file data. Unpriviliged
processes can modify file data and that's going to be equally
problematic, isn't it? So why are we so focussed only on
security label part of it.

You have mentioned that file data is not necessarily
that big a problem because UID 1000 on host and UID 1000 in guest
should be treated same. But I am not sure we can do that. In kata
container model, guest images are untrusted. So they can simply cook
up UID 1000 or UID 0 or any other UID. Now there can be use
cases where we are ready to trust guest and treat UID 1000
on host and guest in same way. But primary model I am focussing
on is that guest shared directory remains isolated from other
users on host.

> 
> 
> > In addition to that, LSMs on host can block setting "user.*" xattrs by
> > virtiofsd domain only for additional protection.
> 
> Try thinking outside the SELinux box briefly, if you possibly can.
> An LSM that implements just Bell & LaPadula isn't going to have a
> "virtiofs domain". Neither is a Smack "3 domain" system. Smack doesn't
> distinguish writing user xattrs from writing other file attributes
> in policy. Your argument requires a fine grained policy a'la SELinux.
> And an application specific SELinux policy at that.

Ok, so does we have to have capability for every LSM to block write
to user xattr. I mean in above example, virtiofsd is relying on DAC so that
unprivileged processes can't modify user xattr labels. If we were to
use "trusted.*" xattr then we are relying on CAP_SYS_ADMIN.

IOW, it will be nice if one or more LSMs can provide mechanism fine
grained enough to block write to user xattr by unwanted application
and that provides extra level of security. But should it be mandatory?

> 
> >  If LSMs are not configured,
> > then hiding the directory is the solution.
> 
> It's not a solution at all. It's wishful thinking that
> some admin is going to do absolutely everything right, will
> never make a mistake and will never, ever, read the mount(2)
> man page.

I agree that its easy to make mistakes. But making mistakes is already
disastrous. So lets say and admin makes mistake and unprivileged
processes can open/read/write files in shared directory on host.
Assume I am using "trusted" xattrs to store guest's security labels.

Now file's data can be modified on host in unwated way and be very
problematic.

Guest can drop a setuid root binary in shared directory and unprivileged
process on host can run it and take over the system.

Isn't that even bigger problem. So to me making sure shared directory
is not reachable by unprivileged processes is absolute must requirement
for virtiofsd (when running as root). If we break that assumption,
we already have much bigger problems.

> 
> > So why that's not a solution and only relying on CAP_SYS_ADMIN is the
> > solution. I don't understand that part.
> 
> It comes back to your design, which is fundamentally flawed. You
> can't store system security information in an attribute that can
> be manipulated by untrusted entities.

You are assuming untrusted entities can have access to the shared dir. But
assumption in this model is, shared directory is not reachable by
unprivileged entities. If we break that requirement, there are much
bigger issues to deal with then just security attributes. 

> That's why we have system.*
> xattrs. You want to have an attribute on the host that maps to a
> security attribute on the guest. The host has to protect the attribute
> on the guest with mechanisms of comparable strength as the guest's
> mechanisms. Otherwise you can't trust the guest with host data.

Ok, I understand your desire that security xattrs as seen by guest kernel
should be protected by something stronger than simply user xattr.

> 
> It's a real shame that CAP_SYS_ADMIN is so scary. The capability
> mechanism as implemented today won't scale to the hundreds of individual
> capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
> I'm not convinced that there isn't a way to accomplish what you're
> trying to do without privilege, but this isn't it, and I don't know
> what is. Sorry.
> 
> > Also if directory is not hidden, unprivileged users can change file
> > data and other metadata.
> 
> I assumed that you've taken that into account. Are you saying that
> isn't going to be done correctly either?

I am relying on shared directory not accessible to unprivileged processes.
If that assumption is broken, I guess,  all bets are off. Until and unless
one designs SELinux (or other LSM) policy in such a way so that
only virtiofsd can read/write to these shared directories.

I think Dan Walsh has got SELinux policy written for atleast kata
containers case.

So I guess we will rely on MAC to block unwanted access if users
make a mistake? Is that the idea? I guess that's why you want
a stronger mechansim to store guest security xattrs on host. If
users make a mistake then we have a fallback path?

> 
> >  Why that's not a concern and why there is
> > so much of focus only security xattr.
> 
> As with an NFS mount, the assumption is that UID 567 (or its magically
> mapped equivalent) has the same access rights on both the server/host
> and client/guest. I'm not worried about the mode bits because they are
> presented consistently on both machines. If, on the other hand, an
> attribute used to determine access is security.esprit on the guest and
> user.security.esprit on the host, the unprivileged user on the host
> can defeat the privilege requirements on the guest. That's why.

Hmm..., so if a user id 1000 inside guest can't modify security
xattrs then same user on host should be allowed to bypass that
by modifying user xattr. I agree with that.

Just that I am relying on shared directory not being accessible
to uid 1000 on host and you don't want to rely on that because
users can easily make mistake. And that's why want to stronger
form of mechanism to store security xattrs.

> 
> >  If you were to block modification
> > of file then you will have rely on LSMs.
> 
> No. We're talking about the semantics of the xattr namespaces.
> LSMs can further constrain access to xattrs, but the basic rules
> of access to the user.* and security.* attributes are different
> in any case. This is by design.
> 
> >  And if LSMs are not configured,
> > then we will rely on shared directory not being visible.
> 
> LSMs are not the problem. LSMs use security.* xattrs, which is why
> they come up in the discussion.
> 
> > Can you please help me understand why hiding shared directory from
> > unprivileged users is not a solution
> 
> Maybe you can describe the mechanism you use to "hide" a shared directory
> on the host. If the filesystem is mounted on the host it seems unlikely
> that you can provide a convincing argument for sufficient protection.

I am relying on changing direcotry permissions to allow read/write/search
permission to root only.

Thanks
Vivek

