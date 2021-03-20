Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70D342B96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCTKv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 06:51:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTKvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 06:51:21 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lNYS5-0004S0-K1
        for linux-fsdevel@vger.kernel.org; Sat, 20 Mar 2021 10:03:25 +0000
Received: by mail-ed1-f72.google.com with SMTP id o15so24334431edv.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Mar 2021 03:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6xT9jeCPBXNdoVrmRy60VcYXZbqaQTYKy1zemjeU5tQ=;
        b=LD5o6GlvhjvnbkviERDCQqT9QeEtqwlfRjK8EyLN1+vP34BShBoIzfrWV112Ta7Klt
         no7/nHE86RQCddTLUl8vCOKCIeIXhtvNd+KX6bg53uUuClRwRNyp7H/MTFclMJTW1RAE
         alV3gFGJNsxRZtL3ZQlgnD7B3ibSGcWj9p10A0P+x8fHFJDBqy0Fx4h6yWU2rLpJEUys
         wWUS4HEhwvJvgP9aC/MQDMtjDvjCMIt8dyvy7Nfsj3rugL9C67lW4x3B0CrsIGJs1qYR
         7fXprforiDRp3qzjSeHW/kF4dGi3yhhoQAIPgn/5qYPMTIibfmFH6iFlPp7VtYZWaGHq
         Bhtg==
X-Gm-Message-State: AOAM533c0OLQh9owBYoMBDh49sKIckTlpcxpqbMqId9IU1XyfQdbOZP1
        F523Ifq8d0x1XtbgKi3fndZMNU/CnBQ9RZPGlTy6jz5c8ZS8AF8oKkFO8f5Wde9HzzFGFDCUOEQ
        15gr91APYf5hpWdKz2JG5u9SRC4Qf7TVB8PgGel5HSL8=
X-Received: by 2002:a17:906:9bc5:: with SMTP id de5mr9107548ejc.284.1616234605198;
        Sat, 20 Mar 2021 03:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMnEtYNqzI5L7gpZLlQlj1az6CLbmQYLoAqJ72bRRK64C3vgPnc7jNhufbCQEfX8lOBrCj7A==
X-Received: by 2002:a17:906:9bc5:: with SMTP id de5mr9107519ejc.284.1616234604964;
        Sat, 20 Mar 2021 03:03:24 -0700 (PDT)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id p3sm5027921ejd.7.2021.03.20.03.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 03:03:24 -0700 (PDT)
Date:   Sat, 20 Mar 2021 11:03:22 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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
Message-ID: <20210320100322.ox5gzgauo7iqf2fv@gmail.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
 <20210319195547.427371-2-vgoyal@redhat.com>
 <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:42:48PM +0100, Andreas Grünbacher wrote:
> Hi,
> 
> Am Fr., 19. März 2021 um 20:58 Uhr schrieb Vivek Goyal <vgoyal@redhat.com>:
> > posix_acl_update_mode() determines what's the equivalent mode and if SGID
> > needs to be cleared or not. I need to make use of this code in fuse
> > as well. Fuse will send this information to virtiofs file server and
> > file server will take care of clearing SGID if it needs to be done.
> >
> > Hence move this code in a separate helper so that more than one place
> > can call into it.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andreas Gruenbacher <agruenba@redhat.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/posix_acl.c            |  3 +--
> >  include/linux/posix_acl.h | 11 +++++++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index f3309a7edb49..2d62494c4a5b 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_userns,
> >                 return error;
> >         if (error == 0)
> >                 *acl = NULL;
> > -       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > -           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > +       if (posix_acl_mode_clear_sgid(mnt_userns, inode))
> >                 mode &= ~S_ISGID;
> >         *mode_p = mode;
> >         return 0;
> > diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> > index 307094ebb88c..073c5e546de3 100644
> > --- a/include/linux/posix_acl.h
> > +++ b/include/linux/posix_acl.h
> > @@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
> >  }
> >
> >
> > +static inline bool
> > +posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
> > +                         struct inode *inode)
> > +{
> > +       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> > +           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > +               return true;
> > +
> > +       return false;
> 
> That's just
> 
> return !in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
>     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID);
> 
> The same pattern we have in posix_acl_update_mode also exists in
> setattr_copy and inode_init_owner, and almost the same pattern exists
> in setattr_prepare, so can this be cleaned up as well? The function
> also isn't POSIX ACL specific, so the function name is misleading.

Good idea but that should probably be spun into a separate patchset that
only touches the vfs parts.

Christian
