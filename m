Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FE346D95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhCWWvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233913AbhCWWu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616539856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Cr93mb6JnRs4arNME88BnQuOUnzIS6N9+cha3N56us=;
        b=UZ+8EPXJDLTdPZlSE9YHJHfxaNjDA6yNSbS5X1aetmLtpuI1Kl8oJxzQPNcooc4F1OS7b+
        eh93KnLdGbooAgk5SyzAxzoIYIVSDvmfrLUAEj08KhT1SZT2bGUg+xI96QOLyBVInZA4rt
        gLvLNRAWBfUXktWLv/cCXsVgLk2fpSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-XovzKeluNreOh25xzxZyQw-1; Tue, 23 Mar 2021 18:50:53 -0400
X-MC-Unique: XovzKeluNreOh25xzxZyQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB7065B361;
        Tue, 23 Mar 2021 22:50:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-103.rdu2.redhat.com [10.10.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA26B5C1C5;
        Tue, 23 Mar 2021 22:50:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 10A4F220BCF; Tue, 23 Mar 2021 18:50:46 -0400 (EDT)
Date:   Tue, 23 Mar 2021 18:50:46 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
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
Message-ID: <20210323225046.GH483930@redhat.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
 <20210319195547.427371-2-vgoyal@redhat.com>
 <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
 <20210320100322.ox5gzgauo7iqf2fv@gmail.com>
 <20210322170111.GE446288@redhat.com>
 <20210323093233.iyl4k6x432ytb72c@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323093233.iyl4k6x432ytb72c@wittgenstein>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:32:33AM +0100, Christian Brauner wrote:
> On Mon, Mar 22, 2021 at 01:01:11PM -0400, Vivek Goyal wrote:
> > On Sat, Mar 20, 2021 at 11:03:22AM +0100, Christian Brauner wrote:
> > > On Fri, Mar 19, 2021 at 11:42:48PM +0100, Andreas Grünbacher wrote:
> > > > Hi,
> > > > 
> > > > Am Fr., 19. März 2021 um 20:58 Uhr schrieb Vivek Goyal <vgoyal@redhat.com>:
> > > > > posix_acl_update_mode() determines what's the equivalent mode and if SGID
> > > > > needs to be cleared or not. I need to make use of this code in fuse
> > > > > as well. Fuse will send this information to virtiofs file server and
> > > > > file server will take care of clearing SGID if it needs to be done.
> > > > >
> > > > > Hence move this code in a separate helper so that more than one place
> > > > > can call into it.
> > > > >
> > > > > Cc: Jan Kara <jack@suse.cz>
> > > > > Cc: Andreas Gruenbacher <agruenba@redhat.com>
> > > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > ---
> > > > >  fs/posix_acl.c            |  3 +--
> > > > >  include/linux/posix_acl.h | 11 +++++++++++
> > > > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > > > index f3309a7edb49..2d62494c4a5b 100644
> > > > > --- a/fs/posix_acl.c
> > > > > +++ b/fs/posix_acl.c
> > > > > @@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_userns,
> > > > >                 return error;
> > > > >         if (error == 0)
> > > > >                 *acl = NULL;
> > > > > -       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > > > -           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > > > +       if (posix_acl_mode_clear_sgid(mnt_userns, inode))
> > > > >                 mode &= ~S_ISGID;
> > > > >         *mode_p = mode;
> > > > >         return 0;
> > > > > diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> > > > > index 307094ebb88c..073c5e546de3 100644
> > > > > --- a/include/linux/posix_acl.h
> > > > > +++ b/include/linux/posix_acl.h
> > > > > @@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
> > > > >  }
> > > > >
> > > > >
> > > > > +static inline bool
> > > > > +posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
> > > > > +                         struct inode *inode)
> > > > > +{
> > > > > +       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > > > +           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > > > +               return true;
> > > > > +
> > > > > +       return false;
> > > > 
> > > > That's just
> > > > 
> > > > return !in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > >     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID);
> > > > 
> > > > The same pattern we have in posix_acl_update_mode also exists in
> > > > setattr_copy and inode_init_owner, and almost the same pattern exists
> > > > in setattr_prepare, so can this be cleaned up as well? The function
> > > > also isn't POSIX ACL specific, so the function name is misleading.
> > > 
> > > Good idea but that should probably be spun into a separate patchset that
> > > only touches the vfs parts.
> > 
> > IIUC, suggestion is that I should write a VFS helper (and not posix
> > acl helper) and use that helper at other places too in the code. 
> 
> If there are other callers outside of acls (which should be iirc) then
> yes.
> 
> > 
> > I will do that and post in a separate patch series.
> 
> Yeah, I think that makes more sense to have this be a separate change
> instead of putting it together with the fuse change if it touches more
> than one place.

I do see that there are few places where this pattern is used and atleast
some of them should be straight forward conversion.

I will follow this up in separate patch series. I suspect that this
might take little bit of back and forth, so will follow with fuse
changes in parallel and open code there. Once this series gets merged
will send another patch for fuse.

Thanks
Vivek

