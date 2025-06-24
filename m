Return-Path: <linux-fsdevel+bounces-52781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9399AE6891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5917B1093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC92571A1;
	Tue, 24 Jun 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmV9fHfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E9291C09;
	Tue, 24 Jun 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774851; cv=none; b=nH27SBlUKWtkXhLQ0pPZWJdCs/HgPMnh9FgSq+ORq92BIFPN2+AnRJkS88NGl/+xSZyH/7p5eBht3i4pcc9k+UjLbKgyZnaB4lcltrHi1DQ69fdEPqi6xU17gHcRnQKBvHkWGPxyXXYJ4OKIKqDeULPLHNJPWAt2zGXfBMpOiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774851; c=relaxed/simple;
	bh=pTxD5BsYkDsJW8X8i4LtTxir/ws/ZMGlAJSMHfcUhBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJjoTzzGImzqufJ2c0bSoxr2RYhcvZKGr4+F69W2PJmbraj9llq3XK+elX7vpjekzjMOVxT6gUdQ/zKaufweZdxyegZw6zBvuuArHjh8iK0J+yXLjBjcR58/v4BCS+/BdHfT4lrFnjvdygX78DLHLoDas0sadsWQMwzRprx7XnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmV9fHfO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8507126a12.3;
        Tue, 24 Jun 2025 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750774848; x=1751379648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5HTTitgAHrzxvm3Nog1ktxSEZ4cOQiOsM/irXDycSQ=;
        b=GmV9fHfO3V9tStvfA3fvD50BWqIrBKIRHa2rXahzKBdAoEIbY5wCpxkguq3iidZazH
         0A+UrQrlipTcYovNwNsglq2JmSVun/W0mxBip4rZOTq/Ia2hmwt7nRRU8eI6qKPzlTdO
         YtABNV5m1rqhh3O9PcH0/dQwlstOq6zaUIT4BTPfj/GpDhj7xEdbRXwcyp+EeKTzOQJm
         nFiWB+mZZ2zcIHyQ+5B7Hn3lkdLsE4gCbNjbQb9eFmKfVvi/n/yoZVrrBfJ0N8WeprPR
         dSUFNhxIURMZTp0Rx6Zxy9GTUQA29eM8/iWC/2Wa5xutRsQ270jtpGQGJgZbcYuxzfST
         HLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774848; x=1751379648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5HTTitgAHrzxvm3Nog1ktxSEZ4cOQiOsM/irXDycSQ=;
        b=mTqaAdW0LNLrsup2CYUynCISR0vyUNEbaO7vrfIiR2Nt0VcoQ3jvLB3XXtVmS4lv3e
         JmGMh+hIoiVOL3a5wYDyHH9PSlWVbnzG/RvtswyutYseFQSN9IjWMdYEPyrFQU8iTQ4O
         DTaIlkUOxjzhkMYqV0AzXGD4WPO3rwy0QkTu9bLH5/IhS7aMqO15MDgDFVETVUc/T8WF
         oCifQeDEHy3kibO1zdPHLmUfN9C/Odv5gIqZmEfbECeOs8R4Wb0p9012zgvSD60iKVac
         Qbx6Kr0S1aHxuhQTypRQlQqv3JF8npGtxQhPymZmt/3i9yeXJsZzQ4PRC77lXHzMvfZx
         5dvA==
X-Forwarded-Encrypted: i=1; AJvYcCUE0LEWTzm0yEcNgtxxH2CQE2z4QSJrZGDoM5S4n91qs5dR93pK4US/ReYBrowZ26PIrk5Tqk9d/kJUfNew@vger.kernel.org, AJvYcCWjphq/BXtRFM0q7P2rHd6NUExmvDM/5oABffmLGMBCTnHMFZlNNRukeHLuAea1Z+XL9cYX0sC/x+n4@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM8n7QX29m5qmKvhvIcGmVkED+368NL9VN5o89TcyTrCGoEp2
	vaLHmobKF9u66jIOjptx/c9pj0kvSgiBW95gA0CFmay85GucrWXP3bRnn8dLSo0G8IbqcXtVBVf
	ioYj4B2vd53M1m776rIJNYz6uocn20ug=
X-Gm-Gg: ASbGncspxcFzHaW0UQbXUgLoLxU9lsfXsrF2uQFAD2ooFbKSEYRxvIUsXfmk9sO3ylf
	q910AwqKwn4h6cCNUA2jlODF3P3FMKtVij0Ram7bk4HCpFaCu6Ar84PcCm5vMvvC0+e4NCdy5aV
	GTWO93AjBGYUVnJS2S/NCaCvA5C5S8U326roZKTOf84vY=
X-Google-Smtp-Source: AGHT+IGK31UYHxZyegbhwqAA8Azl5cZSHc46jPoyB8h4dSFTqOv6EdPEttIj40sBvrczCtpj1VRoPqADNTSYhBE/7EU=
X-Received: by 2002:a17:907:72d5:b0:add:f0a2:d5d8 with SMTP id
 a640c23a62f3a-ae057c80225mr1580557866b.11.1750774847450; Tue, 24 Jun 2025
 07:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
 <CAOQ4uxgA0FTB8jRC21uA6wC_5_VaFZB7O7CdF_EHA+HrBDS2DA@mail.gmail.com> <20250624-zeitzeugen-gegraben-88ef5162e1fd@brauner>
In-Reply-To: <20250624-zeitzeugen-gegraben-88ef5162e1fd@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 16:20:35 +0200
X-Gm-Features: AX0GCFvnHUMS64lcFmc8M2CdJQfswJHBYdDBlsHX54F3Ve0e_XV8aTS2Ms2lS4k
Message-ID: <CAOQ4uxguH4txWsh3rs0u+NUyGk0sXhqu=ezvzNKkAiW4fNOvOQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] exportfs: add FILEID_PIDFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:43=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jun 24, 2025 at 03:15:18PM +0200, Amir Goldstein wrote:
> > On Tue, Jun 24, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > Introduce new pidfs file handle values.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  include/linux/exportfs.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > index 25c4a5afbd44..5bb757b51f5c 100644
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@ -131,6 +131,11 @@ enum fid_type {
> > >          * Filesystems must not use 0xff file ID.
> > >          */
> > >         FILEID_INVALID =3D 0xff,
> > > +
> > > +       /* Internal kernel fid types */
> > > +
> > > +       /* pidfs fid type */
> > > +       FILEID_PIDFS =3D 0x100,
> > >  };
> > >
> >
> > Jan,
> >
> > I just noticed that we have a fh_type <=3D 0xff assumption
> > built into fanotify:
> >
> > /* Fixed size struct for file handle */
> > struct fanotify_fh {
> >         u8 type;
> >         u8 len;
> >
> > and we do not enforce it.
> > there is only check of type range 1..0xffff
> > in exportfs_encode_inode_fh()
> >
> > We should probably do either:
> >
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -454,7 +454,7 @@ static int fanotify_encode_fh(struct fanotify_fh
> > *fh, struct inode *inode,
> >         dwords =3D fh_len >> 2;
> >         type =3D exportfs_encode_fid(inode, buf, &dwords);
> >         err =3D -EINVAL;
> > -       if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dw=
ords << 2)
> > +       if (type <=3D 0 || type >=3D FILEID_INVALID || fh_len !=3D dwor=
ds << 2)
> >                 goto out_err;
> >
> >         fh->type =3D type;
> >
> > OR
> >
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -29,11 +29,10 @@ enum {
> >
> >  /* Fixed size struct for file handle */
> >  struct fanotify_fh {
> > -       u8 type;
> > +       u16 type;
> >         u8 len;
> >  #define FANOTIFY_FH_FLAG_EXT_BUF 1
> >         u8 flags;
> > -       u8 pad;
> >  } __aligned(4);
> >
> >
> > Christian,
> >
> > Do you know if pidfs supports (or should support) fanotify with FAN_REP=
ORT_FID?
>
> I think it's at least supported by fanotify in that FAN_REPORT_FID and
> FAN_REPORT_PIDFD aren't mutually exclusive options afaict. I don't know
> if it's used though.
>
> > If it does not need to be supported we can block it in fanotify_test_fi=
d(),
> > but if it does need fanotify support, we need to think about this.
>
> Sure, block it.
>

hmm, we are already denying sb/mount marks from SB_NOUSER,
but inode marks are allowed.
I don't want to special case pidfs.
I guess we can do:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1736,6 +1736,10 @@ static int fanotify_test_fid(struct dentry
*dentry, unsigned int flags)
        if (mark_type !=3D FAN_MARK_INODE && !exportfs_can_decode_fh(nop))
                return -EOPNOTSUPP;

+       /* We do not support reporting autonomous file handles. */
+       if (nop && nop->flags & EXPORT_OP_AUTONOMOUS_HANDLES)
+               return -EOPNOTSUPP;
+
        return 0;
 }

if needed

> >
> > Especially, if we want fanotify to report autonomous file handles.
> > In that case, the design that adds the flag in the open_by_handle_at()
> > syscall won't do.
>
> Sorry, the design that adds the flag? You mean the FD_INVALID?
> Why is that?

I mean the design that adds the flag FILEID_IS_AUTONOMOUS
in do_sys_name_to_handle(), because fanotify encodes the file handle
with the vfs helper exportfs_encode_fid(), so the resulting fid it reports
is not autonomous.

But I think I have a suggestion to untangle all this mess.
I will explain in another email.

Thanks,
Amir.

