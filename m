Return-Path: <linux-fsdevel+bounces-44584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E67A6A7E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38437AFF7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7B1A287E;
	Thu, 20 Mar 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLgmo79V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97F15C158;
	Thu, 20 Mar 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479420; cv=none; b=MldUCWpk/xBPmbWMOzgpWgT73ESf7JIMLJOKcpdB/LTolN5YksqMqLtrfpmO4DhdUnH9TdhqKTLX2cC0INe60yvUqBLUcj80VXIpoYn4Eo9A0uIyYiZBEiHz1mZuKMI8bAUgOKU1cymKlGUFTvjJJ2hgEEhQ3a5GcutGyNfyySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479420; c=relaxed/simple;
	bh=3CtXUOiV6YbzdJsdrwscdlDgW4tNQasHXRzZgigycQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9XqOIoCc+4JuKwYPBSawnYIzUjP/RNXKoQY+tQ3Z22YokZMbgvlyCdMwpgo6IJef7vDzPGQ+i+o1LtshnutJgYiB94fRqjyKIa6WSON2UIxc8V1vyUS+/9x3PeFe0ChrqJPGS1VCJiPXv3jObn9dk1eJSNtGuHlhomqjqjbfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLgmo79V; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so1507487a12.2;
        Thu, 20 Mar 2025 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742479416; x=1743084216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CtXUOiV6YbzdJsdrwscdlDgW4tNQasHXRzZgigycQQ=;
        b=dLgmo79VicFTMWNJmSVc5aThCEafu7+DWd6CCUlU9P3KRe29VgXaI7Osd2klwc15JO
         tM+g9TUmf2MFry7bJGgj/02tK7MYAz0WYJNVdH31cV3B6VyUCo/YmZ4V+vdhJk3MGr/c
         H5g6cDtUSLbe3Ft7/yKCTvzR2+WO1G/5jvidvxVAVQJQxQ0Zt6ZkuNxloPE+JqLUXxf2
         DVklcd0NDoDZSIDXGFmFntAwL8rfIt4bcjYTjF5vUux6s9hYiatSLJofwtMfpv0gaYiD
         dC3Ima4b1JzSpWjfzZNlxV100ueSsKWNnXkXx9d9UEeXJgDFVm/iOD4JqiNTUtD1vp2B
         IiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479416; x=1743084216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CtXUOiV6YbzdJsdrwscdlDgW4tNQasHXRzZgigycQQ=;
        b=gazmRrEBd5/TSzjl95g4K85gAPYy5XOVdzQrHABIdcnAeCpfA/wboFv428/bteDdkJ
         jCQEYppjxpq3YQssv4kow/vwFgMIvPO5CEv+QINidrKKAMnrA6flkj7S76mZZs28c5Cu
         ATnsb7AhiwKu/rG8QXORXEv4rJD+TmVBZc3MnNvRiJkp7N23QhE+FKDSYlMU6Ehk9B29
         eqkf77Z3wL64wsJ5MdqBEz8E6bXB+KGNT+ByXBZ6lRCHtCMdla5+QGf+SA/Cv9w/xYS3
         Eq7iMl8hQWmamh9ZuTFfRT6RCLUqzQ1bOgDCQNrAfAg3rrQRysZ+sPtN6rnJpw3v6fZ+
         cMTA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Oatkmh65LN/7V6oiLiXbGOZCoPrab1jyuzt8VohL8XdQfc8UFbD9Zrvxz3GAiKklZZ997T/ZC6a34A21@vger.kernel.org, AJvYcCVCfDuvUSD/Liq7uncchCW/TTsHbR6o4LA/wVlnvgrp2/eR2M/Ym6ohh/g7et0SwbOtt3UfbCWh/CpsLlUz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CTFHZ5o8TC/oqm3nP8IPQ4NHksvuJlB4q6WD+gkluB442zl2
	xRXjY62ISFsUNUaUGw/Jkl5kahrIz4DMwutrIuKIBXlqZX9fbed3Dj7L5jVvEepjoMiFcWYNAgi
	VYaS1tYoEGg3OaZ2eW+00RmU3df8=
X-Gm-Gg: ASbGncs/HI//mttfo9Q74wdxvqQXWEdjs8xB4n8xS18q3T399sv/QVbpqqGLFvops1X
	X1pqC9EB2/wO8InnvSPCRel45jdAqyLce54UbJ9XgP9tkKb670/ES5fKivWHNV75e666Mlmi8V4
	zd4LXysnhmFbJ8ZOM7TTapXNsWfA==
X-Google-Smtp-Source: AGHT+IGALGMMu/YsqXe9xpFG1Zvsg+H81RlB3W+6FQpYQ+mku3Is44qbw54dvJZeoZYVIfpMg1lheo128uDYemPpZsg=
X-Received: by 2002:a05:6402:51d4:b0:5e0:8c55:501 with SMTP id
 4fb4d7f45d1cf-5eb80cddff8mr6754185a12.7.1742479415865; Thu, 20 Mar 2025
 07:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320104922.1925198-1-mjguzik@gmail.com> <20250320-befund-wegnehmen-048d8b9cd252@brauner>
In-Reply-To: <20250320-befund-wegnehmen-048d8b9cd252@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Mar 2025 15:03:24 +0100
X-Gm-Features: AQ5f1JqJ7R3DUhsz9KRRtGc6eQ78lXIxPUtWVUrtvfctVT0DbH7Gz3NwTZ5hUzY
Message-ID: <CAGudoHFpfJ_m3HTJntxKt-ZF2x1eQ4A4Pjjp6trf6Y5fnY6rhQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: sort out stale commentary about races between fd
 alloc and dup2()
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:58=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 11:49:22AM +0100, Mateusz Guzik wrote:
> > Userspace may be trying to dup2() over a fd which is allocated but not
> > yet populated.
> >
> > Commentary about it is split in 2 parts (and both warrant changes):
> >
> > 1. in dup2()
> >
> > It claims the issue is only relevant for shared descriptor tables which
> > is of no concern for POSIX (but then is POSIX of concern to anyone
> > today?), which I presume predates standarized threading.
> >
> > The comment also mentions the following systems:
> > - OpenBSD installing a larval file -- they moved away from it, file is
> > installed late and EBUSY is returned on conflict
> > - FreeBSD returning EBADF -- reworked to install the file early like
> > OpenBSD used to do
> > - NetBSD "deadlocks in amusing ways" -- their solution looks
> > Solaris-inspired (not a compliment) and I would not be particularly
> > surprised if it indeed deadlocked, in amusing ways or otherwise
> >
> > I don't believe mentioning any of these adds anything and the statement
> > about the issue not being POSIX-relevant is outdated.
> >
> > dup2 description in POSIX still does not mention the problem.
> >
> > 2. above fd_install()
> >
> > <quote>
> > > We need to detect this and fput() the struct file we are about to
> > > overwrite in this case.
> > >
> > > It should never happen - if we allow dup2() do it, _really_ bad thing=
s
> > > will follow.
> > </quote>
> >
> > I have difficulty parsing it. The first sentence would suggest
> > fd_install() tries to detect and recover from the race (it does not),
> > the next one claims the race needs to be dealt with (it is, by dup2()).
> >
> > Given that fd_install() does not suffer the burden, this patch removes
> > the above and instead expands on the race in dup2() commentary.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > This contains the new commentary from:
> > https://lore.kernel.org/linux-fsdevel/20250320102637.1924183-1-mjguzik@=
gmail.com/T/#u
> >
> > and obsoletes this guy hanging out in -next:
> > ommit ec052fae814d467d6aa7e591b4b24531b87e65ec
>
> This is already upstream as of v6.14-rc1. So please make it a diff on
> top. ;)

oops.

Well in that case the previously sent variant applies:
https://lore.kernel.org/linux-fsdevel/20250320102637.1924183-1-mjguzik@gmai=
l.com/T/#u

Although I see the commit message would use a small tweak:
> Given that fd_install() does not suffer the burden, this patch removes
> the above and instead expands on the race in dup2() commentary instead.

s/ instead././

--=20
Mateusz Guzik <mjguzik gmail.com>

