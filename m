Return-Path: <linux-fsdevel+bounces-31535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2912998458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772641F2534B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC11C2430;
	Thu, 10 Oct 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ZNswEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B01BFE1A;
	Thu, 10 Oct 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558108; cv=none; b=bOeHyStljiSV6+sfpl30UNufE24Rnz4mnB5N/BWT2dhheBq5RSHWMpeJX2HkAx41sF+4gX7yEnRWTUiu80bZNiVwkPARWk1Te2vuPsJaeubvh5/QN0NGpq2AD4dJUOjzREMWVIlu7FkB9onCqs3gzSYN38Xdg/nzKYLVpkQgDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558108; c=relaxed/simple;
	bh=AMNfM9ovhdNcTYAifGKvWnq6AepmFJgspZNJ5kjbraM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQrLj+mAPtP9WMf2dfQ5xL5+A+draD1GSnH5i6pLfgyfF5mmTPNkWillINNryYSsEXEMZJsULuh1zzR49blzKpuijSW2oZrIZzGm28wX5kDLyfioJUZwb6q1HeXBnK7wEovAR8epJ7csivBAtHW3Bi1XNbuptwV520wn+deqFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/ZNswEa; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1141a3a2aso54021385a.2;
        Thu, 10 Oct 2024 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728558106; x=1729162906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVSLa2sj4pU6NU4WkrVpj8HemQ5H5usJ+c89vY3OGOg=;
        b=Y/ZNswEa7fOeBb2cH/6RS0X9O2eudpip3Ysfk0+wO45UvAZWTp3J6DUJsrlSdKtk7T
         lmmVZm+gZkaqo3Nk00bhOlqrqdR4YvePCNrtdUFPzKIAXYLRgK/h2lDgzUP4yVDXt0Lg
         +gdLvyBEUZlk4rMZWf6li4AAinKkUubuB+/zHFnZRR2iRAjtVSnxNbrSwDDJ0S0gMuaX
         zcLljeHEnvX038JkO/0g1BNsMX/t/qioubyblfjg9u1dY7MKDpfowvKf0iPfQ5+20LfQ
         dP74WqMA0giSgMFWh14r+RE+tZFsRqKyishNbmutwi/YtU823EDVmG557+H2jDvMUSCi
         2LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558106; x=1729162906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVSLa2sj4pU6NU4WkrVpj8HemQ5H5usJ+c89vY3OGOg=;
        b=Lme6sIKfbhvT0CWgaVYraAK3gGzS5HvEKlSf90sglukVPmBhztjqV96VG70IXayl6G
         R+ptXJNvkl/g34ZZ4bh3fcPE1T4XQNoKBwrOLobgq6VCfFDqW5ZhBKp8cNc++a8Ee+sx
         GCpdekEHzIk+etMtjAPeffFTN0j1LjWV+nSrq6cnwe3uYeaqXoaj1/E5ErZ8RgFjaEL6
         +y4FKyz0mprxSmuWVMKKwYvcb2PV413AslIqBCW5P9mLMeKN1vvySnArfSY++iUKk1Ax
         IT/RVRVf1O84+PaQFcvIv/bJOTgBeIloUGTmCPn4PDd6ysrezlo7/Qv4UWC4eUlZrtcf
         VTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLDQ2gDJUMOXkYJ0+KWU9x/fxPwoDUbDxSaEU2jv4aUcKjId5PBR52PvCPGfHhBA5xnfpsMQISQ9Ly@vger.kernel.org, AJvYcCX4Ub6x+J68REYIlF1kJwa64uDc6XHqqd53d1M7ztVfRB98CK/EqCgu4L5lAA9Knxd3Cz3J0X+TTUzzTsdj@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDM1NK2kcKP9jizqjYSpBlVX4FvpPmH8i8acc1EzLTXtCHLYo
	ZdtFmxqgyZL+NP8JF1/cCGEHrmaC0IapFMO6qRyitFmktQa+MnvjBWLYyLKWPRUloIJgyjwZJlm
	p6jVMb7iETSkJwzEQfP7C5csU5C4=
X-Google-Smtp-Source: AGHT+IGkEeOpwsAxtdsp4d19uGuY7iYLJS7gQTwH5SwNkfbOaNgLE41AfSQ2RU7DDSJjFX1BD7TzhZG1MzFgLeVlMY8=
X-Received: by 2002:a05:620a:4448:b0:7a9:bfcb:6d86 with SMTP id
 af79cd13be357-7b06f96a267mr923853785a.25.1728558105836; Thu, 10 Oct 2024
 04:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008152118.453724-1-amir73il@gmail.com> <20241008152118.453724-2-amir73il@gmail.com>
 <b2df96ad86950b4b3a790f68be99df845a6a2108.camel@kernel.org> <CAOQ4uxj-=9-23HNsc8r8ciJttBN-2zzWAx3X_S7xB1cxY20gFA@mail.gmail.com>
In-Reply-To: <CAOQ4uxj-=9-23HNsc8r8ciJttBN-2zzWAx3X_S7xB1cxY20gFA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Oct 2024 13:01:34 +0200
Message-ID: <CAOQ4uxj6wu4uodZCQghFEbx8UxvKrRYrt5n+oKeMp+qG6CMjPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: prepare for "explicit connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Oct 8, 2024 at 8:19=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> > > We would like to use the high 16bit of the handle_type field to encod=
e
> > > file handle traits, such as "connectable".
> > >
> > > In preparation for this change, make sure that filesystems do not ret=
urn
> > > a handle_type value with upper bits set and that the open_by_handle_a=
t(2)
> > > syscall rejects these handle types.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/exportfs/expfs.c      | 14 ++++++++++++--
> > >  fs/fhandle.c             |  6 ++++++
> > >  include/linux/exportfs.h | 14 ++++++++++++++
> > >  3 files changed, 32 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > > index 4f2dd4ab4486..c8eb660fdde4 100644
> > > --- a/fs/exportfs/expfs.c
> > > +++ b/fs/exportfs/expfs.c
> > > @@ -382,14 +382,21 @@ int exportfs_encode_inode_fh(struct inode *inod=
e, struct fid *fid,
> > >                            int *max_len, struct inode *parent, int fl=
ags)
> > >  {
> > >       const struct export_operations *nop =3D inode->i_sb->s_export_o=
p;
> > > +     enum fid_type type;
> > >
> > >       if (!exportfs_can_encode_fh(nop, flags))
> > >               return -EOPNOTSUPP;
> > >
> > >       if (!nop && (flags & EXPORT_FH_FID))
> > > -             return exportfs_encode_ino64_fid(inode, fid, max_len);
> > > +             type =3D exportfs_encode_ino64_fid(inode, fid, max_len)=
;
> > > +     else
> > > +             type =3D nop->encode_fh(inode, fid->raw, max_len, paren=
t);
> > > +
> > > +     if (WARN_ON_ONCE(FILEID_USER_FLAGS(type)))
> > > +             return -EINVAL;
> > > +
> >
> > The stack trace won't be very useful here. Rather than a WARN, it might
> > be better to dump out some info about the fstype (and maybe other
> > info?) that returned the bogus type value here. I'm pretty sure most
> > in-kernel fs's don't do this, but who knows what 3rd party fs's might
> > do.
> >
>
> Right. I changed to:
>
>         if (FILEID_USER_FLAGS(type)) {
>                 pr_warn_once("%s: unexpected fh type value 0x%x from
> fstype %s.\n",
>                              __func__, type, inode->i_sb->s_type->name);
>                 return -EINVAL;
>         }
>
>

FYI, following Jan's comment about mixing bitwise with negative values,
I changes this to:

        if (type > 0 && FILEID_USER_FLAGS(type)) {
                pr_warn_once("%s: unexpected fh type value 0x%x from
fstype %s.\n",
                             __func__, type, inode->i_sb->s_type->name);
                return -EINVAL;
        }

        return type;

because ->encode_fh() method are allowed to return a negative error
(e.g. -EOVERFLOW)

> > > +     return type;
> > >
> > > -     return nop->encode_fh(inode, fid->raw, max_len, parent);
> > >  }
> > >  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
> > >
> > > @@ -436,6 +443,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, stru=
ct fid *fid, int fh_len,
> > >       char nbuf[NAME_MAX+1];
> > >       int err;
> > >
> > > +     if (WARN_ON_ONCE(FILEID_USER_FLAGS(fileid_type)))
> > > +             return -EINVAL;
> > > +
> >
> >
> > This is called from do_handle_to_path() or nfsd_set_fh_dentry(), which
> > means that this fh comes from userland or from an NFS client. I don't
> > think we want to WARN because someone crafted a bogus fh and passed it
> > to us.
> >
>
> Good point, I will remove the WARN and also fix the bug :-/
>
>         if (FILEID_USER_FLAGS(fileid_type))
>                 return ERR_PTR(-EINVAL);
>

And changed this to:

@@ -436,6 +446,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt,
struct fid *fid, int fh_len,
        char nbuf[NAME_MAX+1];
        int err;

+       if (fileid_type < 0 || FILEID_USER_FLAGS(fileid_type))
+               return ERR_PTR(-EINVAL);
+

> Pushed this and othe minor fixes to
> https://github.com/amir73il/linux/commits/connectable-fh/
> until we sort out the rest of your comments and maybe get more feedback.
>

If no further comments I will post v4.

Thanks,
Amir.

