Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717522E537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfE2TYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:24:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41714 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2TYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:24:00 -0400
Received: by mail-yb1-f195.google.com with SMTP id d2so1213658ybh.8;
        Wed, 29 May 2019 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuDM8FzvWLq/3sIRx2I/nBmaXEAYcl3k6zr8OA+PA4Y=;
        b=mwpduTF3byaxqEeCOSCreMuPuJrkGWIKgXRJGLsuLpq6p0uNNZzzvccuynksvfadCH
         iSSfBrLe+JjgxxSxHkt9u3VBJz93VIQaQYyg9f4mnUPCv0Gl4IXuohqcllwnUIKcQIU2
         jFEIRImoGlNHqdywAs/f+I24o+aTTAWltjselmjHzTP63okjUhu7mE2Wxi8TByYWImrX
         xhtdY6AsJjqvJogj4BE5qMXUJB1+x1U3LX+mMdqmM4eo8ebFDk+wjMMnUnEXb5FVsatY
         DkLdj5OtlG2e+rfIkqB6TRrO4hDsShWoo+xXnWJm6yZzE/+AtPqYCmEd8WwUSOsoUYEC
         Akiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuDM8FzvWLq/3sIRx2I/nBmaXEAYcl3k6zr8OA+PA4Y=;
        b=T+Fwx6xscIEZWIEmNPxqYWlBnieTZlrhbZBuRYxO8BLQQ/XK69dUK9yBTt6grj9/Bh
         FPZnrCtRji3qgQVEf+RqozhKP9Xjay/+Mkf7f3XhjWVgcRj5CZF+UwdAyroeUDdhjc4u
         3z1qdQ7OlrkL32jnllMDrlUL+O4QRU2I/TSNtK74Tg/frVvnDdMuYOcFB/bLA7WJUTzu
         REHVeThN6CeWnipFAw+CNZg4VvQEI5srTri5B31xr0jKLuvQiaQRe2v4UayCG8Kz5IGa
         WnkT2mxZ/RDiP+9kpveYGqI6rQISXAW7TSSwk3NIGL43DkBrL+bUv7ARYcqNGBa7m1V7
         1Nvg==
X-Gm-Message-State: APjAAAWg+BKta0BIUeLpPJ26IFvBopbhKLkgPIa0vGeRJHeF1gMEF4Cu
        1gbWcDCHlDFbxIzW7GHc4JXEBr+TyHcQlDsRbQQ=
X-Google-Smtp-Source: APXvYqwmbjPAYBMUV6ZXS6Zlyu4v6xE1R/4OnEew72LwniatFovs101keHqMK+zPGDPNtTrfUOcKJkhupOSBCGLRPVc=
X-Received: by 2002:a25:c983:: with SMTP id z125mr59252647ybf.45.1559157838918;
 Wed, 29 May 2019 12:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-7-amir73il@gmail.com>
 <20190529182748.GF5231@magnolia> <CAOQ4uxgsMLTPtYaQwwNHo3NrzXz9u=YGc2v6Pg8TSo7-xFrqQQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgsMLTPtYaQwwNHo3NrzXz9u=YGc2v6Pg8TSo7-xFrqQQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:23:46 +0300
Message-ID: <CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] vfs: introduce file_modified() helper
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 10:08 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 9:27 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Wed, May 29, 2019 at 08:43:10PM +0300, Amir Goldstein wrote:
> > > The combination of file_remove_privs() and file_update_mtime() is
> > > quite common in filesystem ->write_iter() methods.
> > >
> > > Modelled after the helper file_accessed(), introduce file_modified()
> > > and use it from generic_remap_file_range_prep().
> > >
> > > Note that the order of calling file_remove_privs() before
> > > file_update_mtime() in the helper was matched to the more common order by
> > > filesystems and not the current order in generic_remap_file_range_prep().
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/inode.c         | 20 ++++++++++++++++++++
> > >  fs/read_write.c    | 21 +++------------------
> > >  include/linux/fs.h |  2 ++
> > >  3 files changed, 25 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index df6542ec3b88..2885f2f2c7a5 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1899,6 +1899,26 @@ int file_update_time(struct file *file)
> > >  }
> > >  EXPORT_SYMBOL(file_update_time);
> > >
> > > +/* Caller must hold the file's inode lock */
> > > +int file_modified(struct file *file)
> > > +{
> > > +     int err;
> > > +
> > > +     /*
> > > +      * Clear the security bits if the process is not being run by root.
> > > +      * This keeps people from modifying setuid and setgid binaries.
> > > +      */
> > > +     err = file_remove_privs(file);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     if (likely(file->f_mode & FMODE_NOCMTIME))
> >
> > I would not have thought NOCMTIME is likely?
> >
> > Maybe it is for io requests coming from overlayfs, but for regular uses
> > I don't think that's true.
>
> Nope that's a typo. Good spotting.
> Overlayfs doesn't set FMODE_NOCMTIME (yet). Only xfs does from
> XFS_IOC_OPEN_BY_HANDLE, but I think Dave said that is a deprecated
> API. so should have been very_unlikely().
>

Is that an ACK with likely converted to unlikely?

Thanks,
Amir.
