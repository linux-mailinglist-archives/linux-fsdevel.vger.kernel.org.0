Return-Path: <linux-fsdevel+bounces-41183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C42A2C199
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8953A46FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C581DE4C9;
	Fri,  7 Feb 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK9kloha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1302417ED;
	Fri,  7 Feb 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928058; cv=none; b=Zjhr6ZkOhRAppouoPZZvjvWTFtRNUBPTtu/BIuBQYkRFhoGRb0KT0fgqkP6eLYa0+GJ+VXkdQ1YlYXp6DV1xZyKEqiH87oIIHGIRZfgenrvyJTDUVReJ+RxdDoppWT9rUGbXWM9oMieGv7HGSwTifE45vV//0Qt4nkfCkx0xWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928058; c=relaxed/simple;
	bh=1wh2cpQUxPLEuY0IQg/F5m/jGKR7k88MMsXZiFFmCBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry2byU886Xpav6S7AKH25ohHPuh4YHZjqMxfSXtdiW0fxCo9vGayjrjLv18188GVG1ff8w6WAQZNX/9ceSYt33/fFTq+ezBegMFs175A96x9nrZHxfu7KYEcrEjAgFrzFMnpXYlmU1d6qysoCzp2NHHUcVzeVCn13fyBeTwlEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK9kloha; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dcd3454922so4062212a12.1;
        Fri, 07 Feb 2025 03:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928055; x=1739532855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wh2cpQUxPLEuY0IQg/F5m/jGKR7k88MMsXZiFFmCBM=;
        b=lK9klohaHZlwxpE4VavEtix3oVxbRRpg5zG12Ybf1/6YwbtQ2xmo3oCuu5v2xGtWD3
         79JI7B0RZcyXsQpQvGG1dPNNu68oXIPC0/H6OyrQ1pvowZA5vYJIzy8few7VRwQKxyda
         EyRdtiE/FNH/i3f+ftalyydPNpXMZRgUvPgUDh/LXpQJuMnja8MkOgsHBqdyEddJYvuJ
         pCgG6Pfs4FFSIFOvxHbU6l2nHUdBTetA/xdX/o2NP81om+E/Tm2rj9aPUizFX9TqdmzC
         n0ZxUe5Kja/i4TBadSYxXOqCH7R1ANCorD75p4b+0u3oUvztGk9jsEfDO/75fGmjAcG6
         4XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928055; x=1739532855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wh2cpQUxPLEuY0IQg/F5m/jGKR7k88MMsXZiFFmCBM=;
        b=FPbualtZHACwcvtsqZuUuEfgH/UexFm0WDbgK7nG9OlYlNndwr2TvYsPN8acsqKjsL
         3kmOVlhKyzPH+UijumAk+kWy1Dg6tLTSnyGAhCsdBmjsvzuxrgqGVpO559G+IOFo1Lmy
         iR9qiV1/c7KeVhDAqy7ocu1y7RIhJVZLRLfYjR+RGEd4NSaUvgWwUvzi57ciLPWRRGD4
         OX82K1lcTtLxRChVm5pwwQN9a9nRjZ+GMNC2Zwqe9m3Fy1hd8qLqdzSyYcGkJhIqNKlo
         0Nr3zGOeEBE8qvsbHF7eGISTKTDKoXZrN/2318zWuMLSW/RXfmpPQfwvom+gTAfz4Tkm
         KYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXrT0sdDpIJobLXdP0L35oKk+PeqOiBtix9RPp9o4b0GIEDEr68i9EReIrkMnFBG4ZrOKnSlVesSGbY+lw@vger.kernel.org, AJvYcCUZYzotP2H2Ksnvw/TG4cN7mcp/zOP7jfNadDuz50JZmKcZQPlZNP8YLW9rSft6tyKwAnUQzs8hGV/uDLMX@vger.kernel.org
X-Gm-Message-State: AOJu0YweeVPV4h1yAE1vVRHFsdHpNNWQSB1/XYAbHqB/kJvtwnKTHJ9D
	1Ogl8oNOxluhDeX+dxfUUqv9hjE25U+uFSkzl7j4zMTNYZdsYe1Y0IyOZ5knxnVLx8qWJ+6X9il
	v8kuGE6YU1BsqJN4FVZcyK4GhFbg=
X-Gm-Gg: ASbGncsCoJQIih4uVC0oBOdt634qGQD6mzVmMsnrgMhGXiQyYwJV3kv+WL1iK1ZsKz6
	+ZK78I+w3Tt3V4A////IAmVguz8fd3m5X8r2oTVRECAoRk5kNNwGNYUId/i7ygCLxfm0ONDYm
X-Google-Smtp-Source: AGHT+IHyRv3J+H1efaMv2+jprVJQ5kvQHBMSEBpkJMRhuptG38yMhxproOUF8W1NeehsICmuMFItcl1nZXdLw/P/+DA=
X-Received: by 2002:a05:6402:2189:b0:5dc:7fbe:72f2 with SMTP id
 4fb4d7f45d1cf-5de44fea964mr3336334a12.3.1738928054659; Fri, 07 Feb 2025
 03:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502051546.fca7cd-lkp@intel.com> <CAHk-=whSncSTE_Q0as-d989L_niJ6=ViwaDoOK6gTcWHNPkp7w@mail.gmail.com>
In-Reply-To: <CAHk-=whSncSTE_Q0as-d989L_niJ6=ViwaDoOK6gTcWHNPkp7w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Feb 2025 12:34:03 +0100
X-Gm-Features: AWEUYZlfBZ7ZGHwIFt2AGR4hspLGRP5IPR0R2ajHRmpRBd1zmnHtetwWqx-EEJU
Message-ID: <CAOQ4uxgC_Uaa2XA8vyuDvsio1ysr__9kF6RK3pKcD=Xa1ps8Mg@mail.gmail.com>
Subject: Re: [linus:master] [fsnotify] a94204f4d4: stress-ng.timerfd.ops_per_sec
 7.0% improvement
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:45=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 5 Feb 2025 at 00:09, kernel test robot <oliver.sang@intel.com> wr=
ote:
> >
> > kernel test robot noticed a 7.0% improvement of stress-ng.timerfd.ops_p=
er_sec on:
>
> I have no idea what the heck that benchmark does, but I am happy to
> see that this whole patch series did actually end up improving on the
> whole fsnotify cost that I was ranting about in the original
> submission.
>
> Obviously this load doesn't actually do the new pre-event hooks, so it
> seems to be all just about how fsnotify_file_area_perm() (or some
> other fsnotify hook in the normal read() path) now isn't the
> unconditional pig that it used to be.

Right.
We got this win by slightly modifying semantics of FAN_ACCESS_PERM
events, but I cannot imagine that anyone will care (famous last words).

It's all about the fact that
>
> I don't see how that would be worth 7%, but I'll happily take it.
>

Yeh, I was happy to see that as well :)

Thanks,
Amir.

