Return-Path: <linux-fsdevel+bounces-31461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76809997098
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947FB1C21B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE431E32B9;
	Wed,  9 Oct 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBEzhu5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727B197A7E;
	Wed,  9 Oct 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488845; cv=none; b=E0oMWDiDLBZq1Pdq6zzfBiVSrzO7qfUCCe4EKVK7eUmxkuC9X/2qmo9aRO7vz/XUbAy6kzmsk3T86pZtIaD6s7BHzKXRQFe3W6Gcor5+qgTmxfhbCqTc3aMwf+GfTGkYvcvDzqb4SbeQiYBxYVmg9KJ3Sz/WiFV7GP08TpdWli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488845; c=relaxed/simple;
	bh=4t3vYaypqAGa71Nycr1GUXmLG9PicTroI6PdaMmQVCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0LfxrhDbpXsD7Ba5iYnoQ0oSRyvJsZ6UtTVdO/4zp7Fz1CUSua4lbDliRuCpelr6HvLHgVYMh4AaffottgcCuylPouzaFMmyJx7Efp5rUszRzseFNuFUUqhATp6D1tdQqTmwkyeduDg/gl1lD0TKqs8RxEUcctDQlT6MV4AP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBEzhu5Q; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b02420b600so88550185a.0;
        Wed, 09 Oct 2024 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488843; x=1729093643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWdlNRbdJ7C3Il2Chzmz6Q7Ub1gRXXaOQC6li9nz9Dw=;
        b=cBEzhu5QVKVQWExEGXq9l7KSTk4Aj5PwRwEZJk25OZ4rFIIOmWBmFxPmDLNFZiS+wG
         nR05JlQxk4PEAqqliNCCuzOQ0ruafAM/OzxkVCpAZ9hEySD2Io7V4GObTBFB0YVWsIzu
         yc5N34flcalNbUX24ZJ4ibTUaTHrBae/HkiKZglXaBgJTv2ttTOH8sbz4u23o6CSLd3K
         KXfktDU3OyLFBTz7LBoMHxz572rFVnNUlwumR2TJwZx/86FTASDPrj+Gg4NIXtC6EyrG
         VnBBWu7334Hl+hmEYBLCAlesQxGeE72iS5fGEeT+D8IY4LEUw3rJX2L0UBbMzx6AfaH0
         xPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488843; x=1729093643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWdlNRbdJ7C3Il2Chzmz6Q7Ub1gRXXaOQC6li9nz9Dw=;
        b=Il+l/4fn0owKwnCPXg/6ynzs5oGZ9UgSUOw1znhcv5QeKD1yLOAruNFIOsHW+2tJ7R
         7olMPhu2MlwsTmnuYTErn51wvArgOk9/+Rvpl8b9nt8nQ6GtNljNVL8m+eChSMSbXyhU
         Qaz7aS2pPCHjkqyvv0awJG/l+KIi3I3nzLjkKD46gkPDTw2um/L/FAmYD0Lbwvlj4c6T
         vT4fH5weQvNGW/VwUX6pyKmExieeG5U0bHl7UGCE4aZgyHzR/iJ0ySZ+RLLBK9kYdybR
         an7nS/CAJS9tyriwToMI8KuuOJRElsDsXZLKbhs7Mo6LGJd6BACwXSEOtkv2HtoSHL8t
         NLLg==
X-Forwarded-Encrypted: i=1; AJvYcCVIPpCyvkv0BGDz+/iJsoyxmImKQ7w7gti6t+Mb9DoeVwwCCtuWN1PXzVoBFZ0oFj8daTT07WqIc3LqwSfG@vger.kernel.org, AJvYcCXu9K14zao7t36vF/s9t06nOvhuYO6qz5hRaTudR1PH9hdfpuAcleLQJTlZaufhMo82gV+1sLkbR9lz@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWCk1AUIe30yx1qOB4WPOdrg0AKwQLg9knnr6HowjMs84ES0O
	hicipJ3JlLWVeX9P47Ue0JWCROoUtY8f4FQdRWngflsAmMj8tB1UXBabIJtjdMLNJ8PJERnEbNN
	oI3Bl8Ww0IN2o65v53SKFRIaHk+U=
X-Google-Smtp-Source: AGHT+IHQKspLfSLEOI1vDnaB8MqG5mFZCD9oK6x5bMiVB2ZrVA65T4yS8TEbk25uMywr7sMRGm7sAaenSkYMBOwfv44=
X-Received: by 2002:a05:620a:1926:b0:7b1:123a:2185 with SMTP id
 af79cd13be357-7b1123a21c1mr18609285a.54.1728488842782; Wed, 09 Oct 2024
 08:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
 <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
 <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
 <20241009094034.xgcw2inu2tun4qrq@quack3> <CAOQ4uxgoZBznM8VsnDoNekuMep8qN7eM8zUsYpS=C4OKC3ZMMg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgoZBznM8VsnDoNekuMep8qN7eM8zUsYpS=C4OKC3ZMMg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Oct 2024 17:47:11 +0200
Message-ID: <CAOQ4uxjG_4TUuJDsK9AwK4AqdF9sb2MPDefUg3yhsCKqv9SBcw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:16=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Wed, Oct 9, 2024 at 11:40=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 08-10-24 15:11:39, Amir Goldstein wrote:
> > > On Tue, Oct 8, 2024 at 1:07=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > >
> > > > On Mon, 2024-10-07 at 17:26 +0200, Amir Goldstein wrote:
> > > > > On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <braun=
er@kernel.org> wrote:
> > > > > >
> > > > > > > open_by_handle_at(2) does not have AT_ flags argument, but al=
so, I find
> > > > > > > it more useful API that encoding a connectable file handle ca=
n mandate
> > > > > > > the resolving of a connected fd, without having to opt-in for=
 a
> > > > > > > connected fd independently.
> > > > > >
> > > > > > This seems the best option to me too if this api is to be added=
.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > Jeff, Chuck,
> > > > >
> > > > > Any thoughts on this?
> > > > >
> > > >
> > > > Sorry for the delay. I think encoding the new flag into the fh itse=
lf
> > > > is a reasonable approach.
> > > >
> > >
> > > Adding Jan.
> > > Sorry I forgot to CC you on the patches, but struct file_handle is of=
ficially
> > > a part of fanotify ABI, so your ACK is also needed on this change.
> >
> > Thanks. I've actually seen this series on list, went "eww bitfields, le=
t's
> > sleep to this" and never got back to it.
> >
> > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > index 96b62e502f71..3e60bac74fa3 100644
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@ -159,8 +159,17 @@ struct fid {
> > >  #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent=
 */
> > >  #define EXPORT_FH_FID          0x2 /* File handle may be non-decodea=
ble */
> > >  #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
> > > directory */
> > > -/* Flags allowed in encoded handle_flags that is exported to user */
> > > -#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DI=
R_ONLY)
> > > +
> > > +/* Flags supported in encoded handle_type that is exported to user *=
/
> > > +#define FILEID_USER_FLAGS_MASK 0xffff0000
> > > +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> > > +
> > > +#define FILEID_IS_CONNECTABLE  0x10000
> > > +#define FILEID_IS_DIR          0x40000
> > > +#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILE=
ID_IS_DIR)
> >
> > FWIW I prefer this variant much over bitfields as their binary format
> > depends on the compiler which leads to unpleasant surprises sooner rath=
er
> > than later.
> >mask
> > > +#define FILEID_USER_TYPE_IS_VALID(type) \
> > > +       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)
> >
> > The macro name is confusing
>
> Confusing enough to hide the fact that it was negated in v2...
>
> > because it speaks about type but actually
> > checks flags. Frankly, I'd just fold this in the single call site to ma=
ke
> > things obvious.
>
> Agree. but see below...
>
> >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index cca7e575d1f8..6329fec40872 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1071,8 +1071,7 @@ struct file {
> > >
> > >  struct file_handle {
> > >         __u32 handle_bytes;
> > > -       int handle_type:16;
> > > -       int handle_flags:16;
> > > +       int handle_type;
> >
> > Maybe you want to make handle_type unsigned when you treat it (partiall=
y)
> > as flags? Otherwise some constructs can lead to surprises with sign
> > extension etc...
>
> That seems like a good idea, but when I look at:
>
>         /* we ask for a non connectable maybe decodeable file handle */
>         retval =3D exportfs_encode_fh(path->dentry,
>                                     (struct fid *)handle->f_handle,
>                                     &handle_dwords, fh_flags);
>         handle->handle_type =3D retval;
>         /* convert handle size to bytes */
>         handle_bytes =3D handle_dwords * sizeof(u32);
>         handle->handle_bytes =3D handle_bytes;
>         if ((handle->handle_bytes > f_handle.handle_bytes) ||
>             (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
>                 /* As per old exportfs_encode_fh documentation
>                  * we could return ENOSPC to indicate overflow
>                  * But file system returned 255 always. So handle
>                  * both the values
>                  */
>                 if (retval =3D=3D FILEID_INVALID || retval =3D=3D -ENOSPC=
)
>                         retval =3D -EOVERFLOW;
>                 /*
>
> I realize that we actually return negative values in handle_type
> (-ESTALE would be quite common).
>
> So we probably don't want to make handle_type unsigned now,
> but maybe we do want a macro:
>
> #define FILEID_IS_USER_TYPE_VALID(type) \
>              ((type) >=3D 0 && \
>               !(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))
>
> that will be used for the assertions instead of assuming that
> FILEID_USER_FLAGS_MASK includes the sign bit.
>
> huh?

Scratch that, the assertions check for any user flags at all.
I will just open code type < 0 there as well.

Thanks,
Amir.

