Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A05BDF39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiITIF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiITIE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:04:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FD481CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:02:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hy2so474244ejc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L8aCBg7ijFOKf8iD02EF5tdyKFb8Ymh8u0B1y5Zoysg=;
        b=CJXp4JroV9pBbWkBf6/XuJfNysc40cQB3fWKIGqgiVA7hQcV8M0X7annxVyUDBLXMA
         mru7GsVrSpTsNlLRDSLPcItx9D/0FzrUWeoAIeB9vCp59J8U5UZUJakSIiI46zhi2iQX
         JCaaBZn9KzEVrpWPSL9itJkhIDDOVM+B44Y8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L8aCBg7ijFOKf8iD02EF5tdyKFb8Ymh8u0B1y5Zoysg=;
        b=3hTemY83tjR/AEd58frHvW4OUpV8byBIcOA6sXRh58Scr2Sc5foE14mjveWe7GlVLo
         U2ZO3Rq+2E3IWVPTaiSdax7mcujChnYlPcVby+ycgoiOqXdR0/+vP4adEF5iUcIn2Zsx
         Jfr5L2o3U5jXriy8Q4vXC+g30wIQ92sfXSWDzMTIL5Drf1Hq1P9H9dCd5uKclEo4dZga
         BN9BLZyrUlBVGYJu5qQVtFSB5VvUFu7ym9j2CTppwEHiLpgf+6Sgzj+cJkUUVS+Ljt+6
         AlCvEMNfULvoCc7v4VjVtsPD/5mTlaqe+D5bT6ZnZVsZSoT7QcNcMzpYuYY6yS7sADWp
         EYBQ==
X-Gm-Message-State: ACrzQf2Ls0c7cDlGA+NqfJLjS+CKHtDlAs+DE0CMuyyJo9MVLizaeEdb
        3/nMQYd0Jnw4DkB8v1GuFBh0hli3vn2KmC30qDAvNToT3W4=
X-Google-Smtp-Source: AMsMyM7l5zIz0NmZj6EPtW7tUVakuqc+ClJrfVTFf5aUISiTdFsb42slTARfM3ihjWBTHFpFG+mWz15Hu/EewFS88BI=
X-Received: by 2002:a17:907:97c2:b0:780:6a13:53 with SMTP id
 js2-20020a17090797c200b007806a130053mr15959823ejc.187.1663660963215; Tue, 20
 Sep 2022 01:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220919141031.1834447-1-mszeredi@redhat.com> <20220919141031.1834447-5-mszeredi@redhat.com>
 <YykYWVpNvNm8BzWv@ZenIV>
In-Reply-To: <YykYWVpNvNm8BzWv@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Sep 2022 10:02:32 +0200
Message-ID: <CAJfpegtD32rPXYwKVC77qmgd3QFt5P3cTKRhT5pMBoFvAoO=sA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] ovl: use tmpfile_open() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Sept 2022 at 03:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 19, 2022 at 04:10:27PM +0200, Miklos Szeredi wrote:
> > If tmpfile is used for copy up, then use this helper to create the tmpfile
> > and open it at the same time.  This will later allow filesystems such as
> > fuse to do this operation atomically.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/copy_up.c   | 49 ++++++++++++++++++++++------------------
> >  fs/overlayfs/overlayfs.h | 12 ++++++----
> >  fs/overlayfs/super.c     | 10 ++++----
> >  3 files changed, 40 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index fdde6c56cc3d..ac087b48b5da 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -194,16 +194,16 @@ static int ovl_copy_fileattr(struct inode *inode, struct path *old,
> >  }
> >
> >  static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
> > -                         struct path *new, loff_t len)
> > +                         struct path *new, struct file *new_file, loff_t len)
> >  {
>
> Ugh...  Lift opening into both callers and get rid of struct path *new,
> please.  Would be much easier to follow that way...
>
> > -     err = ovl_copy_up_inode(c, temp);
> > +     err = ovl_copy_up_inode(c, temp, NULL);
>
> FWIW, I would consider passing a struct file * in all cases, with O_PATH
> for non-regular ones...

OK.

>
> > -     temp = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
> > -     ofs->tmpfile = !IS_ERR(temp);
> > +     tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
> > +     ofs->tmpfile = !IS_ERR(tmpfile);
> >       if (ofs->tmpfile)
> > -             dput(temp);
> > +             fput(tmpfile);
>
>         Careful - that part essentially checks if we have a working
> ->tmpfile(), but we rely upon more than just having it - we want
> dentry-based setxattr() and friends to work after O_TMPFILE.
> Are we making that a requirement for ->tmpfile()?

Yes, I think that should be expected of all sane filesystems.   Adding
tmpfile support to a fuse filesystem will require explicit code, so no
regression risk there.

Thanks,
Miklos
