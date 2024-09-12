Return-Path: <linux-fsdevel+bounces-29194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DF976F80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D19B22BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792A1BF7E3;
	Thu, 12 Sep 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av0l2ARc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB015098A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162032; cv=none; b=iErER9OLqtbO7UFbfg2nYdvglq7MdtrHLtB09RVaSu+Q/MchhVO1YgDjFOSlGj2+Uf/MPBfdlkkePWJ4CBH7rhqK7D3wwtg/p7A0XMgJUvEUlJpA+SeS30Rz0/lPOlk8KTkdc+m8BRBSvQXRInNlpl1UfU81qZfd9VtJzcLKu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162032; c=relaxed/simple;
	bh=uaL3ya7TTf4buk5jOwX+d7wY/SHzwvJuRMVzEEl+leQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRYpHjEXU8ypOC113WBS7ZsNSptq9oS2/0C8jXTHwL19gIvJICnGAHdIitZNAt7pp++CtJiK27JIXVloGtCaA0VdnjUkhu0A2qwPAVGdJQ2ahlkaVg1nPcQbleedmnFz5OwxaWG6D5vjt2F1n3PW4tO0z9xyVbyiXKQ7gq9RbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av0l2ARc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso1044286a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726162030; x=1726766830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytq7tkoDvqkkenLVDqM10lvENbdP1e6VeR6iCfYpPM0=;
        b=Av0l2ARcchG3PmDJxvedPTw8YiyQQeaNqNVDunEuw45duhn9WHY3xFNM9rLiVdNg5R
         7sQY1dCmUJf0cA5uXuwNWEKEFeq5ZH+0NGRfu2uHvXYFeJh+blOg8qU0B5Xc4uo43Asz
         ZgQ9lcBhw/EXFEC58nYb3RWegO1hHgP0WbJXT6J0OVXB6kczcI99po5EfGhkrV4h0zff
         KW6z3/gUvJ/GjyvhNzvZU26f3J9bAk/RtiBc9yPu/5oAKdUWCucMmlyPxghnW03rU4KL
         rYSdEcmTSVAtmqa35/52+oBnXFgH8V6tU5B3AjrzEwg524bJiYUbBwP1hxHvq/LtXoXp
         AN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162030; x=1726766830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytq7tkoDvqkkenLVDqM10lvENbdP1e6VeR6iCfYpPM0=;
        b=iL1BRvXrLhUKO+9j67eKxuRWgWnqAu2KFzUZ1B3F66kly1zMN08CmImJxSGeuAb6Mg
         wmj2VAb7Vmhr6G/EwVyI6PYj22p0m/qSVQFP7Sk6RtKCENVyVHzaDtibPtU53EahaGUl
         ArSOpB40GuGIZ5csVzK4h0qT3JJjXc/EryIKGQz9FlhiLjVj4ZqJYwcAFDJuZNWlzZu1
         ieFIU35aFdnMaZsgmtmxCpCgQ4b8ALWwVqHo06FSwCXy0kgFsbqFFJEFDWNOJYVqEGok
         ZgonOIeW/g+HzvzFT9in06NDCbhuucK/ojrKDrKhczn/h1pokjHbjvd8AcnVP4jhD9py
         /mxw==
X-Forwarded-Encrypted: i=1; AJvYcCXiXYNhveIqMFd4oYUKtzu2begb76ug1Gf0ZLOkzFu6/OfjTPjrwIt0vKhKozYjiDnvuvAFyp2NaHUl/HIS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Elv/JKWDjN90O8HG3rf0CYKEmSaMzkpxUsHh/ak6DLOSpv9D
	0DTH1s/GBI6yBHPpnw2yyrxeS9xnYJTEQJxMmAym3GyDZNMac/trcn6RAMwZD0NMNqKRRIUpbu1
	QfYkwAnqvXjkC74uBxcU43NO7eSE=
X-Google-Smtp-Source: AGHT+IH73Ai/V6sOtpMHSwI5ap9q6CWq4hXIOIvhA+gTd/nJkr4+m+kiAwnkxciP0HLby+W+wt7T0Vt2VbgnU2sZJFQ=
X-Received: by 2002:a17:90a:6b44:b0:2d8:9513:d889 with SMTP id
 98e67ed59e1d1-2db9ffbeecdmr3677743a91.14.1726162029799; Thu, 12 Sep 2024
 10:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm> <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
 <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm> <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
 <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
In-Reply-To: <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 12 Sep 2024 19:26:58 +0200
Message-ID: <CAOw_e7bR8xHbCrcv4x9P=XbE4nXcjiCkpiuxV4waS-i7QK=82A@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 3:06=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> > Do you know how old this behavior is? It would be great to not have to
> > write the kludge on my side, but if it has been out there for a long
> > time, I can't pretend the problem doesn't exist once it is fixed, as
> > it will still crop up if folks run things on older kernels. The
> > runtime for Go has been issuing SIGURG for preempted goroutines since
> > ~2020.
>
> Following git history, I think introduced here
>
> commit 1f60fbe7274918adb8db2f616e321890730ab7e3
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat Apr 23 22:50:07 2016 -0400
>
>     ext4: allow readdir()'s of large empty directories to be interrupted

Could the same behavior happen for readdir, or is only readdirplus affected=
?

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

