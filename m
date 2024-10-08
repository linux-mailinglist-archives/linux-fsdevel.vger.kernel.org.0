Return-Path: <linux-fsdevel+bounces-31367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8656099587D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49187285047
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA0215019;
	Tue,  8 Oct 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKkILa3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE121E104B;
	Tue,  8 Oct 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419508; cv=none; b=mEOI2AXcjLrtHpRFirYH6kHQ/kypczHc+8PNPpCwXjg/1wvPvX6OunXugFz86h/BsC9i0hF/cHy1IGCgJ4mK6loeKB3RIvYDOgDAULTk0sDOZtuI/y33NPYnQHaNLSD5BaDHzYRLXzUTf1gzCEkL2obSzrqiYxKmUrO8e/cVn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419508; c=relaxed/simple;
	bh=itTu5nGnYHokIYet1xEeFVWP0f4i+WN9ppsfs6Is1ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Ynn/63YNLzuycmmjSmsmr9OGGUjV/JL/dHkDOvWhr3BJNrekY6E4KQLkCsb8u2L3wH/BjA2nNYjbBum1sEVAybs+BftSNPFGfZcQGlAOkE+OFIlS3jhvSFleBIF5DZQltEPWgzD096KUbHtO0YskHjTOMSk9CuFyWduZl5wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKkILa3m; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7afc67e9447so16929185a.1;
        Tue, 08 Oct 2024 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728419505; x=1729024305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz7Hp0fm0hCFBnjhlisUYY5V0Q0cWwyJgq+VR0R10HU=;
        b=OKkILa3m6X3M/rAGm2DKdLR9CMEYKDZIATnqEZgU0Cwz7KFYM+NJs3XHdmPyRAzcwx
         vzBwrk3VA/cFfrJ2PQPRSheTrwvlGKtXKbcoDj50bsPKisa3ekZqaiTakVyzBgmA4Ekv
         eZuqRn4xR7gWd6+cLkVVjS+iy/b5IRG3MQqra727DRpqvacU8YHB7mNeXJ4ZGMGcHhcf
         F2Tf2uB1KGaOJt75Ws/XMudhsBaaBFFOOkW9J31SkpsMCVQNxVqdGyja764l+XJeYt+z
         OlydDm3chK100nXMk/ELVUHIRaxe28d7Baqc+NXBattbUmX1iqp8aQeQbUmjUmbcwjMv
         gxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419505; x=1729024305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz7Hp0fm0hCFBnjhlisUYY5V0Q0cWwyJgq+VR0R10HU=;
        b=ZKohVY5LQBmeG27jzg6lmLR+9fRDoxbujCzFr3P41guFx5+szioUPpr66eWa1xHHQw
         H6TkmcJvBOm0B/1lKu9ZTQfB9CSs0x4ssDtTQe0AexCD/9vOeDs1zMEWZzpT16rZ+TmX
         JcsGeKKlnVMn0xHEwsz6dbG+Yfm1kHdjbHVL5L44Da93WZSppBked8BYpUmPa9mQGexc
         GDRPgoY4iQlR/WVQxPSZ6Nn0GjouOz/96qF2Mhj/nZGDcreuY3rjJ3Hk3L0QaW3azlrT
         3FQqGltRnfo4jCRW5AAzcCCf2V1JScb2Z3+nQ9wBC8xOqQMTt90ltiqvP83EX3/QM3Oz
         XfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYfwEQds2yAo+fk8ZA7kI2+AnXsCleKqjRuQZaPCdcKu79PxZ66vcPlVTnFoM6QCz3fYcMtubTcU/G@vger.kernel.org, AJvYcCXUalAVEySgDVYbVLfN/sMAn6ZoLZn/A74rScLHsUAKwDdMYoUFvpHitCI9C2OpyvbddaNYptfer4aNFuoV@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBsRaJo24nypjsF1zbXysx5HjRS9gIke6caP8RhNeMST0K+Jr
	i9H6Vj3C2rezepPZq7ZSlyB0ekcWMRS6BPCxMm3mDGJL8OOgW9nWRT9hvIeA+ahg5Got+jJrKHI
	HEnh4J2BD676FpbruLVEppWzrh38=
X-Google-Smtp-Source: AGHT+IG8Oo0yjSX4QxYUj/WXAq2/K4FWF08TPv1AoP4ytyNDqpDFU550LIBLT7aIMOhObvsiBEMMDHvKbDxq9PU32y4=
X-Received: by 2002:a05:620a:1710:b0:7a9:bf31:dbba with SMTP id
 af79cd13be357-7affaf940c1mr56237285a.7.1728419505215; Tue, 08 Oct 2024
 13:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008152118.453724-1-amir73il@gmail.com> <20241008152118.453724-2-amir73il@gmail.com>
 <b2df96ad86950b4b3a790f68be99df845a6a2108.camel@kernel.org>
In-Reply-To: <b2df96ad86950b4b3a790f68be99df845a6a2108.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 22:31:33 +0200
Message-ID: <CAOQ4uxj-=9-23HNsc8r8ciJttBN-2zzWAx3X_S7xB1cxY20gFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: prepare for "explicit connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:19=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> > We would like to use the high 16bit of the handle_type field to encode
> > file handle traits, such as "connectable".
> >
> > In preparation for this change, make sure that filesystems do not retur=
n
> > a handle_type value with upper bits set and that the open_by_handle_at(=
2)
> > syscall rejects these handle types.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/exportfs/expfs.c      | 14 ++++++++++++--
> >  fs/fhandle.c             |  6 ++++++
> >  include/linux/exportfs.h | 14 ++++++++++++++
> >  3 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 4f2dd4ab4486..c8eb660fdde4 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -382,14 +382,21 @@ int exportfs_encode_inode_fh(struct inode *inode,=
 struct fid *fid,
> >                            int *max_len, struct inode *parent, int flag=
s)
> >  {
> >       const struct export_operations *nop =3D inode->i_sb->s_export_op;
> > +     enum fid_type type;
> >
> >       if (!exportfs_can_encode_fh(nop, flags))
> >               return -EOPNOTSUPP;
> >
> >       if (!nop && (flags & EXPORT_FH_FID))
> > -             return exportfs_encode_ino64_fid(inode, fid, max_len);
> > +             type =3D exportfs_encode_ino64_fid(inode, fid, max_len);
> > +     else
> > +             type =3D nop->encode_fh(inode, fid->raw, max_len, parent)=
;
> > +
> > +     if (WARN_ON_ONCE(FILEID_USER_FLAGS(type)))
> > +             return -EINVAL;
> > +
>
> The stack trace won't be very useful here. Rather than a WARN, it might
> be better to dump out some info about the fstype (and maybe other
> info?) that returned the bogus type value here. I'm pretty sure most
> in-kernel fs's don't do this, but who knows what 3rd party fs's might
> do.
>

Right. I changed to:

        if (FILEID_USER_FLAGS(type)) {
                pr_warn_once("%s: unexpected fh type value 0x%x from
fstype %s.\n",
                             __func__, type, inode->i_sb->s_type->name);
                return -EINVAL;
        }


> > +     return type;
> >
> > -     return nop->encode_fh(inode, fid->raw, max_len, parent);
> >  }
> >  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
> >
> > @@ -436,6 +443,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct=
 fid *fid, int fh_len,
> >       char nbuf[NAME_MAX+1];
> >       int err;
> >
> > +     if (WARN_ON_ONCE(FILEID_USER_FLAGS(fileid_type)))
> > +             return -EINVAL;
> > +
>
>
> This is called from do_handle_to_path() or nfsd_set_fh_dentry(), which
> means that this fh comes from userland or from an NFS client. I don't
> think we want to WARN because someone crafted a bogus fh and passed it
> to us.
>

Good point, I will remove the WARN and also fix the bug :-/

        if (FILEID_USER_FLAGS(fileid_type))
                return ERR_PTR(-EINVAL);

Pushed this and othe minor fixes to
https://github.com/amir73il/linux/commits/connectable-fh/
until we sort out the rest of your comments and maybe get more feedback.

Thanks for the review!
Amir.

