Return-Path: <linux-fsdevel+bounces-62927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31315BA5C2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9FF4C5D2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6D2D5C8B;
	Sat, 27 Sep 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUv9Viz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF51C84A1
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964396; cv=none; b=KNc7XWpnuPAYCoG++P8GRdWO1ttVZ9prg64ayhIjfqI7lRwU/bYP0uRNAz8k3Koelx84YmapcpZiM5uVUaajebUEQjHUxYF5Qf/q9Ap7DKK5Hn55KHEKUvCNYGACZ0vbIgl4VRVVQibVjv1L0z2i0DE0mFNRdrG+LPienVCDIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964396; c=relaxed/simple;
	bh=2L3LgtDx/W0YAm5oo2MvHENKPlwiYG7qOkn/JuVVeac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfdppMFcRLbOpbkV02vFRx4Z8K1eND3prRAoydv74SQ8Vkq0xieuNeeUC3Pa4BXIvhWinRyiy1uQBnW3lKlRjOeODphQbcE50sgpai6UwKf1fQKog21KdNPO1dnzJdt70dUroHaLoNQXgIlhmorul88LmbRUpdE+HzvEgzZZWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUv9Viz2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so459328566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758964392; x=1759569192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKHG9+3ANwptJbBGEXfc0maGdVViYLuQO5/Ni5PCOBw=;
        b=dUv9Viz22K2ZBf4ILW0L3KFAEvH2PLhoe2IUNQtpDcr1Ek1/e3iEY5EpYa0Wrftv+z
         T564fgKph6KHAE59+WFx8USzzgWZsMzKNuW83Nqovrp/W5tC4xCUBov+E+QUzIOZv7so
         TsINP2Aismb8nhQTxlInO3h2IHiSAJ93/sjqq4sf4XKQNzG4YhWWw+1Uriobmyq3GAV4
         gMnJbw1Zvh1GdtsyeT+QRKyt0lRymK2gZIDfJcBEB8sBufGKdpdBRjXNJYbS2blcxGTu
         iDsG6uMV+EJSsDcJ5ISiiyArN6eOKsyWUNZWk3iq6eV4pUBsfhGz2sd9Yp4YL+jrnZaq
         bz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758964392; x=1759569192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKHG9+3ANwptJbBGEXfc0maGdVViYLuQO5/Ni5PCOBw=;
        b=AlKLKUVCUPz0IrYRg2uAa3ZBD/0jNHaEozmoedrjEMLUs3fCfxohu8D1+RMRjEisOz
         RFy1b6t4inOzh/vkpFAYGZX9yiZqH6QaTzrxyUAYjXo/CzN5CdQZLoNyo4FbevlGfMNs
         cstC9DX6u0KVtiFsO5oeVxBNXt0BqbsyjX61fvMdCyKY8d95vMKEvrevcKXkKfRgi/ow
         jBnTmLRISmlHBBOIkN8U91xTEPO/KEsIAWxmz7lonDt3Km87nqxkPXtVNME4c7USkjG3
         eQYO/0BsywkYabsCRhbcX6zsAFDqMYFgHaVk+T/RSZLC/2t2AEndMyHEbpaELHHu8nEG
         78Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWC66Pt60ib0HiJZpqarvZDh613vhLo6UBaq7EEEDGnvfsKTPkUkCsOvcQ6CdOx3SmsD4FucGe/6UD7AGBl@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGYUBk0a+QXTrANjQ/SzJuY3ZUyxOwUQcbZq4K3EpYGqmS25I
	QyaSS0qNoghOXRLj5ytJ0ZMxWxv8Qj+21x+e2CF3hCl/ExvJEymkzGZgKvcIHtbPdS3lWjbV0KP
	hVdnGeXDsCLtSwX3l8VCsggqpyUnlqKMOmKS2QBo=
X-Gm-Gg: ASbGncu9jsyR6NZdjGVbpYNNUuohe7lSK7tAziNXFmjOlVlt2CCfc7g98zdLB24NMoM
	s5+qvNoEdcbMy9tTzxJaCGX0bxTZXTiRjJizqszJ44sPCzmXr2YwSifdO0GBBEJC7Q8HE5MAyEV
	yQwqRFtRdOK0mkqLeFicbkI7Sv5pVGUxwKiVhilRCLLA+wfpQeKQKmLA2BlA99bgR7GkBdMCyN3
	7pXCnG/X3OMO+cqZGloEOS6z4ndzUff23zwF0xn7Q==
X-Google-Smtp-Source: AGHT+IEauKUAezFDdV/KJjG+VcK8+IhxlFf5z7VNg0/ih9i3IQ9Sp7+Iwz9UWZ4nFoOUHOM4b2pYiqnnxgQmxQ0QqQo=
X-Received: by 2002:a17:907:72ce:b0:b04:ae68:afdf with SMTP id
 a640c23a62f3a-b34b9782c8emr1181926366b.28.1758964392415; Sat, 27 Sep 2025
 02:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-2-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-2-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Sep 2025 11:13:01 +0200
X-Gm-Features: AS18NWAVHRj0AiELd_Vh18oYwnKBYKKms3JCCRzqK7g13iy_joL6Z4en-vDLFZk
Message-ID: <CAOQ4uxgnb+JWGDo2B7yx5Jm7yPEMMkzcjSwxFMimyH-RboJeUw@mail.gmail.com>
Subject: Re: [PATCH 01/11] debugfs: rename end_creating() to debugfs_end_creating()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> By not using the generic end_creating() name here we are free to use it
> more globally for a more generic function.
> This should have been done when start_creating() was renamed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/debugfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 661a99a7dfbe..b863c8d0cbcd 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -411,7 +411,7 @@ static struct dentry *failed_creating(struct dentry *=
dentry)
>         return ERR_PTR(-ENOMEM);
>  }
>
> -static struct dentry *end_creating(struct dentry *dentry)
> +static struct dentry *debugfs_end_creating(struct dentry *dentry)
>  {
>         inode_unlock(d_inode(dentry->d_parent));
>         return dentry;
> @@ -458,7 +458,7 @@ static struct dentry *__debugfs_create_file(const cha=
r *name, umode_t mode,
>
>         d_instantiate(dentry, inode);
>         fsnotify_create(d_inode(dentry->d_parent), dentry);
> -       return end_creating(dentry);
> +       return debugfs_end_creating(dentry);
>  }
>
>  struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
> @@ -605,7 +605,7 @@ struct dentry *debugfs_create_dir(const char *name, s=
truct dentry *parent)
>         d_instantiate(dentry, inode);
>         inc_nlink(d_inode(dentry->d_parent));
>         fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
> -       return end_creating(dentry);
> +       return debugfs_end_creating(dentry);
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_dir);
>
> @@ -652,7 +652,7 @@ struct dentry *debugfs_create_automount(const char *n=
ame,
>         d_instantiate(dentry, inode);
>         inc_nlink(d_inode(dentry->d_parent));
>         fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
> -       return end_creating(dentry);
> +       return debugfs_end_creating(dentry);
>  }
>  EXPORT_SYMBOL(debugfs_create_automount);
>
> @@ -705,7 +705,7 @@ struct dentry *debugfs_create_symlink(const char *nam=
e, struct dentry *parent,
>         inode->i_op =3D &debugfs_symlink_inode_operations;
>         inode->i_link =3D link;
>         d_instantiate(dentry, inode);
> -       return end_creating(dentry);
> +       return debugfs_end_creating(dentry);
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
>
> --
> 2.50.0.107.gf914562f5916.dirty
>

