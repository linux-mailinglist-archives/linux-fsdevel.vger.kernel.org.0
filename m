Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128113428CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 23:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSWnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSWnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD6C061760;
        Fri, 19 Mar 2021 15:43:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 16so13792093ljc.11;
        Fri, 19 Mar 2021 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2Te/S8IQN8II87+ruJB6/OZWiTMllLjsdgUQ032A7E=;
        b=iYXj549E1TSXlKplraY6a7uriF3jJn340mEeSfahFmXK2DIwCKLLNAgXEBIiSVkdAl
         zB0tQV4s8N4o/AQJLXCbZSjZlbCWI64Ak2QzRXZVLmNg4VduOFCvh0BfANlonz1raaY6
         y5xo+5mFR0uc5XlfHV5+e06GJuIH997vcwgFkEwgbxylsITLzkRno8RBXinuQK2tYlAT
         wbf5oWuKuC41lkBgWlC4M6MKH5BqzSp+DpGP2oaWVdlEP0iu2cfYi0jeguz5dLYrs1Hy
         Cv7fr6DfrlDDqyRbV/UXRvdSR0uPU6WY2SeldO6kkgTtaDaXi6+gpCX2X/c/FvDL2bjl
         liaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2Te/S8IQN8II87+ruJB6/OZWiTMllLjsdgUQ032A7E=;
        b=tNjQN35TBiejgPWe21wYCjWriG0G1zfrIvMMcV6EKdTYz2Pd2dij+TUobcIjwRP5CC
         FUfXst8Vy9M+wLr1RWweaBqnPFGtihpJsyvRtzUbEH1OSfP+lW1eaxrcoLmhXztWr5ZI
         G7JFNYcnhdBMBVN5xR2UfShaclQz1nM7TZ2Lx+W6joWGnBE+a9Jd8LOvRHJdfpcnbNTC
         j2qDa3Wn3HD7yyVRGCq8dQcT5Y5JBoBTb6OyJ5jHOHIVDpAgYaLvsN9NAEUo95Nr8Iub
         BBe0ea3NKrg60BAFvyZJUbcHnkNaD8v7X6V7rPqwoPslDGgNnhjhh4z2+k6W54S+LONb
         B2RA==
X-Gm-Message-State: AOAM532OzTHY8kM6RHs57O5cRCCW+MteIeepd3Y0CiZaQi27w/afcLfz
        O1k+vsv6L1KZyXaaTQIiP1SOz249jQYsrLYpYiY=
X-Google-Smtp-Source: ABdhPJzTykB9ymD3JXav+qnnbIuhHI0y9S0Tfm6c9DRTtjszViqz9nlVNzh5sp+4p5+REYVAymKar/bVjzXtCUpFY1o=
X-Received: by 2002:a2e:8e37:: with SMTP id r23mr2247160ljk.269.1616193779968;
 Fri, 19 Mar 2021 15:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210319195547.427371-1-vgoyal@redhat.com> <20210319195547.427371-2-vgoyal@redhat.com>
In-Reply-To: <20210319195547.427371-2-vgoyal@redhat.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 19 Mar 2021 23:42:48 +0100
Message-ID: <CAHpGcMKhFxotKDxPryfKdhNMMDWO4Ws33s6fEm2NP0u_4vffnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] posic_acl: Add a helper determine if SGID should be cleared
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        lhenriques@suse.de, dgilbert@redhat.com,
        Seth Forshee <seth.forshee@canonical.com>,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Am Fr., 19. M=C3=A4rz 2021 um 20:58 Uhr schrieb Vivek Goyal <vgoyal@redhat.=
com>:
> posix_acl_update_mode() determines what's the equivalent mode and if SGID
> needs to be cleared or not. I need to make use of this code in fuse
> as well. Fuse will send this information to virtiofs file server and
> file server will take care of clearing SGID if it needs to be done.
>
> Hence move this code in a separate helper so that more than one place
> can call into it.
>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/posix_acl.c            |  3 +--
>  include/linux/posix_acl.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index f3309a7edb49..2d62494c4a5b 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_=
userns,
>                 return error;
>         if (error =3D=3D 0)
>                 *acl =3D NULL;
> -       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> -           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +       if (posix_acl_mode_clear_sgid(mnt_userns, inode))
>                 mode &=3D ~S_ISGID;
>         *mode_p =3D mode;
>         return 0;
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 307094ebb88c..073c5e546de3 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
>  }
>
>
> +static inline bool
> +posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
> +                         struct inode *inode)
> +{
> +       if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
> +           !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> +               return true;
> +
> +       return false;

That's just

return !in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID);

The same pattern we have in posix_acl_update_mode also exists in
setattr_copy and inode_init_owner, and almost the same pattern exists
in setattr_prepare, so can this be cleaned up as well? The function
also isn't POSIX ACL specific, so the function name is misleading.

> +}
> +
>  /* posix_acl.c */
>
>  extern void posix_acl_init(struct posix_acl *, int);
> --
> 2.25.4

Thanks,
Andreas
