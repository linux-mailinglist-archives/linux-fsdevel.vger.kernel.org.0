Return-Path: <linux-fsdevel+bounces-35340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987349D3FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D28C1F22830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98E145B1B;
	Wed, 20 Nov 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO9cxOQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728613665B;
	Wed, 20 Nov 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119157; cv=none; b=GMCiT09ULysJ7bEPEI7j5XuS31o05peq7k+N+LtDXx1LOdPLuaJW6uMeOooxb3U53L7nBRpZQDu5gDHiE3a1ldsSy5sbiD4T7pUO2YIEnH21tLUIAagKhmq/Leg7M7cocihsmxVCrShc0r7wCJU5wuAY+GQBFT/xZe2WbDLDR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119157; c=relaxed/simple;
	bh=LsOXYnlAFrXH4ANT2Gwet+eFYLz+xFvrFpLsYbF5d+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnMxXEmYWdcOf8QAxwX7uzo5ihORVyOaPn/m0DqG/aDxDMxjRb9zYtQSa7BmpHhO19bsG8QZgnSAHbE4nxBaYbY5SA2viEm0F2CSC/PZgrAKOPu97eb8Eqk3VPtHkENsd2/irrXxT4XJJNF6/cUgalnWHVwGVirjrZuOuSeZWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO9cxOQL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso71602631fa.3;
        Wed, 20 Nov 2024 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732119154; x=1732723954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0cgeSNXkJH2+E5FXlc5NSe4Q9H23sTP1cPn8NwPK4A=;
        b=UO9cxOQLX68lt3e9XFzBLzHiOmdmpqwFyn9JR1oL7hO354twh4eDvdV10uR2jgn0Gx
         Xie3+1DqeWZHBrz+mAZfJ+lRQX2te95GRe0F/9Yl1F09Y2f3GSPy8XTxhu+8ADWPoMUv
         3F+OG1mcnbELjZ0ilbmDLCRDnCe8vlpPgSjE2SWpVErvM/vvOQkcc8EiEGd0O7uR1FMD
         ZfvadeQk8QSouP4BPQ06QUQQVA+cv/cAROTlccXCqahby6vOK2Ab50pV4dfTzmsxxPC8
         IUDCOFDl+iOgCcZXxDPqNRsib1m2I3W8Vd9YX/rLMzDa8Eh39UTXzJomR5Kmt/UD1idt
         icFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119154; x=1732723954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0cgeSNXkJH2+E5FXlc5NSe4Q9H23sTP1cPn8NwPK4A=;
        b=fiH/DeeJMrZSlkSbl6+Oe6JPy/qejIBFbJX47KPaLwOqL1pn9aWJMcAZjUv9igerA4
         xnZ78fO+tMgIXU257scRgi/THh8Tb7+/Vba1P3wO/VV64zAVcNFShqIVfeTudsr/6MmR
         MVHQCD1O3ehcjXPisUfrXr2V2HybczhBOKzcWRWxA35eEDvWPcb0+/7DiMCfS2TnWdl3
         2YiRMpGKODhpfu1em3+7B8nDFgApNkKx0+bLom7GjGxlQrdRUxykxtfWQvBaFNy9Zn/s
         M1VpSDb5AWp3nYzadPQ+CN0E6I7oQdEzholbJYcQfSeRiRsy8fL28d32tPE+Xohr2mdr
         pwZw==
X-Forwarded-Encrypted: i=1; AJvYcCUA9xc+fA2SkS1y+JOaj+PYUJKodV99tBpZP78VGh8+gDhWFPeed7vR6QsaBjN5SoXMdSiCQ5XSsSXIHQ==@vger.kernel.org, AJvYcCUb4yAp8at44BcDY0MEbG3lru792KgTK3tPgXMcGY8tCyg2zeMHnbdYKjKhxFPm4QFvK99FqpgUfCyvBg==@vger.kernel.org, AJvYcCUceRZZbIpwRERtHVXPmazwjbXvezHrsaXjwFPgdkaD/6KeDyMwlU9n2bCA6q4/EatpQIZoqugz0QEh@vger.kernel.org, AJvYcCXDF/4lL6ssCFC/cviPBDFCNG+G86kdFDm/nw+bjyMZDxFG6I4A9aWYG+JVXcfB5t0MAy6R3tk47cGmYuUZqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxItaqXxnEWPNqAXskrvKw3qnzryc6Ml+Dmi1yh4LyJ/HmnE0
	jYprGh5IZuEeSY+XXk1NcL90oA1s11Hgw5WZcZkKY8YjUFhkmnfB8zFHQbijebyJC7ua2haO0J+
	kF647nIQoNBbTbBgbfvxPKKyM12s=
X-Google-Smtp-Source: AGHT+IF8f7v4a4sptq5ia4dSWBkD2+QG1/RGNLsS7h/kWKRgH7sx+NYjTqd9GraWx1v1b2aBXhIThMPt13OjiV/rAVI=
X-Received: by 2002:a05:651c:221b:b0:2fb:6362:284e with SMTP id
 38308e7fff4ca-2ff8db165bdmr29289991fa.8.1732119153173; Wed, 20 Nov 2024
 08:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3>
In-Reply-To: <20241120155309.lecjqqhohgcgyrkf@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 17:12:21 +0100
Message-ID: <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:53=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-11-24 10:30:15, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Legacy inotify/fanotify listeners can add watches for events on inode,
> > parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> > were already open at the time of setting up the watches.
> >
> > fanotify permission events are typically used by Anti-malware sofware,
> > that is watching the entire mount and it is not common to have more tha=
t
> > one Anti-malware engine installed on a system.
> >
> > To reduce the overhead of the fsnotify_file_perm() hooks on every file
> > access, relax the semantics of the legacy FAN_ACCESS_PERM event to gene=
rate
> > events only if there were *any* permission event listeners on the
> > filesystem at the time that the file was opened.
> >
> > The new semantic is implemented by extending the FMODE_NONOTIFY bit int=
o
> > two FMODE_NONOTIFY_* bits, that are used to store a mode for which of t=
he
> > events types to report.
> >
> > This is going to apply to the new fanotify pre-content events in order
> > to reduce the cost of the new pre-content event vfs hooks.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwj8L=3DmtcRTi=3DNEC=
HMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> FWIW I've ended up somewhat massaging this patch (see below).
>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 23bd058576b1..8e5c783013d2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, lo=
ff_t offset,
> >
> >  #define      FMODE_NOREUSE           ((__force fmode_t)(1 << 23))
> >
> > -/* FMODE_* bit 24 */
> > -
> >  /* File is embedded in backing_file object */
> > -#define FMODE_BACKING                ((__force fmode_t)(1 << 25))
> > +#define FMODE_BACKING                ((__force fmode_t)(1 << 24))
> >
> > -/* File was opened by fanotify and shouldn't generate fanotify events =
*/
> > -#define FMODE_NONOTIFY               ((__force fmode_t)(1 << 26))
> > +/* File shouldn't generate fanotify pre-content events */
> > +#define FMODE_NONOTIFY_HSM   ((__force fmode_t)(1 << 25))
> > +
> > +/* File shouldn't generate fanotify permission events */
> > +#define FMODE_NONOTIFY_PERM  ((__force fmode_t)(1 << 26))
>
> Firstly, I've kept FMODE_NONOTIFY to stay a single bit instead of two bit
> constant. I've seen too many bugs caused by people expecting the constant
> has a single bit set when it actually had more in my life. So I've ended =
up
> with:
>
> +/*
> + * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shoul=
dn't be
> + * generated (see below)
> + */
> +#define FMODE_NONOTIFY         ((__force fmode_t)(1 << 25))
> +
> +/*
> + * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't =
be
> + * generated (see below)
> + */
> +#define FMODE_NONOTIFY_PERM    ((__force fmode_t)(1 << 26))
>
> and
>
> +/*
> + * The two FMODE_NONOTIFY* define which fsnotify events should not be ge=
nerated
> + * for a file. These are the possible values of (f->f_mode &
> + * FMODE_FSNOTIFY_MASK) and their meaning:
> + *
> + * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> + * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> + * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content even=
ts.
> + */
> +#define FMODE_FSNOTIFY_MASK \
> +       (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
> +
> +#define FMODE_FSNOTIFY_NONE(mode) \
> +       ((mode & FMODE_FSNOTIFY_MASK) =3D=3D FMODE_NONOTIFY)
> +#define FMODE_FSNOTIFY_PERM(mode) \
> +       (!(mode & FMODE_NONOTIFY_PERM))

That looks incorrect -
It gives the wrong value for FMODE_NONOTIFY | FMODE_NONOTIFY_PERM

should be:
!=3D FMODE_NONOTIFY_PERM &&
!=3D FMODE_NONOTIFY

The simplicity of the single bit test is for permission events
is why I chose my model, but I understand your reasoning.

> +#define FMODE_FSNOTIFY_HSM(mode) \
> +       ((mode & FMODE_FSNOTIFY_MASK) =3D=3D 0)
>
> Also I've moved file_set_fsnotify_mode() out of line into fsnotify.c. The
> function gets quite big and the call is not IMO so expensive to warrant
> inlining. Furthermore it saves exporting some fsnotify internals to modul=
es
> (in later patches).

Sounds good.
Since you wanted to refrain from defining a two bit constant,
I wonder how you annotated for NONOTIFY_HSM case

   return FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;


Thanks,
Amir.

