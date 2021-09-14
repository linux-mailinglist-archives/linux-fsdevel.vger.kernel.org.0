Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5109B40AE42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhINMxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 08:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhINMxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631623922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZChv2040w8kh2fxqWTvSsejGrn3bEO5wpgltjJDlvDk=;
        b=Pie7SLedsVI8Z07jl54cGYGvbWcfr0GAyCvqP4tgQetIfDIn3J4M6TYXl2G80Hxa9Yul+A
        z/w1GcCzs4uA3M9P7kBIR8TaBvbFRcezx6jbKNwNJC1moEHHBuz7qrYpbrGpAapaIiycc7
        kU3+NmJGYQGRURD3sGo5wutW2xLIHwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-wDjwVCCYP0eYlf0jikgUJQ-1; Tue, 14 Sep 2021 08:52:01 -0400
X-MC-Unique: wDjwVCCYP0eYlf0jikgUJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A309A9017C2;
        Tue, 14 Sep 2021 12:51:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202505C25A;
        Tue, 14 Sep 2021 12:51:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9E428220779; Tue, 14 Sep 2021 08:51:54 -0400 (EDT)
Date:   Tue, 14 Sep 2021 08:51:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, bfields@redhat.com,
        stephen.smalley.work@gmail.com, agruenba@redhat.com,
        david@fromorbit.com
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YUCa6pWpr5cjCNrU@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
 <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
 <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:05:07PM -0700, Casey Schaufler wrote:
> On 9/6/2021 7:55 AM, Dr. David Alan Gilbert wrote:
> > * Casey Schaufler (casey@schaufler-ca.com) wrote:
> >> On 9/2/2021 1:06 PM, Vivek Goyal wrote:
> >>>  If LSMs are not configured,
> >>> then hiding the directory is the solution.
> >> It's not a solution at all. It's wishful thinking that
> >> some admin is going to do absolutely everything right, will
> >> never make a mistake and will never, ever, read the mount(2)
> >> man page.
> > That is why we run our virtiofsd with a sandbox setup and seccomp; and
> > frankly anything we can or could turn on we would.
> 
> That doesn't address my concern at all. Being able to create an
> environment in which a feature can be used safely does not make
> the feature safe.

That's the requirement of virtiofs shared directory. It is a shared
directory, potentially being used by untrusted guest. So it should
not be accessible to unprivileged entities on host.

Same is the requirement for regular containers and that's why
podman (and possibly other container managers), make top level
storage directory only readable and searchable by root, so that
unpriveleged entities on host can not access container root filesystem
data.

I think similar requirements are there for idmapped mounts. One
will shift container images into user namespaces. And that means,
through idmapped mounts one can write files which will actually
show up as owned by root in original directory. And that original
directory should not be accessible to unprivileged users otherwise
user found an easy way to drop root owned files on system and
exectute these.

So more and more use cases are there which are relying on directory
not being accessible to unprivileged users.

I understand it is not going to be easy to get the configurations
right all the time. But orchestration tools can be helpful. container
managers can make sure kata container rootfs are not accessible.
libvirt can probably warn if shared directory is accessible to
unprivileged users. And all that will help in getting configuration
right.

> 
> 
> > So why that's not a solution and only relying on CAP_SYS_ADMIN is the
> > solution. I don't understand that part.
> 
> Sure you do. If you didn't, you wouldn't be so concerned about
> requiring CAP_SYS_ADMIN. You're trying hard to avoid taking the
> level of responsibility that running with privilege requires.

Running with minimal capabilities is always desired. So we want
to do away with CAP_SYS_ADMIN. And this reduces our risk in
case virtiofsd gets compromised.

I thought we had similar reasons that we did not want setuid
root binaries and wanted to give them limited set of capabilites
depending on what they are doing.

> To do that, you're introducing a massive security hole, a backdoor
> into the file system security attributes.

Shared directory is not accessible to unprivileged entities. If
configuration is not right, then it is user's problem and we
need to fix that.

> 
> >> It comes back to your design, which is fundamentally flawed. You
> >> can't store system security information in an attribute that can
> >> be manipulated by untrusted entities. That's why we have system.*
> >> xattrs. You want to have an attribute on the host that maps to a
> >> security attribute on the guest. The host has to protect the attribute
> >> on the guest with mechanisms of comparable strength as the guest's
> >> mechanisms.
> > Can you just explain this line to me a bit more: 
> >> Otherwise you can't trust the guest with host data.
> > Note we're not trying to trust the guest with the host data here;
> > we're trying to allow the guest to store the data on the host, while
> > trusting the host.
> 
> But you can't trust the host! You're allowing unprivileged processes
> on the host to modify security state of the guest.

No we are not. Shared directory should not be accessible to
unpriviliged entities on host.

> 
> >> It's a real shame that CAP_SYS_ADMIN is so scary. The capability
> >> mechanism as implemented today won't scale to the hundreds of individual
> >> capabilities it would need to break CAP_SYS_ADMIN up. Maybe someday.
> >> I'm not convinced that there isn't a way to accomplish what you're
> >> trying to do without privilege, but this isn't it, and I don't know
> >> what is. Sorry.
> >>
> >>> Also if directory is not hidden, unprivileged users can change file
> >>> data and other metadata.
> >> I assumed that you've taken that into account. Are you saying that
> >> isn't going to be done correctly either?
> >>
> >>>  Why that's not a concern and why there is
> >>> so much of focus only security xattr.
> >> As with an NFS mount, the assumption is that UID 567 (or its magically
> >> mapped equivalent) has the same access rights on both the server/host
> >> and client/guest. I'm not worried about the mode bits because they are
> >> presented consistently on both machines. If, on the other hand, an
> >> attribute used to determine access is security.esprit on the guest and
> >> user.security.esprit on the host, the unprivileged user on the host
> >> can defeat the privilege requirements on the guest. That's why.
> > We're OK with that;
> 
> I understand that. I  am  not  OK  with  that.

Unprivileged entities can't modify "user.viritiofs.security.selinux"
as shared directory is not accessible to them.

Sorry, I have to repeat this so many times because you are 
completely ignoring this requirement saying users will get it
wrong. Sure if they do get it wrong, they need to fix it.  But
that does not mean we start giving CAP_SYS_ADMIN to daemon. 

If shared direcotry is accessible to unprivileged entities, game
is already over (setuid root binaries). Being able to modify
security attributes of a file seems like such a minor concern
in comparison.

> 
> >  remember that the host can do wth it likes to the
> > guest anyway
> 
> We're not talking about "the host", we're talking about an
> unprivileged user on the host.
> 
> >  - it can just go in and poke at the guests RAM if it wants
> > to do something evil to the guest.
> > We wouldn't suggest using a scheme like this once you have
> > encrypted/protected guest RAM for example (SEV/TDX etc)
> >
> >>>  If you were to block modification
> >>> of file then you will have rely on LSMs.
> >> No. We're talking about the semantics of the xattr namespaces.
> >> LSMs can further constrain access to xattrs, but the basic rules
> >> of access to the user.* and security.* attributes are different
> >> in any case. This is by design.
> > I'm happy if you can suggest somewhere else to store the guests xattr
> > data other than in one of the hosts xattr's - the challenge is doing
> > that in a non-racy way, and making sure that the xattr's never get
> > associated with the wrong file as seen by a guest.
> 
> I'm sorry, but I've got a bunch of other stuff on my plate.
> I've already suggested implementing xattr namespaces a'la user
> namespaces, but I understand that is beyond the scope of your
> current needs, and has its own set of dragons.
> 
> >>>  And if LSMs are not configured,
> >>> then we will rely on shared directory not being visible.
> >> LSMs are not the problem. LSMs use security.* xattrs, which is why
> >> they come up in the discussion.
> >>
> >>> Can you please help me understand why hiding shared directory from
> >>> unprivileged users is not a solution
> >> Maybe you can describe the mechanism you use to "hide" a shared directory
> >> on the host. If the filesystem is mounted on the host it seems unlikely
> >> that you can provide a convincing argument for sufficient protection.
> > Why?
> 
> Because 99-44/100% of admins out there aren't as skilled at "hiding"
> data as you are. Many (I almost said "most". I'm still not sure which.)
> of them don't even know how to use mode bits correctly.

We need to rely on orchestration tools to this by default.
podman already does that for containers. We probably need to
add something to libvirt too and warn users.

Vivek

