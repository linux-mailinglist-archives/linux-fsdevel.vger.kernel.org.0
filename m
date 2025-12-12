Return-Path: <linux-fsdevel+bounces-71194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D608ECB8C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513E7301EC47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B0320A00;
	Fri, 12 Dec 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUmpHMXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212331ED8B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540544; cv=none; b=d0tvlnO5fZFwYEaYvNs+7YnWfK5DQ/IWb2Vyb31ktvhf41csWdt0pO3rD0RWUepqvIJolvXPnH41cS8pdrnR+/8jTIYodlem6+CZCQySdc+w735WS3hveOwb60hK4fAb2qe/EVCd3r0WwnaQ66SDLOriOyOF0EPdgYcB5Gy2bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540544; c=relaxed/simple;
	bh=pU5j96LHCOt6a1LputoKggwOob/5HYs1D1MEBGhPW6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LN09OthLA7HItfogh359W35oKm7tubqx7xZHUMyAhK++SBfQWIpzpWmWDnshlzGJ1L2EGhFqGe++2rP7EnEvJsARR8lU6Ba3OandNYVW5UOswq9wEOBaxtQaqbfR22cxTu5P0rEE0pcTFro9zH9LeXLmphh4FBspTHrQqXapyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUmpHMXH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73a9592fb8so252738566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 03:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765540540; x=1766145340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBBZ+/iP1D6xDO/Pt/Eg6ETEUrv0lEs7/AoDiNTg5wA=;
        b=cUmpHMXH0Lkbi7J81DwCDlM/ZWyl4L9RLhIMraWS3EKxdHd3Hv/R0n9K26PzjtWvPs
         EcL6LaHFJVt4I+bOSP1NWFmXMsM+rwkg0ujZZYy3EajioDoQHlXoIHzpabGiqkWyA4/u
         diAfi9CHPSg+qqBWep5IxeFV5eiEd/LD3xkeRN3QleSqsfibHrMAoZYUalmndJ6i4vXF
         pY4U2Rm+wanZqI7qJ4S/xQqe0SWNi/IzUm01A0ex05cQUHOnMwe4T85nJa+O7WILRyLP
         zxA7P1D7I0SWIL38TMqBoZPvGh3hnW6/Wo1FKo/j4Tf0QV84hFZJyrJLnSz6tXO26gzs
         qrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765540540; x=1766145340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBBZ+/iP1D6xDO/Pt/Eg6ETEUrv0lEs7/AoDiNTg5wA=;
        b=u489Sl4xrNp9YbqA8Z36CtU+ucv4xErcpVvvd4DicZK/+K741p+Iv4DzD3iLBMFtKi
         WOhqEm6zT/WwHfBoz/nm/h6AQvfLalltAiO4RQl4nMrvPIV6MreI9Hsxwa6vZFvJywTT
         5eQT7h9OWMrHGxNwdyhMZsnQrvR9Lvo6+VH9nighOSGuY0RIQp+tY1FNMQIpMgIxYo4D
         /KnbeN2BL8z4AbBSPXK5qhmwaIZR3KmRJCDqKLgZrephaoR/9iN0Zl+E+i5U90xKbcPq
         /pwSFzyGfj/6tKkVWgZJb1He0J1DwKKmAjMYl3bDIZ97IaA3c8Dlx6Kyz6aUXXGtlX1K
         TKXg==
X-Forwarded-Encrypted: i=1; AJvYcCWE0Tckg6so6Wl38sRBZVa0gzN0lblAfgObkbsVFzpP633bz/M67WIWnw5TwxvWNiXF6kI1i+xbHoe8KPZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IB05Zpen4itFgpfeiwiGIhn6vv7M5dPSEE3XffPaswGKigZu
	qnmfAxuOocqQd0K2nIX8uxHw9dhlG6smsTBfmbZk+JAk3ejHW3q9oct6OVjxIu71jnaZ0Q/RDdi
	vfSE8ufPHrIy9QE+WYSC8EgOZuouUyW0=
X-Gm-Gg: AY/fxX6QLAqSXwyxQbsd3f+k69pWfWkC6b0HTApi63hBYc+B9JLjrLiyYrDWKG8v9Px
	QRN8e+9865ZuWCRz+kMzKas8p456UJCyJzlQ1jJi3jt48HTdwjaebcdOxaKOGn1ZF2oQoUzZldk
	SyKBXMZh6r1hAcnCgiRMooGMF7uTh7FvdONZnJ3lsWxks72RF1ZRUOlQo3b4RexXIDqhssh7FYT
	Y1CVy17dL+FieDFFspmFSTb81T5KSLIC81XXa2eXPQc0aYcc7/nhNyfh1ap25KVYiVT4eEZqsA6
	197yO475TNJC59aw5UmYtoPpxLM=
X-Google-Smtp-Source: AGHT+IEAuFsza2aEEtVI9ny/XFJ0ouAL6+vxgMMG/dQiaHrFfmNcSt2PBUUisslbWrx1+l0dmvbklQ4+ZkqTuTuMlNQ=
X-Received: by 2002:a17:907:7f9e:b0:b72:dcda:fe5a with SMTP id
 a640c23a62f3a-b7d02137051mr519204866b.5.1765540540180; Fri, 12 Dec 2025
 03:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119142954.2909394-1-mjguzik@gmail.com> <20251212012236.3231369-1-clm@meta.com>
In-Reply-To: <20251212012236.3231369-1-clm@meta.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 12 Dec 2025 12:55:28 +0100
X-Gm-Features: AQt7F2r6Gx71eHg8R6SFUgJ0ymGXM2GtvEa-Mrbkjy6ppKP1xdt9sC_i5z5OPp0
Message-ID: <CAGudoHFus8zBCmF=vS_HNQimQfTUwqUqohZ-gNzZ2T7TOfNbPw@mail.gmail.com>
Subject: Re: [PATCH v5] fs: add predicts based on nd->depth
To: Chris Mason <clm@meta.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 2:22=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On Wed, 19 Nov 2025 15:29:54 +0100 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
>
> Hi everyone,
>
> I ran some of the recent commits through the AI review prompts and it
> flagged this one.  The comments look right to me:
>
> [ ... ]
>
> > diff --git a/fs/namei.c b/fs/namei.c
> > index a5bffc2a29f6c..5fbb05fb96b75 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
>
> [ ... ]
>
> > @@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
> >
> >       BUG_ON(!(nd->flags & LOOKUP_RCU));
> >
> > -     if (unlikely(!legitimize_links(nd)))
> > +     if (unlikely(nd->depth && !legitimize_links(nd)))
> >               goto out1;
>
> When nd->depth is 0, this short-circuits and never calls legitimize_links=
().
> However, legitimize_links() contains a LOOKUP_CACHED check that was moved
> there in commit b93a6e389bdc7 ("fix handling of nd->depth on LOOKUP_CACHE=
D
> failures in try_to_unlazy*"):
>
>     static bool legitimize_links(struct nameidata *nd)
>     {
>         if (unlikely(nd->flags & LOOKUP_CACHED)) {
>             drop_links(nd);
>             nd->depth =3D 0;
>             return false;
>         }
>         ...
>     }
>
> Before that commit, the LOOKUP_CACHED check was done directly in
> try_to_unlazy() before calling legitimize_links(). It was moved into
> legitimize_links() for consolidation, not because it's semantically
> related to having links.
>
> With LOOKUP_CACHED set (used by io_uring for non-blocking opens) and
> nd->depth =3D=3D 0, try_to_unlazy() now proceeds to legitimize_path() and=
 may
> succeed, when previously it would have failed. This can cause
> lookup_fast()->try_to_unlazy() to succeed, leading the caller to call
> lookup_slow() which takes inode_lock_shared() and blocks - violating
> LOOKUP_CACHED semantics.
>
> Should the LOOKUP_CACHED check be moved back to try_to_unlazy() before
> the depth check, like:
>
>     if (unlikely(nd->flags & LOOKUP_CACHED))
>         goto out1;
>     if (unlikely(nd->depth && !legitimize_links(nd)))
>         goto out1;
>

Thanks for the report. This is indeed a bug on my end, in my defense
the current behavior is... interesting -- why would it the routine
fail when it had nothing to do?

The commit hash you referenced does not exist in master, I found this
instead: eacd9aa8cedeb412842c7b339adbaa0477fdd5ad

That said, the proposed patch does not do the trick as it fails to
clean up links if nd->depth && nd->flags & LOOKUP_CACHED. The check
however can be planted *after* if (unlikely(nd->depth &&
!legitimize_links(nd)))

This would clean up the bug but retain the weird (for me anyway)
state. Perhaps this is good enough as a fixup for the release and some
clean up is -next material

