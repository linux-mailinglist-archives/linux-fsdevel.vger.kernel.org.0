Return-Path: <linux-fsdevel+bounces-39604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA226A16134
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108A3188474A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB581B422F;
	Sun, 19 Jan 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adEBrS0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0A18785D;
	Sun, 19 Jan 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737282543; cv=none; b=cWDLd+ZZ2HoFRWGeelk3VrORroeD3k62J46HfX6CH+kd5Y5Rbh4h3gekjQxF8VxuHIZPoJT51rSgzEh4efyDe+W/eE864iV2VsY2Br8zi6qV+cuPgb0A9svsfhywCsS0eOH/+Zj7fCTZNpPJAKkLU8Xo8+NhHIN5c9T7+wND768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737282543; c=relaxed/simple;
	bh=KZGXv8I2D3JnqX4HeRzvETDRqh6i3LqlTv5DejpmKe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBOETOs9YLfpTPQp3eRcJArusdm1n7EIfMtKQhD5I5xVrppYJSugVcZIcYxBUna5cGYX6l5t+YaVzrDTYGK1VDJvSSAYfYuOMSvip8GiBXZF/Ed0RXvPQ67IJ4Hl+1x8gwbwRb8DMuNDegsRNPwQsyHjVDlPdBwyGL5hCoMqU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adEBrS0T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so5494209a12.3;
        Sun, 19 Jan 2025 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737282540; x=1737887340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHtj1JGrmFbXGHYAnCk+M0GmLO0ckQxdvRUoNx1DAUU=;
        b=adEBrS0TLkGiVjFklWLh55A37HMb52j4jGi+a9zobudHVUGteotcTBgxfxpjIQ2j5f
         u+deJmYQ5Ejqu1Egyo8aNgvsi7bpF/0B0c99YXf4zrwkMkCzwb9fxP8MEvLcBDVAloxZ
         uHm88LG70YKNrMq2OYYrZMLY25Wrh3irkvRqSy5UiWDVbZ3Vliug/l6Dw9G/jzCAu1yk
         YUZPykMaoYaxh4AQEA88LyAGNH22Z0ubd65OyahCw5eyE6j3vcCWZAeqMb64ZG6aaNKz
         bdH8lHyxPiE3xhx+aPzZGS1exUOJVR4fz1ccLbSn1RUHr/UAp1fNfJMwmoCBVBX/mjrL
         SSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737282540; x=1737887340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHtj1JGrmFbXGHYAnCk+M0GmLO0ckQxdvRUoNx1DAUU=;
        b=vnW5Twzgv0rSpEwbI+bBeRH22yxEHMnZL9G+XZEjhCYVNM//YezV1y7UTPZqI8igNc
         pFbXp8Mft2DJ/HNlFd2TBnM4r0R8OLaGLp9U7fJKspmgDQErM+6vNKVjoeou64CzT2tO
         M6bWv5jdYxIlBDAXwIp79hVTmgH6XxFvTW/8H2rZw8QvfEp+DM+lQidtfSpfmQBlxLxD
         19wPVZOZxxvCkb+e4EJ2F6+rPBdjcUPaiEJp0TeT6rA29nGaqp+SsiNSE4m6VSlejsXB
         CdKVrOtYOFgdiUyRJZSfWCy/xrsnQbNYlnIL4yE/bzAf7FRqHCR8VhXZnPydboLkj4rw
         5vFA==
X-Forwarded-Encrypted: i=1; AJvYcCUFXvfow+60JniUWswH6x9iYmvGXL61tRfoj2en2b3938Orktmp+ESGMNSNCXvaYaCLfKhCG9Pvu8BrbO+k@vger.kernel.org, AJvYcCXuOj3o3lgIuhMoYtHN677U7JGxF9ZqZsdhky8gWn0VBqKTBLSvKVFY6rfh8lag0MKSreF1FORSW1968tgl@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXXkeB6wgChwYqE2gknQNor6XhAn7xukCA5rNo36RCLL0oO6j
	PJBVc5qlemBpgIDgkX8u0bsHZQvRn275DEgMLkKlhlmFE4xXRAZ16F6A2jUENwGKbfSFR5f1AZU
	tghjjCNFWR4VUCxAoNgjkaHghEXG4vw==
X-Gm-Gg: ASbGncsQyXxZjZIQd4qCnZcQg8TNnxz7rQF+k9x7X2DQuKJZD+HPfmb287gArcdhjek
	bO2n38/Rd8pngPE9lE1siyMKhYnYnUU49fAMMEZz7M/tiNBkXB1U=
X-Google-Smtp-Source: AGHT+IHEQMXALyTh1AAXqlciZBpIfyL7e+Xpecg+3yV39oBUv5AlrdBe4RsjhoYnI0cirafe+wC4kXWY4C4mZt4kxoo=
X-Received: by 2002:a05:6402:42d0:b0:5d1:1024:97a0 with SMTP id
 4fb4d7f45d1cf-5db7d2e251bmr9327330a12.6.1737282539621; Sun, 19 Jan 2025
 02:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
 <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r>
 <63wvjel64hsft4clgeayaorx3v7txvqh264mw7ionlbmmve7pj@eblpknd677zf>
 <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com> <Z4k68Clw4k2g2OgK@tachyon.localdomain>
In-Reply-To: <Z4k68Clw4k2g2OgK@tachyon.localdomain>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 19 Jan 2025 11:28:47 +0100
X-Gm-Features: AbW1kvaDKNf45dyOYWand-aR_jl6epEB9Jq_0qj12CpL0GCbvnmEdr0uaBGufgY
Message-ID: <CAGudoHE74SbDjO+4863JVTL_dyZKCt7aCXudjXnBkoy6ELujtQ@mail.gmail.com>
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous regions
To: Tavian Barnes <tavianator@tavianator.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:04=E2=80=AFPM Tavian Barnes <tavianator@tavianato=
r.com> wrote:
>
> On Thu, Jan 16, 2025 at 01:04:42PM +0100, Mateusz Guzik wrote:
> > In this context there are next to no pages found, but there is a
> > gazillion relocks as the entire VA is being walked.
>
> Do I understand correctly that all the relocks are to look up the VMA
> associated with each address, one page at a time?  That's especially
> wasteful as dump_user_range() is called separately for each VMA, so it's
> going to find the same VMA every time anyway.
>

it indeed is a loop over vmas, and then over the entire range with
PAGE_SIZE'd steps

> > I however vote for someone mm-savvy to point out an easy way (if any)> =
> to just iterate pages which are there instead.
>
> It seems like some of the <linux/pagewalk.h> APIs might be relevant?
> Not sure which one has the right semantics.  Can we just use
> folio_walk_start()?
>
> I guess the main complexity is every time we find a page, we have to
> stop the walk, unlock mmap_sem, call dump_emit_page(), and restart the
> walk from the next address.  Maybe an mm expert can weigh in.
>

I don't know the way, based on my epsilon understanding of the area I
*suspect* walking the maple tree would do it.

--=20
Mateusz Guzik <mjguzik gmail.com>

