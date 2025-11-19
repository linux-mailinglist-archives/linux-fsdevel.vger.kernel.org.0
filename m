Return-Path: <linux-fsdevel+bounces-69140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E417FC70E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30425348794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E6371DFA;
	Wed, 19 Nov 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUZcMERa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3603559EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581793; cv=none; b=pSP8hpiGdZfXIseXAElHVCxWUFx0xmDcrGyT/ZRRtwdu99OPUseHDeyeTjM26p7sftg0qsrM5Rt9bqAJ4uWoyjbrX7YzfPeeTALa3gKXUdgMJfCvHiLz+xJQsEsJiXmxrILhm6+XqiGFTcGMj9GltoUvO+nkELgGdCxw2YLEkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581793; c=relaxed/simple;
	bh=xbMyJ5hdJOaVlfHnXPGF4ptkHenN0CGYBIN+v2/lxa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqQcCSXoqnsWCQQBUH6GRTlZnL5t/ndgLm/Qlh7dVy2Ykrn/5G5ktui9wvf8zs/+lF/UcFmfK1YR0UCWa78N5GkKaNrlWCsm9sX1HZ14suvEl6qWmIOo8vdR4fP1EpiPu0l40AdXchzs2LfvHx7dwxrWDtoL1q0fEZkJP4lww7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUZcMERa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso110521a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 11:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763581789; x=1764186589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09/V0EDP3O3vqf2l1/Yu/5a9xvVwUQqDa70Jf0vTetA=;
        b=YUZcMERaggSn/8WqEfmgfM9WcYWdEfEUD0ekNw2SIf34PCIE3otxN67SBkOG42KQN+
         rhlK10fKciWqDvwlGiCUDYD2E1YMkSrDqMhs9JXG+MAnXN8c1j4lpvWJ1skUuYoP2nPv
         KdG4ro0XQ+6x9sxP4B5+FmNCPQ1C/p0iOPMIxN5IJwRB1evVkpwZPQ+WHDxWlPPC3jbL
         x1SuE/yQdNxF90GZSsntkoUPN/wbNs5W/rfM1u9zl2vmwECHoqQSHh6tzw7AxC+5VX/c
         hRphdzBWDXAgIzc1y9cThVDVSCd+rmRR+q8Va0XpUChjM4QIzYsLyYIqF6trhJ0Vaqpt
         MjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581789; x=1764186589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09/V0EDP3O3vqf2l1/Yu/5a9xvVwUQqDa70Jf0vTetA=;
        b=K1QWoMSLdgSzBoo0VqMU7zosltIdk6tLi7lZmS2PtqIeJYg9JKJrkohl59J+oQ5lvK
         ZR2Kpz7i5vAWjX3cd2hj6vPOHyp3jQCccpcpPua9MxuQBgLCetOZFwe85D2RHj3LDxzK
         OQrfXTcWA2LeTNQjFR1/qgjel8coRxw7aSoQ1l7npxfUMeeMU4wx+MLgyZLF0ELzz1aZ
         yKdRdO3SC+LkV2EYXTUef+Q+Y4vfGiRPzyPqqpi0JlXJT6XC7qjC4PtCA16W0jeFqIZa
         idwG4ICNWPjovcMJsX4qYHptXwNuYT6xbcwdZs3nm0tUSKmjt6abXn8BUBu3PA8mHTMB
         q5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SfrQhhtIUvamYSOHFd/bEEkWy0O8rqBwgizIrcBaCkcEsXngMWu54Xwt57gdPEuqROFj8CL+GjlCubMz@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3JWrrB3IVrKz5Gvmomrz6NyVy0QN6nCjXMOmbpxI7Fccnz6j
	/L2HT1dLDj+XZU16cAy3JNJSn81yLeJmHXKTMvouFQtdwzcJjq381dd0Of0BPlRGglODopjJ1mK
	TGp3MNRROu7+CLtT0Wzy0r/Vh/5DWBTi3Y2pP
X-Gm-Gg: ASbGncsxtB6Gtk+pBC1nAC2Oqmi5ydbCPe8OwfIzFX9o4kvCPR0jhMgyJIy2njraM8Z
	pjJaPWNhbE1FBydPlCj7gFb9LVVsmKK+G0GwYpsAJFmqyZcKRRqKrprXcIQcAPi/2Zvga4QaWW9
	tbYKDi/grt2h/WxxAicy/12TDgsoIuvQ25pz+XcV0Hkl7TlzyazgpLjE8CrU0O9sLH34ITkAJZ6
	OiB4U6axMxGWeMv0rG+GZdOgordE3lsaVa1+p2L2zOJsuD//GB1goBfWHDpbHPR6O43HlNrtXkd
	IbrfxdizItimJqs5NpePzPTBewVSswVhSpWW
X-Google-Smtp-Source: AGHT+IGAsNQ5gQef4mcEmprCr4ymZjPEUEnqCqEntbqtBbVanPWtYPynVQwYnsgER+H4CfzFBIYtHUED0Ew3kRVTDEc=
X-Received: by 2002:a05:6402:146a:b0:641:1f6c:bccf with SMTP id
 4fb4d7f45d1cf-6453643d17bmr501148a12.16.1763581788562; Wed, 19 Nov 2025
 11:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184001.2942865-1-mjguzik@gmail.com> <20251119194210.GO2441659@ZenIV>
In-Reply-To: <20251119194210.GO2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Nov 2025 20:49:36 +0100
X-Gm-Features: AWmQ_bkETBvI-QGfJXg7HNqKvV3Ip-kLDk6t6xTuCZ7vfcs1oenn2aawv35UCvs
Message-ID: <CAGudoHHroVs1pNe575f7wNDKm_+ZVvK3tJhOhk_+5ZgYjFkxCA@mail.gmail.com>
Subject: Re: [PATCH] fs: inline step_into() and walk_component()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:42=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Nov 19, 2025 at 07:40:01PM +0100, Mateusz Guzik wrote:
>
> > -static const char *pick_link(struct nameidata *nd, struct path *link,
> > +static noinline const char *pick_link(struct nameidata *nd, struct pat=
h *link,
> >                    struct inode *inode, int flags)
> >  {
> >       struct saved *last;
> >       const char *res;
> > -     int error =3D reserve_stack(nd, link);
> > +     int error;
> > +
> > +     if (nd->flags & LOOKUP_RCU) {
> > +             /* make sure that d_is_symlink above matches inode */
>
> Where would that "above" be?  Have some pity on the readers...
>

this is just copy pasted from the original, i'll patch it

> > +static __always_inline const char *step_into(struct nameidata *nd, int=
 flags,
> > +                  struct dentry *dentry)
> > +{
> > +     struct path path;
> > +     struct inode *inode;
> > +
> > +     path.mnt =3D nd->path.mnt;
> > +     path.dentry =3D dentry;
> > +     if (!(nd->flags & LOOKUP_RCU))
> > +             goto slowpath;
> > +     if (unlikely(dentry->d_flags & DCACHE_MANAGED_DENTRY))
> > +             goto slowpath;
> > +     inode =3D path.dentry->d_inode;
> > +     if (unlikely(d_is_symlink(path.dentry)))
> > +             goto slowpath;
> > +     if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
> > +             return ERR_PTR(-ECHILD);
> > +     if (unlikely(!inode))
> > +             return ERR_PTR(-ENOENT);
> > +     nd->path =3D path;
> > +     nd->inode =3D inode;
> > +     nd->seq =3D nd->next_seq;
> > +     return NULL;
> > +slowpath:
> > +     return step_into_slowpath(nd, flags, dentry);
> > +}
>
> Is there any point keeping that struct path here?  Hell, what's wrong
> with
>
> static __always_inline const char *step_into(struct nameidata *nd, int fl=
ags,
>                      struct dentry *dentry)
> {
>         if (likely((nd->flags & LOOKUP_RCU) &&
>             !(dentry->d_flags & DCACHE_MANAGED_DENTRY) &&
>             !d_is_symlink(dentry))) {
>                 // Simple case: no messing with refcounts and
>                 // neither a symlink nor mountpoint.
>                 struct inode *inode =3D dentry->d_inode;
>
>                 if (read_seqcount_retry(&dentry->d_seq, nd->next_seq))
>                         return ERR_PTR(-ECHILD);
>                 if (unlikely(!inode))
>                         return ERR_PTR(-ENOENT);
>                 nd->path.dentry =3D dentry;
>                 nd->inode =3D inode;
>                 nd->seq =3D nd->next_seq;
>                 return NULL;
>         }
>         return step_into_slowpath(nd, flags, dentry);
> }
>
> for that matter?

this keeps the style of the current step_into, which I can stick with

The gotos, while uglier, imo provide easier handling should one try to
mess with the checks, but I'm not going to die on that hill.

btw, is there a way to combine DCACHE_MANAGED_DENTRY + symlink check
into one branch? The compiler refuses at the moment due to type being
a bitfield. Given how few free flags are remaining this is quite a
bummer.

