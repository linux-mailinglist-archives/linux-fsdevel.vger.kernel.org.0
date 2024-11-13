Return-Path: <linux-fsdevel+bounces-34618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0529C6C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EB8285AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C621FB8A5;
	Wed, 13 Nov 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD092vy2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBD1FB884;
	Wed, 13 Nov 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492752; cv=none; b=XDdMuLMwe0/ABCTs5/giYb4qQHqBwGF43rN1Rjeu3Cj1PuHMBe9WBDNhzD6piFcVu7pzE0tu+wv1ui0C6dC/XgIAm0Ul0uoE7JWDGiW5Jjz8Y2SqlPGPTeoV2AffWEYraPLu0g7enuBDZr0zcnaRial138EweNvYx6ToIL3sA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492752; c=relaxed/simple;
	bh=qg9MC38Uq422sUcpozDGSsIeP93v7MALrGfAFzBkAU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvMpa5mA0kZsjYOpxFi78eA4Z4tnm7pzDLomO+KW+nfd9a/2eLVbHAjtxfhHUWAFMrFyZ2kNX1zI3E72t3hNtGsEglZgREf+ceLNt8aC5JTlu+49qz4HiyWWlXtuYwJVM7zd8k8UIVgH4Krr/hQfF+YMOUgMRYJIvZ94zU2ZNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD092vy2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e333af0f528so6292519276.3;
        Wed, 13 Nov 2024 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731492749; x=1732097549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPvCe20vqjW/9L206QUZNSC4KV6t+3WGN84L/k9zELI=;
        b=jD092vy2JnItRdWWr3+05ve02vhftAd4/3AxI8FAzcTN4d/XZVbDyrosgHJoaTACGN
         hkoZBH0E00Dj3cp6XXp+vMSzI3rmlcOc07xhYJea4exK4F0oqORYSNhbaQsiAu4ENOUQ
         QJz2xNERGQsxwPj4twfSTwUucB6tk57x2SPWbhp1iR+s+MGAo3SLj1qsnDD+XlL5cG5g
         vsJ/iLR6db2KZMHzRvd3bwzmv26rSESxZKVH0KokL3OpIPTeRPcz866hLN27GhscoOTi
         HAh+hJ4eUvz6GI11BM+fX20eg0kEAGNv88xAczbOoKMZtBOy2ksnBeIyesxkJQKNOssA
         Klkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492749; x=1732097549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPvCe20vqjW/9L206QUZNSC4KV6t+3WGN84L/k9zELI=;
        b=u6EVf4G+e7XFdUGFu3j03hmcRyonxfLjUNw/86py2XdVzgyQlMXGR0hJihpnh8cqYQ
         sk0MlPLiECeSSvVe1oON+y1VfpIOQKJ/j3GsNmS2wanT0JoTyld0cG4csLpR1CWgRwOC
         tKJIAdrmYujswdMP3vzrmQmEzrxNVifc8QH6aau6Sm/tw1isek+lmXkJ1qjobnvp+YR9
         DQBhqqN18EfUjms4wa+aH3YkqFFaQWoBa2ZOOZbIv3a2jwpLtnzjO+gShOC+sNh73RDd
         3Tup+hhUezbL8l+QlgEKgHId+2Mk0JU8jDoW9oGhvZWC+K7De021EZs3Zuw4zsCElYup
         HAPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7YU1IuidmGLv1B+fGi8+rLUrmOhUNNO8wWYcpWd03R6ORxTspErH68yjqGNrNEw85ZiGdZOD3PKplaPV8OA==@vger.kernel.org, AJvYcCUoTRsI6n8rohO/NZMApzYq+p5cH9oq9Jlx5UUEKSM0ZcqjzgxV3f/KSj89S6Q3lzMEY6bRv7pYqa+o@vger.kernel.org, AJvYcCV/zrlDZWj5cAvzZqJ2fDigJny0TGGKFXQXiJmWTxTVdU0z7XjiVav/VH2nPb++oJH0+VvBjRLUNalwLA==@vger.kernel.org, AJvYcCVkHzX5yKq6XWjuaOU4aLVHw8XtoU0F4W34RdPgChK5XVcpHAIte/DE88629D5GzblUFadJ2S1N0nvGtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqkL8dE7r6YPVn5Oz7mJNqcYh0gsChPYo9D4IimD+jJj4WOCB
	WWFhAoKgsU7ffmAqtg79bRVLG6PqKUsxUWNfhTh97oJIkYdzkVl8FynZ+x1fU7g1owL1/vYZs45
	HiGNsmJGPL1hL5NCyCY0pQ0WnhdU=
X-Google-Smtp-Source: AGHT+IEgkmb6w5scqXSHLPCI0xBhSKcJTGnw+qItafp2JXkNGsrxVBU10S/9ET5y7RckoZUnXJjpqQFPE4B9dQa2O5g=
X-Received: by 2002:a05:6902:1083:b0:e30:dc66:5877 with SMTP id
 3f1490d57ef6-e35dc54772dmr5424408276.17.1731492749508; Wed, 13 Nov 2024
 02:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
 <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com> <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
In-Reply-To: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 11:12:18 +0100
Message-ID: <CAOQ4uxjJL_ZbJt4LnRcZWXfvgVahSeUeAKa9OSru=egcPv6aDA@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:58=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 15:41, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > You wrote it should be called "in the open path" - that is ambiguous.
> > pre-content hook must be called without sb_writers held, so current
> > (in linux-next) location of fsnotify_open_perm() is not good in case of
> > O_CREATE flag, so I am not sure where a good location is.
> > Easier is to drop this patch.
>
> Dropping that patch obviously removes my objection.
>
> But since none of the whole "return errors" is valid with a truncate
> or a new file creation anyway, isn't the whole thing kind of moot?
>

Not moot. It is needed for the case that open with O_CREAT
finds an existing file and that file needs to be filled on open
and anyway do_open() is also taking sb_writers for O_RDWR
and O_WRONLY (not 100% sure why) not only for O_CREAT.

Essentially, this means that the legacy FAN_OPEN_PERM event
is not safe to be used by HSM, to fill file content on open.
and while I can document that fact all over the internet, that won't
stop people from using FAN_OPEN_PERM to implement a simple
HSM.

This is (the only) reason that I wanted to have a noticeable new event
at open time that is documented as safe for use by HSM and inviting
HSM developers to use the correct event.

Very possible that this is not a good enough reason.

> I guess do_open() could do it, but only inside a
>
>         if (!error && !do_truncate && !(file->f_mode & FMODE_CREATED))
>                 error =3D fsnotify_opened_old(file);
>
> kind of thing. With a big comment about how this is a pre-read hook,
> and not relevant for a new file or a truncate event since then it's
> always empty anyway.

Right. That would be good for what I wanted to achieve.

>
> But hey, if you don't absolutely need it in the first place, not
> having it is *MUCH* preferable.
>
> It sounds like the whole point was to catch reads - not opens. So then
> you should catch it at read() time, not at open() time.

Yeh, for sure.

Will drop this patch.

Thanks,
Amir.

