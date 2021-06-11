Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5190F3A4449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFKOqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFKOqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:46:36 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CFC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 07:44:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id y207so3877800vsy.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PvXVENs4UcLiDY3320dR9DN7zBQ45xeDN/rAyFn8JA=;
        b=i5LVNB0DwhGf2ES3OdhAjX+n64FoNUud/WLuGEq8qE8Er+PbPUy9mhs1J9pD0lWRI7
         pEC1Zhm5NVv66PV5FNWT3WSIHOFieg2/cIAzBiqqm/NQDhdXEU816QuGBapZyfrO8u+W
         KC213z6/e2h7YA2fB/mlJbqtbkW4l3Ei3FMbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PvXVENs4UcLiDY3320dR9DN7zBQ45xeDN/rAyFn8JA=;
        b=nGHRTlL3ULldO+MXXRMx65fBGJO3WgGrlIz7kivGhdcpw+4j6s78r07sqx92TtBV7Y
         mkPkw1piYaLhx3LaAe+sYzEtrFN+c/tWrrp7agZNgRzHFoqZp5T6NgeXOK97YdXAknZI
         577Mpvfi9dL83YbRlx1Q9vnTAydAjJaqlHd0NB6n6ksymYVcHW0Qvj5WaLzoP6izg05C
         z3gN1yOtqZ5Q9WixvFyaXIBfs/9uYmDWnJzdvORh/8zHmYvPfkGlhGU7vzQi5Um9V+Zx
         NH8lfOGkWSdsOf6EwBqpWfxyKAw45Py0j8zjnd5yA/Ph+l/xrsn37B+BaIvyqgkd0T1c
         1slQ==
X-Gm-Message-State: AOAM5300CMFxxkrm8V81s4RtdKIjyv8Lt4NisZQsL7OXfRuUbLL/Zn9e
        d2r1imBw9FJrhFBgaIqVSgLxkPt6AIV90m9z15dFyQ==
X-Google-Smtp-Source: ABdhPJxpw1yGLViH5uP4+1r0GCK+sji66nQF20epPTph2zduLFfY6TO0ArXupmFGS9kkFvhdypNtZ62szadvE1aODo0=
X-Received: by 2002:a05:6102:2144:: with SMTP id h4mr9505890vsg.21.1623422677896;
 Fri, 11 Jun 2021 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210604161156.408496-1-groug@kaod.org> <20210604161156.408496-7-groug@kaod.org>
 <0d3b4dfb-2474-2200-80d1-39dcbf8f626e@redhat.com> <20210609094547.222fc420@bahia.lan>
In-Reply-To: <20210609094547.222fc420@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 16:44:27 +0200
Message-ID: <CAJfpegsWL30hfduM1HLwgeruKUJ=rdUgG=wNdFHV9m4entPw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] fuse: Switch to fc_mount() for submounts
To:     Greg Kurz <groug@kaod.org>
Cc:     Max Reitz <mreitz@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 09:45, Greg Kurz <groug@kaod.org> wrote:
>
> On Tue, 8 Jun 2021 17:51:03 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>
> > On 04.06.21 18:11, Greg Kurz wrote:
> > > fc_mount() already handles the vfs_get_tree(), sb->s_umount
> > > unlocking and vfs_create_mount() sequence. Using it greatly
> > > simplifies fuse_dentry_automount().
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >   fs/fuse/dir.c | 26 +++++---------------------
> > >   1 file changed, 5 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index b88e5785a3dd..fc9eddf7f9b2 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -311,38 +311,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
> > >     struct fs_context *fsc;
> > >     struct vfsmount *mnt;
> > >     struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
> > > -   int err;
> > >
> > >     fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
> > > -   if (IS_ERR(fsc)) {
> > > -           err = PTR_ERR(fsc);
> > > -           goto out;
> > > -   }
> > > +   if (IS_ERR(fsc))
> > > +           return (struct vfsmount *) fsc;
> >
> > I think ERR_CAST(fsc) would be nicer.
> >
>
> Indeed. I'll fix that if I need to repost.

Fixed.

Thanks,
Miklos
