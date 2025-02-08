Return-Path: <linux-fsdevel+bounces-41286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CCA2D703
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C17E3A7EA2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D724817A;
	Sat,  8 Feb 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO8KAAfB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FB14A4F9;
	Sat,  8 Feb 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029622; cv=none; b=V3YVTaXC8k9wVd46ZY97RHtKhgA9mH+2SaKKhVfga2YNExVMP2yH+EkWDXMefD5ex4E/qj6cFUSfg3f7qNR9+1/YIWcXigzpql6e6i2ezBVg4LlcRdgjfIQFyvmvklBUw2qERiEGE31+kQf5SDKyieq140mngEW+aNGt0o9JXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029622; c=relaxed/simple;
	bh=5oF7U/lMdQNsEhvFQBmWFeeAK8Ia/CG64J+TV4m7MlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAnF/mSBQ8MlthbJ/+MjjxBWJPEKPlgmvyZW9Amdiadnur3QOjQHhsecu62ixNfJahyRe9fc4en/S/V2Md3zaM925nP+5uZWP8+v4axLAByuRakZTEU1mBbJm4tDi/lE9elGu6xi/KrmsngQlHyUrF3u4099MWheVit3ZgOlb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO8KAAfB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a3f1e667so18951431cf.0;
        Sat, 08 Feb 2025 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739029620; x=1739634420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fOnrK9Ez1FxS3AJL66DzUp4872IstaGG4vVRCtFBhM=;
        b=fO8KAAfB4VUNbRi6ZqMJqUK9R5AZ8n16OJnkk3DwcTrz2vflwAPfuF+N6ncW1ztBh/
         tEK9AXhWphrc+GypS1VTwo7Tl9JLkgoH5bcvOdqes3A1ccCp8IoMTIzZpN/Vvw83SqPR
         fdhSpgrPfDj0Qu788NsLkEAnVlQF+9PXMrzCQhftnStAZQJqoiQrrnN3LCl4Q0Vm4Dmh
         HlWlB/avFB7SuzU7/XJGQZQDkWYN8gV0Hk+fN9EhMocqSlMI1tZ49VW9mZq0ZbnAkdSD
         itnDAKN5V1eAAfj/41PAvJhBm5rkEx/Oo6B7bHUXUJFlzeu9chlgHwxav/GEPoe5/D/0
         RZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739029620; x=1739634420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fOnrK9Ez1FxS3AJL66DzUp4872IstaGG4vVRCtFBhM=;
        b=JgeYMaj8bUnoEuBeqpji9Fp80MBYVe/7oJv1gPZkDMq/TkbErTAq8+jC87ab+R9oet
         sbtBd0znB2hmBaEN5e2tSLYRn6lFG+MXWDL2KJ2WvIoCuqJLnNjiVhhLF8xYGYcV2VA2
         AeIqI4a6d2c5wwXAW5D0L1m/ruj0eGyb02aTR6hqe7zQs9jDxcQEECWGzrQg+6N6axum
         bPvAYcXHqW7kTdP0j6bSyW2SFrp0t+LTm174FfTUZLqoxpUWflVzsXVt5v7kHa/d1vrl
         R0u6+Ib9dYaPtXyOb4ZMEE05ZMlXwRVXA571ZrA7Bu12Uijm6Cn/0b3XU/V0rZDXZcLe
         1d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVne7mVM3kIdNlRXSL94oJddXhb0Pg5SBviOBCwiJkWtjFUJWH1joZtZFK0NWYusw7VxIwEFLDq5Rj8FLik@vger.kernel.org, AJvYcCXiItLcC+cDI4aZ5852D36VVEoJWkZHek4hn3chothejnTgvydNBABiboLTL4ZdGLczvY9TBvnytGLXX9Fv@vger.kernel.org
X-Gm-Message-State: AOJu0YzNA4lWWnheTcn1+9wjHR+t5gL5oY3OuWLKvl3La5CGEyAj1vyi
	lr/ab2TdR86k54XjnPo/HPXVC7c08iwcZOEA7ACyiHiz8p6uLpa+iS+iNhBqm0w5IphvyXwWLBF
	sV0FRwZcabkMzsUJaStJv5ZGpmDg=
X-Gm-Gg: ASbGncusuQUBEUhDFaikdgabKRjAhnK8gQBntBANTE3LC2SfnHrB5LPT98XKcS2bHxD
	Y4PI9bkiEytf/QrRbvvn73TJNRgK/SoAYL70WfVvmcpatfWKV9J9/iGTyPYekds1S0Oc7ZUdoNw
	==
X-Google-Smtp-Source: AGHT+IFSh4Mb6rl+oRG62Z0H13C2MR3PfJXfuPqUV/E9DdliMmk9tvl6Kyi3LNNOMS6rezVnMSgNza0FH6hi6ihzvh0=
X-Received: by 2002:a05:622a:107:b0:467:706f:14b7 with SMTP id
 d75a77b69052e-47167a5327dmr98645921cf.30.1739029619751; Sat, 08 Feb 2025
 07:46:59 -0800 (PST)
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
 <Z6ct4bEdeZwmksxS@casper.infradead.org>
In-Reply-To: <Z6ct4bEdeZwmksxS@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Sat, 8 Feb 2025 07:46:48 -0800
X-Gm-Features: AWEUYZlmX7UqjYolQF--Dd82_LLes-B_HkoK5EPAEx4gxpTBKL3nR7nmvwna1lU
Message-ID: <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
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

On Sat, Feb 8, 2025 at 2:11=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> > > Thanks, Josef. I guess we can at least try to confirm we're on the ri=
ght track.
> > > Can anyone affected see if this (only compile tested) patch fixes the=
 issue?
> > > Created on top of 6.13.1.
> >
> > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> > Mantas's instructions for Obfuscate. I was able to trigger the crash
> > on a clean build and then with this patch, I'm not seeing the crash
> > anymore.
>
> Since this patch fixes the bug, we're looking for one call to folio_put()
> too many.  Is it possibly in fuse_try_move_page()?  In particular, this
> one:
>
>         /* Drop ref for ap->pages[] array */
>         folio_put(oldfolio);
>
> I don't know fuse very well.  Maybe this isn't it.

Yeah, this looks it to me. We don't grab a folio reference for the
ap->pages[] array for readahead and it tracks with Mantas's
fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
I tested it yesterday:

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a5479998..172cab8e2caf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
*fm, struct fuse_args *args,
                fuse_invalidate_atime(inode);
        }

-       for (i =3D 0; i < ap->num_folios; i++)
+       for (i =3D 0; i < ap->num_folios; i++) {
                folio_end_read(ap->folios[i], !err);
+               folio_put(ap->folios[i]);
+       }
        if (ia->ff)
                fuse_file_put(ia->ff, false);

@@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_control *=
rac)

                while (ap->num_folios < cur_pages) {
                        folio =3D readahead_folio(rac);
+                       folio_get(folio);
                        ap->folios[ap->num_folios] =3D folio;
                        ap->descs[ap->num_folios].length =3D folio_size(fol=
io);
                        ap->num_folios++;


I reran it just now with a printk by that ref drop in
fuse_try_move_page() and I'm indeed seeing that path get hit.

Not sure why fstests didn't pick this up though since splice is
enabled by default in passthrough_hp, i'll look into this next week.

