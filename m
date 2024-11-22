Return-Path: <linux-fsdevel+bounces-35580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D199D5FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62450B228B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F067405A;
	Fri, 22 Nov 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9PPjpiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C712E7F;
	Fri, 22 Nov 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283499; cv=none; b=rPtZTv2dNJUyEtUt+pcFBynk2w8WPIozRP0z4xzdj5XCw3YVYzno66ZRy2UNOK4esF1z/6ZF3x822uWvoiclSj5vHUOro12rEaj2zuKq7Z5ZwfI2JdYqRXyhNOGcXli0hkjZfGo6XA1vPaW7fC5AWWIYQJEjRMSQ2vDY1DN9/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283499; c=relaxed/simple;
	bh=FUSPjYnmqvq3EZk+YaMlZMRYm+mAt5sMmrYQadC1O2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8mwwj53vzjI6D3p1kYdpBxhy2cbAEnY73jNf//6S9d9P8+TjNKqMcIj8/EZORfTD6vGoyrfhbzsChNs+/oDsKIOAHH2Tf/UxbZWADlQ69YxEZAVCwemHQIIWOTX5CXus96pfXohSHutGV/23BZ1nI6zgkY/YH3Hg459Yi8mfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9PPjpiq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da2140769so2516127e87.3;
        Fri, 22 Nov 2024 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732283496; x=1732888296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1M+VNoDV01ttI4ykAkLiT0TH7dIi4lr51PaobubPkY=;
        b=E9PPjpiqRbbSa7J3T9vUDuBGgA9SOh1kNLjk7K/5ROfBDth04v0vWA0qtv0U3U1Du+
         8vOojvYVoMfT1KSk1kaV4IyR0qm5UZdIDRTZe24xi5Gc1RsRW0LGaUOlPkKXk32XefNF
         TMNgm1DS3e1I8xWQyCisW/92ay9e2xs1nIgzYsEtYMyEwFhoBJGLDYft+VzdHTHHcbS+
         bCS5idpnPDtQx57wzXVNPNEPUX/EXXpUsjCuoX1HpsPrZjLaNgrqWV2gmW8DeAeXi4jb
         VNEQ5FpJ2pcPjSBUJ+pFLQm74uL8ZYTTE4D22xWy9Bxn8mhrJfPzS96483g/EkzazJjI
         r27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283496; x=1732888296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1M+VNoDV01ttI4ykAkLiT0TH7dIi4lr51PaobubPkY=;
        b=g65hLxst0YlG+nk0SH61RgdJmm7yLEpi5wyHMr410e9LaewRL5gKBwkROHJE580O2u
         QLdwrkvfqzakkoUIJHL8Ssz4ghGrtx5cn3V6ZKhxEMX+ZVqkUDVVzBPw73ag1ZdoQWnI
         9mtCvjwujbIggTSgLCZ86A7ZkZTz9Sad/jhed5uDI8gD0n00sMxUcOkyrDV77urURCZb
         Xmy4O2UJwMpZIdGIIRgcOJqggm96xPoasRy5e4y4vwCcagcHrTyVlHdPxgRyVPPbCTsd
         H7O+5Bbrr8Lh1sV5UCnL3m8WVqZoccHxB7SXivJSf5cVIHcryAhBTY/i2MVsTMKoOST8
         OAEA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdoubayeRCfLRPouKPolAoZWuQ5gkV+MmtsAAmF82il7rd5ehKse1W5o7S5/TMFF1KmooSbq1uZNmag==@vger.kernel.org, AJvYcCWf+8ocdmKX7htEBxQi+BasjnRAp707vwXVJMrXCOtIMKCynFFJ+niom7iLSNUQi5bFxwhof8sB3DT4@vger.kernel.org, AJvYcCXYuetgmrM5d5wGNJF2UAFFW3pWIxcg/86LKtXo4C4ZcFRfi4c4AABtz3795OU3aFTURtj7Idz1V3dVpA==@vger.kernel.org, AJvYcCXtmElmaOy/TZ6a2rfwfVTPNQW/0lwPOU9sADVbcp8QEg3E+J7mfGxi+CLKo+WeERS4tIFpjUc9m60gq0/Lmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HQlnRGHFAQDJwhG1kmf6fTLiwemLWMmVXgcpOEWa+4DBiOmQ
	OZTyBh52a3A7z7vyWMmPVC6WN+wO2hTbfY1HXOH7R5pgyjbWkaedKFJGxrrQsOORqo9rjiO1/h7
	SlTNvk1Tfp0aKL9VwAd5ZsoF31UQ=
X-Gm-Gg: ASbGnctM+/2K/xe/mrq6tWi38y4JF4m3R7xiWGRzo076PQLZNWdhiHKNRl8hZZA0v7a
	884ixZJc1DRmvHceqVMO57ovibTue1Ag=
X-Google-Smtp-Source: AGHT+IFksCaFnz5KcROoZ2l24vat56l/bmgqMqDIpj9UInqeXkdyaOzrJLTT+HRXZb32Fn4KXFKnG0FbN2YKckPb6S0=
X-Received: by 2002:a05:6512:3d06:b0:539:9645:97ab with SMTP id
 2adb3069b0e04-53dd389d83dmr1593356e87.33.1732283495537; Fri, 22 Nov 2024
 05:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3> <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3> <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
 <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com> <20241122124215.3k3udv5o6eys6ffy@quack3>
In-Reply-To: <20241122124215.3k3udv5o6eys6ffy@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Nov 2024 14:51:23 +0100
Message-ID: <CAOQ4uxgCU6fETZTMdyzQmfyE4oBF_xgqpBdVjP20K1Yp1BSDxQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 21-11-24 19:37:43, Amir Goldstein wrote:
> > On Thu, Nov 21, 2024 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > On Thu, Nov 21, 2024 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > > On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > > > > On Thu, Nov 21, 2024 at 11:44=E2=80=AFAM Jan Kara <jack@suse.cz> =
wrote:
> > > > > and also always emitted ACCESS_PERM.
> > > >
> > > > I know that and it's one of those mostly useless events AFAICT.
> > > >
> > > > > my POC is using that PRE_ACCESS to populate
> > > > > directories on-demand, although the functionality is incomplete w=
ithout the
> > > > > "populate on lookup" event.
> > > >
> > > > Exactly. Without "populate on lookup" doing "populate on readdir" i=
s ok for
> > > > a demo but not really usable in practice because you can get spurio=
us
> > > > ENOENT from a lookup.
> > > >
> > > > > > avoid the mistake of original fanotify which had some events av=
ailable on
> > > > > > directories but they did nothing and then you have to ponder ha=
rd whether
> > > > > > you're going to break userspace if you actually start emitting =
them...
> > > > >
> > > > > But in any case, the FAN_ONDIR built-in filter is applicable to P=
RE_ACCESS.
> > > >
> > > > Well, I'm not so concerned about filtering out uninteresting events=
. I'm
> > > > more concerned about emitting the event now and figuring out later =
that we
> > > > need to emit it in different places or with some other info when ac=
tual
> > > > production users appear.
> > > >
> > > > But I've realized we must allow pre-content marks to be placed on d=
irs so
> > > > that such marks can be placed on parents watching children. What we=
'd need
> > > > to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn'=
t we?
> > >
> > > Yes, I think that can work well for now.
> > >
> >
> > Only it does not require only check at API time that both flags are not
> > set, because FAN_ONDIR can be set earlier and then FAN_PRE_ACCESS
> > can be added later and vice versa, so need to do this in
> > fanotify_may_update_existing_mark() AFAICT.
>
> I have now something like:
>
> @@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struct fs=
notify_group *group)
>  }
>
>  static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_m=
ark,
> -                                             unsigned int fan_flags)
> +                                            __u32 mask, unsigned int fan=
_flags)
>  {
>         /*
>          * Non evictable mark cannot be downgraded to evictable mark.
> @@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(struc=
t fsnotify_mark *fsn_mark,
>             fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
>                 return -EEXIST;
>
> +       /* For now pre-content events are not generated for directories *=
/
> +       mask |=3D fsn_mark->mask;
> +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> +               return -EEXIST;
> +

EEXIST is going to be confusing if there was never any mark.
Either return -EINVAL here or also check this condition on the added mask
itself before calling fanotify_add_mark() and return -EINVAL there.

I prefer two distinct errors, but probably one is also good enough.

Thanks,
Amir.

