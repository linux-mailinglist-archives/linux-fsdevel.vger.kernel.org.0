Return-Path: <linux-fsdevel+bounces-68769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 483D3C65C16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 48E1628EAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4131B814;
	Mon, 17 Nov 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIKVZNAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630843161B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404950; cv=none; b=D2HYH9n7Ykk6NxW0g6jtCcXySvDFp6Pq+iwcbW1EumysAjMEuQKSvPaLGMtXN69LfJ0QCmpUF0cUiyYkt0/7fR1TtbBDxqPDMzxTffiw9tO1wItYfw92KA6UEwVagF5gBBSD5bx2uH7DciWPkZgV2+3UodzI1kVw9VW+T+tKbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404950; c=relaxed/simple;
	bh=9pRuuZLVf8exleeu5aME3a+ZFOSFZVB2RRP475jUT0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+hu/L+w1YgjJiXH1V9rfYWlJppMIRU69q/JJ4U4c8FOUB2fXZ2t5p7A4lna5r+0TluA7hfJMBSpMIDWBTBFsh3W5gWmFAuPBvyG6FBBzNzdUmpBuSaBIRfEP/gjtmQJPebORw2Gh8GcBO51Ea2Ti6/YvH2A/8D0nMK6Kd61omU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIKVZNAg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298144fb9bcso49287675ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763404948; x=1764009748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GT+Mvcn48BVfqy5/WD1n2ZA/hN2dz1BCZmhQdhw608=;
        b=GIKVZNAgAxjmU4lnE5Y4BFk5dlkELgKM5Fkh/dWmNle5s0R4ZR3Gms7tLgFK5uAiSH
         /260LVr9LwpjxAEAwBk7ydCIbPENF1nL8Q9nQZa17W1oWEqqAHqIg3ZIQIKgr2UZsUi9
         vhOOWZ6J963McjkW5XlppgZVZBbCzskUIWQ0arX5slHHx+8OdZsmESg6Hsjbv+MoMMn3
         GLGDOm/8T+QtzwFtROEkftyU9IedheAM9GNk3I1RFaxXaWa0E9QwEDDunA/jettHslLC
         aK6iUNEb3/1/rZTvV0YcXD3Kdob380QLmIl5ABTkWOrqoSbMf+QKunWDpH3BJV5kBgFm
         EcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404948; x=1764009748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GT+Mvcn48BVfqy5/WD1n2ZA/hN2dz1BCZmhQdhw608=;
        b=tnJ7NAj/FQ8EwzAhA/diyf2mezY3kZSv586rELets2stoYdcBxaZTSk+f89q6+xXjp
         sS1Wo/lkTKgVLBy0LrTN9Ft89hIpjeo+vy0aTlekgsybhVg9XESjU6c6oKZU/Ix8KEHg
         owT2wCELU3C8z0GmNeqbT9ql1orfm6sD/FcJ6sopHLXAXXhQPIDqLuGXZBNCnVmMKME0
         gAwO11XVj2Nz+r4S9DKpJrfhwQvaGTcwALIGBbr+X3K2jKwkfkS0nDlT7RDOY0H1E4ot
         L3hHlKaZsCLAd6PqJdFNmVf7Kst9X6IHF4nj9wct43jYm8nq12LA+q7mDdTb+e3ubcxL
         ptUg==
X-Forwarded-Encrypted: i=1; AJvYcCUk3o6OczIq6fw0mvbQvKXqkRpcCYz+FcWVlQNq/VBzT8jyV/NB0qWREJ+crEOuP1HvDfdRxIsJ/kTZKblt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbf1LvpysXqwi+4QCO5iyOBJY6fG6oi4gjYeii5lAsxPi8wsEz
	ViZWuhEUY+/b9jbkCLs+TKD31X5s6cHqBQrdBZ8zUU5SYIbcsMtpUJ62LcwHWeYY0kTh0krJz+3
	Yt9DnQJC29yak0MS/z7ucuIKq4wZCWlA=
X-Gm-Gg: ASbGnct0WFl6plBUZ+ql51wrqHlDAwmi9/hVXXtQPSZwMfuDoTgQ0WqiPPn7pCNswq4
	UkikNNC4diJ39FDXqWiO0rApILBUPDAOlI905+0r7qW5hOXB9CP9goLi7yB0YbKsLMbAH02B2aR
	J+KIWioSwH3umRoiXtjc9GDNkhMx01qpz/zqVbC7d3l6bWeutt7MsqBfyhUB5KFaM0qyTGOz0Af
	toywlsskJDVg5+KAUC45OQU4Lge/85GVuIWIxc0IWLYQ//lKw5C4dJS3LZd3+1Zrfw9WnKdOFQz
X-Google-Smtp-Source: AGHT+IGlCOta17/ddsZWnD9v3ffWOGOnFpGs6oqmTfDQtnnrJ2sc9E7ozUdVinCK+4CGR9Q0e/Sf5CFPt1dugRYiBPM=
X-Received: by 2002:a17:903:1aed:b0:297:d764:9874 with SMTP id
 d9443c01a7336-2986a6cbe5cmr156328205ad.21.1763404947533; Mon, 17 Nov 2025
 10:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193729.251892-1-ssranevjti@gmail.com> <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org> <aRsqwndQ459VN8I9@ranegod-HP-ENVY-x360-Convertible-13-bd0xxx>
In-Reply-To: <aRsqwndQ459VN8I9@ranegod-HP-ENVY-x360-Convertible-13-bd0xxx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Nov 2025 10:42:15 -0800
X-Gm-Features: AWmQ_blI9jblEa7JMJ2vTFmsIQ2D6lp_5HRLH235a5mwf0VK6MfqNFE0M2tzyYY
Message-ID: <CAEf4Bzboqf+1KUZCb2fBnLZUkzi5X4zOk+wy72eTu3VLB+z7RQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, shakeel.butt@linux.dev, 
	eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf@

On Mon, Nov 17, 2025 at 6:10=E2=80=AFAM Shaurya Rane <ssrane_b23@ee.vjti.ac=
.in> wrote:
>
> On Sun, Nov 16, 2025 at 10:32:12PM +0000, Matthew Wilcox wrote:
> > First, some process things ;-)
> >
> > 1. Thank you for working on this.  Andrii has been ignoring it since
> > August, which is bad.  So thank you for picking it up.

It is bad, I'm sorry for this. I was surprised to read this, though,
as I was not aware of any bug related to build ID parsing code, so I
went looking at syzbot history of the issue. August timeframe you are
referring to implies those "Monthly fs report" emails, which
unfortunately I didn't receive as I'm not subscribed to linux-fsdevel,
but I do see that there was earlier report back in April, which I did
get in my inbox, apparently. So I'm sorry again for dropping the ball.
Please feel free to ping me or BPF mailing list next time when you see
something not being addressed in a timely manner.

> >
> > 2. Sending a v2 while we're having a discussion is generally a bad idea=
.
> > It's fine to send a patch as a reply, but going as far as a v2 isn't
> > necessary.  If conversation has died down, then a v2 is definitely
> > warranted, but you and I are still having a discussion ;-)
> >
> > 3. When you do send a v2 (or, now that you've sent a v2, send a v3),
> > do it as a new thread rather then in reply to the v1 thread.  That play=
s
> > better with the tooling we have like b4 which will pull in all patches
> > in a thread.
> >
> Apologies for the process errors regarding the v2 submission. I appreciat=
e the guidance on the workflow and threading; I will ensure the next versio=
n is sent as a clean, new thread once we have agreed on the technical solut=
ion.
> > With that over with, on to the fun technical stuff.
> >
> > On Sun, Nov 16, 2025 at 11:13:42AM +0530, SHAURYA RANE wrote:
> > > On Sat, Nov 15, 2025 at 2:14=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in =
wrote:
> > > > > When read_cache_folio() is called with a NULL filler function on =
a
> > > > > mapping that does not implement read_folio, a NULL pointer
> > > > > dereference occurs in filemap_read_folio().
> > > > >
> > > > > The crash occurs when:
> > > > >
> > > > > build_id_parse() is called on a VMA backed by a file from a
> > > > > filesystem that does not implement ->read_folio() (e.g. procfs,
> > > > > sysfs, or other virtual filesystems).
> > > >
> > > > Not a fan of this approach, to be honest.  This should be caught at
> > > > a higher level.  In __build_id_parse(), there's already a check:
> > > >
> > > >         /* only works for page backed storage  */
> > > >         if (!vma->vm_file)
> > > >                 return -EINVAL;
> > > >
> > > > which is funny because the comment is correct, but the code is not.
> > > > I suspect the right answer is to add right after it:
> > > >
> > > > +       if (vma->vm_file->f_mapping->a_ops =3D=3D &empty_aops)
> > > > +               return -EINVAL;
> > > >
> > > > Want to test that out?
> > > Thanks for the suggestion.
> > > Checking for
> > >     a_ops =3D=3D &empty_aops
> > > is not enough. Certain filesystems for example XFS with DAX use
> > > their own a_ops table (not empty_aops) but still do not implement
> > > ->read_folio(). In those cases read_cache_folio() still ends up with
> > > filler =3D NULL and filemap_read_folio(NULL) crashes.
> >
> > Ah, right.  I had assumed that the only problem was synthetic
> > filesystems like sysfs and procfs which can't have buildids because
> > buildids only exist in executables.  And neither procfs nor sysfs
> > contain executables.
> >
> > But DAX is different.  You can absolutely put executables on a DAX
> > filesystem.  So we shouldn't filter out DAX here.  And we definitely
> > shouldn't *silently* fail for DAX.  Otherwise nobody will ever realise
> > that the buildid people just couldn't be bothered to make DAX work.
> >
> > I don't think it's necessarily all that hard to make buildid work
> > for DAX.  It's probably something like:
> >
> >       if (IS_DAX(file_inode(file)))
> >               kernel_read(file, buf, count, &pos);
> >
> > but that's just off the top of my head.
> >
> >
> I agree that DAX needs proper support rather than silent filtering.
> However, investigating the actual syzbot reproducer revealed that the iss=
ue extends beyond just DAX. The crash is actually triggering on tmpfs (shme=
m).I verified via debug logging that the crashing VMA is backed by `shmem_a=
ops`. Looking at `mm/shmem.c`, tmpfs legitimately lacks a `.read_folio` imp=
lementation by design.
> It seems there are several "real" filesystems that can contain executable=
s/libraries but lack `.read_folio`:
> 1. tmpfs/shmem
> 2. OverlayFS (delegates I/O)
> 3. DAX filesystems
> Given that this affects multiple filesystem types, handling them all corr=
ectly via `kernel_read` might be a larger scope than fixing the immediate c=
rash. I worry about missing edge cases in tmpfs or OverlayFS if we try to i=
mplement the fallback immediately in this patch.
> > I really don't want the check for filler being NULL in read_cache_folio=
().
> > I want it to crash noisily if callers are doing something stupid.
> I propose the following approach for v3. It avoids the silent failure you=
 are concerned about, but prevents the kernel panic:
>
> 1. Silent reject for `empty_aops` (procfs/sysfs), as they legitimately ca=
n't contain build IDs.
> 2. Loud warning + Error for other cases (DAX, tmpfs, OverlayFS).
>

Tbh, it seems a bit fragile to have to hard-code such file
system-specific logic in higher-level build ID fetching logic, where
all we really ask for from filemap_get_folio() + read_cache_folio()
combo is to give us requested piece of file or let us know (without
crashing) that this was not possible.

But if there is no way to abstract this away, then I think Shaurya
proposed with failing known-not-supported cases and warning on
unexpected ones would be a reasonable solution, I suppose. I see that
Matthew is discussing generalizing kernel_read, so maybe that will be
a better solution, let's see.


> The code would look like this:
>
>     /* pseudo-filesystems */
>     if (vma->vm_file->f_mapping->a_ops =3D=3D &empty_aops)
>         return -EINVAL;
>
>     /* Real filesystems missing read_folio (DAX, tmpfs, OverlayFS, etc.) =
*/
>     if (!vma->vm_file->f_mapping->a_ops->read_folio) {
>         /*
>          * TODO: Implement kernel_read() fallback for DAX/tmpfs.
>          * For now, fail loudly so we know what we are missing.
>          */
>         pr_warn_once("build_id_parse: filesystem %s lacks read_folio supp=
ort\n",
>                      vma->vm_file->f_path.dentry->d_sb->s_type->name);
>         return -EOPNOTSUPP;
>     }
>
> This highlights exactly which filesystems are missing support in the logs=
 without crashing the machine
> Thanks,
> Shaurya

