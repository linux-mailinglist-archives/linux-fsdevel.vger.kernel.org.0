Return-Path: <linux-fsdevel+bounces-31211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F210993073
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D053B25126
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318D1D8E01;
	Mon,  7 Oct 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Ru+oo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EB1D88BF;
	Mon,  7 Oct 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313366; cv=none; b=eg4C5eRNBirYTyFFarJU6sSLg9H3NUKGb8+vofT77W/fFtjA/1kOViIQCEwKOuM0pVo5z+VPO/YB4yEMCOVwx4+xXmrZm9Nmh1YxpEvDchKe9mD9zUkf7Misjt1R4GQua7Aiu4AnwkzruxxZWSUmFuo08LkgOEGlnTQD0dPPws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313366; c=relaxed/simple;
	bh=B13MxCRW9jsqr1anZQPdMT2T2QfFp3XrIP8oHV5hph0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndprBJHomoOz/fJIYuCXIal4yAXe1dmu5t/VUOj+OcZbXE4NiiCwZRj8mY5x8fi74XeSS/k9n+Xb4c3CfFJ+qwBQHwui+xRY0zoOWjQ4eDmh/aQKuhxauadwINJ35yV9ksgMtflI65LXYeZLGwKVvafVMwYRj4yVbv4es8xegbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Ru+oo/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf48166bso51650881fa.0;
        Mon, 07 Oct 2024 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313363; x=1728918163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbr+Z+qX12MylYir5eLjsvDJLbWukomsRsdrv/i/ToI=;
        b=H+Ru+oo/NoUrbicAj0vg06s8r8/KEtIE7dgEk+PuQs6F/zKniqpqpPO6elfG06XWWD
         YjuIuk9ABnmvYkbg0U6WumQ1lISAdkOyE/koUwj1hB/KyKe38TdivNS0oMvZ8F0uySRO
         odsS01xBilFTAVsQARv1TN5rqIzqZO4P72B1Nr+gb3DCfogprGI+TU7Eox8BbjDKD1gv
         kkIH1Kr+UOJLIfkTEOZ6J2LhqohQ9AZctNJNpvXAPJ2/nsB3L6ZmMwzSBw1UAb5iPIAK
         utVNbVVaA6v+7OalzYsLG/3BS3U6H5h+DcC9OcaaaHpZZ0NFDkgVWcdicWU/bE33fst+
         C1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313363; x=1728918163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbr+Z+qX12MylYir5eLjsvDJLbWukomsRsdrv/i/ToI=;
        b=kFQTG27wID8NW5ao8PSh+yz6aL5lsZpwwgQor0uMY+Y23zJeiiwM5+dVhWrmj1zheV
         jhv+PMIC2MjttxsQuHaC6oIzSPGR8uE46YFfC+pxPPheuNzWahMtTcblgy1J0wBHBely
         WDpv72xvFDPBL7CuZofSpX6BVYrfq4vK7+WdbXeQOKcXn8IxHURAJkgHB+dDQQmpEFLU
         qUTAC/QC67mhY078jwRgU11xA8lxw5ePkFU/sZ1tk3FZs6P3YJXDifvEATCCnPEw1xZu
         bg35FK54PzYYpn3u9pBGVGtdOufkqNE78qaLa//xE5lEbUT7Vm1YexqGh+ZC7tj4R5n5
         /9yw==
X-Forwarded-Encrypted: i=1; AJvYcCXrk8X9XZJnTccMDUpT5XustgdZm6hZVKNrNAUnyMsxdtaX1L5hOgsO01N1AvPkctXkq8bQ4JiBdQavahU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDk4rQLrqdNLvjOWX3AkuNugaGDJvxQCML2HZ6fupTEn9SDCyv
	RWSMj4q1PBsrsP7aXHFoorQznXWaPlYXBt/uNISaMOifKLqlYHBXbS+ytiNGKzo3ETINl9dXvSB
	ZZmTl7b/rEFSKngDmWS+kvS3R+7w=
X-Google-Smtp-Source: AGHT+IGt6CoKiI9IMyHkeVqvXEQsLG80bTKiaVKvrYDpVbB1tU7Ygm1RnERKsFfMU1aQPra6NUZuDMGLSG4Qnx+ouRg=
X-Received: by 2002:a2e:be87:0:b0:2fa:c841:af36 with SMTP id
 38308e7fff4ca-2faf3d70782mr58349091fa.30.1728313362394; Mon, 07 Oct 2024
 08:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007085303.48312-1-ubizjak@gmail.com> <20241007145034.GM4017910@ZenIV>
In-Reply-To: <20241007145034.GM4017910@ZenIV>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 7 Oct 2024 17:02:30 +0200
Message-ID: <CAFULd4atoeGkCTc+itU_ACBAcBxXPbPNOhockqCnd4Xsc75R9w@mail.gmail.com>
Subject: Re: [PATCH] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:50=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Mon, Oct 07, 2024 at 10:52:37AM +0200, Uros Bizjak wrote:
> > Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> > to use optimized implementation and ease register pressure around
> > the primitive for targets that implement optimized variant.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > ---
> >  fs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 93c377816d75..9a3c251d033d 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3901,7 +3901,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct =
user_namespace *user_ns, bool a
> >       }
> >       new_ns->ns.ops =3D &mntns_operations;
> >       if (!anon)
> > -             new_ns->seq =3D atomic64_add_return(1, &mnt_ns_seq);
> > +             new_ns->seq =3D atomic64_inc_return(&mnt_ns_seq);
>
> On which load do you see that path hot enough for the change to
> make any difference???

It is not performance, but code size improvement, as stated in the
commit message.

The difference on x86_32 (that implements atomic64_inc_return()) is:

     eeb:    b8 01 00 00 00           mov    $0x1,%eax
     ef0:    31 d2                    xor    %edx,%edx
     ef2:    b9 20 00 00 00           mov    $0x20,%ecx
            ef3: R_386_32    .data
     ef7:    e8 fc ff ff ff           call   ef8 <alloc_mnt_ns+0xd0>
            ef8: R_386_PC32    atomic64_add_return_cx8
     efc:    89 46 20                 mov    %eax,0x20(%esi)
     eff:    89 56 24                 mov    %edx,0x24(%esi)

vs:

     eeb:    be 20 00 00 00           mov    $0x20,%esi
            eec: R_386_32    .data
     ef0:    e8 fc ff ff ff           call   ef1 <alloc_mnt_ns+0xc9>
            ef1: R_386_PC32    atomic64_inc_return_cx8
     ef5:    89 43 20                 mov    %eax,0x20(%ebx)
     ef8:    89 53 24                 mov    %edx,0x24(%ebx)

Uros.

