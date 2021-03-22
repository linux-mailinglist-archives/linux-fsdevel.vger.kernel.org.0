Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E0344C93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCVRBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhCVRBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616432478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kI6JCUton9Pw1WTmpNMH1+Wj/jifPkleYuBOY5L9rd8=;
        b=Rp6BH5UChMLPZvUrspq7nDNAALV4kApmYZhuVLOnIQN0eUPnTTQGxc5BYt+aOnbSd7Y4A4
        OVVGVUyBT4PfhEw4WxXZh9Y/BKE6pKFJ2TdwojmaJqkhuQ0hTj38xwoos7VKVcVh+YMdO8
        patTlbgxcxbmSZrATbmg87uo6+2VGAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-eTs5gemHNB2cz_t9qTRHAQ-1; Mon, 22 Mar 2021 13:01:17 -0400
X-MC-Unique: eTs5gemHNB2cz_t9qTRHAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20406513F;
        Mon, 22 Mar 2021 17:01:15 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-132.rdu2.redhat.com [10.10.114.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 066662B0A9;
        Mon, 22 Mar 2021 17:01:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 603BD220BCF; Mon, 22 Mar 2021 13:01:11 -0400 (EDT)
Date:   Mon, 22 Mar 2021 13:01:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
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
Message-ID: <20210322170111.GE446288@redhat.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
 <20210319195547.427371-2-vgoyal@redhat.com>
 <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
 <20210320100322.ox5gzgauo7iqf2fv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320100322.ox5gzgauo7iqf2fv@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 11:03:22AM +0100, Christian Brauner wrote:
> On Fri, Mar 19, 2021 at 11:42:48PM +0100, Andreas Grünbacher wrote:
> > Hi,
> > 
> > Am Fr., 19. März 2021 um 20:58 Uhr schrieb Vivek Goyal <vgoyal@redhat.com>:
> > > posix_acl_update_mode() determines what's the equivalent mode and if SGID
> > > needs to be cleared or not. I need to make use of this code in fuse
> > > as well. Fuse will send this information to virtiofs file server and
> > > file server will take care of clearing SGID if it needs to be done.
> > >
> > > Hence move this code in a separate helper so that more than one place
> > > can call into it.
> > >
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Andreas Gruenbacher <agruenba@redhat.com>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/posix_acl.c            |  3 +--
> > >  include/linux/posix_acl.h | 11 +++++++++++
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > index f3309a7edb49..2d62494c4a5b 100644
> > > --- a/fs/posix_acl.c
> > > +++ b/fs/posix_acl.c
> > > @@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_userns,
> > >                 return error;
> > >         if (error == 0)
> > >                 *acl = NULL;
> > > -       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > -           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > +       if (posix_acl_mode_clear_sgid(mnt_userns, inode))
> > >                 mode &= ~S_ISGID;
> > >         *mode_p = mode;
> > >         return 0;
> > > diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> > > index 307094ebb88c..073c5e546de3 100644
> > > --- a/include/linux/posix_acl.h
> > > +++ b/include/linux/posix_acl.h
> > > @@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
> > >  }
> > >
> > >
> > > +static inline bool
> > > +posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
> > > +                         struct inode *inode)
> > > +{
> > > +       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > > +           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > > +               return true;
> > > +
> > > +       return false;
> > 
> > That's just
> > 
> > return !in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> >     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID);
> > 
> > The same pattern we have in posix_acl_update_mode also exists in
> > setattr_copy and inode_init_owner, and almost the same pattern exists
> > in setattr_prepare, so can this be cleaned up as well? The function
> > also isn't POSIX ACL specific, so the function name is misleading.
> 
> Good idea but that should probably be spun into a separate patchset that
> only touches the vfs parts.

IIUC, suggestion is that I should write a VFS helper (and not posix
acl helper) and use that helper at other places too in the code. 

I will do that and post in a separate patch series.

Thanks
Vivek

