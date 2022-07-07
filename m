Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56690569FF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiGGKbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiGGKbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9495564F3;
        Thu,  7 Jul 2022 03:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C3F622B4;
        Thu,  7 Jul 2022 10:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925EBC3411E;
        Thu,  7 Jul 2022 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657189866;
        bh=lWsE81JZr7G4bvmt1HdOt9XAuQK3z64Wg5KVk5o0vFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VImBZOTYKpQi5n4QW2j9idCh/X+j0zJlagIPZTPJM0HHoEUzVnWcUdoM2uJhFTm8o
         SEWsAXghJNIVEFcVXx/QPHCvGKhdQdHENxV9ew0b8IROOf1CoAJC6kTM9GTCZO6S2G
         nS0Bq1Rxy/tTTDpz5VHz93aUtEvOA8MWr9Onq+qYygVTwCKfuElbeEgaTujlvWZT2v
         9nn/GIQx0m00QX2r0RLiurMbRIDOizWYWrk9Vs8IocCxk0n4rMRGaWSkrYYoPgkfFS
         D+Myn4TDGJslaohGPmdSWch1fp3lXAi74YPU+IzQQdIrqoZCRAQDascGev9qIGBdOh
         8VZImmTEgQKZQ==
Date:   Thu, 7 Jul 2022 12:31:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] acl: report correct ownership in some ovl use-cases
Message-ID: <20220707103100.rphgrcnrficb22tk@wittgenstein>
References: <20220705144502.165935-1-brauner@kernel.org>
 <YsXN4056AenjHap9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsXN4056AenjHap9@redhat.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:01:07PM -0400, Vivek Goyal wrote:
> On Tue, Jul 05, 2022 at 04:45:02PM +0200, Christian Brauner wrote:
> > This cycle we added support for mounting overlayfs on top of idmapped mounts.
> > Recently I've started looking into potential corner cases when trying to add
> > additional tests and I noticed that reporting for POSIX ACLs is currently wrong
> > when using idmapped layers with overlayfs mounted on top of it.
> > 
> > I'm going to give a rather detailed explanation to both the origin of the
> > problem and the solution.
> > 
> > Let's assume the user creates the following directory layout and they have a
> > rootfs /var/lib/lxc/c1/rootfs. The files in this rootfs are owned as you would
> > expect files on your host system to be owned. For example, ~/.bashrc for your
> > regular user would be owned by 1000:1000 and /root/.bashrc would be owned by
> > 0:0. IOW, this is just regular boring filesystem tree on an ext4 or xfs
> > filesystem.
> > 
> > The user chooses to set POSIX ACLs using the setfacl binary granting the user
> > with uid 4 read, write, and execute permissions for their .bashrc file:
> > 
> >         setfacl -m u:4:rwx /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc
> > 
> > Now they to expose the whole rootfs to a container using an idmapped mount. So
> > they first create:
> > 
> >         mkdir -pv /vol/contpool/{ctrover,merge,lowermap,overmap}
> >         mkdir -pv /vol/contpool/ctrover/{over,work}
> > 
> > The user now creates an idmapped mount for the rootfs:
> > 
> >         mount-idmapped/mount-idmapped --map-mount=b:0:10000000:65536 \
> >                                       /var/lib/lxc/c2/rootfs \
> >                                       /vol/contpool/lowermap
> > 
> > This for example makes it so that /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc
> > which is owned by uid and gid 1000 as being owned by uid and gid 10001000 at
> > /vol/contpool/lowermap/home/ubuntu/.bashrc.
> > 
> > Similarly, the user creates another idmapped mount using the same idmapping:
> > 
> >         mount-idmapped/mount-idmapped --map-mount=b:0:10000000:65536 \
> >                                       /vol/contpool/ctrover/ \
> >                                       /vol/contpool/overmap/
> > 
> > Assume the user wants to expose these idmapped mounts through an overlayfs
> > mount to a container.
> > 
> >        mount -t overlay overlay                      \
> >              -o lowerdir=/vol/contpool/lowermap,     \
> >                 upperdir=/vol/contpool/overmap/over, \
> >                 workdir=/vol/contpool/overmap/work   \
> >              /vol/contpool/merge
> > 
> > The user can do this in two ways:
> > 
> > (1) Mount overlayfs in the initial user namespace and expose it to the
> >     container.
> > (2) Mount overlayfs on top of the idmapped mounts inside of the container's
> >     user namespace.
> > 
> > Let's assume the user chooses the (1) option and mounts overlayfs on the host
> > and then changes into a container which uses the idmapping 0:10000000:65536
> > which is the same used for the two idmapped mounts.
> > 
> > Now the user tries to retrieve the POSIX ACLs using the getfacl command
> > 
> >         getfacl -n /vol/contpool/lowermap/home/ubuntu/.bashrc
> > 
> > and to their surprise they see:
> > 
> >         # file: vol/contpool/merge/home/ubuntu/.bashrc
> >         # owner: 1000
> >         # group: 1000
> >         user::rw-
> >         user:4294967295:rwx
> >         group::r--
> >         mask::rwx
> >         other::r--
> > 
> > indicating the the uid wasn't correctly translated according to the idmapped
> > mount. The problem is how we currently translate POSIX ACLs. Let's inspect the
> > callchain in this example:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                   |> vfs_getxattr()
> >                   |  -> __vfs_getxattr()
> >                   |     -> handler->get == ovl_posix_acl_xattr_get()
> >                   |        -> ovl_xattr_get()
> >                   |           -> vfs_getxattr()
> >                   |              -> __vfs_getxattr()
> >                   |                 -> handler->get() /* lower filesystem callback */
> >                   |> posix_acl_fix_xattr_to_user()
> >                      {
> >                               4 = make_kuid(&init_user_ns, 4);
> >                               4 = mapped_kuid_fs(&init_user_ns /* no idmapped mount */, 4);
> >                               /* FAILURE */
> >                              -1 = from_kuid(0:10000000:65536 /* caller's idmapping */, 4);
> >                      }
> > 
> > If the user chooses to use option (2) and mounts overlayfs on top of idmapped
> > mounts inside the container things don't look that much better:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:10000000:65536
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                   |> vfs_getxattr()
> >                   |  -> __vfs_getxattr()
> >                   |     -> handler->get == ovl_posix_acl_xattr_get()
> >                   |        -> ovl_xattr_get()
> >                   |           -> vfs_getxattr()
> >                   |              -> __vfs_getxattr()
> >                   |                 -> handler->get() /* lower filesystem callback */
> >                   |> posix_acl_fix_xattr_to_user()
> >                      {
> >                               4 = make_kuid(&init_user_ns, 4);
> >                               4 = mapped_kuid_fs(&init_user_ns, 4);
> >                               /* FAILURE */
> >                              -1 = from_kuid(0:10000000:65536 /* caller's idmapping */, 4);
> >                      }
> > 
> > As is easily seen the problem arises because the idmapping of the lower mount
> > isn't taken into account as all of this happens in do_gexattr(). But
> > do_getxattr() is always called on an overlayfs mount and inode and thus cannot
> > possible take the idmapping of the lower layers into account.
> > 
> > This problem is similar for fscaps but there the translation happens as part of
> > vfs_getxattr() already. Let's walk through an fscaps overlayfs callchain:
> > 
> >         setcap 'cap_net_raw+ep' /var/lib/lxc/c2/rootfs/home/ubuntu/.bashrc
> > 
> > The expected outcome here is that we'll receive the cap_net_raw capability as
> > we are able to map the uid associated with the fscap to 0 within our container.
> > IOW, we want to see 0 as the result of the idmapping translations.
> > 
> > If the user chooses option (1) we get the following callchain for fscaps:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                    -> vfs_getxattr()
> >                       -> xattr_getsecurity()
> >                          -> security_inode_getsecurity()                                       ________________________________
> >                             -> cap_inode_getsecurity()                                         |                              |
> >                                {                                                               V                              |
> >                                         10000000 = make_kuid(0:0:4k /* overlayfs idmapping */, 10000000);                     |
> >                                         10000000 = mapped_kuid_fs(0:0:4k /* no idmapped mount */, 10000000);                  |
> >                                                /* Expected result is 0 and thus that we own the fscap. */                     |
> >                                                0 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000000);            |
> >                                }                                                                                              |
> >                                -> vfs_getxattr_alloc()                                                                        |
> >                                   -> handler->get == ovl_other_xattr_get()                                                    |
> >                                      -> vfs_getxattr()                                                                        |
> >                                         -> xattr_getsecurity()                                                                |
> >                                            -> security_inode_getsecurity()                                                    |
> >                                               -> cap_inode_getsecurity()                                                      |
> >                                                  {                                                                            |
> >                                                                 0 = make_kuid(0:0:4k /* lower s_user_ns */, 0);               |
> >                                                          10000000 = mapped_kuid_fs(0:10000000:65536 /* idmapped mount */, 0); |
> >                                                          10000000 = from_kuid(0:0:4k /* overlayfs idmapping */, 10000000);    |
> >                                                          |____________________________________________________________________|
> >                                                  }
> >                                                  -> vfs_getxattr_alloc()
> >                                                     -> handler->get == /* lower filesystem callback */
> > 
> > And if the user chooses option (2) we get:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:10000000:65536
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                    -> vfs_getxattr()
> >                       -> xattr_getsecurity()
> >                          -> security_inode_getsecurity()                                                _______________________________
> >                             -> cap_inode_getsecurity()                                                  |                             |
> >                                {                                                                        V                             |
> >                                        10000000 = make_kuid(0:10000000:65536 /* overlayfs idmapping */, 0);                           |
> >                                        10000000 = mapped_kuid_fs(0:0:4k /* no idmapped mount */, 10000000);                           |
> >                                                /* Expected result is 0 and thus that we own the fscap. */                             |
> >                                               0 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000000);                     |
> >                                }                                                                                                      |
> >                                -> vfs_getxattr_alloc()                                                                                |
> >                                   -> handler->get == ovl_other_xattr_get()                                                            |
> >                                     |-> vfs_getxattr()                                                                                |
> >                                         -> xattr_getsecurity()                                                                        |
> >                                            -> security_inode_getsecurity()                                                            |
> >                                               -> cap_inode_getsecurity()                                                              |
> >                                                  {                                                                                    |
> >                                                                  0 = make_kuid(0:0:4k /* lower s_user_ns */, 0);                      |
> >                                                           10000000 = mapped_kuid_fs(0:10000000:65536 /* idmapped mount */, 0);        |
> >                                                                  0 = from_kuid(0:10000000:65536 /* overlayfs idmapping */, 10000000); |
> >                                                                  |____________________________________________________________________|
> >                                                  }
> >                                                  -> vfs_getxattr_alloc()
> >                                                     -> handler->get == /* lower filesystem callback */
> > 
> > We can see how the translation happens correctly in those cases as the
> > conversion happens within the vfs_getxattr() helper.
> > 
> > For POSIX ACLs we need to do something similar. However, in contrast to fscaps
> > we cannot apply the fix directly to the kernel internal posix acl data
> > structure as this would alter the cached values and would also require a rework
> > of how we currently deal with POSIX ACLs in general which almost never take the
> > filesystem idmapping into account (the noteable exception being FUSE but even
> > there the implementation is special) and instead retrieve the raw values based
> > on the initial idmapping.
> > 
> > The correct values are then generated right before returning to userspace. The
> > fix for this is to move taking the mount's idmapping into account directly in
> > vfs_getxattr() instead of having it be part of posix_acl_fix_xattr_to_user().
> > 
> > To this end we split out two small and unexported helpers
> > posix_acl_getxattr_idmapped_mnt() and posix_acl_setxattr_idmapped_mnt(). The
> > former to be called in vfs_getxattr() and the latter to be called in
> > vfs_setxattr().
> > 
> > Let's go back to the original example. Assume the user chose option (1) and
> > mounted overlayfs on top of idmapped mounts on the host:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                   |> vfs_getxattr()
> >                   |  |> __vfs_getxattr()
> >                   |  |  -> handler->get == ovl_posix_acl_xattr_get()
> >                   |  |     -> ovl_xattr_get()
> >                   |  |        -> vfs_getxattr()
> >                   |  |           |> __vfs_getxattr()
> >                   |  |           |  -> handler->get() /* lower filesystem callback */
> >                   |  |           |> posix_acl_getxattr_idmapped_mnt()
> >                   |  |              {
> >                   |  |                       /* This is a nop on non-idmapped mounts. */
> >                   |  |                              4 = make_kuid(&init_user_ns, 4);
> >                   |  |                       10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, 4);
> >                   |  |                       10000004 = from_kuid(&init_user_ns, 10000004);
> >                   |  |                       |___________________________________
> >                   |  |              }                                           |
> >                   |  |> posix_acl_getxattr_idmapped_mnt()                       |
> >                   |     {                                                       |
> >                   |             /* This is a nop on non-idmapped mounts. */     V
> >                   |             10000004 = make_kuid(&init_user_ns, 10000004);
> >                   |             10000004 = mapped_kuid_fs(&init_user_ns /* no idmapped mount */, 10000004);
> >                   |             10000004 = from_kuid(&init_user_ns, 10000004);
> >                   |     }       |_________________________________________________
> >                   |                                                              |
> >                   |> posix_acl_fix_xattr_to_user()                               |
> >                      {                                                           V
> >                                  10000004 = make_kuid(0:0:4k /* init_user_ns */, 10000004);
> >                                         /* SUCCESS */
> >                                         4 = from_kuid(0:10000000:65536 /* caller's idmapping */, 10000004);
> >                      }
> 
> Hi Christian,
> 
> Trying to understand the problem and solution. I am wondering
> why do we still have posix_acl_fix_xattr_to_user().
> 
> Shouldn't posix_acl_getxattr_idmapped_mnt() (Or whatever name is
> appropriate), take care of doing all the translations. Something along
> the lines of cap_inode_getsecurity(). 
> 
> IOW, I am viewing it as if posix_acl_getxattr_idmapped_mnt() takes
> care of doing all the translations for each layer. And it is called
> twice for stacked filesystem. So for the example when overaly is mounted
> from outside the user_ns.
> 
> 	idmapped mount lower:      		0:10000000:65536
> 	caller's idmapping:                      0:10000000:65536
> 	overlayfs idmapping (ofs->creator_cred): 0:0:4k /* initial idmapping */
> 
> Overlay layer translations
> 	10000004 = make_kuid(&init_user_ns, 10000004);
> 	/* Overlayfs mount has no idmapping */
> 	10000004 = mapped_kuid_fs(&init_user_ns, &init_user_ns, 10000004);
> 	/* Map into caller's idmapping. And caller in this case is process
> 	 * inside user namespace */
> 	4 = from_kuid(0:10000000:65536, 10000004);
> 
> Lower layer translations
> 	4 = make_kuid(&init_user_ns, 4);
> 	10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, &init_user_ns, 4);
> 	/* Map into caller's idmapping. And caller in this case is mounter
> 	 * of overlayfs which is init_user_ns */
> 	10000004 = from_kuid(&init_user_ns, 10000004);
> 
> Above kind of makes more sense to me based on your documentation here.
> 
> https://www.kernel.org/doc/html/latest/filesystems/idmappings.html
> 
> But there is a good chance that I am missing something.
> 
> And when overlayfs is mounted from inside user namepsace, then
> translations could look as follows.
> 
> 	idmapped mount lower:      		0:10000000:65536
> 	caller's idmapping:                      0:10000000:65536
> 	overlayfs idmapping (ofs->creator_cred): 0:10000000:65536
> 
> Overlay layer translations
> 	/* Overlayfs was mounted from inside user namespace */
> 	10000004 = make_kuid(0:10000000:65536, 4);
> 	/* Overlayfs mount has no idmapping */
> 	10000004 = mapped_kuid_fs(&init_user_ns, 0:10000000:65536, 10000004);
> 	/* Map into caller's idmapping. And caller in this case is process
> 	 * inside user namespace */
> 	4 = from_kuid(0:10000000:65536, 10000004);
> 
> Lower layer translations
> 	4 = make_kuid(&init_user_ns, 4);
> 	10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, &init_user_ns, 4);
> 	/* Map into caller's idmapping. And caller in this case is mounter
> 	 * of overlayfs which was inside user namespace */
> 	4 = from_kuid(0:10000000:65536, 10000004);
> 
> 
> 
> > And similarly if the user chooses option (1) and mounted overayfs on top of
> 
> You probably mean if "user chooses option (2)". And following example
> also seems to be for option 1 and not option 2.

Indeed, fixed.

> 
> Thanks
> Vivek
> 
> > idmapped mounts inside the container:
> > 
> >         idmapped mount /vol/contpool/merge:      0:10000000:65536
> >         caller's idmapping:                      0:10000000:65536
> >         overlayfs idmapping (ofs->creator_cred): 0:10000000:65536
> > 
> >         sys_getxattr()
> >         -> path_getxattr()
> >            -> getxattr()
> >               -> do_getxattr()
> >                   |> vfs_getxattr()
> >                   |  |> __vfs_getxattr()
> >                   |  |  -> handler->get == ovl_posix_acl_xattr_get()
> >                   |  |     -> ovl_xattr_get()
> >                   |  |        -> vfs_getxattr()
> >                   |  |           |> __vfs_getxattr()
> >                   |  |           |  -> handler->get() /* lower filesystem callback */
> >                   |  |           |> posix_acl_getxattr_idmapped_mnt()
> >                   |  |              {
> >                   |  |                       /* This is a nop on non-idmapped mounts. */
> >                   |  |                              4 = make_kuid(&init_user_ns, 4);
> >                   |  |                       10000004 = mapped_kuid_fs(0:10000000:65536 /* lower idmapped mount */, 4);
> >                   |  |                       10000004 = from_kuid(&init_user_ns, 10000004);
> >                   |  |                       |___________________________________
> >                   |  |              }                                           |
> >                   |  |> posix_acl_getxattr_idmapped_mnt()                       |
> >                   |     {                                                       |
> >                   |             /* This is a nop on non-idmapped mounts. */     V
> >                   |             10000004 = make_kuid(&init_user_ns, 10000004);
> 
> In this example, overlayfs is mounted from inside the user namespace,
> so overlay filesystem idmappings are not init_user_ns. Should this be
> following instead.

I initially had the same idea as you had. But I alluded to a problem
with this in the following section of the commit message:

        of how we currently deal with POSIX ACLs in general which almost never take the
        filesystem idmapping into account (the noteable exception being FUSE but even

First, let's consider a tmpfs mounted inside of a container with the
current translation routines:
====================================================================

caller_idmapping: 0:10000000:65536
fs_idmapping:     0:10000000:65536

/* Setting a POSIX ACL for uid 4 on a tmpfs mounted in container */
 1 sys_setxattr()
 2 -> path_setxattr()
 3    -> setxattr()
 4       -> do_setxattr()
 5          |> posix_acl_fix_xattr_from_user()
 6          |  {
 7 	    |          /* caller_idmapping */
 8          |          10000004 = make_kuid(0:10000000:65536, 4);
 9 	    |          /* no idmapped mount */
10          |          10000004 = mapped_kuid_user(&init_user_ns, &init_user_ns, 10000004);
11          |          /* Always initial_idmapping, never fs_idmapping */
12          |          10000004 = from_kuid(&init_user_ns, 10000004);
13          |  }
14          |> vfs_setxattr()
15              -> __vfs_setxattr_locked()
16                 -> __vfs_setxattr_noperm()
17                    -> __vfs_setxattr()
18                       -> handler->set() == posix_acl_xattr_set()
19                          -> posix_acl_from_xattr(&init_user_ns, ...)
20                             {
21 			            /* Always initial_idmapping, never fs_idmapping (Notable exception being FUSE). */
22                                     10000004 = make_kuid(&init_user_ns, 10000004);
23                             }
24                             -> set_posix_acl()
25                                -> posix_acl_valid(i_user_ns(inode), ...)
26                                   {
27                                          /* fs_idmapping */
28                                           true = kuid_has_mapping(0:10000000:65536, 10000004);
29                                   }
30                                   -> inode->i_op->set_acl() == simple_set_acl()
31                                      -> posix_acl_update_mode()
32                                      -> set_cached_acl()

/* Retrieving the POSIX ACL for uid 4 on a tmpfs mounted in container */
 1 sys_getxattr()
 2 -> path_getxattr()
 3    -> getxattr()
 4       -> do_getxattr()
 5           |> vfs_getxattr()
 6           |  -> __vfs_getxattr()
 7           |     -> handler->get == posix_acl_xattr_get()
 8           |        -> posix_acl_to_xattr(&init_user_ns, ...)
 9           |           {
10 	     |  	      /* Always initial_idmapping, never fs_idmapping (Notable exception being FUSE). */
11           |                   10000004 = from_kuid(&init_user_ns, 10000004);
12           |           }
13           |> posix_acl_fix_xattr_to_user()
14              {
15 	             /* Always initial_idmapping, never fs_idmapping. */
16                      10000004 = make_kuid(&init_user_ns, 10000004);
17 		     /* no idmapped mount */
18                      10000004 = mapped_kuid_fs(&init_user_ns, &init_user_ns, 10000004);
19                      /* caller_idmapping */
20                      4 = from_kuid(0:10000000:65536, 10000004);
21              }

As you can see in line getxattr-8, getxattr-15 as well as setxattr-12
and setxattr-21 it's always the initial_idmapping that is used, never
the idmapping of the filesystem. Iow, even for a tmpfs mounted in a
container we'd use the initial_idmapping to prepare the ACLs for the
filesystem. 

But now let's consider a tmpfs mounted inside of a container with your
proposed translation routines where this causes things to break:
======================================================================

caller_idmapping: 0:10000000:65536
fs_idmapping:     0:10000000:65536

/* Setting a POSIX ACL for uid 4 on a tmpfs mounted inside a user namespace. */
 1 sys_setxattr()
 2 -> path_setxattr()
 3    -> setxattr()
 4       -> do_setxattr()
 5          -> vfs_setxattr()
 6             -> posix_acl_fix_xattr_from_user()
 7                {
 8                         /* caller_idmapping */
 9                        10000004 = make_kuid(0:10000000:65536, 4);
10 		          /* no idmapped mount */
11                        10000004 = mapped_kuid_user(&init_user_ns, &init_user_ns, 10000004);
12 	                  /* NEW: fs_idmapping */
13                               4 = from_kuid(0:10000000:65536, 10000004);
14                }
15             -> __vfs_setxattr_locked()
16                -> __vfs_setxattr_noperm()
17                   -> __vfs_setxattr()
18                      -> handler->set() == posix_acl_xattr_set()
19                         -> posix_acl_from_xattr(&init_user_ns, ...)
20                            {
21 				      /* Always initial_idmapping, never fs_idmapping (Notable exception being FUSE). */
22                                    4 = make_kuid(&init_user_ns, 4);
23                            }
24                            -> set_posix_acl()
25                               -> posix_acl_valid(i_user_ns(inode), ...)
26                                  {
27                                          /* fs_idmapping */
28                                          false = kuid_has_mapping(0:10000000:65536, 4); /* FAILURE */
29                                  }
30                                  -> inode->i_op->set_acl() == simple_set_acl()
31                                     -> posix_acl_update_mode()
32                                     -> set_cached_acl()

 1 sys_getxattr()
 2 -> path_getxattr()
 3    -> getxattr()
 4       -> do_getxattr()
 5           -> vfs_getxattr()
 6              |> __vfs_getxattr()
 7              |  -> handler->get == posix_acl_xattr_get()
 8              |     -> posix_acl_to_xattr(&init_user_ns, ...)
 9              |        {
10              |                /* Always initial_idmapping, never fs_idmapping (Notable exception being FUSE). */
11              |                10000004 = from_kuid(&init_user_ns, 10000004);
12              |        }
13              |> posix_acl_fix_xattr_to_user()
14                 {
15                         /* fs_idmapping */                     
16                         -1 = make_kuid(0:10000000:65536, 10000004);
17                         -1 = mapped_kuid_fs(&init_user_ns, &init_user_ns, 10000004);
18                         /* caller_idmapping */
19                         -1 = from_kuid(0:10000000:65536, 10000004);
20                 }

So if we start to take the fs_idmapping into account in getxattr-15 and
setxattr-13 we will fail to create or retrieve ACLs for tmpfs mounted in
containers.

Now, the reason for this is that posix_acl_{from,to}_xattr() in line
getxattr-8 and setxattr-19 don't operate on the fs_idmapping but always
on the initial_idmapping.

I considered switching posix_acl_{from,to}_xattr() to operate on the
fs_idmapping to make the translation routines work the way you
described:

tmpfs: mounted inside of container with __adapted__ current translation routines
================================================================================

caller_idmapping: 0:10000000:65536
fs_idmapping:     0:10000000:65536

/* Setting a POSIX ACL for uid 4 on a tmpfs mounted inside a user namespace */
 1 sys_setxattr()
 2 -> path_setxattr()
 3    -> setxattr()
 4       -> do_setxattr()
 5          |> posix_acl_fix_xattr_from_user()
 6          |  {
 7 	    |          /* caller_idmapping */
 8          |          10000004 = make_kuid(0:10000000:65536, 4);
 9 	    |          /* no idmapped mount */
10          |          10000004 = mapped_kuid_user(&init_user_ns, &init_user_ns, 10000004);
11          |          /* NEW: fs_idmapping */
12          |                 4 = from_kuid(0:10000000:65536, 10000004);
13          |  }
14          |> vfs_setxattr()
15              -> __vfs_setxattr_locked()
16                 -> __vfs_setxattr_noperm()
17                    -> __vfs_setxattr()
18                       -> handler->set() == posix_acl_xattr_set()
19                          -> posix_acl_from_xattr(0:10000000:65536, ...)
20                             {
21                                     /* NEW: fs_idmapping */
22                                     10000004 = make_kuid(0:10000000:65536, 4);
23                             }
24                             -> set_posix_acl()
25                                -> posix_acl_valid(i_user_ns(inode), ...)
26                                   {
27                                          /* fs_idmapping */
28                                           true = kuid_has_mapping(0:10000000:65536, 10000004);
29                                   }
30                                   -> inode->i_op->set_acl() == simple_set_acl()
31                                      -> posix_acl_update_mode()
32                                      -> set_cached_acl()

 1 sys_getxattr()
 2 -> path_getxattr()
 3    -> getxattr()
 4       -> do_getxattr()
 5           |> vfs_getxattr()
 6           |  -> __vfs_getxattr()
 7           |     -> handler->get == posix_acl_xattr_get()
 8           |        -> posix_acl_to_xattr(0:10000000:65536, ...)
 9           |           {
10           |                   /* fs_idmapping */
11           |                   4 = from_kuid(0:10000000:65536, 10000004);
12           |           }
13           |> posix_acl_fix_xattr_to_user()
14              {
15                      /* NEW: fs_idmapping */
16                      10000004 = make_kuid(0:10000000:65536, 4);
17	                /* no idmapped mount */
18                      10000004 = mapped_kuid_fs(&init_user_ns, &init_user_ns, 10000004);
19                      /* caller_idmapping */
20                      4 = from_kuid(0:10000000:65536, 10000004);
21              }

Now your proposal works. But I thought two things spoke against it but
I'm happy to be convinced otherwise. First, the change is tree-wide and
subtle.

Second, this would mean that in both line getxattr-10 and line
setxattr-11 we'd have a raw uid and gid value - which is 4 in this
example - stored instead of the "mapped" 10000004 until the fs_idmapping
is reapplied in getxattr-15 and setxattr-21.

(Technically, this is currently a subtle type confusion but one that
we've tolerated for a long time. The 10000004 isn't really a {g,u}id
it's a k{g,u}id which is stored in the form of a {g,u}id in the posix
acl uapi struct which doesn't carre {g,u}ids. Otherwise we could just
carry the k{g,u}ids generated via caller_idmapping directly...)

All of this is probably not a huge deal and we could change it. And I'd
consider that in the future but for now the safer way to do this from my
vantage point was to keep the posix_acl_{from,to}_xattr() helpers as
they are and just move the idmapped mount translations into vfs_setxattr().

Iow, within vfs_setxattr() we'd continue to purely deal with non-caller
properties such as idmapped mounts. I'm happy to pursue other approaches
though including the one you proposed if you think it's worth it though.

(Sorry for the lenghty mail... Hopefully I didn't make any mnistakes in
my thinking.)
