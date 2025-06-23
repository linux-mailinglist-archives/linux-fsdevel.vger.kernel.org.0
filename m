Return-Path: <linux-fsdevel+bounces-52547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625FAE4097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847DC7A9116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3D248F46;
	Mon, 23 Jun 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWqW14O5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF209242D6F;
	Mon, 23 Jun 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682292; cv=none; b=Xv5ydllSrefR3ZAInVUuGApqFkbXwmh2HDmO959TT0sX70Lw770Nx9h+TT3ppZ9y98bDgr0vR4dJhehCYGZSd678Wqgyt7ILUm8YzYUkn9BximdaVbW8zb5C8ZPsQBP6DtJ9AJXnh4z6k+dTC22CkUS6s5E3d0abyl8kCtRzIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682292; c=relaxed/simple;
	bh=VZy9CSUt9mk/vqF4oiRuTprjPvP6eJb/pARYaqfJwHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2bMdJ/F5/AlOKrw+9Y891HDxGgtZTBOkYYb2QcdCOygazhC5SaGOwshtFKbxAayw2OhhMyfB2veworznlSRPICnhxv1NokIPNYc7mBWRKnMowqobgZfm8RoIMRS3U8k+dgFB26P3Pufkq1EOMRbZxxocO1G8LyIZsBc5iNhz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWqW14O5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad883afdf0cso826306066b.0;
        Mon, 23 Jun 2025 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750682289; x=1751287089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A27xQCTg0cti1RAIXekdY0tK1YGeklEpEsuW0zdAVtI=;
        b=YWqW14O5sI6rPgCDHWU1k8KkD2tCOpqdzhEv+HkaWuaI/zwHUhojJiQl3L0y2UHAp3
         W/vofpiQ232d4MDnc3Efvpfa9rtCoPeMqw8bPUL34lVJMesypp5WvcQlXliXq4V5DXDo
         NJJnBQ9lPGfifdYKywtDKqtwYf/yQMS49C6xdyPVW1tttc1V7RuRl18vEtZERPTnKaBf
         rr/Wg47dM8orpQqSjD+IgOyeowgqVcuxpYtYJFwt8JxyE2y3kLNUN02/VOmKXCflIVzz
         qhjbppjQA94A8TGYFx8klu4FsQ4p37MoBzDvDfNHtcXWrrTWdpXnXYcwdAetlAokyQ5b
         VHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682289; x=1751287089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A27xQCTg0cti1RAIXekdY0tK1YGeklEpEsuW0zdAVtI=;
        b=T1U1UBphRL50mrYDp2KNbw54/Rf20ksSYgq9306mbXcGSW4fuN8+KDcJGdzDHhjMWP
         qgoQqSs8elwz7zp8LV98YQjqfWRxKfnFnkPj9BHUIHMhZQU2AZ3Rt6jq86yq4uvKouR3
         LBk90qmqeET2iWHyGB5VtrGAfipFzXbktwOw13WdhfG/8R1EArhWc48+ZP7EYG3hjLFP
         fQgsQABsIyN/0zhPigThHxvyo1PASTHqLeQBOzwXgP9jA41CaMFchKAxMrQBlLdsgR3x
         nTWswbQFl3yj0MthAqSdozw983Ua3GqtWKo5ucb/T3Hdzr1a8yw3FYmAhSAZi5EDk2KD
         TcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HJDPtgDC23yMGPPwLxb4z2kMikJUJddcPNuUWa+L9FULZmEPJwiwtEwuPFzsdLBEOsob1R/uzDjo@vger.kernel.org, AJvYcCW5IjZxnW1nQdeJ80JG9lznvq0/x3PFnXavKFwFr7h2kfFBlFasHJ7BSSvWxlB+sdbL9kNtfjX3jxnDJWJT@vger.kernel.org
X-Gm-Message-State: AOJu0YxdK4W6DpSCOdb9NHZX6Ueeifw7H853GG+3npUR7XhNS7xupKDX
	JzIx9uoc6IOOoHrwgM5zGZYgLEgfGvIoVvfd5QBHI6TOsVNw1iWkJYgvwqWOpIvvtZPvaa6V6hw
	MvJBgtdFZbMr8rIOtNWnNUy27GEHC2SrXtEFb8J0=
X-Gm-Gg: ASbGncueig4Gi4//FxwI9CrSgc7zZlH+7gJcZ9V1n1Zno2jK5MpLho75uBCWVmVpTBV
	E3weRrdgEyNZoB98cPTBS1U2WhdZ/SIoU3E+fuoYTvb/C1hW77/WBFzz0vlEUOPl6U7tOO4KwdM
	HuBDM32iIU7V37+gHH0x4FsxnwdolWLrdE6BTEQdP+L28=
X-Google-Smtp-Source: AGHT+IFyL1A9/MyPIFQlIui+rX/ahym4iCjS1bf4nqN/CQ4PDyoPYrcvaAHXrx1CxbO8ebRo3YrLyyc4y8AvhxulKuQ=
X-Received: by 2002:a17:907:60d3:b0:ad8:9b5d:2c14 with SMTP id
 a640c23a62f3a-ae057b3b6f3mr1326066966b.29.1750682288428; Mon, 23 Jun 2025
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-7-75899d67555f@kernel.org> <qonvmbf5cqgcj6rshspxfjwb537vz25ahi2jk773gqgppplydh@7ohq6aw3qhez>
In-Reply-To: <qonvmbf5cqgcj6rshspxfjwb537vz25ahi2jk773gqgppplydh@7ohq6aw3qhez>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 14:37:57 +0200
X-Gm-Features: AX0GCFsQClrSZ-0R6pYZpfhdiiia2RqeUZDbYF8V5u-0rHGhK1jrbg283Z8WnaA
Message-ID: <CAOQ4uxiNisXa7C0-z7YTjuXtAuSzuqDKXvasaPtifuQPGGYkjw@mail.gmail.com>
Subject: Re: [PATCH 7/9] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:59=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-06-25 11:01:29, Christian Brauner wrote:
> > Allow a filesystem to indicate that it supports encoding autonomous fil=
e
> > handles that can be decoded without having to pass a filesystem for the
> > filesystem. In other words, the file handle uniquely identifies the
> > filesystem.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> ...
>
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 45b38a29643f..959a1f7d46d0 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -194,7 +194,8 @@ struct handle_to_path_ctx {
> >  /* Flags supported in encoded handle_type that is exported to user */
> >  #define FILEID_IS_CONNECTABLE        0x10000
> >  #define FILEID_IS_DIR                0x20000
> > -#define FILEID_VALID_USER_FLAGS      (FILEID_IS_CONNECTABLE | FILEID_I=
S_DIR)
> > +#define FILEID_IS_AUTONOMOUS 0x40000
> > +#define FILEID_VALID_USER_FLAGS      (FILEID_IS_CONNECTABLE | FILEID_I=
S_DIR | FILEID_IS_AUTONOMOUS)
>
> Is there a reason for FILEID_IS_AUTONOMOUS? As far as I understand the
> fh_type has to encode filesystem type anyway so that you know which root =
to
> pick. So FILEID_IS_AUTONOMOUS is just duplicating the information? But
> maybe there's some benefit in having FILEID_IS_AUTONOMOUS which I'm
> missing...

The use of the high 16bits as a way for vfs to describe properties on
the fhandle
relies on the fact that filesystems, out of tree as well, are not
allowed to return a type
with high 16 bits set and we also enforce that.
FWIW, the type is documented in exporting.rst FWIW as single byte:
"A filehandle fragment consists of an array of 1 or more 4byte words,
together with a one byte "type"."

It is important to remember that filesystems file handles and their types
are opaque and that filesystems in and of tree do not need to use constants
defined in exportfs.h nor to avoid with collisions with the namespace of
file type constants.

This way, to let vfs raise the autonomous flag based on export_op flags
seems more backward compat and leaves less room for mistakes IMO.

This way, to let vfs raise the autonomous flag based on export_op flags
seems more backward compat and leaves less room for mistakes IMO.

Thanks,
Amir.

