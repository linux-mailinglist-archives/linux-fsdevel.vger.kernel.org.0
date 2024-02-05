Return-Path: <linux-fsdevel+bounces-10254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21A84972F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16731B28FB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870D134DB;
	Mon,  5 Feb 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As80OIQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F7134AD;
	Mon,  5 Feb 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127229; cv=none; b=aFL29Qj85SH/yrhqoTRVk+UUrJGorbUQTaxxc0F/jGMqqftT7QmqF7lFY/5U+ScB37JksVk9bnxjomJ4j7oTRfr4tGsZJAKjCH7S3eJjuubO4FAbMAZYLlugMzDaUfQLNGTBJ0qXNO6/3XAh+A/pJA+BpHOJXzYLfgpHYgZTF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127229; c=relaxed/simple;
	bh=ZNaxtENYjMmhsQjQ16yP45HhTKLvYqXbULXrFuJiDWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUnaWM87sN//0wZ0ZxTWVI1Bd2VbwD6ygsLmpxFDxJ1Ce9Rg6WYR9KEo9/aijz9djSLpDX4aLPB0iO7Ag1VxfnYZX3KnBQMJyuMuq8Fbk0ffWuRyaSzRQ2INmNBE8sVZWjHLGV6sv0TJM3ISILxLSTFzpQX+qz+grF5d7xFvxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As80OIQ2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0600551e8so49510871fa.0;
        Mon, 05 Feb 2024 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127225; x=1707732025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VurLbfRnWv4YpVYRbQMAJnS5CPXbeMidumFgVRRN3xA=;
        b=As80OIQ29Juwj8SirjH4ZvwDDKAKDAY3jiLNlHYNvGV1E8fCys8wkc6gX4md/5qAsR
         rwR8LlVofj9pH08wcd/8ZlnoY+MkzRMz3Z6pF0uC6B4jhCIIHwsY6BWoW2wjJK6GM2nY
         744pIm+RI/vVAtcPA3bxHBejo+V/R2B20nQpPuB99FXr8fiFpLgMEVOESQNs133noYnX
         ODiuJka9MzmjrY/oUE6nmLbS6KznXgof2j19bupbJqkHbiUOybJ0H81Lkzx+1x86iReE
         hFvjr6inu/jocLyYieCHZAoq6+rWfs+1dIG5EGjikyLYd20BZdklIJGLENc8Rcz1PKPR
         x9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127225; x=1707732025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VurLbfRnWv4YpVYRbQMAJnS5CPXbeMidumFgVRRN3xA=;
        b=JMUCpwGREHQGHCV7EVQme4D0FTm+Y8+neOiPpiJrc1LogejNVbSkfH1Y0Jv8vefswt
         MFIO0+mLiUNISvCauUiYxtiDJsUkry5DPoQHAUL/8Rk86wd2TOjGK/eAN/z7fmiRRqz/
         Wsb4ncdxshD3qv5/97jqbxqEmvH66RT1PKbwncC0XtQUwVi63lioixG60kZDPE+zDf++
         lkp3QkvjqfWaC1l/8mDzlHE4G3b+k1M8spwV1cLPB+ba1ydeirSLou8cFe8Xn5Hl3SvV
         WHpd9ya28e27jXnXAPD5p+07rto81lCJIgroYCXY+kMkz6l3130EgGLw4oB8tiA3Rj7u
         hYsg==
X-Gm-Message-State: AOJu0Ywfvh9h7ZVXoVMhcvbDAGlr/ZRb8MRohTvj9QGfdm9t5dY8FI/J
	4fH1XpVLuN/tQvzdI1zkiBG6TbSC52Kfi1sVmo5z8NVOqGcQGpdo7qOp3jhFsBRssV+m8LjxegD
	rDMllLCbq/eNM1K7KCbftqZ9Umn4=
X-Google-Smtp-Source: AGHT+IHf8/XOSOt2uHkTkfcWX6Bmcswg59VYPoQLGzmClCSOGJbvoVaawsFDuBxZnqgL3HjY9VTEAQGeuGtuhT0JMIg=
X-Received: by 2002:a2e:855a:0:b0:2d0:ab64:a7f4 with SMTP id
 u26-20020a2e855a000000b002d0ab64a7f4mr1378976ljj.6.1707127224618; Mon, 05 Feb
 2024 02:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
 <20240127020833.487907-2-kent.overstreet@linux.dev> <20240202120357.tfjdri5rfd2onajl@quack3>
 <CA+icZUWdUUhWg_-0NvF+6L=EUhj7amv_7HRKHDPvrEBspwHC2Q@mail.gmail.com> <20240205095358.p322zf5u74fgczlo@quack3>
In-Reply-To: <20240205095358.p322zf5u74fgczlo@quack3>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 5 Feb 2024 10:59:47 +0100
Message-ID: <CA+icZUXdhRY-wRZCFWJA4ppz98Shjft_W9xDnvAHe0AZKH7zvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:54=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 02-02-24 13:25:20, Sedat Dilek wrote:
> > On Fri, Feb 2, 2024 at 1:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 26-01-24 21:08:28, Kent Overstreet wrote:
> > > > *_lock_nested() is fundamentally broken; lockdep needs to check loc=
k
> > > > ordering, but we cannot device a total ordering on an unbounded num=
ber
> > > > of elements with only a few subclasses.
> > > >
> > > > the replacement is to define lock ordering with a proper comparison
> > > > function.
> > > >
> > > > fs/pipe.c was already doing everything correctly otherwise, nothing
> > > > much changes here.
> > > >
> > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > >
> > > I had to digest for a while what this new lockdep lock ordering featu=
re is
> > > about. I have one pending question - what is the motivation of this
> > > conversion of pipe code? AFAIU we don't have any problems with lockde=
p
> > > annotations on pipe->mutex because there are always only two subclass=
es?
> > >
> > >                                                                 Honza
> >
> > Hi,
> >
> > "Numbers talk - Bullshit walks." (Linus Torvalds)
> >
> > In things of pipes - I normally benchmark like this (example):
> >
> > root# cat /dev/sdc | pipebench > /dev/null
> >
> > Do you have numbers for your patch-series?
>
> Sedat AFAIU this patch is not about performance at all but rather about
> lockdep instrumentation... But maybe I'm missing your point?
>

Sorry, I missed the point, Jan.

-Sedat-

