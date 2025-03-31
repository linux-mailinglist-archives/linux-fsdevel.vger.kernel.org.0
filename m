Return-Path: <linux-fsdevel+bounces-45349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A4A7678B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74D718898AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAC213E65;
	Mon, 31 Mar 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/J5tcE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FE1DF72E;
	Mon, 31 Mar 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430558; cv=none; b=XF33Rlv2IGsj1Gez8kg+OqfOsrIjRtjiG/mnwsAYk/j1RIaz4H4sT5NqBFj9oXxuMp29kt5jrc3Gs+1eJ24sIAHxQcBeDYNPdmzQIOt59I+gcolabiYhaMxx2oIfICFJBDu7JjTxvg+0Q+OPtL1Mf/NjejlVBbW8QvZTGBYLj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430558; c=relaxed/simple;
	bh=u4asOOkJL5H38FdOWS+70qA+ZSrNZ25FZ1N76jwXbz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9UOPBOnJ4Ktz8LeCpj+vBZ7kWS8Vzu2SXzRsbIdy6BEKCUQ6/TxMViZzfB9coVSo4dxqvvVgCz/xNJSwVVQokyPP5ZiZi6p00CtLp9+fjiPWHRLLX5iSTJ7RqjpLRaAN7Th76olEseQRUldSVZw8HRfk/SPYsO2BSy0S2DRwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/J5tcE8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so670010366b.0;
        Mon, 31 Mar 2025 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743430555; x=1744035355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Efm7vyI0UggOeElhP8HuC+GaLyiMJk4UFAleiVjps3M=;
        b=W/J5tcE8Gnf1E3xdKClTrvneuENbqOb94We5TKz+vYpFX+c1zFICWEL8P+QH1GN8Sn
         JAGP9JyZorjqhsyOoRtmj1MP7+lojU7SQiO+yHO7PzQSYiygWyZQaPQHWKZtfSdrX6xs
         +7/OGg9dhtppNSoT45ZlUL+7wd8o0Yc1z7nsZM/mJ4acTcNVrE+mp8gq8DgS70DPdRL2
         nsbp3vs970ltgF7VUdHftplP87U6yjAXwhosuEcXwWsDrvpnuLbqBhQndXBIxj6Paw+d
         HPXzrFRtCur7mi92SltRHz17HY3XLUmznLnxWutaK+82fvOt4A+J2em/9g3rZTBpEUcq
         ED7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430555; x=1744035355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Efm7vyI0UggOeElhP8HuC+GaLyiMJk4UFAleiVjps3M=;
        b=vCT6jLytpjXINPg+s70V/e63Eh4vAv2ZFrbRy3PXPJh1xObbfqmu19k/BBDUuKe/iP
         CoqLHGtfTiyf74mrazdjTIM8A+PG+vjXIeP6WJvFbOExESthoVUwwxUNPPMswuJK3lHF
         lr48vGaANQsRrmIU8xQlwHIaDaZKQx01knWllUUBAOwE/VJ2FTa7RTniT9SY7SRquXwg
         x05h3wo6a0+kTBJLDYyubKqjNseFc76LaHLdV+n6096wHyxon6EiZK4mOmpMo+751Hwa
         P9yjs0HNiEidpa5NTRzO/cyFW1IAbTAu3Y8kvTLUDLbd+jaP6s3GiN/ZO8G1eS3tp1aK
         FOEw==
X-Forwarded-Encrypted: i=1; AJvYcCUM6WmGsgjDthW5Ws/u2Q9v/84VgrKdwkE3EoHxNgi1lDbXNyjGlyY/y+nNhijpHcDS8PwtNhW99eTytNMS@vger.kernel.org, AJvYcCWTYPoqIlSpx+AsYgAj3p0iA8h3FbXJ5HM/to6b+i5RmC2cDTWzlCZXfXzRNRpR0Sv27FhPsTU5OJx5@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXYH/oLcSKIddTKW3v9y7fkPqYOe8EPbie0/w0+dwIqb96884
	JduxpkOZjWk37y67CYsYCn7Nlz3SovkY2Sm8EcXV0htw1bWk7mXBVNzWBEkqwwRfbXRfl9i58QV
	urgPUaCHkgTKQ70vuKASX30wGS5E=
X-Gm-Gg: ASbGncv/sebX8as8gGwLQd99MLFQQxOJZ4/G2CSgRynQswnVRr6g2Ocdh/lvAPKLFE4
	KxAi7shXA6QzFbOmNmp2K7jes/yUj5scza8CvRLcJr6NKq8+0a0+m9YN4LnaXr1j5DPhHsf/oi4
	J/vnWQ6DY99drYZqozFsAHyh1J8DTcaxaYyyFM
X-Google-Smtp-Source: AGHT+IEbcdg39ZM8FuXbYHjOnt98fMN2jaTWLAGxMl7FPDzUhH8l2u6iBxX8jWDIDYEQlpG1lwlfKfgbjheCHnHhb0c=
X-Received: by 2002:a17:906:7955:b0:ac2:758f:9814 with SMTP id
 a640c23a62f3a-ac738a50849mr907341166b.23.1743430554229; Mon, 31 Mar 2025
 07:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331135101.1436770-1-amir73il@gmail.com> <3k2d32vlljorweynxujgyi4ezkkhbbmg6bfud26fthtg5xrpci@7dtdk72cvaga>
In-Reply-To: <3k2d32vlljorweynxujgyi4ezkkhbbmg6bfud26fthtg5xrpci@7dtdk72cvaga>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Mar 2025 16:15:42 +0200
X-Gm-Features: AQ5f1JoYQOabhFVCJUO0zyuAFVzsW9T1GmQosPYpwGJAKjjM6n-rtMGfklP6RDI
Message-ID: <CAOQ4uxjLcqdPSvfEp9S6=4KSe0s0xaE+k+w=cTSMHYpo-F0TPg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document mount namespace events
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 31-03-25 15:51:01, Amir Goldstein wrote:
> > Used to subscribe for notifications for when mounts
> > are attached/detached from a mount namespace.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ...
> > @@ -442,6 +459,12 @@ A file or directory that was opened read-only
> >  .RB ( O_RDONLY )
> >  was closed.
> >  .TP
> > +.BR FAN_MNT_ATTACH
> > +A mount was attached to mount namespace.
> > +.TP
> > +.BR FAN_MNT_DETACH
> > +A mount was detached to mount namespace.
>                         ^^ from
>

thanks for spotting

> > @@ -727,6 +751,21 @@ in case of a terminated process, the value will be
> >  .BR \-ESRCH .
> >  .P
> >  The fields of the
> > +.I fanotify_event_info_mnt
> > +structure are as follows:
> > +.TP
> > +.I .hdr
> > +This is a structure of type
> > +.IR fanotify_event_info_header .
> > +The
> > +.I .info_type
> > +field is set to
> > +.BR FAN_EVENT_INFO_TYPE_MNT .
> > +.TP
> > +.I .mnt_id
> > +Identifies the mount associated with the event.
>
> Since mnt_id is not well established, I think we should tell here a bit
> more about the mnt_id - that this is the ID you'll get from listmount(2)
> and can use it e.g. with statmount(2).

You are right, but it is actually established much sooner,
As I described mount_id in the recently merged man page patch
name_to_handle_at.2: Document the AT_HANDLE_MNT_ID_UNIQUE flag

...is the unique mount id as the one returned by
.BR statx (2)
with the
.BR STATX_MNT_ID_UNIQUE
flag.

So I will add a reference to statx here as well.

Thanks,
Amir.

