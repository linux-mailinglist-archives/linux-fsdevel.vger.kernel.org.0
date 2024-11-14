Return-Path: <linux-fsdevel+bounces-34750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA259C85E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C51FB2C829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5A1DE8A1;
	Thu, 14 Nov 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuD/pcPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADE17DFEC;
	Thu, 14 Nov 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575853; cv=none; b=kUEN4ZZlqWRXWQn7X1BtwcfjlBXxRkSS7Z/cQYxStQdiQR8rJOaewiUHPCLlwB4M/+u/bClXIKnGR5K/mbqBCnOy8x8ludE7tCN3zwFvS6K0XHcKEHAK60+ZcB2+/snc/svbSF0TymCcJQnDm0sD9Crtcj+yReNYrohKdlwCDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575853; c=relaxed/simple;
	bh=QKf6mfjMuPzIotqlNRXsRdLEIZjvJ7dhWNT5/jT13RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5z9Qjfjm08JLOipJ8ObgLnHYU3SFBN9XehVsza5agGMCvQHenIW7nh6F4XSGSxodmAwIbdXQgf4hwtiVddymS8rJsKoen3ACwuOp32A/r6jY0AE7c5/lz2qXQURKVi3a7Lt4jRCcrNyPS5b4LwZVStdawvi/fkOBJyPQSaXQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuD/pcPO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe3e99680so2059036d6.3;
        Thu, 14 Nov 2024 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731575851; x=1732180651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLmlyoSVqmQfwHvu1g2di1RxtIWYJxIW+9O9DW6h9oY=;
        b=iuD/pcPOeCUCkgW0yTr0Tka0kQtbsyrpzxPfQK+dXdLCmLGk8FV+vRAhU+odD8B6D4
         3lre7HGN2RgwzL1j6pGFuJjm3WSt58bHLu0ZBI84pnvl/qfj9J1JBlNL1MTRIvq22tGk
         jB8FxFC/t1JVc/p6nIOmIcc1Hwwl29AsNVrMpkzizWcd327T2xKdTpsjzozil/eIidop
         gqO0gtM5ZyqW5O2FbKwokzXQ4PazWTLNuZ7Uu5Xxw3JV+/swvROQC0sr4BHqDuLMcEDk
         XTjtD6zDHJgf7h/hw5tFOCwBi6OdepLe6fWUe4O6LlLnXeoy3s8oR1a0uPCHqZ2ZGKen
         I4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575851; x=1732180651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLmlyoSVqmQfwHvu1g2di1RxtIWYJxIW+9O9DW6h9oY=;
        b=wZPJgNQiIStq3n38/i+5o2jYe33dH9CGznZlCsvZ0BGpNf08QeXWFUka+R2NkiaFsb
         ZYlWOO5FAwuMvA8atBFxDaNJTS+o2XYYcYaxOsD74cyGIVdjzQKYKtYzWjBSwUOveYLB
         +s+l93peKYBOTgdo2HOEr0mVRdB/tfwD5FFfTsOx7GtqaN/XuQQfD3zr52Hvg57oKP3G
         7dWRWAdb48MvcJtiBMwDiAdrHURuJ3//97Sg0psV7sAWpZk+Gv/C/qT6VOYnFIztnDLl
         6iJlCs+/v8DUfx3LOGd7KlR2Uus6Q+8I1m3gVBthA2ZeulqiTawNTcGuFWZFBOxNefaM
         TLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXBhno/OxQDzf4gUDvfLYB68GUCmFjQ/NppheB3AbwX8NEd9Tf2a0anyRsZHaljM53DrZz3akTMac6Yhp/g@vger.kernel.org, AJvYcCXI/UhZntqlxe/YHjj7c66jLKuXtliMn6OWZqfEldP562zZt83k5l/3VjFyyTBxWtEvJzSfBGPa8DJrH0Su@vger.kernel.org, AJvYcCXtm2R4lPbkIq6dN4kW20NfCy7lSnFzDqvTzKdND6Lgj35p/0/l4CkUqgyBAL/7p4NX+Wo7TVp+BdbMBrp/NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik6eRxkGXzhyyn8zzASm9fm7/y4UeENzOWm/n6cb+/+tTfHp2
	kOOBqRoNKP9s8drP7HpMNDmckNyZ25Xr9//C5BNdDaasYfstwvD5Ob9g0Ta+Uqu3NmsaYu6JUrU
	3AqMIKzP5+yR1tk0KCJgDDyrNp+0=
X-Google-Smtp-Source: AGHT+IFyty86XtBTOhDABYTfg53ztFDdwKsXvk0PjnfyehyVO/9LIAsDM67BtjEotZlCXaAyCKvFTZW8bQGJZaPBy0o=
X-Received: by 2002:a05:6214:4b07:b0:6cc:c2:81d5 with SMTP id
 6a1803df08f44-6d39e18004cmr309143446d6.15.1731575851157; Thu, 14 Nov 2024
 01:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com> <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
 <87ldxnrkxw.fsf@intel.com> <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
In-Reply-To: <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 10:17:19 +0100
Message-ID: <CAOQ4uxgk-EFsc_35vrhkZCmyEYfbOPm=RRdMcC_dZAyjUfnSAg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Nov 13, 2024 at 8:30=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> > > <vinicius.gomes@intel.com> wrote:
> >
> > [...]
> >
> > >
> > > Vinicius,
> > >
> > > While testing fanotify with LTP tests (some are using overlayfs),
> > > kmemleak consistently reports the problems below.
> > >
> > > Can you see the bug, because I don't see it.
> > > Maybe it is a false positive...
> >
> > Hm, if the leak wasn't there before and we didn't touch anything relate=
d to
> > prepare_creds(), I think that points to the leak being real.
> >
> > But I see your point, still not seeing it.
> >
> > This code should be equivalent to the code we have now (just boot
> > tested):
> >
> > ----
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 136a2c7fb9e5..7ebc2fd3097a 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dentry =
*dentry, struct inode *inode,
> >          * We must be called with creator creds already, otherwise we r=
isk
> >          * leaking creds.
> >          */
> > -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentr=
y->d_sb));
> > -       put_cred(override_cred);
> > +       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_creds=
(dentry->d_sb));
> >
> >         return 0;
> >  }
> > ----
> >
> > Does it change anything? (I wouldn't think so, just to try something)
>
> No, but I think this does:
>
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -576,7 +576,8 @@ static int ovl_setup_cred_for_create(struct dentry
> *dentry, struct inode *inode,
>          * We must be called with creator creds already, otherwise we ris=
k
>          * leaking creds.
>          */
> -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentry-=
>d_sb));
> +       old_cred =3D override_creds(override_cred);
> +       WARN_ON_ONCE(old_cred !=3D ovl_creds(dentry->d_sb));
>         put_cred(override_cred);
>
>         return 0;
>
> Compiler optimized out override_creds(override_cred)? :-/

Nope, this voodoo did not help either.

>
> However, this is not enough.
>
> Dropping the ref of the new creds is going to drop the refcount to zero,
> so that is incorrect, we need to return the reference to the new creds
> explicitly to the callers. I will send a patch.

And neither did this.
The suspect memleak is still reported.

Any other ideas?

Thanks,
Amir.

