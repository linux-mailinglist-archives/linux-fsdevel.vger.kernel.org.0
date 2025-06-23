Return-Path: <linux-fsdevel+bounces-52544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FDAE4008
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B9F17783B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057423E23C;
	Mon, 23 Jun 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9QT6ulW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA77081F;
	Mon, 23 Jun 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681361; cv=none; b=Yb7LYjVyOKVO3Ni2iAREZSzc/bfSwzdNdBO35UL4gWavC3k2W8u3dcyupr97Q7Wdx+r4pajBP7s0tdfMEu26O9PzyZmhGDzSS6YgUBPHjyId5o2W/LiXsZvayTq1LnqmIvD8N7z0Nu7XwJadK2aaBjdyTFrw5zNmwuiX/KyR0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681361; c=relaxed/simple;
	bh=xiN3A1fOmRcD84YEq+Yp2ui/stDt/ZCWcSxqxG0B7jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Id7Ix4/DFzEtabjDIAgWWUzXuuGA49UCCxhmaMEkDprFxW9Q/mH1r+MhziHDRAToD4ktsQV5Ma3Djm1fu+uBqhtxtiUjhnCPciNJne+OMRlrsY9YeMdV4x9nJRay0IDjblp7beBw/mJuCPtaHJ3ckuQJNgxNO7j6qU7XqgX7R8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9QT6ulW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade58ef47c0so842108766b.1;
        Mon, 23 Jun 2025 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750681358; x=1751286158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1+lKnMFhRJaFjskxua8Lv90AA+v7x7uHwsG8HPQ8Yo=;
        b=E9QT6ulWHzkLUx4Uxy2bQfU/aBkhuhKvLJrBXIPqeGGSEz3OPCk+HmUYzIGTc6ZTgz
         XQpM9QfxY+M3aC/LzweTsoVGEgDzUEq/Tq/xZyejugJlZ6WsXtWzYB1gK4p2Gm3Luvog
         hJcu8uwCSroMiZ3xDemYkvsm9zn0AVHM4+Q2tmcPLIbmcM7D0H3L9/1Su9unmSP5w+7y
         oji8yBkYTH0+nSZQSrRu5KZKh0W04NQnpe1YIizRQEYA3Dp/InjuqZhwPOHNFdneLgB5
         kkB0CwOMYX5709A4gXdjkuLkRxnO8+cfpcgYmLT7THZOKP6/fN5fQSFsxEHXZZnqDTpQ
         xG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750681358; x=1751286158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1+lKnMFhRJaFjskxua8Lv90AA+v7x7uHwsG8HPQ8Yo=;
        b=XYeRXRSkhhdvLf6EK9U269EeujniRk4zmRkF1Do76gQaW1lUXOqXysyfdye8UBHxao
         RgvioFirraU6yJYArkQ1QzT7o8zfLNjmXv3ywrtaIsPLkiFOtIUEj/kPm0tcHtXEc+gR
         RLcllLLCWC9v+r7KFFbcBsxhpmS+Z4i3iWiAd2vHFalBQp1sqXp/oVLFQp+azpUIf0lG
         r6BXBE6HL7VIKIikHVZS4VtMPInVZpyG3JC34bjwruQSl6YyzJv2Tfu4pd6XHmmsD9Ge
         huzq7levM+kBVYaFaNvEHKPqW4cYsNZncZ+kzrI/xjc3UZeiKFaQe9r3g6hAq8es9YjU
         Y2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW+CLXFarPBklR/e0CJ8UCcJs8E3kiYNwDf265wpFewDlkAtCJ6P18zhHjl9as2jf04Ry+f9uJRWT42@vger.kernel.org, AJvYcCWLfjSur6KXgFAaaV2DRxXhJRAK5YW6bpY+7nc3R8SMrQ+VAYZv9tQkCGSxDylX27UMCs4blyJ/GPXTRjwn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6zvUkdD31F3FvjtBS0T3nFfVTPTi6yBlBnIFUDVcz2/yz6M+
	a6qz3lY+/rakk2XcyjX/k/OenXPaolM7oCtVh/Z5WBV7usjzCcE/2gNk4wFu0H3EguY/xwCAYAX
	PRkTsUfgE92OTue5gxRctCt7rJbd58RBGdZu9
X-Gm-Gg: ASbGnctxBubOqParVp5T7ltwoHbGTezHM6hV6HF4ZFQSMrk2lyLT8nuv7phUSWMueh6
	FZS5syHOeW2jKQ+JtEHeVJ8AkxG+CbALG5Zo3D7xdes1lBuPh9buh6FBwF8YtMvGhBxw24SiqwB
	6modvddbAMlH/sOi8xZVfR4CC+xk7yyofTc4OP92G3Szw=
X-Google-Smtp-Source: AGHT+IG6ZEnEM7ofgyyrBuAkrjc7aMd3Cw3C4ArEJNJKebaC8WVGIDpyJrxeGxGpMgl4GAMl8NgsY6lL22widj6JjlY=
X-Received: by 2002:a17:907:948c:b0:ad5:2d5d:2069 with SMTP id
 a640c23a62f3a-ae05ae7169cmr1264809766b.13.1750681358005; Mon, 23 Jun 2025
 05:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx> <20250623-herzrasen-geblickt-9e2befc82298@brauner>
In-Reply-To: <20250623-herzrasen-geblickt-9e2befc82298@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 14:22:26 +0200
X-Gm-Features: AX0GCFvhOVwut-kJCQ84TEZfo8xeFcwODhMcozd3AY5F3sB5Grakuy4LNodEJes
Message-ID: <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:58=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> > On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > > Introduce new pidfs file handle values.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  include/linux/exportfs.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > index 25c4a5afbd44..45b38a29643f 100644
> > > --- a/include/linux/exportfs.h
> > > +++ b/include/linux/exportfs.h
> > > @@ -99,6 +99,11 @@ enum fid_type {
> > >      */
> > >     FILEID_FAT_WITH_PARENT =3D 0x72,
> > >
> > > +   /*
> > > +    * 64 bit inode number.
> > > +    */
> > > +   FILEID_INO64 =3D 0x80,
> > > +
> > >     /*
> > >      * 64 bit inode number, 32 bit generation number.
> > >      */
> > > @@ -131,6 +136,12 @@ enum fid_type {
> > >      * Filesystems must not use 0xff file ID.
> > >      */
> > >     FILEID_INVALID =3D 0xff,
> > > +
> > > +   /* Internal kernel fid types */
> > > +
> > > +   /* pidfs fid types */
> > > +   FILEID_PIDFS_FSTYPE =3D 0x100,
> > > +   FILEID_PIDFS =3D FILEID_PIDFS_FSTYPE | FILEID_INO64,
> >
> > What is the point behind having FILEID_INO64 and FILEID_PIDFS separatel=
y?
> > Why not just allocate one value for FILEID_PIDFS and be done with it? D=
o
> > you expect some future extensions for pidfs?
>
> I wouldn't rule it out, yes. This was also one of Amir's suggestions.

The idea was to parcel the autonomous fid type to fstype (pidfs)
which determines which is the fs to decode the autonomous fid
and a per-fs sub-type like we have today.

Maybe it is a bit over design, but I don't think this is really limiting us
going forward, because those constants are not part of the uapi.

Thanks,
Amir.

