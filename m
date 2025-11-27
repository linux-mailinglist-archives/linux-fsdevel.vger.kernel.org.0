Return-Path: <linux-fsdevel+bounces-70030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43689C8EACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628A73BC362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38633372C;
	Thu, 27 Nov 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwlMZv+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780A3328EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251736; cv=none; b=iSTuzglM8k3eWdzgJsKFx6saHn78cIRqXkdna6ZLFSPub0p9zT/psoV4n5wxLtChsGol/uEBaSyuUI79IsgKX4ITC8hLTxrRg+q8/5FapZLn7ShcngtWGXuWfZEbSid5zyFuWk3tlXk/pZkW3OA3yuAbf9Ex1ztiVHiv7CEcTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251736; c=relaxed/simple;
	bh=Os4Lvx6KgcZkwmRfLRjDx8vE7aV3dQ5M8wa8V/1U4gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpcAx2iiU38Shb9j6SzZmvJk7OB8qtMSbrIASSacV+xTzwyNS/CDjVQS0l6FhqXz0PbB67E9e3XUstolR11d4Dk36TKi6Edk6/QZ8xtWFbgfFcQlAezRkXJFAOHgbWda4tsCXkxKz/vO7c5A4KS0FZQEqElaprDqVFsoCXezC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwlMZv+I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324204so159873566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764251733; x=1764856533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaMQ1trz+NYw2jMsnUtD+LyVHIPnVAIyDHdDzDFMieI=;
        b=EwlMZv+IgqEy2k1mceoNXd9GyLab9B5snaYKziL1TILIREsfmLcLxjqf+sSODZrLiS
         fe8ZzKv9xmWIlirl1ACvTsbVzeSYmQ2V/5i8SNZVioSAjgD43eOb0QoCPY0zRA63X9r9
         HqZIsBlVm2pb5W1bragrmMhREoK4M01NNqi3WHOe9vbb7vknj8ItcZRh5H6oX/BvWRc9
         vIYTKFsWd02y4MlLKED3HKyGHmJjHuGE2T6Y6ETE9JeMeo11ycVfime7qCKInS8AXBBl
         2LmO97KNo3kBVOp0MlH1MsO2j5eADZEKr8YlSrpPgNpLBy6bKpWiA377kO8f9FNc+1UB
         QU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251733; x=1764856533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaMQ1trz+NYw2jMsnUtD+LyVHIPnVAIyDHdDzDFMieI=;
        b=SHNU/N4Cd2ztckwRVZKiv3r+f7PW5lsHBOybxFHRIs5yHL0A/PvOMsKPh0U/4uX4wZ
         KP7ENdz8Hmyh7HdRYky+ITfR+lsuTZMU8D23EFIG0/+kScomfhe55q2p9dQhubpGEHht
         OF4eiXpN/GSSSOrG+1y7zOyjFpsJUaYsfgIv/iHrsj8MVwZhTEzdPbsRTTjh0+3kNE8D
         hkC7Tx/JCgAlYM6VWcDrNgnCeQM3cCE8G3J8OXb/UarJAIkp/py2iLSoyN2Jac5ZdYXR
         WhhDJCh9jlfTrjPHyoJvn7jypcaM7RteJqLV7bJxP9lkBarE50A3LoACXkC/0oaZSUWr
         Yp5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOp81g0LASO5dsfy7sV6BGKT+URmVE3dYbwpk2GWm6g9R0mi5pwCKC4aYxScNlUluxPkm1h8DpN/+B/B16@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4TjY/++U2xE1ADz8OtDTYl1Z4cgl18/vDA7WWfipvhk3HMH1
	2N2UPRHga+/PQsQO4Pfxr25O39FnsL9AbmQDnv3FFvJm3TV8W/vxPD5tFjiaFYkTWuu0Jd4r6T6
	yMpFsc3l/K9fFDHzlcJHGVJcM7KZps2E=
X-Gm-Gg: ASbGncv6OOqGY+hnOBxe6Ev6Zbpl7OTJwd2BWsjO+4/Fr6WLNxocgoAH03wsjmbtxvO
	6JAltrepLFdigwFDg6X7YqcHbnp4tBJ5vodmZLbRdxe7Sm7tLunIELBafT9J2pFJXQBCf0BkeeD
	RfutH2/uaJfJOIM/oXu2stYHir47MFtItUeqq3paC6KY/KwIkkTD6opCjIHqsHteV8dgZ2R44cN
	3/QgvIMklmgUkT5lmq7Z6Sh1FFRj8VP+nLNxMiDev+2OCmVYceK2latCfAcjNabf5Qtg1RkYUiR
	HMYCK0fnqJdoAj6hCjzDPC3u5zfz4n+ntgv7
X-Google-Smtp-Source: AGHT+IEgfmakWZP9XCSrXpe6LTY6B9fJgPXoq+xBT1euZeQ4OEFOai+xgOwsgYzdC88hC7Yr86jezDngc4aZZDOV5e4=
X-Received: by 2002:a17:907:9815:b0:b72:c103:88db with SMTP id
 a640c23a62f3a-b76c534e251mr1022588866b.9.1764251732911; Thu, 27 Nov 2025
 05:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127122412.4131818-1-mjguzik@gmail.com> <3xwv7kza6hgxfzzsmyoolno4yygiqses4rutu3n2l2qqrf56ry@p7hs7s5yik2t>
In-Reply-To: <3xwv7kza6hgxfzzsmyoolno4yygiqses4rutu3n2l2qqrf56ry@p7hs7s5yik2t>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Nov 2025 14:55:09 +0100
X-Gm-Features: AWmQ_bn7KIB9mlOskxBiz4lVtRNzLh1CiEPZCkwlwpLn5kRP1RRSuP9TgQKXmoQ
Message-ID: <CAGudoHGh-=MKK0CBWosD6ikb5HHmRr0u_YxQD0bceL9dCeUYDw@mail.gmail.com>
Subject: Re: [PATCH] dcache: predict the name matches if parent and length
 also match
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 2:52=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 27-11-25 13:24:12, Mateusz Guzik wrote:
> > dentry_cmp() has predicts inside, but they were not enough to convince
> > the compiler.
> >
> > As for difference in asm, some of the code is reshuffled and there is
> > one less unconditional jump to get there.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> I've checked and on my laptop the dentry hash table has ~2 million entrie=
s.
> This means we'll be getting hash collisions within a directory for
> directories on the order of thousands entries. And until we get to hundre=
ds
> of thousands of entries in a directory, the collisions of entries will be
> still rare. So I guess that's rare enough. Feel free to add:
>

collisions with the same parent are a given, but with the same length
on top should be rare

> Reviewed-by: Jan Kara <jack@suse.cz>

thanks, but see v2 :)
https://lore.kernel.org/linux-fsdevel/20251127131526.4137768-1-mjguzik@gmai=
l.com/T/#u
>
>                                                                 Honza
>
> > ---
> >
> > i know it's late, but given the non-semantic-modifying nature of the
> > change, i think it can still make it for 6.19
> >
> >  fs/dcache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 23d1752c29e6..bc84f89156fa 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2346,7 +2346,7 @@ struct dentry *__d_lookup_rcu(const struct dentry=
 *parent,
> >                       continue;
> >               if (dentry->d_name.hash_len !=3D hashlen)
> >                       continue;
> > -             if (dentry_cmp(dentry, str, hashlen_len(hashlen)) !=3D 0)
> > +             if (unlikely(dentry_cmp(dentry, str, hashlen_len(hashlen)=
) !=3D 0))
> >                       continue;
> >               *seqp =3D seq;
> >               return dentry;
> > --
> > 2.34.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

