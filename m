Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73B26E4CF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDQPXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQPWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F921CC04;
        Mon, 17 Apr 2023 08:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B44062573;
        Mon, 17 Apr 2023 15:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F44C433EF;
        Mon, 17 Apr 2023 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681744890;
        bh=lmtLsv1bceOVOVw5ghHPX+EyHyePCk+ywetGO6tMb0Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n5rnO9tPSOfW8PyiNhI7ZWmPUGhY+QvlWPCcmFXDwlK5JTowCE7h/omBAgbR88UYA
         XLZCg0yQk6Ds5GNo19cpu8G0xvGAdy5ZudFksMUORNsjyGaJY3i41vUra07GyXqWu7
         W9A7cg7JDhd3/AgJMCd1JFLc3Kn0725sAtCTA+AzMToFcNxIyU0hY44thPFJbfeWnv
         6nzJLcFpYVoPsDFFqbWonUfWLtGwqp1VRedYtA4ft3ArOlI2X7+mvN48DYFvXaDVYV
         H2QfKe/JO4eR5Hbn/zK+FDyMsBpD+dxJ/RUUvK0fMuUz9qGW4RSUzkKcVISRGiyBfC
         3cr8T94KjD5Tw==
Message-ID: <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 17 Apr 2023 11:21:28 -0400
In-Reply-To: <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168168683217.24821.6260957092725278201@noble.neil.brown.name>
         <20230417-beisein-investieren-360fa20fb68a@brauner>
         <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
         <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-17 at 16:24 +0200, Christian Brauner wrote:
> On Mon, Apr 17, 2023 at 08:25:23AM -0400, Jeff Layton wrote:
> > On Mon, 2023-04-17 at 13:55 +0200, Christian Brauner wrote:
> > > On Mon, Apr 17, 2023 at 09:13:52AM +1000, NeilBrown wrote:
> > > >=20
> > > > When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
> > > > engage with underlying systems at all.  Any mount point MUST be in =
the
> > > > dcache with a complete direct path from the root to the mountpoint.
> > > > That should be sufficient to find the mountpoint given a path name.
> > > >=20
> > > > This becomes an issue when the filesystem changes unexpected, such =
as
> > > > when a NFS server is changed to reject all access.  It then becomes
> > > > impossible to unmount anything mounted on the filesystem which has
> > > > changed.  We could simply lazy-unmount the changed filesystem and t=
hat
> > > > will often be sufficient.  However if the target filesystem needs
> > > > "umount -f" to complete the unmount properly, then the lazy unmount=
 will
> > > > leave it incompletely unmounted.  When "-f" is needed, we really ne=
ed to
> > >=20
> > > I don't understand this yet. All I see is nfs_umount_begin() that's
> > > different for MNT_FORCE to kill remaining io. Why does that preclude
> > > MNT_DETACH? You might very well fail MNT_FORCE and the only way you c=
an
> > > get rid is to use MNT_DETACH, no? So I don't see why that is an
> > > argument.
> > >=20
> > > > be able to name the target filesystem.
> > > >=20
> > > > We NEVER want to revalidate anything.  We already avoid the revalid=
ation
> > > > of the mountpoint itself, be we won't need to revalidate anything o=
n the
> > > > path either as thay might affect the cache, and the cache is what w=
e are
> > > > really looking in.
> > > >=20
> > > > Permission checks are a little less clear.  We currently allow any =
user
> > >=20
> > > This is all very brittle.
> > >=20
> > > First case that comes to mind is overlayfs where the permission check=
ing
> > > is performed twice. Once on the overlayfs inode itself based on the
> > > caller's security context and a second time on the underlying inode w=
ith
> > > the security context of the mounter of the overlayfs instance.
> > >=20
> > > A mounter could have dropped all privileges aside from CAP_SYS_ADMIN =
so
> > > they'd be able to mount the overlayfs instance but would be restricte=
d
> > > from accessing certain directories or files. The task accessing the
> > > overlayfs instance however could have a completely different security
> > > context including CAP_DAC_READ_SEARCH and such. Both tasks could
> > > reasonably be in different user namespaces and so on.
> > >=20
> > > The LSM hooks are also called twice and would now also be called once=
.
> > >=20
> > > It also forgets that acl_permission() check may very well call into t=
he
> > > filesystem via check_acl().
> > >=20
> > > So umount could either be used to infer existence of files that the u=
ser
> > > wouldn't otherwise know they exist or in the worst case allow to umou=
nt
> > > something that they wouldn't have access to.
> > >=20
> > > Aside from that this would break userspace assumptions and as Al and
> > > I've mentioned before in the other thread you'd need a new flag to
> > > umount2() for this. The permission model can't just change behind use=
rs
> > > back.
> > >=20
> > > But I dislike it for the now even more special-cased umount path look=
up
> > > alone tbh. I'd feel way more comfortable with a non-lookup related
> > > solution that doesn't have subtle implications for permission checkin=
g.
> > >=20
> >=20
> > These are good points.
> >=20
> > One way around the issues you point out might be to pass down a new
> > MAY_LOOKUP_MOUNTPOINT mask flag to ->permission. That would allow the
> > filesystem driver to decide whether it wants to avoid potentially
> > problematic activity when checking permissions. nfs_permission could
> > check for that and take a more hands-off approach to the permissions
> > check. Between that and skipping d_revalidate on LOOKUP_MOUNTPOINT, I
> > think that might do what we need.
>=20
> Yes, that's pretty obvious. I considered that, wrote the section and
> deleted it again because I still find this pretty ugly. It does leak
> very specific lookup information into filesystems that isn't generically
> useful like MAY_NOT_BLOCK is. Most filesystems don't need to check with
> a server like NFS does and so don't suffer from this issue.
>=20

Sort of. Most of the MAY flags cover a specific operation. In this case,
we'd just be adding a flag to make it clear that this permission check
is for the specific purpose of chasing down a mountpoint (presumably to
umount).

This field does look less like a "mask" field now though, and more like
a "flags".
=20
> The crucial change in the patchset in its current form is that you're
> requesting from the VFS to significantly alter permission checking just
> because this is a umount request in a pretty fundamental way for roughly
> 21 filesytems. Afaict, on the VFS level that doesn't make sense. The VFS
> can't just skip a filesystem's ->permission() handler with "well, it's
> just on a way to a umount so whatever". That's just not going to be
> correct and is just a source of subtle security bugs. So NAK on that.
>

Fair enough. I too think the permission check ought to be left up to the
filesystem driver. It does need some way to know that the permission
check is in the context of a LOOKUP_MOUNTPOINT pathwalk though. A MAY_*
flag seems like the obvious choice, since we could use that for checking
ACLs too, but maybe there is some better way.

> And I'm curious why is it obvious that we don't want to revalidate _any_
> path component and not just the last one? Why is that generally safe?
> Why can't this be used to access files and directories the caller
> wouldn't otherwise be able to access? I would like to have this spelled
> out for slow people like me, please.
>=20
> From my point of view, this would only be somewhat safe _generally_ if
> you'd allow circumvention for revalidation and permission checking if
> MNT_FORCE is specified and the caller has capable(CAP_DAC_READ_SEARCH).
> You'd still mess with overlayfs permission model in this case though.
>=20
> Plus, there are better options of solving this problem. Again, I'd
> rather build a separate api for unmounting then playing such potentially
> subtle security sensitive games with permission checking during path
> lookup.

umount(2) is really a special case because the whole intent is to detach
a mount from the local hierarchy and stop using it. The unfortunate bit
is that it is a path-based syscall.

So usually we have to:

- determine the path: Maybe stat() it and to validate that it's the
mountpoint we want to drop
- then call umount with that path

The last thing we want in that case is for the server to decide to
change some intermediate dentry in between the two operations. Best
case, you'll get back ENOENT or something when the pathwalk fails. Worst
case, the server swaps what are two different mountpoints on your client
and you unmount the wrong one.

If we don't revaliate, then we're no worse off, and may be better off if
something hinky happens to the server of an intermediate dentry in the
path.
--=20
Jeff Layton <jlayton@kernel.org>
