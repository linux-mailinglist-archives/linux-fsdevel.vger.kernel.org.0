Return-Path: <linux-fsdevel+bounces-63563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC9BC268E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 551E735062F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D92E9748;
	Tue,  7 Oct 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po8OZugi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04D2E8E05
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862353; cv=none; b=JH5hsplC99c+kQtLetQdGBoYWQS/eUhI/wp+YesIeMiVEpM3XbV3219Az0Gqgzvp4eU0vL0TPEtBp2OF/2uGfbpWEw63qNIKjl1WTSasyI3fEsWvF2NHWYhWqCusg8VQLndaAiMR8jgfHwcvKZMctTkgCODyJ+eS6CvU7EwtotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862353; c=relaxed/simple;
	bh=ATKQZCRMHg8Cf45pgKwHsOSu1jo4xiNtxORKdi1Fz+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGohnObyh1nrE/H5gyRbX9h1M4VwAs7mbtQwwNQw+pTxYwxU36Kl5XlD3KRu6DOTvMWhT/h+7e3iLJ+msfFWtK5TvSsokm8uT4CAtVEJrICd3E+ZipBmDXACwAFi/9NB1QUMG9cU56w85SZT4dufY3pLeu9ZvnRul9nesK5y9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po8OZugi; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-635380a4a67so7592771d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862351; x=1760467151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YIIkoab05zGu1Gpmvy2NKeRxtUOvWDZ01jDGCtGLzE=;
        b=Po8OZugipSUnuCun/IX/t9eVkLco5zJ01KLcdAlKBd2rYLfHLNJjXg9l4ZCNjeIK5K
         wXHqT4gOIlIoyvy+GdbGYpZYwvEf5PJ8kzcWuxEWwqZDx7kuPRhvEEQUiTOKbIaKUMir
         uEvOdPWIMXPb/ZCEk4pVSapYYbbqBT+9yYxzudi47KvYnt5bxQQussGdpzMfwm+TFp2i
         cHbvCrSGiCxv7DJ7aE7SwiJwhq6hQqbyqyEVW06tWCnL5cvXESDou5CVNoZOct7UXAjQ
         9gsQNJE/asVCdBCUToCQaDMh2aWdU0d36EGjyWt5qxK/dCQfdESghl55Wg6hoROf7F73
         eMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862351; x=1760467151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YIIkoab05zGu1Gpmvy2NKeRxtUOvWDZ01jDGCtGLzE=;
        b=Nen6WSlEE5MeRnRf/3JMl1k2iNG7AaXFaRdfeThw35xs4VVL1b5pJGe3UdcE0QiWvX
         90BF0N4CCC+uph+ELjxvRIMgwmNJDtS/q/ppF9c72uue8scSOoCufO6W13YzGO/8MI4s
         f6vQKj8wIN3CP99sxZVP8X9OoY5bUq7kN4sHmFjOKnaZguHk13I4GNntx39OiRGtdW/X
         sPsNKdU3A80sZyutTY0NE4wm7tOaCIImK2kj2LZBA180nzXDz/1bFw7oTuqVOcg0V4a5
         I/qRB6EDcUD2RiEtwo3zCrqvKBWDbrOyb42TjX0cd3izyOKHnnvoCpQ3AFvoVbqziny0
         CEQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLi5HeC3G8dXIPNJhpnOFFMTb0dqW5PtC8VpTJJEMW/YUvzMoHHxKXSR8vIDWf/aH778/21cYJ8MdFuDwc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1PIu9QbTmXmR5ALHjeI+jLtODqkgKET68e34BYwtTCc4QnS2
	rNGfjGJlRqZhQez6Flc7iyRwBdDqMRW5jxnev4fHaTkIk8bu8sZcXGUXtzIY2GSExIMP9D4ZGFs
	qeW6mul85G69JEQRDkbbTtdklwJyElf4=
X-Gm-Gg: ASbGnctHwd1kAzBHD+io9oGiKxhWN4ueJroO4KrwUZhv539FM0bGiPStf39Ng870rWW
	6aMxOFlnZ2NiidQyCrLmp9zzC2gcZnx3A+jRcXoXL3CVHBbPKvW2Yd//9OsTYtsUG2QdqSY8zST
	iWng9MUOCTbrElQtAAIvBCAtnmyUPAy/Rbe5rvie5B4w1W0/TwR6BHXVCRvA3Y1a4j43S4dz/Nx
	8k4ghSNR4JiiCFsqiyKXC5Rol2W1vLiZg85/f6YCJu7eKGrQfLtv70B9HHne76JIWKrhxKAP+8h
X-Google-Smtp-Source: AGHT+IG3BPQCGSTA8NQ8dSbRg8uEv/+AMQI1dltOu5JO/t01qZXT+LAFUov2PXREkPKz6oqukYZpf49R/2qfb0BCUIE=
X-Received: by 2002:a05:690e:6da:b0:636:d6b9:4c91 with SMTP id
 956f58d0204a3-63ccb854956mr599331d50.15.1759862350936; Tue, 07 Oct 2025
 11:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006103852.506614-1-luca.boccassi@gmail.com>
 <2hg43wshc3iklydtwx25ulqadzyuldkyi6wylgztzwendi5zhw@kw223cxay7qn>
 <CAMw=ZnR6QMNevxtxWysqi5UkDmbD68Ge=R5cVAxskqtmhb5m5A@mail.gmail.com>
 <bywtfrezkfevzz7y2ecq4w75nfjhz2qqu2cugwl3ml57jlom5k@b5bebz4f24sd>
 <CAMw=ZnSZmW=BFbLLSKsn7sze-FXZroQw6o4eJU9675VmGjzDRw@mail.gmail.com>
 <rleqiwn4mquteybmica3jwilel3mbmaww5p3wr7ju7tfj2d6wt@g6rliisekp2e>
 <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com>
 <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com> <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
 <2025-10-07-greater-dingy-vendetta-kennel-JrnGHl@cyphar.com>
In-Reply-To: <2025-10-07-greater-dingy-vendetta-kennel-JrnGHl@cyphar.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 7 Oct 2025 19:38:59 +0100
X-Gm-Features: AS18NWDnk2thca7COi9O2VMSio-Xfy8UHkLtLOM45h7ztdsuargrdw_VgA2_LfU
Message-ID: <CAMw=ZnSpgiCy0vB6BfwiZEjONNt6gNxnBtFRZ_4uMpH2ysZUUw@mail.gmail.com>
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 19:37, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > On Mon, 6 Oct 2025 at 14:41, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > >
> > > On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > > > On Mon, 6 Oct 2025 at 12:57, Alejandro Colomar <alx@kernel.org> wrote:
> > > > >
> > > > > Hi Luca,
> > > > >
> > > > > On Mon, Oct 06, 2025 at 12:46:41PM +0100, Luca Boccassi wrote:
> > > > > > > > > >  .TP
> > > > > > > > > > +.B EINVAL
> > > > > > > > > > +The source mount is already mounted somewhere else. Clone it via
> > > > > > > [...]
> > > > > > > > > > +.BR open_tree (2)
> > > > > > > > > > +with
> > > > > > > > > > +.B \%OPEN_TREE_CLONE
> > > > > > > > > > +and use that as the source instead (since Linux 6.15).
> > > > > > > > >
> > > > > > > > > The parenthetical in that position makes it unclear if you're saying
> > > > > > > > > that one should use open_tree(2) with OPEN_TREE_CLONE since Linux 6.15,
> > > > > > > > > or if you're saying that this error can happen since that version.
> > > > > > > > > Would you mind clarifying?  I think if you mean that the error can
> > > > > > > > > happen since Linux 6.15, we could make it part of the paragraph tag, as
> > > > > > > > > in unshare(2).
> > > > > > > >
> > > > > > > > I meant the former, the error is always there, but OPEN_TREE_CLONE can
> > > > > > > > be used since 6.15 to avoid it. Sent v2 with this and the other fix,
> > > > > > > > thanks for the prompt review.
> > > > > > >
> > > > > > > Hmmm, I see.  Why not use open_tree(2) and OPEN_TREE_CLONE before 6.15?
> > > > > > > The syscall and flag existed, AFAICS.  I think we should clarify --at
> > > > > > > least in the commit message--, why that version is important.
> > > > > >
> > > > > > It was just not supported at all, so it would still fail with EINVAL
> > > > > > before 6.15 even with the clone.
> > > > >
> > > > > Thanks!  What's the exact commit (or set of commits) that changed this?
> > > > > That would be useful for the commit message.
> > > > >
> > > > > > Would you like me to send a v3 or would you prefer to amend the commit
> > > > > > message yourself?
> > > > >
> > > > > I can amend myself.
> > > >
> > > > Sorry, I am not a kernel dev so I do not know where it was introduced
> > > > exactly, and quickly skimming the commits list doesn't immediately
> > > > reveal anything. I only know that by testing it, it works on 6.15 and
> > > > fails earlier.
> > >
> > > If I'm understanding the new error entry correctly, this might be commit
> > > c5c12f871a30 ("fs: create detached mounts from detached mounts"), but
> > > Christian can probably verify that.
> > >
> > > Just to double check that I understand this new error explanation -- the
> > > issue is that you had a file descriptor that you thought was a detached
> > > mount object but it was actually attached at some point, and the
> > > suggestion is to create a new detached bind-mount to use with
> > > move_mount(2)? Do you really get EINVAL in that case or does this move
> > > the mount?
> >
> > Almost - the use case is that I prep an image as a detached mount, and
> > then I want to apply it multiple times, without having to reopen it
> > again and again. If I just do 'move_mount()' multiple times, the
> > second one returns EINVAL. From 6.15, I can do open_tree with
> > OPEN_TREE_CLONE before applying with move_mount, and everything works.
>
> Before each move_mount(2) or just doing it once before all of them? My
> quick testing seems to indicate that it needs to be before each one.

Yep, a clone before each move is what I am doing, otherwise it doesn't work

