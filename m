Return-Path: <linux-fsdevel+bounces-25397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83994B6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353A6B25191
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BF186E36;
	Thu,  8 Aug 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US9W8N3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134F183063;
	Thu,  8 Aug 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098396; cv=none; b=LvhPXbk7TLv6WuU+xI91EFAPRJaUcma84gEOMuNFVSwgS2bYoW6f6bI557KeKJpf4CxyArQoOHDqwjaMwQQ08Lq7p4X5V98IbGhES04B6tWpDKhRZk1ejSlb9icrTf4H3q99Lhp3YWzT/BtSZuiqwm2Gqdz3ODafCcc4mgXBVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098396; c=relaxed/simple;
	bh=TPBmz90yWIPzk3xwAlW0IMWNrhiACBTJH786GobJbHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHlsywZ5SyJaF7NBxgOvzKEs6I6A81XSoR6iG2Hah2LC7mgBCOQMGxLc8fXr4wmapzePqa4VWPc1vDilpAKQCHWZuwTn0vNYRsyklUg0XF4RrjSEHT3Cq4rjESxv6gGw/8Qhw5GyBzjwn/b+Eg02tYKeVWG0Lqix2bSiQd4eMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US9W8N3V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so54113166b.0;
        Wed, 07 Aug 2024 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723098393; x=1723703193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dakk67C20xjrlywmpktHOBSXYaOk12CuQplEuJCCIvE=;
        b=US9W8N3VBFGuW9622CNx2omXJZibnD1k8vpUVZtKA4iSkQZL1UlLcbENcb4FqyQ0J0
         2r+uxz2RzJORaCpQXSYNelOjczW07dYN4acjxm1MWsadfROYIxezbX9zdfdtvhBkmbLi
         yPhWJR/LrToUXk3MwhQWC6yekgFc7Ey6x5/4At8wyu5RZJFjZnaINpyF20mJxZnHHtxh
         vkKE+M7ADSpxLS5CLIxLXrDRnsJ/e3zVT+SmMLhH+WHXeCwDlPs9+o2zuvcLR55193nt
         C6KzjpTALffQ7Gv/WUgElIEfU1Ce9/6OEcnxeXzmPP3P3m/lUy3zMKgcCTJhv3FjjdPV
         DwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098393; x=1723703193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dakk67C20xjrlywmpktHOBSXYaOk12CuQplEuJCCIvE=;
        b=DQYWregvbGHIDoK8dnRWxv7h7tE3js6rRdCO6hEL++qH+j7h8axr3LOKAXNlg6ObPa
         jYkBTItEceJRpzVei+b2bJkbNaQS4klsnVxWjeit79FLcjIOYCYTdjPXaLirGKx7d9Ss
         XuSu7dgkT+Dn7jVcxRifeu7xp+NKZThG6yJguH2zrTBnxt1pg4DOAegsrwYHDiT33GKQ
         XICPzQgG21Xk38q/S+3mqCA3N/2UzLhwr5dlEyKqUr6fHBGLMMX7SjnPOh+g4LesmOTz
         pMMo7kYenZu49Bhl1JaP9iLUgYCK5/K5r6EJrJhcJsWU4LMh9v2Jy9eCIbU54Ry6UjCP
         hHLA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWV3icEmBFEPyjL5t7PLq21K9jTNvA9qQoUEJJf6O2htsi+f4vgQcTgfg6tSYTZuCNQ3UUe2xFlPxhilc@vger.kernel.org, AJvYcCWbiFunocaHmBaOjQvpG5WrR1c7ndeLt0OH1pzAw7pA8sat483cnuXT3DPFibXthcIcUcToOTekyKHbR0Li@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEF1mqVvxnqLYG2PMxcClNalyIyjyCWFm4dBGqk0pqAplJSQ0
	M0xcF2onsxgMzmLdZGmzY8F+Wo0LcBKYa/FXHYdLVVipuPNDIBGk41kSSlwbLFz5nzTScUKrWi9
	KTUDHDv5St1d8HUqc5YpXoWytlVRxUg==
X-Google-Smtp-Source: AGHT+IF+St6RBJ9YRxVeG2pzYGu4pBlYPOKZhHH+liTd0RSoIdF+j+MyA/kWfSK6RxbAIlPIOU0t7fiRTlKswGPdcJc=
X-Received: by 2002:a17:907:e92:b0:a7a:b070:92c6 with SMTP id
 a640c23a62f3a-a8090e41f3bmr58294166b.50.1723098392472; Wed, 07 Aug 2024
 23:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807033820.GS5334@ZenIV> <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV> <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV> <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV> <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com> <20240807124348.GY5334@ZenIV>
In-Reply-To: <20240807124348.GY5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 8 Aug 2024 08:26:20 +0200
Message-ID: <CAGudoHE=fu2B+MNdnzOafr0Mg8D3bDmsKyMPTOZS2LeUFv53Gw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:43=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Aug 07, 2024 at 11:50:50AM +0200, Mateusz Guzik wrote:
>
> > tripping ip:
> > vfs_tmpfile+0x162/0x230:
> > fsnotify_parent at include/linux/fsnotify.h:81
> > (inlined by) fsnotify_file at include/linux/fsnotify.h:131
> > (inlined by) fsnotify_open at include/linux/fsnotify.h:401
> > (inlined by) vfs_tmpfile at fs/namei.c:3781
>
> Try this for incremental; missed the fact that finish_open() is
> used by ->tmpfile() instances, not just ->atomic_open().
>
> Al, crawling back to sleep...
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 95345a5beb3a..0536907e8e79 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3776,7 +3776,10 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>         file->f_path.dentry =3D child;
>         mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
>         error =3D dir->i_op->tmpfile(idmap, dir, file, mode);
> -       dput(child);
> +       if (file->f_mode & FMODE_OPENED)
> +               mntget(parentpath->mnt);
> +       else
> +               dput(child);
>         if (file->f_mode & FMODE_OPENED)
>                 fsnotify_open(file);
>         if (error)

That seems to have worked, but my test rig went down due to surprise
PDU maintenance (and it is still down) and I was unable to give the
patch a more serious beating.

--=20
Mateusz Guzik <mjguzik gmail.com>

