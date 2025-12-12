Return-Path: <linux-fsdevel+bounces-71220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9544CB9F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 23:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B1D73016CAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E32D839B;
	Fri, 12 Dec 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYk3CjK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C407221F0A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579161; cv=none; b=lRmDrZTfTpnWOI2JbMiqadeUPbGjL1rsT0FxviCeHYQgX0BuLzwKCOZRfZQrScR/OtDDJ2DMd2YpIm2wgVwgc9SliGNmTmO6TiP6xGAZ9zOqFTfvTZ3Kku3w5RxrJngAt7XtagGD3pw06kHtB4AyeubsEl25VumN4z9nkMbgZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579161; c=relaxed/simple;
	bh=n20JYF6/eBwYGZn/N97nVpFuSiTvw1/kmetrbgEWG2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNGIp3Afbvdq6eoRooYcuOIZrDd3dohxI8Laq1H+jmSzhZB5agyd1RkyPIFUxCa4DLHrmwqrc7YQef2W1+lpfVjq/QZ+xND/5vPu3eLcZcAto9UrHEy0bOJXS1JHIRzDftJbhk9UyzJlH4143VDxF2njx864zsIN7u47fDpIIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYk3CjK7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6496a094ae1so2519986a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579157; x=1766183957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zqI8BUSeQJJzwWOoIp2WbVZfrDCzoVl0j8b0A0wB0U=;
        b=gYk3CjK70d7fpQY9cikQPh148auxBmiCRfCZeWX+8wwWEjCJ89s+AQbEit5Ejo9rHH
         ibCliR6kW6hMhBDg9MojRjy4HfZFeARrbHce3d8tAqmwo9SqPjx96pGIJkzUmFPKiTQw
         Bm+OayShyTO86kX3GuvDm4Zw8fqAXkNlgsP2ss6qTOzExHUifkCpuFjKUu1g2VbSdW+a
         tQbDKTKec1v2qWc0l2SymjSK/R/3HgIwh28cZ6CdN94HCr2qKy0rPQkLhcNF3ZRlJC0o
         Q9Ryk+BsbBba0/CTcsMdciYccOQpIFZRGaWXDLYQr6EaQ/JXSUtqLGsD7zKGidKHywkz
         ngzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579157; x=1766183957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zqI8BUSeQJJzwWOoIp2WbVZfrDCzoVl0j8b0A0wB0U=;
        b=BnOrWMt2fH/+8AIdRGxU846a43GLXiTP45iYiuUsCdQPjD9lzwg/AcrJlKNDL/DaSp
         nIotHpeCyIs4RLzDWz2HnCrjJZXLRrtJLCrswdaqewB8tNw4Qj7TmNDz/ac1j7ChHlk8
         TjcWqe7gEYpba4wYfq93xf8CD+yNN/anKSiO8fEbo9IgPIOudEkE+LPHwCafWUodV98Q
         8OteBt6QOJ8fmcMK+jplqFCGaVTYGhJmZJVpmnoyD+sQFrPpvQDtG2CWv1j1V3OcK9Jf
         pEmydGIHGGhk9gI7l3wY7cyGmwkXNF4E3FUlBMzvZgzwPOj0erjohIwdbTYmQ83pBOUB
         NOLw==
X-Forwarded-Encrypted: i=1; AJvYcCWGHkdW6T9aMvu2LXmG3QGRWJ08W5ky2RphQAzy/6V8VAy56F+BtXOPaNjVeToNl9AHXA7WVTjhnM8O8Fo9@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtCgUrAObfRw0TWveNsjVGGgYVlCyUcCXm/nlvh4DZuD58y9F
	9tNA75MbLPKM+1vsCRklw2XX9mHcT3/3VUEquRWQrz633bLxVa0QTO9hJ8X/L7RDwn/094TNMHT
	qFdCYAjPL4l2nIf0+2MKDLm1kIrUQ8W4=
X-Gm-Gg: AY/fxX5WfgqiqblIpRbuHdP2rmw8rk2i9xGXNXAGiEUWShsF114J4acFP1LrOKr0jhD
	ZZhEZyPZU9LkELKW6R3uLPShRwbctk9rRlKVcRP0bfmRop3tvniVMbopmLlDjG1B25ewF/gHJkG
	nc+FahJrXvdcPUrbUuxqD0QEfi/9jwTceqRgj9z75Y51jtk7FRH3jJi7dSzUscokRO72H6lyq/p
	VE1+v4AooeWfatbBQxwLIZDqrPIOWuOjxWNvaxwn6YTat/NZs/Dz9JcrjTHCVvU4gfEnzvXriKo
	LvOd7snyV29bOIk8D5DasnbY3Pk=
X-Google-Smtp-Source: AGHT+IHf3hz+LEO8Sw7KXgIgtpuuOpp1C/H3lXUAnTAbT1wSmOUIJCS9Q2Np1hptQYvCrpVnl0e1Odht3v1OzKVVUNE=
X-Received: by 2002:a17:907:6eac:b0:b73:9792:918b with SMTP id
 a640c23a62f3a-b7d236b50bamr403806266b.27.1765579157222; Fri, 12 Dec 2025
 14:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212121119.1577170-1-mjguzik@gmail.com> <daf45c76-65e3-4db7-8b2f-a1fe0dee98ab@meta.com>
In-Reply-To: <daf45c76-65e3-4db7-8b2f-a1fe0dee98ab@meta.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 12 Dec 2025 23:39:05 +0100
X-Gm-Features: AQt7F2rqlqJYuiTXrlRBX0uj3Izh_nxTpKyy2bSAjurhEgmOjv2s9v1rFUYjYF8
Message-ID: <CAGudoHH=c7OMBXXtsJzytGiE9stcGpsXGdX4g_9yWQDLB-Wv+Q@mail.gmail.com>
Subject: Re: [PATCH] fs: make sure to fail try_to_unlazy() and try_to_unlazy()
 for LOOKUP_CACHED
To: Chris Mason <clm@meta.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:26=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> On 12/12/25 7:11 AM, Mateusz Guzik wrote:
> > Otherwise the slowpath can be taken by the caller, defeating the flag.
> >
> > This regressed after calls to legitimize_links() started being
> > conditionally elided and stems from the routine always failing
> > after seeing the flag, regardless if there were any links.
> >
> > In order to address both the bug and the weird semantics make it illega=
l
> > to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> > the two callsites.
> >
> > While here another tiny tidyp: ->depth =3D 0 can be moved into
> > drop_links().
> >
> AI flagged that last ->depth =3D 0 in drop_links().  I made it list
> out the ways it thinks this can happen to make it easier to
> call BS if it's wrong, but I think you can judge this a lot faster
> than me:
>
> > diff --git a/fs/namei.c b/fs/namei.c
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -774,6 +774,7 @@ static void drop_links(struct nameidata *nd)
> >               do_delayed_call(&last->done);
> >               clear_delayed_call(&last->done);
> >       }
> > +     nd->depth =3D 0;
> >  }
> >
> >  static void leave_rcu(struct nameidata *nd)
> > @@ -799,7 +800,7 @@ static void terminate_walk(struct nameidata *nd)
> >       } else {
> >               leave_rcu(nd);
> >       }
> > -     nd->depth =3D 0;
> > +     VFS_BUG_ON(nd->depth);
> >       nd->path.mnt =3D NULL;
> >       nd->path.dentry =3D NULL;
> >  }
>
> Moving nd->depth =3D 0 into drop_links() appears to break terminate_walk(=
)
> in non-RCU mode. The function reads:
>
>     static void terminate_walk(struct nameidata *nd)
>     {
>         if (unlikely(nd->depth))
>             drop_links(nd);              // <-- now sets nd->depth =3D 0
>         if (!(nd->flags & LOOKUP_RCU)) {
>             int i;
>             path_put(&nd->path);
>             for (i =3D 0; i < nd->depth; i++)   // <-- nd->depth is 0 her=
e
>                 path_put(&nd->stack[i].link); // <-- loop never executes
>             ...
>         }
>         ...
>     }
>
> When terminate_walk() is called in non-RCU mode with nd->depth > 0 (after
> following symlinks), the path_put() loop for nd->stack[i].link will run
> zero iterations because drop_links() has already zeroed nd->depth. Can
> this leak references on the symlink paths stored in nd->stack[]?
>
> Concrete paths where this can occur:
>
> 1. Retry after RCU-walk failure (non-RCU from the start):
>
>    filename_lookup()
>      -> path_lookupat(&nd, flags | LOOKUP_RCU, path)
>      -> returns -ECHILD
>      -> path_lookupat(&nd, flags, path)   // retry WITHOUT LOOKUP_RCU
>          -> path_init() in non-RCU mode
>          -> link_path_walk() follows symlinks
>              -> pick_link() calls mntget() and increments nd->depth
>          -> terminate_walk()              // nd->depth > 0, refs held
>
> 2. Mid-walk transition via try_to_unlazy():
>
>    path_lookupat() in RCU mode
>      -> link_path_walk() follows symlinks, nd->depth > 0
>          -> pick_link()
>              -> atime_needs_update() returns true
>              -> try_to_unlazy()
>                  -> legitimize_links() takes refs on nd->stack[].link
>                  -> leave_rcu() clears LOOKUP_RCU
>      -> error occurs later
>      -> terminate_walk()                  // nd->depth > 0, refs held
>
> 3. Transition via complete_walk():
>
>    path_lookupat() in RCU mode
>      -> link_path_walk() follows symlinks, nd->depth > 0
>      -> complete_walk()
>          -> try_to_unlazy()
>              -> legitimize_links() takes refs
>              -> leave_rcu()
>      -> later check fails (e.g., -ENOTDIR)
>      -> terminate_walk()                  // nd->depth > 0, refs held
>
> In all these paths, nd->stack[i].link holds references that should be
> released by the path_put() loop in terminate_walk(), but the loop runs
> zero iterations because drop_links() has already zeroed nd->depth.
>
> [ ... ]
>
> -chris

Quite verbose. :)

I thought I patched all of these.

But ye, the value needs to get read prior.

Again weird semantics, why is any work on symlink stack being done
after drop_links got called.

What this really wants is some form of variable poisoning so that
instead of zeroing depth I mark it as indeterminate and have kasan
trap on access.

Will send a v2 later, thanks.

