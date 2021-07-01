Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AA3B95EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhGASJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhGASJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:09:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F3C061762;
        Thu,  1 Jul 2021 11:07:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gn32so11923757ejc.2;
        Thu, 01 Jul 2021 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZWIvsjsNSolG62fsKgZqJ80YeCW0H+lL6vnrEt4gj8k=;
        b=T6DQKC4UrMyYR2tY0wIdQotT9TY8dqVTjmTxXLouh9MivWlP6P4JlAue38ZFAaalJ9
         P6uwp9UUd2pTt/STO/iUgNExGgsKhD27PNeae8hHkTSImDHCVhya7JfYolHQoawPwzXp
         tcfB3pcAJCiMTpn+nzD6sIblDN1oZTehKa1M1Q0MtASUSXQEKTxSuiQ1y7XDw+Sjh2za
         7edzW/wCAeC0T7UZqveaE3012TFYK6WjPa6hTpHaRoMXpoOWwEaYwT6Johj7cRfMB/yd
         H4eOYsM6m9uecbB6LfBmY2lj7Z9Rgt5Km/9eKw/QL2XHDtBotedaDlz553rkd1Q6DmsC
         b7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZWIvsjsNSolG62fsKgZqJ80YeCW0H+lL6vnrEt4gj8k=;
        b=p+uuMmjGiDcHqh3/LKFPRZIWzWEEXDRyfSRTKDacvrCku++DKAocF5ZNIsKZCoJ/P8
         9uOeqsyrysW9cGs01E+455+ESa3e3G84drYqzKaowQM3iEM0fp2abdlefotSHMyivshi
         5UOtfbhqDlxg3jRDdgAx//qAd8Pbz0y4GoZus/Z7vfeCVgDuUc4OxsU9L9zz3UmP5Ydb
         yAZZktThyphyrB4iUIhMlYtW5NwpQU2hUbM+ksnFzmaF3uHhvSSNgyBssbmXuY2UYnd4
         WJuChYr6FBtHCrcYCLSfY7ejwFmFosJePTEYd89G0+S/rrdEDMzEiEL5wP3unbBvhiUy
         L+ZA==
X-Gm-Message-State: AOAM533QNN2Ji/vZqdpVIZX8eOos6nMwW09EirJlpc3+g+eRmE7BvUcC
        mE2aOKY11TzPCXi6pfE+Il5YTF3njKfr4bvQ03I=
X-Google-Smtp-Source: ABdhPJwkVzrwI1DtRUXnrViaCWhKXJoGZ9BasJqkhdQKP/+OWqbZtL2iwmnSNeYgIj9XGbcA9gCjpxuJV5t0vSU9qWE=
X-Received: by 2002:a17:906:e256:: with SMTP id gq22mr1263021ejb.248.1625162825323;
 Thu, 01 Jul 2021 11:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210630161320.29006-1-lhenriques@suse.de> <CAN-5tyGXZWQgdaWG5GWJn1mZhA23PR-KEv1-EW=tGRJLL4PUWA@mail.gmail.com>
 <YN2FhweR8MXABae5@suse.de>
In-Reply-To: <YN2FhweR8MXABae5@suse.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 1 Jul 2021 14:06:53 -0400
Message-ID: <CAN-5tyGO1-21HTU4TjXiE9dF3rD_vVt9owd0-8y=S8HeMuf9mA@mail.gmail.com>
Subject: Re: [PATCH v11] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Petr Vorel <pvorel@suse.cz>, Steve French <sfrench@samba.org>,
        kernel test robot <oliver.sang@intel.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 1, 2021 at 5:06 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> On Wed, Jun 30, 2021 at 05:06:49PM -0400, Olga Kornievskaia wrote:
> > adding linux-nfs to the recipients as well (seems to have been dropped)
> >
> > On Wed, Jun 30, 2021 at 12:22 PM Luis Henriques <lhenriques@suse.de> wr=
ote:
> > >
> > > A regression has been reported by Nicolas Boichat, found while using =
the
> > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") th=
e
> > > kernel would return -EXDEV to userspace when trying to copy a file ac=
ross
> > > different filesystems.  After this commit, the syscall doesn't fail a=
nymore
> > > and instead returns zero (zero bytes copied), as this file's content =
is
> > > generated on-the-fly and thus reports a size of zero.
> > >
> > > This patch restores some cross-filesystem copy restrictions that exis=
ted
> > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy acr=
oss
> > > devices").  Filesystems are still allowed to fall-back to the VFS
> > > generic_copy_file_range() implementation, but that has now to be done
> > > explicitly.
> > >
> > > nfsd is also modified to fall-back into generic_copy_file_range() in =
case
> > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > >
> > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devic=
es")
> > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-=
drinkcat@chromium.org/
> > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+=
BnvW=3DZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cd=
c3ff707bc1efa17f5366057d60603c45f@changeid/
> > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > ---
> > > Changes since v10
> > > - simply remove the "if (len =3D=3D 0)" short-circuit instead of chec=
king if
> > >   the filesystem implements the syscall.  This is because a filesyste=
m may
> > >   implement it but a particular instance (hint: overlayfs!) may not.
> > > Changes since v9
> > > - the early return from the syscall when len is zero now checks if th=
e
> > >   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
> > >   otherwise.  Issue reported by test robot.
> > >   (obviously, dropped Amir's Reviewed-by and Olga's Tested-by tags)
> > > Changes since v8
> > > - Simply added Amir's Reviewed-by and Olga's Tested-by
> > > Changes since v7
> > > - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that =
the
> > >   error returned is always related to the 'copy' operation
> > > Changes since v6
> > > - restored i_sb checks for the clone operation
> > > Changes since v5
> > > - check if ->copy_file_range is NULL before calling it
> > > Changes since v4
> > > - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOP=
NOTSUPP
> > >   or -EXDEV.
> > > Changes since v3
> > > - dropped the COPY_FILE_SPLICE flag
> > > - kept the f_op's checks early in generic_copy_file_checks, implement=
ing
> > >   Amir's suggestions
> > > - modified nfsd to use generic_copy_file_range()
> > > Changes since v2
> > > - do all the required checks earlier, in generic_copy_file_checks(),
> > >   adding new checks for ->remap_file_range
> > > - new COPY_FILE_SPLICE flag
> > > - don't remove filesystem's fallback to generic_copy_file_range()
> > > - updated commit changelog (and subject)
> > > Changes since v1 (after Amir review)
> > > - restored do_copy_file_range() helper
> > > - return -EOPNOTSUPP if fs doesn't implement CFR
> > > - updated commit description
> > >
> > >  fs/nfsd/vfs.c   |  8 +++++++-
> > >  fs/read_write.c | 52 +++++++++++++++++++++++------------------------=
--
> > >  2 files changed, 31 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 15adf1f6ab21..f54a88b3b4a2 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -569,6 +569,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *n=
f_src, u64 src_pos,
> > >  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct f=
ile *dst,
> > >                              u64 dst_pos, u64 count)
> > >  {
> > > +       ssize_t ret;
> > >
> > >         /*
> > >          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> > > @@ -579,7 +580,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u=
64 src_pos, struct file *dst,
> > >          * limit like this and pipeline multiple COPY requests.
> > >          */
> > >         count =3D min_t(u64, count, 1 << 22);
> > > -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count,=
 0);
> > > +       ret =3D vfs_copy_file_range(src, src_pos, dst, dst_pos, count=
, 0);
> > > +
> > > +       if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
> > > +               ret =3D generic_copy_file_range(src, src_pos, dst, ds=
t_pos,
> > > +                                             count, 0);
> > > +       return ret;
> > >  }
> > >
> > >  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index 9db7adf160d2..049a2dda29f7 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1395,28 +1395,6 @@ ssize_t generic_copy_file_range(struct file *f=
ile_in, loff_t pos_in,
> > >  }
> > >  EXPORT_SYMBOL(generic_copy_file_range);
> > >
> > > -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_i=
n,
> > > -                                 struct file *file_out, loff_t pos_o=
ut,
> > > -                                 size_t len, unsigned int flags)
> > > -{
> > > -       /*
> > > -        * Although we now allow filesystems to handle cross sb copy,=
 passing
> > > -        * a file of the wrong filesystem type to filesystem driver c=
an result
> > > -        * in an attempt to dereference the wrong type of ->private_d=
ata, so
> > > -        * avoid doing that until we really have a good reason.  NFS =
defines
> > > -        * several different file_system_type structures, but they al=
l end up
> > > -        * using the same ->copy_file_range() function pointer.
> > > -        */
> > > -       if (file_out->f_op->copy_file_range &&
> > > -           file_out->f_op->copy_file_range =3D=3D file_in->f_op->cop=
y_file_range)
> > > -               return file_out->f_op->copy_file_range(file_in, pos_i=
n,
> > > -                                                      file_out, pos_=
out,
> > > -                                                      len, flags);
> > > -
> > > -       return generic_copy_file_range(file_in, pos_in, file_out, pos=
_out, len,
> > > -                                      flags);
> > > -}
> > > -
> > >  /*
> > >   * Performs necessary checks before doing a file copy
> > >   *
> > > @@ -1434,6 +1412,25 @@ static int generic_copy_file_checks(struct fil=
e *file_in, loff_t pos_in,
> > >         loff_t size_in;
> > >         int ret;
> > >
> > > +       /*
> > > +        * Although we now allow filesystems to handle cross sb copy,=
 passing
> > > +        * a file of the wrong filesystem type to filesystem driver c=
an result
> > > +        * in an attempt to dereference the wrong type of ->private_d=
ata, so
> > > +        * avoid doing that until we really have a good reason.  NFS =
defines
> > > +        * several different file_system_type structures, but they al=
l end up
> > > +        * using the same ->copy_file_range() function pointer.
> > > +        */
> > > +       if (file_out->f_op->copy_file_range) {
> > > +               if (file_in->f_op->copy_file_range !=3D
> > > +                   file_out->f_op->copy_file_range)
> > > +                       return -EXDEV;
> > > +       } else if (file_in->f_op->remap_file_range) {
> > > +               if (file_inode(file_in)->i_sb !=3D file_inode(file_ou=
t)->i_sb)
> > > +                       return -EXDEV;
> > > +       } else {
> > > +                return -EOPNOTSUPP;
> > > +       }
> > > +
> > >         ret =3D generic_file_rw_checks(file_in, file_out);
> > >         if (ret)
> > >                 return ret;
> > > @@ -1497,11 +1494,9 @@ ssize_t vfs_copy_file_range(struct file *file_=
in, loff_t pos_in,
> > >         if (unlikely(ret))
> > >                 return ret;
> > >
> > > -       if (len =3D=3D 0)
> > > -               return 0;
> >
> > Can somebody please explain this change to me? Is this an attempt to
> > support "whole" file copy?
>
> No, this was a bug reported in this thread:
>
> https://lore.kernel.org/linux-fsdevel/877dk1zibo.fsf@suse.de/
>
> (I'm also adding back Steve to the Cc: list.)

Ok so this is a problem. As I mentioned a zero size copy means in NFS
copy the whole file.  Current copy_file_range system doesn't have the
same semantics. I don't expect the same semantics exist in other file
systems but, if they do, then perhaps semantics of copy_file_range can
be changed to reflect that. If not, then I would like to put back the
return 0 if len=3D0 somehow or you need to put it explicitly in all file
systems (or at least in NFS).

>
> Cheers,
> --
> Lu=C3=ADs
>
> > I believe previously file systems relied
> > on the fact that they don't need to handle 0 size copy_file_range size
> > call. If this is being changed why not individual implementors (nfs,
> > etc) were modified to keep the same behavior? I mean is CIFS ok with
> > getting count=3D0 copy_file_range request?
> >
> > In the NFS spec of COPY (copy_file_range), length of 0 means (or could
> > mean) "whole file" copy. While the linux NFS server did put in support
> > for doing "whole file" copy, it's not present before 5.13 in the linux
> > server. It makes it now confusing that a copy of length 0 previously
> > would return 0 and now it could copy whole file.
> > > -
> > >         file_start_write(file_out);
> > >
> > > +       ret =3D -EOPNOTSUPP;
> > >         /*
> > >          * Try cloning first, this is supported by more file systems,=
 and
> > >          * more efficient if both clone and copy are supported (e.g. =
NFS).
> > > @@ -1520,9 +1515,10 @@ ssize_t vfs_copy_file_range(struct file *file_=
in, loff_t pos_in,
> > >                 }
> > >         }
> > >
> > > -       ret =3D do_copy_file_range(file_in, pos_in, file_out, pos_out=
, len,
> > > -                               flags);
> > > -       WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP);
> > > +       if (file_out->f_op->copy_file_range)
> > > +               ret =3D file_out->f_op->copy_file_range(file_in, pos_=
in,
> > > +                                                     file_out, pos_o=
ut,
> > > +                                                     len, flags);
> > >  done:
> > >         if (ret > 0) {
> > >                 fsnotify_access(file_in);
