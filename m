Return-Path: <linux-fsdevel+bounces-34564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8E9C64DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401C9B22AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E221B45D;
	Tue, 12 Nov 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/68WnA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77521A71C;
	Tue, 12 Nov 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452783; cv=none; b=IuM5u+RYkJ1PWYTB7s5pQxPG9j34mR8rkA2ekTJqgcZFiXnN6Dn+jvu/gPV9iiCu2M5mQitkaEWdxJ6QclrAKvy0kRdkvg4+k/InF51rYZMFPkIRiFigVJ0uyf+OUrx/w8CnOCmVhWHz0MS5RyBLQpJ6riscZYRWlfO8A2uaf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452783; c=relaxed/simple;
	bh=gfFVCHmb+HoisgZ2lNP7XW0mnRshgsLW/YkaWiNMF3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9iqhfRdp7+U36crGN7x7/OQtWzad2K+wDoWyzmPEafc/r2JufQ1ivLd6Y43t3/NS4d6nIB74wJQ4VXtBspMTb+IqQfS+9b5/5E3aFx8ZFHA65S0Ds0A/alyMoNVJDo7qFD3FcyW6VWgiWcysxWFEpj+EvbYAK80oHPjhw9fklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/68WnA6; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso42720036d6.0;
        Tue, 12 Nov 2024 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731452779; x=1732057579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIr16uc11UiqTl1Sx8j59V2P8BYfKtJ63uAHahcToIA=;
        b=W/68WnA6if+LbRWB3C07X58E+hXp8jf/6OZj/LTHG37SpmN75dn1vZN5M3fgQAXPSQ
         EBD2Bk2+kMXMwF6TOH4nJ+tv6klGmblrwwsdyB6OC8zysc009oTd5gbxKB3G0QAERNj5
         gMZj6XvF0CCr0lCCS8u3g+6MYxMkV8HFJldwAQKSboABkIwoe8ZW3hx0F/uMhevrOYb1
         jxo9/TCjoJrnrPlTC/MFPJLqDbN6aDpcFgOGvJdP8Dz6NK/mvWAfcDNb5G1QYkNNtaO9
         t3Yxj60jnMTnA5I4qOcIPTNr9Afd6aWa7I0kMw6EtC6YTUklPhKhyePeU7cqIjtc2I0l
         1nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452779; x=1732057579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIr16uc11UiqTl1Sx8j59V2P8BYfKtJ63uAHahcToIA=;
        b=IodAK5Wbda85AyJ2sXG/RJgONVZdU+Lw3QSQWL+c5ryqWA/a6UqV6nby8bknDVpTWG
         5DPPe0zPKFPQ1do+1NpzHW3nejwUCX7MrHBzeQug4jRBaCpYTxFNIp5yjNgrSJ05dVLW
         raBRtdlk44/jNsI5yxh207qRIIj6VvmD0Oall1swJo5q+tMkjE0VxnFJ+z7RrCr1O23B
         z1LtWq8dhT+ZiJTCQaKJ4Fc2TEY2qyw0gmhFWFF7AuF9fug9YZnU31pQk0+gMiMycctu
         3SraH/+VmxCL/86EXRTa7tKwxGsTo26ZnwZbtg7PbyG18fKDYMvd72XPy/c/RmfjHFsa
         4/dw==
X-Forwarded-Encrypted: i=1; AJvYcCVUqWZpQfLlQhAVz698NB9iIPzR2Iz4xaKU5OhHqREhk7+sVD6d2TEUkN3GeMWEkmBa1Qa2PPnGVUrfMGGKsw==@vger.kernel.org, AJvYcCVa6GJeZWgqYEz6ZgTF2tD9VkZpkvIu3Jcg471Ig5AyT+q4+4kqRsf2spDurE0f96sWq46KLZ1tgTvcRg==@vger.kernel.org, AJvYcCWHkhD5N6quXRUE2JeUgyjDyCllwZsF+nd5Hw4WzHSuCPT0TZHLILjLxH5NoYuutz6l5lJ/wRCu7UrJ@vger.kernel.org, AJvYcCWPltaDMsONfUclI1a51cxN6MF2Y3yQXAjPtZu2nuYf9ie6okcDoIA9h5vm54Er5hccJ7Lu0EHHUMuzrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tcCeIrd9IrtWHkXqVqFYcajPm9K6KdgUixCB1fHtp45/l4hE
	7S73mUapUG7vehuBb8tdEdLXctoRjmasJGaggoenxDHpcchMHKrfnsaHlR/7e+xSnHMbsv5yxds
	wnLkCLfxGbP2auzzC6jFeX1w2kbk=
X-Google-Smtp-Source: AGHT+IHxu77JKYYa/Yi0IgqgbzYETuy6BNeSMuPucl1B8xYxyyUZE8YdamGYeRduzkpm8Frlb0wJ61eZe0uRDQXpVlo=
X-Received: by 2002:a05:6214:3287:b0:6d1:74d4:4ba2 with SMTP id
 6a1803df08f44-6d39e15549cmr215580146d6.9.1731452779171; Tue, 12 Nov 2024
 15:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
In-Reply-To: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 00:06:07 +0100
Message-ID: <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:12=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> >  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > +static inline int fsnotify_pre_content(struct file *file)
> > +{
> > +       struct inode *inode =3D file_inode(file);
> > +
> > +       /*
> > +        * Pre-content events are only reported for regular files and d=
irs
> > +        * if there are any pre-content event watchers on this sb.
> > +        */
> > +       if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
> > +           !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
> > +           !fsnotify_sb_has_priority_watchers(inode->i_sb,
> > +                                              FSNOTIFY_PRIO_PRE_CONTEN=
T))
> > +               return 0;
> > +
> > +       return fsnotify_file(file, FS_PRE_ACCESS);
> > +}
>
> Yeah, no.
>
> None of this should check inode->i_sb->s_iflags at any point.
>
> The "is there a pre-content" thing should check one thing, and one
> thing only: that "is this file watched" flag.
> The whole indecipherable mess of inline functions that do random
> things in <linux/fsnotify.h> needs to be cleaned up, not made even
> more indecipherable.
>
> I'm NAKing this whole series until this is all sane and cleaned up,
> and I don't want to see a new hacky version being sent out tomorrow
> with just another layer of new hacks, with random new inline functions
> that call other inline functions and have complex odd conditionals
> that make no sense.
>
> Really. If the new hooks don't have that *SINGLE* bit test, they will
> not get merged.
>
> And that *SINGLE* bit test had better not be hidden under multiple
> layers of odd inline functions.
>
> You DO NOT get to use the same old broken complex function for the new
> hooks that then mix these odd helpers.
>
> This whole "add another crazy inline function using another crazy
> helper needs to STOP. Later on in the patch series you do
>
> +/*
> + * fsnotify_truncate_perm - permission hook before file truncate
> + */
> +static inline int fsnotify_truncate_perm(const struct path *path,
> loff_t length)
> +{
> +       return fsnotify_pre_content(path, &length, 0);
> +}
>
> or things like this:
>
> +static inline bool fsnotify_file_has_pre_content_watches(struct file *fi=
le)
> +{
> +       if (!(file->f_mode & FMODE_NOTIFY_PERM))
> +               return false;
> +
> +       if (!(file_inode(file)->i_sb->s_iflags & SB_I_ALLOW_HSM))
> +               return false;
> +
> +       return fsnotify_file_object_watched(file, FSNOTIFY_PRE_CONTENT_EV=
ENTS);
> +}
>
> and no, NONE of that should be tested at runtime.
>
> I repeat: you should have *ONE* inline function that basically does
>
>  static inline bool fsnotify_file_watched(struct file *file)
>  {
>         return file && unlikely(file->f_mode & FMODE_NOTIFY_PERM);
>  }
>
> and absolutely nothing else. If that file is set, the file has
> notification events, and you go to an out-of-line slow case. You don't
> inline the unlikely cases after that.
>
> And you make sure that you only set that special bit on files and
> filesystems that support it. You most definitely don't check for
> SB_I_ALLOW_HSM kind of flags at runtime in critical code.

I understand your point. It makes sense.
But it requires using another FMODE_HSM flag,
because FMODE_NOTIFY_PERM covers also the legacy
FS_ACCESS_PERM event, which has different semantics
that I consider broken, but it is what it is.

I am fine not optimizing out the legacy FS_ACCESS_PERM event
and just making sure not to add new bad code, if that is what you prefer
and I also am fine with using two FMODE_ flags if that is prefered.

Thanks,
Amir.

