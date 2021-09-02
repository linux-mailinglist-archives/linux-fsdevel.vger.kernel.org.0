Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7D3FF2C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhIBRqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347295AbhIBRnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630604568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6M/wgbQIeuI4dl1ecVvAF+kwe81RW4A+xW1u6uekdY=;
        b=Yf0NUpMsx42XDX0CnBgaTyH7gY1RypJ9Hj13GG5uVFS9ZrjpBZznadpRYCHomQyYAvj416
        DzRTagYSpa+C1icQOXSfK1PfIY4esmtReXYaX2bO9WecBpsTQm1RD+dlukxQWQuDmuBZGC
        wk4TN0taZii7QSv3P0Hvr5BGuLZ8qsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-89HTkiHiMRStRTpIX110kQ-1; Thu, 02 Sep 2021 13:42:47 -0400
X-MC-Unique: 89HTkiHiMRStRTpIX110kQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84553835DE0;
        Thu,  2 Sep 2021 17:42:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7A05C232;
        Thu,  2 Sep 2021 17:42:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7CEFF220257; Thu,  2 Sep 2021 13:42:40 -0400 (EDT)
Date:   Thu, 2 Sep 2021 13:42:40 -0400
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
Message-ID: <YTENEAv6dw9QoYcY@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTEEPZJ3kxWkcM9x@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:05:01PM -0400, Vivek Goyal wrote:
> On Thu, Sep 02, 2021 at 08:43:50AM -0700, Casey Schaufler wrote:
> > On 9/2/2021 8:22 AM, Vivek Goyal wrote:
> > > Hi,
> > >
> > > This is V3 of the patch. Previous versions were posted here.
> > >
> > > v2:
> > > https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> > > v1:
> > > https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.co
> > > +m/
> > >
> > > Changes since v2
> > > ----------------
> > > - Do not call inode_permission() for special files as file mode bits
> > >   on these files represent permissions to read/write from/to device
> > >   and not necessarily permission to read/write xattrs. In this case
> > >   now user.* extended xattrs can be read/written on special files
> > >   as long as caller is owner of file or has CAP_FOWNER.
> > >  
> > > - Fixed "man xattr". Will post a patch in same thread little later. (J.
> > >   Bruce Fields)
> > >
> > > - Fixed xfstest 062. Changed it to run only on older kernels where
> > >   user extended xattrs are not allowed on symlinks/special files. Added
> > >   a new replacement test 648 which does exactly what 062. Just that
> > >   it is supposed to run on newer kernels where user extended xattrs
> > >   are allowed on symlinks and special files. Will post patch in 
> > >   same thread (Ted Ts'o).
> > >
> > > Testing
> > > -------
> > > - Ran xfstest "./check -g auto" with and without patches and did not
> > >   notice any new failures.
> > >
> > > - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
> > >   filesystems and it works.
> > >  
> > > Description
> > > ===========
> > >
> > > Right now we don't allow setting user.* xattrs on symlinks and special
> > > files at all. Initially I thought that real reason behind this
> > > restriction is quota limitations but from last conversation it seemed
> > > that real reason is that permission bits on symlink and special files
> > > are special and different from regular files and directories, hence
> > > this restriction is in place. (I tested with xfs user quota enabled and
> > > quota restrictions kicked in on symlink).
> > >
> > > This version of patch allows reading/writing user.* xattr on symlink and
> > > special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.
> > 
> > This part of your project makes perfect sense. There's no good
> > security reason that you shouldn't set user.* xattrs on symlinks
> > and/or special files.
> > 
> > However, your virtiofs use case is unreasonable.
> 
> Ok. So we can merge this patch irrespective of the fact whether virtiofs
> should make use of this mechanism or not, right?
> 
> > 
> > > Who wants to set user.* xattr on symlink/special files
> > > -----------------------------------------------------
> > > I have primarily two users at this point of time.
> > >
> > > - virtiofs daemon.
> > >
> > > - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
> > >   fuse-overlay as well and he ran into similar issue. So fuse-overlay
> > >   should benefit from this change as well.
> > >
> > > Why virtiofsd wants to set user.* xattr on symlink/special files
> > > ----------------------------------------------------------------
> > > In virtiofs, actual file server is virtiosd daemon running on host.
> > > There we have a mode where xattrs can be remapped to something else.
> > > For example security.selinux can be remapped to
> > > user.virtiofsd.securit.selinux on the host.
> > 
> > As I have stated before, this introduces a breach in security.
> > It allows an unprivileged process on the host to manipulate the
> > security state of the guest. This is horribly wrong. It is not
> > sufficient to claim that the breach requires misconfiguration
> > to exploit. Don't do this.
> 
> So couple of things.
> 
> - Right now whole virtiofs model is relying on the fact that host
>   unpriviliged users don't have access to shared directory. Otherwise
>   guest process can simply drop a setuid root binary in shared directory
>   and unpriviliged process can execute it and take over host system.
> 
>   So if virtiofs makes use of this mechanism, we are well with-in
>   the existing constraints. If users don't follow the constraints,
>   bad things can happen.
> 
> - I think Smalley provided a solution for your concern in other thread
>   we discussed this issue.
> 
>   https://lore.kernel.org/selinux/CAEjxPJ4411vL3+Ab-J0yrRTmXoEf8pVR3x3CSRgPjfzwiUcDtw@mail.gmail.com/T/#mddea4cec7a68c3ee5e8826d650020361030209d6
> 
> 
>   "So for example if the host policy says that only virtiofsd can set
> attributes on those files, then the guest MAC labels along with all
> the other attributes are protected against tampering by any other
> process on the host."
> 
>  Apart from hiding the shared directory from unpriviliged processes,
>  we could design selinux policy in such a way that only virtiofsd
>  is allowed "setattr". That should make sure even in case of
>  misconfiguration, unprivileged process is not able to change
>  guest security xattrs stored in "user.virtiofs.security.selinux".
> 
>  I think that sounds like a very reasonable proposition.
> 
> > 
> > > This remapping is useful when SELinux is enabled in guest and virtiofs
> > > as being used as rootfs. Guest and host SELinux policy might not match
> > > and host policy might deny security.selinux xattr setting by guest
> > > onto host. Or host might have SELinux disabled and in that case to
> > > be able to set security.selinux xattr, virtiofsd will need to have
> > > CAP_SYS_ADMIN (which we are trying to avoid).
> > 
> > Adding this mapping to virtiofs provides the breach for any
> > LSM using xattrs.
> 
> I think both the points above answer this as well.
> 
> > 
> > >  Being able to remap
> > > guest security.selinux (or other xattrs) on host to something else
> > > is also better from security point of view.
> > >
> > > But when we try this, we noticed that SELinux relabeling in guest
> > > is failing on some symlinks. When I debugged a little more, I
> > > came to know that "user.*" xattrs are not allowed on symlinks
> > > or special files.
> > >
> > > So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> > > allow virtiofs to arbitrarily remap guests's xattrs to something
> > > else on host and that solves this SELinux issue nicely and provides
> > > two SELinux policies (host and guest) to co-exist nicely without
> > > interfering with each other.
> > 
> > virtiofs could use security.* or system.* xattrs instead of user.*
> > xattrs. Don't use user.* xattrs.
> 
> So requirement is that every layer (host, guest and nested guest), will
> have a separate security.selinux label and virtiofsd should be able
> to retrieve/set any of the labels depending on access.
> 
> How do we achieve that with single security.selinux label per inode on host.

I guess we could think of using trusted.* but that requires CAP_SYS_ADMIN
in init_user_ns. And we wanted to retain capability to run virtiofsd
inside user namespace too. Also we wanted to give minimum required
capabilities to virtiofsd to reduce the risk what if virtiofsd gets
compromised. So amount of damage it can do to system is minimum.

So guest security.selinux xattr could potentially be mapped to.

trusted.virtiofs.security.selinux

nested guest selinux xattrs could be mapped to.

trusted.virtiofs.trusted.virtiofs.security.selinux

And given reading/setting trusted.* requires CAP_SYS_ADMIN, that means
unpriviliged processes can't change these security attributes of a
file.

And trade-off is that virtiofsd process needs to be given CAP_SYS_ADMIN.

Frankly speaking, we are more concerned about the security of host
system (as opposed to something changing in file for guest). So while
using "trusted.*" is still an option, I would think that not running
virtiofsd with CAP_SYS_ADMIN probably has its advantages too. On host
if we can just hide the shared dir from unpriviliged processes then
we get best of both the worlds. Unpriviliged processes can't change
anything on the shared file at the same time, possible damage by
virtiofsd is less if it gets compromised.

Thanks
Vivek

