Return-Path: <linux-fsdevel+bounces-41608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7BA32EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E76E1888F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80F25EF88;
	Wed, 12 Feb 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu4I6prt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A411F76A5;
	Wed, 12 Feb 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386101; cv=none; b=n902lAVy6ssbToq+YWNkSga1yzem3wHUpuN4fvg0FJ7hvxvFaVYWIouQW8KeyvV6X+39CxcNO3K9qZ3dkvHNb/WyVCNgGDiAEjY2/29l2NWIWoxbWPOeDWeMSPh0CuXDH5u2D/FFvj5ZzLM5MxBSb7H8QCrC6ZpSRAtJh0I7nZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386101; c=relaxed/simple;
	bh=Eqpyg4hmNu9ocUQzEcAGhdpaBhKdg5oflZSaKCbqwL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsEK6N/LYl/SKaZhslMCBNHbxafUzAcxTicsIX5Ez896GJyWNyq4vr5MGpRXR/kb7yrAhV6IcJNC9xaT3+AHyl84O2dLuAMKyJsq5uxDcw79DSwEO/Vcju3+wJWf6ntlK4IDvrC5ZArpCjfRry/7sYzf2G4eok0slG+v209j694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu4I6prt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471b049e273so11532051cf.2;
        Wed, 12 Feb 2025 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739386099; x=1739990899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZASkp6PCL8/WlHtTvN4bXlrF7OXxOuY1zeD3mdzMNtA=;
        b=Vu4I6prtsL2jiHUbmtrD4s7CRlYY9LnQ5QkY6ze8Hv/+NmBH3P1R9lnNH5o++Ozdsu
         WuKTxHBO2GQXvC5Ax+KkvjPKZwsOPGi2UvuqeJzOvrTpjB8F55n/LS7iyGTD70gLAG78
         H+NY2wy5rKuXwszdaqnZtD9IwN9k1QdDlt1e410pmXGGP8XjZLVpG0eOw8998beMZ1ya
         t91Fh07mlqCHt+ucxUP9flSsurTx5OtBb0kNMXWS3WmDNwRfPbevL+YP7Qa4KbkYQeaD
         UnTkCkGOGqg1eHJ0IEPb9T6rOLxkKR2XUx1kUlfJakYQNVcPHvhM4O1DSbJAB3FbvqwQ
         XqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386099; x=1739990899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZASkp6PCL8/WlHtTvN4bXlrF7OXxOuY1zeD3mdzMNtA=;
        b=E9rE6iZZeQkS9c+5WfamHEmu9V5UOenYHtb1iGj/rmN5SNzk4sHzTLQA3SHY0wnCFW
         J2sorZ5VjROVfR00bhzzSYlTwJzP5smOBEZhoUa582iyJzryq+iBmGoyNxTIMr2JknYb
         rA/pbfZ10NIG6swn1updHtYqt7wNtHYJzx7WLPPvNJTitIHaFJwL0KP4+tzj7BDJGwTx
         FCh7UcBqnRDSzVudbvRmCMpsrcRmHiAWEwltDp3YCIKaYfSJCwVIj1Ul5bBhDpIyCalX
         kXyqV8K1ZcCiLW6kr4ssXG9YIyjoSQQuMltas4bWEJ1oWCpbjdSEc+ys451banPCKrfC
         8TNw==
X-Forwarded-Encrypted: i=1; AJvYcCWDjE+h02o0/gQ/2FDTJz9wlgz99PYad7eJVbWqYAjmmUIBSuLGWWp+1hE198L5g7j0f63m46WEBvOojawI@vger.kernel.org, AJvYcCWb5cfOL5VHo2aQdPeQg/utc91MX7OAJGrlst2KxB44AfCduc1mUi8SsHMoVGB3FClXJWDnL+0snw7iDARg@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMVCYv9WmIJ14TnXj8vywG0By0LdxcSqGnNxvYYIDzj9lxyqY
	yPgFPYRlU6b9kjvwy6biiHzu61bmWdjFhOQp2lUw0Nd3V+vScB57DEf2uPjg2P8O2grhwY3q/0+
	dbArp9HGXrTfGOEPWWj0vw0kICaENWMwJM9o=
X-Gm-Gg: ASbGncu0q2JMfIrOvteKbk8S9JnGNNt+Mltq8wlIBNA8HHOIpRd/aWBUEjlhaTRgOWl
	KAYul5aV8hKCA0Om1BksQUWr3Il4xqBKSbA6N+jZofTd5y+6mkPp8tawnUovhWRZhR4V27JAqY9
	1zG1bx4hX93FI=
X-Google-Smtp-Source: AGHT+IFlFkV7aYZs2utz/iZsBLLt0+a7zY/YwhAWQu45D2zt1uVzJM7iX/axNKQZ5Z6o1mUaT0iyZJqMYKvLu5Nm+Nc=
X-Received: by 2002:ac8:5a0c:0:b0:461:646c:b8fc with SMTP id
 d75a77b69052e-471afe505d8mr65715981cf.23.1739386098867; Wed, 12 Feb 2025
 10:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz> <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz> <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org> <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 12 Feb 2025 10:48:07 -0800
X-Gm-Features: AWEUYZk-0djWTKrtRmi8VrGFoz0pLfNoKipNM8dCPw51QEUcZp_d7Q09JdxuGyQ
Message-ID: <CAJnrk1YB5c+wO0U=7aOiWAMaMwQCKUL1-FuvuPMjnB_gnjD28w@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel <christian@heusel.eu>, 
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 7:46=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Sat, Feb 8, 2025 at 2:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > > > Thanks, Josef. I guess we can at least try to confirm we're on the =
right track.
> > > > Can anyone affected see if this (only compile tested) patch fixes t=
he issue?
> > > > Created on top of 6.13.1.
> > >
> > > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> > > Mantas's instructions for Obfuscate. I was able to trigger the crash
> > > on a clean build and then with this patch, I'm not seeing the crash
> > > anymore.
> >
> > Since this patch fixes the bug, we're looking for one call to folio_put=
()
> > too many.  Is it possibly in fuse_try_move_page()?  In particular, this
> > one:
> >
> >         /* Drop ref for ap->pages[] array */
> >         folio_put(oldfolio);
> >
> > I don't know fuse very well.  Maybe this isn't it.
>
> Yeah, this looks it to me. We don't grab a folio reference for the
> ap->pages[] array for readahead and it tracks with Mantas's
> fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
> I tested it yesterday:
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d92a5479998..172cab8e2caf 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> *fm, struct fuse_args *args,
>                 fuse_invalidate_atime(inode);
>         }
>
> -       for (i =3D 0; i < ap->num_folios; i++)
> +       for (i =3D 0; i < ap->num_folios; i++) {
>                 folio_end_read(ap->folios[i], !err);
> +               folio_put(ap->folios[i]);
> +       }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
>
> @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_control=
 *rac)
>
>                 while (ap->num_folios < cur_pages) {
>                         folio =3D readahead_folio(rac);
> +                       folio_get(folio);
>                         ap->folios[ap->num_folios] =3D folio;
>                         ap->descs[ap->num_folios].length =3D folio_size(f=
olio);
>                         ap->num_folios++;
>
>
> I reran it just now with a printk by that ref drop in
> fuse_try_move_page() and I'm indeed seeing that path get hit.
>
> Not sure why fstests didn't pick this up though since splice is
> enabled by default in passthrough_hp, i'll look into this next week.

This wasn't hit in fstests because passthrough_hp doesn't set
SPLICE_F_MOVE. After adding that, I was able to trigger this crash by
running generic/075. I'll send out a libfuse pr for this

