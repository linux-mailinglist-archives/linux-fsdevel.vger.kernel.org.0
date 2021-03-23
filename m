Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553D9345AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCWJcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:32:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWJci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:32:38 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOdOs-0000ly-LP; Tue, 23 Mar 2021 09:32:34 +0000
Date:   Tue, 23 Mar 2021 10:32:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        lhenriques@suse.de, dgilbert@redhat.com,
        Seth Forshee <seth.forshee@canonical.com>,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/3] posic_acl: Add a helper determine if SGID should be
 cleared
Message-ID: <20210323093233.iyl4k6x432ytb72c@wittgenstein>
References: <20210319195547.427371-1-vgoyal@redhat.com>
 <20210319195547.427371-2-vgoyal@redhat.com>
 <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
 <20210320100322.ox5gzgauo7iqf2fv@gmail.com>
 <20210322170111.GE446288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322170111.GE446288@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:01:11PM -0400, Vivek Goyal wrote:
> On Sat, Mar 20, 2021 at 11:03:22AM +0100, Christian Brauner wrote:
> > On Fri, Mar 19, 2021 at 11:42:48PM +0100, Andreas Grünbacher wrote:
> > > Hi,
> > > 
> > > Am Fr., 19. März 2021 um 20:58 Uhr schrieb Vivek Goyal <vgoyal@redhat.com>:
> > > > posix_acl_update_mode() determines what's the equivalent mode and if SGID
> > > > needs to be cleared or not. I need to make use of this code in fuse
> > > > as well. Fuse will send this information to virtiofs file server and
> > > > file server will take care of clearing SGID if it needs to be done.
> > > >
> > > > Hence move this code in a separate helper so that more than one place
> > > > can call into it.
> > > >
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Andreas Gruenbacher <agruenba@redhat.com>
> > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > ---
> > > >  fs/posix_acl.c            |  3 +--
> > > >  include/linux/posix_acl.h | 11 +++++++++++
> > > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > > index f3309a7edb49..2d62494c4a5b 100644
> > > > --- a/fs/posix_acl.c
> > > > +++ b/fs/posix_acl.c
> > > > @@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_userns,
> > > >                 return error;
> > > >         if (error == 0)
> > > >                 *acl = NULL;
> > > > -       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > > -           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > > +       if (posix_acl_mode_clear_sgid(mnt_userns, inode))
> > > >                 mode &= ~S_ISGID;
> > > >         *mode_p = mode;
> > > >         return 0;
> > > > diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> > > > index 307094ebb88c..073c5e546de3 100644
> > > > --- a/include/linux/posix_acl.h
> > > > +++ b/include/linux/posix_acl.h
> > > > @@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
> > > >  }
> > > >
> > > >
> > > > +static inline bool
> > > > +posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
> > > > +                         struct inode *inode)
> > > > +{
> > > > +       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > > +           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > > +               return true;
> > > > +
> > > > +       return false;
> > > 
> > > That's just
> > > 
> > > return !in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > >     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID);
> > > 
> > > The same pattern we have in posix_acl_update_mode also exists in
> > > setattr_copy and inode_init_owner, and almost the same pattern exists
> > > in setattr_prepare, so can this be cleaned up as well? The function
> > > also isn't POSIX ACL specific, so the function name is misleading.
> > 
> > Good idea but that should probably be spun into a separate patchset that
> > only touches the vfs parts.
> 
> IIUC, suggestion is that I should write a VFS helper (and not posix
> acl helper) and use that helper at other places too in the code. 

If there are other callers outside of acls (which should be iirc) then
yes.

> 
> I will do that and post in a separate patch series.

Yeah, I think that makes more sense to have this be a separate change
instead of putting it together with the fuse change if it touches more
than one place.

Thanks!
Christian
